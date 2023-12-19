#lang sicp

(#%require srfi/41)
(#%require rackunit)
(#%require "util.scm")

; [List Non-number Non-number] 
(define (fract-stream nd)
  (let ((numerator (car nd))
        (denominator (cadr nd)))
    (stream-cons (quotient (* numerator 10) denominator)
                 (fract-stream (list (remainder (* numerator  10) denominator) denominator)))))

(check-equal? (stream-car (fract-stream '(1 7))) 1)
(check-equal? (stream-car (stream-cdr (stream-cdr (fract-stream '(1 7))))) 2)

(define (approximation s numdigits)
  (if (= numdigits 0)
      '()
      (cons (stream-car s)
            (approximation (stream-cdr s) (- numdigits 1)))))

(check-equal? (approximation (fract-stream '(1 7)) 4) '(1 4 2 8))
(check-equal? (approximation (fract-stream '(1 2)) 4) '(5 0 0 0))