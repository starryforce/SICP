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

; Peter-get Peter-set Paul-get Paul-set Mary-get Mary-set
#|

Peter-get
Peter-get Peter-set
Peter-get Peter-set Paul-get
Peter-get Peter-set Paul-get Paul-set
Peter-get Peter-set Paul-get Paul-set Mary-get Mary-set
Peter-get Peter-set Paul-get Mary-get
Peter-get Peter-set Paul-get Mary-get Paul-set Mary-set 
Peter-get Peter-set Paul-get Mary-get Mary-set Paul-set
Peter-get Peter-set Mary-get
Peter-get Peter-set Mary-get Mary-set
Peter-get Peter-set Mary-get Mary-set Paul-get Paul-set
Peter-get Peter-set Mary-get Paul-get
Peter-get Peter-set Mary-get Paul-get Mary-set Paul-set
Peter-get Peter-set Mary-get Paul-get Paul-set Mary-set

Peter-get Paul-get
Peter-get Paul-get Peter-set
Peter-get Paul-get Peter-set Paul-set
Peter-get Paul-get Peter-set Paul-set Mary-get Mary-set
Peter-get Paul-get Peter-set Mary-get
Peter-get Paul-get Peter-set Mary-get Paul-set Mary-set
Peter-get Paul-get Peter-set Mary-get Mary-set Paul-set 

Peter-get Paul-get Paul-set
Peter-get Paul-get Paul-set Peter-set
Peter-get Paul-get Paul-set Peter-set Mary-get Mary-set
Peter-get Paul-get Paul-set Mary-get
Peter-get Paul-get Paul-set Mary-get Peter-set Mary-set
Peter-get Paul-get Paul-set Mary-get Mary-set Peter-set

Peter-get Paul-get Mary-get
Peter-get Paul-get Mary-get Peter-set
Peter-get Paul-get Mary-get Peter-set Paul-set Mary-set
Peter-get Paul-get Mary-get Peter-set Mary-set Paul-set
Peter-get Paul-get Mary-get Paul-set
Peter-get Paul-get Mary-get Paul-set Mary-set Peter-set
Peter-get Paul-get Mary-get Paul-set Peter-set Mary-set
Peter-get Paul-get Mary-get Mary-set
Peter-get Paul-get Mary-get Mary-set Peter-set Paul-set
Peter-get Paul-get Mary-get Mary-set Paul-set Peter-set

Peter-get Mary-get
Peter-get Mary-get Paul-get
Peter-get Mary-get Paul-get Peter-set
Peter-get Mary-get Paul-get Peter-set Paul-set Mary-set
Peter-get Mary-get Paul-get Peter-set Mary-set Paul-set
Peter-get Mary-get Paul-get Paul-set
Peter-get Mary-get Paul-get Paul-set Mary-set Peter-set
Peter-get Mary-get Paul-get Paul-set Peter-set Mary-set
Peter-get Mary-get Paul-get Mary-set
Peter-get Mary-get Paul-get Mary-set Peter-set Paul-set
Peter-get Mary-get Paul-get Mary-set Paul-set Peter-set

Peter-get Mary-get Peter-set
Peter-get Mary-get Peter-set Mary-set
Peter-get Mary-get Peter-set Mary-set Paul-get Paul-set
Peter-get Mary-get Peter-set Paul-get
Peter-get Mary-get Peter-set Paul-get Mary-set Paul-set
Peter-get Mary-get Peter-set Paul-get Paul-set Mary-set

Peter-get Mary-get Mary-set
Peter-get Mary-get Mary-set Peter-set
Peter-get Mary-get Mary-set Peter-set Paul-get Paul-set
Peter-get Mary-get Mary-set Paul-get
Peter-get Mary-get Mary-set Paul-get Mary-set Paul-set
Peter-get Mary-get Mary-set Paul-get Paul-set Mary-set

Paul-get

Mary-get

|#