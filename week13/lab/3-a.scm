#lang sicp

; String String -> Boolean
(define (match? pattern sentence) ...)


; Pattern Directory -> [Stream [Pair String String]]
(define (search pattern dir)
  (mapreduce (lambda (item) (if (match? pattern (kv-value item))
                                (list item)
                                '()))
             cons
             '()
             "/gutenberg/shakespeare"))
