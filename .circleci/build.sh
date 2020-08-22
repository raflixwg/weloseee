#!/usr/bin/env bash
echo "Cloning dependencies"
git clone --depth=1 https://github.com/itswege/fiency_kernel -b  circleci-project-setup kernel
cd kernel
git clone --depth=1 https://github.com/ZyCromerZ/DragonTC -b daily/10.0 clang
git clone --depth=1 https://github.com/itswege/AnyKernel3-1 AnyKernel
git clone --depth=1 https://github.com/najahiiii/aarch64-linux-gnu.git -b 4.9-mirror gcc64
git clone --depth=1 https://github.com/najahiiii/aarch64-linux-gnu.git -b 4.9-32-mirror gcc32
echo "Done"
IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
TANGGAL=$(date +"%F-%S")
START=$(date +"%s")
export CONFIG_PATH=$PWD/arch/arm64/configs/X01BD_defconfig
PATH="${pwd}/clang/bin:${pwd}/gcc64/bin:${pwd}/gcc32/bin:${PATH}"
export ARCH=arm64
export KBUILD_BUILD_HOST=circleci
export KBUILD_BUILD_USER="itswege"
# Compile plox
function compile() {
    make -j$(nproc) O=out ARCH=arm64 X01BD_defconfig
    make -j$(nproc) O=out \
                    ARCH=arm64 \
                    CC=clang \
                    CLANG_TRIPLE=aarch64-linux-gnu- \
                    CROSS_COMPILE=aarch64-linux-android- \
                    CROSS_COMPILE_ARM32=arm-linux-androideabi-

    if ! [ -a "$IMAGE" ]; then
        finerr
        exit 1
    fi
    buildsucs
    cp out/arch/arm64/boot/Image.gz-dtb AnyKernel
}
# Zipping
function zipping() {
    cd AnyKernel || exit 1
    zip -r9 ${TANGGAL}Fiency-noMi.zip *
    cd .. 
}
compile
zipping

