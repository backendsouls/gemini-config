# Makefile for Gemini CLI Sandbox Environments

.PHONY: all build-all base python javascript go rust ruby java php clean help

# Default target
all: help

# Help command
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  base         Build base sandbox"
	@echo "  python       Build python sandbox"
	@echo "  javascript   Build javascript sandbox"
	@echo "  go           Build go sandbox"
	@echo "  rust         Build rust sandbox"
	@echo "  ruby         Build ruby sandbox"
	@echo "  java         Build java sandbox"
	@echo "  php          Build php sandbox"
	@echo "  cpp          Build c/c++ sandbox"
	@echo "  all-in-one   Build the 'all' sandbox with everything"
	@echo "  build-all    Build ALL sandboxes sequentially"
	@echo "  clean        Remove all gemini-sandbox images"

# Individual build targets
base:
	docker build -t gemini-sandbox-base sandboxes/base

python: base
	docker build -t gemini-sandbox-python sandboxes/python

javascript: base
	docker build -t gemini-sandbox-js sandboxes/javascript

go: base
	docker build -t gemini-sandbox-go sandboxes/go

rust: base
	docker build -t gemini-sandbox-rust sandboxes/rust

ruby: base
	docker build -t gemini-sandbox-ruby sandboxes/ruby

java: base
	docker build -t gemini-sandbox-java sandboxes/java

php: base
	docker build -t gemini-sandbox-php sandboxes/php

cpp: base
	docker build -t gemini-sandbox-cpp sandboxes/cpp

all-in-one: base
	docker build -t gemini-sandbox-all sandboxes/all

# Build all sandboxes
build-all: base python javascript go rust ruby java php cpp all-in-one

# Clean targets
clean:
	docker rmi $$(docker images 'gemini-sandbox-*' -q) || true
