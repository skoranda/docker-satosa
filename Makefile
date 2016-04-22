VERSION=latest
NAME=satosa

all: build push
build:
	docker build --no-cache=true -t $(NAME) .
	docker tag -f $(NAME) docker.sunet.se/$(NAME):$(VERSION)
update:
	docker build -t $(NAME) .
	docker tag -f $(NAME) docker.sunet.se/$(NAME):$(VERSION)
push:
	docker push docker.sunet.se/$(NAME):$(VERSION)
