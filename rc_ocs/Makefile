all:
	cd src
	vasmm68k_mot -devpac -nocase -Fhunk -DSOUND -DQ4_12_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./src/rc.o ./src/rc.s
	vlink -bamigahunk -o ./bin/rc -s -DSOUND -DQ4_12_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  ./src/rc.o
	chmod 777 ./bin/rc

	vasmm68k_mot -devpac -nocase -Fhunk -DQ4_12_TABLE_LOOKUP -DDEBUG -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./src/rc_debug.o ./src/rc.s
	vlink -bamigahunk -o ./bin/rc_debug -s -DQ4_12_TABLE_LOOKUP -DDEBUG -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  ./src/rc_debug.o
	chmod 777 ./bin/rc_debug