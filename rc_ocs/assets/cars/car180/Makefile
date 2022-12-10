FILENAME=car180_16x16
all:
	rm -f ${FILENAME}.raw
	ilbm2raw ./${FILENAME}.iff ./${FILENAME}.raw
	head -c 64 ${FILENAME}.raw > ${FILENAME}X2.raw

	rm -f ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=0 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=16 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=1 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=17 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=2 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=18 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=3 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=19 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=4 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=20 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=5 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=21 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=6 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=22 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=7 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=23 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=8 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=24 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=9 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=25 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=10 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=26 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=11 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=27 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=12 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=28 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=13 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=29 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=14 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=30 >> ${FILENAME}.sprite

	dd if=${FILENAME}.raw  bs=2 count=1 skip=15 >> ${FILENAME}.sprite
	dd if=${FILENAME}.raw  bs=2 count=1 skip=31 >> ${FILENAME}.sprite

	cp ${FILENAME}.sprite ../../../src/assets/cars/