#lang simply-scheme

((lambda (f n)    ; this lambda is defining MAP
   ((lambda (map) (map map f n))
    (lambda (map f n)
      (if (null? n)
          '()
          (cons (f (car n)) (map map f (cdr n)))))))
 first            ; here are the arguments to MAP
 '(the rain in spain))


((lambda (pred? seq0)
   ((lambda (filter) (filter filter pred? seq0))
    (lambda (filter pred? seq)
      (if (null? seq)
          '()
          (if (pred? (car seq))
              (cons (car seq) (filter filter pred? (cdr seq)))
              (filter filter pred? (cdr seq)))))))
 (lambda (x) (> (string-length (symbol->string x)) 3))
 '(the rain in spain))