 # Reading One: Section 1.1
 
 ## 1: Building Abstractions with Procedures
 - *Computational Process* -- an abstract being that inhabits computers. They manipulate other abstract things called *data*. "The Evolution of a process is directed by a pattern of rules called a *program*"'.
 - spiritual discussion of processes. Programmer cum conjurer 
 - "Real-world programming requires care, expertise, and wisdom."
 -  good programs are modular programs
 -  The [TYCS page](https://www.teachyourselfcs.com) says that this book has the potential to radically change the way you understand programs. I think that all of this talk of sorcery is part of that.
 - LISP "possesses unique features that make it an excellent medium for studying programming constructs and data structures" -- hopefully I can pick those out.
	 - Its ability to handle procedures as data. AND IT'S FUN

### 1.1 Elements of Programming
-	a strong langauge provides a strong *framework* "within which we organize our ideas about processes".
-	[[../../Programming Langauges]] -- "...when we describe a language, we should pay particular attention to the means that the language provides for combining simple ideas to make more complex ideas."
	-	Every powerful language has three things that help accomplish that:
		-	**primitive expressions** which represent the simplist entities the language is concered with,
		-	**means of combination** by which compound elements are built from simpler ones, and
		-	**means of abstraction** by which compound elements can be name and manipulated as units. (e.g. variables, complex data structures, the ability to act on complex data structures with functions)

-	**Procedures** and **Data** -- data = stuff we want to manipulate, procedures = descriptions of the rules for manipulating data.
-	as an aside, Humans are amazing at flipping between different types of understanding -- see footnote 4. whereaswe can treat 3, 3.0, 3/1, etc., as all the 'same thing', computers don't really have that luxury. I think a main idea behind that is that the numbers as we interact with them behind a computer screen are not the same numbers we interact with when doing math -- If numbers themselves are abstractions, numbers-on-screen are an abstraction of an abstraction

#### 1.1.1 Expressions
-	numbers are primitive expressions
-	and simple, arithmetic operators (like + or -) are primitive procedures.
-	the construction `(+ 3 2)` is a *combination*: the left-most thing (in this case a `+`) is the *operator* and what follows are the *operands*. :The value of a combination is obtained by applying the procedures specified by the operator to the *arguments* that are the values of the operands.
-	prefix notation means no confusion for the interpreter.

#### 1.1.2: Naming and the Environment
-	in Scheme, variables are declared with `define`: `(define size 2)`.
-	define is Scheme's simplest method of abstraction.
-	Scheme stores symbol-value combinations in memory in what is called the *environment*.

#### 1.1.3: Evaluating Combinations
-	To evaluate a procedure:
		1. Evaluate the subexpressions of a combination
		2. Apply the procedure (i.e. the left-most subexpresion, i.e. the operator) to the arguments (i.e. the values of the other subexpressions).
-	As we can see, the above steps are recursive: "it includes, as one of its own steps, the need to invoke the rule itself."
-	looking at the tree in fig. 1.1, it is clear that the terminal leaves are primitive expressions. And the braching paths are the combinations of expressions.
-	This kind of 'drawing up' of values is known as *Tree Accumulation*.
-	The *environment* determines the meaning of the symbols in expressions.
-	Note that the operation `define` does not fit in the above procedure -- in the expression `(define size 2)`, `define` is not applied to both of those values. Infact, we can't apply step 2 to `size`, because it is totally meaningless until the oepration completes.
-	NOTE that `define` expressions are not combinations. Exceptions to general evaluation rules are called *special forms*.
-	The term 'syntactic sugar' was coined by Peter Landin

#### 1.1.4: Compound Procedures
-	as laid out above, Lisp has:
	-	**Primitive Expressions** in numbers and arithmetic operations,
	-	**means of combination** in nested combinations, and
	-	 a limited **means of abstraction** in definitions that associate names with values
-	**Procedure Definitions** -- a powerful abstraction technique by which a compound operation can be given a name.
-	consider a small example: `(define (square x) (* x x))`. Here we are both naming (as `square`) and describing a procedure, multiplying a thing by itself.
	-	the general form of a procedure definition is:
		-	`(define (<name> <formal parameters>) <body>)`.
			-	In a way, this is not tooo much different from simply naming a variable. In fact, I bet that we'll learn later that they are pretty much the same.
		- *formal parameters* are "the names used within the body of the procedure to refer to the corresponding arguments of the procedure".
		- the *body* is "an expression that will yield the value of the preocedure application when the formal paramters are replaced by the actual arguments to which the procedure is applied."
		- Side effects seem challening in this set up.

#### 1.1.5: The Substitution Model for Procedure Application
-	the first paragraph, read: evaluating expressions that `define` compound procedures is nearly the same as evaluating expressions that `define` primitive procedures.
-	To apply a compound procedure to arguments, evaluate the body of the procedure (which was defined with the procedure) with each of the formal parameters replaced by the corresponding argument.
-	 this model is called the *substitution model*, but it 
		1. Is not nescessarily how the interpreter actually works
		2. We will build an interpreter in chapter 5, and the substitution model is simply a basic mental-model for begining to think about interpreters. This model will brak down in chapter 3 with **mutable data**.

**Applicative vs. normal order**
-	in the interpreter model in 1.1.3, we evaluate **all** subexpressions when we get to them. Alternatively, we could not evaluate an expression until we need it for a compuation. This model would "first substitute operand expressions for parameters until it obtained an expression involving only primitive operators, and would then perform the evaluation".
		-	e.g `(square (+ 5 1))` would evaluate first to `(* (+ 5 1) (+ 5 1))` in this model, vs to `(* 6 6)` in the original model.
		-	This 'fully expand and then reduce' model is known as *normal-order evaluation*. the original method is known as *applicative-order evaluation*
		-	All procedures where the substitution model is valid will produce the same value for both methods of evaluation.

#### 1.1.6: Conditional Expressions and Predicates
-	Lisp introduces a new special form for *case analysis* (that is, conditional expressions): `cond`
				-	(I'm just now realizing that 'special forms' are just 'keywords '.)
-	consider:
	``` Scheme
	(define (abs x)
	  (cond (( > x 0) x)
	        (( = x 0) 0)
			(( < x 0) (- x))))
	```
	The general form of a conditional expression:
	``` Scheme
	(cond (<p1> < e1>)
		  (<p2> <ex>)
		  ...
		  (<pn> <en>))
	```
-	Conditionals are evaluated as follows:
	1. the predicate `<p1>` is evaluated first. If the value is false, then `<p2>` is evaluated, and the next after that, if `<p2>` is false.
	2. Once the interpreter evalues a predicate expression as true, then it will return the consequent expression (`<e>`) of that clause. 
	3. If nothing is true, then the whole cond expression is undefined.
-	the keyword `else` can be used in place of a predicate expression in a cond, and that will always evaluate as true. It must always come last.
-	If there are precisely two cases in the case analysis, then we can use the special form `if`: `(if <prediacate> <consequent> <alternative>)`
-	a minor difference -- in `cond`, the consequent `<e>` may be a sequence of expressions, with the final being returned, while in `if`, the predicate and conseqiuent must be single expressions.
-	there are the primitive predicates such as` < = >` and `<= >=`, as well as logical composition operations, like `and or not`

#### 1.1.7: Example: Square Roots by Newton's Method
-	declarative- vs imperative-knowledge: knowing the properties of something vs knowing how to do/make something.

#### 1.1.8 Procedures as Black-Box Abstractions
-	our square root function is naturally a collection of sub-problems.
-	And we don't need to worry about the implementation details of a lower-level abstraction. e.g. when writing the `good-enough?` procedure, we don't concern ourselves with how `square` works, only that it returns the square of a number.
-	Therefore, `square` is not quite a procedure, but a *procedural abstraction*.
-	a procedure definition should suppress detail.
-	**bound variables** are the variables in procedure that reflect the formal parameters. **Free variables** are the variables that are not part of the formal parameters. 
-	bound variables in a procedure definition have the procedure body as their scope.
-	Scheme allows us to define procedures and variables inside of other procedures.
-	*Lexical scoping* dictates that free variables in a procedure are taken to refer to bindings made by the enclosing procedural definitions.

#### Exercise 1.1 100%
```Scheme
10                     ; 10
(+ 5 3 4)              ; 12
( - 9 1)               ; 8
(/ 6 2)                ; 3
(+ (* 2 4) ( - 4 6))   ; 6
(define a 3)           ; 
(define b ( + a 1))    ;
(+ a b ( * a b))       ; 19 ( 3 + 4 + 12)
(= a b)                ; #f

(if (and ( > b a) ( < b (* a b)))
	b
	a)                 ; 4

(cond ((= a 4) 6)
	  ((= b 4) (+ 6 7 a))
	  (else 25))       ; 16
	  
(+ 2 (if (> b a) b a)) ; 6

(* (cond((> a b) a)
		((< a b) b)
		(else -1))
		(+ a 1))       ; 16
```

#### Exercise 1.2
``` Scheme
( / (+ 5 4 (- 2 ( - 3 ( + 6 (/ 4 5)))))
	(* 3 ( - 6 2) ( - 2 7)))
```

#### Exercise 1.3
``` Scheme
(define (sum-square-greatest-two x y z)
		 (cond  ((and (>= x z) (>= y z)) (+ (* y y) (* x x)))
                        ((and (>= y x) (>= z x)) (+ (* y y) (* z z)))
                        ((and (>= z y) (>= x y)) (+ (* z z) (* x x)))))
```

#### Exercise 1.4

in this expression, we check if b is greater than 0. if it is, we return the `+` operand, if not, the `-`. The left-most operator is a compound expression used to determine the correct operand to use.

#### Exercise 1.5

``` Scheme

(define (p) (p))
(define (text x y)
   (if (= x 0)
        0
		y))
		
(tesst 0 (p))
```

If Ben is using an applicative-order interpreter, He'll probably just see `0` because `(p)` never has a chance to be evaluated in `if`.

I was wrong -- it doesn't return anything. Changing `p` in the call to `test` will make it run normally. It doesn't just return nothing --- it hangs! which I didn't notice at first.
This makes much more sense, and it's just stuck in a loop with `p`.

-	the top `define` is a procedure definition.
-	`p` is a prodcedure who's body just evaluates the procedure's definition?

I think in normal order evaluation, we'd see it just return `0`.

SOOOO -- in applicative order, it get's stuck in the line `(test 0 (p))` because it wants to determine the value of `(p)` before it calls `test`. In normal-order, I don't think `(p)` would ever get evaluated because it's value is never needed for a procedure.

#### Exercise 1.6
-	What happens: the call stack keeps increasing in size. The program hangs. we run out of memory.
-	Explain: something with the recursion. My thinking, though I can't find it in writing in the book that this is what happens, is that cond will evaluate the consequent before deciding whether to return it. But that seems like poor design and I don't think that's the case.
- I figured it out -- because `new-if` isn't a special form, it evalutes all sub-expressions, including the expression with recursion. which means it will evaluate all of the expressions in that recursive call, including the one with recursion.
- replacing the `if` in the `sqrt-iter` procedure with `cond` and `else` evaluates the same as with `if`, so the problem isn't with `cond` but calling a recursive function in a non-special-form procedure.

#### Exercise 1.7
- the answer in general is that it's too precise for large numbers and not precise enough for small numbers.
-  for small numbers, the procedure won't get much smaller than .01, and for large numbers the procedure will run for a very long time without returning an answer -- it will never be precise enuogh.
-  I can't help but feel like I'm not actually answering the question. But I did reimplement `good-enough` to work better with large and small numbers.

#### Exercise 1.8
- Implemented


