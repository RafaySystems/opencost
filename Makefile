IMG ?= rafay-opencost:latest
TS := v1.2.0
DEV_USER ?= dev
DEV_TAG := registry.dev.rafay-edge.net:5000/${DEV_USER}/rafay-opencost:$(TS)

build:
	docker build -t ${IMG} . --build-arg version=v1.99.0
	docker tag ${IMG} $(DEV_TAG)
	docker push $(DEV_TAG)
