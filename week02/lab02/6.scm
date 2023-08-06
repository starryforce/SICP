#lang simply-scheme

(require rackunit)

; Word -> [Any -> Boolean]
; return returns a procedure of one argument x that
; returns true if x is equal to w and false otherwise
(define (make-tester w)
  (lambda (x) (equal? w x)))



(check-equal? ((make-tester 'hal) 'hal) #t)
(check-equal? ((make-tester 'hal) 'cs61a) #f)

(define sicp-author-and-astronomer? (make-tester 'gerry))

(check-equal? (sicp-author-and-astronomer? 'hal) #f)
(check-equal? (sicp-author-and-astronomer? 'gerry) #t)