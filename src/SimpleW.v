Require Import Coq.Lists.List. Import ListNotations.

Require Import
        Coq.Bool.Bool
        Coq.Strings.Ascii
        Coq.Strings.String.

From SRC Require Export Utils CStrings Simple Semiring.

Local Open Scope char.

(* Act 1 - Scene II, Adding Weights *)
Inductive regex_w {X : Type} (c : ascii) (s : X)
  :=
  | Eps_w
  | Sym_w : (ascii -> X) -> regex_w c s
  | Alt_w : regex_w c s -> regex_w c s -> regex_w c s
  | Seq_w : regex_w c s -> regex_w c s -> regex_w c s
  | Rep_w : regex_w c s -> regex_w c s.

Definition aux {X : Type} `{X : Semiring} (c : ascii) :=
  fun x => if eq_ascii c x then one else zero.
