# Building and packaging the code example:

Directory for jars:

`$ mkdir -p jars`

Making the clock.jar:

```
$ mkdir -p build/classes/com.lukasz.clock/
$ javac -d build/classes/com.lukasz.clock/ com.lukasz.clock/module-info.java com.lukasz.clock/com/lukasz/clock/SpeakingClock.java
$ jar -c -f jars/clock.jar -C build/classes/com.lukasz.clock/ .

```

Making the timeTeller.jar:

```
$ mkdir -p build/classes/com.lukasz.main
$ javac -d build/classes/com.lukasz.main/ --module-path=jars com.lukasz.main/module-info.java com.lukasz.main/com/lukasz/main/Main.java
$ jar -c -f jars/timeTeller.jar --main-class com.lukasz.main.Main -c build/classes/com.lukasz.main .

```

Running the jar:

```
$ cd jars
$ java -p . -m com.lukasz.main

```

