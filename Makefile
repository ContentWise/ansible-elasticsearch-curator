.DEFAULT_GOAL := help

.PHONY: test
test:					## Test the role using Test Kitchen. By default 'kitchen test' is run. Different kitchen commands can be run using the 'cmd' variable (e.g.: 'make test cmd=converge')
	kitchen $${cmd:-test}


.PHONY: docker
docker: Dockerfile		## Run target inside Docker. E.g.: make docker target=test
	docker run --rm -it \
	-e cmd=$(cmd) \
	--net="host" \
	-v /var/run/docker.sock:/var/run/docker.sock \
	$(shell docker build -q .) $${target}

.PHONY: help
help:					## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'