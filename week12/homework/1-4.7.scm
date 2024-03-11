#lang sicp

(let* ((x 3)
       (y (+ x 2))
       (z (+ x y 5)))
  (* x z))

(let ((x 3))
  (let* ((y (+ x 2))
         (z (+ x y 5)))
    (* x z)))

(let ((x 3))
  (let ((y (+ x 2)))
    (let ((z (+ x y 5)))
      (* x z))))

(let ((x 3))
  (let ((y 5))
    (let ((z 13))
      (* 3 13))))


#|
we must explicitly expand let* in terms of non-derived expressions
after first transform, let* is in the inner of let, so it will not
be expanded anymore.
|#

; let->combination

(define (let*->nested-lets exp)
  (let ((vars (let-bindings exp))
        (body (let-body exp)))
    (if (null? (cdr vars))
        (make-let vars body)
        (make-let (list (car vars))
                  (let*->nested-lets (make-let* (cdr vars) body))))))

(define (let-bindings exp)
  (cadr exp))
(define (let-body exp)
  (cddr exp))

(define (make-let bindings body)
  (cons 'let (cons bindings body)))

(define (make-let* bindings body)
  (cons 'let* (cons bindings body)))