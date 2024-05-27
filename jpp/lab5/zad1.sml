fun time (action, arg) = let
  val timer = Timer.startCPUTimer ()
  val _ = action arg
  val times = Timer.checkCPUTimer timer
in
  Time.+ (#usr times, #sys times)
end


(* binomial *)
fun binomial n 0 = 1
  | binomial n k = 
    if n = k then 1 
    else binomial (n-1) (k-1) + binomial (n-1) k;



fun pascal_row 0 = [1]
  | pascal_row n =
      let
          val prev_row = pascal_row (n - 1)
          val extended_prev_row = prev_row @ [0]
          val shifted_prev_row = 0 :: prev_row
      in
          ListPair.map (op +) (extended_prev_row, shifted_prev_row)
      end


fun binomial2 n k = List.nth (pascal_row n, k);


(*merge sort*)

fun mergesort lst =
    let
        fun split lst =
            let
                val len = length lst
                val half = len div 2
            in
                (List.take (lst, half), List.drop (lst, half))
            end

        fun merge (left, right) =
            case (left, right) of
                ([], _) => right
              | (_, []) => left
              | (x::xs, y::ys) => if x < y then x :: merge (xs, right)
                                        else y :: merge (left, ys)

        val splitted = split lst
        val left = #1 splitted
        val right = #2 splitted
    in
        case lst of
            [] => []
          | [_] => lst
          | _ => merge (mergesort left, mergesort right)
    end



(* diophant eq  *)
fun extended_gcd a 0 = (a, 1, 0)
  | extended_gcd a b = 
    let val (d, x, y) = extended_gcd b (a mod b)
    in 
        (d, y, x - y * (a div b))
    end;

fun de a b =  extended_gcd a b


(* prime factors *)
fun prime_factors n =
  let
    fun prime_factors 1 d acc = acc
        | prime_factors n d acc = 
            if n mod d = 0 then prime_factors (n div d) d (d::acc)
            else prime_factors n (d+1) acc
  in
    prime_factors n 2 []
  end;


(*totient *)
fun totient n =
  let
    fun gcd a 0 = a
      | gcd a b = gcd b (a mod b)

    fun totient n k acc =
      if k = n then acc
      else if gcd n k = 1 then totient n (k + 1) (acc + 1)
      else totient n (k + 1) acc
  in
    totient n 1 0
  end;


(*totient2 *)
(* phi(n) = (p1^(k1 -1)) * (p1 - 1) * (p2^(k2 -1)) * (p2 - 1) * ... * (pr^(kr -1)) * (pr - 1)*)
fun totient2 n =
  let
    fun totient2 acc divisors =
      case divisors of
          [] => acc
        | first :: second :: rest =>
            if first = second then totient2 (acc * first) (second :: rest)
            else totient2 (acc * (first - 1)) (second :: rest)
        | first :: [] => acc * (first - 1)
  in
    totient2 1 (prime_factors n)
  end;



(* primes *)
fun sito n =
  let
    fun range a b = if a > b then [] else a :: range (a + 1) b

    fun sito_ numbers it =
        if it * it >= n then numbers
        else
          case numbers of
            [] => []
          | first :: rest =>
            first :: sito_ (List.filter (fn x => x mod first <> 0) rest) (it + 1)

  in
    sito_ (range 2 n) 0
  end;



