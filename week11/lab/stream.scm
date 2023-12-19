#lang sicp

(#%require srfi/41)

(define (integers-starting-from n)
  (stream-cons
   n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))


(stream-cons <a> <b>)
(cons <a> (delay <b>))
(delay <exp>) -> (lambda () <exp>)
(delay <exp>) -> (memo (lambda () <exp>))

(define (stream-car stream)
  (car stream))

(define (stream-cdr stream)
  (force (cdr stream)))