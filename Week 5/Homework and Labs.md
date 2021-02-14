## Homework

- Problem 2.26

```Scheme
; 2.26:
(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)
 '(1 2 3 4 5 6)
(cons x y) ; ACTUAL '((1 2 3) 4 5 6)
 '((1 2 3) . (4 5 6))
(list x y)
 '((1 2 3) (4 5 6))

```

- Problem 2.29

```Scheme
; 2.29

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure) ; structures are a number (representing a weight) or another mobile
  (cons length structure))

; a
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cdr mobile))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cdr branch))

; b
(define (branch-weight branch)
    (cond ((number? (branch-structure branch)) (branch-structure branch))
          (else (+ (branch-weight (left-branch (branch-structure branch)))
                   (branch-weight (right-branch (branch-structure branch)))))))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

; c

(define (branch-torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (balanced? mobile)
  (and (= (branch-torque (left-branch mobile))
          (branch-torque (right-branch mobile)))
       (if (not (number? (branch-structure (left-branch mobile))))
             (balanced? (branch-structure (left-branch mobile)))
             #t)
       (if (not (number? (branch-structure (right-branch mobile))))
             (balanced? (branch-structure (right-branch mobile)))
             #t)))

                              
(define y (make-mobile (make-branch 1 (make-mobile (make-branch 1 499)
                                                   (make-branch 1 1)))
                       (make-branch 5 100)))
(balanced? y) ; #f

; d

; Everything runs well after changing the cadr's in
; right-branch and branch-structure to cdr's
```

- Problem 2.30

```Scheme
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

```

- Problem 2.31

```Scheme
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
```

- Problem 2.32

```Scheme
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
```