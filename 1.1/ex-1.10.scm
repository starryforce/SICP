#lang sicp

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (y-1))))))

(A 1 10)
(A (- 1 1) (A 1 9))
(A 0 (A 1 9))
(* 2 (A 1 9))
(* 2 (A (- 1 1) (A 1 8)))
