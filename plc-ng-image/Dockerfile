# this is the official base notebook for jupyter.
#  we don't need LaTeX and other fancy stuff.
ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_CONTAINER=$REGISTRY/$OWNER/base-notebook
FROM $BASE_CONTAINER

USER root
RUN apt update
RUN apt install -y --no-install-recommends pkg-config gcc build-essential curl unzip bubblewrap zlib1g-dev libffi-dev libgmp-dev libzmq5-dev python3-pip git libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev nodejs

# Ocaml
RUN curl -sS -L -o /usr/local/bin/opam \
 https://github.com/ocaml/opam/releases/download/2.1.5/opam-2.1.5-x86_64-linux \
 && chmod +x /usr/local/bin/opam

# Haskell
RUN curl -sSL https://get.haskellstack.org/ | sh

# Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN ~/.cargo/bin/cargo install evcxr_jupyter

USER $NB_USER

# OCaml
RUN opam -y init
RUN opam -y install jupyter
RUN grep topfind ~/.ocamlinit || echo '#use "topfind";;' >> ~/.ocamlinit
RUN grep Topfind.log ~/.ocamlinit || echo 'Topfind.log:=ignore;;' >> ~/.ocamlinit
RUN ~/.opam/default/bin/ocaml-jupyter-opam-genspec
RUN jupyter kernelspec install --user --name "ocaml-jupyter-$(opam var switch)" "$(opam var share)/jupyter"

# Rust
RUN ~/.cargo/bin/evcxr_jupyter --install

# TypeScript
RUN npm install -g tslab
RUN tslab install

# Java
# Use: https://github.com/allen-ball/ganymede

# Haskell
# RUN git clone https://github.com/gibiansky/IHaskell
# RUN cd IHaskell
# RUN stack init
# RUN stack install
# RUN ihaskell install --stack



