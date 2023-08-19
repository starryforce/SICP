#lang simply-scheme


(define (for-each fn l)
  (define (inner l)
    (cond ((null? l) '())
          (else (fn (car l))
                (inner (cdr l)))))
  (inner l)
  #t)
        

(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))