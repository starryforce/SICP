#lang simply-scheme

(require rackunit)

#| Exercise 1.3:
Define a procedure that takes three numbers as arguments
and returns the sum of the squares of the two larger numbers.
|#

; Number -> Number
; return the square of x
(define (square x) (* x x))

(check-equal? (square 2) 4)
(check-equal? (square 3) 9)

; Number Number Number -> Number
; returns the sum of the squares of the two larger numbers.
(define (fn a b c)
  (cond ((and (<= a b) (<= a c)) (+ (square b) (square c)))
        ((and (<= b a) (<= b c)) (+ (square a) (square c)))
        ((and (<= c a) (<= c c)) (+ (square b) (square a)))))

(check-equal? (fn 2 1 3) 13)
(check-equal? (fn 1 2 3) 13)