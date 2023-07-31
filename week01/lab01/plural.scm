#lang simply-scheme

(define (plural wd)
  (cond ((equal? (last wd) 'y) (if (vowel? (last (bl wd)))
                                   (word wd 's)
                                   (word (bl wd) 'ies)))
        (else (word wd 's))))


(define (vowel? letter)
  (member? letter '(a e i o u)))