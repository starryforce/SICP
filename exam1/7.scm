#lang simply-scheme

(require rackunit)

(define (make-time hr mn cat) (list hr mn cat))
(define hour car)
(define minute cadr)
(define category caddr)

(define (time-print-form t)
  (let ((h (hour t))
        (m (if (> (minute t) 9) (minute t) (word 0 (minute t))))
        (c (category t)))
    (word h ":" m c)))

(check-equal? (time-print-form (make-time 3 7 'pm)) "3:07pm")


(define (24-hour t)
  (let ((h (hour t))
        (m (minute t))
        (c (category t)))
    (if (equal? c 'pm)
        (+ (* 100 (+ h 12)) m)
        (+ (* 100 h) m))))
         
(check-equal? (24-hour (make-time 3 47 'pm)) 1547)