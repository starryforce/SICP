#lang simply-scheme

(define ex1 '(1 3 (5 7) 9))
(car (cdr (car (cdr (cdr ex1)))))

(define ex2 '((7)))
(car (car ex2))

(define ex3 '(1 (2 (3 (4 (5 (6 7)))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr ex3))))))))))))