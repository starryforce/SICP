#lang simply-scheme

(require rackunit)

;[X -> Y] [Any -> Boolean] Any
; pred is a function that returns #t if and only if
; the datum is a legal argument to f
(define (type-check f pred datum)
  (if (pred datum) (f datum) #f))

(check-equal? (type-check sqrt number? 'hello) #f)
(check-equal? (type-check sqrt number? 4) 2)