#lang sicp

; gutenberg-wordcounts
; [Stream [List-of [Pair Word Number]]]
; example: ((the . 300) (was . 249) (thee . 132) ... )

(define result (stream-fold (lambda (prev cur) (if (< (kv-value prev) (kv-value cur))
                                                   cur
                                                   prev))
                            (make-kv-pair 'fool 0)
                            gutenberg-wordcounts))