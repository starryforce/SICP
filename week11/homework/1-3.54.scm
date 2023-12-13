#lang sicp

(#%require srfi/41)

(define ones (stream-cons 1 ones))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define integers 
  (stream-cons 1 (add-streams ones integers)))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials 
  (stream-cons 1 (mul-streams factorials (stream-cdr integers))))

(stream-ref factorials 0)
(stream-ref factorials 1)
(stream-ref factorials 2)
(stream-ref factorials 3)
(stream-ref factorials 4)
(stream-ref factorials 5)
(stream-ref factorials 6)