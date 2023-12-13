#lang sicp

(#%require srfi/41)

(define ones (stream-cons 1 ones))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define integers 
  (stream-cons 1 (add-streams ones integers)))

(define (partial-nums s)
  (define result
    (stream-cons (stream-car s)
                 (add-streams result (stream-cdr s))))
  result)

(stream-ref (partial-nums integers) 0)
(stream-ref (partial-nums integers) 1)
(stream-ref (partial-nums integers) 2)
(stream-ref (partial-nums integers) 3)
(stream-ref (partial-nums integers) 4)