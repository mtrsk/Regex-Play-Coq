Require Import Coq.Lists.List.
Import ListNotations.

Require Import Coq.Bool.Bool Coq.Strings.Ascii.
Local Open Scope char.

From SRC Require Export CStrings.

(* Act II - Scene 0, Before Semirings *)

Inductive regex : Type :=
  | Eps : regex
  | Sym : bool -> ascii -> regex
  | Alt : regex -> regex -> regex
  | Seq : regex -> regex -> regex
  | Rep : regex -> regex.

Fixpoint empty (x : regex) : bool :=
  match x with
    | Eps => true
    | Sym _ _ => false
    | Alt p q => empty p || empty q
    | Seq p q => empty p && empty q
    | Rep r => true
  end.

Fixpoint final (x : regex) : bool :=
  match x with
    | Eps => false
    | Sym b _ => b
    | Alt p q => final p || final q
    | Seq p q => final p && final q
    | Rep r => final r
  end.

Fixpoint shift (m : bool) (x : regex) (c : ascii)
  : regex :=
  match x with
    | Eps => Eps
    | Sym _ x =>
      Sym (m && eq_ascii x c) x
    | Alt p q =>
      Alt (shift m p c) (shift m p c)
    | Seq p q =>
      Seq (shift m p c)
          (shift (m && empty p || final q) q c)
    | Rep r =>
      Rep (shift (m || final r) r c)
  end.

(* TODO fix rmatch *)
Definition rmatch (r : regex) (s : string) : bool :=
  match s with
    | [] => empty r
    | (c :: cs) =>
      final (fold_left (shift false) (shift true r c) cs)
  end.
