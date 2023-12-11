#lang sicp
(#%require srfi/41)

#|
Evaluation of the expression
(stream-cdr (stream-cdr (cons-stream 1 '(2 3))))
produces an error. Why?
|#

(stream-cons 1 '(2 3))
(stream-car (stream-cons 1 '(2 3)))
(stream-cdr (stream-cons 1 '(2 3)))
