package arp.task;

enum TaskStatus {
	Stalled;
	Progress;
	Complete;
	Error(e:Dynamic);
}
