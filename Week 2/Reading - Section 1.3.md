# Reading Two: Section 1.3

## 1.3: Formulating Abstractions with Higher-Order Procedures

-	[[cs61a/Glossary | Procedure:]] "An abstraction that describes compound operatios on numbes independent of the particular numbers"
-	[[cs61a/Glossary | Higher-Order Procedures:]] Procedures that manipulate procedures.
	-	Do they manipulate procedures themselves, or manipulate the ouput of a given procedure?
	
### 1.3.1 Procuedres as Arguments

-	sigma notation (used for summations of serieses). Easily reproduced in Scheme:

```Scheme
(define (<name> a b)
	(if (> a b)
	0
	(+ (<term> a) (<name> (<next> a) b)))
```
-	With the idea of higher-order functions, we can easily define a procedure to express sums by slotting formal parameters into the above template:
```Scheme
(define (sum term a next b)
	(if (> a b)
	0
	(+ (term a)
		(sum term (next a) b))))
```

### 1.3.2 Constructing Procedures using `Lambda`

- `lambda` is a keyword analogous to saying 'the procedure that...'
	- essentially anonymous functions in JS, and I think Python also uses `lamda`
-	using `lamda` lets us get away with specifying functions without needing to explicitly define them. This cuts out a lot of extraneous, one-off definitions (like we find in the exercies below) which keeps our environment cleaner.
-	usage: `(lamda (<formal params>) <body>)`
-	comes from Lisp, which took the idea of lambda from Alonzo Church's lambda calculus, which he developed to study functions and their applications.
-	the related keyword `let` allows us to define local variables (i.e. variables that we won't access outside of some function).
-	the variables described by `let` are only available in the body of the `let`  expression, as seen below.
-	usage:
 ```Scheme
 (let ((<var1> <expr1>)
 	   (<var2> <expr2>)
	   ...
	   (<varN> <exprN>)
	   <body>)
 ```
	 
### 1.3.3: Procedures as General Methods
- Like the `sum` and `integral` procedures above, we explore two more examples as procedures as generalized methods in this section.

### 1.3.4: Procedures as Returned Values
-	the ability to return procedures from procedures. Think JS closures (?). This ability gives programming languages even more expressive power.
-	*compound procedures* allow us to express 'general methods of computing as explicit elements in our programming language'. And *higher-order procedures* allow us to 'manipulate these general methods to create further abstractions'.
-	[[cs61a/Glossary | First-Class Functions:]] ...
	-	can be named by variables
	-	may be passed as arguments as procedures
	-	may be returned as the result of a procedure
	-	may be included in data structures.

## Exercises
### 1.29:
uses the `sum` function from above and `odd?` and `even?` from simply-scheme
```Scheme
(define (simpsum f a n)
  (define (simp-func x)
    (* (cond ((or (= x 0) (= x n)) 1.0)
           ((odd? x) 4.0)
           ((even? x) 2.0))
        (f x)))
  (sum simp-func 0 inc n))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (comp-y x) (f (+ a (* x h))))
    (* (/ h 3) (simpsum comp-y a n)))

(simpson cube 0 1 10000) ; 0.250000...1
```

### 1.32:
Solved this before 1.31 because I had solved the accumulator problem and didn't bother to go back and solve for a less useful `product` function.
```Scheme
(define (accumulate combiner null-val term a next b)
  (if (< b a)
      null-val
      (combiner (term a) (accumulate combiner null-val term (next a) next b))))


(define (acc-sum term a next b)
  (accumulate + 0 term a next b))

(define (acc-prod term a next b)
  (accumulate * 1 term a next b))
```

### 1.31:

```Scheme
(define (factorial n)
  (acc-prod identity 1 inc n))

(factorial 5) ; 120

(define (comp-pi n)
  (define (inc-2 x) (+ x 2))
  (define (mult-by-plus-2 x) (* x (+ x 2))) 
  (* 4 (/ (acc-prod mult-by-plus-2 2.0 inc-2 (- n 2))
          (acc-prod square 3.0 inc-2 n))))

(comp-pi 150) ; 3.152...
```

### 1.33:
pre:
```Scheme
(define (filtered-accumulate combiner null-val term a next b filter?)
  (if (< b a)
      null-val
        (combiner (if (filter? a)
                      (term a)
                      null-val)
                  (filtered-accumulate combiner null-val term (next a) 
				  next b filter?))))
```
a:
```Scheme
(define (prime? x) ; not a great prime finder, but I don't have a concept of lists in Scheme yet.
  (define (is-prime? n)
  (cond ((= n 1) #t)
        ((= 0 (modulo x n)) #f)
        (else (is-prime? (decr n)))))
  (if (or (= 1 x) (= 0 x))
      #f
  (is-prime? (decr x))))

(define (sum-prime-squares a b)
  (filtered-accumulate + 0 square a inc b prime?))

(sum-prime-squares 0 5) ; 38
(+ (square 2) (square 3) (square 5)) ; 38

```
b:
```Scheme
(define (rel-prime? x y)
  (if (= 1 (gcd x y))
          #t
          #f))

(define (product-rel-primes-below y)
  (define (rel-prime-w-y? x)
    (rel-prime? x y)
    )
  (filtered-accumulate * 1 identity 1 inc y rel-prime-w-y?))

(product-rel-primes-below 10) ; 189
(* 9 7 3) ; 189
```
### 1.40
```Scheme
(define (cubic a b c)
  (lambda (x)
    (+ (cube x) (* (square x) a) (* b x) c)))

(newtons-method (cubic 5 9 20) 1.0) ; -3.9999

((cubic 5 9 20) -4) ; 0
```