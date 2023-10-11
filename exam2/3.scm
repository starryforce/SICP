#lang simply-scheme

(define (make-segment start end)
  (tag 'segment (cons start end)))
(define (start-segment se)
  (car (content  se)))
(define (end-segment se)
  (cdr (content se)))


(define (midpoint obj)
  (let ((type (type-tag obj)))
    (cond ((eq? type 'segment)
           (scale-vect 0.5
                       (add-vect (start-segment obj)
                                 (end-segment obj)))
           ((eq? type 'frame)
            (add-vect (origin-frame obj)
                      (scale-vect 0.5
                                  (add-vect (edge1-frame obj)
                                            (edge2-frame obj)))))
           (else #f)))))