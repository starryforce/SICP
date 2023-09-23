#lang simply-scheme

(require rackunit)

(define (make-tree a b)
  (cons a b))
(define (datum t) (car t))
(define (children t) (cdr t))

(define ex (make-tree 5
                      (list (make-tree 7 '(1 3))
                            (make-tree 2 (list 9
                                               (make-tree 5 '(3 1)))))))

(define (biggest l)
  (apply max l))

; Tree -> Number
(define (maxpath t)
  (cond ((null? (children t)) (datum t))
        (else (+ (datum t) (maxpath-l (children t))))))

; [List-of Tree] -> Number
(define (maxpath-l alot)
  (cond ((null? alot) 0)
        (else (biggest (map (lambda (x) (if (number? x) x (maxpath x))) alot)))))

(check-equal? (maxpath ex) 16)
(check-equal? (maxpath (make-tree 5 '(3 1))) 8)

(check-equal? (maxpath-l '(3 1)) 3)