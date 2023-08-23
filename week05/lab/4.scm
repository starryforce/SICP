#lang simply-scheme

(define (mystery7 L1 L2)
  (cons L1 (append L2 L1)))

(define (mystery1 L1 L2) 
  (list L1 (list L1 L1)))

(define (mystery0 L1 L2) 
  (append (cons L2 L2) L1))

; mystery 7
; (cons L1 (append L2 L1))

; mystery 1
; (list L1 (list L1 L1))

; mystery 0
; (cons L2 (append L2 L1))
; '((4 5 6) 4 5 6 1 2 3)

