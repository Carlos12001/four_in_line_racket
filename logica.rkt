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
  (get-col-helper col board)
)

;; Define funcion auxiliar de get-col que obtiene los elementos de una 
  ;; columna especifica recursivamente
  ;;
  ;; Entradas:
  ;; - col: numero de columna (indice iniciando en 0)
  ;; - acc: lista de listas que representa el tablero (se usa para 
  ;; mantener el estado actual de la columna)
  ;;
  ;; Salida:
  ;; - Lista con los elementos en la columna especificada
(define (get-col-helper col acc)
  (cond 
  [(null? acc) 
    '()
  ]
  [else 
    (cons (list-ref (car acc) col) 
          (get-col-helper col (cdr acc)))
  ]
  )
)


; (define (get-diagonal row col board)
;   (define (get-pos n)
;     (list-ref (list-ref board n) n))
;   (define (get-diagonal-positions i j result)
;     (cond ((< i (length board))
;            (cond ((= j (max row col))
;                   result)
;                  (else
;                   (get-diagonal-positions (add1 i) (add1 j)
;                                           (cons (get-pos i) result))))))
;           (else
;            (list)))
;   (define (get-diagonal-list i j result)
;     (cond ((>= i 0)
;            (cond ((= j (max row col))
;                   result)
;                  (else
;                   (get-diagonal-list (sub1 i) (add1 j)
;                                      (cons (get-pos i) result))))))
;           (else
;            (list)))
;   (append (get-diagonal-positions row col '())
;           (cdr (get-diagonal-list (sub1 row) (add1 col) '())))
; )


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
(define board '((1 2 3 12) 
                (4 5 6 23) 
                (7 8 9 55)))

(get-col 3 board) ; devuelve '(2 5 8)