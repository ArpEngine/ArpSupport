package arp.task;

import arp.events.ArpProgressEvent;
import arp.events.ArpSignal;
import arp.events.IArpSignalOut;

class TaskRunner<T:ITask> {

	public var verbose:Bool = false;

	public var cpuTime:Float = 50;

	private var _beacon:IArpSignalOut<Float>;
	private var _liveTasks:Array<T>;
	private var _readyTasks:Array<T>;
	private var _waitingTasks:Array<T>;
	private var processedSomething:Bool = false;

	public var tasksProcessed(default, null):Int = 0;
	public var tasksTotal(default, null):Int = 0;
	public var tasksWaiting(default, null):Int = 0;

	public var isAutoStart(default, default):Bool = false;
	public var isRunning(default, null):Bool = false;
	public var isDeadlock(default, null):Bool = false;

	public var isActive(get, never):Bool;
	public function get_isActive():Bool {
		return this.tasksTotal != this.tasksProcessed;
	}

	public var isWaiting(get, never):Bool;
	public function get_isWaiting():Bool {
		return this.tasksWaiting > 0;
	}

	public var isCompleted(get, never):Bool;
	public function get_isCompleted():Bool {
		return !(this.isActive || this.isWaiting);
	}

	private var _onProgress:ArpSignal<ArpProgressEvent>;
	public var onProgress(get, never):IArpSignalOut<ArpProgressEvent>;
	inline private function get_onProgress():IArpSignalOut<ArpProgressEvent> return _onProgress;

	private var _onError:ArpSignal<Dynamic>;
	public var onError(get, never):IArpSignalOut<Dynamic>;
	inline private function get_onError():IArpSignalOut<Dynamic> return _onError;

	private var _onDeadlock:ArpSignal<Int>;
	public var onDeadlock(get, never):IArpSignalOut<Int>;
	inline private function get_onDeadlock():IArpSignalOut<Int> return _onDeadlock;

	private var _onComplete:ArpSignal<Int>;
	public var onComplete(get, never):IArpSignalOut<Int>;
	inline private function get_onComplete():IArpSignalOut<Int> return _onComplete;

	private var _onCompleteTask:ArpSignal<T>;
	public var onCompleteTask(get, never):IArpSignalOut<T>;
	inline private function get_onCompleteTask():IArpSignalOut<T> return _onCompleteTask;

	public function new(beacon:IArpSignalOut<Float> = null, isAutoStart:Bool = false) {
		this._beacon = beacon;
		this.isAutoStart = isAutoStart;

		this._liveTasks = [];
		this._readyTasks = [];
		this._waitingTasks = [];

		this._onProgress = new ArpSignal();
		this._onError = new ArpSignal();
		this._onDeadlock = new ArpSignal();
		this._onComplete = new ArpSignal();
		this._onCompleteTask = new ArpSignal();
	}

	public function start():Void {
		if (!this.isRunning) {
			if (this._beacon == null) this._beacon = TaskRunner.defaultBeacon;
			this._beacon.push(this.tick);
			this.isRunning = true;
		}
	}

	public function stop():Void {
		if (this.isRunning) {
			this._beacon.remove(this.tick);
			this.isRunning = false;
		}
	}

	/**
	 * Add a task to this task queue.
	 * @param task A task to execute.
	 */
	public function prepend(task:T):Void {
		this.isDeadlock = false;
		this.notify(task);
		this._liveTasks.push(task);
		this.tasksTotal++;
		if (this.isAutoStart) this.start();
	}

	/**
	 * Add a task to this task queue.
	 * @param task A task to execute.
	 */
	public function append(task:T):Void {
		this.isDeadlock = false;
		this.notify(task);
		this._liveTasks.unshift(task);
		this.tasksTotal++;
		if (this.isAutoStart) this.start();
	}

	/**
	 * Mark a task to hold this TaskRunner's completion, with its execution skipped until next notify() call.
	 * @param task A task to wait for notify(). This task may be either queued or not queued.
	 */
	public function wait(task:T):Void {
		if (this._waitingTasks.indexOf(task) < 0) {
			this._waitingTasks.push(task);
			this.tasksWaiting++;
		}
	}

	/**
	 * Unmarks a task marked by wait(), and resumes task execution if scheduled.
	 * @param task A task, which is wait()ing.
	 */
	public function notify(task:T):Void {
		if (this._waitingTasks.indexOf(task) >= 0) {
			this.isDeadlock = false;
			this._waitingTasks.remove(task);
			this.tasksWaiting--;
			this.processedSomething = true;
			if (this.isAutoStart) this.start();
		}
	}

	/**
	 * Cancel a task.
	 * @param task A task in this task queue to cancel.
	 * @return true if call succeeds.
	 */
	public function halt(task:T):Bool {
		var i:Int;
		i = this._liveTasks.indexOf(task);
		if (i >= 0) {
			this._liveTasks.splice(i, 1);
			return true;
		}
		i = this._readyTasks.indexOf(task);
		if (i >= 0) {
			this._readyTasks.splice(i, 1);
			return true;
		}
		return false;
	}

	private function triggerProgressEvent():Void {
		if (this._onProgress.willTrigger()) {
			this._onProgress.dispatch(new ArpProgressEvent(this.tasksProcessed, this.tasksTotal));
		}
	}

	public function tick(cpuLoad:Float):Void {
		// rotate anyway
		if (this._liveTasks.length == 0) {
			this._liveTasks = this._readyTasks;
			this._readyTasks = [];
		}
		var endTime:Float = Date.now().getTime() + this.cpuTime * cpuLoad;
		do {
			// step 1: consume live tasks
			var task:T = this._liveTasks.pop();
			if (task != null) {
				if (this._waitingTasks.indexOf(task) >= 0) {
					this._readyTasks.push(task);
					continue;
				}
				var status:TaskStatus;
				if (this._onError.willTrigger()) {
					status = task.run();
				} else {
					try {
						status = task.run();
					} catch (e:Dynamic) {
						status = TaskStatus.Error(e);
					}
				}
				switch (status) {
					case TaskStatus.Complete:
						this.tasksProcessed++;
						this.processedSomething = true;
						if (this._onCompleteTask.willTrigger()) this._onCompleteTask.dispatch(task);
					case TaskStatus.Progress:
						this.processedSomething = true;
						this._readyTasks.push(task);
					case TaskStatus.Stalled:
						this._readyTasks.push(task);
					case TaskStatus.Error(e):
						this._onError.dispatch(e);
				}
			}
			// step 2: check turnover
			if (this._liveTasks.length == 0) {
				if (this._readyTasks.length > 0) {
					// Check if anything has proceeded
					if (this.processedSomething) {
						// Rotate ready tasks and make them live again
						this._liveTasks = this._readyTasks;
						this._readyTasks = [];
						this.processedSomething = false;
					} else if (this.tasksWaiting > 0) {
						// we have some tasks waiting
						if (!this.verbose) this.triggerProgressEvent();
						this.stop();
						return;
					} else {
						// No work done, tasks depends each other, we can only halt now
						this.isDeadlock = true;
						if (!this._onDeadlock.willTrigger()) throw "TaskRunner.tick(): TaskRunner has encountered a deadlock";
						this._onDeadlock.dispatch(this.tasksTotal - this.tasksProcessed);
						//deadlock is fatal, so we must stop
						this.stop();
						return;
					}
				} else {
					if (this.tasksWaiting > 0) {
						if (!this.verbose) this.triggerProgressEvent();
						this.stop();
						return;
					} else {
						// No tasks, no ready tasks, done!
						this._onComplete.dispatch(0);
						this.stop();
						return;
					}
				}
			}
			if (this.verbose) this.triggerProgressEvent();
		} while (Date.now().getTime() < endTime);
		// Tasks seems to be over?
		if (!this.verbose) this.triggerProgressEvent();
	}

	public static var defaultBeacon:ArpSignal<Float> = new ArpSignal<Float>();
}
