#lang simply-scheme


(define (make-vect x y)
  (cons x y))
; A Vector is a Pair:
; (make-vect Number Number)
; interpretation represents a vector

(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))


; Vector Vector -> Vector
; (x1,y1)+(x2,y2) = (x1+x2,y1+y2)
(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2)) 
             (+ (ycor-vect v1) (ycor-vect v2))))

; Vector Vector -> Vector
; (x1,y1)-(x2,y2) = (x1-x2,y1-y2)
(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2)) 
             (- (ycor-vect v1) (ycor-vect v2))))

; Vector Number -> Vector
; s⋅(x,y) = (sx,sy)
(define (scale-vect v scalar)
  (make-vect (* scalar (xcor-vect v)) (* scalar (xcor-vect v))))

