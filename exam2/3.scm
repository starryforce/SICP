#lang simply-scheme

(define (make-point x y)
  (cons x y))
(define (point-x p)
  (car p))
(define (point-y p)
  (cdr p))

(define (make-segment start end)
  (cons 'segment (cons start end)))

(define (start-segment s)
  (cadr s))
(define (end-segment s)
  (cddr s))


(define (midpoint obj)
  (let ((type (car obje)))
    (cond ((eq? 'segment type) ...)
          ((eq? 'frame type) ...)
          (else #f))))