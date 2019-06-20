FROM lnl7/nix:2.2.2

WORKDIR /home/coqproject

COPY . .

RUN nix-shell
