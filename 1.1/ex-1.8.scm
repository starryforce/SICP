#lang simply-scheme

(require rackunit)

(define delta 0.0001)

; Number Number -> Number
; determine the cube root of x
; from guess, literly improve the guess
(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve-guess guess x) x)))

; Number Number -> Boolean
(define (good-enough? guess x)
  (= (improve-guess guess x) guess))

; Number Number -> Number
; use Newton’s method to improve guess of the cube root
(define (improve-guess guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (cube-root x)
  (cube-root-iter 1.0 x))

(check-within (cube-root 27) 3 delta)
(check-within (cube-root 1000) 10 delta)