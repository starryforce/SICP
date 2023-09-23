#lang simply-scheme

(require rackunit)

(define (make-tree a b)
  (cons a b))
(define datum car)
(define children cdr)

(define ex (make-tree 5
                      (list (make-tree 7 (list (make-tree 1 '())
                                               (make-tree 3 '())))
                            (make-tree 2 (list (make-tree 9 '())
                                               (make-tree 5 (list (make-tree 3 '())
                                                                  (make-tree 1 '()))))))))

(define (biggest l)
  (apply max l))

; Tree -> Number
(define (maxpath t)
  (cond ((null? (children t)) (datum t))
        (else (+ (datum t) (biggest (map maxpath (children t)))))))

(check-equal? (maxpath ex) 16)