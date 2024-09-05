#lang sicp

(mapreduce (lambda (input-key-value-pair)
             (list (make-kv-pair (kv-key input-key-value-pair 1)))
             +
             0
             "/gutenberg/shakespeare"))

(stream-fold (lambda (count item) (+ count (kv-value item)))
             0
             (get-last-mapreduce-output))