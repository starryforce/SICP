#lang simply-scheme

(require "obj.rkt")

(define-class (random-generator max)
  (instance-vars (count 0))
  (method (number) (set! count (+ count 1)) (random max)))