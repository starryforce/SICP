#lang simply-scheme

(define (make-interval a b)
  (if (and (<= a 0) (>= b 0))
      (error "wrong interval, please check lower and upper")
      (cons a b)))