#lang simply-scheme

(require r5rs)

; Explain why memo-fib computes the nth Fibonacci number in a number of steps proportional to n.
; for every n, it will use previous result to calculate the result, so every n cost constant time.


; Would the scheme still work if we had simply defined memo-fib to be (memoize fib)?
; no, the recursive call will be incorrect