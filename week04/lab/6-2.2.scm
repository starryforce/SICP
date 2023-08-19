#lang simply-scheme

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


; A Segment is (cons Point Point)

; Point Point -> Segment
(define (make-segment start end)
  (cons start end))

; Segment -> Point
; extract start point of segment s
(define (start-segment s)
  (car s))
; Segment -> Point
; extract end point of segment s
(define (end-segment s)
  (cdr s))

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

; Segment -> Point
(define (midpoint-segment s)
  (let ((start (start-segment s))
        (end (end-segment s)))
    (make-point (/ (+ (x-point start) (x-point end)) 2)
                (/ (+ (y-point start) (y-point end)) 2))))

(define ex (make-segment (make-point 0 0) (make-point 4 10)))

(print-point (midpoint-segment ex))