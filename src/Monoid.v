Require Import Coq.Bool.Bool.

Class Monoid (X : Type) :=
  {
    empty : X;
    append : X -> X -> X;

    associativity : forall (x y z : X),
        append x (append y z) = append (append x y) z;

    l_neutral : forall (x : X), append empty x = x;
    r_neutral : forall (x : X), append x empty = x;
  }.

Instance BoolMonoid : Monoid bool :=
  {
    empty := false;
    append x y := x || y;
  }.
  (* associativity *)
  Proof.
    intros. apply orb_assoc.
  (* l_neutral *)
  Proof.
    intros. apply orb_false_l.
  (* r_neutral *)
  Proof.
    intros. apply orb_false_r.
