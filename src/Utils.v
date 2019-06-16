Require Import Coq.Lists.List.
Import ListNotations.

Fixpoint split {X : Type} (l : list X) : list (list X * list X) :=
  match l with
    | [] => [([], [])]
    | c::cs =>
      ([], c::cs) :: map (fun '(s1, s2) => (c :: s1, s2)) (split cs)
  end.

(* [[c] : p | p <- parts cs] *)

Fixpoint parts_l {X : Type} (l : list X) : list (list (list X)) :=
  match l with
    | [] => [[]]
    | (x::xs) => map (fun p => [x] :: p) (parts_l xs)
  end.

Compute parts_l [1; 2; 3].

(* [(c : p) : ps | (p:ps) <- parts' cs] *)

Fixpoint parts_r {X : Type} (l : list X) : list (list (list X)) :=
  match l with
    | [] => [[]]
    | (x::xs) => [[]]
  end.

