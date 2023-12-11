#lang sicp

(#%require srfi/41)

(define (integers-starting-from n)
  (stream-cons
   n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))
