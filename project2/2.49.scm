#lang simply-scheme

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) 
         (start-segment segment))
        ((frame-coord-map frame) 
         (end-segment segment))))
     segment-list)))

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
; (make-segment Vector Vector)

; Segement -> Vector
(define (start-segment se) (car se))
(define (end-segment se) (cdr se))

; The painter that draws the outline of the designated frame.
(define outline (segments->painter '((make-segment (make-vect 0 0) (make-vect 1 0))
                                     (make-segment (make-vect 1 0) (make-vect 1 1))
                                     (make-segment (make-vect 1 1) (make-vect 0 1))
                                     (make-segment (make-vect 0 1) (make-vect 0 0)))))
; The painter that draws an “X” by connecting opposite corners of the frame.
(define draw-x (segments->painter '((make-segment (make-vect 0 0) (make-vect 1 1))
                                    (make-segement (make-vect 1 0) (make-vect 0 1)))))
; The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.
(define diamond (segments->painter '((make-segment (make-vect 0.5 0) (make-vect 1 0.5))
                                     (make-segment (make-vect 1 0.5) (make-vect 0.5 1))
                                     (make-segment (make-vect 0.5 1) (make-vect 0 0.5))
                                     (make-segment (make-vect 0 0.5) (make-vect 0.5 0)))))
; The wave painter.