#lang sicp

(#%require srfi/41)

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (stream-cons 
   1.0
   (stream-map (lambda (guess)
                 (sqrt-improve guess x))
               (sqrt-stream x))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(define (stream-limit s t)
  (let ((i0 (stream-car s))
        (i1 (stream-car (stream-cdr s))))
    (if (< (abs (- i0 i1)) t)
        i1
        (stream-limit (stream-cdr s) t))))

(sqrt 5 0.000001)
