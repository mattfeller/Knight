(defun modify-list (list entry new-value) ;; returns given list with specified entry changed to new-value
  (if (= entry 0)
      (cons new-value (cdr list))
      (cons (car list) (modify-list (cdr list) (- entry 1) new-value))
  )
)

(defun modify-double-list (double-list entry new-value) ;; returns given double-list with specified entry changed to new-value
  (modify-list double-list (car entry) (modify-list (nth (car entry) double-list) (car (cdr entry)) new-value))
)

(defun create-list (n) ;; returns a list of n entries of value nil
  (if (<= n 0)
      nil
      (cons nil (create-list (- n 1)))
  )
)

(defun create-double-list (m n) ;; returns a double-list with m rows and n columns with entries nil
  (if (<= m 0)
      nil
      (cons (create-list n) (create-double-list (- m 1) n))
  )
)

(defun check-spot (double-list m n step k l) ;; if (k,l) entry is valid and has not been visited yet, continues tour from that position
  (cond ((>= k m) nil)
        ((>= l n) nil)
        ((< k 0) nil)
        ((< l 0) nil)
        ((null (nth l (nth k double-list)))
         (continue-tour (modify-double-list double-list (list k l) step) m n step k l))
        (t nil)
  )
)

(defun continue-tour (double-list m n step k l) ;; given a tour on an m by n board up to the given step (double-list with step+1 entries being 0 through step and the rest being nil, where step is the (k,l) entry), continues the tour. returns the completed tour or returns nil if not possible
  (if (= step (- (* m n) 1))
      double-list
      (or ;; checks each direction. if one direction returns nil, checks the next direction. returns nil if all directions return nil
       (check-spot double-list m n (+ step 1) (- k 2) (+ l 1)) ;; check up 2 right 1
       (check-spot double-list m n (+ step 1) (- k 1) (+ l 2)) ;; check up 1 right 2
       (check-spot double-list m n (+ step 1) (+ k 1) (+ l 2)) ;; check down 1 right 2
       (check-spot double-list m n (+ step 1) (+ k 2) (+ l 1)) ;; check down 2 right 1
       (check-spot double-list m n (+ step 1) (+ k 2) (- l 1)) ;; check down 2 left 1
       (check-spot double-list m n (+ step 1) (+ k 1) (- l 2)) ;; check down 1 left 2
       (check-spot double-list m n (+ step 1) (- k 1) (- l 2)) ;; check up 1 left 2
       (check-spot double-list m n (+ step 1) (- k 2) (- l 1)) ;; check up 2 left 1
      )
  )
)

;; main function: user inputs four integers dim1 dim2 n m, returns a knight's tour of the dim1 by dim2 board starting at position (n,m), returning nil if impossible
(print "What are the dimensions of the board you would like to use?")
(terpri)
(let ((dim1 (read *standard-input* nil)) (dim2 (read *standard-input*)))
  (if (or (> dim1 6) (> dim2 6)) ;; checks that dimensions are less than or equal to 6
      (print "Sorry, too hard!")
      (progn (print "What space would you like to start at?")
       (terpri)
       (write (check-spot (create-double-list dim1 dim2) dim1 dim2 0 (read *standard-input* nil) (read *standard-input* nil)))
      )
  )
)
