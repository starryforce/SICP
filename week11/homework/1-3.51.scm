#lang sicp

(#%require srfi/41)

(define (display-line x)
  (newline)
  (display x))

(define (show x)
  (display-line x)
  x)

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (stream-cons
       low
       (stream-enumerate-interval (+ low 1)
                                  high))))

(define x 
  (stream-map 
   show 
   (stream-enumerate-interval 0 10)))
; (stream-enumerate-interval 0 10) returns a stream-pair whose stream-car is 0
; and stream-cdr is a promise to produce (stream-enumerate-interval 1 10)
; because of memorization, define x will not evaluate the first item in x.


;(stream-ref x 5)
; 5
;(stream-ref x 7)
; 7