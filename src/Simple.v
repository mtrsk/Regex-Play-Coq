Require Import Coq.Lists.List.
Import ListNotations.

Require Import Coq.Bool.Bool Coq.Strings.Ascii.
Local Open Scope char.

Require Import Utils AsciiStrings.

Inductive regex : Type :=
  | Eps : regex
  | Sym : ascii -> regex
  | Alt : regex -> regex -> regex
  | Seq : regex -> regex -> regex
  | Rep : regex -> regex.

Definition eq_ascii (a1 a2 : ascii) :=
  match a1, a2 with
  | Ascii b1 b2 b3 b4 b5 b6 b7 b8, Ascii c1 c2 c3 c4 c5 c6 c7 c8 =>
    (eqb b1 c1) && (eqb b2 c2) && (eqb b3 c3) && (eqb b4 c4) &&
    (eqb b5 c5) && (eqb b6 c6) && (eqb b7 c7) && (eqb b8 c8)
  end.

Fixpoint eq_string (s1 s2 : string) :=
  match s1, s2 with
  | [], [] => true
  | x1::s1, x2::s2 => eq_ascii x1 x2 && eq_string s1 s2
  | _, _ => false
  end.

Compute map (fun ui => ui)
        (map (fun p => parts p) [["a";"b";"c"]]).

Fixpoint accept (r : regex) (u : string) : bool :=
  match r, u with
    | Eps, [] => true
    | Sym c, u => eq_string [c] u
    | Alt p q, u => accept p u || accept q u
    | Seq p q, u =>
      let seq_map :=
          map (fun '(u1, u2) => accept p u1 && accept q u2)
              (split u)
      in
      fold_right (fun x y => x || y) false seq_map
    | _,_ => false
  end.
