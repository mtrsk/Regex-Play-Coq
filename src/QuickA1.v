Require Import Coq.Lists.List. Import ListNotations.

Require Import
        Coq.Bool.Bool
        Coq.Strings.Ascii
        Coq.Strings.String.

From SRC Require Export Utils CStrings Simple.

From QuickChick Require Import QuickChick. Import QcNotation.
Import QcDefaultNotation. Open Scope qc_scope.
Import GenLow GenHigh.

Local Open Scope string.
Local Open Scope char.


Fixpoint show_regex (r : regex) : string :=
  match r with
    | Eps => "ε"
    | Sym c => show_ascii c
    | Alt p q =>
      "(" ++ (show_regex p) ++ "|" ++ (show_regex q) ++ ")"
    | Seq p q =>
      "(" ++ (show_regex p) ++ (show_regex q) ++ ")"
    | Rep x =>
      show_regex x ++ "*"
  end.

Instance ShowRegex : Show regex :=
  {
    show := show_regex
  }.

Fixpoint show_lstring (l : lstring) : string :=
  match l with
    | [] => "ε"
    | [x] => (String x "")
    | x::xs => (String x "") ++ show_lstring xs
  end.

Instance ShowLString : Show lstring :=
  {
    show := show_lstring
  }.

Definition genAscii : G ascii :=
  (liftM ascii_of_nat (choose (97,122))).

Fixpoint genString (n : nat) (g1 : G ascii)
  : G string :=
  match n with
    | 0 => ret EmptyString
    | S m => liftM2 String g1 (genString m g1)
  end.

Definition genLString (n : nat) (g : G ascii) :=
  vectorOf n g.

Sample (genLString 5 genAscii).

Fixpoint genRegex (n : nat) (g : G ascii)
  : G regex :=
  match n with
    | 0 => liftM Sym g
    | S m =>
      freq [
          (1, ret Eps);
          (3, liftM Sym g);
          (4, liftM2 Alt (genRegex m g) (genRegex m g));
          (4, liftM2 Seq (genRegex m g) (genRegex m g));
          (3, liftM Rep (genRegex m g))
      ]
  end.

Sample (genRegex 5 genAscii).
