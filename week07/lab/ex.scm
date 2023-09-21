#lang simply-scheme

(require "obj.rkt")

(define-class (person name)
  (method (say stuff) stuff)
  (method (ask stuff) (ask self 'say (se '(would you please) stuff)))
  (method (greet) (ask self 'say (se '(hello my name is) name))) )

(define-class (pigger name)
  (parent (person name))
  (method (pigl wd)
          (if (member? (first wd) '(a e i o u))
              (word wd 'ay)
              (ask self 'pigl (word (bf wd) (first wd))) ))
  (method (say stuff)
          (if (word? stuff)
              (ask self 'pigl stuff)
              (map (lambda (w) (ask self 'pigl w)) stuff))) )