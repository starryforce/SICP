#lang sicp

; format: (from-address to-address subject body)

#| sample
("cs61a-tb" "cs61a-tc" "mapreduce" "mapreduce is great! lucky students!")
("bot1337" "cs61a-ta" "free ipod now!" "buy herbal ipod enhancer!")
("bot1338" "cs61c-tf" "free ipod now!" "buy herbal ipod enhancer!")
|#


(define (get-counts folder)
  (mapreduce mapper + 0 folder))

(define (mapper record)
  (list (make-kv-pair (caddr record) 1)))

#|
("mapreduce" 1)
("free ipod now!" 2)
|#