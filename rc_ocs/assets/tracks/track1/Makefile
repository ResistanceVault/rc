TRACKNAME = TRACK1

all:
	rm -f ./images/rc045_320X240X8.raw ./images/rc045_320X240X8.pal ./images/rc045_320X240X8.raw.*
	ilbm2raw  ./images/rc045_320X240X8.iff ./images/rc045_320X240X8.raw -p ./images/rc045_320X240X8.pal
	split -b 9600 ./images/rc045_320X240X8.raw ./images/rc045_320X240X8.raw.
	cp ./images/rc045_320X240X8.raw.aa ./images/rc045_320X240X8.raw.ab ./images/rc045_320X240X8.raw.ac ./images/rc045_320X240X8.pal ../../../src/assets/tracks/track1/

	rm -f ./images/rc045_320X240X32.raw ./images/rc045_320X240X32.pal ./images/rc045_320X240X32.raw.*
	ilbm2raw  ./images/rc045_320X240X32.iff ./images/rc045_320X240X32.raw -p ./images/rc045_320X240X32.pal -s 17,11 -s 18,2 -s 21,4 -s 22,6 -s 25,30 -s 26,5

	split -b 9600 ./images/rc045_320X240X32.raw ./images/rc045_320X240X32.raw.
	cp ./images/rc045_320X240X32.raw.aa ./images/rc045_320X240X32.raw.ab ./images/rc045_320X240X32.raw.ac ./images/rc045_320X240X32.raw.ad ./images/rc045_320X240X32.raw.ae ./images/rc045_320X240X32.pal ../../../src/assets/tracks/track1/

	cp ./metadata/rc045_320X240X8.data ../../../src/assets/tracks/track1/rc045_320X240X8.data
	cp ./images/rc045_320X240X32.raw ../../../buildadf/tracks/TRACK1.TRK
	cat ./images/rc045_320X240X32.pal >> ../../../buildadf/tracks/TRACK1.TRK
	cat ./metadata/rc045_320X240X8.data >> ../../../buildadf/tracks/TRACK1.TRK

	# car 1 position
	echo 00 74 00 c8 00 00 | xxd -r -p >> ../../../buildadf/tracks/TRACK1.TRK

	# car 2 position
	echo 00 88 00 c8 00 00 | xxd -r -p >> ../../../buildadf/tracks/TRACK1.TRK

	# car 3 position
	echo 00 60 00 c8 00 00 | xxd -r -p >> ../../../buildadf/tracks/TRACK1.TRK

	# car 4 position
	echo 00 4c 00 c8 00 00 | xxd -r -p >> ../../../buildadf/tracks/TRACK1.TRK

	# car 5 position
	echo 00 3c 00 c8 00 00 | xxd -r -p >> ../../../buildadf/tracks/TRACK1.TRK

	# car 6 position
	echo 00 2f 00 c8 00 00 | xxd -r -p >> ../../../buildadf/tracks/TRACK1.TRK

	# car 7 position
	echo 00 2f 00 d2 00 00 | xxd -r -p >> ../../../buildadf/tracks/TRACK1.TRK

	# car 8 position
	echo 00 20 00 d2 00 00 | xxd -r -p >> ../../../buildadf/tracks/TRACK1.TRK

	# CPU positions

	# Section 1
	printf "%04x%04x\n" 206 195 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 226 202 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 247 202 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 264 195 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 276 183 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 285 166 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 290 141 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 2
	printf "%04x%04x\n" 294 117 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 284 103 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 265 102 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 256 109 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 239 123 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 3
	printf "%04x%04x\n" 228 114 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 220 112 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 216 105 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 4
	printf "%04x%04x\n" 212 98 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 217 89 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 212 75 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 222 57 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 226 39 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 213 30 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 197 26 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 190 28 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 184 33 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 169 41 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 157 58 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 156 72 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 160 90 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 5
	printf "%04x%04x\n" 167 114 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 161 131 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 150 147 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 6
	printf "%04x%04x\n" 128 139 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 111 132 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 89 121 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 7
	printf "%04x%04x\n" 61 102 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 44 85 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 30 63 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 27 43 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 8
	printf "%04x%04x\n" 38 26 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 55 25 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 75 28 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 94 32 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 102 43 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 105 55 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 9
	printf "%04x%04x\n" 104 79 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 93 94 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 77 116 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 10
	printf "%04x%04x\n" 61 130 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 59 140 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 55 152 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 53 165 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 49 190 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 72 196 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 11
	printf "%04x%04x\n" 83 203 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 114 196 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 135 195 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 156 194 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 177 193 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	for number in `seq 1 192`; do \
        echo FF FF FF FF | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK ;\
    done

	cp ../../../buildadf/tracks/TRACK1.TRK ../../../bin/tracks/TRACK1.TRK
	chmod -R 777  ../../../bin/tracks

	cd ../../../bin/tracks && Shrinkler --data TRACK1.TRK ../tracksshr/TRACK1.TRK && chmod 666 ../tracksshr/TRACK1.TRK

	cp -p ../../../bin/tracksshr/TRACK1.TRK ../../../buildadf/tracksshr/TRACK1.TRK

