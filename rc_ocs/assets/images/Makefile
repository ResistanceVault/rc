all:
	rm -f ./raw/rc045_320X240X8.raw ./raw/rc045_320X240X8.pal
	ilbm2raw  ./iff/rc045_320X240X8.iff ./raw/rc045_320X240X8.raw -p ./raw/rc045_320X240X8.pal
	split -b 9600 ./raw/rc045_320X240X8.raw ./raw/rc045_320X240X8.raw.

	rm -f ./raw/rc045_320X240X32.raw ./raw/rc045_320X240X32.pal
	ilbm2raw  ./iff/rc045_320X240X32.iff ./raw/rc045_320X240X32.raw -p ./raw/rc045_320X240X32.pal
	split -b 9600 ./raw/rc045_320X240X32.raw ./raw/rc045_320X240X32.raw.