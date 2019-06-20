Require Import Coq.Lists.List. Import ListNotations.

Require Import
        Coq.Bool.Bool
        Coq.Strings.Ascii
        Coq.Strings.String.

From SRC Require Export Utils CStrings Simple Semiring.

Local Open Scope char.

(* Act 1 - Scene II, Adding Weights *)

Inductive regex_w {X : Type} (c : ascii) `(s : Semiring X)
  : Type :=
  | Eps_w : regex_w c s
  | Sym_w : ascii -> X -> regex_w c s
  | Alt_w : regex_w c s -> regex_w c s -> regex_w c s
  | Seq_w : regex_w c s -> regex_w c s -> regex_w c s
  | Rep_w : regex_w c s -> regex_w c s.

Definition sym {X : Type} (c : ascii) `(s : Semiring X) :=
  fun x => Sym_w (if eq_ascii x c then one else zero).

