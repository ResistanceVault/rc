define strip_odd_bytes
    > $2
	for number in 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40; do \
		dd if=$1 skip=$$number count=1 bs=1 status=none oflag=append conv=notrunc of=$2; \
    done
endef

define strip_odd_bytes_mask
    > $2
	for number in 0 2 4 6 8 10 12; do \
		dd if=$1 skip=$$number count=1 bs=1 status=none oflag=append conv=notrunc of=$2; \
    done
endef

define copy
	cp $1 $2
endef


all:
	ilbm2raw -f -i ./cursor_left.iff ./cursor_left.raw
	cp ./cursor_left.raw ../../src/assets/cursors/cursor_left.spr
	ilbm2raw -f -r ./cursor_left_mask_reversed.raw ./cursor_left.iff ./cursor_left.raw
	cp ./cursor_left_mask_reversed.raw ../../src/assets/cursors/cursor_left_mask_reversed.raw
	cp ./cursor_left.raw ../../src/assets/cursors/cursor_left.raw

	ilbm2raw -f -i ./cursor_right.iff ./cursor_right.raw
	cp ./cursor_right.raw ../../src/assets/cursors/cursor_right.spr
	ilbm2raw -f -r ./cursor_right_mask_reversed.raw ./cursor_right.iff ./cursor_right.raw
	cp ./cursor_right_mask_reversed.raw ../../src/assets/cursors/cursor_right_mask_reversed.raw
	cp ./cursor_right.raw ../../src/assets/cursors/cursor_right.raw

	ilbm2raw -f -i ./cursor_left_small.iff ./cursor_left_small.raw
	cp ./cursor_left_small.raw ../../src/assets/cursors/cursor_left_small.spr
	ilbm2raw -f -r ./cursor_left_small_mask_reversed.raw ./cursor_left_small.iff ./cursor_left_small.raw
	$(call strip_odd_bytes,./cursor_left_small.raw,../../src/assets/cursors/cursor_left_small.raw)
	$(call strip_odd_bytes_mask,./cursor_left_small_mask_reversed.raw,../../src/assets/cursors/cursor_left_small_mask_reversed.raw)

	ilbm2raw -f -i ./cursor_right_small.iff ./cursor_right_small.raw
	cp ./cursor_right_small.raw ../../src/assets/cursors/cursor_right_small.spr
	ilbm2raw -f -r ./cursor_right_small_mask_reversed.raw ./cursor_right_small.iff ./cursor_right_small.raw
	$(call strip_odd_bytes,./cursor_right_small.raw,../../src/assets/cursors/cursor_right_small.raw)
	$(call strip_odd_bytes_mask,./cursor_right_small_mask_reversed.raw,../../src/assets/cursors/cursor_right_small_mask_reversed.raw)
