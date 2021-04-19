(import chicken.string)
(import shell)

(define (host)
  (conc "Host: " (capture "hostname")))

(display (host))
