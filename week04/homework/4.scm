#lang simply-scheme

(require rackunit)

; Word -> [Pair -> Any]
(define (cxr-function w)
  (define (helper w)
    (cond ((empty? w) (lambda (x) x))
          ((equal? (first w) 'a) (lambda (x) (car ((helper (bf w)) x))))
          (else (lambda (x) (cdr ((helper (bf w)) x))))))
  (helper (bf (bl w))))


(define ex (cons (cons (cons 0 1) 2) 3))
(check-equal? ((cxr-function 'cdar) ex) 2)
(check-equal? ((cxr-function 'cdaar) ex) 1)