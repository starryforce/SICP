#lang simply-scheme

(require rackunit)


; [List-of Any] -> [List-of Any]
; returns a list of the same elements in reverse order
(define (reverse l0)
  ; [List-of Any] ??? -> [List-of Any]
  ; accumulator all items in l0 that not in l in reverse order
  (define (reverse-iter l a)
    (cond ((empty? l) a)
          (else (reverse-iter (cdr l) (cons (car l) a)))))
  (reverse-iter l0 '()))


(check-equal? (reverse (list 1 4 9 16 25))
              '(25 16 9 4 1))