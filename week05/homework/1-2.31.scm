#lang simply-scheme

(require rackunit)

(define (square x) (* x x))

(define (tree-map fn tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (fn tree))
        (else (cons (tree-map fn (car tree))
                    (tree-map fn (cdr tree))))))

(define (square-tree tree) 
  (tree-map square tree))

(check-equal? (square-tree
               (list 1
                     (list 2 (list 3 4) 5)
                     (list 6 7)))
              '(1 (4 (9 16) 25) (36 49)))

(define (tree-map-1 fn tree)
  (if (not (pair? tree))
      (fn tree)
      (map (lambda (sub) (tree-map-1 fn sub)) tree)))

(define (square-tree-map tree)
  (tree-map-1 square tree))

(check-equal? (square-tree-map
               (list 1
                     (list 2 (list 3 4) 5)
                     (list 6 7)))
              '(1 (4 (9 16) 25) (36 49)))