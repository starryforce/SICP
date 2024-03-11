#lang sicp

#|
(let ((⟨var₁⟩ ⟨exp₁⟩) … (⟨varₙ⟩ ⟨expₙ⟩))
  ⟨body⟩)
--------->
((lambda (⟨var₁⟩ … ⟨varₙ⟩)
   ⟨body⟩)
 ⟨exp₁⟩
 …
 ⟨expₙ⟩)
|#

(define (let->combination exp)
  (cons (make-lambda (let-formals exp) (let-body exp))
        (let-actuals exp)))


...
((let? exp)
 (eval (let->combination exp) env))
...

(define (let? exp)
  (tagged-list? exp 'let))

(define (let-formals exp)
  (map car (cadr exp)))
(define (let-actuals exp)
  (map cadr (cadr exp)))
(define (let-body exp)
  (cddr exp))
