#lang simply-scheme

(define (replace-tato sent)
  (if (= 0 (count sent))
         '()
         (if (equal? (first sent) 'tato)
             (se '(tato <and tato only>) (replace-tato (bf sent)))
             (se (first sent) (replace-tato (bf sent))))
         ))


(define (expand-tato n)
  (se (cond ((= n 0)'(tato))
          (else (replace-tato(se (expand-tato (- n 1))))
          ))))

(expand-tato 0) ; tato
(expand-tato 1) ; tato <and tato only>
(expand-tato 2) ; tato <and tato only> <and tato <and tato only> only>
(expand-tato 3)