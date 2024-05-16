
#!/bin/bash

OS := $(shell uname)

ifeq ($(OS),Darwin)
	UID = $(shell id -u)
	IP_DEBUG = host.docker.internal
else ifeq ($(OS),Linux)
	UID = $(shell id -u)
	IP_DEBUG = 172.17.0.1
else
	UID = 1000
	IP_DEBUG = host.docker.internal
endif

DOCKER_BE = backend

help: ## Show this help message
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

run: ## Arranca los contenedores
	U_ID=${UID} IP_DEBUG=${IP_DEBUG} docker compose -f docker-compose.yml up -d --build

stop: ## Detiene los contenedores
	U_ID=${UID} docker compose -f docker-compose.yml stop

restart: ## Reinicia los contenedores
	$(MAKE) stop && $(MAKE) run

build: ## Rebuilds all the containers
	U_ID=${UID} docker compose build

logs: ## Show test logs in real time
	U_ID=${UID} docker exec -it --user ${UID} ${DOCKER_BE} test server:log

ssh-be: ## bash into the be container
	U_ID=${UID} docker exec -it --user ${UID} ${DOCKER_BE} bash


##docker commands
 #docker stop $(docker ps -q) ## stop container
 #docker stop $(docker ps -aq) ## stop all container
 #docker rm $(docker ps -aq) ## delete containers
 #docker volume prune ## delete local volume
 #docker volume rm $(docker volume ls -q)  ## delete all volume
 #docker rmi $(docker images -a -q) ## delete images

 