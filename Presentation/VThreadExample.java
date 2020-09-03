Runnable printThread = () -> System.out.println(Thread.currentThread());

var kernelThreadFactory = Thread.builder().factory();
var virtualThreadFactory = Thread.builder().virtual().factory();

var kernelThread = kernelThreadFactory.newThread(printThread);
var virtualThread = virtualThreadFactory.newThread(printThread);

kernelThread.start();
virtualThread.start();