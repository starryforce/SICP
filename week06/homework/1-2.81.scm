#lang simply-scheme

; Q1
; x -> scheme-number
; y -> scheme-number
(apply-generic 'not-exist x y)

(get 'not-exist '(scheme-number scheme-number))

(apply-generic 'not-exist x y)
; A1 infinate loop


; Q2
; if the procedure doesn't exist,
; it will still try coercion to another data type

; Q3
; (if (not (equal type1 type2)))