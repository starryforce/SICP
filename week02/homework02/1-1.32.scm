#lang simply-scheme

(require rackunit)

; [X X -> X] X [Number -> X] Number [Number -> Number] Number -> X
(define (accumulate combiner null-value term a next b)
  (cond ((> a b) null-value)
        (else (combiner (term a)
                        (accumulate combiner null-value term (next a) next b)))))

; [Number -> Number] Number [Number -> Number] Number -> Number
; calc the sum
(define (sum term a next b)
  (accumulate + 0 term a next b))

(check-equal? (sum (lambda (x) x) 1 (lambda (x) (+ x 1)) 5) 15)
  
; [Number -> Number] Number [Number -> Number] Number -> Number
; calc the product
(define (product term a next b)
  (accumulate * 1 term a next b))

(check-equal? (product (lambda (x) (* x x)) 3 (lambda (x) (+ x 1)) 6) 129600)