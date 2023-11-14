#lang sicp

(define (count-pairs x0)
  (let ((l '()))
    (define (loop x)
      (if (not (pair? x))
          0
          (if (memq x l)
              0
              (begin
                (set! l (cons x l))
                (+ (loop (car x))
                   (loop (cdr x))
                   1)))))
    (loop x0)))

(define w3 (list 1 2 3))

(define w4 (list 1 2 3))
(set-car! (cdr w4) (cddr w4))

(define w71 (cons 1 2))
(define w72 (cons w71 w71))
(define w7 (cons w72 w72))

(define loop (list 1 2 3))
(set-cdr! (cddr loop) loop)

(count-pairs w3)
(count-pairs w4)
(count-pairs w7)
(count-pairs loop)