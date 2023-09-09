#lang simply-scheme

(require rackunit)

(define (square x) (* x x))

(define (square-tree tree)
  (cond ((null? tree) '())
        ((pair? tree) (cons (square-tree (car tree))
                            (square-tree (cdr tree))))
        (else (square tree))))

(check-equal? (square-tree
               (list 1
                     (list 2 (list 3 4) 5)
                     (list 6 7)))
              '(1 (4 (9 16) 25) (36 49)))


; Number | Tree -> Number | Tree
(define (square-tree-map tree)
  (if (number? tree)
      (square tree)
      (map square-tree-map tree)))

(check-equal? (square-tree-map
               (list 1
                     (list 2 (list 3 4) 5)
                     (list 6 7)))
              '(1 (4 (9 16) 25) (36 49)))