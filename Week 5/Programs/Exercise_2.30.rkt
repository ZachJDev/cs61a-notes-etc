#lang simply-scheme

; 2.30

(define  (sqr x) (* x x))

(define (square-tree tree) ; with map
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (sqr sub-tree))) tree))

(define (new-square-tree tree) ; without map
  (cond ((null? tree) '())
        ((not (pair? tree)) (sqr tree))
        (else (cons (new-square-tree (car tree))
                    (new-square-tree (cdr tree))))))

(square-tree (list 1
                   (list 2 (list 3 4) 5)
                   (list 6 7))) ; '(1 (4 (9 16) 25) (36 49))

(new-square-tree (list 1
                   (list 2 (list 3 4) 5)
                   (list 6 7))) ; '(1 (4 (9 16) 25) (36 49))

