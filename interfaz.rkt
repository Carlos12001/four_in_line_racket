#lang racket

(require racket/gui/base)
(require "logica.rkt")

;; -------- Interfaz del Juego ---------


;; --------- Inicio -------------

;; Crea un frame1 con titulo "Inicio".
(define frame1 (new frame% [label "Inicio"] [width 500] [height 300]))

;; Crea un label para mostrar un mensaje mensaje 
(new message% [parent frame1] [label "Escoja el tamaño de la matriz"] )

;; Seleciona la tamano fila
(define row-slider (new slider%
                        [label "Fila:   "]
                        [min-value 3]
                        [max-value 16]
                        [parent frame1]))

;; Seleciona la tamano columna
(define col-slider (new slider%
                        [label "Columna: "]
                        [min-value 3]
                        [max-value 16]
                        [parent frame1]))

;; Seleciona la tipo de ficha
(define token-slider (new slider%
                        [label "Ficha:   "]
                        [min-value 1]
                        [max-value 2]
                        [parent frame1]))

;; Llamada de accion del boton listo
(define (ready-button-callback b e)
  (start-game 
              (send row-slider get-value)
              (send col-slider get-value)
              (send token-slider get-value)
  )
)

;; Crea el boton listo   
(new button% [label "Listo"]
    [parent frame1]
    [callback ready-button-callback])

;; Muestra el frame 1
(send frame1 show #t)


;; --------- Juego -------------

;; Crea frame 2 del Juego
(define frame2 (new frame% [label "4 en Linea"] [width 500] [height 500]))

;; Crea un label con un mensaje
(define msg (new message% [parent frame2] [label "Turno Jugador =          "] ))

;; Crea un panel para guardar el panel de botones
(define panel2 (new horizontal-panel% [parent frame2]))

;; Decide que cual jugador juega
(define actual-player 0)

;; La matriz de juego
(define board '())

;; La matriz de botones
(define buttons-panel '())

;; Cambia el juagador actual el otro
(define (change-player p)
  (cond
    [(equal? 1 p) 
      (set! actual-player 2)
    ]
    [else
      (set! actual-player 1)
    ]
  )
)

;; Botones de la matrix de botones
(define Button%
  (class button%
    (init-field [row 0] [col 0])
    (super-new)
    (define/public (get-row)
      row)
    (define/public (get-col)
      col)
  )
)


;; Inicio del juego
(define (start-game n m player)
  (set! actual-player player)
  (set! board (create-matrix n m))
  (send msg set-label (format "Turno Jugador =  ~a !" actual-player))
  (send msg refresh)
  (create-board-panel board) ; crea el panel de botones
  (send frame1 show #f)
  (send frame2 show #t)
)

;; Crea la matriz de botones
(define (create-board-panel board)
  (define panel (new vertical-panel% [parent panel2]))
  
  (for ([i (in-range (length board))])
    (define row-panel (new horizontal-panel% [parent panel]))
    (define row-buttons '())

    (for ([j (in-range (length (list-ref board i)))])
      (define b (new Button% [parent row-panel]
                            [label "-"]
                            [callback button-grid-callback]
                            [row i]
                            [col j]
                            ))
      (set! row-buttons (append row-buttons (list b)))
    )
    (set! buttons-panel (append buttons-panel (list row-buttons)) )
  )
  panel
)

;; Realiza un impresion por consola de los botones del juego
(define (print-buttons matrix)
  (for ([i (in-range (length matrix))])
    (for ([j (in-range (length (list-ref matrix i)))])
    (define b (list-ref (list-ref matrix i) j))
    (display (format "(~a, ~a) " (send b get-row) (send b get-col)))
    )
    (newline)
  )
) 

;; Verfica si hay condicion de juego terminado
(define (check-game-status)
  (cond
    ((check-win board actual-player)
      (display (format "¡Felicidades!: ¡Jugador ~a has ganado el juego!" 
      actual-player))
      (define frame3 (new frame% [label "Fin del Juego"]
      [width 500]
      [height 500]))
      (new message% [parent frame3] 
      [label (format "¡Felicidades!: ¡Jugador ~a has ganado el juego!" 
      actual-player)] )
      (send frame2 show #f)
      (send frame3 show #t)
     )
    ((check-tie board)
      (display "Empate: ¡El juego ha terminado en empate!")
      (define frame3 (new frame% [label "Fin del Juego"] 
      [width 500] 
      [height 500]))
      (new message% [parent frame3]
      [label "Empate: ¡El juego ha terminado en empate!"] )
      (send frame2 show #f)
      (send frame3 show #t)
     )
    (else #f)
  )
)

;; Funcion que se ejecuta cuando un boton se presiona
(define (button-grid-callback b e)
  (set! board (insert-token (send b get-col) board actual-player))

  (displayln (format "Jugador ~a presiono boton (~a, ~a)" 
                                      actual-player
                                      (send b get-row) 
                                      (send b get-col)))
  (print-matrix board)

  (update-board-panel)
  (check-game-status)
  (change-player actual-player)
  (send msg set-label (format "Turno Jugador =  ~a !" actual-player))
) 

;; Actualiza como se ve la matriz de botones
(define (update-board-panel)
  (for ([i (in-range (length board))])
    (for ([j (in-range (length (list-ref board i)))])
      (define button (list-ref (list-ref buttons-panel i) j))
      (cond
        [(equal? 0 (list-ref (list-ref board i) j))
          (send button set-label "-")
          (send button enable #t)]
        [(equal? 1 (list-ref (list-ref board i) j))
          (send button set-label "1")
          (send button enable #f)]
        [(equal? 2 (list-ref (list-ref board i) j))
          (send button set-label "2")
          (send button enable #f)]
      )
    )
  )
)
