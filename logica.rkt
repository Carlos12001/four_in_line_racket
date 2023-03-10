#lang racket

(require racket/gui/base)

; (provide
;          create-matrix
;          print-matrix
;          insert-token
;          check-win
;          check-tie
;          greddy
; )

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



;;; -------- Greddy Alorithm  ---------

;Recibe Matriz, valor del jugador a verificar, valor de jugador enemigo, indice de fila, indice columna, contador de columna para moverse horizontalmente, contador de fichas aliadas sucesivas, contador puntos
(define (ver_izq tablero jugador enem i j cont_h cont_f punt)
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (< cont_h 0) (< cont_h (- j 3)))
     (ver_der tablero jugador enem i j (+ j 1) cont_f punt)) ;verifica no se haya salido del rango a verificar, pasa a verificar lado opuesto.
    ((equal? (list-ref (list-ref tablero i) cont_h) enem)
     (ver_der tablero jugador enem i j (+ j 1) cont_f (- punt 5))) ;Si se topa con ficha enemiga, resta puntos y pasa a verificar lado opuesto
    ((equal? (list-ref (list-ref tablero i) cont_h) 0)
     (ver_izq tablero jugador enem i j (- cont_h 1) cont_f (+ punt 3))) ;Topo con espacio vacío, suma puntos pero no muchos.
    (else
     (ver_izq tablero jugador enem i j (- cont_h 1) (+ cont_f 1) (+ punt 15))) ;Topo con ficha aliada, suma el doble de puntos que vacio.
    )
)

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_der tablero jugador enem i j cont_h cont_f punt)
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_h (length (list-ref tablero i))) (> cont_h (+ j 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero i) cont_h) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 5))
    ((equal? (list-ref (list-ref tablero i) cont_h) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_der tablero jugador enem i j (+ cont_h 1) cont_f (+ punt 3)))
    (else
     (ver_der tablero jugador enem i j (+ cont_h 1) (+ cont_f 1) (+ punt 15))) ;Ficha aliada encontrada, suma más puntos.
    )
)


;  DIAGONAL Izq Arriba
;Recibe Matriz, valor del jugador a verificar, valor de jugador enemigo, indice de fila, indice columna, contador de columna para moverse horizontalmente, contador de fichas aliadas sucesivas, contador puntos
(define (ver_izqa tablero jugador enem i j cont_h cont_v cont_f punt)
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (< cont_h 0) (< cont_h (- j 3)) (< cont_v 0) (< cont_v (- i 3)))
     (ver_derb tablero jugador enem i j (+ j 1) (+ i 1) cont_f punt)) ;verifica no se haya salido del rango a verificar, pasa a verificar lado opuesto.
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem)
     (ver_derb tablero jugador enem i j (+ j 1) (+ i 1) cont_f (- punt 5))) ;Si se topa con ficha enemiga, resta puntos y pasa a verificar lado opuesto
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0)
     (ver_izqa tablero jugador enem i j (- cont_h 1) (- cont_v 1) cont_f (+ punt 3))) ;Topo con espacio vacío, suma puntos pero no muchos.
    (else
     (ver_izqa tablero jugador enem i j (- cont_h 1) (- cont_v 1) 
      (+ cont_f 1) (+ punt 15))) ;Topo con ficha aliada, suma el doble de puntos que vacio.
    )
)

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_derb tablero jugador enem i j cont_h cont_v cont_f punt)
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_h (length (list-ref tablero i))) 
      (> cont_h (+ j 3)) 
      (= cont_v (length tablero)) (> cont_v (+ i 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 5))
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_derb tablero jugador enem i j (+ cont_h 1) (+ cont_v 1) cont_f (+ punt 3)))
    (else
     (ver_derb tablero jugador enem i j (+ cont_h 1) (+ cont_v 1) (+ cont_f 1) (+ punt 15))) ;Ficha aliada encontrada, suma más puntos.
    )
)


;  DIAGONAL Der Arriba
;Recibe Matriz, valor del jugador a verificar, valor de jugador enemigo, indice de fila, indice columna, contador de columna para moverse horizontalmente, contador de fichas aliadas sucesivas, contador puntos
(define (ver_izqb tablero jugador enem i j cont_h cont_v cont_f punt)
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (< cont_h 0) (< cont_h (- j 3)) (= cont_v (length tablero)) 
      (> cont_v (+ i 3)))
     (ver_dera tablero jugador enem i j (+ j 1) (- i 1) cont_f punt)) ;verifica no se haya salido del rango a verificar, pasa a verificar lado opuesto.
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem)
     (ver_dera tablero jugador enem i j (+ j 1) (- i 1) cont_f (- punt 5))) ;Si se topa con ficha enemiga, resta puntos y pasa a verificar lado opuesto
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0)
     (ver_izqb tablero jugador enem i j (- cont_h 1) 
            (+ cont_v 1) cont_f (+ punt 3))) ;Topo con espacio vacío, suma puntos pero no muchos.
    (else
     (ver_izqb tablero jugador enem i j 
        (- cont_h 1) 
        (+ cont_v 1) (+ cont_f 1) (+ punt 15))) ;Topo con ficha aliada, suma el doble de puntos que vacio.
    )
)

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_dera tablero jugador enem i j cont_h cont_v cont_f punt)
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_h (length (list-ref tablero i))) (> cont_h (+ j 3)) 
          (< cont_v 0) (< cont_v (- i 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 5))
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_dera tablero jugador enem i j (+ cont_h 1) (- cont_v 1) cont_f (+ punt 3)))
    (else
     (ver_dera tablero jugador enem i j (+ cont_h 1) (- cont_v 1) 
     (+ cont_f 1) (+ punt 15))) ;Ficha aliada encontrada, suma más puntos.
    )
)

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_b tablero jugador enem i j cont_v cont_f punt)
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_v (length tablero)) (> cont_v (+ j 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero cont_v) j) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 5))
    ((equal? (list-ref (list-ref tablero cont_v) j) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_b tablero jugador enem i j (+ cont_v 1) cont_f (+ punt 3)))
    (else
     (ver_b tablero jugador enem i j (+ cont_v 1) (+ cont_f 1) (+ punt 15))) ;Ficha aliada encontrada, suma más puntos.
    )
)

;Obtiene un valor en el tablero. tablero get
(define (mget board i j)
  (list-ref (list-ref board i) j)
)

;-----------------------
;       El Voraz
;-----------------------

(define (greedy board player enemy)
  (solution
   (selection
    (objective board player enemy
               (feasibility board))))
)

;-----------------------
;      Viabilidad
;-----------------------

(define (feasibility board)
  (fea_aux board (length board) (length (list-ref board 0)) 
                (- (length board) 1) 0 '() )
)

(define (fea_aux board i j cont_v cont_h res)
  (cond
    ((< cont_v 0)
     (fea_aux board i j (- i 1) (+ cont_h 1) res))
    ((= cont_h j)
     res)
    ((= (mget board cont_v cont_h) 0)
     (fea_aux board i j (- i 1) (+ cont_h 1) 
                  (append res (list (list cont_v cont_h)))))
    (else
     (fea_aux board i j (- cont_v 1) cont_h res))
   )
)
    

(define (getij lst index num)
  (cond
    ((= num 1)
     (car (list-ref lst index)))
    (else
     (cadr (list-ref lst index)))
  )
)


(define (calculator board player enemy fea_res index)
  (ver_izq board player enemy (getij fea_res index 1) (getij fea_res index 2) 
  (- (getij fea_res index 2) 1) 0
           (ver_izqa board player enemy (getij fea_res index 1) 
           (getij fea_res index 2) (- (getij fea_res index 2) 1) 
           (- (getij fea_res index 1) 1) 0
                     (ver_izqb board player enemy 
                     (getij fea_res index 1) (getij fea_res index 2) 
                     (- (getij fea_res index 2) 1) 
                     (+ (getij fea_res index 1) 1) 0
                               (ver_b board player enemy 
                               (getij fea_res index 1) 
                               (getij fea_res index 2) 
                               (+ (getij fea_res index 1) 1) 0 0)))
 )
)

;-----------------------
; Conjunto de Candidatos
;-----------------------

(define (candidates board player enemy fea_res index)
  (candidates_aux board player enemy (- (getij fea_res index 1) 1) 
  (getij fea_res index 2))
)

(define (candidates_aux board player enemy i j)
  (cond
    ((< i 0) 0)
    (else
     (ver_izq board player enemy i j (- j 1) 0
           (ver_izqa board player enemy i j (- j 1) (- i 1) 0
                     (ver_izqb board player enemy i j (- j 1) (+ i 1) 0
               (ver_b board player enemy i j (+ i 1) 0 0))))
   )
  )
)

;-----------------------
;       Objetivo
;-----------------------

(define (objective board player enemy fea_res)
  (obj_aux board player enemy fea_res 0 '())
)

(define (obj_aux board player enemy fea_res index res)
  (cond
    ((= (length res) (length fea_res))
     res)
    (else
     (obj_aux board player enemy fea_res (+ index 1)
              (append res (list (list (getij fea_res index 1) 
                          (getij fea_res index 2)
                          (balance
                           (calculator board player enemy fea_res index)
                           (calculator board enemy player fea_res index)
                           (candidates board enemy player fea_res index)
                           )))))
     )
  )
)


(define (balance playerscore enemyscore futurescore)
  (cond ((> playerscore 900) 1000)
        ((> enemyscore 900) 500)
        ((> futurescore 900) -500)
        (else playerscore)
  )
)


;-----------------------
;       Seleccion
;-----------------------


(define (selection lst)
  (define (car-get-points lst2)
    (caddar lst2)
  )
  (define (selection_aux lst2 max-lst)
    (cond 
      ((null? lst2)
       max-lst)
      ((> (car-get-points lst2) (car-get-points max-lst))
       (selection_aux (cdr lst2) (list (car lst2))))
      ((= (car-get-points lst2) (car-get-points max-lst))
       (selection_aux (cdr lst2) (append max-lst (list (car lst2)))))
      (else
       (selection_aux (cdr lst2) max-lst))
    )
  )
  (cond
    ((null? lst)
     '())
    (else
     (selection_aux (cdr lst) (list (car lst))))
  )
)



;-----------------------
;       Solucion
;-----------------------

(define (solution lst)
  (cond
    ((= (length lst) 1) (cadr (car lst)))
    (else
     (solution_aux lst)
     )
  )
)

(define (solution_aux lst)
  (define random-index (random (length lst)))
  (cadr (list-ref lst random-index ))
)
