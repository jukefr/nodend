dev:
	open http://localhost:1313 && hugo server & ag -l | entr reload-browser Vivaldi 

build:
	hugo
