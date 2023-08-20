#lang simply-scheme


(define (for-each fn l)
  (cond ((null? l) #t)
        (else (fn (car l))
              (for-each fn (cdr l)))))
        

(for-each 
 (lambda (x) (newline) (display x))
 (list 57 321 88))