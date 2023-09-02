#lang simply-scheme

(define (subsets s)
  ; if s is null, the result is a list contains one result that is empty list as well
  (if (null? s)
      '(())
      (let (; rest is all sets not contains (car s)
            (rest (subsets (cdr s))))
        ; the final result is all sets that do not contains (car s)
        ; together with all sets contains (car s)
        (append rest (map (lambda (i) (cons (car s) i)) rest)))))