GROUP=sampot
NAME=basebox
VERSION=18.04-spk1


all: build

build: Dockerfile
	docker build  -t $(GROUP)/$(NAME):$(VERSION) .


