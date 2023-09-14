#lang simply-scheme

(define (make-vect x y)
  (cons x y))
; A Vector is a Pair:
; (make-vect Number Number)
; interpretation represents a vector

(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

(define (make-segment start end)
  (cons start end))
; A Segement is a Pair:
; (cons Vector Vector)

; Segement -> Vector
(define (start-segment se) (car se))
(define (end-segment se) (cdr se))