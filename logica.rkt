#lang racket

(require racket/gui/base)



;;; -------- Logica del juego ---------

;; Obtiene los elementos de una columna especifica en un tablero
  ;;
  ;; Entradas:
  ;; - col: numero de columna (indice iniciando en 0)
  ;; - board: lista de listas que representa el tablero
  ;;
  ;; Salida:
  ;; - Lista con los elementos en la columna especificada
(define (get-col col board)
  (cond 
  [(null? board) 
    '()
  ]
  [else 
    (cons (list-ref (car board) col) 
          (get-col col (cdr board)))
  ]
  )
)



;; Obtiene los elementos de la diagonal derecha secundaria
    ;;  que pasa por la posicion (row, col)
    ;;
    ;; Entradas:
    ;; - row: indice de fila de la posicion inicial (iniciando en 0)
    ;; - col: indice de columna de la posicion inicial (iniciando en 0)
    ;; - board: una lista de listas que representa el tablero
    ;;
    ;; Salida:
    ;; - Una lista con los elementos en la diagonal secundaria
(define (get-right-diagonal row col board)
    (define (helper row col acc)
        (cond
        ;; Si se han alcanzado los limites del tablero,
        ;; se devuelve la lista acumulada
        [(or (>= row (length board)) (>= col (length (list-ref board 0)))) 
                acc]
        ;; Si no se han alcanzado los limites del tablero, 
        ;; se agrega el elemento actual
        ;; a la lista acumulada y se llama 
        ;; recursivamente a la funcion con la siguiente
        ;; fila y la siguiente columna.
        [else 
            (helper 
                (add1 row) (add1 col) 
                (cons (list-ref (list-ref board row) col) acc))
        ]
        )
    )
    (helper row col '())
)




; (define (check-consecutive lst elem)
;   (define (check-consecutive-aux count lst)
;     (cond ((null? lst) (>= count 4))
;           ((eq? (car lst) elem) (check-consecutive-aux (add1 count) (cdr lst)))
;           (else (check-consecutive-aux 0 (cdr lst)))))
;   (check-consecutive-aux 0 lst)
; )

; (define (check-win board player)
;   (define (check-row row)
;     (check-consecutive (list-ref board row) player))
;   (define (check-col col)
;     (check-consecutive (get-col col board) player))
;   (define (check-diagonal row col)
;     (check-consecutive (get-diagonal row col board) player))
;   (define (check-all)
;     (define (check-all-aux i j)
;       (cond ((>= i (length board)) #t)
;             ((>= j (length (first board))) (check-all-aux (add1 i) 0))
;             ((or (check-row i)
;                  (check-col j)
;                  (check-diagonal i j))
;              #t)
;             (else (check-all-aux i (add1 j)))))
;     (check-all-aux 0 0))
;   (check-all))



; (define (check-tie lst)
;   (cond ((null? lst) #t)
;         ((member 0 (car lst)) #f)
;         (else (check-tie (cdr lst)))))

;   (define (check-row row)
;     (check-consecutive (list-ref board row) player))
;   (define (check-col col)
;     (check-consecutive (get-col col board) player))
;   (define (check-diagonal row col)
;     (check-consecutive (get-diagonal row col board) player))
;   (define (check-all)
;     (define (check-all-aux i j)
;       (cond ((>= i (length board)) #t)
;             ((>= j (length (first board))) (check-all-aux (add1 i) 0))
;             ((or (check-row i)
;                  (check-col j)
;                  (check-diagonal i j))
;              #t)
;             (else (check-all-aux i (add1 j)))))
;     (check-all-aux 0 0))
;   (check-all))


; (define (game-over board player)
;   (cond ((check-win board player) #t)
;         ((check-tie board))))

; (define (play-game)
;   (define board (make-board))
;   (define players '(1 2))
;   (define (next-player player)
;   (if (eq? player (first players))
;   (second players)
;   (first players)))
;   (define (get-player-piece player)
;   (if (eq? player (first players))
;   1
;   2))
;   (define (print-board)
;   (display-board board)
;   (newline))
;   (define (play-turn player)
;   (print-board)
;   (display (format "Player ~a's turn\n" player))
;   (let ((col (get-valid-col player)))
;   (place-piece col player board)
;   (if (game-over board player)
;   (begin
;   (print-board)
;   (display (format "Player ~a wins!\n" player))
;   'game-over)
;   (if (check-tie board)
;   (begin
;   (print-board)
;   (display "Tie game!\n")
;   'game-over)
;   (play-turn (next-player player))))))

;   (play-turn (first players))
; )






;;; -------- Testing de funciones ---------

;; get-col
; (define board '((1  2   3   4)
;                 (5  6   7   8)
;                 (9  10  11  12)))

; (get-col 3 board)

;; get-diagonal

; (define (test-all-positions board)
;   (define rows (length board))
;   (define cols (length (list-ref board 0)))
;   (for*/list ([row (in-range rows)]
;               [col (in-range cols)])
;     (get-right-diagonal row col board)))

; (test-all-positions board)