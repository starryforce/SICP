#lang sicp

(define (eval exp env)
  (cond ((self-evaluating? exp) 
         exp)
        ((variable? exp) 
         (lookup-variable-value exp env))
        ((quoted? exp) 
         (text-of-quotation exp))
        ((assignment? exp) 
         (eval-assignment exp env))
        ((definition? exp) 
         (eval-definition exp env))
        ((if? exp) 
         (eval-if exp env))
        ((lambda? exp)
         (make-procedure 
          (lambda-parameters exp)
          (lambda-body exp)
          env))
        ((begin? exp)
         (eval-sequence 
          (begin-actions exp) 
          env))
        ((cond? exp) 
         (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values 
                 (operands exp) 
                 env)))
        (else
         (error "Unknown expression 
                 type: EVAL" exp))))

(put 'eval 'set! eval-assignment)
(put 'eval 'define eval-definition)
(put 'eval 'if eval-if)
(put 'eval 'lambda eval-lambda)
(put 'eval 'begin? eval-begin)
(put 'eval 'cond eval-cond)
(put 'eval 'quote eval-quote)

(define (eval-quote exp env)
  (text-of-quotation exp))
(define (eval-lambda exp env)
  ((make-procedure 
    (lambda-parameters exp)
    (lambda-body exp)
    env)))
(define (eval-begin exp env)
  (eval-sequence 
   (begin-actions exp) 
   env))
(define (eval-cond exp env)
  (eval (cond->if exp) env))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) 
         (lookup-variable-value exp env))
        (else (let ((method (get 'eval (car exp))))
          (cond (method (method exp env))
                ((application? exp)
                 (apply (eval (operator exp) env)
                        (list-of-values 
                         (operands exp) 
                         env)))
                (else
                 (error "Unknown expression 
                 type: EVAL" exp)))))))
