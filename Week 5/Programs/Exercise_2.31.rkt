#lang simply-scheme

; 2.31

(define  (sqr x) (* x x))

(define (tree-map funct tree)
    (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (funct sub-tree)))tree))

(define (square-tree tree) (tree-map sqr tree))

(square-tree (list 1
                   (list 2 (list 3 4) 5)
                   (list 6 7))) ; '(1 (4 (9 16) 25) (36 49))



