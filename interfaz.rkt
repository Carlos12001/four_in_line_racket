#lang racket

(require racket/gui/base)
(require "logica.rkt")

;;; -------- Interfaz del Juego ---------


;; --------- Inicio -------------


(define frame1 (new frame% [label "Inicio"] [width 500] [height 300]))
(new message% [parent frame1] [label "Escoja el tamaño de la matriz"] )
(define row-slider (new slider%
                        [label "Fila:   "]
                        [min-value 8]
                        [max-value 16]
                        [parent frame1]))
(define col-slider (new slider%
                        [label "Columna: "]
                        [min-value 8]
                        [max-value 16]
                        [parent frame1]))
(define token-slider (new slider%
                        [label "Ficha:   "]
                        [min-value 1]
                        [max-value 2]
                        [parent frame1]))

  ;Llamada de acción del botón "check"
(define (button-callback b e)
  (grid-craetor (send row-slider get-value)
              (send col-slider get-value)
              (send token-slider get-value)
  )
)


; ;Crea el botón check    
(new button% [label "Listo"]
    [parent frame1]
    [callback button-callback])
(send frame1 show #t)


;; --------- Juego -------------

(define frame2 (new frame% [label "4 en Linea"] [width 500] [height 500]))
(define panel2 (new horizontal-panel% [parent frame2]))
(define (grid-craetor n m player)
  
  (define buttons '())
  (for ([i (in-range n)])
    (define row (new vertical-panel% [parent panel2]))
    (for ([j (in-range m)])
      (define button (new button% [parent row] [label "-"]))
      (set! buttons (cons button buttons))))
    
  (send frame1 show #f)
  (send frame2 show #t)
  (play-game n m player)
  buttons
)
