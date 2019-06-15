Require Import Coq.Lists.List.
Import ListNotations.

Fixpoint split {X : Type} (l : list X) : list (list X * list X) :=
  match l with
    | [] => [([], [])]
    | c::cs =>
      let fix split' c cs :=
          match cs with
            | [] => []
            | s1::s2 => (c++[s1], s2) :: split' (c++[s1]) s2
          end
      in
      ([], c :: cs) :: ([c], cs) :: split' [c] cs
  end.

Compute (split [1; 2; 3; 4]).
Compute (split [1]).
Compute (split []).
