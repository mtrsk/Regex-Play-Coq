Require Import Coq.Bool.Bool Coq.Arith.PeanoNat.

Class Monoid (X : Type) :=
  {
    empty : X;
    append : X -> X -> X;

    associativity : forall (x y z : X),
        append x (append y z) = append (append x y) z;

    l_neutral : forall (x : X), append empty x = x;
    r_neutral : forall (x : X), append x empty = x;
  }.

Instance BoolMonoidOr : Monoid bool :=
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

Instance BoolMonoidAnd : Monoid bool :=
  {
    empty := true;
    append x y := x && y;
  }.
  (* associativity *)
  Proof.
    intros. apply andb_assoc.
  (* l_neutral *)
  Proof.
    intros. apply andb_true_l.
  (* r_neutral *)
  Proof.
    intros. apply andb_true_r.

Instance NatMonoidPlus : Monoid nat :=
  {
    empty := 0;
    append := Nat.add;
  }.
  (* associativity *)
  Proof.
    intros. apply Nat.add_assoc.
  (* l_neutral *)
  Proof.
    intros. simpl. reflexivity.
  (* r_neutral *)
  Proof.
    intros.
    rewrite <- plus_n_O.
    reflexivity.

Instance NatMonoidMul : Monoid nat :=
  {
    empty := 1;
    append := Nat.mul;
  }.
  (* associativity *)
  Proof.
    intros. apply Nat.mul_assoc.
  (* l_neutral *)
  Proof.
    intros. apply Nat.mul_1_l.
  (* r_neutral *)
  Proof.
    intros. apply Nat.mul_1_r.
