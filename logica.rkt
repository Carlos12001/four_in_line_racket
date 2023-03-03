#lang racket

(require racket/gui/base)

(provide fibonacci)
(provide factorial)


;;; -------- Logica del juego ---------

(define (factorial num) 
    (cond  
        [(zero? num) 1]
        [else (* num (factorial (- num 1)))]
    )
)

;; Realiza el fibonacci de numero
;; num entero
(define (fibonacci num)
    (cond
        [(zero? num) 0]
        [(equal? num 1) 1]
        [else (+ (fibonacci (- num 1)) (fibonacci (- num 2)) )]
    )
)
