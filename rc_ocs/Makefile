all:
	cd src
	vasmm68k_mot -devpac -nocase -Fhunk -DUSE_CLIPPING -DSQRT_SMALL -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./src/rc.o ./src/rc.s
	vlink -bamigahunk -o ./rc -s -DUSE_CLIPPING -DSQRT_SMALL -DUSE_DBLBUF -DUSE_BPL_SECTION  ./src/rc.o
	chmod 777 ./rc