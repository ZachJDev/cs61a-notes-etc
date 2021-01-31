# Homework:
### Exercise 1.16
```Scheme
(define (iter-fast-expt y x)
  (define (ife b n a)
    (cond ((= n 0) a)
          ((odd? n) (ife b (- n 1) (* a b)))
          (else (ife (square b) (/ n 2)  a))))
  (ife y x 1))

```

### Exercise 1.35
```Scheme
(define tolerance 0.0001)

(define (close-enough? x y)
  (< (abs (- x y)) tolerance))


(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0) ; 1.6810...
```

### Exercise 1.37
```Scheme
(define (cont-fract n d k)
 (define (iter n d k result)
    (cond ((= k 0) result)
     (else (iter n d (- k 1) (/ (n k) (+ (d k) result))))))
  (iter n d k (/ (n k) (d k))))

(define (rec-cont-fract n d k)
  (cond ((= k 0) (/ (n k) (d k)))
        (else (/ (n k)
           (+ (d k) (rec-cont-fract n d (- k 1))))))) 

(/ 1 (cont-fract (lambda (i)  1.0)
                 (lambda (i)  1.0) 13)) ; 1.6180...

(/ 1 (rec-cont-fract (lambda (i)  1.0)
                     (lambda (i)  1.0) 13))  ; 1.6180...
```

### Exercise 1.38
```Scheme
(+ 2 (cont-fract (lambda (i) 1.0)
                 (lambda (i)
                   (let ((trip (ceiling (/ i 3)))
                           (idx (modulo i 3)))
                     (cond ((or
                             (= idx 1)
                             (= idx 0)) 1)
                            (else (* 2 trip))))) 20)) ; 2.71828....

```

### Q 2:
```Scheme
(define (is-factor? x y)
  (if (= 0 (remainder y x) )
      #t
      #f))

(define (sum-if low high pred?)
  (cond ((= low high) 0)
           ((pred? low high) (+ low (sum-if (+ 1 low) high pred?)))
           (else (sum-if (+ 1 low) high pred?))))

(define (next-perf num)
  (if (= num (sum-if 1 num is-factor?))
      num
      (next-perf (+ 1 num))))

 (next-perf 29) ; 496
```

### Q 3:
- when `kinds-of-coins` and `amount` are both `0`, then the filpped version will return `0` and the original  `1`.

### Q 4:
 `b` raised to the power of `n - counter` equals `product`