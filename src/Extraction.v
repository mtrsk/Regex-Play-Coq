Require Import Coq.Lists.List. Import ListNotations.

Require Import
        Coq.Bool.Bool
        Coq.Strings.Ascii
        Coq.Strings.String.

From SRC Require Export Simple Semiring.

Require Coq.extraction.Extraction.

Require Import
        ExtrHaskellBasic
        ExtrHaskellZInt
        ExtrHaskellString.

Extraction Language Haskell.

Extract Inductive list => "[]" ["[]" "(:)"].

Extraction "Extraction/match.hs" accept.
