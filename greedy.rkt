#lang racket

;; ------------------------
;;     Matriz de PRUEBA 
;; ------------------------

(define tabla
  (list 
   (list 0 0 0 0 0 0 0 0)
   (list 0 0 0 0 0 1 0 0)
   (list 0 0 1 0 1 0 0 0)
   (list 0 2 1 0 1 2 0 0)
   (list 0 0 2 1 1 0 0 0)
   (list 0 0 0 1 0 1 0 0)
   (list 0 0 0 1 0 0 0 0)
   (list 0 0 0 0 0 0 0 0)))

(define tabla2
  (list 
   (list 0 0 0 0 0 0 0 0)
   (list 0 0 0 0 0 0 0 1)
   (list 0 0 0 0 0 0 0 2)
   (list 0 0 0 2 0 0 2 1)
   (list 0 2 0 1 2 2 1 2)
   (list 2 1 1 2 1 1 2 1)
   (list 1 2 1 2 1 2 1 2)
   (list 2 1 2 1 2 1 2 1)))

(define tabla3
  (list 
   (list 0 0 0 0 0 0 0 0)
   (list 0 1 0 0 0 1 0 0)
   (list 0 0 1 0 1 0 0 0)
   (list 0 2 1 0 1 2 0 0)
   (list 0 0 2 1 2 0 0 0)
   (list 0 0 0 1 0 1 0 0)
   (list 0 0 0 2 0 0 0 0)
   (list 0 0 0 0 0 0 0 0)))

(define tabla4
  (list 
   (list 0 0 0 0 0 0 0 0)
   (list 0 0 0 0 0 0 0 0)
   (list 0 0 2 2 2 0 0 0)
   (list 0 0 0 0 0 0 0 0)
   (list 0 1 0 0 0 0 0 0)
   (list 0 0 0 0 0 0 0 1)
   (list 1 0 2 2 2 0 0 1)
   (list 2 1 2 1 2 1 2 1)))

(define tablaprofe
  (list 
   (list 0 0 0 0 0 0 0 0)
   (list 0 0 0 0 0 0 0 0)
   (list 0 0 0 0 0 0 0 0)
   (list 0 0 0 0 0 0 0 0)
   (list 0 0 0 0 0 0 0 0)
   (list 0 0 0 1 0 0 0 0)
   (list 0 0 2 2 0 0 0 0)
   (list 2 1 1 1 2 0 0 0)))


         
;Recibe Matriz, valor del jugador a verificar, valor de jugador enemigo, indice de fila, indice columna, contador de columna para moverse horizontalmente, contador de fichas aliadas sucesivas, contador puntos
(define (ver_izq tablero jugador enem i j cont_h cont_f punt)
  ;(displayln (list 'ver_izq cont_h cont_f punt))
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
    ))

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_der tablero jugador enem i j cont_h cont_f punt)
  ;(displayln (list 'ver_der cont_h cont_f punt))
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
    ))

;(ver_izq tabla 1 2 2 3 2 0 0) EJEMPLO DE USO PARA VERIFICAR
;(ver_izq tabla 1 2 2 3 (- 3 1) 0 0) EJEMPLO DE USO PARA VERIFICAR REAL

;-----------------------
;  DIAGONAL Izq Arriba
;-----------------------

;(ver_izqa tabla 1 2 3 3 (- 3 1) (- 3 1) 0 0)

;Recibe Matriz, valor del jugador a verificar, valor de jugador enemigo, indice de fila, indice columna, contador de columna para moverse horizontalmente, contador de fichas aliadas sucesivas, contador puntos
(define (ver_izqa tablero jugador enem i j cont_h cont_v cont_f punt)
  ;(displayln (list 'ver_izqa cont_h cont_v cont_f punt))
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (< cont_h 0) (< cont_h (- j 3)) (< cont_v 0) (< cont_v (- i 3)))
     (ver_derb tablero jugador enem i j (+ j 1) (+ i 1) cont_f punt)) ;verifica no se haya salido del rango a verificar, pasa a verificar lado opuesto.
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem)
     (ver_derb tablero jugador enem i j (+ j 1) (+ i 1) cont_f (- punt 5))) ;Si se topa con ficha enemiga, resta puntos y pasa a verificar lado opuesto
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0)
     (ver_izqa tablero jugador enem i j (- cont_h 1) (- cont_v 1) cont_f (+ punt 3))) ;Topo con espacio vacío, suma puntos pero no muchos.
    (else
     (ver_izqa tablero jugador enem i j (- cont_h 1) (- cont_v 1) (+ cont_f 1) (+ punt 15))) ;Topo con ficha aliada, suma el doble de puntos que vacio.
    ))

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_derb tablero jugador enem i j cont_h cont_v cont_f punt)
  ;(displayln (list 'ver_derb cont_h cont_v cont_f punt))
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_h (length (list-ref tablero i))) (> cont_h (+ j 3)) (= cont_v (length tablero)) (> cont_v (+ i 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 5))
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_derb tablero jugador enem i j (+ cont_h 1) (+ cont_v 1) cont_f (+ punt 3)))
    (else
     (ver_derb tablero jugador enem i j (+ cont_h 1) (+ cont_v 1) (+ cont_f 1) (+ punt 15))) ;Ficha aliada encontrada, suma más puntos.
    ))

;-----------------------
;  DIAGONAL Der Arriba
;-----------------------

;(ver_izqb tabla jugador enemigo i j (- j 1) (+ i 1) fichas puntos)
;(ver_izqb tabla 1 2 3 3 (- 3 1) (+ 3 1) 0 0) EJEMPLO DE USO PARA VERIFICAR REAL

;Recibe Matriz, valor del jugador a verificar, valor de jugador enemigo, indice de fila, indice columna, contador de columna para moverse horizontalmente, contador de fichas aliadas sucesivas, contador puntos
(define (ver_izqb tablero jugador enem i j cont_h cont_v cont_f punt)
  ;(displayln (list 'ver_izqb cont_h cont_v cont_f punt))
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (< cont_h 0) (< cont_h (- j 3)) (= cont_v (length tablero)) (> cont_v (+ i 3)))
     (ver_dera tablero jugador enem i j (+ j 1) (- i 1) cont_f punt)) ;verifica no se haya salido del rango a verificar, pasa a verificar lado opuesto.
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem)
     (ver_dera tablero jugador enem i j (+ j 1) (- i 1) cont_f (- punt 5))) ;Si se topa con ficha enemiga, resta puntos y pasa a verificar lado opuesto
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0)
     (ver_izqb tablero jugador enem i j (- cont_h 1) (+ cont_v 1) cont_f (+ punt 3))) ;Topo con espacio vacío, suma puntos pero no muchos.
    (else
     (ver_izqb tablero jugador enem i j (- cont_h 1) (+ cont_v 1) (+ cont_f 1) (+ punt 15))) ;Topo con ficha aliada, suma el doble de puntos que vacio.
    ))

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_dera tablero jugador enem i j cont_h cont_v cont_f punt)
  ;(displayln (list 'ver_dera cont_h cont_v cont_f punt))
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_h (length (list-ref tablero i))) (> cont_h (+ j 3)) (< cont_v 0) (< cont_v (- i 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 5))
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_dera tablero jugador enem i j (+ cont_h 1) (- cont_v 1) cont_f (+ punt 3)))
    (else
     (ver_dera tablero jugador enem i j (+ cont_h 1) (- cont_v 1) (+ cont_f 1) (+ punt 15))) ;Ficha aliada encontrada, suma más puntos.
    ))


;(ver_b tabla 1 2 3 3 (- 3 1) 0 0)


;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_b tablero jugador enem i j cont_v cont_f punt)
  ;(displayln (list 'ver_b cont_v cont_f punt))
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
    ))




;Obtiene un valor en el tablero. tablero get
(define (mget board i j)
  (list-ref (list-ref board i) j))




;-----------------------
;       El Voraz
;-----------------------

(define (greedy board player enemy)
  (solution
   (selection
    (objective board player enemy
               (feasibility board)))))





;-----------------------
;      Viabilidad
;-----------------------

(define (feasibility board)
  (fea_aux board (length board) (length (list-ref board 0)) (- (length board) 1) 0 '() ))

(define (fea_aux board i j cont_v cont_h res)
  (cond
    ((< cont_v 0)
     (fea_aux board i j (- i 1) (+ cont_h 1) res))
    ((= cont_h j)
     res)
    ((= (mget board cont_v cont_h) 0)
     (fea_aux board i j (- i 1) (+ cont_h 1) (append res (list (list cont_v cont_h)))))
    (else
     (fea_aux board i j (- cont_v 1) cont_h res))))
    


;-----------------------
;       Objetivo
;-----------------------

(define (getij lst index num)
  (cond
    ((= num 1)
     (car (list-ref lst index)))
    (else
     (cadr (list-ref lst index)))))

;(calculator tabla3 1 2 '((3 3)) 0) Usado para verificar su funcionamiento

(define (calculator board player enemy fea_res index)
  (ver_izq board player enemy (getij fea_res index 1) (getij fea_res index 2) (- (getij fea_res index 2) 1) 0
           (ver_izqa board player enemy (getij fea_res index 1) (getij fea_res index 2) (- (getij fea_res index 2) 1) (- (getij fea_res index 1) 1) 0
                     (ver_izqb board player enemy (getij fea_res index 1) (getij fea_res index 2) (- (getij fea_res index 2) 1) (+ (getij fea_res index 1) 1) 0
                               (ver_b board player enemy (getij fea_res index 1) (getij fea_res index 2) (+ (getij fea_res index 1) 1) 0 0)))))

(define (future-calculator board player enemy fea_res index)
  (future_aux board player enemy (- (getij fea_res index 1) 1) (getij fea_res index 2)))

(define (future_aux board player enemy i j)
  (cond
    ((< i 0) 0)
    (else
     (ver_izq board player enemy i j (- j 1) 0
           (ver_izqa board player enemy i j (- j 1) (- i 1) 0
                     (ver_izqb board player enemy i j (- j 1) (+ i 1) 0
                               (ver_b board player enemy i j (+ i 1) 0 0)))))))

           

;(objective tabla4 1 2 '((5 0) (4 7) (3 1)))

(define (objective board player enemy fea_res)
  (obj_aux board player enemy fea_res 0 '()))

(define (obj_aux board player enemy fea_res index res)
  (displayln (list 'obj_aux fea_res index res))
  (cond
    ((= (length res) (length fea_res))
     res)
    (else
     (obj_aux board player enemy fea_res (+ index 1)
              (append res (list (list (getij fea_res index 1) (getij fea_res index 2)
                                      (balance
                                       (calculator board player enemy fea_res index)
                                       (calculator board enemy player fea_res index)
                                       (future-calculator board enemy player fea_res index)
                                       )))))
     )))


(define (balance playerscore enemyscore futurescore)
  (cond ((> playerscore 900) 1000)
        ((> enemyscore 900) 500)
        ((> futurescore 900) -500)
        (else playerscore)))


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
     )))

(define (solution_aux lst)
  (define random-index (random (length lst)))
  (cadr (list-ref lst random-index )))



























