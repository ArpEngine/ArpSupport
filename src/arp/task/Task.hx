package arp.task;

class Task implements ITask {
	public function new(run:Void->TaskStatus) this._run = run;
	private dynamic function _run():TaskStatus return TaskStatus.Complete;
	inline public function run():TaskStatus return this._run();
}
