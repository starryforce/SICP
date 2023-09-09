#lang simply-scheme

(require sicp-pict)

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter 
                                  (- n 1))))
        (beside painter 
                (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter
                               (- n 1))))
        (below painter
               (beside smaller smaller)))))

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


(define right-split-high (split beside below))
(define up-split-high (split below beside))