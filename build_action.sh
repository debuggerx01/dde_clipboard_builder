#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt update
# apt install -y software-properties-common
# add-apt-repository ppa:ubuntudde-dev/stable
# apt update
# apt install -y git libdtkcore-dev libdtkgui-dev libdtkwidget-dev
apt install -y git

git config --global user.email "dx8917312@163.com"
git config --global user.name "debuggerx"

TAG="5.4.24"

git clone https://github.com/linuxdeepin/dde-clipboard.git --branch $TAG

cd dde-clipboard || exit

git am ../handle_enter_key.patch

git status

apt build-dep -y .
apt install -y qt5-default

mkdir build

cd build || exit
cmake -D CMAKE_BUILD_TYPE=Release ..
CPU_CORES=$(($(grep -c processor < /proc/cpuinfo)*2))

make -j"$CPU_CORES"

ls

strip dde-clipboard

cd ..
cd ..

mkdir "artifact"

mv dde-clipboard/build/dde-clipboard artifact/
