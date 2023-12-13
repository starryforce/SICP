#lang sicp

(#%require srfi/41)

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (stream-cons
       low
       (stream-enumerate-interval (+ low 1)
                                  high))))
(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))

; Main
(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq 
  (stream-map 
   accum 
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))
; 1+0 1 
; 2+1 3
; 3+3 6  0
; 4+6 10 1
; 5+10 15
; 6+15 21
; 7+21 28 2
; 8+28 36  3
; 9+36 45
; 10+45 55
; 11+55 66  4
; 12+66 78  5
; 13+78 91
; 14+91 105
; 15+105 120  6
; 16+120 136  7

; 17+136 153
; 18+153 171
; 19+171 190
; 20+190 210

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))
; sum: 0

(stream-ref  y 7)
; sum: 136
(display-stream z)
; sum: 210