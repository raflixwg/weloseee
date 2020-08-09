#!/bin/bash

#Deleting Kernel Image Before
cd /home/itswege/itswege/Source
echo "Deleting Kernel Image Before"
rm -rf ame

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="wege-Local"
export CROSS_COMPILE=/home/itswege/itswege/gcc64/aarch64-linux-gnu/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/itswege/itswege/gcc32/aarch64-linux-gnu/bin/arm-linux-androideabi-

make O=ame ARCH=arm64 SUBARCH=arm64 X01BD_defconfig

make -j$(nproc --all) O=ame ARCH=arm64 \
                        CC="/home/itswege/itswege/proton/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"

