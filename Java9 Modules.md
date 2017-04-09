# Java 9th's Jigsaw project

(this post is part of our mini Java 9 series - check out other posts!)

Modularity is a known concept in software engineering. Writing unique units encapsulating functionality and exposing it through various interfaces is something that we try to archieve on many other fields in software engineering. This attitude has number of advantages. We:
 	
 - make our design cleaner and easier to understand and maintain
 - choose what tools to use in a more concious way
 - make our application smaller because we avoid using unnecessary things
 - make it safer because it does not contain things potentially dangerous to our application
 - possibly make it more scalable
 - possibly improve performance

Java creators certainly know that. That's why there's [Jigsaw](http://openjdk.java.net/projects/jigsaw/). It is a huge project started at sun way back in August 2008. Delayed due to technical and non-technical reasons (eg. integrating Sun into Oracle) it's finally there to make Java modular. Encompassing 6 JEPs, it will be a part of Java 9 release which is planned to happen in about 100 days. Let's take a peek at what it brings: 



## 1. Writing modular code


Before java 9 there was no simple way to modularize the code we wrote. Of course one could adhere to good practices to organize it well but there was nothing that enforced modularity during all the program phases: compilation, packaging, deployment and execution. 


For me, the easiest way to learn something is to see it in action... (I jedziesz z modułami na początek)

## 2. Breaking The Monolith

As we take a look at Java Platform and the JDK we see monolithic, unorganized and tangled structure. This is not a suprise - over the years Java was not designed with modularity in mind. Every release has just made the monolith bigger. No wonder that the primary goal of the Jigsaw project was to cut the Java Platform and the JDK to smaller and more organized modules. The uncontrolled growth simply had to be stopped.

This job was a tough one. After the decision about defering Project Jigsaw from Java 8 to Java 9 in 2012, Mark Reinhold explained why it was so hard:


>There are two main reasons. The first is that the JDK code base is deeply interconnected at both the API and the implementation levels, having been built over many years primarily in the style of a monolithic software system. We’ve spent considerable effort eliminating or at least simplifying as many API and implementation dependences as possible, so that both the Platform and its implementations can be presented as a coherent set of interdependent modules, but some particularly thorny cases remain.


Now it seems that they succeded in doing the job. It resulted in creating 91 modules (as for the day of writing). They're all located in your $JAVA_HOME/jmods directory:

```
~$ ls -l $JAVA_HOME/jmods
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
 







