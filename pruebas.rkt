#lang racket
































































































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

