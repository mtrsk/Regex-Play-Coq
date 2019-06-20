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

Definition genAscii : G ascii :=
  (liftM ascii_of_nat (choose (97,122))).

Fixpoint genRegex (n : nat) (g1 : G ascii) (g2 : G ascii)
  : G regex :=
  match n with
    | 0 => liftM Sym g1
    | S m =>
      oneOf [
          ret Eps;
          liftM Sym genAscii;
          liftM2 Alt (genRegex m g1 g2) (genRegex m g2 g1);
          liftM2 Seq (genRegex m g1 g2) (genRegex m g2 g1);
          liftM Rep (genRegex m g1 g2)
      ]
  end.

Sample (genRegex 5 (genAscii) (genAscii)).
