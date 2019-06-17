Require Import Coq.Lists.List.
Import ListNotations.

Require Import Coq.Bool.Bool Coq.Strings.Ascii.
Local Open Scope char.

Definition string := list ascii.

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
