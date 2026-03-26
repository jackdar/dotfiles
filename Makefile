.PHONY: help
LINT_FILES := $(shell fd -H -e sh -e bash)

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

pull: ## Pull down the latest changes for the main repository
	git pull origin master

pull-all: pull ## Pull down latest changes for the main repository and all submodules
	$(MAKE) update-submodules

update-submodules: ## Update all submodules
	git submodule update --init --recursive && \
	git submodule foreach git pull --recurse-submodules origin master

shellcheck: ## Runs the shellcheck tests on the scripts
	@if ! command -v shellcheck &> /dev/null; then \
		echo "shellcheck is not installed. please install it with your package manager." && exit 1; \
	fi

	shellcheck $(LINT_FILES)
