define strip_odd_bytes
    > $2
	for number in 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40; do \
		dd if=$1 skip=$$number count=1 bs=1 status=none oflag=append conv=notrunc of=$2; \
    done
endef

define copy
	cp $1 $2
endef

all:
	rm -f ./off.raw ../../src/assets/phazelogo/colors.plt
	ilbm2raw  ./off.iff ./off.raw -p ../../src/assets/phazelogo/colors.plt
	$(call strip_odd_bytes,./off.raw,../../src/assets/phazelogo/off.raw)

	rm -f ./on.raw ../../src/assets/phazelogo/colors.plt
	ilbm2raw  ./on.iff ./on.raw
	$(call strip_odd_bytes,./on.raw,../../src/assets/phazelogo/on.raw)

	ilbm2raw -f phaze.iff ../../src/assets/phazelogo/phazelogo.raw -p ../../src/assets/phazelogo/phazelogo.plt