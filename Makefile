IMG ?= rafay-opencost:latest
#TS := $(shell /bin/date "+%Y%m%d%H%M%S")
TS := configReloadFix
DEV_USER ?= dev
DEV_TAG := registry.dev.rafay-edge.net:5000/${DEV_USER}/rafay-opencost:$(TS)

build:
	docker build -t ${IMG} . --build-arg version=v1.96.0
	docker tag ${IMG} $(DEV_TAG)
	docker push $(DEV_TAG)
