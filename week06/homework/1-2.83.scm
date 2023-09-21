#lang simply-scheme

(define (raise x)
  (apply-generic 'raise x))

(define (integer->rational x) (make-rational x 1))
(define (rational->real x) (make-real (/ (numer x) (denom x))))
(define (real->complex x) (make-complex-from-real-imag x 0))

(put 'raise '(integer) integer->rational)
(put 'raise '(rational) rational->real)
(put 'raise '(real) real->complex)