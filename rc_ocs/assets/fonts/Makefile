define strip_odd_bytes
    > $2
	for number in 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40; do \
		dd if=$1 skip=$$number count=1 bs=1 status=none oflag=append conv=notrunc of=$2; \
    done
endef

all:
	rm -f ./small/0.raw
	ilbm2raw  ./small/0.iff ./small/0.raw -p ../../src/assets/fonts/small/colors.plt
	$(call strip_odd_bytes,./small/0.raw,../../src/assets/fonts/small/0.raw)

	rm -f ./small/1.raw
	ilbm2raw  ./small/1.iff ./small/1.raw
	$(call strip_odd_bytes,./small/1.raw,../../src/assets/fonts/small/1.raw)

	rm -f ./small/2.raw
	ilbm2raw  ./small/2.iff ./small/2.raw
	$(call strip_odd_bytes,./small/2.raw,../../src/assets/fonts/small/2.raw)

	rm -f ./small/3.raw
	ilbm2raw  ./small/3.iff ./small/3.raw
	$(call strip_odd_bytes,./small/3.raw,../../src/assets/fonts/small/3.raw)

	rm -f ./small/4.raw
	ilbm2raw  ./small/4.iff ./small/4.raw
	$(call strip_odd_bytes,./small/4.raw,../../src/assets/fonts/small/4.raw)

	rm -f ./small/5.raw
	ilbm2raw  ./small/5.iff ./small/5.raw
	$(call strip_odd_bytes,./small/5.raw,../../src/assets/fonts/small/5.raw)

	rm -f ./small/6.raw
	ilbm2raw  ./small/6.iff ./small/6.raw
	$(call strip_odd_bytes,./small/6.raw,../../src/assets/fonts/small/6.raw)

	rm -f ./small/7.raw
	ilbm2raw  ./small/7.iff ./small/7.raw
	$(call strip_odd_bytes,./small/7.raw,../../src/assets/fonts/small/7.raw)

	rm -f ./small/8.raw
	ilbm2raw  ./small/8.iff ./small/8.raw
	$(call strip_odd_bytes,./small/8.raw,../../src/assets/fonts/small/8.raw)

	rm -f ./small/9.raw
	ilbm2raw  ./small/9.iff ./small/9.raw
	$(call strip_odd_bytes,./small/9.raw,../../src/assets/fonts/small/9.raw)