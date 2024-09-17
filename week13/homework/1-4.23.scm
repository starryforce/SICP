#lang sicp

; text version
(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc 
                            (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence: ANALYZE"))
    (loop (car procs) (cdr procs))))

; length = 1
; procs -> single-proc
; (loop single-proc '())
; return single-proc

; length = 2
; procs -> '(a-proc b-proc)
; (loop a-proc '(b-proc))
; (loop (sequentially a-proc b-proc) '())
; (sequentially a-proc b-proc)
; (lambda (env) (a-proc env) (b-proc env))

; Alyssa version
(define (analyze-sequence exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs)) 
           ((car procs) env))
          (else ((car procs) env)
                (execute-sequence 
                 (cdr procs) env))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence: 
                ANALYZE"))
    (lambda (env) 
      (execute-sequence procs env))))
; length = 1
; procs -> single-proc
; (execute-sequence single-proc env)
; (single-proc env)
; an extra lambda function

; length = 2
; procs -> '(a-proc b-proc)
; (execute-sequence '(a-proc b-proc) env)
;   (a-proc env)
;   (execute-sequence '(b-proc) env)
;   (b-proc env)

