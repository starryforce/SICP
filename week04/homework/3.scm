#lang simply-scheme

(require rackunit)

; A Section is one of:
; - Symbol
; - Number
; - Article

; An Article is [List-of Section]

; Symbol [List-of Any] [List-of Any] -> Word
(define (replace w aloo alon)
  (cond ((null? aloo) w)
        (else (if (equal? w (car aloo))
                  (car alon)
                  (replace w (cdr aloo) (cdr alon))))))
  

; Article [List-of Any] [List-of Any] -> Article
; return a copy of the li with every occurrence of the old word
; replaced by the new word, even in sublists
(define (substitute2 li old new)
  (define (mapper s)
    (if (or (symbol? s) (number? s))
        (replace s old new)
        (substitute2 s old new)))
  (map mapper li))



(check-equal? (substitute2 '((4 calling birds) (3 french hens) (2 turtle doves))
                           '(1 2 3 4) '(one two three four))
              '((four calling birds) (three french hens) (two turtle doves)))