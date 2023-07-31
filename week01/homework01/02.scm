#lang simply-scheme

(require rackunit)

#| 2.
Write a procedure squares that takes a sentence of numbers as its argument and
returns a sentence of the squares of the numbers:
|#

(define (square x) (* x x))

; [List-of Number] -> [List-of Number]
; returns a sentence of the squares of the numbers
(define (squares alon)
  (cond ((empty? alon) '())
        (else (se (square (first alon))
                  (squares (bf alon))))))

(check-equal? (squares '(2 3 4 5)) '(4 9 16 25))
