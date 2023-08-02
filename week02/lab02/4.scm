#lang simply-scheme

(define f1 2)
f1 ; 2

(define f2 (lambda () 3))
(f2) ; 3

(define f3 (lambda (x) (+ x 1)))
(f3 3)  ;4

(define f4 (lambda () (lambda () 5)))
((f4)) ;5

(define f5 (lambda () (lambda () (lambda (x) (+ x 3)))))
(((f5)) 3) ;6