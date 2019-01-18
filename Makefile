dev:
	hugo server & ag -l | entr reload-browser Vivaldi 

build:
	hugo
