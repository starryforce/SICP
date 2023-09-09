#lang simply-scheme

(require rackunit)

;; Scheme calculator -- evaluate simple expressions

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

; The read-eval-print loop:

(define (calc)
  (display "calc: ")
  (print (calc-eval (read)))
  (calc))

; Evaluate an expression:

(define (calc-eval exp)
  (cond ((number? exp) exp)
        ((symbol? exp) exp)
	((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
	(else (error "Calc: bad expression:" exp))))

; Apply a function to arguments:

(define (calc-apply fn args)
  (cond ((eq? fn '+) (accumulate + 0 args))
	((eq? fn '-) (cond ((null? args) (error "Calc: no args to -"))
			   ((= (length args) 1) (- (car args)))
			   (else (- (car args) (accumulate + 0 (cdr args))))))
	((eq? fn '*) (accumulate * 1 args))
	((eq? fn '/) (cond ((null? args) (error "Calc: no args to /"))
			   ((= (length args) 1) (/ (car args)))
			   (else (/ (car args) (accumulate * 1 (cdr args))))))
        ((eq? fn 'first) (first (car args)))
        ((eq? fn 'butfirst) (butfirst (car args)))
        ((eq? fn 'last) (last (car args)))
        ((eq? fn 'butlast) (butlast (car args)))
        ((eq? fn 'word) (apply word args))
	(else (error "Calc: bad operator:" fn))))