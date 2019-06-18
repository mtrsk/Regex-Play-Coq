Require Import Coq.Bool.Bool Coq.Arith.PeanoNat.

Class Monoid {A : Type} (empty : A) (append : A -> A -> A):=
  {
    associativity : forall (x y z : A),
        append x (append y z) = append (append x y) z;

    l_neutral : forall (x : A), append empty x = x;
    r_neutral : forall (x : A), append x empty = x;
  }.

Instance BoolMonoidOr : Monoid false orb :=
  {}.
  (* associativity *)
  Proof.
    intros. apply orb_assoc.
  (* l_neutral *)
  Proof.
    intros. apply orb_false_l.
  (* r_neutral *)
  Proof.
    intros. apply orb_false_r.
  Defined.

Instance BoolMonoidAnd : Monoid true andb :=
  {}.
  (* associativity *)
  Proof.
    intros. apply andb_assoc.
  (* l_neutral *)
  Proof.
    intros. apply andb_true_l.
  (* r_neutral *)
  Proof.
    intros. apply andb_true_r.
  Defined.

Instance NatMonoidPlus : Monoid 0 Nat.add :=
  {}.
  (* associativity *)
  Proof.
    intros. apply Nat.add_assoc.
  (* l_neutral *)
  Proof.
    intros. apply Nat.add_0_l.
  (* r_neutral *)
  Proof.
    intros. apply Nat.add_0_r.
  Defined.

Instance NatMonoidMul : Monoid 1 Nat.mul :=
  {}.
  (* associativity *)
  Proof.
    intros. apply Nat.mul_assoc.
  (* l_neutral *)
  Proof.
    intros. apply Nat.mul_1_l.
  (* r_neutral *)
  Proof.
    intros. apply Nat.mul_1_r.
  Defined.
