GROUP=sampot
NAME=basebox
VERSION=18.04-spk1


all: build publish

build: Dockerfile
	docker build  -t $(GROUP)/$(NAME):$(VERSION) .

publish:
	docker push $(GROUP)/$(NAME):$(VERSION)
