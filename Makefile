GO=go
GIT_SHORT_HASH=$(shell git rev-parse --short HEAD)
KUSTOMIZE_GO=kustomize.go

.PHONY: dist
dist:
	mkdir -p dist

.PHONY: darwin
darwin: dist
	GOOS=darwin GOARCH=amd64 $(GO) build -o dist/kustomize_$(GIT_SHORT_HASH)_darwin_amd64 $(KUSTOMIZE_GO) 

.PHONY: linux
linux: dist
	GOOS=linux GOARCH=amd64 $(GO) build -o dist/kustomize_$(GIT_SHORT_HASH)_linux_amd64 $(KUSTOMIZE_GO) 

.PHONY: all
all: darwin linux
	find dist -name 'kustomize*' | xargs shasum -a 256 > dist/sha256_$(GIT_SHORT_HASH).txt

.PHONY: clean
clean:
	rm dist/*

