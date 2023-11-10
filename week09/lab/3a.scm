#lang sicp

(define list1 (list (list 'a) 'b))

(define list2 (list (list 'x) 'y))

(set-cdr! (car list1) (list 'x 'b))

(set-cdr! (car list2) (list 'b))