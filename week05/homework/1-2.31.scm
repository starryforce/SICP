#lang simply-scheme

(require rackunit)

(define (square x) (* x x))

(define (tree-map fn tree)
  (cond ((null? tree) '())
        ((pair? tree) (cons (square-tree (car tree))
                            (square-tree (cdr tree))))
        (else (tree-map fn tree))))

(define (square-tree tree) 
  (tree-map square tree))

(check-equal? (square-tree
               (list 1
                     (list 2 (list 3 4) 5)
                     (list 6 7)))
              '(1 (4 (9 16) 25) (36 49)))

(define (tree-map-1 fn tree)
  (map (lambda (x) (if (number? x)
                       (fn x)
                       (tree-map-1 fn x)))
       tree))

(define (square-tree-map tree)
  (tree-map-1 square tree))

(check-equal? (square-tree-map
               (list 1
                     (list 2 (list 3 4) 5)
                     (list 6 7)))
              '(1 (4 (9 16) 25) (36 49)))