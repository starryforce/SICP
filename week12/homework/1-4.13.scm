#lang sicp

(define (remove-binding-from-frame! var frame)
  (define (loop pairs)
    (let ((var1 (caar pairs))
          (val1 (cadr pairs)))
      (if (eq? var var1)
          (begin (set-car! pairs (cdar pairs))
                 (set-cdr! pairs (cddr pairs)))
          (loop (cons (cdar pairs) (cddr pairs)))))))
          
          
    ...)
  (loop frame))
  

(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (remove-binding-from-frame! var frame)))