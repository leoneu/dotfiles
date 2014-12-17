#!/bin/bash

# Installs or updates go development tools.

GOBIN=go
GET="$GOBIN get -u -x"
INSTALL="$GOBIN install "

PACKAGES="golang.org/x/tools/cmd/goimports golang.org/x/tools/cmd/gorename golang.org/x/tools/cmd/eg golang.org/x/tools/cmd/oracle golang.org/x/tools/cmd/cover golang.org/x/tools/cmd/stringer code.google.com/p/rog-go/exp/cmd/godef github.com/nsf/gocode github.com/kisielk/errcheck github.com/dougm/goflymake github.com/golang/lint/golint github.com/golang/glog github.com/gonum/blas github.com/gonum/matrix/mat64 github.com/gonum/floats github.com/gonum/graph"

for p in $PACKAGES; do
    echo ">>> " $p
    $GET $p
    $INSTALL $p
done
