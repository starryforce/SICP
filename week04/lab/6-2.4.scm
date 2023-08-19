#lang simply-scheme

; X Y -> [M -> (M X Y)]
(define (cons x y) 
  (lambda (m) (m x y)))

; [M -> (M X Y)]
(define (car z) 
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

(car (cons 1 2))
(cdr (cons 1 2))