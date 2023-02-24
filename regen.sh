#!/bin/bash

DEFCONFIG="x3_defconfig"

make -j"$(nproc --all)" O=out ARCH=arm64 SUBARCH=arm64 "$DEFCONFIG"
cp -af out/.config arch/arm64/configs/"$DEFCONFIG"
git add arch/arm64/configs/"${DEFCONFIG}"
git commit -m "ARM64: configs: x3: Regenerate defconfig"
echo -e "\nSuccessfully regenerated defconfig at $DEFCONFIG"
