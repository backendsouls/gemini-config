# Makefile for Gemini CLI Sandbox Environments

# Docker Namespace (Registry/Username)
NAMESPACE ?= backendsouls
IMAGE_PREFIX = gemini-sandbox
TAG_VERSION = python3.13-node24
TAG_ALIAS = backendsouls

.PHONY: all build-all base build-base python javascript go rust ruby java php clean help push-all

# Default target
all: help

# Help command
help:
	@echo "Usage: make [target] [NAMESPACE=your-namespace]"
	@echo ""
	@echo "Targets:"
	@echo "  base         Build base sandbox"
	@echo "  build-base   Build base sandbox (alias)"
	@echo "  python       Build python sandbox"
	@echo "  javascript   Build javascript sandbox"
	@echo "  go           Build go sandbox"
	@echo "  rust         Build rust sandbox"
	@echo "  ruby         Build ruby sandbox"
	@echo "  java         Build java sandbox"
	@echo "  php          Build php sandbox"
	@echo "  lua          Build lua sandbox"
	@echo "  cpp          Build c/c++ sandbox"
	@echo "  all-in-one   Build the 'all' sandbox with everything"
	@echo "  build-all    Build ALL sandboxes sequentially"
	@echo "  push-all     Push ALL built sandboxes to the namespace"
	@echo "  clean        Remove all gemini-sandbox images"

# Helper for tagging
define tag_image
	docker tag $(NAMESPACE)/$(IMAGE_PREFIX)-$(1) $(NAMESPACE)/$(IMAGE_PREFIX)-$(1):$(TAG_VERSION)
	docker tag $(NAMESPACE)/$(IMAGE_PREFIX)-$(1) $(NAMESPACE)/$(IMAGE_PREFIX)-$(1):$(TAG_ALIAS)
endef

# Individual build targets
base:
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-base sandboxes/base
	$(call tag_image,base)

build-base: base

python: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-python sandboxes/python
	$(call tag_image,python)

javascript: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-js sandboxes/javascript
	$(call tag_image,js)

go: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-go sandboxes/go
	$(call tag_image,go)

rust: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-rust sandboxes/rust
	$(call tag_image,rust)

ruby: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-ruby sandboxes/ruby
	$(call tag_image,ruby)

java: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-java sandboxes/java
	$(call tag_image,java)

php: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-php sandboxes/php
	$(call tag_image,php)

lua: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-lua sandboxes/lua
	$(call tag_image,lua)

cpp: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-cpp sandboxes/cpp
	$(call tag_image,cpp)

all-in-one: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-all sandboxes/all
	$(call tag_image,all)

# Upgrade Gemini CLI to the latest version across all images
upgrade:
	docker build --no-cache --pull -t $(NAMESPACE)/$(IMAGE_PREFIX)-base sandboxes/base
	$(call tag_image,base)
	make all-in-one NAMESPACE=$(NAMESPACE)

# Build all sandboxes
build-all: base python javascript go rust ruby java php lua cpp all-in-one

# Push all sandboxes
push-all:
	@for variant in base python js go rust ruby java php lua cpp all; do \
		echo "Pushing $${variant}..."; \
		docker push $(NAMESPACE)/$(IMAGE_PREFIX)-$${variant}:latest; \
		docker push $(NAMESPACE)/$(IMAGE_PREFIX)-$${variant}:$(TAG_VERSION); \
		docker push $(NAMESPACE)/$(IMAGE_PREFIX)-$${variant}:$(TAG_ALIAS); \
	done

# Clean targets
clean:
	docker rmi $$(docker images '$(NAMESPACE)/$(IMAGE_PREFIX)-*' -q) || true
