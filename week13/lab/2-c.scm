#lang sicp

; gutenberg-wordcounts
; [Stream [List-of [Pair Word Number]]]
; example: ((the . 300) (was . 249) (thee . 132) ... )

(define result (stream-filter (lambda (item) (= (kv-value item0 1))) gutenberg-wordcounts))