#lang simply-scheme

(define (inferred-types def)
  (cond ((eq? (car def) 'define)
	 (inf-typ (cdadr def) (caddr def)))
	((eq? (car def) 'lambda)
	 (inf-typ (cadr def) (caddr def)))
	(else (error "not a definition"))))

(define (inf-typ params body)
  (inf-typ-helper (map (lambda (name) (list name '?)) params) body))

(define (inf-typ-helper alist body)
  (cond ((not (pair? body)) alist)
	((assoc (car body) alist)
	 (inf-typ-seq (typ-subst (car body) 'procedure alist) (cdr body)))
	((eq? (car body) 'map) (inf-map alist body 'list))
	((eq? (car body) 'every) (inf-map alist body 'sentence-or-word))
	((eq? (car body) 'member) (typ-subst (caddr body) 'list alist))
	((memq (car body) '(+ - max min)) (seq-subst (cdr body) 'number alist))
	((memq (car body) '(append car cdr)) (seq-subst (cdr body) 'list alist))
	((memq (car body) '(first butfirst bf sentence se member?))
	 (seq-subst (cdr body) 'sentence-or-word alist))
	((eq? (car body) 'quote) alist)
	((eq? (car body) 'lambda) (inf-lambda alist body))
	(else (inf-typ-seq alist (cdr body)))))

(define (typ-subst name type alist)
  (cond ((null? alist) '())
	((eq? (caar alist) name)
	 (cons (list name
		     (if (or (eq? (cadar alist) '?)
			     (eq? (cadar alist) type))
			 type
			 'x))
	       (cdr alist)))
	(else (cons (car alist) (typ-subst name type (cdr alist))))))

(define (inf-typ-seq alist seq)
  (if (null? seq)
      alist
      (inf-typ-seq (inf-typ-helper alist (car seq)) (cdr seq))))

(define (inf-map alist body type)
  (if (pair? (cadr body))
      (inf-typ-helper (typ-subst (caddr body) type alist)
		      (cadr body))
      (typ-subst (cadr body) 'procedure (typ-subst (caddr body) type alist))))

(define (seq-subst seq type alist)
  (cond ((null? seq) alist)
	((pair? (car seq))
	 (seq-subst (cdr seq) type (inf-typ-helper alist (car seq))))
	(else (seq-subst (cdr seq) type (typ-subst (car seq) type alist)))))

(define (inf-lambda alist exp)
  ((repeated cdr (length (cadr exp)))
   (inf-typ-helper (append (map (lambda (name) (list name '?)) (cadr exp))
			   alist)
		   (caddr exp))))

(inferred-types
 '(lambda (a b) (map (lambda (a) (append a a)) b)))