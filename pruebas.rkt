#lang racket

;; ----- PRUEBAS GREDDY -----

; ;; ------------------------
; ;;     Matriz de PRUEBA 
; ;; ------------------------

; (define tabla
;   (list 
;    (list 0 0 0 0 0 0 0 0)
;    (list 0 0 0 0 0 1 0 0)
;    (list 0 0 1 0 1 0 0 0)
;    (list 0 2 1 0 1 2 0 0)
;    (list 0 0 2 1 1 0 0 0)
;    (list 0 0 0 1 0 1 0 0)
;    (list 0 0 0 1 0 0 0 0)
;    (list 0 0 0 0 0 0 0 0)))

; (define tabla2
;   (list 
;    (list 0 0 0 0 0 0 0 0)
;    (list 0 0 0 0 0 0 0 1)
;    (list 0 0 0 0 0 0 0 2)
;    (list 0 0 0 2 0 0 2 1)
;    (list 0 2 0 1 2 2 1 2)
;    (list 2 1 1 2 1 1 2 1)
;    (list 1 2 1 2 1 2 1 2)
;    (list 2 1 2 1 2 1 2 1)))

; (define tabla3
;   (list 
;    (list 0 0 0 0 0 0 0 0)
;    (list 0 1 0 0 0 1 0 0)
;    (list 0 0 1 0 1 0 0 0)
;    (list 0 2 1 0 1 2 0 0)
;    (list 0 0 2 1 2 0 0 0)
;    (list 0 0 0 1 0 1 0 0)
;    (list 0 0 0 2 0 0 0 0)
;    (list 0 0 0 0 0 0 0 0)))

; (define tabla4
;   (list 
;    (list 0 0 0 0 0 0 0 0)
;    (list 0 0 0 0 0 0 0 0)
;    (list 0 0 2 2 2 0 0 0)
;    (list 0 0 0 0 0 0 0 0)
;    (list 0 1 0 0 0 0 0 0)
;    (list 0 0 0 0 0 0 0 1)
;    (list 1 0 2 2 2 0 0 1)
;    (list 2 1 2 1 2 1 2 1)))



;; --Pruebas greddy ---

;(ver_izq tabla 1 2 2 3 2 0 0) EJEMPLO DE USO PARA VERIFICAR
;(ver_izq tabla 1 2 2 3 (- 3 1) 0 0) EJEMPLO DE USO PARA VERIFICAR REAL
;
; ; (ver_izqa tabla 1 2 3 3 (- 3 1) (- 3 1) 0 0)


; ; (ver_izqb tabla jugador enemigo i j (- j 1) (+ i 1) fichas puntos)
; ; (ver_izqb tabla 1 2 3 3 (- 3 1) (+ 3 1) 0 0) EJEMPLO DE USO PARA VERIFICAR REAL


; ; (ver_b tabla 1 2 3 3 (- 3 1) 0 0)


; ; (calculator tabla3 1 2 '((3 3)) 0) Usado para verificar su funcionamiento


; ; (objective tabla4 1 2 '((5 0) (4 7) (3 1)))




; (define tablaprofe
;   (list 
;    (list 0 0 0 0 0 0 0 0 0)
;    (list 0 0 0 0 0 0 0 0 0)
;    (list 0 0 0 0 0 0 0 0 0)
;    (list 1 2 0 0 0 0 0 0 0)
;    (list 1 1 1 2 0 0 0 0 0)
;    (list 1 2 1 1 0 0 0 0 0)
;    (list 1 2 2 2 1 2 0 0 0)
;    (list 2 1 1 1 2 2 1 2 0))
; )

; (greedy tablaprofe 2 1)










































; (define (get-max-punctuation lst)
;     (define (car-get-points lst2)
;         (caddar lst2)
;     )
;     (define (get-max-punctuation-aux lst2 max-lst)
;         (cond 
;         ((null? lst2)
;             max-lst
;         )
;         ((> (car-get-points lst2) (car-get-points max-lst))
;              (get-max-punctuation-aux (cdr lst2) 
;                     (append '() (list (car lst2))))
;         )
;         ((= (car-get-points lst2) (car-get-points max-lst))
;             (get-max-punctuation-aux (cdr lst2) 
;                     (append max-lst (list (car lst2))))
;         )
;         (else
;              (get-max-punctuation-aux (cdr lst2) 
;                                         max-lst)
;         )
;         )
;     )
;     (cond
;     ((null? lst)
;         '()
;     )
;     (else
;         (get-max-punctuation-aux (cdr lst) (list (car lst)))
;     )
;     )
; )

; (define board44 '((0 14 15)
;                        (4 5 10)
;                        (11 12 5)
;                        (1 10 -10)
;                        (4 8 15)))
; (get-max-punctuation board44)


; (define frame (new frame% [label "Saludo"][width 500][height 500]))
; (define panel (new vertical-panel% [parent frame]))
; (define msg (new message% [parent panel] [label "¿Cuál es tu nombre?"]))
; (define entry (new text-field% [label "Nombre: "] [parent frame]))


; ;Llamada de acción del botón "check"
; (define (button-callback b e)
;     (let ((name (send entry get-value)))
;       (greet name)
;    )
; )

; (define (greet name)
;   (send msg set-label (format "Hola, ~a!" name)))

      
; ;Crea el botón check    
; (new button% [label "Check"]
;     [parent frame]
;     [callback button-callback])

; (send frame show #t)





; (define listos '())

; (append listos (list 4))

; (define matriz '())
; (define lista '(1 2 3))
; (define lista2 '(11 22 33))
; (define lista3 '(111 222 333))
; (define lista4 '(1111 2222 3333))


; (set! matriz (append matriz (list lista)))
; (set! matriz (append matriz (list lista2)))
; (set! matriz (append matriz (list lista3)))
; (set! matriz (append matriz (list lista4)))

; (display matriz)















































































;;; -------- Pruebas de funciones ---------

; (define board '((1 0 0 0 0 0 0 0 0)
;                 (1 0 0 0 0 0 0 0 0)
;                 (1 0 0 0 0 0 0 0 0)
;                 (2 0 0 0 0 0 0 0 0)
;                 (2 0 0 0 0 0 0 0 0)
;                 (1 1 1 0 0 0 0 0 0)
;                 (2 1 2 2 1 0 0 0 0)
;                 (1 1 2 2 2 0 0 0 0)))

; (define board2 '((  1   2   3   4)
;                 (   5   6   7   8)
;                 (   9   10  11  12))
; )

; ;; get-row

; (define (test-all-positions-row board)
;   (define rows (length board))
;   (for*/list ([row (in-range rows)]
;               )
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
; ; (for-each (lambda (x) (display x) (newline)) (test-all-positions-col board2))
; (get-col 1 board2)

; ;; get-d-r


; (define (test-all-positions-dr board)
;     (define rows (length board))
;     (define cols (length (list-ref board 0)))
;     (for*/list ([row (in-range rows)]
;               [col (in-range cols)])
;     (get-right-diagonal row col board))
; )

; (println "------D-R-------")
; (for-each (lambda (x) (display x) (newline)) (test-all-positions-dr board2))

; ;; get-l-r

; (define (test-all-positions-dl board)
;   (define rows (length board))
;   (define cols (length (list-ref board 0)))
;   (for*/list ([row (in-range rows)]
;               [col (in-range cols)])
;     (get-left-diagonal row col board)))

; (println "------D-L-------")
; (for-each (lambda (x) (display x) (newline)) (test-all-positions-dl board2))

;; check-consecutive

; (check-consecutive '(1 1 1 1 2 3 4) 1)

; (check-consecutive '(1 2 1 1 1 3 4) 1)

; (check-consecutive '(1 2 3 4 5) 1)


; ;; check-win
; (check-win board 1) ; #f
; (check-win board 2) ; #f


;; check-tie
; (define board3 '((1 1 1 1 2 1 2 1 2)
;                 (1 1 1 1 1 1 1 1 1)
;                 (1 1 1 1 2 1 1 1 1)
;                 (2 1 1 1 2 2 2 2 2)
;                 (2 1 1 1 0 2 2 2 2)
;                 (1 1 1 1 1 2 2 2 2)
;                 (2 1 2 2 1 1 2 2 2)
;                 (1 1 2 2 2 2 1 1 1)))

; (check-tie board3)


; ;; insert-token

; (define board   '((0 0 0 0 0 0 0 0 0)
;                   (0 0 0 0 0 0 0 0 0)
;                   (0 0 0 0 0 0 0 0 0)
;                   (2 0 0 0 0 0 0 0 0)
;                   (2 0 0 0 0 0 0 0 0)
;                   (1 0 0 0 0 0 0 0 0)
;                   (1 0 0 0 0 0 0 0 0)
;                   (1 0 0 0 0 0 0 0 0)))

; (pretty-print board)
; (newline)
; (define board2 (insert-token 0 board 1))
; (pretty-print board2)
; (newline)
; (define board3 (insert-token 0 board2 3))
; (pretty-print board3)
; (newline)

; (define board4 (insert-token 0 board3 2))
; (pretty-print board4)
; (newline)

; (define board5 (insert-token 1 board4 4))
; (pretty-print board5)
; (newline)


