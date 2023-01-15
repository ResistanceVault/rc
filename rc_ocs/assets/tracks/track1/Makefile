all:
	rm -f ./images/rc045_320X240X8.raw ./images/rc045_320X240X8.pal ./images/rc045_320X240X8.raw.*
	ilbm2raw  ./images/rc045_320X240X8.iff ./images/rc045_320X240X8.raw -p ./images/rc045_320X240X8.pal
	split -b 9600 ./images/rc045_320X240X8.raw ./images/rc045_320X240X8.raw.
	cp ./images/rc045_320X240X8.raw.aa ./images/rc045_320X240X8.raw.ab ./images/rc045_320X240X8.raw.ac ./images/rc045_320X240X8.pal ../../../src/assets/tracks/track1/

	rm -f ./images/rc045_320X240X32.raw ./images/rc045_320X240X32.pal ./images/rc045_320X240X32.raw.*
	ilbm2raw  ./images/rc045_320X240X32.iff ./images/rc045_320X240X32.raw -p ./images/rc045_320X240X32.pal -s 17,11 -s 18,2 -s 19,23 -s 22,6 -s 21,0
	split -b 9600 ./images/rc045_320X240X32.raw ./images/rc045_320X240X32.raw.
	cp ./images/rc045_320X240X32.raw.aa ./images/rc045_320X240X32.raw.ab ./images/rc045_320X240X32.raw.ac ./images/rc045_320X240X32.raw.ad ./images/rc045_320X240X32.raw.ae ./images/rc045_320X240X32.pal ../../../src/assets/tracks/track1/