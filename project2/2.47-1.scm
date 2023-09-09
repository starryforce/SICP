#lang simply-scheme

(require rackunit)

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (caddr frame))

(define ex (make-frame 1 2 3))
(check-equal? (origin-frame ex) 1)
(check-equal? (edge1-frame ex) 2)
(check-equal? (edge2-frame ex) 3)