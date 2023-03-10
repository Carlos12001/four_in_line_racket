# Juego 4 linea

- Definir la función get-row que dada una fila row y un tablero board devuelve una lista con los elementos en esa row

```  scheme
(define (get-row row board)
    (list-ref board row)
)
```

- Definir la función get-col que dada una columna col y un tablero board devuelve una lista con los elementos en esa columna:

```  scheme
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
```

- Definir la función get-diagonal que dada una fila row, una columna col y un tablero board devuelve una lista con los elementos en la diagonal principal (derecha hacia abajo) que contiene la posición (row, col):

``` scheme
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
```

- Definir la función get-diagonal que dada una fila row, una columna col y un tablero board devuelve una lista con los elementos en la diagonal opuesta (izquierda hacia abajo) que contiene la posición (row, col):

``` scheme
(define (get-left-diagonal row col board)
    (define (helper row col acc)
        (cond
            [(or (>= row (length board)) (< col 0))
                acc]
            [else 
                (helper 
                    (+ 1 row) (- 1 col) 
                    (cons (list-ref (list-ref board row) col) acc))]))
    (helper row col '())
)
```

- Definir la función check-consecutive que dada una lista lst y un elemento elem devuelve verdadero si elem aparece consecutivamente al menos cuatro veces en lst:

```  scheme
(define (check-consecutive lst elem)
    (define (check-consecutive-aux count lst)
        (cond 
        ((or (null? lst) (equal? 4 count)) 
            #t
        )
        ((equal? (car lst) elem) 
            (check-consecutive-aux (+ 1 count) (cdr lst))
        )
        (else 
            #f
        ))
    )
    (check-consecutive-aux 0 lst)
)
```

- Definir la función check-win que dada una lista lst y un elemento elem devuelve verdadero si elem aparece consecutivamente al menos cuatro veces en lst:

```  scheme
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
```

- Definir la función check-tie que dada una lista lst devuelve verdadero si todas las casillas en lst están ocupadas:

```  scheme
(define (check-tie lst)
  (cond ((null? lst) #t)
        ((member 0 (car lst)) #f)
        (else (check-tie (cdr lst))))
)
```

- Definir una funcion agrega hasta el final una ficha de un jugador.

```  scheme

(define (replace-ele-list pos lst val)
  (cond
    ((null? lst) '())
    ((= pos 0) (cons val (cdr lst)))
    (else (cons (car lst)
                (replace-ele-list (- pos 1) (cdr lst) val))
          )
    )
)

(define (replace-ele-matrix i j board val)
  (replace-ele-list i board (replace-ele-list j (get-row i board) val))
)

(define (get-ele-matrix i j board)
  (list-ref (list-ref board i) j)
)

(define (insert-token col board player)
  (define (insert-aux row)
    (cond
      [(< row 0) board]
      [(zero? (get-ele-matrix row col board))
       (replace-ele-matrix row col board player)]
      [else (insert-aux (- row 1))]))

  (insert-aux (- (length board) 1))
)
```

- Definir la función que crea la matriz del juego.

```  scheme
(define (create-matrix n m)
  (define (create-row m)
    (cond ((= m 0) '())
          (else (cons 0 (create-row (- m 1))))))

  (cond ((= n 0) '())
        (else (cons (create-row m)
                    (create-matrix (- n 1) m))))
)
```

- Imprime una matriz.

```  scheme
(define (print-matrix matrix)
  (cond
    ((null? matrix) (newline))
    (else (begin
            (display (car matrix))
            (newline)
            (print-matrix (cdr matrix)))))
) 
```

