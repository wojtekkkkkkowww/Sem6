
;;binomial

(defun binomial (n k)
  ( if (or (= k 0) (= k n)) 1 (+ (binomial (- n 1) (- k 1)) (binomial (- n 1) k))
  ) 
)


(defun pascal-row (n)
  (if (zerop n)
      '(1)
      (let* ((prev-row (pascal-row (1- n)))
             (extended-prev-row (append prev-row '(0)))
             (shifted-prev-row (cons 0 prev-row)))
        (mapcar #'+ extended-prev-row shifted-prev-row))))
  
(defun binomial2 (n k)
  (nth k (pascal-row n)))

 

;; mergesort nie ogonowy
(defun mergesort (lst)
  (labels 
  ((split (lst)
    (let* ((len (length lst))
          (half (floor (/ len 2))))
      (list (subseq lst 0 half) (subseq lst half))))
  (merge (left right)
    (cond
      ((null left) right)
      ((null right) left)
      ((< (car left) (car right)) (cons (car left) (merge (cdr left) right)))
      (t (cons (car right) (merge left (cdr right))))))
  )
  (cond
    ((null (cdr lst)) lst)
    (t (let* ((splitted (split lst))
              (left (car splitted))
              (right (cadr splitted)))
          (merge (mergesort left) (mergesort right)))
    ))))



;; de 
(defun extended_gcd (a b)
  ( cond 
      ((= b 0) (list a 1 0))
      (t (let* (
            (lst (extended_gcd b (mod a b)))
            (d (car lst))
            (x (cadr lst))
            (y (caddr lst)))
          (list d y (- x (* y (floor (/ a b)))))
        )
      )
  )
)

(defun de (a b)
  (extended_gcd a b)
)


;; prime factors

(defun prime_factors (n)
  ( labels ( 
    (_prime_factors (n d acc)
      (cond
        ((= n 1) acc)
        ((= (mod n d) 0) (_prime_factors (/ n d) d (cons d acc)))
        (t (_prime_factors n (+ d 1) acc))
      )
    ))
    (_prime_factors n 2 nil)
  )
)

;; totient

(defun totient (n)
  (labels (
    (_totient (n k acc)
        (cond
        ((= k n) acc)
        ((= (gcd n k) 1) (_totient n (+ k 1) (+ acc 1)))
        (t (_totient n (+ k 1) acc))
      )
    ))
    (_totient n 1 0)
  )

)

;; phi(n) = (p1^(k1 -1)) * (p1 - 1) * (p2^(k2 -1)) * (p2 - 1) *    ... * (pr^(kr -1)) * (pr - 1)

(defun totient2 (n)
  (labels (
    (_totient2 (acc divisors)
      (let (
        (first (car divisors))
        (second (cadr divisors))
        (rest (cdr divisors)))
      (cond 
        ((null rest) (* acc (- first 1)))
        ((equal first second) 
          (_totient2 (* acc first) rest))
        (t (_totient2 (* acc (- first 1)) rest))))
    ))
    (_totient2 1 (prime_factors n))
))


;; prime

(defun range (a b)
  (labels (
    (_range (a b acc)
      (cond
        ((= a b) (reverse (cons a acc)))
        (t (_range (+ a 1) b (cons a acc)))
    )))
    (_range a b nil)
))


(defun sito (n)
  (labels ((_sito (numbers it)
    (cond  
      ((null numbers) nil)
      ((=(* it it) n) numbers)
      (t (cons (car numbers) 
               (_sito (remove-if (lambda (x) (= 0 (mod x (car numbers)))) (cdr numbers)) (+ it 1))))
    )))
  (_sito (range 2 n) 0)))


(defun sito2 (n)
  (labels ((_sito (numbers it)
    (cond  
      ((null numbers) nil)
      ((=(* it it) n) numbers)
      (t (cons (car numbers) 
               (_sito (remove-if (lambda (x) (= 0 (mod x (car numbers)))) (cdr numbers)) (+ it 1))))
    )))
  (_sito (loop for i from 2 to n collect i) 0)))