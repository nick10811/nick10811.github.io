all: build
.PHONY: all

build: 
	jekyll build
	rm -rf tags/
	cp -R _site/tags .
.PHONY: build

clean:
	rm -rf _site/
	rm -rf .jekyll-cache/
.PHONY: clean