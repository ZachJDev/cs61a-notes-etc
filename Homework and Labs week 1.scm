#lang simply-scheme
; 
; (define (square x) (* x x))
; 
; (define (squares sent)
;   (if (< 0 (count sent))
;       (se (square (first sent)) (squares (bf sent)))
;       sent
;   ))
; 
; (squares '(2 3 4 5))

; (define (isMe? wd)
;   (or (equal? wd 'me)
;       (equal? wd 'Me)))
; 
; (define (isYou? wd)
;   (or (equal? wd 'you)
;       (equal? wd 'You)))
; 
; (define (isI? wd)
;   (or (equal? wd 'i)
;       (equal? wd 'I)))
; 
; (define (switchSentence sent)
;   (se (cond ((empty?  sent) '())
;             ((or (isMe? (first sent)) (isI? (first sent))) (se 'you (switchSentence (bf sent))))
;             ((isYou? (first sent)) (se 'me (switchSentence (bf sent))))
;             (else (se (first sent) (switchSentence (bf sent))))
;       )))
; 
; (define (switch sent)
;   (cond ((isYou? (first sent)) (se 'I (switchSentence (bf sent))))
;         ((or (isI? (first sent) ) (isMe? (first sent))) (se 'You (switchSentence (bf sent))))
;         (else (switchSentence sent))))
; 
; (switch '(Told me that I should wake you up I you me))


; (define (firstTwo sent)
;   (se (first sent) (first (bf sent)))
;   )
; 
; 
; (define (ordered? sent)
;   (if (< 1 (count sent))
;       (if (< (first (firstTwo sent)) (last (firstTwo sent)))
;           (ordered? (bf sent))
;           #f
;           )
;       #t)
;   )
; 
; (ordered? '( 1 2 3 4 5 6))

; 
; (define (endsWithE? wd)
;   (equal? (last wd) 'e))
; 
; (define (appendWordIf wd test)
;   (if (test wd) wd '())
;   )
; 
; (define (ends-e sent)
;   (if (< 0 (count sent))
;   (se (appendWordIf (first sent) endsWithE?) (ends-e (bf sent)))
;   sent)
;  )
; 
; (ends-e '(please boy bee above the elephant romme room boom highe))


; (define (recursion)
;   (recursion))
; (or #t recursion)
; (and #f recursion)


(define (dupals-removed sent)
  (if (< 0 (count sent))
  (se (if(member? (first sent) (bf sent))
         (se (dupals-removed (bf sent)))
         (se (first sent)(dupals-removed (bf sent)))
         )
      )
  sent)
  )

(dupals-removed '(1 2 3 2 1)) ; '(3 2 1)