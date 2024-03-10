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
  ((make-lambda (map car (cadr exp)) (cddr exp))
   (map cadr (cadr exp))))


...
((let? exp)
 (eval (let->combination exp) env))
...

(define (let? exp)
  (tagged-list? exp 'let))