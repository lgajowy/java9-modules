#!/bin/bash

rm -r build jars

mkdir -p jars

mkdir -p build/classes/com.lukasz.clock/
javac -d build/classes/com.lukasz.clock/ com.lukasz.clock/module-info.java com.lukasz.clock/com/lukasz/clock/SpeakingClock.java
jar -c -f jars/clock.jar -C build/classes/com.lukasz.clock/ .

mkdir -p build/classes/com.lukasz.main
javac -d build/classes/com.lukasz.main/ --module-path=jars com.lukasz.main/module-info.java com.lukasz.main/com/lukasz/main/Main.java
jar -c -f jars/timeTeller.jar --main-class com.lukasz.main.Main -C build/classes/com.lukasz.main .
