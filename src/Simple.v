Require Import Coq.Lists.List.
Import ListNotations.

Require Import Bool Ascii String.
Open Scope string_scope.

Inductive regex : Type :=
  | Eps : regex
  | Sym : ascii -> regex
  | Alt : regex -> regex -> regex
  | Seq : regex -> regex -> regex
  | Rep : regex -> regex.

Inductive regex_match : string -> regex -> Prop :=
  | MEps : regex_match "" Eps
  | MSym : forall (c : ascii),
      regex_match (String c "") (Sym c)
  | MAltL : forall (s : string) (r1 r2 : regex),
      regex_match s r1 -> regex_match s (Alt r1 r2)
  | MAltR : forall (s : string) (r1 r2 : regex),
      regex_match s r2 -> regex_match s (Alt r1 r2)
  | MSeq : forall (s1 s2 : string) (r1 r2 : regex),
      regex_match s1 r1 ->
      regex_match s2 r2 ->
      regex_match (s1 ++ s2) (Seq r1 r2)
  | MRep0 : forall (r : regex), regex_match "" (Rep r)
  | MRep1 : forall (s1 s2 : string) (r : regex),
      regex_match s1 r ->
      regex_match s2 (Rep r) ->
      regex_match (s1++s2) (Rep r).

Notation "s ~= re" := (regex_match s re) (at level 80).

Compute ("a" ~= Sym "a").
Compute ("b" ~= Alt (Sym "a") (Sym "b")).
Check ("b" ~= Alt (Sym "a") (Sym "b")).
