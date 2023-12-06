# this is the official base notebook for jupyter.
#  we don't need LaTeX and other fancy stuff.
ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_CONTAINER=$REGISTRY/$OWNER/base-notebook
FROM $BASE_CONTAINER

USER root
RUN apt update
RUN apt install -y --no-install-recommends pkg-config gcc build-essential curl unzip bubblewrap zlib1g-dev libffi-dev libgmp-dev libzmq5-dev

RUN curl -sS -L -o /usr/local/bin/opam \
 https://github.com/ocaml/opam/releases/download/2.1.5/opam-2.1.5-x86_64-linux \
 && chmod +x /usr/local/bin/opam

USER $NB_USER
RUN opam -y init

RUN opam -y install jupyter
RUN grep topfind ~/.ocamlinit || echo '#use "topfind";;' >> ~/.ocamlinit
RUN grep Topfind.log ~/.ocamlinit || echo 'Topfind.log:=ignore;;' >> ~/.ocamlinit
RUN ~/.opam/default/bin/ocaml-jupyter-opam-genspec
RUN jupyter kernelspec install --user --name "ocaml-jupyter-$(opam var switch)" "$(opam var share)/jupyter"

