#lang simply-scheme

; the difference will appear when both amount & kinds-of-coins are 0
; in the origin procedure, when amount is 0, this call chain will be one way to change
; but in the modified version, if kinds-of-coins is 0, this call chain will be
; considered as wrong answer, and pass through.