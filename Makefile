GROUP=sampot
NAME=basebox
VERSION=18.04-spk1


all: build publish

build: Dockerfile
	docker build  -t $(GROUP)/$(NAME):$(VERSION) .

publish:
	echo ${DOCKER_PASS} | docker login --username ${DOCKER_USER} --password-stdin
	docker push $(GROUP)/$(NAME):$(VERSION)
