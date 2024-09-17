#lang sicp

; Path -> [Stream [List Word [List-of String]]]
(define (generate-index path)
  (define (mapper input-kv-pair)
    (let ((name (kv-key)))
      (map (lambda (x) (make-kv-pair x name))
           (filter (lambda (x) (>= (count x) N))
                   (kv-value input-kv-pair)))))
  

  (mapreduce mapper cons '() path))

