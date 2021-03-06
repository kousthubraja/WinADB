(define (make-family age ls rs)
	(list age ls rs)
)

(define (get-age family)
	(car family)
)

(define (get-left family)
	(cadr family)
)

(define (get-right family)
	(caddr family)
)

(define (is-empty? family)
	(null? family)
)

(define (count-between a1 a2 family)
	(if (is-empty? family) 0
		(if (and (> (get-age family) a1) (< (get-age family) a2))
			(+ 1 (+ (count-between a1 a2 (get-left family))
					(count-between a1 a2 (get-right family))))
			(+ (count-between a1 a2 (get-left family))
					(count-between a1 a2 (get-right family)))
		)
	)
)

(define (get-rightmost-child family)
	(if (is-empty? family) '()
		(if (is-empty? (get-right family))
			(get-age family)
			(get-rightmost-child (get-right family))
		)
	)
)

(define (get-leftmost-child family)
	(if (is-empty? family) '()
		(if (is-empty? (get-left family))
			(get-age family)
			(get-leftmost-child (get-left family))
		)
	)
)

(define (lower age family)
	(if (is-empty? (search age family))
		(get-leftmost-child family)
		(if (is-empty? (get-left (search age family)))
			(if (= age (get-age (search (get-leftmost-child family) family))) '() (get-parent (+ -1 age) -1 family))
			(get-rightmost-child (get-left (search age family)))
		)
	)
)

(define (higher age family)
	(if (is-empty? (search age family))
		(get-rightmost-child family)
		(if (is-empty? (get-right (search age family)))
			(if (= age (get-age (search (get-rightmost-child family) family))) '() (get-parent (+ 1 age) 1 family))
			(get-leftmost-child (get-right (search age family)))
		)
	)
)

(define (main1 age family)
	(list (lower age family) (higher age family)))


(define (search age family)
	(if (is-empty? family) '()
		(cond 	((= age (get-age family)) family)
				((< age (get-age family)) (search age (get-left family)))
				((> age (get-age family)) (search age (get-right family)))
		)
	)
)

(define (get-parent age x family)
	(if (is-empty? (search age family))
		(get-parent (+ x age) x family) 
		age
	)
)

;(define age-bst '(40 (14 () (35 (26 (23 (17 () (18 () (22 (20 () ()) ()))) ()) ()) ())) ()))
(define age-bst '(16 (12 (10 () ()) (14 (13 () ()) ())) (18 (17 () ()) (20 () (22 () ())))))
;(count-between 20 30 age-bst)
(main1 20 age-bst)