#lang sicp


(define (sqrt x)
  (define (square x)
  (* x x))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
      guess
      (sqrt-iter (improve guess)
                 )))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (average x y)
    (/ (+ x y) 2))
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  
  (sqrt-iter 1.0))


(sqrt 9)