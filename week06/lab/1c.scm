#lang simply-scheme

(map first '(the rain in spain))
; '(t r i s)

'(map first '(the rain in spain))
(apply-1 (eval-1 'map)
         (map eval-1 '(first '(the rain in spain))))
(apply-1 map
         (list (eval-1 'first)
               (eval-1 ''(the rain in spain))))
(apply-1 map
         (list first '(the rain in spain)))
(apply map (list first '(the rain in spain)))
(map first '(the rain in spain))

(map (lambda (x) (first x)) '(the rain in spain))
; map: contract violation
;  expected: procedure?
;  given: '(lambda (x) (first x))

'(map (lambda (x) (first x)) '(the rain in spain))

(apply-1 (eval-1 'map)
         (map eval-1 '((lambda (x) (first x)) '(the rain in spain))))
(apply-1 map
         (list (eval-1 '(lambda (x) (first x)))
               (eval-1 ''(the rain in spain))))
(apply-1 map
         (list '(lambda (x) (first x))
               '(the rain in spain)))
(apply map (list '(lambda (x) (first x))
                 '(the rain in spain)))

(map '(lambda (x) (first x)) '(the rain in spain))

; '(lambda (x) (first x)) is still an expression, not a value