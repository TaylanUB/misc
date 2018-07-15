(define-syntax self (identifier-syntax _self))
(define-syntax super (identifier-syntax _super))

(define-syntax new-object (syntax-rules (variables methods)

    ((_ prototype
        (variables (vname vval) ...)
        (methods (mname (margs ...) mbody mbody* ...) ...))

     (let ((_super prototype) (vname vval) ... (mname (lambda (margs ...) mbody mbody* ...)) ...)
        (define (_self msg . args)
            (case msg
                ((Super) _super)
                ((Set)
                    (let ((msg (car args)) (args (cadr args)))
                        (case msg
                            ((vname) (set! vname (car args)))
                            ...
                            (else (error "No such member.")))))
                ((_get)
                    (let ((_self (car args)) (_super (cadr args)) (msg (caddr args)) (args (cadddr args)))
                        (case msg
                            ((vname) vname)
                            ...
                            ((mname) (apply mname args))
                            ...
                            (else
                                (_super '_get _self _super msg args)))))
                (else
                    (_self '_get _self _super msg args))))
        _self))


    ((_ (variables (vname vval) ...)
        (methods (mname (margs ...) mbody mbody* ...) ...))

     (let ((super (lambda (msg . args) (error "No such member:" (car args)))))
         (new-object super (variables (vname vval) ...) (methods (mname (margs ...) mbody mbody* ...) ...))))


    ((_ prototype
        (variables (vname vval) ...))

     (new-object prototype (variables (vname vval) ...) (methods)))


    ((_ prototype
        (methods (mname (margs ...) mbody mbody* ...) ...))

     (new-object prototype (variables) (methods (mname (margs ...) mbody mbody* ...) ...)))


    ((_ (variables (vname vval) ...))

     (new-object (variables (vname vval) ...) (methods)))


    ((_ (methods (mname (margs ...) mbody mbody* ...) ...))

     (new-object (variables) (methods (mname (margs ...) mbody mbody* ...) ...)))))


#!
(define Class (new-object
    (variables
        (super #f)
        (private-variables '())
        (inherited-variables '())
        (instance-methods '()))
    (methods
        (new ()
            (let ((class self)

(define-syntax new-class
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
!#
