#lang simply-scheme

(require sicp-pict)

; An Operation is [Painter .] -> Painter

; Operation . -> Operation
(define (split op-main op-small)
  (define (spliter painter n)
    (if (= n 0)
        painter
        (let ((smaller (spliter painter 
                                (- n 1))))
          (op-main painter 
                   (op-small smaller smaller)))))
  spliter)


(define right-split (split beside below))
(define up-split (split below beside))