# Java 9th's Jigsaw project

(this post is part of our mini Java 9 series - check out other posts!)

Modularity is quite a known concept in software engineering. Writing unique units encapsulating functionality and exposing it through various interfaces is something that we try to archieve on many fields nowadays. This attitude has number of advantages. We:
 	
 - make our design cleaner and easier to understand and maintain
 - choose what tools to use in a more concious way
 - make our application smaller because we avoid using unnecessary things
 - make it safer because it does not contain things potentially dangerous to our application
 - possibly make it more scalable
 - possibly improve performance

Java creators certainly know that. That's why there's [Jigsaw](http://openjdk.java.net/projects/jigsaw/). It is a huge project started at sun way back in August 2008. Delayed due to technical and non-technical reasons (eg. integrating Sun into Oracle) it's finally there to make Java modular. Encompassing 6 JEPs, it will be a part of Java 9 release which is planned to happen in about 100 days. 

## Breaking The Monolith

As we take a look at Java Platform and the JDK we are probably not satisfied about it's structure. This is not a suprise - over the years Java was designed without mechanisms that enforced modular design. The spirit of always being backwards compatible didn't help either. Every release has just made the it bigger and more tangled. No wonder that the primary goal of the Jigsaw project was to cut the Java Platform and the JDK to smaller and more organized modules. The uncontrolled growth simply had to be stopped.

This job was a tough one. After the decision about defering Project Jigsaw from Java 8 to Java 9 in 2012, Mark Reinhold explained why it was so hard:

>There are two main reasons. The first is that the JDK code base is deeply interconnected at both the API and the implementation levels, having been built over many years primarily in the style of a monolithic software system. We’ve spent considerable effort eliminating or at least simplifying as many API and implementation dependences as possible, so that both the Platform and its implementations can be presented as a coherent set of interdependent modules, but some particularly thorny cases remain.

Now it seems that they succeded in doing the job. It resulted in creating 91 modules. They're located in your `$JAVA_HOME/jmods` directory:

```
~$ ls -l $JAVA_HOME/jmods
```


The modules are fully independent and isolated from each other. Each one has it's interface that is exposed for other modules. Developers can now compile, package, deploy and execute applications that consists only of the selected modules and nothing else. This is a big thing.

## Getting modular

If Java itself is modular and there are means to make our own code modular then we should do it right now. Let's explain the basics on a simple Java application made of two modules:
	
1. com.timeteller.clock: a module which contains SpeakingClock - a class for printing current time to the stdout.
2. com.timeteller.main: a module utilizing the functionality offered by com.timeteller.clock module.

The code, building and running instructions are located here (TODO: LINK TO THE CODE)

Project structure:

![project structure](ProjectStructure.png "Demo project structure")


Classes Main.java and SpeakingClock.java are almost irrelevant regarding to modules. Jigsaw does not make them any different from previous java implementations. All we have to know that the _main_ method uses the SpeakingClock's method: 

```
public static void main (String[] args) {
    SpeakingClock clock = new SpeakingClock();
    clock.tellTheTime(); // displays the time to stdout.
}
```

The most important part is hidden in the module descriptor files (module-info.java). They contain all the module metadata. The're plain java files, like this:

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

This is a trivial module configuration but you can learn the following from it:

- module descriptor files by convention are placed in the root folder of the module	 
- every module has a unique name
- module descriptors define what packages are _exported_ from the module and what modules do they _require_

The last bullet is strictly about the isolation I mentioned earlier. If you do not export your packages, they will remain hidden in your module, unavailable to other modules. Analogically with requiring. If something is exported that does not mean that you can use it everywhere. You have to explicitly require it (except with the java.base module - for convinience every module automatically requires it). If you won't do the above, the application won't even compile.

Last thing to notice here is that _public_ changes it's meaning in java 9. Before modules, it meant that a public code is visible everywhere. Now it means that the code is not visible unless the package that has it is exported.
	
## Tailor-made runtime (size)

Jigsaw is not about modules only. 


(show how to use jlink to create your own runtime)
- large jars, large rt.jar


There is also no need for rt.jar (java runtime jar) prepared for us - we create the runtime by ourselves by linking modules. 


(show module creation etc)

## 4. Increased security and performance
(try to invoke code on your java app)


## 6. Caveats??
 - show how to check if apis are inaccessible?
 - how to find out if i'm ready for migration?
 







