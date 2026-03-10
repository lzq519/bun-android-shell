#!/usr/bin/env bash
set -e

ARCH=$1
API=21

TOOLCHAIN=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64

if [ "$ARCH" = "armv7a" ]; then
  TARGET=armv7a-linux-androideabi
elif [ "$ARCH" = "arm64" ]; then
  TARGET=aarch64-linux-android
else
  echo "unknown arch"
  exit 1
fi

export CC=$TOOLCHAIN/bin/${TARGET}${API}-clang
export CXX=$TOOLCHAIN/bin/${TARGET}${API}-clang++

cd bun

zig build \
  -Dtarget=$TARGET \
  -Drelease-fast

mkdir -p ../out
cp build/bin/bun ../out/bun
