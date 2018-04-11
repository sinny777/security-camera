FROM hukam/ffmpeg
MAINTAINER Gurvinder Singh <contact@hukamtechnologies.com>

ENV BUILD_VERSION="V1"

USER root

ENV CLOUDANT_URL $CLOUDANT_URL

# Updates S.O. and adds system required packages
RUN apt-get update && apt-get install -qy wget git tar libraspberrypi-bin \
    && rm -rf /var/lib/apt/lists/*

# Create a directory where our app will be placed
RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/assets

#Change directory so that our commands run inside this new directory
WORKDIR /usr/src/app

COPY entrypoint.sh /usr/src/app
COPY build.sh /usr/src/app
COPY assets/motion.conf /usr/src/app/assets
COPY assets/motion /usr/src/app/assets

RUN mkdir /tmp/motion
RUN mkdir /tmp/motion/cam1
RUN touch /tmp/motion/motion.log
RUN sudo chmod 755 -R /tmp/motion/motion.log
RUN sudo chmod 755 -R /tmp/motion

RUN chmod 755 /usr/src/app/entrypoint.sh
RUN chmod 755 /usr/src/app/build.sh

RUN /usr/src/app/build.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
CMD []

EXPOSE 90 9091
