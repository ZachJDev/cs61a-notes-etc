#lang simply-scheme


(define (get-value card)
  (define (get-length card length)
    (if (not (member?  (first card) '(S D H C j))) ; added a catch in here for the joker
        (get-length (bf card) (+ length 1))
        length))
  (if (= 2(get-length card 0))
      10
      (first card)))


(define (get-suit card)
  (last card))



(define (suits-in-hand hand) 
  (if (<= (length hand) 0)
      '()
      (se (get-suit (first hand)) (suits-in-hand (bf hand)))))

(define (has-suit suit hand)
  (member? suit (suits-in-hand hand)))

(define (make-count-value value)
  (lambda (hand)
    (define (iter hand total)
      (cond ((<= (length hand) 0) total)
            ((equal? (get-value (first hand)) value) (iter (bf hand) (+ 1 total)))
            (else (iter (bf hand) total))))
    (iter hand 0)))


(define (best-total hand) ;  wrote everything below joker-count
  (define (pre-totaler cards)
  (define (sort cards)
    (cond ((>= 0 (length cards)) '())
          ((equal? (get-value (first cards)) 'A) (se (sort (bf cards)) (first cards)))
          (else (se (first cards) (sort (bf cards))))))
  (define (iter cards total)
    (if (>= 0 (length cards)) total
    (let ( (card-val (get-value (first cards))))
      (cond ((member? card-val '(K J Q)) (iter (bf cards) (+ total 10)))
             ((equal? card-val 'A) (iter (bf cards) (+ total (if (<= total 11) 10 1))))
             (else (iter (bf cards) (+ total card-val)))))))
  (iter (sort cards) 0))
  
  (define joker-count ((make-count-value 'j) hand))
  (define (remove-joker hand)
    (cond ((<= (length hand) 0) '())
          ((equal? (get-value (first hand)) 'j) (se (remove-joker (bf hand))))
          (else (se (first hand) (remove-joker (bf hand))))))
  (define pre-total (pre-totaler (remove-joker hand)))
 (cond ((>= pre-total 20) (+ pre-total (* joker-count 1)))
       ((and (< pre-total 20)(= 2 joker-count)) 21)
       ((and (>= pre-total 10) (= 1 joker-count)) 21)
       (else (+ pre-total (* joker-count 11)))))

 
;;;; STARTING CODE
(define (twenty-one strategy)
  (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
    (cond ((> (best-total dealer-hand-so-far) 21) 1)
	  ((< (best-total dealer-hand-so-far) 17)
	   (play-dealer customer-hand
			(se dealer-hand-so-far (first rest-of-deck))
			(bf rest-of-deck)))
	  ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1)
	  ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0)
	  (else 1)))

  (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
    (cond ((> (best-total customer-hand-so-far) 21) -1)
	  ((strategy customer-hand-so-far dealer-up-card)
	   (play-customer (se customer-hand-so-far (first rest-of-deck))
			  dealer-up-card
			  (bf rest-of-deck)))
	  (else
	   (play-dealer customer-hand-so-far
			(se dealer-up-card (first rest-of-deck))
			(bf rest-of-deck)))))

  (let ((deck (make-deck)))
    (play-customer (se (first deck) (first (bf deck)))
		   (first (bf (bf deck)))
		   (bf (bf (bf deck))))))

(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)) )
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C) 'j 'j) ) ; Added the two jokers here.


(define (make-deck)
  (define (shuffle deck size)
    (define (move-card in out which)
      (if (= which 0)
	  (se (first in) (shuffle (se (bf in) out) (- size 1)))
	  (move-card (bf in) (se (first in) out) (- which 1)) ))
    (if (= size 0)
	deck
    	(move-card deck '() (random size)) ))
  (shuffle (make-ordered-deck) 52) )

;; Strategies

(define (reckless strat)
  (lambda (hand dealer-hand)
    (strat (bl hand) dealer-hand)))

(define (majority strat1 strat2 strat3)
  (lambda (hand dealer-hand)
         (let ((res1 (strat1 hand dealer-hand))
               (res2 (strat2 hand dealer-hand))
               (res3 (strat3 hand dealer-hand)))
           (or (and res1 res2)
               (and res2 res3)
               (and res1 res3)))))
           

(define (suit-strategy suit strat1 strat2)
  (lambda (hand dealer-hand)
    (if (has-suit suit hand)
        (strat2 hand dealer-hand)
        (strat1 hand dealer-hand))))

(define (stop-at n)
  (lambda (hand dealer-card)
    (< (best-total hand) n)))

(define valentine (suit-strategy 'H (stop-at 17) (stop-at 19)))

; ((majority (stop-at 16) (stop-at 17) (stop-at 18))'(2S 3S 7D 3C) 'JC)
; ((reckless (stop-at 15)) '(2S 3S 7D 10C) 'JC)

;(valentine '(2S 3S 10D 2C) 'JC)

; ("2S" "3S" "AH" "10D" "2D" "3D")
; (define (stop-at-17 hand dealer-card)
;   (< (best-total hand) 17))

(define (dealer-sensitive hand dealer-card)
  (define dealer-card-val (get-value dealer-card))
  (or
       (and (member? dealer-card-val '(A 7 8 9 10 K Q J))
            (< (best-total hand) 17))
       (and (member? dealer-card-val '(2 3 4 5 6))
            (< (best-total hand) 12))))


  
;(define (valentine hand dealer-hand)
;  (if (has-suit 'H hand)
;      ((stop-at 19) hand dealer-hand)
;      ((stop-at 17) hand dealer-hand)))


;; play-n games

(define (play-n strategy n)
  (define (iter total n)
    (if (<= n 0) total
        (iter (+ (twenty-one strategy) total) (- n 1)))) 
  (iter 0 n))

 (play-n (stop-at 16)  100)
 (play-n dealer-sensitive 100)
 (play-n valentine 100)













;                                      32
