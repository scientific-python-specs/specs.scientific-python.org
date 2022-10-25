.PHONY: help prepare html serve serve-dev clean
.DEFAULT_GOAL := help
SHELL:=/bin/bash


# Add help text after each target name starting with '\#\#'
help:   ## show this help
	@echo -e "Help for this makefile\n"
	@echo "Possible commands are:"
	@grep -h "##" $(MAKEFILE_LIST) | grep -v grep | sed -e 's/\(.*\):.*##\(.*\)/    \1: \2/'

prepare:
	git submodule update --init
	pip install -r requirements.txt
	pre-commit install

html: prepare  ## build the website in ./public
	@hugo

serve: prepare  ## serve the website
	@hugo --printI18nWarnings server

serve-dev: prepare
	@hugo --printI18nWarnings --disableFastRender server

clean:
	rm -rf public
