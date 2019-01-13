#!/bin/bash

function install_build_tools {
  apt-get update
  # Install packages
  apt-get -y install libavcodec-dev libavcodec0d libavformat-dev libavformat0d
  apt-get install -y wget tar unzip nano motion libjpeg62
}

function build_motion {

  sudo chown motion /tmp/motion

  rm -rf /etc/default/motion
  cp /usr/src/app/assets/motion /etc/default/

  # Remove old motion config
  rm -rf /etc/motion/motion.conf

  # Copy motion config file
  cp /usr/src/app/assets/motion.conf /etc/motion/

}

function start_ngrok {
  unzip /usr/src/app/ngrok-stable-linux-amd64.zip
}

/**
 * This method is not in use
 */
function build_h264 {
    # h.264 video encoder

    echo "Building h264"

    cd /usr/src/app
    git clone git://git.videolan.org/x264
    cd x264

    ./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
    make
    make install
}

/**
 * This method is not in use
 */
function build_lame {
    # mp3 audio encoder

	echo "Building lame"

    cd /usr/src/app
    wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.tar.gz
    tar xzvf lame-3.99.tar.gz
    cd lame-3.99
    ./configure
    make
    make install
}

/**
 * This method is not in use
 */
function build_faac {
    # aac encoder

    echo "Building faac"

    cd /usr/src/app
    curl -#LO http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.gz
    tar xzvf faac-1.28.tar.gz
    cd faac-1.28
    ./configure
    make
    make install
}

/**
 * This method is not in use
 */
function build_ffmpeg {

	echo "Building ffmpeg"

    cd /usr/src/app/
    sudo git clone https://github.com/FFmpeg/FFmpeg.git
    cd FFmpeg/
    apt-get install -qy libomxil-bellagio-dev
    sudo ./configure --arch=armel --target-os=linux --enable-gpl --enable-omx --enable-omx-rpi --enable-nonfree
    sudo make -j4
    sudo make install

}

/**
 * This method is not in use
 */
function configure_ldconfig {

	echo "Building ldconfig"

    echo "/usr/local/lib" > /etc/ld.so.conf.d/libx264.conf
    ldconfig
}

/**
 * This method is not in use
 */
function build_psips {
  git clone git://github.com/AndyA/psips.git
  cd psips
  ./setup.sh && ./configure && make && make install
}

install_build_tools
build_motion
start_ngrok
# build_yasm
# build_h264
# build_lame
# build_faac
# build_ffmpeg
# configure_ldconfig
# build_psips
