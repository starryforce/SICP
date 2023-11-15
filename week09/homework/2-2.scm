#lang simply-scheme

(require rackunit)

; [Any -> Boolean] Vector -> Vector
; Vector version filter
(define (vector-filter pred? v)
  (define (loop n nv)
    (if (< n 0)
        nv
        (let ((item (vector-ref v n)))
          (if (pred? item)
              (let ((next (make-vector (+ (vector-length nv) 1))))
                (copy! next nv)
                (vector-set! next 0 item)
                (loop (- n 1) next) )
              (loop (- n 1) nv)))))
  (loop (- (vector-length v) 1) (vector)))

; Vector Vector -> Null
(define (copy! target source)
  (define (loop n)
    (cond ((>= n 0) (vector-set! target (+ n 1) (vector-ref source n))
                    (loop (- n 1)))))
  (loop (- (vector-length source) 1)))
  
(check-equal? (vector-filter even? (vector 1 2 3 4 5 6 7 8)) (vector 2 4 6 8))

(define (vector-filter-trans pred vec)
  (list->vector (filter pred (vector->list vec))))