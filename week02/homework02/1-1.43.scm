#lang simply-scheme

(require rackunit)

(define (compose f g)
  (lambda (x) (f (g x))))

; [Number -> Number] Number -> [Number -> Number]
; repeated evaluate f n times
(define (repeated f n)
  (cond ((= n 1) f)
        (else (compose
               f
               (repeated f (- n 1))))))

(define (square x) (* x x))

(check-equal? ((repeated square 2) 5) 625)