# Security Camera Docker container - Includes Motion Detection and Live streaming
![Docker & Raspberry Pi](/assets/images/docker+rpi.png)

## Basic Setup on Raspberry Pi

`curl -sSL https://get.docker.com | sh`
`sudo usermod pi -aG docker`
Then we connect the official Raspberry Pi camera and activate it.

`sudo raspi-config`
Under “Interfacing Options” -> “Camera” you will find the menu item for activating the camera. Thereafter, it will restart.

Now we test the recording function of the camera. Enter the following in the console:

`sudo raspistill -o test.jpg`
This should take a picture. If you get an error here, enter the following command and then restart the system (sudo reboot):

`sudo modprobe bcm2835-v4l2`

## Running Docker container for motion detection

START CONTAINER (motion detection as default action)

`docker run --privileged -it -d --name camera -p 80:9090 -p 8081:9091 -v /tmp:/tmp --device=/dev/video0 hukam/security-camera motion`

After the initial start use below command for running container to stream Live feed on Youtube:
`docker exec -it -d camera bash entrypoint.sh live xxxx-xxxx-xxxx-xxxx`

After the initial start use below command for running container as motion detection:
`docker exec -it -d camera bash entrypoint.sh motion`

TO STOP CONTAINER

`docker stop camera`

TO START CONTAINER

`docker start camera`

## REFERENCES
[Motion Detection 1](https://github.com/remonlam/rpi-docker-motion)
 |
[Motion Detection 2](https://github.com/yushi/rpi-dockerfile)
