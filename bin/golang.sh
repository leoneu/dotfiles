#!/bin/bash

# Installs or updates go development tools.

GOBIN=go
GET="$GOBIN get -u"
INSTALL="$GOBIN install "

PACKAGES="golang.org/x/tools/cmd/goimports golang.org/x/tools/cmd/gorename golang.org/x/tools/cmd/eg golang.org/x/tools/cmd/oracle golang.org/x/tools/cmd/stringer github.com/rogpeppe/godef github.com/nsf/gocode github.com/kisielk/errcheck github.com/dougm/goflymake github.com/golang/lint/golint github.com/golang/glog github.com/gonum/blas github.com/gonum/matrix/mat64 github.com/gonum/floats github.com/gonum/graph github.com/akualab/optioner github.com/akualab/ju"

for p in $PACKAGES; do
    echo ">>> " $p
    $GET $p
    st=$?
    if [ $st != "0" ]; then
        echo "bad exit status $st for $p"
#        exit 1
    fi
    $INSTALL $p
    if [ $st != "0" ]; then
        echo "bad exit status $st for $p"
#        exit 1
    fi
done
