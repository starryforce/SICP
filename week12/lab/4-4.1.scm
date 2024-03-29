#lang sicp

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((cur (eval (first-operand exps) env)))
        (cons cur
              (list-of-values 
               (rest-operands exps) 
               env)))))

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((rest (list-of-values 
                   (rest-operands exps) 
                   env)))
        (cons (eval (first-operand exps) env)
              rest))))