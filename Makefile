.PHONY: all
all: clean setup build run

.PHONY: run
run:
	bundle exec jekyll serve

.PHONY: build
build:
	bundle exec jekyll build

.PHONY: setup
setup:
	bundle install

.PHONY: clean
clean:
	rm -rf _site .jekyll-cache
