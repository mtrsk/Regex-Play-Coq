#!/usr/bin/env bash

coq_files=(
    "Utils.v"
    "CStrings.v"
    "Simple.v"
    "Monoid.v"
    "Semiring.v"
    "SimpleW.v"
    "EffMatching.v"
    "EffMatchingW.v"
    "QuickA1.v"
)

SRC="src"

for i in "${coq_files[@]}";do
    coqc -Q src/ SRC src/"$i" 2> /dev/null
done
