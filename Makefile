all:

%:: configs/%
	@cp $< .config

export DOCKER_EXPORT

.PHONY: \
	all \
	docker

docker:
	docker build docker -t tiiuae/pkvm_build:latest

shell:
	@docker/enter_container.sh
