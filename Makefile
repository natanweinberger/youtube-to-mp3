PACKAGE_NAME=youtube-to-mp3

build:
	docker build -t $(PACKAGE_NAME) .

dev:
	docker run --rm -it -v $(SPOTIFY_DIR):/tmp -v $(shell pwd):/var/src youtube-to-mp3 bash
