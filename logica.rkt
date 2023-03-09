#lang racket

(require racket/gui/base)



;;; -------- Logica del juego ---------

;; Esta funcion obtiene una fila especifica de una matriz.
  ;;
  ;; Entradas:
  ;; - row: el indice de la fila que se quiere obtener
  ;; - board: la matriz representada como una lista de listas
  ;;
  ;; Retorna:
  ;; - una lista que representa la fila especifica de la matriz
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

;; Esta funcion verifica si hay una secuencia de cuatro elementos 
  ;; iguales  en una fila, columna o diagonal de una tabla de cuatro
  ;;  en línea.
  ;;
  ;; Entradas:
  ;; - board: una lista de listas que representa la tabla de cuatro 
  ;; en linea
  ;; - player: un número que representa el jugador a verificar (1 o 2)
  ;;
  ;; Retorna:
  ;; - #t si hay una secuencia de cuatro elementos iguales del jugador
  ;; en una fila, columna o diagonal de la tabla
  ;; - #f en otro caso
(define (check-win board player)
  (define (check-row row)
    (check-consecutive (get-row row board) player))
  (define (check-col col)
    (check-consecutive (get-col col board) player))
  (define (check-right-diagonal row col)
    (check-consecutive (get-right-diagonal row col board) player))
  (define (check-left-diagonal row col)
    (check-consecutive (get-left-diagonal row col board) player))
  (define (check-all i j)
    (cond
    [(>= i (length board)) 
        #f
    ]
    [(>= j (length (car board)))
        (check-all (+ 1 i) 0 )
    ]
    [(or    (check-row i) 
            (check-col j)
            (check-right-diagonal i j)
            (check-left-diagonal i j))
        #t
    ]
    [else 
        (check-all i (+ 1 j))
    ]
    )
  )
  (check-all 0 0)
)

;; Esta funcion verifica si hay un empate en el tablero, es decir,
  ;;  si no hay 
  ;; ninguna celda vacia en la matriz
  ;;
  ;; Entradas:
  ;; - lst: una matriz que representa el tablero de juego
  ;;
  ;; Retorna:
  ;; - #t si no hay celdas vacias en el tablero (empate)
  ;; - #f en otro caso
(define (check-tie lst)
  (cond ((null? lst) #t)
        ((member 0 (car lst)) #f)
        (else (check-tie (cdr lst))))
)

;; Esta funcion reemplaza un elemento en una lista con otro valor 
  ;; dado su indice.
  ;;
  ;; Entradas:
  ;; - pos: el indice del elemento a reemplazar
  ;; - lst: la lista en la cual se quiere reemplazar el elemento
  ;; - val: el valor que se quiere colocar en la posicion dada por el 
  ;; indice
  ;;
  ;; Retorna:
  ;; - Una nueva lista donde se ha reemplazado el elemento en la 
  ;; posicion dada por el indice con el valor dado.
(define (replace-ele-list pos lst val)
  (cond
    ((null? lst) '())
    ((= pos 0) (cons val (cdr lst)))
    (else (cons (car lst)
                (replace-ele-list (- pos 1) (cdr lst) val))
          )
    )
)

;; Esta funcion reemplaza un valor en una matriz dada su posicion en
  ;; las filas y columnas.
  ;;
  ;; Entradas:
  ;; - i: la fila donde se encuentra el elemento a reemplazar
  ;; - j: la columna donde se encuentra el elemento a reemplazar
  ;; - board: la matriz en la que se desea hacer el reemplazo
  ;; - val: el valor que se quiere colocar en la posicion (i,j) de la matriz
  ;;
  ;; Retorna:
  ;; - Una nueva matriz con el elemento (i,j) reemplazado por el valor dado.
(define (replace-ele-matrix i j board val)
  (replace-ele-list i board (replace-ele-list j (get-row i board) val))
)

;; Esta funcion retorna el elemento en la posicion (i,j) de una matriz.
  ;;
  ;; Entradas:
  ;; - i: la fila donde se encuentra el elemento deseado
  ;; - j: la columna donde se encuentra el elemento deseado
  ;; - board: la matriz de la cual se quiere obtener el elemento
  ;;
  ;; Retorna:
  ;; - El elemento en la posicion (i,j) de la matriz.
(define (get-ele-matrix i j board)
  (list-ref (list-ref board i) j)
)

;; Esta funcion inserta un token en la columna dada en la matriz, de
  ;; acuerdo a la regla de un juego de cuatro en linea. El token se
  ;; inserta en la fila más baja disponible.
  ;;
  ;; Entradas:
  ;; - col: la columna en la que se desea insertar el token
  ;; - board: la matriz que representa el tablero de juego
  ;; - player: el valor del jugador que está insertando el token
  ;;
  ;; Retorna:
  ;; - Una nueva matriz con el token insertado en la columna dada, en 
  ;; la fila mas baja disponible.
(define (insert-token col board player)
  (define (insert-aux row)
    (cond
      [(< row 0) board]
      [(zero? (get-ele-matrix row col board))
       (replace-ele-matrix row col board player)]
      [else (insert-aux (- row 1))]))

  (insert-aux (- (length board) 1))
)

;; Esta funcion crea una matriz de n filas y m columnas llena de ceros
  ;;
  ;; Entradas:
  ;; - n: numero de filas de la matriz
  ;; - m: numero de columnas de la matriz
  ;;
  ;; Retorna:
  ;; - Una matriz de n filas y m columnas llena de ceros
(define (create-matrix n m)
  (define (create-row m)
    (cond ((= m 0) '())
          (else (cons 0 (create-row (- m 1))))))

  (cond ((= n 0) '())
        (else (cons (create-row m)
                    (create-matrix (- n 1) m))))
)

;; Esta funcion imprime una matriz de manera legible en la consola
  ;;
  ;; Entradas:
  ;; - matrix: la matriz que se desea imprimir
  ;;
  ;; Retorna:
  ;; - Nada, ya que su función es solo imprimir en la consola
(define (print-matrix matrix)
  (cond
    ((null? matrix) (newline))
    (else (begin
            (display (car matrix))
            (newline)
            (print-matrix (cdr matrix)))))) 

(define (play-game n m player)
  (print-matrix (create-matrix n m))
  (create-matrix n m)
)
(provide play-game
         create-matrix
         print-matrix
         insert-token
         check-win
         check-tie
)