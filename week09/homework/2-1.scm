#lang simply-scheme

(require rackunit)

(define ex1 (vector 1 2 3))
(define ex2 (vector 4 5 6))

; Vector Vector -> Vector
; append v1 onto v2
(define (vector-append v1 v2)
  (define newvec (make-vector (+ (vector-length v1)
                                 (vector-length v2))))
  (define (loop v n nIndex)
    (cond ((>= n 0)  (vector-set! newvec nIndex (vector-ref v n))
                     (loop v (- n 1) (- nIndex 1)))))
  (loop v1 (- (vector-length v1) 1) (- (vector-length v1) 1))
  (loop v2 (- (vector-length v2) 1) (- (vector-length newvec) 1))
  newvec)

(check-equal? (vector-append ex1 ex2) (vector 1 2 3 4 5 6))