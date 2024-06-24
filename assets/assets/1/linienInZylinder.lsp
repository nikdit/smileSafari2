(defun c:Line2Zyl (/ i as)
  (setq as (ssget "X" '((0 . "LINE"))))
  (setq i 0)
  (repeat (sslength as)
    (setq lineStart (cdr (assoc 10 (entget(ssname as i)))))
    (setq lineEnd (cdr (assoc 11 (entget(ssname as i)))))
    (setq centerX (/ (+ (car lineStart) (car lineEnd)) 2.0))
    (setq centerY (/ (+ (cadr lineStart) (cadr lineEnd)) 2.0))
    
    ;; Erstellt einen Zylinder
    (command "_cylinder"
             lineStart
             50
             "a"
             lineEnd
    )

    ;; Ändert die Farbe des Zylinders auf Grün
    (entmod
     (list (cons 62 3)  ; Farbcode für Grün (3)
           (cons 0 "CIRCLE")
           (cons 8 "0")
           (cons 10 (list centerX centerY (caddr lineStart)))
           (cons 40 50)
          )
    )
    
    (setq i (1+ i))
  )
  (princ)
)
