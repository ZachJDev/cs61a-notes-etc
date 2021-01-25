#lang simply-scheme

(define (cube a)
  (* a a a))

(define (square x)
  (* x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (accumulate combiner null-val term a next b)
  (if (< b a)
      null-val
      (combiner (term a) (accumulate combiner null-val term (next a) next b))))

(define (inc n) (+ n 1))
(define (decr n)(- n 1))
(define (identity x) x)

(define (prime? x) ; not a great prime finder, but I don't have a concept of lists in Scheme yet.
  (define (is-prime? n)
  (cond ((= n 1) #t)
        ((= 0 (modulo x n)) #f)
        (else (is-prime? (decr n)))))
  (if (or (= 1 x) (= 0 x))
      #f
  (is-prime? (decr x))))

(define (rel-prime? x y)
  (if (= 1 (gcd x y))
          #t
          #f))

(define tolerance 0.00001)

(define (close-enough? x y)
  (< (abs (- x y)) tolerance))

(define (average x y)
  (/ (+ x y) 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (old-sum-integers a b)
  (if (> a b)
      0
      (+ a (old-sum-integers (+ a 1) b))))
;(old-sum-integers 1 5) ; 15

(define (old-sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (old-sum-cubes (+ 1 a) b))))

;(old-sum-cubes 1 5) ; 225

(define (old-pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (old-pi-sum (+ a 4) b))))

;(old-pi-sum 1 5) ; .3619....

(define (sum-integers a b)
  (sum identity a inc b))
;(sum-integers 1 50)


(define (sum-cubes a b)
  (sum cube a inc b))
;(sum-cubes 1 10)

(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ a 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

;(pi-sum 1 1000)

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

;(integral cube 0 1 .00001)

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

;(simpson cube 0 1 10000) ; 0.250000...1

(define (acc-sum term a next b)
  (accumulate + 0 term a next b))

(define (acc-prod term a next b)
  (accumulate * 1 term a next b))

(define (factorial n)
  (acc-prod identity 1 inc n))

;(factorial 5) ; 120

(define (comp-pi n)
  (define (inc-2 x) (+ x 2))
  (define (mult-by-plus-2 x) (* x (+ x 2))) 
  (* 4 (/ (acc-prod mult-by-plus-2 2.0 inc-2 (- n 2))
          (acc-prod square 3.0 inc-2 n))))

;(comp-pi 150) ; 3.152...
      
(define (filtered-accumulate combiner null-val term a next b filter?)
  (if (< b a)
      null-val
        (combiner (if (filter? a)
                      (term a)
                      null-val)
                  (filtered-accumulate combiner null-val term (next a) next b filter?))))

(define (sum-prime-squares a b)
  (filtered-accumulate + 0 square a inc b prime?))

;(sum-prime-squares 0 5) ; 38
;(+ (square 2) (square 3) (square 5)) ; 38

(define (product-rel-primes-below y)
  (define (rel-prime-w-y? x)
    (rel-prime? x y)
    )
  (filtered-accumulate * 1 identity 1 inc y rel-prime-w-y?))

;(product-rel-primes-below 10) ; 189
;(* 9 7 3) ; 189

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                (search f midpoint pos-point))
                (else midpoint))))))


(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sign" a b)))))

; (half-interval-method sin 2.0 4.0) ; 3.141113...

; (half-interval-method (lambda (x) (- (cube x) (* 2 x) 3)) 1.0 2.0) ; 1.893...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; (fixed-point cos 1.0) ; 0.73908....
; (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0) ; 1.258...

; (define (sqrt x)
; (fixed-point (lambda (y) (average y (/ x y))) 1.0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (average-damp f)
  (lambda (x) (average x (f x))))

; ((average-damp square) 10) ; 55

; ((average-damp square) 5)

; average-damp returns the function described by
; (lambda (x) (average x (f x))) with f equal to 
; square (or f in the definition). above, 5 is 
; passed into the function where we get (average 5 (square 5))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (different-deriv g x)
  (/ (- (g (+ x dx)) (g x)) dx))

; (different-deriv cube 5)
; ((deriv cube) 3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (newton-sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))

; (newton-sqrt 100)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (new-sqrt x)
  (fixed-point-of-transform (lambda (y) (- (square y) x))
                           newton-transform
                           1.0))
; (new-sqrt 10000)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (cubic a b c)
  (lambda (x)
    (+ (cube x) (* (square x) a) (* b x) c)))

; (newtons-method (cubic 5 9 20) 1.0)

; ((cubic 5 9 20) -4)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (double f)
  (lambda (x)
    (f (f x))))

;(((double (double double)) inc) 5) ; 21 -- 2^(2^2) = 16 times
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (compose f g)
  (lambda (x)
    (f (g x))))

((compose square inc) 6)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (repeated f x)
  (define (comp g)
    (lambda (x) (f (g x))))
  (define (repeat t x)
    (if (= x 1)
        (lambda (y) (t y))
        (repeat (comp t) (decr x))))
  (repeat f x))

((repeated inc 3) 5)
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (iterative-improve good-enough? improve)
  (lambda (x)
    (define next-guess (improve x))
    (if (good-enough? x next-guess)
        x
        ((iterative-improve good-enough? improve) next-guess))))

(define (sqrt3 x)
  ((iterative-improve close-enough? (lambda (y) (average y (/ x y))))x))

(sqrt3 9.0)

(define (it-imp-fixed-point f first-guess)
  ((iterative-improve close-enough? f) first-guess))

(define (sqrt x)
  (it-imp-fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))
 (sqrt 25) ; 5.0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (every f sent)
  (if (< (count sent) 1)
      '()
      (se (f (first sent)) (every f (bf sent)))))

(every first '(hello everyone loves love orgres))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(every (lambda (letter) (word letter letter)) 'purple) ; '(pp uu rr pp ll ee)
(every (lambda (number) (if (even? number) (word number number) number))
       '(781 5 76 909 24)) ; '(781 5 7676 909 2424)
(keep even? '(781 5 76 909 24)) ; '(76 24)
(keep (lambda (letter) (member? letter 'aeiou)) 'bookkeeper) ; 'ooeee
(keep (lambda (letter) (member? letter 'eaiou)) 'syzzygy) ; ""
;(keep (lambda (letter) (member? letter 'eaiou)) '(purple syzygy)) ; error
(keep (lambda (wd) (member? 'e wd)) '(purple syzygy)) ; '(purple)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (sumsq a b)
  (define (square x) (* x x))
  (+ (square a) (square b)))

(sumsq 3 4) ; 25

((lambda (a b)
   ((lambda (square)
      (+ (square a) (square b)))
    (lambda (x) (* x x))))
   3 4)

(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

(fact 5) ; 120


((lambda (n)
   (
    (lambda (fact)
      (fact fact n))
    (lambda (ft k)
      (if (= k 1)
          1
          (* k (ft ft (- k 1)))))))
 5)