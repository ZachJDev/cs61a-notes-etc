Link: https://archive.org/details/ucberkeley_webcast_ZvH3wF2qg7Q

---

The big idea this week is "Procedures as data", i.e. [[../Glossary | Higher-Order Procedures]]

we could theoretically write a language where the only built-in functionality is the ability to create a function and the ability to call functions.

We can generalize patterns using variable numbers (like when computing various areas which all contain some *x* multipled by the square of a radius or side).

We can also generalize a pattern in which a function varies (like when computing sums of various functions, sums of squares or sums of cubes, e.g.)

Higher-order functions can also be *unnamed functions*, using **lambda** in Scheme. I don't think you can return a named function in scheme, and I can't think of why you'd want to...

When did JS get first-class functions? it doesn't seem like they were part of it during this lecture (2011), but "callback hell" certainly existed long before then, right?

First-class data types:
-	can be named by variables
-	can be passed as arguments to procedures
-	can be returned as the result of procedures
-	can be included in agregates (i.e. data structures)
-	(sometimes included in the def) can be anonymous

numbers as first class in every language. Character strings are in *most*. Functions are first-class in nearly none (except Lisp and Python) (and at this time -- I *think* more langauges have them than just those named in this lecture).

#### Why is there more than one programing language?
Different languages have different design principles.
One of Scheme's major principles is "Everything First-Class" -there's one exception, appparently.
Logo (which we'll see later) was designed for children -- it's design principles make it look different from Scheme, even though it is closely related.

One of the main justifictions that I had come up with for JS closrues in the past was that they provide a way to track internal state. This reading and these lectures have made me realize that they are also a powerful tool for other kinds of abstraction. 
(A little googling openned by eyes to how closures are implemented with JS (wrt to the hidden Environment variable), and they are certainly more complicated than I realized.)

Abstractions like we're seeing in this week's lectures let us work with and combine functions without needing to discuss the domain and range (input and output) of the more-specific functions.

first-class functions means that we can create whatever kind of control mechanisms that we want...