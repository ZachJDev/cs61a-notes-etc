# Reading Four: 2 .1 & 2.2.1

Where Chapter 1 was about  proceduresm chaptter two will  be about complex data. The procedures we implemented before are sufficient for simple data, but most of the problems we'll face as programmers will contain complex data.

Thus we will focus on *compound data* in this chapter. 

We want compound data for the same reason we want compound procedures: to elevate the level at which we may reason about our programs, increase modularity  and enchance the expressive power of our language.

I really like this idea of thinking about languages and programming in terms of expression and expressing something.

"The general technique of isolating the parts of a program that deal with how data ojects are represented from the parts of a program that deal with how data objects are used is a powerful desiugn methodolgy called [[../Glossary | data abstraction]]"

programming languages should have glue for data.

we'll further blur the line between procedure and data as well in this chapter.

## 2.1: Introduction to Data Abstraction

 "[[../Glossary |Data Abstraction]] is a methodology that enables us to isolate how a compound data object is used from the details of how it is constructed from more primitive data objects."
 
 "...our programs should use data in such a way as to make no assumptions about the data  that are not strictly nescessary for performing the task at hand." 
 
 This all seems very OOP (in a basic way), at least in terms of the types of abstractions we'll be making.
 
a *pair* is our first compound data structure: constructed with `cons` it returns a data object that contains both of the two arguments. `car` returns the first value of the pair and `cdr` returns the second value.

pairs themselves can be a single item in a larger pair.

*List-structured data* are data objects built from pairs. And apparently all of the complex data types we'll be deigning are built from pairs.


### 2.1.2: Abstraction Barriers: 

"The underlying idea of data abstraction is to identify for each type of data object a basic set of perations in terms of which all manipulations of data objects of that type will be expressed, and then to use only those operations in manipulating the data."

In the rational numbers example, even though the `make-rat`, `denom`, and `numer` operations are little more than wrappers for built-in Scheme functions, the goal for well-abstracted data requires that we specify the operations in terms of the data we're using.  E.g, we could store different kinds of pairs (like of farm animals) with `make-rat` but if we did, that would be a bad program.

*Abstraction barriers* isolate different levels of the system -- e.g. seperating instances of rational numbers from `car` and `cdr`, even though they are essentially pairs. **The details of each level's implementation are irrelevant outside of the level itself.**

**But Why??**
-	programs with data abstraction are easier to maintain and modify.
-	programs are easier to reason about.

### 2.1.3: What is Meant by Data?

"We can think of data as defined by some collection of **selectors** and **constructors**, together with specified conditions that  these procedures must fulfill in order to be a valid representation"

abstract models in general define new data types in terms of previous data types (e.g. our rational numbers are defined in terms of integers )

**Constructors** build our new abstract datum, and **selectors** let us operate on specific parts of an already-constructed instance of that datum.

My mind is being blown by the `cons` definition -- it's return value is not any actual pieces of data but an interface with which to interact with an instance of a data object. The interface itself provides the methods to extract the primitive data from the pair. It's not how it's *actually* implemented, but it's a great challenge to try to wrap your head around it.

"The procedural representation ... is a perfectly adequate way to represent pairs, **since it fulfils the only conditions that pairs need to fulfill**"

This seems like such a powerful idea.

I'm in love with this book.

## 2.2 Hierachical Data and the Closure Property

*Closure Property:* An operation for combining data objects satisfies the closure property if the results of combining things with that operation can themselves be combined with the same operation. -- NOT closures in a functional / Environmental sense.

Closure is the key to creating heirarchical data structures.

### 2.2.1 Representing Sequences

a *sequence* is an ordered collection of data objects.

Scheme has a *list* constructor that constructs a chain of pairs  terminated by an end-of-list marker.