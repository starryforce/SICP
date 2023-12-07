#lang sicp

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high)) ) )
(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream low (stream-enumerate-interval (+ low 1) high)) ) )

(delay (enumerate-interval 1 3))
; a promise to produce (list 1 2 3)

(stream-enumerate-interval 1 3)
; a promise to produce 1 2 3 one by one