#lang simply-scheme

(define (=zero? x) (apply-generic '=zero? x))

; ... install-scheme-number-package ...
(put '=zero? '(scheme-number)
     (lambda (x) (= x 0)))

; ... install-rational-package ...
(put '=zero? '(rational)
     (lambda (x) (and (= (numer x) 0)
                      (not (= (denom x) 0)))))

; ... install-complex-package ...
(put '=zero? '(complex complex)
     (lambda (z) (and (= (real-part z) 0)
                      (= (imag-part z) 0))))
