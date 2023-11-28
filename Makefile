GO ?= go
SHELL := bash
IMAGE_TAG ?= $(shell ./tools/image-tag)
GIT_REVISION := $(shell git rev-parse --short HEAD)
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
GIT_LAST_COMMIT_DATE := $(shell git log -1 --date=iso-strict --format=%cd)

# Build flags
VPREFIX := github.com/opencost/opencost/pkg/version
GO_LDFLAGS   := -X $(VPREFIX).Version=$(IMAGE_TAG) -X $(VPREFIX).GitCommit=$(GIT_REVISION)
GO_FLAGS     := -ldflags "-extldflags \"-static\" -s -w $(GO_LDFLAGS)"

IMG ?= rafay-opencost:latest
TS := $(shell /bin/date "+%Y%m%d%H%M%S")
DEV_USER ?= dev
DEV_TAG := registry.dev.rafay-edge.net/${DEV_USER}/rafay-opencost:$(TS)

.PHONY: go/bin
go/bin:
	CGO_ENABLED=0 $(GO) build $(GO_FLAGS) ./cmd/costmodel

build:
	docker buildx create --use
	docker buildx build --platform=linux/amd64,linux/arm64 --provenance=false --push -t ${DEV_TAG} . --build-arg version=dev
	@echo "$(DEV_TAG)"
