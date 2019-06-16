Require Import Coq.Lists.List.
Import ListNotations.

Fixpoint split {X : Type} (l : list X) : list (list X * list X) :=
  match l with
    | [] => [([], [])]
    | c::cs =>
      ([], c::cs) :: map (fun '(s1, s2) => (c :: s1, s2)) (split cs)
  end.


Definition athead {X : Type}
  (x : X) (xs : list (list X)) :=
  match xs with
    | [] => []
    | (y :: ys) => (x :: y) :: ys
  end.

Definition non_empty {X : Type} (xs : list (list X)) :=
  match xs with
    | [] => false
    | _ => true
  end.

Fixpoint parts {X : Type}
  (xs : list X) : list (list (list X)) :=
  match xs with
    | [] => [[]]
    | [c] => [[[c]]]
    | (c :: cs) =>
      flat_map (fun ps => [ athead c ps; [c] :: ps])
               (filter non_empty (parts cs))
  end.
