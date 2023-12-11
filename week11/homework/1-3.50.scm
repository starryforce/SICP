#lang sicp

(#%require srfi/41)
(#%require rackunit)

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (stream-cons
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc 
                    (map stream-cdr 
                         argstreams))))))

(define ex (stream-map + (stream 1 2 3) (stream 1 2 3)))
(stream-ref ex 0)
(stream-ref ex 1)
(stream-ref ex 2)