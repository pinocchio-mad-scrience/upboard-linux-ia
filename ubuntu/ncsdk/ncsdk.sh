#!/bin/bash

git clone https://github.com/movidius/ncsdk.git
cd scripts
cp -r install.sh ../ncsdk
cd ../ncsdk
make install

