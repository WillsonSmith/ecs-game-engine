GAME = ECS Game Engine
VERSION = 0.0.1

install:
	git submodule update --init --recursive

build:
	zip -9 -r "build/$(GAME)-$(VERSION).love" . -x ".git/*" -x "build/*"