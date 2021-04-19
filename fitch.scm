(import chicken.string)
(import shell)

(define (main)
  (display (conc (user) "@" (host))))

(define (user)
  (_string-strip (capture "echo $USER")))

(define (host)
  (_string-strip (capture "hostname")))

(define (_string-strip str)
  (string-chomp str "\n"))

(main)
