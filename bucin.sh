#!/bin/bash

#Deleting Kernel Image Before
cd /home/itswege/itswege/Ame
echo "Deleting Kernel Image Before"
rm -rf kata

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="wege-Local"
export CROSS_COMPILE=/home/itswege/itswege/Toolchain/gcc64/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/itswege/itswege/Toolchain/gcc32/bin/arm-linux-androideabi-

make O=kata ARCH=arm64 SUBARCH=arm64 bucin_defconfig

make -j$(nproc --all) O=kata ARCH=arm64 \
                        CC="/home/itswege/itswege/Toolchain/dtc/DragonTC/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"

