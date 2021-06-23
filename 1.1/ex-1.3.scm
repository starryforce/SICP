#lang sicp

(define (square x)
  (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (sum-of-squares-of-larger-two x y z)
  (cond ((and (>= x y) (>= z y)) (sum-of-squares x z))
        ((and (>= y x) (>= z x)) (sum-of-squares y z))
        (else (sum-of-squares x y))))

(sum-of-squares-of-larger-two -1 3 5)