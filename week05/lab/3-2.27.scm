#lang simply-scheme

(require rackunit)

; [List-of Any] -> [List-of Any]
; returns as its value the list with its elements reversed and
; with all sublists deep-reversed as well
(define (deep-reverse l)
  (if (pair? l)
      (append (deep-reverse (cdr l)) (list (deep-reverse (car l))))
      l))


(define x 
  (list (list 1 2) (list 3 4)))
(check-equal? (deep-reverse x) '((4 3) (2 1)))
(check-equal? (deep-reverse '((1 2 3) (4 5 6) (7 8 9)))
              '((9 8 7) (6 5 4) (3 2 1)))