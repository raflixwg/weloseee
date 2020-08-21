#!/bin/bash

# Building Ameno
echo "Start building ameno kernel..."
echo "Deleting Kernel Image Before"
rm -rf ame

# Go to AmenoBranch 
git checkout ameno
echo "Ameno branch...Checked..."
echo "Start Building..."

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="wege-Local"
export CROSS_COMPILE=/home/itswege/itswege/Toolchain/gcc64/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/itswege/itswege/Toolchain/gcc32/bin/arm-linux-androideabi-

make O=ame ARCH=arm64 SUBARCH=arm64 X01BD_defconfig

make -j$(nproc --all) O=ame ARCH=arm64 \
                        CC="/home/itswege/itswege/Toolchain/dtc/DragonTC/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"

echo "Ameno kernel. Builded..."
echo "Clearing..."
clear

# Building Ameno65
echo "Start building ameno65 kernel..."
echo "Deleting Kernel Image Before"
rm -rf ame65

# Go to AmenoBranch 
git checkout ame65
echo "Ameno branch...Checked..."
echo "Start Building..."

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="wege-Local"
export CROSS_COMPILE=/home/itswege/itswege/Toolchain/gcc64/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/itswege/itswege/Toolchain/gcc32/bin/arm-linux-androideabi-

make O=ame65 ARCH=arm64 SUBARCH=arm64 X01BD_defconfig

make -j$(nproc --all) O=ame65 ARCH=arm64 \
                        CC="/home/itswege/itswege/Toolchain/dtc/DragonTC/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"

echo "Ameno65 kernel. Builded..."
echo "Clearing..."
clear

# Build Katamari
echo "Starting building Katamari"
echo "Deleting Kernel Image Before"
rm -rf kata 

# Go to Katamari
git checkout kata
echo "Kata branch...Checked..."
echo "Start Building..."
       
# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="wege-Local"
export CROSS_COMPILE=/home/itswege/itswege/Toolchain/gcc64/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=/home/itswege/itswege/Toolchain/gcc32/bin/arm-linux-androideabi-

make O=kata ARCH=arm64 SUBARCH=arm64 X01BD_defconfig

make -j$(nproc --all) O=kata ARCH=arm64 \
                        CC="/home/itswege/itswege/Toolchain/dtc/DragonTC/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"

echo "Katamari done..."
echo "Clearing..."
clear

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

