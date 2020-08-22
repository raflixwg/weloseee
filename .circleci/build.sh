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
# Build nomi
echo "Starting building noMi"

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="circleci"
export CROSS_COMPILE="/root/project/fiency/kernel/gcc64/bin/aarch64-linux-android-"
export CROSS_COMPILE_ARM32="/root/project/fiency/kernel/gcc32/bin/arm-linux-androideabi-"

make O=nomi ARCH=arm64 SUBARCH=arm64 X01BD_defconfig

make -j$(nproc --all) O=nomi ARCH=arm64 \
                        CC="/root/project/fiency/kernel/clang/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"
                        
cp nomi/arch/arm64/boot/Image.gz-dtb AnyKernel

# Zipping
function zipping() {
    cd AnyKernel || exit 1
    zip -r9 ${TANGGAL}Fiency-noMi.zip *
    cd ..
}

# Push kernel to channel
function push() {
    cd AnyKernel
    ZIP=$(echo *.zip)
    curl -F document=@$ZIP "https://api.telegram.org/bot1297366089:AAHXfN5kK3BKWyVOk3JmH7Aa8HNbIpnJKhE/sendDocument" \
        -F chat_id="-1001450556997" \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" \
        -F caption="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s). | For <b>XOBOD xixixi</b> |"
}
zipping
push
