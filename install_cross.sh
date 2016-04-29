#!/usr/bin/env bash

echo "Installing PX4 Cross-Compile Toolchain for Raspberry Pi"
echo "======================================================="

TOOLCHAIN_DIR="$1"
#TODO : check for valid path
if [ "${TOOLCHAIN_DIR}" == "" ]; then
  echo -e "No install path specified, installing to default location at /opt/rpi_toolchain/\n"
  TOOLCHAIN_DIR="/opt/rpi_toolchain"
else
  echo "Installing cross-compiler to $TOOLCHAIN_DIR"
fi

git clone --depth 1 https://github.com/raspberrypi/tools.git rpi_toolchain
if [ $? -eq 0 ]; then
    echo "Toolchain downloaded successfully"
else
    echo "Toolchain download failure"
    exit 1
fi

sudo mkdir -p $TOOLCHAIN_DIR/gcc-linaro-arm-linux-gnueabihf-raspbian

MACHINE_TYPE=`uname -m`
if [ "${MACHINE_TYPE}" == "x86_64" ]; then
  echo "Installing for x86_64 system"
  sudo cp -r rpi_toolchain/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/* $TOOLCHAIN_DIR/gcc-linaro-arm-linux-gnueabihf-raspbian
else
  echo "Installing for x86_32 system"
  sudo cp -r rpi_toolchain/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/* $TOOLCHAIN_DIR/gcc-linaro-arm-linux-gnueabihf-raspbian
fi

exportline="export RPI_TOOLCHAIN_DIR=$TOOLCHAIN_DIR"
if grep -Fxq "$exportline" ~/.profile; then echo 'Already installed' ; else echo $exportline >> ~/.profile; fi
  
echo -e "Cleaning up\n"
rm -rf rpi_toolchain

$TOOLCHAIN_DIR/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc --version

if [ $? -eq 0 ]; then
    echo -e "Install complete"
    exit 0
else
    echo "Install failed"
    exit 1
fi

