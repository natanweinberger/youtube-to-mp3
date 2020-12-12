PACKAGE_NAME=youtube-to-mp3

build:
	docker build -t $(PACKAGE_NAME) .

dev:
	docker run --rm -it -v $(LOCAL_MUSIC_DIR):/home -v $(shell pwd):/var/src youtube-to-mp3 bash
