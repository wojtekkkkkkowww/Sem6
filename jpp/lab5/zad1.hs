--binomial
binomial n 0 = 1
binomial n k = 
    if n == k then 1 else binomial (n-1) (k-1) + binomial (n-1) k

--binomial2
pascalInfinite = [1] : map (\l -> zipWith (+) (l ++ [0]) (0:l)) pascalInfinite
binomial2 n k = (pascalInfinite !! n) !! k


--mergesort 
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
  | x < y     = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys

mergesort [] = []
mergesort [x] = [x]
mergesort xs = merge (mergesort firstHalf) (mergesort secondHalf)
  where
    (firstHalf, secondHalf) = splitAt (length xs `div` 2) xs


--de 
extendedGcd a 0 = (a, 1, 0)
extendedGcd a b = (d, y, x - (a `div` b) * y)
  where
    (d, x, y) = extendedGcd b (a `mod` b)

de a b = extendedGcd a b

-- prime_factors
primeFactors n = primeFactors' n 2 []
  where
    primeFactors' 1 _ acc = acc
    primeFactors' n d acc
      | n `mod` d == 0 = primeFactors' (n `div` d) d (d : acc)
      | otherwise      = primeFactors' n (d + 1) acc


--totient
totient n = length [x | x <- [1..n], gcd x n == 1]

-- phi(n) = (p1^(k1 -1)) * (p1 - 1) * (p2^(k2 -1)) * (p2 - 1) *    ... * (pr^(kr -1)) * (pr - 1)

totient2 n = totient2' 1 (primeFactors n)
  where
    totient2' acc [] = acc
    totient2' acc [x] = acc * (x - 1)
    totient2' acc (x:y:xs)
      | x == y    = totient2' (acc * x) (y:xs)
      | otherwise = totient2' (acc * (x - 1)) (y:xs)


--primes
sito :: Int -> [Int]
sito n = sito' [2..n] 0
  where
    sito' [] _ = []
    sito' numbers it
      | it * it == n = numbers
      | otherwise    = head numbers : sito' [x | x <- tail numbers, x `mod` head numbers /= 0] (it + 1)