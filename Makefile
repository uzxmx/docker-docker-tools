DOCKER_REPO ?= uzxmx/docker
DOCKER_TAG  ?= latest

.PHONE: login build image_push push

login:
	echo "$(DOCKER_PASSWORD)" | docker login -u "$(DOCKER_USERNAME)" --password-stdin

build:
	@docker build --rm -t "$(DOCKER_REPO):$(DOCKER_TAG)" \
		--build-arg TAG="$(DOCKER_TAG)" .

define docker_push
	docker push "$(DOCKER_REPO):$(DOCKER_TAG)"
endef

image_push:
	$(docker_push)

push: build
	$(docker_push)
