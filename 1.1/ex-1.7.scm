#lang simply-scheme

#| Exercise 1.7:
The good-enough? test used in computing square roots
will not be very effective for finding the square roots of very small numbers.
Also, in real computers, arithmetic operations are almost always performed with limited precision.
This makes our test inadequate for very large numbers.
Explain these statements, with examples showing how the test fails for small and large numbers.
An alternative strategy for implementing good-enough? is to
watch how guess changes from one iteration to the next and to
stop when the change is a very small fraction of the guess.
Design a square-root procedure that uses this kind of end test.
Does this work better for small and large numbers?
|#
(define (square x) (* x x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) 
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;(sqrt 0.001)
; 0.04124542607499115
; (* 0.04124542607499115 0.04124542607499115)
; 0.0017011851721075596 =? 0.001

;(sqrt 59999999999999999999)
; infinate loop

(define (al-sqrt-iter guess prev-guess x)
  (if (al-good-enough? guess prev-guess x)
      guess
      (al-sqrt-iter (improve guess x) guess x)))

(define (al-good-enough? guess prev-guess x)
  (<= (abs (/ (- guess prev-guess) prev-guess)) 0.001))

(define (al-sqrt x)
  (al-sqrt-iter 1.0 2.0 x))

;(al-sqrt 0.001)
; 0.03162278245070105
; (* 0.03162278245070105 0.03162278245070105)
; 0.0010000003699243661
; much better

;(al-sqrt 59999999999999999999)
; 7745966997.409021
; (* 7745966997.409021 7745966997.409021)
; 6.000000472494973e+19
; give out a result