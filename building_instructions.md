# Building and packaging the code example:

Directory for jars:

`$ mkdir -p jars`

Making the clock.jar:

```
$ mkdir -p build/classes/com.timeteller.clock/
$ javac -d build/classes/com.timeteller.clock/ com.timeteller.clock/module-info.java com.timeteller.clock/com/timeteller/clock/SpeakingClock.java
$ jar -c -f jars/clock.jar -C build/classes/com.timeteller.clock/ .

```

Making the timeTeller.jar:

```timeteller
$ mkdir -p build/classes/com.timeteller.main
$ javac -d build/classes/com.timeteller.main/ --module-path=jars com.timeteller.main/module-info.java com.timeteller.main/com/timeteller/main/Main.java
$ jar -c -f jars/timeTeller.jar --main-class com.timeteller.main.Main -c build/classes/com.timeteller.main .

```

Running the jar:

```
$ java -p jars -m com.timeteller.main

```

