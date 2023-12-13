#lang sicp

(#%require srfi/41)

; Without running the program, describe the elements of the stream defined by

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define s (stream-cons 1 (add-streams s s)))

; the first element is 1,
; the rest of stream is itself plus itself
; the second element is 1 + 1 = 2
; the third element is 

; 1 2 4 8 16