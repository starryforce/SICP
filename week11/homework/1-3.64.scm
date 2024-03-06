#lang sicp

(#%require srfi/41)

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream 
     1.0 (stream-map
          (lambda (guess)
            (sqrt-improve guess x))
          guesses)))
  guesses)

(define (stream-limit s t)
  0)

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))