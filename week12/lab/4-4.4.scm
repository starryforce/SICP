#lang sicp

(define TRUE #t)
(define FALSE #f)

; eval
(cond ....
      ((and? exp)
       (eval-and exp env))
      ((or? exp)
       (eval-or exp env)))

; predicate
(define (and? exp)
  (tagged-list? exp 'and))
(define (or? exp)
  (tagged-list? exp 'or))

(define (and-items exp)
  (cdr exp))
(define (or-items exp)
  (cdr exp))

(define (no-items? items)
  (null? items))

; implement
(define (eval-and exp env)
  (if (no-items? exp)
      TRUE
      (apply and (and-items exp))))
(define (eval-or exp env)
  (if (no-items? exp)
      FALSE
      (apply or (or-items exp))))