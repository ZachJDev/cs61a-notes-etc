#lang simply-scheme

; Lab Week 4

; Problem 1:

(define x (cons 4 5)) ; makes a pair of 4 and 5
(car x)  ; 4
(cdr x)  ; 5
(define y (cons 'hello 'goodbye))
(define z (cons x y))
(car (cdr z)) ; 'hello
(cdr (cdr z))  ; 'goodbye

; Problem 2:

(cdr (car z)) ; 5
(car (cons 8 3)) ; 8
(car z) ; '( 4 . 5)
;(car 3) ; 3 xxxxx Error, expected pair?

; Problem 3:

(define (make-rational num den)
  (cons num den))
(define (numerator rat)
  (car rat))
(define (denominator rat)
  (cdr rat))
(define (*rat a b)
  (make-rational (* (numerator a) (numerator b))
                 (* (denominator a) (denominator b))))
(define (print-rat rat)
  (word (numerator rat) '/ (denominator rat)))



(define (simp-rat rat) ; Added this one myself
  (let ((new-denom (gcd (numerator rat) (denominator rat))))
    (make-rational (/ (numerator rat) new-denom)
                   (/ (denominator rat) new-denom))))
                 

; Problem 4:

; (print-rat (make-rational 2 3))
; (print-rat (*rat (make-rational 2 3) (make-rational 1 4)))

(define (normalize-rat a b)
  (make-rational (* (numerator a) (denominator b))
                 (* (denominator a) (denominator b))))
(define (+rat a b)
  (make-rational (+ (numerator (normalize-rat a b)) (numerator (normalize-rat b a)))
                 (denominator (normalize-rat b a))))

; (print-rat (simp-rat (+rat (make-rational 12 20)
;      (make-rational 15 36)))) ; "61/60"

; Problem 5:

; 2.2

(define (make-segment point1 point2)
  (cons point1 point2))
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))
(define (x-point point)
  (car point))
(define (y-point point)
  (cdr point))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (mid-point line)
  (make-point (/ (+ (x-point (start-segment line)) (x-point (end-segment line))) 2)
              (/ (+ (y-point (start-segment line)) (y-point (end-segment line))) 2)))
(print-point (mid-point
 (make-segment (make-point 15 16)
               (make-point 25 20)))) ; (20,18)

; 2.3

(define (make-rect origin h l)
  (list origin
        (make-point (+ (x-point origin) l) (y-point origin))
        (make-point (+ (x-point origin) l) (+ (y-point origin) h))
        (make-point (x-point origin) (+ (y-point origin) h))))
(define (point1 rect)
  (car rect))
(define (point2 rect)
  (cadr rect))
(define (point3 rect)
  (caddr rect))
(define (point4 rect)
  (cadddr rect))

(define (height rect)
  (abs (- (x-point (point1 rect)) (x-point (point2 rect)))))
(define (length rect)
  (abs (- (y-point (point1 rect)) (y-point (point3 rect)))))

(define x-rect (make-rect (make-point 15 20) 10 10))

(define (perimeter rect)
  (+ (* 2 (length rect))
     (* 2 (height rect))))

(define (area rect)
  (* (length rect)
     (height  rect)))

(area x-rect)

(perimeter x-rect)

; I am a bit confused about this second part, asking to reimplement rectangle with a different representation.
; Does this mean change the underlying data structure (in my case, 4 points)
; OR change the constructor (in my case, an origin, height, and length)?

; The second would be trival to make work with perimeter and area --
; simply derive four points of a rectangle from 2 given points.

; the first would be more challenging, as it would require rewriting
; the height and length procedures.

; I can't think of a way where I wouldn't have to break at least ONE
; abstraction somewhere in the process.

; 2.4

(define (cons2 x y)
  (lambda (m) (m x y)))

(define (car2 z)
  (z (lambda (p q) p)))

(define (cdr2 z)
  (z (lambda (p q) q)))

(cdr2 (cons2 1 2))


; Problem 8

(define (reverse lst)
     (append (if (null? (cdr lst))
               (list (car lst))
               (append (reverse (cdr lst)) (list (car lst)))))) ; Not sure if I was allowed to use list and append, but I finally got this to work, phew.
                
(cons 1
      (cons 2 (cons 3 (cons 4 '()))))
(reverse '( 1 2 3 4))



