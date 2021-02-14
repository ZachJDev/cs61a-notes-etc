#lang simply-scheme
(require racket/trace)

; Week 3 Lab

; Concering the count-change function from 1.2.2 (pg 41)

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(define (first-d kinds-of-coins)
  (cond ((= kinds-of-coins 1) 50)
        ((= kinds-of-coins 2) 25)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 5)
        ((= kinds-of-coins 5) 1)))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                 (- kinds-of-coins 1))
              (cc (- amount
                     (first-d kinds-of-coins))
                  kinds-of-coins)))))

(define (count-change amount)
  (cc amount 5))

;(count-change 100) ; 292

; Problem 1:

; One way to reverse the order of coin-counting would be to reverse the 'first-denomination list, so that
; half-dollars are counted when kinds-of-coins = 1, quaters when it equals 2, etc.

; Another thought I have is to start kinds-of-coins at 1, then add up to the given amount.

; Problem 2:

; Implemented the first way with the 'first-d' procedure.
; when count-change 10 was called, the program generated
; 83 calls to cc when using 'first-denomination' according to the trace
; and 284 when using first-d.

; Problem 3:

(define (new-cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (equal?  kinds-of-coins '() )) 0)
        (else (+ (new-cc amount
                 (bf kinds-of-coins))
              (new-cc (- amount
                     (first kinds-of-coins))
                  kinds-of-coins)))))

(define (new-count-change amount)
  (new-cc amount '(50 25 10 5 1)))
;(new-count-change 100) ; 292

; Problem 4:


(define (type-check funct pred? datum)
  (if (pred? datum)
      (funct datum)
      #f))


;(type-check sqr number? 'hello) ; #f
;(type-check sqrt number? 4) ; 2

; Problem 5:

(define (make-safe funct pred?)
  (lambda (x)
    (if (pred? x)
        (funct x)
        #f)))
(define safe-sqrt (make-safe sqrt number?))

; (safe-sqrt 25) ; 5
; (safe-sqrt 'hello) ; #f



