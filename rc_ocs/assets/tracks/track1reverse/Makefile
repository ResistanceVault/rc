IMAGE8COLORS = rc045reverse_320X240X8
IMAGE32COLORS = rc045reverse_320X240X32
TRACKNAME = TRACK1REVERSE
all:
	ilbm2raw -f ./images/$(IMAGE8COLORS).iff ./images/$(IMAGE8COLORS).raw -p ./images/$(IMAGE8COLORS).pal
	split -b 9600 ./images/$(IMAGE8COLORS).raw ./images/$(IMAGE8COLORS).raw.
	mkdir -p ../../../src/assets/tracks/$(TRACKNAME)
	cp ./images/$(IMAGE8COLORS).raw.aa ./images/$(IMAGE8COLORS).raw.ab ./images/$(IMAGE8COLORS).raw.ac ./images/$(IMAGE8COLORS).pal ../../../src/assets/tracks/$(TRACKNAME)/

	ilbm2raw -f ./images/$(IMAGE32COLORS).iff ./images/$(IMAGE32COLORS).raw -p ./images/$(IMAGE32COLORS).pal -s 17,11 -s 18,2 -s 21,4 -s 22,6 -s 25,30 -s 26,15

	split -b 9600 ./images/$(IMAGE32COLORS).raw ./images/$(IMAGE32COLORS).raw.
	cp ./images/$(IMAGE32COLORS).raw.aa ./images/$(IMAGE32COLORS).raw.ab ./images/$(IMAGE32COLORS).raw.ac ./images/$(IMAGE32COLORS).raw.ad ./images/$(IMAGE32COLORS).raw.ae ./images/$(IMAGE32COLORS).pal ../../../src/assets/tracks/$(TRACKNAME)/

	cp ./metadata/$(IMAGE8COLORS).data ../../../src/assets/tracks/$(TRACKNAME)/$(IMAGE8COLORS).data
	cp ./images/$(IMAGE32COLORS).raw ../../../buildadf/tracks/$(TRACKNAME).TRK
	cat ./images/$(IMAGE32COLORS).pal >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	cat ./metadata/$(IMAGE8COLORS).data >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	cp ../../../buildadf/tracks/$(TRACKNAME).TRK ../../../bin/tracks/$(TRACKNAME).TRK
	chmod 777 ../../../bin/tracks/$(TRACKNAME).TRK

	printf '\x0A\x14' | dd of=output.bin bs=1 seek=0 conv=notrunc

