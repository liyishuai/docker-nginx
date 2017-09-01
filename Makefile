NAME=server
REPO=ysli/nginx
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
IMAGES=$(shell docker images $(REPO) -q)
PORT?=80

ifneq ($(BRANCH), master)
        REPO:=$(REPO):$(BRANCH)
endif

all: clean
	docker build -t $(REPO) .
	docker push $(REPO)

test: stop
	docker run -d -p $(PORT):80 --rm --name $(NAME) $(REPO)

clean: stop
	-docker rmi -f $(IMAGES)

stop:
	-docker rm  -f $(NAME)
