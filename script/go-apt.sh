#!/usr/bin/env sh

PATH="/usr/lib/go-1.17/bin:$PATH"
GOPATH="$HOME/go/apt-system"
GOCACHE="$GOPATH/.cache/go-build"
GOENV="$GOPATH/.config/go/env"
GOMODCACHE="$GOPATH/pkg/mod"
GOROOT="/usr/lib/go-1.17"
GOTOOLDIR="/usr/lib/go-1.17/pkg/tool/linux_amd64"

go $@
