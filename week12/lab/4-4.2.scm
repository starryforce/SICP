#lang sicp

; 1. procedure application will always catch assignments.
;    it will never go into assignments clause.

; 2.
(define (application? exp)
  (tagged-list? exp 'call))

(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))