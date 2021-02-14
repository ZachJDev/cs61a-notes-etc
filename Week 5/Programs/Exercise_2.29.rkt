#lang simply-scheme
; 2.29



(define (make-mobile left right)
  (list left right))

(define (make-branch length structure) ; structures are a number (representing a weight) or another mobile
  (list length structure))

; a
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))

; b
(define (branch-weight branch)
    (cond ((number? (branch-structure branch)) (branch-structure branch))
          (else (+ (branch-weight (left-branch (branch-structure branch)))
                   (branch-weight (right-branch (branch-structure branch)))))))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define x (make-mobile (make-branch 5 10)
             (make-branch 50 (make-mobile (make-branch 25 3)
                                          (make-branch 25 (make-mobile
                                                           (make-branch 30 1)
                                                           (make-branch 40 1)))))))

; c

(define (branch-torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (balanced? mobile)
  (and (= (branch-torque (left-branch mobile))
          (branch-torque (right-branch mobile)))
       (if (not (number? (branch-structure (left-branch mobile))))
             (balanced? (branch-structure (left-branch mobile)))
             #t)
       (if (not (number? (branch-structure (right-branch mobile))))
             (balanced? (branch-structure (right-branch mobile)))
             #t)))

                              
(define y (make-mobile (make-branch 1 (make-mobile (make-branch 2 250)
                                                   (make-branch 2 250)))
                       (make-branch 5 100)))
(balanced? (make-mobile (make-branch 5 y) (make-branch 5 y)))