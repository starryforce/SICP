#lang simply-scheme

(require rackunit)

;[X -> Y] [Any -> Boolean] Any -> [Maybe Y]
; pred is a function that returns #t if and only if
; the datum is a legal argument to f
(define (type-check f pred datum)
  (if (pred datum) (f datum) #f))

(check-equal? (type-check sqrt number? 'hello) #f)
(check-equal? (type-check sqrt number? 4) 2)


; [X -> Y] [Any -> Boolean] -> [Any -> [Maybe Y]
(define (make-safe f pred)
  (lambda (x) (type-check f pred x)))

(define safe-sqrt (make-safe sqrt number?))

(check-equal? (safe-sqrt 'hello) #f)
(check-equal? (safe-sqrt 4) 2)