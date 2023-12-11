#lang sicp

(#%require srfi/41)

(define (num-seq n0)
  (define (iter n) 
    (let ((next (if (odd? n) (+ (* 3 n) 1) (/ n 2))))
      (stream-cons next (iter next))))
  (stream-cons n0 (iter n0)))

(define ex (num-seq 7))


(define (seq-length s)
  (let ((cur (stream-car s))
        (rest (stream-cdr s)))
    (if (= cur 1)
        1
        (+ 1 (seq-length rest)))))