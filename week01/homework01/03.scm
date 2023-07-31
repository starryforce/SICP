#lang simply-scheme

(require rackunit)

#| 3.
Write a procedure switch that takes a sentence as its argument and returns a sentence
in which every instance of the words I or me is replaced by you, while every instance of
you is replaced by me except at the beginning of the sentence, where it’s replaced by I.
(Don’t worry about capitalization of letters.) Example:
|#

; Word -> Word
(define (replace w)
  (cond ((equal? w 'I) 'you)
        ((equal? w 'me) 'you)
        ((equal? w 'you) 'me)
        (else w)))

; Sentence -> Sentence
; switch I or me & you in s
(define (switch-recur s)
  (cond ((empty? s) '())
        (else (se (replace (first s))
                  (switch-recur (bf s)) ))))

(define (switch s)
  (se (if (equal? (first s) 'you) 'i (replace (first s)))
      (switch-recur (bf s))))

(check-equal? (switch '(you told me that I should wake you up))
              '(i told you that you should wake me up))