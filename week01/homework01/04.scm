#lang simply-scheme

(require rackunit)

#| 4.
Write a predicate ordered? that takes a sentence of numbers as its argument and
returns a true value if the numbers are in ascending order, or a false value otherwise.
|#

; [List-of Number] -> Boolean
; determine if alon is in ascending order
(define (ordered? alon)
  (cond ((< (count alon) 2) #t)
        (else (and (< (first alon) (first (bf alon)))
                   (ordered? (bf alon))))))

(check-equal? (ordered? '()) #t)
(check-equal? (ordered? '(1)) #t)
(check-equal? (ordered? '(1 2 3)) #t)
(check-equal? (ordered? '(1 3 2)) #f)