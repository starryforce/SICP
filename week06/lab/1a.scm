#lang simply-scheme

((lambda (x) (+ x 3)) 5)
#|
(read)
(eval-1 '((lambda (x) (+ x 3)) 5))
(pair? exp) -> #t
(apply-1 (eval-1 (car exp))
         (map eval-1 (cdr exp)))
(car exp) -> '(lambda (x) (+ x 3))
(cdr exp) -> '(5)
(apply-1 '(lambda (x) (+ x 3)) '(5))
(procedure? ..) -> #f
(lambda-exp? ..) -> #t

proc -> '(lambda (x) (+ x 3))
(eval-1 (substitute (caddr proc)   
		    (cadr proc)    
		    args           
		    '()))

(eval-1 (substitute '(+ x 3)
                    '(x)
                    '(5)
                    '()))
(map (lambda (subexp) (substitute subexp '(x) '(5) '())) '(+ x 3))
  -> (substitute '+ '(x) '(5) '()) -> +
  -> (substitute 'x '(x) '(5) '()) -> 5
  -> (substitute '3 '(x) '(5) '()) -> 3
'(+ 5 3)
(eval-1 '(+ 5 3))
|#