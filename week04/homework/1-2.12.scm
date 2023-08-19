#lang simply-scheme

(define (make-interval a b) (cons a b))
(define (upper-bound i) (cdr i))
(define (lower-bound i) (car i))

(define (make-center-percent c pt)
  (let ((tolerance (* c pt (/ 1 100))))
    (make-interval (- c tolerance)
                   (+ c tolerance))))

(define (center i)
  (/ (+ (lower-bound i) 
        (upper-bound i)) 
     2))

(define (percent i)
  (let ((c (center i)))
    (* 100 (/ (- (upper-bound i) c)
       c))))
