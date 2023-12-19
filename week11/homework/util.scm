#lang simply-scheme

(require srfi/41)

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define ones (stream-cons 1 ones))

(define integers 
  (stream-cons 1 (add-streams ones integers)))

(define (show-stream s n)
  (if (= n 0)
      'done
      (begin (display (stream-car s))
             (newline)
             (show-stream (stream-cdr s) (- n 1)))))

(define ss show-stream)

(provide show-stream ss)