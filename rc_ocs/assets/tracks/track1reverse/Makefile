IMAGE8COLORS = rc045reverse_320X240X8
IMAGE32COLORS = rc045reverse_320X240X32
TRACKNAME = TRACK1REVERSE
all:
	ilbm2raw -f ./images/$(IMAGE8COLORS).iff ./images/$(IMAGE8COLORS).raw -p ./images/$(IMAGE8COLORS).pal
	split -b 9600 ./images/$(IMAGE8COLORS).raw ./images/$(IMAGE8COLORS).raw.
	mkdir -p ../../../src/assets/tracks/$(TRACKNAME)
	cp ./images/$(IMAGE8COLORS).raw.aa ./images/$(IMAGE8COLORS).raw.ab ./images/$(IMAGE8COLORS).raw.ac ./images/$(IMAGE8COLORS).pal ../../../src/assets/tracks/$(TRACKNAME)/

	ilbm2raw -f ./images/$(IMAGE32COLORS).iff ./images/$(IMAGE32COLORS).raw -p ./images/$(IMAGE32COLORS).pal -s 17,11 -s 18,2 -s 21,4 -s 22,6 -s 25,30 -s 26,5

	split -b 9600 ./images/$(IMAGE32COLORS).raw ./images/$(IMAGE32COLORS).raw.
	cp ./images/$(IMAGE32COLORS).raw.aa ./images/$(IMAGE32COLORS).raw.ab ./images/$(IMAGE32COLORS).raw.ac ./images/$(IMAGE32COLORS).raw.ad ./images/$(IMAGE32COLORS).raw.ae ./images/$(IMAGE32COLORS).pal ../../../src/assets/tracks/$(TRACKNAME)/

	cp ./metadata/$(IMAGE8COLORS).data ../../../src/assets/tracks/$(TRACKNAME)/$(IMAGE8COLORS).data
	cp ./images/$(IMAGE32COLORS).raw ../../../buildadf/tracks/$(TRACKNAME).TRK
	cat ./images/$(IMAGE32COLORS).pal >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	cat ./metadata/$(IMAGE8COLORS).data >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# car 1 position
	echo 00 aa 00 2a 00 b4 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# car 2 position
	echo 00 b2 00 35 00 b4 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# car 3 position
	echo 00 bf 00 23 00 a4 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# car 4 position
	echo 00 c7 00 2e 00 a4 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# car 5 position
	echo 00 db 00 23 00 a4 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# car 6 position
	echo 00 eb 00 23 00 a4 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# car 7 position
	echo 00 fb 00 23 00 a4 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# car 8 position
	echo 01 0b 00 23 00 a4 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# CPU positions

	# Section 1
	printf "%04x%04x\n" 122 52 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 90 37 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 63 40 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 52 46 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 43 63 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 35 82 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 2
	printf "%04x%04x\n" 29 104 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 32 122 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 34 135 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 51 139 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 65 120 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 3
	printf "%04x%04x\n" 91 122 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 107 127 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 4
	printf "%04x%04x\n" 109 144 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 108 159 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 100 175 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 93 190 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 94 203 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 105 213 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 124 213 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 137 203 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 151 189 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 158 173 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 161 153 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 5
	printf "%04x%04x\n" 162 133 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 159 113 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 165 92 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 6
	printf "%04x%04x\n" 182 90 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 202 105 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 223 110 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 242 121 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 7
	printf "%04x%04x\n" 263 132 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 276 143 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 292 166 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 301 184 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 8
	printf "%04x%04x\n" 281 213 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 254 212 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 232 207 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 220 197 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 215 181 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Section 9
	printf "%04x%04x\n" 215 168 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 219 154 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 230 137 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	printf "%04x%04x\n" 256 102 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 270 81 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 281 61 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 268 44 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	#Section 10
	printf "%04x%04x\n" 254 41 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 223 41 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 198 50 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 162 56 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x\n" 142 61 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	for number in `seq 1 198`; do \
        echo FF FF FF FF | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK ;\
    done

	# number of zones of the track
	echo 00 0B | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	cp ../../../buildadf/tracks/$(TRACKNAME).TRK ../../../bin/tracks/$(TRACKNAME).TRK
	chmod 777 ../../../bin/tracks/$(TRACKNAME).TRK

	cd ../../../bin/tracks && ../../Shrinkler --data $(TRACKNAME).TRK ../tracksshr/$(TRACKNAME).TRK && chmod 666 ../tracksshr/$(TRACKNAME).TRK

	cp -p ../../../bin/tracksshr/$(TRACKNAME).TRK ../../../buildadf/tracksshr/$(TRACKNAME).TRK