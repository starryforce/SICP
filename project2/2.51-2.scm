#lang simply-scheme

(require sicp-pict)

(define (below painter1 painter2)
  (rotate90 (beside (rotate270 painter1)
                    (rotate270 painter2))))

(paint (below einstein einstein))