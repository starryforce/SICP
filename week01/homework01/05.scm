#lang simply-scheme

(require rackunit)

#| 5.
Write a procedure ends-e that takes a sentence as its argument and returns a sentence
containing only those words of the argument whose last letter is E:
|#

; Sentence -> Sentence
; returns a sentence
; containing only those words of the argument whose last letter is E
(define (ends-e alos)
  (cond ((empty? alos) '())
        (else (if (equal? (last (first alos)) 'e)
                  (se (first alos) (ends-e (bf alos)))
                  (ends-e (bf alos))))))

(check-equal? (ends-e '(please put the salami above the blue elephant))
              '(please the above the blue))