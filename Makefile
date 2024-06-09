#
# Automation tasks with Makefile
#
# BUILD actions
# Local building
#
.PHONY: build
build:
	make build_arm64
	make build_amd64

.PHONY: build_arm64
build_arm64:
	docker buildx build \
		--platform=linux/arm64 \
		-t arm64/nginx:1.26.1 \
		-t arm64/nginx:latest \
		-f Dockerfile \
		.

.PHONY: build_amd64
build_amd64:
	docker buildx build \
		--platform=linux/amd64 \
		-t amd64/nginx:1.26.1 \
		-t amd64/nginx:latest \
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
