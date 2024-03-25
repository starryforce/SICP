#lang sicp

; 1:  (1 2 3)

; 2:  ((3) 2 3)

; 3:  error -> (set-car! (cdr x) (cdr x))

; 4:  (1 . (2 . (3 . 2)))
; right: (1 2 3 . 2)

#|
(let ((x (list 1 2 3)))
  (set-cdr! (cdr x) (cddr x))
  x)

(let ((x (list 1 2 3)))
  (set-car! x (cddr x))
  x)

(let ((x (list 1 2 3)))
  (set-car! (cdr x) (cdr x))
  x)
; (1 . #0=(#0# 3)) ???

(let ((x (list 1 2 3 4)))
  (set-cdr! (cddr x) (cadr x))
  x)
|#