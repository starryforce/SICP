#lang simply-scheme

(require "obj.rkt")

(define-class (person name)
  (instance-vars (last-say '()))
  (method (say stuff) (set! last-say stuff) stuff)
  (method (ask stuff) (ask self 'say (se '(would you please) stuff)))
  (method (greet) (ask self 'say (se '(hello my name is) name)))
  (method (repeat) last-say))

; (ask mike 'say '(the sky is falling))

(define-class (double-talker1 name)
  (parent (person name))
  (method (say stuff) (se (usual 'say stuff) (ask self 'repeat))) )
; repeat just say single setence
(define-class (double-talker2 name)
  (parent (person name))
  (method (say stuff) (se stuff stuff)) )
; '(the sky is falling the sky is falling)
(define-class (double-talker3 name)
  (parent (person name))
  (method (say stuff) (usual 'say (se stuff stuff))) )
; '(the sky is falling the sky is falling)


; (define mike (instantiate double-talker 'mike))
; (ask mike 'say '(the sky is falling))
; the sencond & third's repeat behavior differently