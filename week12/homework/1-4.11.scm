#lang sicp

(define (make-frame variables values)
  (map (lambda (var val) (cons var val)) variables values))

(define (frame-variables frame) (map car frame))
(define (frame-values frame) (map cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons (cons var val) (car frame))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      ...)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan 
    ...)
  (env-loop env))