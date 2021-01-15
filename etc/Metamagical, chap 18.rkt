#lang simply-scheme
; Solved when reading Metamagical Themas, D.R. Hofstadter, chap. 18

; Called 'hotpo' (half or triple plus one) in the book, but a quick Google tells me this is the Collatz conjecture
; (Or at least the problem the conjecture is based on)

(define (hotpo x)
  (cond ((equal? (modulo x 2)0) (/ x 2))
        (else (+ 1 (* 3 x)))))


(define (buildHotpo x)
  (if (equal? x 1)
      x
      (se  x (buildHotpo (hotpo x)))))

(buildHotpo 3) ; '(3 10 5 16 8 4 2 1)

; Recursively counts 'atoms' regardless of list nesting

(define (atomcount sent)
  (cond ((empty? sent) 0)
        ((word? (first sent)) (+ 1 (atomcount (bf sent))))
        ((list? (first sent)) (+ (atomcount (first sent)) (atomcount (bf sent))))
  )
)

(atomcount '(((ac ab cb) ac (ba bc ac)) ab (( cb ca ba) cb (ac ab cb)))) ; 15


; Tower of Hanoi solver -- lists moves for arbitrary Hanoi solves
; (got over the last hump with https://en.wikipedia.org/wiki/Tower_of_Hanoi)

(define (hanoi disks source target aux)
  (se
  (cond ( (= disks 1) (word source target))
        ( else (se (hanoi (- disks 1) source aux target )
                   (word source target)
                   (hanoi (- disks 1) aux target source ))))))

;(count
 (hanoi 5 'a 'b 'c)
;)

        