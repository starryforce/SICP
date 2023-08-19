#lang simply-scheme

(require rackunit)

; A Section is one of:
; - Symbol
; - Article

; An Article is [List-of Section]

; Article Symbol Symbol -> Article
; return a copy of the li with every occurrence of the old word
; replaced by the new word, even in sublists
(define (substitute li old new)
  (define (mapper s)
    (if (symbol? s)
        (if (equal? s old) new s)
        (substitute s old new)))
  (map mapper li))


(check-equal? (substitute '((lead guitar) (bass guitar) (rhythm guitar) drums) 'guitar 'axe)
              '((lead axe) (bass axe) (rhythm axe) drums))