# Set default shell to bash
SHELL := /bin/bash -o pipefail

BUILD_TOOLS_VERSION      ?= v0.15.2
BUILD_TOOLS_DOCKER_REPO  ?= mineiros/build-tools
BUILD_TOOLS_DOCKER_IMAGE ?= ${BUILD_TOOLS_DOCKER_REPO}:${BUILD_TOOLS_VERSION}

# Some CI providers such as GitHub Actions, CircleCI, and TravisCI are setting
# the CI environment variable to a non-empty value by default to indicate that
# the current workflow is running in a Continuous Integration environment.
#
# If TF_IN_AUTOMATION is set to any non-empty value, Terraform adjusts its
# output to avoid suggesting specific commands to run next.
# https://www.terraform.io/docs/commands/environment-variables.html#tf_in_automation
#
# We are using GNU style quiet commands to disable set V to non-empty e.g. V=1
# https://www.gnu.org/software/automake/manual/html_node/Debugging-Make-Rules.html
#
ifdef CI
  TF_IN_AUTOMATION ?= yes
  export TF_IN_AUTOMATION

  V ?= 1
endif

ifndef NOCOLOR
  GREEN  := $(shell tput -Txterm setaf 2)
  YELLOW := $(shell tput -Txterm setaf 3)
  WHITE  := $(shell tput -Txterm setaf 7)
  RESET  := $(shell tput -Txterm sgr0)
endif

GIT_TOPLEVEL = $(shell git rev-parse --show-toplevel)

.PHONY: default
default: help

## Run pre-commit hooks.
.PHONY: test/pre-commit
test/pre-commit:
	$(call quiet-command,terramate --changed run -- sh -c "pre-commit run --files * --config "${GIT_TOPLEVEL}"/.pre-commit-config.yaml")

## Run pre-commit hooks on all modules.
.PHONY: test/pre-commit/all
test/pre-commit/all:
	$(call quiet-command,terramate run -- sh -c "pre-commit run --files * --config "${GIT_TOPLEVEL}"/.pre-commit-config.yaml")

## Run unit tests.
.PHONY: test/unit-tests
test/unit-tests: TEST ?= "TestUnit"
test/unit-tests:
	@echo "${YELLOW}[TEST] ${GREEN}Start Running unit tests.${RESET}"
	$(call quiet-command,terramate run --changed -- sh -c "cd \$${TM_STACK_TO_ROOT}/tests ; go test -v -count 1 -timeout 45m -parallel 128 -run $(TEST)")

## Run all unit tests.
.PHONY: test/unit-tests/all
test/unit-tests/all: TEST ?= "TestUnit"
test/unit-tests/all:
	@echo "${YELLOW}[TEST] ${GREEN}Start Running unit tests.${RESET}"
	$(call quiet-command,terramate run -- sh -c "cd \$${TM_STACK_TO_ROOT}/tests ; go test -v -count 1 -timeout 45m -parallel 128 -run $(TEST)")

## Update test-assets for each stack
.PHONY: test/update-assets
test/update-assets:
	$(call quiet-command,terramate run -- cp "${GIT_TOPLEVEL}"/test-assets/* tests/)

## Generate README.md with Terradoc
.PHONY: terradoc
terradoc:
	$(call quiet-command,terramate run --disable-check-git-uncommitted -- terradoc generate -o README.md README.tfdoc.hcl)

## Generate shared configuration for tests
.PHONY: terramate
terramate:
	$(call quiet-command,terramate generate)

## Clean up cache and temporary files
.PHONY: clean
clean:
	$(call rm-command,.terraform)
	$(call rm-command,.terratest)
	$(call rm-command,.terraform.lock.hcl)
	$(call rm-command,*.tfplan)
	$(call rm-command,*/*/.terraform)
	$(call rm-command,*/*/.terratest)
	$(call rm-command,*/*/*.tfplan)
	$(call rm-command,*/*/.terraform.lock.hcl)

## Display help for all targets
.PHONY: help
help:
	@awk '/^.PHONY: / { \
		msg = match(lastLine, /^## /); \
			if (msg) { \
				cmd = substr($$0, 9, 100); \
				msg = substr(lastLine, 4, 1000); \
				printf "  ${GREEN}%-30s${RESET} %s\n", cmd, msg; \
			} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

# Define helper functions
quiet-command = $(if ${V},${1},$(if ${2},@echo ${2} && ${1}, @${1}))
rm-command    = $(call quiet-command,rm -rf ${1},"${YELLOW}[CLEAN] ${GREEN}${1}${RESET}")
