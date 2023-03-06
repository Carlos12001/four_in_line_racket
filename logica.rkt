#lang racket

(require racket/gui/base)



;;; -------- Logica del juego ---------

(define (get-row row board)
    (list-ref board row)
)

;; Obtiene los elementos de una columna especifica en un tablero
  ;;
  ;; Entradas:
  ;; - col: numero de columna (indice iniciando en 0)
  ;; - board: lista de listas que representa el tablero
  ;;
  ;; Retorna:
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
    ;; Retorna:
    ;; - Una lista con los elementos en la diagonal secundaria
(define (get-right-diagonal row col board)
    (define (helper row col acc)
        (cond
        [(or (>= row (length board)) 
          (>= col (length (list-ref board 0)))) 

          acc]
        [else 
            (helper 
                (+ 1 row) (+ 1 col) 
                (cons (list-ref (list-ref board row) col) acc))
        ]
        )
    )
    (helper row col '())
)


;; Obtiene los elementos de la diagonal izquierda secundaria
    ;; que pasa por la posicion (row, col) de una matriz dada.
    ;;
    ;; Entradas:
    ;; - row: indice de fila de la posicion inicial (iniciando en 0).
    ;; - col: indice de columna de la posicion inicial (iniciando en 0).
    ;; - board: una lista de listas que representa la matriz.
    ;;
    ;; Retorna:
    ;; - Una lista con los elementos en la diagonal izquierda secundaria.
(define (get-left-diagonal row col board)
  (define (helper row col acc)
    (cond
    [(or    (>= row (length board)) 
            (>= col (length (car board))) 
            (< col 0))
        acc]
    [else
    (helper (+ 1 row) 
            (- col 1) 
            (cons (list-ref (list-ref board row) col) 
        acc))
    ]))
  (helper row col '())
)

;; Esta funcion verifica si hay un numero consecutivo de elementos
  ;; iguales en una lista.
  ;;
  ;; Entradas:
  ;; - lst: una lista de elementos
  ;; - elem: el elemento que se busca contar
  ;;
  ;; Retorna:
  ;; - #t si hay al menos 4 elementos consecutivos iguales en la lista,
  ;;  #f en otro caso
(define (check-consecutive lst elem)
    (define (check-consecutive-aux count lst)
        (cond 
        ((or (null? lst)  (>= count 4))
           (>= count 4)
        )
        ((equal? (car lst) elem) 
            (check-consecutive-aux (+ 1 count) (cdr lst))
        )
        (else 
            (check-consecutive-aux 0 (cdr lst))
        ))
    )
    (check-consecutive-aux 0 lst)
)


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

; (define board '((1 0 0 0 0 0 0 0 0)
;                 (1 0 0 0 0 0 0 0 0)
;                 (1 0 0 0 0 0 0 0 0)
;                 (2 0 0 0 0 0 0 0 0)
;                 (2 0 0 1 0 0 0 0 0)
;                 (2 0 1 0 0 0 0 0 0)
;                 (2 1 0 0 1 0 0 0 0)
;                 (1 1 0 0 2 0 0 0 0))
; )
; (define board2 '((  1   2   3   4)
;                 (   5   6   7   8)
;                 (   9   10  11  12))
; )

; ;; get-row

; (define (test-all-positions-row board)
;   (define rows (length board))
;   (define cols (length (list-ref board 0)))
;   (for*/list ([row (in-range rows)]
;               [col (in-range cols)])
;     (get-row row board)))

; (println "------ROW-------")
; (for-each (lambda (x) (display x) (newline)) (test-all-positions-row board2))

; ;; get-col

; (define (test-all-positions-col board)
;   (define rows (length board))
;   (define cols (length (list-ref board 0)))
;   (for*/list ([row (in-range rows)]
;               [col (in-range cols)])
;     (get-col col board)))
    
; (println "------COL-------")
; (for-each (lambda (x) (display x) (newline)) (test-all-positions-col board2))

; ;; get-d-r

; (define (test-all-positions-r board)
;   (define rows (length board))
;   (define cols (length (list-ref board 0)))
;   (for*/list ([row (in-range rows)]
;               [col (in-range cols)])
;     (get-right-diagonal row col board)))

; (println "------D-R-------")
; (for-each (lambda (x) (display x) (newline)) (test-all-positions-r board2))

; ;; get-l-r

; (define (test-all-positions-l board)
;   (define rows (length board))
;   (define cols (length (list-ref board 0)))
;   (for*/list ([row (in-range rows)]
;               [col (in-range cols)])
;     (get-left-diagonal row col board)))

; (println "------D-R-------")
; (for-each (lambda (x) (display x) (newline)) (test-all-positions-l board2))

;; check-consecutive

; (check-consecutive '(1 1 1 1 2 3 4) 1)

; (check-consecutive '(1 2 1 1 1 3 4) 1)

; (check-consecutive '(1 2 3 4 5) 1)

