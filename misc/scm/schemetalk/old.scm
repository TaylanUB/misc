(define-syntax make-object
    (syntax-rules (variables methods)
        ((_ (variables (vname vval) ...)
            (methods (mname (margs ...) mbody ...) ...))
         (let ((vname vval) ...)
            (define (self msg . args) (case msg
                ((mname) (apply (lambda (margs ...) mbody ...) args))
                ...))
            self))))

(define Class (make-object #f
    (variables
        (super #f)
        (private-variables '())
        (inherited-variables '())
        (instance-methods '()))
    (methods
        (new ()
            (let ((class self)

(define-syntax make-class
    (syntax-rules (class-methods variables private inherited methods)
        ((_ (class-methods (cm (cmarg ...) cmbody ...) ...)
            (variables (private (pvname pvval) ...) (inherited (ivname ivval) ...))
            (methods (m (marg ...) mbody ...) ...))
         (begin
            (define (self msg . args) (case msg
                ((new)
                    #t)
                ((extend)
                    #t)
                ((subclass)
                    #t)
                ((cm) (apply (lambda (cmarg ...) cmbody ...) args)) ...))
         self))))
