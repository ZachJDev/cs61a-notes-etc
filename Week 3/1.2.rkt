#lang simply-scheme


(require racket/trace)
; Recursive Fib. An example of Tree Recursion
(define (rec-fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+
               (rec-fib (- n 1))
               (rec-fib (- n 2))))))
; (rec-fib 13)

; Iterative Fib

(define (it-fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b n)
  (if (= 0 n)
      b
      (fib-iter (+ a b) a (- n 1))))

; (it-fib 13)

; Count Change

(define (count-change amount)
  (se (2cc amount 0) (cc amount 0)))

(define (cc amount kinds-of-coins)
  (cond (( = amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (2cc amount kinds-of-coins)
  (cond 
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (( = amount 0) 1)
        (else (+ (2cc amount
                     (- kinds-of-coins 1))
                 (2cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))
; (trace cc)
;(trace 2cc)

; (count-change 0)

;(define (new-count-change num)
;  (new-cc 0 0 num 5))

;(define (new-cc total start amount kinds-of-coins)
 ; (cond ((= start amount)
  ;       total
   ;      )
    ;    ((or (< amount 0) (= kinds-of-coins 0)) 0)
     ;   (else (+ 



; Homework #2

(define (is-factor? x y)
  (if (= 0 (remainder y x) )
      #t
      #f))

(define (sum-if low high pred?)
  (cond ((= low high) 0)
           ((pred? low high) (+ low (sum-if (+ 1 low) high pred?)))
           (else (sum-if (+ 1 low) high pred?))))

(define (next-perf num)
  (if (= num (sum-if 1 num is-factor?))
      num
      (next-perf (+ 1 num))))

 (next-perf 29) ; 496

; Exponentiation

(define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                 (- counter 1)
                 (* b product))))

; (expt 2 3)

(define (square n)
  (* n n))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (pow b n)
  (cond ((= n 0) 1)
        (else (* b (pow b (- n 1))))))

; Ex. 1.16

(define (iter-fast-expt y x)
  (define (ife b n a)
    (cond ((= n 0) a)
          ((odd? n) (ife b (- n 1) (* a b)))
          (else (ife (square b) (/ n 2)  a))))
  (ife y x 1))



; Exercise 1.37

(define (cont-fract n d k)
 (define (iter n d k result)
    (cond ((= k 0) result)
     (else (iter n d (- k 1) (/ (n k) (+ (d k) result))))))
  (iter n d k (/ (n k) (d k))))

(define (rec-cont-fract n d k)
  (cond ((= k 0) (/ (n k) (d k)))
        (else (/ (n k)
           (+ (d k) (rec-cont-fract n d (- k 1))))))) 

(/ 1 (cont-fract (lambda (i)  1.0)
                 (lambda (i)  1.0) 13)) ; 1.6180...

(/ 1 (rec-cont-fract (lambda (i)  1.0)
                     (lambda (i)  1.0) 13))  ; 1.6180...

; Exercise 1.38

(+ 2 (cont-fract (lambda (i) 1.0)
                 (lambda (i)
                   (let ((trip (ceiling (/ i 3)))
                           (idx (modulo i 3)))
                     (cond ((or
                             (= idx 1)
                             (= idx 0)) 1)
                            (else (* 2 trip))))) 20)) ; 2.71828....

; Exercise 1.35

(define tolerance 0.0001)

(define (close-enough? x y)
  (< (abs (- x y)) tolerance))


(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)


     

           