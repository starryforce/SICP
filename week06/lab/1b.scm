#lang simply-scheme

((lambda (f n)    ; this lambda is defining MAP
   ((lambda (map) (map map f n))
    (lambda (map f n)
      (if (null? n)
          '()
          (cons (f (car n)) (map map f (cdr n)))))))
 first            ; here are the arguments to MAP
 '(the rain in spain))


((lambda (g n0)
   ((lambda (filter) (filter filter g n0))
    (lambda (filter g n)
      (if (null? n)
          '()
          (if (g (car n))
              (cons (car n) (filter filter g (cdr n)))
              (filter filter g (cdr n)))))))
 (lambda (x) (> (string-length (symbol->string x)) 3))
 '(the rain in spain))