#lang simply-scheme

(require rackunit)

; A Type is one of:
; - ?
; - procedure
; - number
; - list
; - sentence-or-word
; - x

; An AssociationList is [List-of [List Symbol Type]]
; AList is abbreviation for AssociationList

; Symbol Type AList -> AList
; update alist with name & type
(define (update-list name type alist)
  (cond ((null? alist) '())
        (else (let ((key (caar alist)) (value (cadar alist)))
                (if (eq? key name)
                    (cons (list name
                                (if (or (eq? value '?) (eq? value type)) type 'x))
                          (cdr alist))
                    (cons (car alist) (update-list name type (cdr alist))))))))

(check-equal? (update-list 'b 'number '((a ?) (b ?))) '((a ?) (b number)))
(check-equal? (update-list 'b 'number '((a ?))) '((a ?)))
(check-equal? (update-list 'a 'number '((a ?))) '((a number)))
(check-equal? (update-list 'a 'number '((a procedure))) '((a x)))

; AList Exp -> AList
(define (infer-t alist body)
  (cond ((not (pair? body)) alist)
        ((assoc (car body) alist) (infer-list (update-list (car body) 'procedure alist) (cdr body)))
        ((memq (car body) '(+ - max min)) (infer-seq alist (cdr body) 'number))
        ((memq (car body) '(first butfirst bf sentence se member?)) (infer-seq alist (cdr body) 'sentence-or-word))
        ((memq (car body) '(append car cdr)) (infer-seq alist (cdr body) 'list))
	((eq? (car body) 'map) (inf-map alist body 'list))
	((eq? (car body) 'every) (inf-map alist body 'sentence-or-word))
        #|
        ((eq? (car body) 'every) (infer-t (update-list (cadr body)
                                                       'procedure
                                                       (update-list (caddr body) 'sentence-or-word alist))
                                          (cdddr body)))
        ((eq? (car body) 'map) (infer-t (update-list (cadr body)
                                                     'procedure
                                                     (update-list (caddr body) 'list alist))
                                        (cdddr body)))
        |#
        ((eq? (car body) 'member) (infer-t (update-list (caddr body) 'list alist) (cadr body)))
        ((eq? (car body) 'quote) alist)
        (else (infer-t alist (cdr body)))))

(define (inf-map alist body type)
  (if (pair? (cadr body))
      (infer-t (update-list (caddr body) type alist)
		      (cadr body))
      (update-list (cadr body) 'procedure (update-list (caddr body) type alist))))

; AList [List-of Exp] -> AList
(define (infer-list alist seq)
  (if (null? seq)
      alist
      (infer-list (infer-t alist (car seq)) (cdr seq))))

; AList [List-of Exp] Symbol -> AList
(define (infer-seq alist seq type)
  (cond ((null? seq) alist)
        ((pair? (car seq))
         (infer-seq (infer-t alist (car seq)) (cdr seq) type))
        (else (infer-seq (update-list (car seq) type alist) (cdr seq) type))))

(define (inf-lambda alist exp)
  ((repeated cdr (length (cadr exp)))
   (update-list (append (map (lambda (name) (list name '?)) (cadr exp))
                        alist)
                (caddr exp))))


(check-equal? (infer-t '((a ?)(b ?)) '(+ a b))
              '((a number) (b number)))
(check-equal? (infer-t '((a ?)(b ?)) '(first a b))
              '((a sentence-or-word) (b sentence-or-word)))
(check-equal? (infer-t '((a ?)(b ?)) '(append a b))
              '((a list) (b list)))
(check-equal? (infer-t '((a ?)(b ?)) '(map a b))
              '((a procedure) (b list)))
(check-equal? (infer-t '((a ?)(b ?)) '(every a b))
              '((a procedure) (b sentence-or-word)))
(check-equal? (infer-t '((a ?)(b ?)) '(member a b))
              '((a ?) (b list)))
(check-equal? (infer-t '((a ?)(b ?)) '(a b))
              '((a procedure) (b ?)))

; Exp
(define (inferred-types exp)
  (define (generate-assoc args)
    (map (lambda (x) (list x '?)) args))
  (cond ((eq? 'define (car exp)) (infer-t (generate-assoc (cdadr exp)) (caddr exp)))
        ((eq? 'lambda (car exp)) (infer-t (generate-assoc (cadr exp)) (caddr exp)))
        (else (error "not an procedure defination"))))

(check-equal? (inferred-types
               '(lambda (a b) (map (lambda (a) (append a a)) b)))
              '((a ?) (b list)))

(check-equal? (inferred-types
               '(define (foo a b c d e f)
                  (f (append (a b) c '(b c)) (+ 5 d) (sentence (first e) f))))
              '((a procedure) (b ?) (c list) (d number)
                              (e sentence-or-word) (f x)))

