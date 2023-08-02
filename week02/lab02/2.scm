#lang simply-scheme

(require rackunit)

; Sentence Word Word -> Sentence
; replace every old with new in s
(define (substitute s old new)
  (cond ((empty? s) '())
        (else (se (if (equal? (first s) old) new (first s)) 
                  (substitute (bf s) old new)))))

(check-equal? (substitute '(she loves you yeah yeah yeah) 'yeah 'maybe)
              '(she loves you maybe maybe maybe))