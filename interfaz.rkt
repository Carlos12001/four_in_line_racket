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
(define actual-player 0)
(define board '())
(define buttons-panel '())
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



(define (start-game n m player)
  (set! actual-player player)
  (set! board (create-matrix n m))
  (display "Jugador esta jugando: ") (displayln actual-player)
  (print-matrix board)
  (create-board-panel board) ; crea el panel de botones
  (send frame1 show #f)
  (send frame2 show #t)
)

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
      (display (format "(~a, ~a) " (send b get-row) (send b get-col)))
    )
    (newline)
    (set! buttons-panel (append buttons-panel (list row-buttons)) )
  )
  panel
)

(define (print-buttons matrix)
  (for ([i (in-range (length matrix))])
    (for ([j (in-range (length (list-ref matrix i)))])
    (define b (list-ref (list-ref matrix i) j))
    (display (format "(~a, ~a) " (send b get-row) (send b get-col)))
    )
    (newline)
  )
) 

(define (button-grid-callback b e)
  (set! board (insert-token (send b get-col) board actual-player))

  (displayln (format "Jugador esta jugando: ~a" actual-player))
  (displayln (format "(~a, ~a)" (send b get-row) (send b get-col)))
  (print-matrix board)
  ; (print-buttons buttons-panel)

  (change-player actual-player)
  (update-board-panel)
) 

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
