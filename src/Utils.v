Require Import Coq.Lists.List.
Import ListNotations.

Fixpoint split {X : Type} (l : list X) : list (list X * list X) :=
  match l with
    | [] => [([], [])]
    | c::cs =>
      ([], c::cs) :: map (fun '(s1, s2) => (c :: s1, s2)) (split cs)
  end.

Fixpoint parts {X : Type} (l : list X) : list (list (list X)) :=
  match l with
    | [] => [[]]
    | (x::xs) => parts_l x xs ++ parts_r x xs
  end.
