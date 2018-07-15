#!/usr/bin/env guile
!#

(use-modules (srfi srfi-1)
             (srfi srfi-11)
             (srfi srfi-26)
             (ice-9 ftw)
             (ice-9 match)
             (ice-9 rdelim)
             (html simple))

(setlocale LC_ALL "")

(define (file-mtime< file1 file2)
  (< (stat:mtime (stat file1))
     (stat:mtime (stat file2))))

(define (directory? file)
  (eq? 'directory (stat:type (stat file))))

;;; Ignores those starting with dot.
(define (get-subdirs dir)
  (scandir dir (lambda (file)
                 (and (directory? file)
                      (not (string-prefix? "." file))))))

(define (file-is-md? file)
  (and (not (directory? file))
       (string-suffix? ".md" file)))

(define (get-mds dir)
  (let* ((mds (scandir dir file-is-md?))
         (mds (map (cut string-drop-right <> 3) mds)))
    (sort mds
          (lambda (e1 e2)
            (let-values (((title1 date1) (get-md-meta e1))
                         ((title2 date2) (get-md-meta e2)))
              (string< date1 date2))))))

(define (file-is-md-html? file mds)
  (and (string-suffix? ".html" file)
       (let ((base (string-drop-right file 5)))
         (member base mds))))

(define (get-non-mds dir)
  (let ((mds (get-mds dir)))
    (scandir dir (lambda (file)
                   (not (or (directory? file)
                            (string=? file "index.html")
                            (string-suffix? ".css" file)
                            (file-is-md? file)
                            (file-is-md-html? file mds)))))))

(define (md-name md)
  (string-append md ".md"))

(define (md-html-name md)
  (string-append md ".html"))

(define (md2html in out)
  (unless (zero? (system* "md2html" "--css=/style.css" in "-o" out))
    (error "md2html returned non-zero exit code")))

;;; Creates/refreshes HTML version if needed, returns path to HTML version.
(define (process-md md)
  (let ((md-in (md-name md))
        (md-out (md-html-name md)))
    (unless (and (file-exists? md-out)
                 (file-mtime< md-in md-out))
      (md2html md-in md-out))))

(define (get-md-meta md)
  (let ((file (md-name md)))
    (with-input-from-file file
      (lambda ()
        (let* ((title-line (read-line))
               (title (if (string-prefix? "% " title-line)
                          (string-drop title-line 2)
                          ""))
               (_ (read-line))
               (date-line (read-line))
               (date (if (string-prefix? "% " date-line)
                         (string-drop date-line 2)
                         "")))
          (values title date))))))

(define (html-file-list files)
  (if (null? files)
      #f
      `(ul ,@(map (lambda (file)
                    `(li (a (@ (href ,file)) ,file)))
                  files))))

(define (html-md-list mds)
  (if (null? mds)
      #f
      `(ul ,@(map (lambda (md)
                    (let*-values (((html-file) (md-html-name md))
                                  ((title date) (get-md-meta md))
                                  ((name) (string-append date ": " title)))
                      `(li (a (@ (href ,html-file)) ,name))))
                  mds))))

(define (write-index title dir output)
  (with-output-to-file output
    (lambda ()
      (write-html-document
       (make-html-document
        title
        `(body
          (h1 ,title)
          ,@(let ((parts (list (html-file-list (get-subdirs dir))
                               (html-md-list   (get-mds dir))
                               (html-file-list (get-non-mds dir)))))
              ;; Add an (hr) between every two parts, eliminating empty parts.
              (cdr (concatenate (map (lambda (part)
                                       (if part
                                           (list '(hr) part)
                                           '()))
                                     parts)))))
        #:head-additions
        `((link (@ (rel "stylesheet")
                   (type "text/css")
                   (href "/style.css")))))))))

(define (process-dir dir)
  (let ((prev-dir (getcwd)))
    (dynamic-wind
      (lambda ()
        (chdir dir))
      (lambda ()
        (for-each process-md (get-mds "."))
        (unless (file-exists? "index.md")
          (let ((title (if (string=? "." dir)
                           "index"
                           dir)))
            (write-index title "." "index.html")))
        (for-each process-dir (get-subdirs ".")))
      (lambda ()
        (chdir prev-dir)))))

(match (program-arguments)
  ((script-name dirs ...)
   (for-each process-dir dirs)))

(display "All done!\n")
