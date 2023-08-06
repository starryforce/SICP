#lang simply-scheme

(require rackunit)

(define (inc x) (+ x 1))

; [X -> Y] -> [X -> Y]
(define (double f)
  (lambda (x) (f (f x))))

(check-equal? ((double inc) 1) 3)

(((double (double double)) inc) 5)
; 13 is wrong
; true value is 21


; (double double) 使得一个函数应用4次
; ((double (double double)) 把一个函数应用4次，再把这个应用了4次的函数应用4次 4x4=16
