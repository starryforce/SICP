#lang sicp

#|
Evaluation of the expression
(stream-cdr (stream-cdr (cons-stream 1 '(2 3))))
produces an error. Why?
|#

; only one cons-stream used