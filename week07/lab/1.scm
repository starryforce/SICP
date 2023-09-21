#lang simply-scheme

(require "obj.rkt")

(define-class (person name)
  (instance-vars (last-say '()))
  (method (say stuff) (set! last-say stuff) stuff)
  (method (ask stuff) (ask self 'say (se '(would you please) stuff)))
  (method (greet) (ask self 'say (se '(hello my name is) name)))
  (method (repeat) (ask self 'say last-say)))