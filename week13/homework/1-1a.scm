#lang sicp

; Path -> [Stream [List Word [List-of String]]]
(define (generate-index path)
  (mapreduce mapper cons '() path))

(define (mapper input-kv-pair)
  (let ((name (kv-key)))
    (map (lambda (x) (make-kv-pair x name))
         (kv-value input-kv-pair))))
  
