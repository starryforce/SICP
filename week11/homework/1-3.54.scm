#lang sicp

(#%require srfi/41)
(#%require "util.scm")

(define ones (stream-cons 1 ones))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define integers 
  (stream-cons 1 (add-streams ones integers)))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials 
  (stream-cons 1 (mul-streams factorials (stream-cdr integers))))

(show-stream factorials 10)