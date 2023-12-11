#lang sicp

(#%require srfi/41)

(define ones (stream-cons 1 ones))