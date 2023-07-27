#lang simply-scheme

#| Exercise 1.4:
Observe that our model of evaluation allows for combinations whose operators are compound expressions.
Use this observation to describe the behavior of the following procedure:
|#

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; first determine the procedure to be perfermed,
; according to the value of b,
; if b is larger than zero, the procedure is +
; otherwise it's -
; then apply the procedure to a & b