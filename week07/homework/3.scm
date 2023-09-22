#lang simply-scheme

(require "obj.rkt")

(define-class (deck cards)
  (method (deal)
          (if (null? cards)
              '()
              (let ((current (car cards)))
                (set! cards (cdr cards))
                current)))
  (method (empty?)
          (null? cards)))

