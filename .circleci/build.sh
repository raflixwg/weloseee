#!/usr/bin/env bash
echo "Cloning dependencies"
git clone --depth=1 https://github.com/itswege/fiency_kernel -b nomi nomi
cd nomi
git clone --depth=1 https://github.com/ZyCromerZ/DragonTC -b daily/10.0 clang
git clone --depth=1 https://github.com/itswege/AnyKernel3-1 AnyKernel
git clone --depth=1 https://github.com/najahiiii/aarch64-linux-gnu.git -b 4.9-mirror gcc64
git clone --depth=1 https://github.com/najahiiii/aarch64-linux-gnu.git -b 4.9-32-mirror gcc32
echo "Done"
IMAGE=$(pwd)/out/arch/arm64/boot/Image.gz-dtb
TANGGAL=$(date +"%d%m" )
START=$(date +"%s")
# Build nomi
echo "Starting building noMi"

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="circleci"
export CROSS_COMPILE="/root/project/fiency/nomi/gcc64/bin/aarch64-linux-android-"
export CROSS_COMPILE_ARM32="/root/project/fiency/nomi/gcc32/bin/arm-linux-androideabi-"

make O=nomi ARCH=arm64 SUBARCH=arm64 X01BD_defconfig

make -j$(nproc --all) O=nomi ARCH=arm64 \
                        CC="/root/project/fiency/nomi/clang/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"
                        
cp nomi/arch/arm64/boot/Image.gz-dtb AnyKernel

# Zipping
function zipping1() {
    cd AnyKernel || exit 1
    zip -r9 [${TANGGAL}]Fiency-noMi.zip *
    cd ..
}

# Push kernel to Tele
function push1() {
    cd AnyKernel
    ZIP=$(echo *.zip)
    curl -F document=@$ZIP "https://api.telegram.org/bot1297366089:AAHXfN5kK3BKWyVOk3JmH7Aa8HNbIpnJKhE/sendDocument" \
        -F chat_id="-1001431143583" \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" \
        -F caption="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)."
    cd ..
}
zipping1
END=$(date +"%s")
DIFF=$(($END - $START))
push1

# Ameno
cd ..
echo "Cloning dependencies"
git clone --depth=1 https://github.com/itswege/fiency_kernel -b  ameno ame
cd ame
echo "Done"
TANGGAL=$(date +"%d%m" )
START=$(date +"%s")
# Build ame
echo "Starting building Ameno"

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="circleci"
export CROSS_COMPILE="/root/project/fiency/nomi/gcc64/bin/aarch64-linux-android-"
export CROSS_COMPILE_ARM32="/root/project/fiency/nomi/gcc32/bin/arm-linux-androideabi-"

make O=nomi ARCH=arm64 SUBARCH=arm64 X01BD_defconfig

make -j$(nproc --all) O=nomi ARCH=arm64 \
                        CC="/root/project/fiency/nomi/clang/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"
                        
cp nomi/arch/arm64/boot/Image.gz-dtb AnyKernel

# Zipping
function zipping2() {
    cd AnyKernel || exit 1
    zip -r9 [${TANGGAL}]Amenotejikara-60Hz.zip *
    cd ..
}

# Push kernel to Tele
function push2() {
    cd AnyKernel
    ZIP=$(echo *.zip)
    curl -F document=@$ZIP "https://api.telegram.org/bot1297366089:AAHXfN5kK3BKWyVOk3JmH7Aa8HNbIpnJKhE/sendDocument" \
        -F chat_id="-1001431143583" \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" \
        -F caption="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)."
    cd ..
}
zipping2
END=$(date +"%s")
DIFF=$(($END - $START))
push2

# Ameno65
cd ..
echo "Cloning dependencies"
git clone --depth=1 https://github.com/itswege/fiency_kernel -b  ame65 ame65
cd ame65
echo "Done"
TANGGAL=$(date +"%d%m" )
START=$(date +"%s")
# Build ame65
echo "Starting building Ameno"

# Main Environment
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="itswege"
export KBUILD_BUILD_HOST="circleci"
export CROSS_COMPILE="/root/project/fiency/nomi/gcc64/bin/aarch64-linux-android-"
export CROSS_COMPILE_ARM32="/root/project/fiency/nomi/gcc32/bin/arm-linux-androideabi-"

make O=nomi ARCH=arm64 SUBARCH=arm64 X01BD_defconfig

make -j$(nproc --all) O=nomi ARCH=arm64 \
                        CC="/root/project/fiency/nomi/clang/bin/clang" \
                        CLANG_TRIPLE="aarch64-linux-gnu-"
                        
cp nomi/arch/arm64/boot/Image.gz-dtb AnyKernel

# Zipping
function zipping3() {
    cd AnyKernel || exit 1
    zip -r9 [${TANGGAL}]Amenotejikara-65Hz.zip *
    cd ..
}

# Push kernel to Tele
function push3() {
    cd AnyKernel
    ZIP=$(echo *.zip)
    curl -F document=@$ZIP "https://api.telegram.org/bot1297366089:AAHXfN5kK3BKWyVOk3JmH7Aa8HNbIpnJKhE/sendDocument" \
        -F chat_id="-1001431143583" \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" \
        -F caption="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)."
}
zipping3
END=$(date +"%s")
DIFF=$(($END - $START))
push3

