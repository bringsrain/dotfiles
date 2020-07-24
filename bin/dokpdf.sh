#!/usr/bin/env bash

pandoc "$1" \
  -f gfm \
  --include-in-header ~/.pandoc/header/blok_kode.tex \
  -V geometry:letter \
  -V geometry:margin=2cm \
  --pdf-engine=xelatex \
  -o "$2"
