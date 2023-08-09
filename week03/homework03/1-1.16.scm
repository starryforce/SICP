#lang simply-scheme

(require rackunit)

(define (even? n)
  (= (remainder n 2) 0))

; Number Number -> Number
(define (fast-expt n b)
  (fast-expt-iter n b 1))

; Number Number Number -> Number
; n is the exponent
; b is the base
; a is the accumulator
(define (fast-expt-iter n b a)
  (cond ((= n 0) a)
        ((even? n) (fast-expt-iter (/ n 2) (* b b) a))
        (else (fast-expt-iter (- n 1) b (* a b)))))

(check-equal? (fast-expt 4 10) 10000)
