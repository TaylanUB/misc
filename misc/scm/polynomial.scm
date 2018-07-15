(use-srfis '(1))

(define (list-remove! l i)
  (if (zero? i)
    (set! l (cdr l))
    (list-remove! (cdr l) (- i 1))))

(define (make-poly . terms) (let
  ()
  (lambda (msg) (case msg
    ((terms) terms)
    ((simplify)
      (pair-for-each
        (lambda (terms)
          (define i 1)
          (for-each
            (lambda (term)
              (if (equal? ((car terms) 'vars) (term 'vars))
                (begin
                  (set-car! terms (make-term (+ ((car terms) 'const) (term 'const)) (term 'vars)))
                  (list-remove! terms i)))
              (set! i (+ i 1)))
            (cdr terms)))
        terms))
    ((display)
      (if (null? terms)
        (display 0)
        (for-each (lambda (term) (display " + ") (term 'display)) terms))
      (newline))))))

(define (make-term const vars) (let
  ()
  (lambda (msg) (case msg
    ((const) const)
    ((vars) vars)
    ((display)
      (display const)
      (for-each (lambda (var) (display " ") (var 'display)) vars))))))

(define (make-var name degree) (let
  ()
  (lambda (msg) (case msg
  ((name) name)
  ((degree) degree)
  ((display)
    (display name)
    (if (not (= degree 1)) (begin
      (display "^") (display degree))))))))


(define (poly+ poly . rest)
  (case (length rest)
    ((0) poly)
    ((1)
      (apply make-poly (append (poly 'terms) ((car rest) 'terms))))
    (else
      (poly+ (poly+ poly (car rest)) (cdr rest)))))

(define (poly- poly . rest)
  (if (null? rest)
    (make-poly (map (lambda (term) (make-term (- (term 'const)) (term 'vars))))))
    (poly+ poly (poly- (apply poly+ rest))))

(define (term* term . rest)
  (case (length rest)
    ((0) term)
    ((1)
      (make-term (* (term 'const) ((car rest) 'const)) (append (term 'vars) ((car rest) 'vars))))
    (else
      (term* (term* term (car rest)) (cdr rest)))))

(define (poly* poly . rest)
  (case (length rest)
    ((0) poly)
    ((1)
      (apply make-poly
             (apply append
               (map (lambda (term1) (map (lambda (term2) (term* term1 term2))
                                         ((car rest) 'terms)))
                    (poly 'terms)))))
    (else
      (poly* (poly* poly (car rest)) (cdr rest)))))

(define (poly-set-var-to-poly! poly varname poly2)
  (map
    (lambda (term)
      (map
        (lambda (var)
          (if (eq? (car var) varname)
              (set-car! var value)))
        (cdr term)))
    poly))

(define poly (make-poly
  (make-term 4 (list (make-var 'x 3) (make-var 'y 2)))
  (make-term 3 (list (make-var 'x 2) (make-var 'y 1)))
  (make-term 2 (list (make-var 'x 1)))
  (make-term 1 '())
))
