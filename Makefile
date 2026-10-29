IMAGE_NAME := build-rocky-golang
REGISTRY := quay.io
# you can override this for testing
REPO_TAG ?= $(REGISTRY)/platform9/$(IMAGE_NAME)

# image tag is the golang build number
IMAGE_TAG := 1.27.3
FULL_TAG :=$(REPO_TAG):$(IMAGE_TAG)
PLATFORMS ?= linux/amd64,linux/arm64
BUILDER ?= tc-rocky-golang

default: build
.PHONY: default build push

build:
	docker build --tag $(FULL_TAG) --build-arg GOLANG_VERSION=$(IMAGE_TAG) .

# Publish a single tag that contains both amd64 and arm64. The TeamCity
# agents are single-arch, so cross-build via buildx instead of depending
# on which agent the job lands on.
push:
	@set -eu; \
	docker run --privileged --rm tonistiigi/binfmt:latest --install amd64,arm64; \
	if ! docker buildx inspect $(BUILDER) >/dev/null 2>&1; then \
		docker buildx create --name $(BUILDER) --driver docker-container --use; \
	else \
		docker buildx use $(BUILDER); \
	fi; \
	docker buildx inspect $(BUILDER) --bootstrap; \
	docker buildx build \
		--platform $(PLATFORMS) \
		--tag $(FULL_TAG) \
		--build-arg GOLANG_VERSION=$(IMAGE_TAG) \
		--push \
		.
