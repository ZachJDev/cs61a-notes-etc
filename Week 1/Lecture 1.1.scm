#lang simply-scheme
42        ; 42
(+ 1 2 3) ; 6
(+ 5)     ; 5
(* 5 5)   ; 25


(+)       ; 0 -- not an error
(*)       ; 1 -- not an error
;(/) error: 'the expected number of arguments does not match the given number


+         ; exposes the procedure/function; not an error
'+        ; apostrophe-followed-by-anything returns the value of the post-apostrophe thing

(+ (+ 2 2) (* 2 6)) ; (2 + 2) + (2 * 6) = 4 + 12 = 16: FUNCTIONAL COMPOSITION

; SOME FUN WORD STUFF

(first 'abcd)          ; 'a
(butfirst 'abcd)       ; 'bcd
(first '(hello World)) ; 'hello
(word 'now 'here)      ; 'nowhere

;VARIBALE AND FUNCTION DEFINITIONS

(define pi 3.141592654) ; defining and calling a variable
(+ 1 pi)                ; 4.141592654

(define (square x)
  (* x x))             ; defining a procedure and calling it
(square 3)             ; 9

; A QUICK NOTE ON OPERATIONS

(define five (+ 2 3))  ; this stores the result as a variable; + 2 3 is evaluated once
five                   ; 5

(define (fiveFunct)(+ 2 3)) ; This stores the result as a function; + 2 3 is evaluated whenever it is called.
(fiveFunct)                 ; 5



(define (plural wd)
  (word wd 's))

(plural 'computer) ; 'computers
(plural 'fly)      ; flys OOPS!
(plural 'boy)

(define(plural2 wd)
  (if (equal? (last wd) 'y)
      (word (bl wd) 'ies)
      (word wd 's)))

(plural2 'computer) ; 'computers
(plural2 'fly)      ; flies
(plural2 'boy)      ; boies OOPS!