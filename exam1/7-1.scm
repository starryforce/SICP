#lang simply-scheme

(require rackunit)

(define (make-time hr mn cat)
  (+ (* 100 (if (equal? cat 'pm) (+ hr 12) hr)) mn))

(define (hour t)
  (remainder (quotient t 100) 12))
(define (minute t)
  (remainder t 100))
(define (category t)
  (if (>= t 1300) 'pm 'am))