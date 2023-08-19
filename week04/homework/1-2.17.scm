#lang simply-scheme

(require rackunit)

; [NEList-of Any] -> [List Any]
; returns the list that contains only the last element of a l
(define (last-pair l)
  (if (null? (cdr l))
      l
      (last-pair (cdr l))))

(check-equal? (last-pair (list 23 72 149 34)) '(34))