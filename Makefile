#
# Automation tasks with Makefile
#
# BUILD actions
# Local building
#
.PHONY: build
build:
	docker buildx build \
		--push \
		--platform=linux/amd64,linux/arm64 \
		-t kozhin/docker-nginx:1.22.1 \
		-t kozhin/docker-nginx:latest \
		-f Dockerfile \
		.

#
# TODO: add auto-tests
#
# TEST actions
# Local testing
#
# .PHONY: test
# test:
# 	make test-images
