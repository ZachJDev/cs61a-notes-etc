# Homework and Labs Week 2
## Homework:
problem 1 is in the reading section.

Problem 2:
```Scheme
(define (every f sent)
  (if (< (count sent) 1)
      '()
      (se (f (first sent)) (every f (bf sent)))))

(every first '(hello everyone loves love orgres)) ; '(h e l l o)'

```

Problem 3:
```Scheme
(every (lambda (letter) (word letter letter)) 'purple) ; '(pp uu rr pp ll ee)
(every (lambda (number) (if (even? number) (word number number) number))
       '(781 5 76 909 24)) ; '(781 5 7676 909 2424)
(keep even? '(781 5 76 909 24)) ; '(76 24)
(keep (lambda (letter) (member? letter 'aeiou)) 'bookkeeper) ; 'ooeee
(keep (lambda (letter) (member? letter 'eaiou)) 'syzzygy) ; ""
;(keep (lambda (letter) (member? letter 'eaiou)) '(purple syzygy)) ; error
(keep (lambda (wd) (member? 'e wd)) '(purple syzygy)) ; '(purple)
```

Extra For Experts:

This is confusing. I was not able to solve it, but the book does have a working example in chapter 4 (search for 'Y-operator' in the index). Working on this has been a bit of a jumping off point in exploring functional programming in slightly more rigourous terms, which has been fruitful. 