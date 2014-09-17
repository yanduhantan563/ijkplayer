#! /usr/bin/env bash

#----------
UNI_BUILD_ROOT=`pwd`
FF_TARGET=$1
set -e
set +x

FF_ALL_ARCHS="armv5 armv7a x86"

echo_archs() {
    echo "===================="
    echo "[*] check archs"
    echo "===================="
    echo "FF_ALL_ARCHS = $FF_ALL_ARCHS"
    echo ""
}

#----------
if [ "$FF_TARGET" = "armv5" -o "$FF_TARGET" = "armv7a" ]; then
    echo_archs
    sh tools/do-compile-openssl.sh $FF_TARGET
elif [ "$FF_TARGET" = "x86" ]; then
    echo_archs
    sh tools/do-compile-openssl.sh $FF_TARGET
elif [ "$FF_TARGET" = "all" ]; then
    echo_archs
    for ARCH in $FF_ALL_ARCHS
    do
        sh tools/do-compile-openssl.sh $ARCH
    done
elif [ "$FF_TARGET" == "check" ]; then
    echo_archs
elif [ "$FF_TARGET" == "clean" ]; then
    echo_archs
    for ARCH in $FF_ALL_ARCHS
    do
        cd openssl-$ARCH && git clean -xdf && cd -
    done
    rm -rf ./build/openssl-*
else
    echo "Usage:"
    echo "  compile-openssl.sh armv5|armv7a|x86"
    echo "  compile-openssl.sh all"
    echo "  compile-openssl.sh clean"
    echo "  compile-openssl.sh check"
    exit 1
fi

#----------
echo "\n--------------------"
echo "[*] Finished"
echo "--------------------"
echo "# to continue to build ffmpeg, run script below,"
echo "sh compile-ffmpeg.sh "
echo "# to continue to build ijkplayer, run script below,"
echo "sh compile-ijk.sh "
