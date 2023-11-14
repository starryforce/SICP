#lang simply-scheme

(require rackunit)
(require r5rs)

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

(check-equal? (lookup (list 'c) table1) 3)
(check-equal? (lookup (list 'letters 'b) table2) 98)
(check-equal? (lookup (list 'math 'l 'b) table3) 2)
(check-equal? (lookup (list 'letters 'l 'b) table3) #f)

; [List-of Symbol] Any List -> Null
(define (insert! keys value table)
  (cond ((empty? (cdr keys))
         (let ((record (assoc (car keys) (cdr table))))
           (if record
               (set-cdr! record value)
               (set-cdr! table (cons (cons (car keys) value) (cdr table))))))
        (else
         (let ((subtable (assoc (car keys) (cdr table))))
           (if subtable
               (insert! (cdr keys) value subtable)
               (begin (set-cdr! table (cons (cons (car keys) '()) (cdr table)))
                      (insert! keys value table)))))))

(insert! (list 'z) 9 table1)
(check-equal? table1
              (list '*table*
                    (cons 'z 9)
                    (cons 'a 1)
                    (cons 'b 2)
                    (cons 'c 3)))

(insert! (list 'letters 'z) 96 table2)
(check-equal? table2
              (list '*table*
                    (list 'math
                          (cons '+ 43)
                          (cons '- 45)
                          (cons '* 42))
                    (list 'letters
                          (cons 'z 96)
                          (cons 'a 97)
                          (cons 'b 98))))


(insert! (list 'maps 'para) 100 table2)
