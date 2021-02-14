#lang simply-scheme

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x)
                            (filter (lambda (y)
                                      (not (member? y x))) s)
                            ) rest)))))

(subsets '(1 2 3)) ; '(() (3) (2 3) (2) (1 2 3) (1 2) (1) (1 3))