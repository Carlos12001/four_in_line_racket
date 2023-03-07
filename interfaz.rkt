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
(define (ready-button-callback b e)
  (start-game 
              (send row-slider get-value)
              (send col-slider get-value)
              (send token-slider get-value)
  )
)


; ;Crea el botón check    
(new button% [label "Listo"]
    [parent frame1]
    [callback ready-button-callback])
(send frame1 show #t)


;; --------- Juego -------------
(define frame2 (new frame% [label "4 en Linea"] [width 500] [height 500]))
(define panel2 (new horizontal-panel% [parent frame2]))
(define board '())
(define buttons-panel '())



(define (start-game n m player)
  (set! board (create-matrix n m))
  (print-matrix board)
  (set! buttons-panel (create-board-panel board)) ; crea el panel de botones
  (send frame1 show #f)
  (send frame2 show #t)
)

(define (create-board-panel board)
  (define panel (new vertical-panel% [parent panel2]))
  
  (for ([row board])
    (define row-panel (new horizontal-panel% [parent panel]))
    
    (for ([elem row])
      (define button (new button% [parent row-panel]
                                  [label "-"]
                                  [callback button-grid-callback]))
      (set! buttons-panel (cons button buttons-panel))
      (cond [(= elem 0) ; si el elemento es 0
             (void)]    ; no hacemos nada
            [(= elem 1) ; si el elemento es 1
             (send button set-label "1") ; establecemos la etiqueta del botón a "1"
             (send button set-enabled #f) ; deshabilitamos el botón
             (send button set-background "blue")] ; establecemos el fondo del botón a azul
            [(= elem 2) ; si el elemento es 2
             (send button set-label "2") ; establecemos la etiqueta del botón a "2"
             (send button set-enabled #f) ; deshabilitamos el botón
             (send button set-background "red")])) ; establecemos el fondo del botón a rojo
  
  panel)
)

  ;Accion de botones
(define (button-grid-callback b e)
  (displayln "Holi :3")
  ; (set! board '((0 0 0 0 0 0 0 0 0 0)
  ;               (0 0 0 0 0 0 0 0 0 0)
  ;               (0 0 0 0 0 0 0 0 0 0)
  ;               (0 0 0 0 0 0 0 0 0 0)
  ;               (0 0 0 0 0 0 0 0 0 0)
  ;               (0 0 0 0 0 0 0 0 0 0)
  ;               (0 0 0 0 0 0 0 0 0 0)
  ;               (0 0 0 0 0 1 0 0 2 0)))
  ; (print-matrix board)
)
