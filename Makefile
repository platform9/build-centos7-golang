IMAGE_NAME := build-rocky-golang
REGISTRY := quay.io
# you can override this for testing
REPO_TAG ?= $(REGISTRY)/platform9/$(IMAGE_NAME)

# image tag is the golang build number
IMAGE_TAG := 1.24.5
FULL_TAG :=$(REPO_TAG):$(IMAGE_TAG)

default: build
.PHONY: default build push

build: 
	docker build --tag $(FULL_TAG) --build-arg GOLANG_VERSION=$(IMAGE_TAG) .

push: | build
	(docker push $(FULL_TAG) || \
		(echo -n $${DOCKER_PASSWORD} | docker login --password-stdin -u $${DOCKER_USERNAME} && \
		docker push $(FULL_TAG) && docker logout))
	docker rmi $(FULL_TAG)
