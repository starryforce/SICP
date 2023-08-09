#lang simply-scheme

; golden ratio satisfied φ2=φ+1.
; according to the definition of fixed point
; x↦1+1/x 's fixed point x = 1 + 1/x
; both sides multiply x.
; x2 = x + 1

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)