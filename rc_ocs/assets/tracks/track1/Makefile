all:
	rm -f ./images/rc045_320X240X8.raw ./images/rc045_320X240X8.pal ./images/rc045_320X240X8.raw.*
	ilbm2raw  ./images/rc045_320X240X8.iff ./images/rc045_320X240X8.raw -p ./images/rc045_320X240X8.pal
	split -b 9600 ./images/rc045_320X240X8.raw ./images/rc045_320X240X8.raw.
	cp ./images/rc045_320X240X8.raw.aa ./images/rc045_320X240X8.raw.ab ./images/rc045_320X240X8.raw.ac ./images/rc045_320X240X8.pal ../../../src/assets/tracks/track1/

	rm -f ./images/rc045_320X240X32.raw ./images/rc045_320X240X32.pal ./images/rc045_320X240X32.raw.*
	#ilbm2raw  ./images/rc045_320X240X32.iff ./images/rc045_320X240X32.raw -p ./images/rc045_320X240X32.pal -s 17,11 -s 18,2 -s 19,23 -s 22,6 -s 21,0 -s 25,30 -s 26,29 -s 27,8 -s 29,13
	ilbm2raw  ./images/rc045_320X240X32.iff ./images/rc045_320X240X32.raw -p ./images/rc045_320X240X32.pal -s 17,11 -s 18,2 -s 21,4 -s 22,6 -s 25,30 -s 26,15

	split -b 9600 ./images/rc045_320X240X32.raw ./images/rc045_320X240X32.raw.
	cp ./images/rc045_320X240X32.raw.aa ./images/rc045_320X240X32.raw.ab ./images/rc045_320X240X32.raw.ac ./images/rc045_320X240X32.raw.ad ./images/rc045_320X240X32.raw.ae ./images/rc045_320X240X32.pal ../../../src/assets/tracks/track1/

	cp ./metadata/rc045_320X240X8.data ../../../src/assets/tracks/track1/rc045_320X240X8.data
	cp ./images/rc045_320X240X32.raw ../../../buildadf/tracks/track1.trk
	cat ./images/rc045_320X240X32.pal >> ../../../buildadf/tracks/track1.trk
	cat ./metadata/rc045_320X240X8.data >> ../../../buildadf/tracks/track1.trk

	cp ../../../buildadf/tracks/track1.trk ../../../bin/tracks/track1.trk
	chmod -R 777  ../../../bin/tracks