(import chicken.string)
(import srfi-69)
(import shell)

(define (main)
 (display (user-host))
 (newline)
 (display (uptime))
 (newline)
 (display (kernel))
 (newline))

(define (user-host)
 (define (host)
  (_string-strip (capture "hostname")))

 (define (user)
  (_string-strip (capture "echo $USER")))

 (define (display*)
  (conc (user) "@" (host)))

 (display*))

(define (uptime)
 (define (uptime-list)
  (let ((time-str (_string-strip
                   (car (string-split (capture "cat /proc/uptime") " ")))))
   (ago (round (inexact->exact (string->number time-str))) intervals-map)))

 (define (uptime-list->string lst)
  (accumulate conc
              ""
              (map (lambda (e)
                    (conc (car e) (car (cdr e)) " "))
                   lst)))

 (define display* (conc "uptime: " (uptime-list->string (uptime-list))))
 display*)

(define (kernel)
 (define (kernel-info)
  (_string-strip (capture "uname -r")))

 (define (display*)
  (conc "kernel: " (kernel-info)))

 (display*))

(define (accumulate proc initial sequence)
 (if (null? sequence)
  initial
  (proc (car sequence) (accumulate proc initial (cdr sequence)))))

(define (_string-strip str)
 (string-chomp str "\n"))

(define (ago seconds intervals)
 (cond
  ((< seconds 60)
   (list (list seconds 's)))
  ((or (< seconds 1)
       (eq? '() intervals))
   '('e))
  (else
   (if (or (= seconds (cadar intervals))
           (> seconds (cadar intervals)))
    (cons
     (list (quotient seconds (cadar intervals)) (car (cdr (caar intervals))))
     (ago (remainder seconds (cadar intervals)) (cdr intervals)))
    (ago seconds (cdr intervals))))))

(define intervals-map
        (list '('y 31536000)
              '('m 2592000)
              '('w 604800)
              '('d 86400)
              '('h 3600)
              '('m 60)))
(main)
