Link: https://archive.org/details/ucberkeley_webcast_Oy36XpGVyjA

---

"If we are dealing with some particular type of data, we want to think about it in terms of its *meaning*, not in terms of how it is represented in the computer."

That means, in this classes terms, to not use `butlast`, a function that takes a sentence for computing poker hand scores. Instead, wrap `butlast` in a new function, e.g. `rest-of-hand`.

*Selectors* and *Constructors* are in terms of *data types*.

- Selectors select one part of a multi-part datum (e.g. a pair)
- Constructors construct multi-part data in terms of a particular data type.

*Abstract Data Types* do not exist in the programming language (like lists or arrays), but only in the programmer's mind.

*Pairs* are the fundamental complex data type of Scheme and Lisp -- they are used to represent a lot of abstract data types.

The `cons`, `car`, and `cdr` as purely functional data blows my mind. I love it.

