#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt update
# apt install -y software-properties-common
# add-apt-repository ppa:ubuntudde-dev/stable
# apt update
# apt install -y git libdtkcore-dev libdtkgui-dev libdtkwidget-dev
apt install -y git

TAG="5.4.24"

git clone https://github.com/linuxdeepin/dde-clipboard.git --branch $TAG

cd dde-clipboard || exit


apt build-dep -y .
apt install -y qt5-default

mkdir build

cd build || exit
cmake ..

CPU_CORES=$(($(grep -c processor < /proc/cpuinfo)*2))

make -j"$CPU_CORES"

ls

cd ..
cd ..

mkdir "artifact"

mv dde-clipboard/build/dde-clipboard artifact/
