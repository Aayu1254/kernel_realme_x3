rm -rf Arcturus*.zip
mkdir -p out
make O=out ARCH=arm64 x3_defconfig
echo Building
make -j$(nproc --all) O=out LLVM=1\
		ARCH=arm64 \
		AS="/workspaces/codespaces-blank/clang/bin/llvm-as" \
		CC="/workspaces/codespaces-blank/clang/bin/clang" \
		LD="/workspaces/codespaces-blank/clang/bin/ld.lld" \
		AR="/workspaces/codespaces-blank/clang/bin/llvm-ar" \
		NM="/workspaces/codespaces-blank/clang/bin/llvm-nm" \
		STRIP="/workspaces/codespaces-blank/clang/bin/llvm-strip" \
		OBJCOPY="/workspaces/codespaces-blank/clang/bin/llvm-objcopy" \
		OBJDUMP="/workspaces/codespaces-blank/clang/bin/llvm-objdump" \
		CLANG_TRIPLE=aarch64-linux-gnu- \
		CROSS_COMPILE="/workspaces/codespaces-blank/clang/bin/clang" \
                CROSS_COMPILE_COMPAT="/workspaces/codespaces-blank/clang/bin/clang" \
                CROSS_COMPILE_ARM32="/workspaces/codespaces-blank/clang/bin/clang"


kernel="out/arch/arm64/boot/Image.gz"
dtb="out/arch/arm64/boot/dts/qcom/sm8150-v2.dtb"
dtbo="out/arch/arm64/boot/dtbo.img"

AK3_DIR="/workspaces/codespaces-blank/AnyKernel3"
ZIPNAME="Arcturus-X3-$(date '+%Y%m%d-%H%M').zip"

if [ -f "$kernel" ] && [ -f "$dtb" ] && [ -f "$dtbo" ]; then
	echo -e "\nKernel compiled succesfully! Zipping up...\n"
	if [ -d "$AK3_DIR" ]; then
		cp -r $AK3_DIR AnyKernel3
	cp $kernel $dtbo AnyKernel3
	cp $dtb AnyKernel3/dtb
	rm -rf out/arch/arm64/boot
	cd AnyKernel3
	git checkout x3 &> /dev/null
	zip -r9 "../$ZIPNAME" * -x .git README.md *placeholder
	cd ..
	rm -rf AnyKernel3
	echo -e "\nCompleted in $((SECONDS / 60)) minute(s) and $((SECONDS % 60)) second(s) !"
	echo "Zip: $ZIPNAME"
		curl -sL https://git.io/file-transfer | sh
                ./transfer wet Arcturus*.zip
			echo
fi
fi
