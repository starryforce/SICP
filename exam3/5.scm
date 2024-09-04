#lang sicp

(define (subvec-min-index vector start-index) 0)

(define (ssort! vec)
  (let ((len (vector-length vec)))
    (define (loop index)
      (if (= index (- len 1))
          'ok
          (let ((smallest-index (subvec-min-index vec index)))
            (let ((smallest (vector-ref vec smallest-index))
                  (current (vector-ref vec index)))
              (vector-set! vec index smallest)
              (vector-set! vec smallest-index current)))
          (loop (+ index 1))))
    (loop 0)))