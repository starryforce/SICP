#lang sicp

(define a 8)
(define b 9)

(let ((a 3)
      (f (lambda (b) (+ a b))))
  (f 5))