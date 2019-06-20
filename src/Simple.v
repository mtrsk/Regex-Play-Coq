Require Import Coq.Lists.List. Import ListNotations.

Require Import
        Coq.Bool.Bool
        Coq.Strings.Ascii
        Coq.Strings.String.

From SRC Require Export Utils CStrings.

Inductive regex : Type :=
  | Eps : regex
  | Sym : ascii -> regex
  | Alt : regex -> regex -> regex
  | Seq : regex -> regex -> regex
  | Rep : regex -> regex.

Definition is_null (s : lstring) : bool :=
  match s with
    | [] => true
    | _  => false
  end.

Definition or_fold (l : list bool) : bool :=
  fold_right (orb) false l.

Definition and_fold (l : list bool) : bool :=
  fold_right (andb) true l.

Fixpoint accept' (r : regex) (u : lstring) : bool :=
  match r with
    | Eps => is_null u
    | Sym c => eq_lstring [c] u
    | Alt p q => accept' p u || accept' q u
    | Seq p q =>
      or_fold (map (fun '(u1, u2) => accept' p u1 && accept' q u2)
                   (split u))
    | Rep x =>
      let mparts r' m :=
          map (fun x =>  accept' r' x) m in
      let nparts r' m :=
          map (fun x => mparts r' x) m in
      let result r' m :=
          or_fold (map (and_fold)
                       (nparts r' (parts m)))
      in
      result x u
  end.

Definition accept (r : regex) (u : string) : bool :=
  accept' r (str_to_lstr u).

