#lang simply-scheme

(define f
  (let ((tmp 0))
    (lambda (n)
      (set! tmp (+ tmp n))
      (- tmp 1))))