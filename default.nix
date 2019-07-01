{ nixpkgs ? import ./pinned-nixpkgs.nix {json = ./.nixpkgs-version.json;}
, coq ? nixpkgs.coq
, ocaml ? nixpkgs.ocaml
}:

with nixpkgs;

let
  ocamlPkgs = with coq.ocamlPackages; [
      camlp5
      findlib
  ];
  coqPkgs = with coq.coqPackages; [
      coq-ext-lib
      QuickChick
      ssreflect
  ];
in
stdenv.mkDerivation {
  inherit coq;
  inherit ocaml;

  name = "coq-env";

  src = ./src;

  buildInputs = [ coq ocaml ] ++ ocamlPackages ++ coqPackages;
}
