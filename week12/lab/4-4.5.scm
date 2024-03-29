#lang sicp

#|
(cond ((assoc 'b '((a 1) (b 2))) => cadr)
      (else false))
|#

(define (cond? exp) 
  (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
;;
(define (clause-additional? clause) (eq? '=> (cadr clause)))
(define (cond-predicate-additional clause)
  (car clause))
(define (cond-actions-additional clause)
  (caddr clause))
;;
(define (cond-predicate clause) 
  (car clause))
(define (cond-actions clause) 
  (cdr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false     ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp 
                 (cond-actions first))
                (error "ELSE clause isn't 
                        last: COND->IF"
                       clauses))
            (if (clause-additional? first)
                (make-if (cond-predicate-additional first)
                         ((cond-actions-additional first) (cond-predicate-additional first))
                         (expand-clauses 
                          rest))
                (make-if (cond-predicate first)
                         (sequence->exp 
                          (cond-actions first))
                         (expand-clauses 
                          rest)))))))