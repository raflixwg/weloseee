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
TOKEN=$("1297366089:AAHXfN5kK3BKWyVOk3JmH7Aa8HNbIpnJKhE")
TANGGAL=$(date +"%F-%S")
START=$(date +"%s")
CHAT=$("-1001450556997")
export CONFIG_PATH=$PWD/arch/arm64/configs/X01BD_defconfig
PATH="${KERNEL_DIR}/clang/bin:${KERNEL_DIR}/gcc64/bin:${KERNEL_DIR}/gcc32/bin:${PATH}"
export ARCH=arm64
export KBUILD_BUILD_HOST=circleci
export KBUILD_BUILD_USER="itswege"
# sticker plox
function sticker() {
    curl -s -X POST "https://api.telegram.org/${TOKEN}/sendSticker" \
        -d sticker="CAACAgUAAxkBAAEzWbBfQSgNu33lb-GgiKUXVtOKmDtskwACdQAD4IC4MrAAATFs0GP_5xsE" \
        -d chat_id=${CHAT}
}
# Send info plox channel
function sendinfo() {
    curl -s -X POST "https://api.telegram.org/${TOKEN}/sendMessage" \
        -d chat_id="${CHAT}" \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=html" \
        -d text="<b>• Fiency-noMi Kernel •</b>%0ABuild started on <code>Circle CI</code>%0AFor device <b>Asus Zenfone Max Pro M2</b> (X01BD)%0Abranch <code>$(git rev-parse --abbrev-ref HEAD)</code>(master)%0AUnder commit <code>$(git log --pretty=format:'"%h : %s"' -1)</code>%0AUsing compiler: <code>$(${GCC}gcc --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')</code>%0AStarted on <code>$(date)</code>%0A<b>Build Status:</b>#Stable"
}
# Push kernel to channel
function push() {
    cd AnyKernel
    ZIP=$(echo *.zip)
    curl -F document=@$ZIP "https://api.telegram.org/${TOKEN}/sendDocument" \
        -F chat_id="${CHAT}" \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" \
        -F caption="Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s). | For <b>Asus Zenfone Max Pro M2 (X01BD)</b> | <b>$(${GCC}gcc --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')</b>"
}
# Fin Error
function finerr() {
    curl -s -X POST "https://api.telegram.org/${TOKEN}/sendMessage" \
        -d chat_id="${CHAT}" \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=markdown" \
        -d text="Build throw an error(s)"
    exit 1
}
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
sticker
sendinfo
compile
zipping
END=$(date +"%s")
DIFF=$(($END - $START))
push

