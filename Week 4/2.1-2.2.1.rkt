#lang simply-scheme

(define (make-rat n d) (cons n d))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mult-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define one-half (make-rat 1 2))

;(print-rat (add-rat one-half one-half))

;;;; 2.1.4 INTERVAL ARITHMATIC ;;;;


(define (make-interval a b) (cons a b))
(define (lower-bound x) (min (cdr x) (car x)))
(define (upper-bound x) (max (cdr x) (car x)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

;;; 2.8
; This can be implemented differently if you would always take the higher of the two upper or lower bounds as the minuend.
; The second of the two implementations does just that.
(define (sub-interval x y) 
  (make-interval (- (upper-bound x) (upper-bound y))
                 (- (lower-bound x) (lower-bound y))))

(define (abs-sub-interval x y)
  (make-interval (abs (- (upper-bound x) (upper-bound y)))
                 (abs (- (lower-bound x) (lower-bound y)))))

(define int1 (make-interval 4.25 7))
(define int2 (make-interval 15.50 -8))

(sub-interval int1 int2)
(sub-interval int2 int1)

(abs-sub-interval int1 int2)
(abs-sub-interval int2 int1)

;;; 2.10

(define (error-div-interval x y)
  (if (<= (upper-bound y) (- (upper-bound y) (lower-bound y)))
      (error "cannot divide by an interval spanning 0.") 
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y))))))

; (error-div-interval int1 int2)


;;; 2.12

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (/ (center i) (- (center i) (lower-bound i))))

(define (make-center-percent x y)
  (let ((percent-change (/ x y)))
    (make-interval (- x percent-change) (+ x percent-change))))

(define int3 (make-center-percent 6.8 10))

(percent int3)

(define 1-4 (list 1 2 3 4))

; Exercise 2.17

(define (last-pair list)
  (if (null? (cdr list))
      list
      (last-pair (cdr list))))
(last-pair '(1 2 3412 414 4923847))

; Exercise 2.20

(define (filter-list list pred)
  (cond ((null? list) null)
        ((pred (car list)) (cons (car list) (filter-list (cdr list) pred)))
        (else (filter-list (cdr list) pred))))

(define (same-parity x . y)
  (let ((par-pred (if (odd? x) odd? even?)))
   (filter-list (cons x y) par-pred)))

(same-parity 2 2 3 4 5 6 7 9 10 11  12 13 15)