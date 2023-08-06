#lang simply-scheme

(require rackunit)

(define (square x) (* x x))

#|
; [Word -> Y] Sentence -> Sentence
; same with map in javascript
(define (every f s)
  (if (empty? s)
      '()
      (se (f (first s)) 
          (every f (bf s)))))


(check-equal? (every square '(1 2 3 4)) '(1 4 9 16))
(check-equal?  (every first '(nowhere man)) '(n m))
|#

(every (lambda (letter) (word letter letter)) 'purple)
; '(pp uu rr pp ll ee)
(every (lambda (number) (if (even? number) (word number number) number))
'(781 5 76 909 24))
; '(781 5 7676 909 2424)
(keep even? '(781 5 76 909 24))
; '(76 24)
(keep (lambda (letter) (member? letter 'aeiou)) 'bookkeeper)
; 'ooeee
(keep (lambda (letter) (member? letter 'aeiou)) 'syzygy)
; ""
(keep (lambda (letter) (member? letter 'aeiou)) '(purple syzygy))
; error
(keep (lambda (wd) (member? 'e wd)) '(purple syzygy))
; '(purple)