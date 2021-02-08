# Project 1

Note that  this project uses "sentences" (as defined in Simply-Scheme and in the environment the class uses) and the related procedures, such as `bl` `first` and `se`.

Q. 1:
 ```Scheme
(define (best-total cards)
  (define (sort cards)
    (cond ((>= 0 (length cards)) '())
          ((equal? (get-value (first cards)) 'A) (se (sort (bf cards)) (first cards)))
          (else (se (first cards) (sort (bf cards))))))
  (define (iter cards total)
    (if (>= 0 (length cards)) total
    (let ( (card-val (get-value (first cards))))
      (cond ((member? card-val '(K J Q)) (iter (bf cards) (+ total 10)))
             ((equal? card-val 'A) (iter (bf cards) (+ total (if (<= total 10) 11 1))))
             (else (iter (bf cards) (+ total card-val)))))))
  (iter (sort cards) 0))
 ```
 
 Q.2
 ```Scheme
 (define (stop-at-17 hand dealer-card)
   (< (best-total hand) 17))
 ```
 
 Q.3
 ```Scheme
 (define (play-n strategy n)
  (define (iter total n)
    (if (<= n 0) total
        (iter (+ (twenty-one strategy) total) (- n 1)))) 
  (iter 0 n))
 ```
 
 Q.4
 ```Scheme
 (define (dealer-sensitive hand dealer-card)
  (define dealer-card-val (get-value dealer-card))
  (or
       (and (member? dealer-card-val '(A 7 8 9 10 K Q J))
            (< (best-total hand) 17))
       (and (member? dealer-card-val '(2 3 4 5 6))
            (< (best-total hand) 12))))

 ```
 
 Q.5
 ```Scheme
 (define (stop-at n)
  (lambda (hand dealer-card)
    (< (best-total hand) n))) 
 ```
 
 Q.6
 ```Scheme
 (define (valentine hand dealer-hand)
  (if (has-suit 'H hand)
      ((stop-at 19) hand dealer-hand)
      ((stop-at 17) hand dealer-hand)))
 ```
 
 Q.7
 ```Scheme
 (define (suit-strategy suit strat1 strat2)
  (lambda (hand dealer-hand)
    (if (has-suit suit hand)
        (strat2 hand dealer-hand)
        (strat1 hand dealer-hand))))
 ```
 
 Q.8
 ```Scheme
 (define (majority strat1 strat2 strat3)
  (lambda (hand dealer-hand)
         (let ((res1 (strat1 hand dealer-hand))
               (res2 (strat2 hand dealer-hand))
               (res3 (strat3 hand dealer-hand)))
           (or (and res1 res2)
               (and res2 res3)
               (and res1 res3)))))
 ```
 
 Q.9
 ```Scheme
 (define (reckless strat)
  (lambda (hand dealer-hand)
    (strat (bl hand) dealer-hand)))
 ```
 
 ### Other procedures defined:
 
 get-value:
 ```Scheme
 (define (get-value card)
  (define (get-length card length)
    (if (not (member?  (first card) '(S D H C)))
        (get-length (bf card) (+ length 1))
        length))
  (if (= 2(get-length card 0))
      10
      (first card)))
 ```
 
 get-suit:
 ```Scheme
 (define (get-suit card)
  (last card))
 ```
 
 suits-in-hand:
 ```Scheme
 (define (suits-in-hand hand) 
  (if (<= (length hand) 0)
      '()
      (se (get-suit (first hand)) (suits-in-hand (bf hand)))))
 ```
 
 has-suit:
 ```Scheme
 (define (has-suit suit hand)
  (member? suit (suits-in-hand hand)))
 ```
 
 ## Joker Changes:
 
 I added two 'j's to the final deck in the `make-ordered-deck` procedure from the starter code.
 
 To `get-value`
 ```Scheme
 (define (get-value card)
  (define (get-length card length)
    (if (not (member?  (first card) '(S D H C j))) ; added a catch in here for the joker
        (get-length (bf card) (+ length 1))
        length))
  (if (= 2(get-length card 0))
      10
      (first card)))
 ```
 
 To `best-total`
 `Pre-totaler` is the old `best-total`. Now the `cond` at the end does the extra work for the jokers.
 ```Scheme
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
 ```