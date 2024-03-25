#lang sicp

(#%require rackunit)

(define a (list 'x))
(define b (list 'x))
(define c (cons a b))
(define d (cons a b))

(check-equal? (eq? a b) #f)

(check-equal? (eq? (car a) (car b)) #t)

(check-equal? (eq? (cdr a) (cdr b)) #t)
; '() == '()

(check-equal? (eq? c d) #f)

(check-equal? (eq? (cdr c) (cdr d)) #t)
; the same b

(define p a)
(set-car! p 'squeegee)

(check-equal? (eq? p a) #t)

(define q a)
(set-cdr! a q)
(check-equal? (eq? q a) #t)

(define r a)
(set! r 'squeegee)
(check-equal? (eq? r a) #f)
; obviously seperate from a 