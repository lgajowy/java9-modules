# Java 9th's Module System

(this post is part of our mini Java 9 series - check out other posts!)

Modularity is quite a known concept in software engineering. Writing unique units encapsulating functionality and exposing it through various interfaces is something we try to archieve on many fields nowadays. This attitude has number of advantages. We:
 	
 - make our design cleaner and easier to maintain
 - choose what tools to use in a more concious way
 - make our application smaller because we avoid using unnecessary things
 - make it safer because it does not contain things potentially dangerous to our application
 - possibly make it more scalable and improve performance

Java creators certainly know that. That's why there's [Jigsaw](http://openjdk.java.net/projects/jigsaw/). It is a huge project started at Sun way back in August 2008. Delayed due to technical and non-technical reasons (eg. integrating Sun into Oracle) it's finally there to make Java modular. Encompassing 6 JEPs, it will be a part of Java 9 release which is planned to happen in about 100 days. 

## Breaking The Monolith

As we take a look at Java Platform and the JDK we are probably not satisfied about it's structure. This is not a suprise - over the years Java was designed without mechanisms that enforced modular design. The spirit of always being backwards compatible didn't help either. Every release has just made the it bigger and more tangled. No wonder the primary goal of the Jigsaw project was to cut the Java Platform and the JDK into smaller and more organized modules.

This job was a tough one. After the decision about defering Project Jigsaw from Java 8 to Java 9 in 2012, Mark Reinhold explained why it was so hard:

>There are two main reasons. The first is that the JDK code base is deeply interconnected at both the API and the implementation levels, having been built over many years primarily in the style of a monolithic software system. We’ve spent considerable effort eliminating or at least simplifying as many API and implementation dependences as possible, so that both the Platform and its implementations can be presented as a coherent set of interdependent modules, but some particularly thorny cases remain.

(CZY MAM DOSTARCZYĆ LINK DO CYTATU?)

Now it seems that they succeded in doing the job. It resulted in creating 91 modules. They're located in your `$JAVA_HOME/jmods` directory:

```
~$ ls -l $JAVA_HOME/jmods
```


The modules are fully independent and isolated from each other. Each one has it's interface that is exposed to other modules. They depend on each other by using the interfaces. Developers can now compile, package, deploy and execute applications that consist only of the selected modules and nothing else. This is a big thing.

## Getting modular

There are means to make our own code modular. Let's explain the basics on a simple Java application made of two modules:
	
1. com.timeteller.clock: a module which contains SpeakingClock - a class for printing current time to the stdout.
2. com.timeteller.main: a module utilizing the functionality offered by com.timeteller.clock module.

The code, building and running instructions are located here (TODO: LINK DO REPOZYTORIUM Z KODEM - GDZIE MAM WYSTAWIĆ TEN KOD?)

The overall project structure looks like this: 

```
$ tree
.
├── com.timeteller.clock
│   ├── com
│   │   └── timeteller
│   │       └── clock
│   │           └── SpeakingClock.java
│   └── module-info.java
├── com.timeteller.main
│   ├── com
│   │   └── timeteller
│   │       └── main
│   │           └── Main.java
│   └── module-info.java
└── rebuild.sh

8 directories, 5 files
```

Classes Main.java and SpeakingClock.java are almost irrelevant regarding to modules. Jigsaw does not make them any different from previous java implementations. All we have to know that the _main()_ method uses the SpeakingClock's method: 

```
public static void main (String[] args) {
    SpeakingClock clock = new SpeakingClock();
    clock.tellTheTime(); // displays the time to stdout.
}
```

The most important part is hidden in the module descriptor files _(module-info.java)_. They contain all the module metadata. They're .java files but a little different, like this:

```
module com.timeteller.clock {
    exports com.timeteller.clock;
}

```
or this:

```
module com.timeteller.main {
    requires com.timeteller.clock;
}

```

It is a trivial module configuration but you can learn the following from it:

- module descriptor files by convention are placed in the root folder of the module	 
- every module has a unique name
- module descriptors define what packages are _exported_ from the module and what modules do they _require_

The last bullet is strictly about the isolation I mentioned earlier. If you do not export your packages, they will remain hidden in your module, unavailable to other modules. Analogically with requiring. If something is exported that does not mean that you can use it everywhere. You have to explicitly require it (except with the java.base module - for convinience every module automatically requires it). If you won't do the above, the application won't even compile.

Let's notice that _public_ keyword changes it's meaning in java 9. Before modules, it meant that a public code is visible everywhere. Now it means that the code is not visible unless the package is exported. It's a good thing - this gives the possibility for hiding internal APIs so that no other module could use it somewhere else. 
	

## Building the timeteller app
	
Let's take a look at module compilation:

```
$ mkdir -p jars

$ mkdir -p build/classes/com.timeteller.clock
$ javac -d build/classes/com.timeteller.clock/ com.timeteller.clock/module-info.java com.timeteller.clock/com/timeteller/clock/SpeakingClock.java
$ jar -c -f jars/clock.jar -C build/classes/com.timeteller.clock/ .

$ mkdir -p build/classes/com.timeteller.main
$ javac -d build/classes/com.timeteller.main/ --module-path=jars com.timeteller.main/module-info.java com.timeteller.main/com/timeteller/main/Main.java
$ jar -c -f jars/timeTeller.jar --main-class com.timeteller.main.Main -C build/classes/com.timeteller.main .


```

The module path is a place where the java compiler looks for modules. To let it know about the modules we must place them on it. It's a concept simillar to classpath but for modules. When we build the `com.timeteller.main` module we put a jar with `com.timeteller.clock` on the modulepath. Otherwise it does not find the necessary code and results in a compilation error:

```
$ javac -d build/classes/com.timeteller.main/  com.timeteller.main/module-info.java com.timeteller.main/com/timeteller/main/Main.java
com.timeteller.main/module-info.java:2: error: module not found: com.timeteller.clock
  requires com.timeteller.clock;
                         ^
1 error
```

Last thing to consider here is the fact that the JARs we created here are modular. Modular JAR files are just like the regular JARs except that they include module-info.class file (compiled module descriptor). This way they can be put either on modulepath or classpath.

## Tailor-made runtime

Project Jigsaw will equip Java 9 in many more useful things. Among them is [The Java Linker](http://openjdk.java.net/jeps/282) tool which can be used to link a set of modules with their dependencies and create a custom run-time image. The image does not contain anything that our application doesn't need. This has two serious advantages:

- the size of the application decreases
- the security of our aplication increases

This is how it can be done (based on the example code). Below we specify the modulepath, the modules we want to pick and the output directory for the runtime:

```
jlink --module-path $JAVA_HOME/jmods:mlib:jars  --add-modules com.timeteller.main --output timeteller-runtime
```

Calling the above creates `timeteller-runtime`. For our (very basic) example it is super small (272 Bytes) and is sufficient to run the timeteller application, like this:

```
$ timeteller-runtime/bin/java  --module-path jars/ -m com.timeteller.main
Sun Apr 09 18:31:16 CEST 2017

```

We can check the modules included in the image the following way:

```
$ timeteller-runtime/bin/java --list-modules
com.timeteller.clock
com.timeteller.main
java.base@9-ea
```

## Summary


 - show how to check if apis are inaccessible?
 - how to find out if i'm ready for migration?
 







