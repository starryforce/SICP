#lang sicp


; -> [Stream [List-of [Pair Word Number]]]
(define gutenberg-wordcounts (mapreduce mapper + "/gutenberg"))

; [Pair String [List-of Word]] -> [List-of [Pair Word 1]]
(define (mapper input-key-value-pair)
  (map (lambda (word) (make-kv-pair word 1))
       (kv-value input-key-value-pair)))

