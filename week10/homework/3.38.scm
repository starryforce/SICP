#lang simply-scheme

#|
(define balance 100)
Peter : (set! balance (+ balance 10))
Paul :  (set! balance (- balance 20))
Mary :  (set! balance (- balance 
                        (/ balance 2)))

Peter Paul Mary 110 90 45
Peter Mary Paul 110 55 35
Paul Peter Mary 80 90 45
Paul Mary Peter 80 40 50
Mary Peter Paul 50 60 40
Mary Paul Peter 50 30 40
|# 