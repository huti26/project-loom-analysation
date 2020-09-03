# Benchmarks

Contains the code used for both benchmarks in this thesis.

# Footprint
Selfmade Echo-Server. Server & Responder are based on these two sources:

http://www.java2s.com/Code/Java/Network-Protocol/AverysimpleWebserverWhenitreceivesaHTTPrequestitsendstherequestbackasthereply.htm

https://dbs.cs.uni-duesseldorf.de/lehre/docs/java/javabuch/examples/EchoServer.java


Compile:

```javac Responder.java```

```javac EchoServerThread.java```

```javac EchoServerVThread.java```

Start one of the servers:

```java EchoServerThread``` 

or 

```java EchoServerVThread```


Optionally you may start a Java profiler now and select the previously started java process in order to monitor heap usage etc.

Now run the Shell script to start the requests:

```bash Mass_Request.sh 50 1000 t 100```

This will run 1000 requests in total with 50 concurrent requests at a time.

This process is then repeated 100 times.

The results will be saved to the folder ```50-1000-t```. The third argument ```t``` only changes the foldername. Call it ```vt``` if you run the script for virtual threads. 

Each run will be saved in a seperate file inside that folder. The run files are called ```run1.txt, run2.txt, ..., run100.txt```.

The total time for all requests per run is in line 16 of the run files.

A successful run has 43 lines. If ApacheBench thinks the values might not be reliable it will add some lines to the file mentioning that. If a run has less than 43 lines, it certainly was a failed one.

Running 1.000 requests with 100 concurrent connections 100 times is better than running 100.000 requests with 100 concurrent connections once because it stops ApacheBench from being a potential bottleneck. 

# JMH
Microbenchmarks by project Loom themselves. 

Run:

```
cd /JMH/microbenchmarks/loom
```

```
mvn clean install
```

```
java -jar target/benchmarks.jar -rf csv
```

One can ommit the -rf csv part, if one doesnt want to save the results as a csv.