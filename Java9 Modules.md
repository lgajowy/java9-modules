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

Now it seems that they succeded in doing the job. It resulted in creating 91 modules. They're located in your $JAVA_HOME/jmods directory:

```
~$ ls -l $JAVA_HOME/jmods
```

The modules are fully independent and isolated from each other. Each one has it's interface that is exposed for other modules. Developers can now compile, package, deploy and execute applications that consists only of the selected modules and nothing else. This is a big thing. There is also no need for rt.jar (java runtime jar) prepared for us - we create the runtime by ourselves by linking modules. Let's see how can we do this and what do we gain by that.

## Getting modular

If Java itself is modular and there are means to make our own code modular then we should do it right now. Let's explain the basics on a simple java application:

- java.base is allways there
- module has a name
- module tells what it provides (exports)
	If you do not export stuff, it's gonna be UNAVAILABLE. 


- module tells what it needs (requires)
	If something is exported that does not mean that you can use it. You have to require it.




```


javac -d mods/com.lukasz.clock com.lukasz.clock/com/lukasz/clock/SpeakingClock.java 

```




- what structure has java right now? 
- what structure will it have after splitting
- lack of clarity on dependencies
- public is too open
## 2. Tailor-made runtime (size)
(show how to use jlink to create your own runtime)
- large jars, large rt.jar


(show module creation etc)

## 4. Increased security and performance
(try to invoke code on your java app)

## 5. Jar hell solutions
Do i want to talk about it??

## 6. Caveats??
 - show how to check if apis are inaccessible?
 - how to find out if i'm ready for migration?
 







