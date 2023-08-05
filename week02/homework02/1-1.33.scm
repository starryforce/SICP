#lang simply-scheme

(require rackunit)

; [X X -> X] X [Number -> X] Number [Number -> Number] Number [X -> Boolean] -> X
(define (filtered-accumulate combiner null-value term a next b pred)
  (cond ((> a b) null-value)
        ((pred a) (combiner (term a)
                                   (filtered-accumulate combiner null-value term (next a) next b pred)))
        (else (filtered-accumulate combiner null-value term (next a) next b pred))))

(define (prime? x) (member? x '(2 3 5 7 11 13 17 19 23)))

; Number Number -> Number
; the sum of the squares of the prime numbers in the interval a to b
(define (fn1 a b)
  (filtered-accumulate + 0 (lambda (x) (* x x)) a (lambda (x) (+ x 1)) b prime?))

(check-equal? (fn1 2 10) 87)
(check-equal? (fn1 3 11) 204)

(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

; Number -> Number
; the product of all the positive integers less than n
; that are relatively prime to n
(define (fn2 n)
  (filtered-accumulate * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) (- n 1) (lambda (x) (equal? 1 (gcd x n)))))

(check-equal? (fn2 7) (* 1 2 3 4 5 6))
