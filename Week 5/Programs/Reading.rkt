#lang simply-scheme


(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x) )
                 (count-leaves (cdr x))))))

(count-leaves '(1 (2 3 4 5) 2 3 4 5))
; (list 1 (list 2 (list 3 4)))



