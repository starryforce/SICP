#lang sicp

; Explain what Eva Lu is talking about.
; In particular, show why Ben’s examples produce the printed results that they do.

; The interpreter prints out the pointer to the last pair, we do noting to the last pair when we
; delete an item, only make change to the last pair pointer when we insert an item

; Define a procedure print-queue that takes a queue as input and prints the sequence of items in the queue.

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) 
  (set-car! queue item))
(define (set-rear-ptr! queue item) 
  (set-cdr! queue item))

(define (make-queue) (cons '() '()))

(define (empty-queue? queue) 
  (null? (front-ptr queue)))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else (set-cdr! (rear-ptr queue) 
                          new-pair)
                (set-rear-ptr! queue new-pair)
                queue))))

(define q1 (make-queue))
(insert-queue! q1 'a)

(define (print-queue q)
  (front-ptr q))