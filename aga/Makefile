all:
	vasmm68k_mot -devpac -nocase -Fhunk -DUSE_CLIPPING -DSQRT_SMALL -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./Lezione15d.o ./Lezione15d.s
	vlink -bamigahunk -o ./Lezione15d -s -DUSE_CLIPPING -DSQRT_SMALL -DUSE_DBLBUF -DUSE_BPL_SECTION  ./Lezione15d.o
	chmod 777 ./Lezione15d


	vasmm68k_mot -devpac -nocase -Fhunk -DUSE_CLIPPING -DSQRT_SMALL -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./Lezione15i.o ./Lezione15i.s
	vlink -bamigahunk -o ./Lezione15i -s -DUSE_CLIPPING -DSQRT_SMALL -DUSE_DBLBUF -DUSE_BPL_SECTION  ./Lezione15i.o
	chmod 777 ./Lezione15i