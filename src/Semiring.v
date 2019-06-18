Require Import Coq.Bool.Bool Coq.Arith.PeanoNat.

Class Semiring {X : Type}
  (zero : X) (one : X)
  (add : X -> X -> X) (mul : X -> X -> X) :=
  {
    (* Semiring rules *)

    add_comm : forall (x y : X), add x y = add y x;

    zero_mul_r : forall (x : X), mul x zero = zero;

    zero_mul_l : forall (x : X), mul zero x = zero;

    distr_mul : forall (x y z : X),
        mul x (add y z) = add (mul x y) (mul x z);

    distr_add : forall (x y z : X),
        mul (add x y) z = add (mul x z) (mul y z);

    (* Monoid rules*)
    add_associativity : forall (x y z : X),
        add x (add y z) = add (add x y) z;

    add_zero_l : forall (x : X), add zero x = x;
    add_zero_r : forall (x : X), add x zero = x;

    mul_associativity : forall (x y z : X),
        mul x (mul y z) = mul (mul x y) z;

    mul_one_l : forall (x : X), mul one x = x;
    mul_one_r : forall (x : X), mul x one = x;
  }.

Instance BoolSemiring :
  Semiring false true (orb) (andb) :=
  {}.
  (* add_comm *)
  Proof.
    intros. apply orb_comm.
  (* zero_mul_r *)
  Proof.
    intros. apply andb_false_r.
  (* zero_mul_l *)
  Proof.
    intros. apply andb_false_l.
  (* distr_mul *)
  Proof.
    intros. apply andb_orb_distrib_r.
  (* distr_add *)
  Proof.
    intros. apply andb_orb_distrib_l.
  (* Monoid proofs *)
  (* add_associativity *)
  Proof.
    intros. apply orb_assoc.
  (* add_zero_l *)
  Proof.
    intros. apply orb_false_l.
  (* add_zero_r *)
  Proof.
    intros. apply orb_false_r.
  (* mul_associativity *)
  Proof.
    intros. apply andb_assoc.
  (* add_zero_l *)
  Proof.
    intros. apply andb_true_l.
  (* add_zero_r *)
  Proof.
    intros. apply andb_true_r.
  Defined.

Instance NatSemiring : Semiring
  0 1 Nat.add Nat.mul :=
  {}.
  (* add_comm *)
  Proof.
    intros. apply Nat.add_comm.
  (* zero_mul_r *)
  Proof.
    intros. apply Nat.mul_0_r.
  (* zero_mul_l *)
  Proof.
    intros. apply Nat.mul_0_l.
  (* distr_mul *)
  Proof.
    intros. apply Nat.mul_add_distr_l.
  (* distr_add *)
  Proof.
    intros. apply Nat.mul_add_distr_r.
  (* Monoid proofs *)
  (* add_associativity *)
  Proof.
    intros. apply Nat.add_assoc.
  (* add_zero_l *)
  Proof.
    intros. apply Nat.add_0_l.
  (* add_zero_r *)
  Proof.
    intros. apply Nat.add_0_r.
  (* mul_associativity *)
  Proof.
    intros. apply Nat.mul_assoc.
  (* add_zero_l *)
  Proof.
    intros. apply Nat.mul_1_l.
  (* add_zero_r *)
  Proof.
    intros. apply Nat.mul_1_r.
  Defined.
