all:
	cd src
	vasmm68k_mot -devpac -nocase -Fhunk -DQ10_6_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./src/rc.o ./src/rc.s
	vlink -bamigahunk -o ./rc -s -DQ10_6_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  ./src/rc.o
	chmod 777 ./rc

	vasmm68k_mot -devpac -nocase -Fhunk -DQ10_6_TABLE_LOOKUP -DDEBUG -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./src/rc_debug.o ./src/rc.s
	vlink -bamigahunk -o ./rc_debug -s -DQ10_6_TABLE_LOOKUP -DDEBUG -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  ./src/rc_debug.o
	chmod 777 ./rc_debug