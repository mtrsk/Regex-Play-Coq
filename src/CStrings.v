Require Import Coq.Lists.List. Import ListNotations.

Require Import
    Coq.Bool.Bool
    Coq.Strings.Ascii
    Coq.Strings.String.

Local Open Scope char_scope.

Definition lstring := list ascii.

Definition eq_ascii (a1 a2 : ascii) :=
  match a1, a2 with
  | Ascii b1 b2 b3 b4 b5 b6 b7 b8, Ascii c1 c2 c3 c4 c5 c6 c7 c8 =>
    (eqb b1 c1) && (eqb b2 c2) && (eqb b3 c3) && (eqb b4 c4) &&
    (eqb b5 c5) && (eqb b6 c6) && (eqb b7 c7) && (eqb b8 c8)
  end.

Fixpoint eq_string (s1 s2 : string) :=
  match s1, s2 with
    | EmptyString, EmptyString => true
    | _, EmptyString => false
    | EmptyString, _ => false
    | String x xs, String y ys => (eq_ascii x y) && eq_string xs ys
  end.

Fixpoint str_to_lstr (s : string) : lstring :=
  match s with
    | EmptyString => []
    | String x xs => x :: str_to_lstr xs
  end.

Fixpoint eq_lstring (s1 s2 : lstring) :=
  match s1, s2 with
    | [], [] => true
    | _, [] => false
    | [] , _ => false
    | x::xs, y::ys => (eq_ascii x y) && eq_lstring xs ys
  end.

Fixpoint show_lstr (s : lstring) : string :=
  match s with
    | [] => ""%string
    | x::xs => (String x "") ++ show_lstr xs
  end.

Definition show_ascii (c : ascii) : string := String c "".

Class Show A : Type :=
  {
    show : A -> string
  }.

Instance ShowLStr : Show lstring :=
  {
    show := show_lstr
  }.

Instance showAscii: Show ascii :=
  {
    show := show_ascii
  }.

