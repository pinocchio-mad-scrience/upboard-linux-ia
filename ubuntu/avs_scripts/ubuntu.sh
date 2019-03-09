#!/bin/bash
#
# Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# A copy of the License is located at
#
#  http://aws.amazon.com/apache2.0
#
# or in the "license" file accompanying this file. This file is distributed
# on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
# express or implied. See the License for the specific language governing
# permissions and limitations under the License.
#

if [ -z "$PLATFORM" ]; then
	echo "You should run the setup.sh script."
	exit 1
fi

SOUND_CONFIG="$HOME/.asoundrc"
START_SCRIPT="$INSTALL_BASE/startsample.sh"
CMAKE_PLATFORM_SPECIFIC=(-DKITTAI_KEY_WORD_DETECTOR=ON \
    -DSENSORY_KEY_WORD_DETECTOR=OFF \
    -DGSTREAMER_MEDIA_PLAYER=ON -DPORTAUDIO=ON \
    -DPORTAUDIO_LIB_PATH="$THIRD_PARTY_PATH/portaudio/lib/.libs/libportaudio.$LIB_SUFFIX" \
    -DPORTAUDIO_INCLUDE_DIR="$THIRD_PARTY_PATH/portaudio/include" \
    -DKITTAI_KEY_WORD_DETECTOR_LIB_PATH="$THIRD_PARTY_PATH/snowboy/lib/ubuntu64/libsnowboy-detect.a" \
    -DKITTAI_KEY_WORD_DETECTOR_INCLUDE_DIR="$THIRD_PARTY_PATH/snowboy/include")

GSTREAMER_AUDIO_SINK="alsasink"
NGHTTP2_DIR="nghttp2"
KITTAI_RES="$THIRD_PARTY_PATH/snowboy/resources"

install_dependencies() {
  sudo apt-get update
  sudo apt-get install -y g++ \
  make binutils autoconf automake autotools-dev libtool \
  pkg-config zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev \
  libevent-dev libjansson-dev libjemalloc-dev cython python3-dev \
  python-setuptools portaudio19-dev libgtest-dev openjdk-8-jdk \
  python-pyaudio python3-pyaudio sox libatlas-base-dev python3-pip python-pip && pip install pyaudio
}

run_os_specifics() {
  build_port_audio
  build_kwd_engine
  configure_sound
  build_nghttp2
  configure_nghttp2
}

configure_sound() {
  echo
  echo "==============> SAVING AUDIO CONFIGURATION FILE =============="
  echo

  cat << EOF > "$SOUND_CONFIG"
  pcm.!default {
    type asym
     playback.pcm {
       type plug
       slave.pcm "hw:0,0"
     }
     capture.pcm {
       type plug
       slave.pcm "hw:1,0"
     }
  }
EOF
}

build_kwd_engine() {
  #get sensory and build
  echo
  echo "==============> CLONING AND BUILDING KittAI =============="
  echo

  cd $THIRD_PARTY_PATH
 # git clone git://github.com:Kitt-AI/snowboy.git

  #Compile a supported swig version (3.0.10 or above)
  wget http://downloads.sourceforge.net/swig/swig-3.0.10.tar.gz
  tar -xvf swig-3.0.10.tar.gz
  cd swig-3.0.10
  sudo apt-get install libpcre3 libpcre3-dev
  ./configure --prefix=/usr                  \
        --without-clisp                    \
        --without-maximum-compile-warnings &&
  make
  make install &&
  install -v -m755 -d /usr/share/doc/swig-3.0.10 &&
  cp -v -R Doc/* /usr/share/doc/swig-3.0.10
  

  # Copy necessary files to model dir
  cd $KITTAI_RES/alexa/alexa-avs-sample-app
  cp alexa.umdl $KITTAI_RES/models
  cd $KITTAI_RES
  cp common.res $KITTAI_RES/models
  cd $KITTAI_RES
  cp *.wav $KITTAI_RES/models
}

build_nghttp2() {
  #get nghttp2 and build
  echo
  echo "==============> CLONING AND BUILDING NGHTTP2 =============="
  echo

if [ -e "$NGHTTP2_DIR" ]
 then
 echo "======'nghttp2' already exists and is not an empty directory ====SKIP===="
else
 cd $THIRD_PARTY_PATH
 git clone https://github.com/tatsuhiro-t/nghttp2.git

 cd nghttp2
 autoreconf -i
 automake
 autoconf
 ./configure

 make
 sudo make install

fi
}

configure_nghttp2() {
  #Download the latest version of curl and configure with support for nghttp2 and openssl:
  echo
  echo "==============> CONFIGURE NGHTTP2 =============="
  echo
if [ -e "$NGHTTP2_DIR" ]
 then
 echo "======'nghttp2' already exists and is not an empty directory ====SKIP===="
else
 cd $THIRD_PARTY_PATH
 wget http://curl.haxx.se/download/curl-7.54.0.tar.bz2
 tar -xvjf curl-7.54.0.tar.bz2 

 cd curl-7.54.0
 ./configure --with-nghttp2=/usr/local --with-ssl

 make
 sudo make install

 #Unlink symbolic link if exist
 sudo unlink /usr/local/lib/libcurl.so.4

 #Make symbolic link for libcurl
 sudo ln -fs /usr/lib/libcurl.so.4 /usr/local/lib/
 sudo ldconfig
fi

}

generate_start_script() {
  cat << EOF > "$START_SCRIPT"
  cd "$BUILD_PATH/SampleApp/src"

  ./SampleApp "$OUTPUT_CONFIG_FILE" "$KITTAI_RES/snowboy/resources/models" DEBUG9
EOF
}
