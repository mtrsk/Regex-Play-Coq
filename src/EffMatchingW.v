Require Import Coq.Lists.List.
Import ListNotations.

Require Import Coq.Bool.Bool Coq.Strings.Ascii.
Local Open Scope char.

From SRC Require Export CStrings Semiring.

(* Act II - Scene I, with Semirings *)

Inductive Re_w c s : Type :=
  | Eps_w : Re_w c s
  | Sym_w : c -> s -> (Re_w c s)
  | Alt_w : (Re_w c s) -> (Re_w c s) -> (Re_w c s)
  | Seq_w : (Re_w c s) -> (Re_w c s) -> (Re_w c s)
  | Rep_w : (Re_w c s) -> (Re_w c s).

Record Reg_w
  {A : Type} {zero : A} {one : A}
  {add : A -> A -> A} {mul : A -> A -> A}
  (s : Semiring zero one add mul) (c : A) :=
  {
    empty_w : s;
    final_w : s;
    reg_w : Re_w c s;
  }.

Definition eps_w {A : Type}
  {zero : A} {one : A}
  {add : A -> A -> A} {mul : A -> A -> A}
  {s : Semiring zero one add mul}
  : Reg_w c s :=
  {|
    empty_w := s.(one);
    final_w := s.(zero);
    reg_w := Eps_w c s;
  |}.
