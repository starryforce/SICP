#lang simply-scheme

(require "obj.rkt")

(define-class (person name)
  (method (say stuff) stuff)
  (method (ask stuff) (ask self 'say (se '(would you please) stuff)))
  (method (greet) (ask self 'say (se '(hello my name is) name))) )

(define p1 (instantiate person "Juice"))

(define-class (miss-manners obj)
  (method (please message arg)
          (ask obj message arg)))

(define m1 (instantiate miss-manners p1))