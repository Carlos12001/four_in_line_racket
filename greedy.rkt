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

;Recibe Matriz, valor del jugador a verificar, valor de jugador enemigo, indice de fila, indice columna, contador de columna para moverse horizontalmente, contador de fichas aliadas sucesivas, contador puntos
(define (ver_izq tablero jugador enem i j cont_h cont_f punt)
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (< cont_h 0) (< cont_h (- j 3)))
     (ver_der tablero jugador enem i j (+ j 1) cont_f punt)) ;verifica no se haya salido del rango a verificar, pasa a verificar lado opuesto.
    ((equal? (list-ref (list-ref tablero i) cont_h) enem)
     (ver_der tablero jugador enem i j (+ j 1) cont_f (- punt 10))) ;Si se topa con ficha enemiga, resta puntos y pasa a verificar lado opuesto
    ((equal? (list-ref (list-ref tablero i) cont_h) 0)
     (ver_izq tablero jugador enem i j (- cont_h 1) cont_f (+ punt 5))) ;Topo con espacio vacío, suma puntos pero no muchos.
    (else
     (ver_izq tablero jugador enem i j (- cont_h 1) (+ cont_f 1) (+ punt 10))) ;Topo con ficha aliada, suma el doble de puntos que vacio.
    ))

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_der tablero jugador enem i j cont_h cont_f punt)
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_h (length (list-ref tablero i))) (> cont_h (+ j 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero i) cont_h) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 10))
    ((equal? (list-ref (list-ref tablero i) cont_h) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_der tablero jugador enem i j (+ cont_h 1) cont_f (+ punt 5)))
    (else
     (ver_der tablero jugador enem i j (+ cont_h 1) (+ cont_f 1) (+ punt 10))) ;Ficha aliada encontrada, suma más puntos.
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
     (ver_derb tablero jugador enem i j (+ j 1) (+ i 1) cont_f (- punt 10))) ;Si se topa con ficha enemiga, resta puntos y pasa a verificar lado opuesto
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0)
     (ver_izqa tablero jugador enem i j (- cont_h 1) (- cont_v 1) cont_f (+ punt 5))) ;Topo con espacio vacío, suma puntos pero no muchos.
    (else
     (ver_izqa tablero jugador enem i j (- cont_h 1) (- cont_v 1) (+ cont_f 1) (+ punt 10))) ;Topo con ficha aliada, suma el doble de puntos que vacio.
    ))

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_derb tablero jugador enem i j cont_h cont_v cont_f punt)
  ;(displayln (list 'ver_derb cont_h cont_v cont_f punt))
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_h (length (list-ref tablero i))) (> cont_h (+ j 3)) (= cont_v (length tablero)) (> cont_v (+ i 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 10))
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_derb tablero jugador enem i j (+ cont_h 1) (+ cont_v 1) cont_f (+ punt 5)))
    (else
     (ver_derb tablero jugador enem i j (+ cont_h 1) (+ cont_v 1) (+ cont_f 1) (+ punt 10))) ;Ficha aliada encontrada, suma más puntos.
    ))

;-----------------------
;  DIAGONAL Der Arriba
;-----------------------

;(ver_izqb tabla jugador enemigo i j (- j 1) (+ i 1) fichas puntos)
;(ver_izqb tabla 1 2 3 3 (- 3 1) (+ 3 1) 0 0) EJEMPLO DE USO PARA VERIFICAR REAL

;Recibe Matriz, valor del jugador a verificar, valor de jugador enemigo, indice de fila, indice columna, contador de columna para moverse horizontalmente, contador de fichas aliadas sucesivas, contador puntos
(define (ver_izqb tablero jugador enem i j cont_h cont_v cont_f punt)
  ;(displayln (list 'ver_izqa cont_h cont_v cont_f punt))
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (< cont_h 0) (< cont_h (- j 3)) (= cont_v (length tablero)) (> cont_v (+ i 3)))
     (ver_derb tablero jugador enem i j (+ j 1) (+ i 1) cont_f punt)) ;verifica no se haya salido del rango a verificar, pasa a verificar lado opuesto.
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem)
     (ver_derb tablero jugador enem i j (+ j 1) (+ i 1) cont_f (- punt 10))) ;Si se topa con ficha enemiga, resta puntos y pasa a verificar lado opuesto
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0)
     (ver_izqb tablero jugador enem i j (- cont_h 1) (+ cont_v 1) cont_f (+ punt 5))) ;Topo con espacio vacío, suma puntos pero no muchos.
    (else
     (ver_izqb tablero jugador enem i j (- cont_h 1) (+ cont_v 1) (+ cont_f 1) (+ punt 10))) ;Topo con ficha aliada, suma el doble de puntos que vacio.
    ))

;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_dera tablero jugador enem i j cont_h cont_v cont_f punt)
  ;(displayln (list 'ver_derb cont_h cont_v cont_f punt))
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_h (length (list-ref tablero i))) (> cont_h (+ j 3)) (< cont_v 0) (< cont_v (- i 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 10))
    ((equal? (list-ref (list-ref tablero cont_v) cont_h) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_derb tablero jugador enem i j (+ cont_h 1) (- cont_v 1) cont_f (+ punt 5)))
    (else
     (ver_derb tablero jugador enem i j (+ cont_h 1) (- cont_v 1) (+ cont_f 1) (+ punt 10))) ;Ficha aliada encontrada, suma más puntos.
    ))


;(ver_b tabla 1 2 3 3 (- 3 1) 0 0)


;Continua el trabajo de la funcion anterior pero hacia lado derecho de la fila
(define (ver_b tablero jugador enem i j cont_v cont_f punt)
  ;(displayln (list 'ver_b cont_h cont_v cont_f punt))
  (cond
    ((equal? cont_f 3) 1000) ;3 fichas aliadas alrededor, 1000 puntos ya que es gane
    ((or (= cont_v (length tablero)) (> cont_v (+ j 3))) ;verifica no se haya salido del rango a verificar
     punt)
    ((equal? (list-ref (list-ref tablero cont_v) j) enem) ;Si se topa con ficha enemiga, resta puntos y finaliza
     (- punt 10))
    ((equal? (list-ref (list-ref tablero cont_v) j) 0) ;Valor igual a 0 suma puntos, pero pocos.
     (ver_b tablero jugador enem i j (+ cont_v 1) cont_f (+ punt 5)))
    (else
     (ver_b tablero jugador enem i j (+ cont_v 1) (+ cont_f 1) (+ punt 10))) ;Ficha aliada encontrada, suma más puntos.
    ))





