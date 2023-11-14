#lang simply-scheme

(require rackunit)

(define table1 (list '*table*
                     (cons 'a 1)
                     (cons 'b 2)
                     (cons 'c 3)))

(define table2 (list '*table*
                     (list 'math
                           (cons '+ 43)
                           (cons '- 45)
                           (cons '* 42))
                     (list 'letters
                           (cons 'a 97)
                           (cons 'b 98))))
(define table3 (list '*table*
                     (list 'math
                           (cons '+ 43)
                           (cons '- 45)
                           (cons '* 42)
                           (list 'l 
                                 (cons 'a 1)
                                 (cons 'b 2)
                                 (cons 'c 3)))
                     (list 'letters
                           (cons 'a 97)
                           (cons 'b 98))))

; A Table is
; (list Symbol [List-of (list Symbol [Table|Any])])
                     
; [List-of Symbol] List -> Any / #f
(define (lookup keys table)
  (cond ((empty? (cdr keys))
         (let ((record (assoc (car keys) (cdr table))))
           (if record
               (cdr record)
               #f)))
        (else (let ((subtable (assoc (car keys) (cdr table))))
                (if subtable
                    (lookup (cdr keys) subtable)
                    #f)))))

(check-equal? (lookup (list 'letters 'b) table2) 98)
(check-equal? (lookup (list 'math 'l 'b) table3) 2)
(check-equal? (lookup (list 'letters 'l 'b) table3) #f)

; [List-of Symbol] Any List -> Null
(define (insert! keys value table)
  0)



