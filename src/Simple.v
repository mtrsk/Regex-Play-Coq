Require Import Coq.Lists.List.
Import ListNotations.

Require Import Bool Ascii String.
Open Scope string_scope.

Require Import Utils.

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
  | EmptyString,  EmptyString  => true
  | String x1 s1, String x2 s2 => eq_ascii x1 x2 && eq_string s1 s2
  | _, _                       => false
  end.

Fixpoint accept (r : regex) (s : string) : bool :=
  match r, s with
    | Eps, "" => true
    | Sym c, s => eq_string (String c "") s
    | Alt r1 r2, s => accept r1 s || accept r2 s
    | _,_ =>  false
  end.

Compute (accept Eps "a").
Compute (accept (Sym "a") "a").
Compute (accept (Sym "a") "b").
Compute (accept (Alt (Sym "a") (Sym "b")) "b").
