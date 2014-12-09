#!/bin/bash

# Installs or updates go development tools.
go get -u -x code.google.com/p/go.tools/cmd/goimports
go get -u -x code.google.com/p/go.tools/cmd/oracle
go get -u -x code.google.com/p/rog-go/exp/cmd/godef
go get -u -x github.com/nsf/gocode
go get -u -x github.com/kisielk/errcheck
go get -u -x github.com/dougm/goflymake
go get -u -x github.com/golang/lint/golint

# Libraries.
go get -u -x github.com/golang/glog
go get -u -x github.com/gonum/blas
go get -u -x github.com/gonum/matrix
go get -u -x github.com/gonum/floats
go get -u -x github.com/gonum/graph
