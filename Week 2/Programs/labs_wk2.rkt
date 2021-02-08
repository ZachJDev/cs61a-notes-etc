#lang simply-scheme
; Labs, Week 2

;;;;;;;;;;;; Exercise 1

(lambda (x) (+ 3 x)) ; Prediction: <prodcedure>
((lambda (x) (+ x 3) )7) ; 10

; Lambda can be thought of as "the function of..." e.g.
; "The function of x that returns x + 3"

(define (make-adder num)
  (lambda (x) (+ x num))) ; no return

((make-adder 3) 7) ; 10

(define plus3 (make-adder 3))

(plus3 7) ; 10

(define (square x) (* x x))

(square 5) ; 25

(define sq (lambda (x) (* x x))) ; I'm 90% sure this is the same as the above, just without the syntactic sugar

(sq 5) ; 25

(define (try f) (f 3 5))

(try +) ; 8

(try word) ; 35

;;;;;;;;;;;; Exercise 2

(define (substitute sent old new)
  (cond ((null? sent) '())
    ((equal? (first sent) old)
         (sentence new (substitute (bf sent) old new)))
    (else (sentence (first sent) (substitute (bf sent) old new)))))

(substitute '(she loves you yeah yeah yeah) 'yeah 'maybe) ; '(she loves you maybe maybe maybe)


;;;;;;;;;;;; Exercise 3

; ((g) 1)
; I think g has zero arguments, but it returns a function that takes 1 argument. so 'procedure'.
; What g could be:
; (define (g)
;  (lambda (x) 3))

;;;;;;;;;;;; Exercise 4

; f - a variable value is whatever the variable is;
;(define f 3)
; f ; 3


; (f) - a function that takes no arguements and returns a constant value
;(define f (lambda () 3))
; (f) ; 3

; (f 3) - a function that takes one value
;(define f (lambda (x) (+ x  3)))
;(f 3) ; 6

; ((f)) a function that returns a function that returns a constant:
;(define f
;  (lambda ()
;    (lambda () 3)))
; ((f)) ; 3

; (((f)) 3) a function that returns a function that returns a function:
;(define f
; (lambda ()
;    (lambda ()
;      (lambda (x) (+ x 3)))))
; (((f)) 3) ; 6

;;;;;;;;;;;; Exercise 5
(define (1+ x)
  (+ 1 x))

(define (t f)
  (lambda (x) (f (f (f x)))))

((t 1+) 0) ; 3
((t (t 1+)) 0) ; 9
(((t t) 1+) 0) ; 9 xxx wrong xxx correct: 27

;;;;;;;;;;;; Exercise 6
(define (s x)
  (+ 1 x))

((t s) 0) ; 3
((lambda (x)
  (+ 1 (+ 1 (+ 1 x))))0)
((t (t s)) 0 ) ; 9
(((t t) s) 0) ; 27

;;;;;;;;;;;; Exercise 7

(define (make-tester word)
  (lambda (x) (if (equal? word x)
                  #t
                  #f)))

((make-tester 'hal) 'hal) ; #t





