#!/bin/bash

# Build nomi
echo "Starting building noMi"
echo "Deleting Kernel Image Before"
rm -rf nomi 

# Go to nomi
git checkout nomi
echo "nomi branch...Checked..."
echo "Start Building..."
       
# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="wege-Local"
export CROSS_COMPILE=/home/itswege/itswege/Toolchain/gcc64/aarch64-linux-gnu/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/itswege/itswege/Toolchain/gcc32/aarch64-linux-gnu/bin/arm-linux-androideabi-

make O=nomi ARCH=arm64 SUBARCH=arm64 X01BD_defconfig

make -j$(nproc --all) O=nomi ARCH=arm64 \
                        CC="/home/itswege/itswege/Toolchain/dtc/DragonTC/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"
