#!/usr/bin/env sh

coq_files=(
    "Utils.v"
    "CStrings.v"
    "Simple.v"
    "Semiring.v"
    "SimpleW.v"
    "EffMatching.v"
    "EffMatchingW.v"
    "QuickA1.v"
)

SRC="src"

for i in "${coq_files[@]}";do
    coqc -Q src/ SRC src/"$i"
done
