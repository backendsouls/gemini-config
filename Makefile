# Makefile for Gemini CLI Sandbox Environments

# Docker Namespace (Registry/Username)
NAMESPACE ?= backendsouls
IMAGE_PREFIX = gemini-sandbox

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

# Individual build targets
base:
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-base sandboxes/base

build-base: base

python: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-python sandboxes/python

javascript: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-js sandboxes/javascript

go: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-go sandboxes/go

rust: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-rust sandboxes/rust

ruby: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-ruby sandboxes/ruby

java: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-java sandboxes/java

php: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-php sandboxes/php

lua: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-lua sandboxes/lua

cpp: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-cpp sandboxes/cpp

all-in-one: base
	docker build -t $(NAMESPACE)/$(IMAGE_PREFIX)-all sandboxes/all

# Upgrade Gemini CLI to the latest version across all images
upgrade:
	docker build --no-cache --pull -t $(NAMESPACE)/$(IMAGE_PREFIX)-base sandboxes/base
	make all-in-one NAMESPACE=$(NAMESPACE)

# Build all sandboxes
build-all: base python javascript go rust ruby java php lua cpp all-in-one

# Push all sandboxes
push-all:
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-base
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-python
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-js
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-go
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-rust
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-ruby
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-java
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-php
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-lua
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-cpp
	docker push $(NAMESPACE)/$(IMAGE_PREFIX)-all

# Clean targets
clean:
	docker rmi $$(docker images '$(NAMESPACE)/$(IMAGE_PREFIX)-*' -q) || true
