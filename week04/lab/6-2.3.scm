#lang simply-scheme

; A Point is (cons Number Number)

; Number Number -> Point
(define (make-point x y)
  (cons x y))

; Point -> Number
; extract the x coordinate of point p
(define (x-point p)
  (car p))
; Point -> Number
; extract the y coordinate of point p
(define (y-point p)
  (cdr p))

#|
; Point Point -> Rectangle
(define (make-rectangle left-bottom right-top)
  (cons left-bottom right-top))

; Rectangle -> Number
(define (width r)
  (- (x-point (cdr r)) (x-point (car r))))
(define (height r)
  (- (y-point (cdr r)) (y-point (car r))))
|#

; Point Point -> Rectangle
(define (make-rectangle left-top right-bottom)
  (cons left-top right-bottom))
; Rectangle -> Number
(define (width r)
  (- (x-point (cdr r)) (x-point (car r))))
(define (height r)
  (- (y-point (car r)) (y-point (cdr r))))

; Rectangle -> Number
(define (perimeter r)
  (* 2 (+ (width r) (height r))))

; Rectangle -> Number
(define (area r)
  (* (width r) (height r)))

;(define ex (make-rectangle (make-point 0 0) (make-point 10 4)))
(define ex (make-rectangle (make-point 0 4) (make-point 10 0)))