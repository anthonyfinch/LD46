
all: clean build

clean:
	rm -rf output/web && mkdir -p output/web

build:
	godot-headless --export HTML5 output/web/index.html

push:
	butler push output/web tfinch/ld-46:html5
