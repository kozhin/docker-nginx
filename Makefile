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
	-f Dockerfile \
	.
#
# TODO: add latest image tagging
#
# TEST actions
# Local testing
#
# .PHONY: test
# test:
# 	make test-images
