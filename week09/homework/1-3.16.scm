#lang sicp

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define w3 (list 1 2 3))

(define w4 (list 1 2 3))
(set-car! (cdr w4) (cddr w4))

(define w71 (cons 1 2))
(define w72 (cons w71 w71))
(define w7 (cons w72 w72))

(define loop (list 1 2 3))
(set-cdr! (cddr loop) loop)