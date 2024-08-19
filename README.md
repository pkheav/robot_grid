## Prerequisites
docker

## Instructions
```
git clone https://github.com/pkheav/robot_grid.git
cd robot_grid
docker run --rm -it $(docker build -q .) # first time this is run may take a couple of minutes as the ruby docker image has to be downloaded
```
