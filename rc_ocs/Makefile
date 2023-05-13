.PHONY: adf

all:
	cp assets/extra/rc.guide* ./bin/
	cd src
	vasmm68k_mot -devpac -nocase -Fhunk -DMATRIX_STACK_SIZE=0 -DSOUND -DQ4_12_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./src/rc.o ./src/rc.s
	vlink -bamigahunk -o ./bin/rc -s -DMATRIX_STACK_SIZE=0 -DSOUND -DQ4_12_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  ./src/rc.o
	chmod 777 ./bin/rc

	vasmm68k_mot -devpac -nocase -Fhunk -DMATRIX_STACK_SIZE=0 -DCOLOR -DSOUND -DQ4_12_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./src/rc32.o ./src/rc.s
	vlink -bamigahunk -o ./bin/rc32 -s -DMATRIX_STACK_SIZE=0 -DCOLOR -DSOUND -DQ4_12_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  ./src/rc32.o
	chmod 777 ./bin/rc32

	vasmm68k_mot -devpac -nocase -Fhunk -DMATRIX_STACK_SIZE=0 -DINTRO -DCOLOR -DSOUND -DQ4_12_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./src/rc32phaze.o ./src/rc.s
	vlink -o ./bin/rc32phaze -s -DMATRIX_STACK_SIZE=0 -DCOLOR -DSOUND -DQ4_12_TABLE_LOOKUP -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  ./src/rc32phaze.o
	chmod 777 ./bin/rc32phaze

	vasmm68k_mot -devpac -nocase -Fhunk -DMATRIX_STACK_SIZE=0 -DQ4_12_TABLE_LOOKUP -DDEBUG -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  -o ./src/rc_debug.o ./src/rc.s
	vlink -bamigahunk -o ./bin/rc_debug -s -DMATRIX_STACK_SIZE=0 -DQ4_12_TABLE_LOOKUP -DDEBUG -DUSE_CLIPPING -DSQRT_BIG -DUSE_DBLBUF -DUSE_BPL_SECTION  ./src/rc_debug.o
	chmod 777 ./bin/rc_debug

adf:
	make all
	cp assets/extra/rc.guide* ./buildadf/
	$(eval $@_TMP := $(shell date +'%F_%T'))
	./Shrinkler bin/rc32 bin/rc32compressed
	cp bin/rc32compressed buildadf/rc32
	rm -f ./buildadf/*.data
	mv ./buildadf/tracks /tmp/
	exe2adf-linux64bit -d buildadf  -l rc -a ./adf/rc_$($@_TMP).adf
	mv /tmp/tracks ./buildadf/tracks
