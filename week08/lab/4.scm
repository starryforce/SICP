#lang simply-scheme

(define (plus1 var)
  (set! var (+ var 1))
  var)

(plus1 5)


#|
(set! 5 (+ 5 1))
5

5

result is 6
|#