IMAGE_NAME := build-centos7-golang
# you can override this for testing
REPO_TAG ?= platform9systems/$(IMAGE_NAME)

# image tag is the golang build number
IMAGE_TAG := 1.15.2
FULL_TAG :=$(REPO_TAG):$(IMAGE_TAG)

build: 
	docker build --tag $(FULL_TAG)  .

push: | build
	(docker push $(FULL_TAG) || \
		(echo -n $${DOCKER_PASSWORD} | docker login --password-stdin -u $${DOCKER_USERNAME} && \
		docker push $(FULL_TAG) && docker logout))
	docker rmi $(FULL_TAG)
