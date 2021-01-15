#lang simply-scheme
10                     ; 10
(+ 5 3 4)              ; 12
( - 9 1)               ; 8
(/ 6 2)                ; 3
(+ (* 2 4) ( - 4 6))    ; 6
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


( / (+ 5 4 (- 2 ( - 3 ( + 6 (/ 4 5)))))
	(* 3 ( - 6 2) ( - 2 7)))

(define (sum-square-greatest-two x y z)
		 (cond  ((and (>= x z) (>= y z)) (+ (* y y) (* x x)))
                        ((and (>= y x) (>= z x)) (+ (* y y) (* z z)))
                        ((and (>= z y) (>= x y)) (+ (* z z) (* x x)))))

(sum-square-greatest-two 1 1 1)

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))


(define (square x) (* x x))

(define x 9999)

(define (paper y) (+ x x))
(paper 3)

(define (average x y)
  (/ (+ x y ) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (improve-cube guess x)
  (/ (+(/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) .001))

(define (new-good-enough? guess prev-guess x)
  (< (abs (- guess prev-guess))(/ x 100000000000000000000000000000000000))
)

(define (sqrt-iter guess x prev-guess)
  (cond ((new-good-enough? guess prev-guess x) 
      guess)
      (else(sqrt-iter (improve guess x) x guess))))


(define (cbrt-iter guess x prev-guess)
  (if (new-good-enough? guess prev-guess x)
       guess
       (cbrt-iter (improve-cube guess x) x guess)))

(cbrt-iter 1.0 125 0)



;(new-if (> 10 1) 10 (p))