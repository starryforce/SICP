#lang simply-scheme

(require rackunit)

(define (equal? a b)
  (cond ((and (symbol? a) (symbol? b))
         (eq? a b))
        ((and (null? a) (null? b)) #t)
        ((and (list? a) (list? b))
         (and (equal? (car a) (car b))
              (equal? (cdr a) (cdr b))))
        (else #f)))

(check-equal? (equal? '(this is a list)
                      '(this is a list))
              #t)
(check-equal? (equal? '(this is a list) 
                      '(this (is a) list))
              #f)