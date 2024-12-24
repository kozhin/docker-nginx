#
# Automation tasks with Makefile
#
REPO = ghcr.io/kozhin
VERSION = 1.26.2

#
# BUILD actions
#
.PHONY: build
build:
	make build_arm64
	make build_amd64

.PHONY: build_arm64
build_arm64:
	docker buildx build \
		--platform=linux/arm64 \
		-t ${REPO}/arm64/nginx:${VERSION} \
		-t ${REPO}/arm64/nginx:latest \
		-f Dockerfile \
		.

.PHONY: build_amd64
build_amd64:
	docker buildx build \
		--platform=linux/amd64 \
		-t ${REPO}/amd64/nginx:${VERSION} \
		-t ${REPO}/amd64/nginx:latest \
		-f Dockerfile \
		.

#
# DEPLOY actions
#
.PHONY: deploy
deploy:
	make push_arm64
	make push_amd64

.PHONY: push_arm64
push_arm64:
	docker push ${REPO}/arm64/nginx:${VERSION}
	docker push ${REPO}/arm64/nginx:latest

.PHONY: push_amd64
push_amd64:
	docker push ${REPO}/amd64/nginx:${VERSION}
	docker push ${REPO}/amd64/nginx:latest

#
# TODO: add auto-tests
#
# TEST actions
#
# .PHONY: test
# test:
# 	make test-images

# Make release (shortcut)
.PHONY: release
release:
	git checkout dev
	git push
	git push --tags
	git checkout main
	git push
	git checkout dev
