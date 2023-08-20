#lang simply-scheme
(require rackunit)

; Word -> Boolean
(define (vowel? letter)
  (member? letter '(a e i o u)))

(define (syllables w)
  (cond ((empty? w) 0)
        ((and (vowel? (first w)) (or (empty? (bf w)) (not (vowel? (first (bf w))))))
         (+ 1 (syllables (bf w))))
        (else (syllables (bf w)))))

(check-equal? (syllables 'banana) 3)
(check-equal? (syllables 'aardvark) 2)
(check-equal? (syllables 'cloud) 1)

