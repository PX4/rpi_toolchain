#!/usr/bin/env bash
echo "Installing PX4 Native Toolchain for Raspberry Pi"
echo "======================================================="
sudo apt-get update && sudo apt-get upgrade

dpkg -i packages/*.deb
sudo rm /usr/bin/cpp /usr/bin/gcc /usr/bin/g++
sudo ln -s /usr/bin/cpp-4.9 /usr/bin/cpp
sudo ln -s /usr/bin/gcc-4.9 /usr/bin/gcc
sudo ln -s /usr/bin/g++-4.9 /usr/bin/g++

echo 'OK'
cmake --version
echo ' '
gcc -v
