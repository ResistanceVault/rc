FILENAME_MAIN := ./Sfondo\ titoli\ Scuro\ RC
FILENAME_START_RACE := Sfondo\ Titolo\ Chiaro
FILENAME_OPTIONS := Sfondo\ titolo\ Chiaro\ RC
FILENAME_0 := 0
FILENAME_1 := 1
FILENAME_2 := 2
FILENAME_3 := 3
FILENAME_4 := 4
FILENAME_5 := 5
FILENAME_6 := 6
FILENAME_7 := 7

all:
	ilbm2raw -f ./Sfondo\ titoli\ Scuro\ RC.iff ./Sfondo\ titoli\ Scuro\ RC.raw -p ./Sfondo\ titoli\ Scuro\ RC.pal
	ilbm2raw -f ./Sfondo\ titoli\ Scuro.iff ./Sfondo\ titoli\ Scuro.raw -p ./Sfondo\ titoli\ Scuro.pal
	ilbm2raw -f ./Sfondo\ Titolo\ Chiaro.iff ./Sfondo\ Titolo\ Chiaro.raw -p ./Sfondo\ Titolo\ Chiaro.pal
	ilbm2raw -f ./Sfondo\ titolo\ Chiaro\ RC.iff ./Sfondo\ titolo\ Chiaro\ RC.raw -p ./Sfondo\ titolo\ Chiaro\ RC.pal
	ilbm2raw -f testtitolo1.iff testtitolo1.raw -p testtitolo1.pal
	ilbm2raw -f ./Sfondo\ Titolo\ Chiaro.iff ./Sfondo\ Titolo\ Chiaro.raw -p ./Sfondo\ Titolo\ Chiaro.pal
	ilbm2raw -f ./Sfondo\ titolo\ Chiaro\ RC.iff ./Sfondo\ titolo\ Chiaro\ RC.raw -p ./Sfondo\ titolo\ Chiaro\ RC.pal

	@echo "Setting $(FILENAME_MAIN) for main.data"
	cp $(FILENAME_MAIN).raw ../../bin/main.data
	#dd if=/dev/zero bs=1 count=10240 >> ../../bin/main.data
	cat $(FILENAME_MAIN).pal >> ../../bin/main.data
	#dd if=/dev/zero bs=1 count=32 >> ../../bin/main.data
	chmod 666 ../../bin/main.data
	chown 1000:1000 ../../bin/main.data
	cp ../../bin/main.data ../../buildadf/main.data
	ln -sf ../../bin/main.data ./main.data
	../../Shrinkler --data main.data main.shr
	cp main.shr ../../bin/main.shr
	chmod +r ../../bin/main.shr
	cp main.shr ../../buildadf/main.shr
	chmod +r ../../buildadf/main.shr

	@echo "Setting $(FILENAME_OPTIONS) for options.data"
	cp $(FILENAME_OPTIONS).raw ../../bin/options.data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/options.data
	cat $(FILENAME_OPTIONS).pal >> ../../bin/options.data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/options.data
	chmod 666 ../../bin/options.data
	chown 1000:1000 ../../bin/options.data
	cp ../../bin/options.data ../../buildadf/options.data
	ln -sf ../../bin/options.data ./options.data
	../../Shrinkler --data options.data options.shr
	cp options.shr ../../bin/options.shr
	chmod +r ../../bin/options.shr
	cp options.shr ../../buildadf/options.shr
	chmod +r ../../buildadf/options.shr

	cp ./testtitolo1.raw ../../bin/raceresult.data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/raceresult.data
	cat ./testtitolo1.pal >> ../../bin/raceresult.data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/raceresult.data
	chmod 666 ../../bin/raceresult.data
	chown 1000:1000 ../../bin/raceresult.data
	cp ../../bin/raceresult.data ../../buildadf/raceresult.data
	ln -sf ../../bin/raceresult.data ./raceresult.data
	../../Shrinkler --data raceresult.data raceresult.shr
	cp raceresult.shr ../../bin/raceresult.shr
	chmod +r ../../bin/raceresult.shr
	cp raceresult.shr ../../buildadf/raceresult.shr
	chmod +x ../../buildadf/raceresult.shr

	cp ././Sfondo\ Titolo\ Chiaro.raw ../../bin/carsetup.data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/carsetup.data
	cat ././Sfondo\ Titolo\ Chiaro.pal >> ../../bin/carsetup.data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/carsetup.data
	chmod 666 ../../bin/carsetup.data
	chown 1000:1000 ../../bin/carsetup.data
	cp ../../bin/carsetup.data ../../buildadf/carsetup.data
	ln -sf ../../bin/carsetup.data ./carsetup.data
	../../Shrinkler --data carsetup.data carsetup.shr
	cp carsetup.shr ../../bin/carsetup.shr
	chmod +r ../../bin/carsetup.shr
	cp carsetup.shr ../../buildadf/carsetup.shr
	chmod +r ../../buildadf/carsetup.shr

	cp $(FILENAME_START_RACE).raw ../../bin/carstartrace.data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/carstartrace.data
	cat $(FILENAME_START_RACE).pal >> ../../bin/carstartrace.data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/carstartrace.data
	chmod 666 ../../bin/carstartrace.data
	chown 1000:1000 ../../bin/carstartrace.data
	cp ../../bin/carstartrace.data ../../buildadf/carstartrace.data
	ln -sf ../../bin/carstartrace.data ./carstartrace.data
	../../Shrinkler --data carstartrace.data carstartrace.shr
	cp carstartrace.shr ../../bin/carstartrace.shr
	chmod +r ../../bin/carstartrace.shr
	cp carstartrace.shr ../../buildadf/carstartrace.shr
	chmod +r ../../buildadf/carstartrace.shr

	ilbm2raw -f arnoux.iff $(FILENAME_0).raw -p $(FILENAME_0).pal
	cp $(FILENAME_0).raw ../../bin/$(FILENAME_0).data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/$(FILENAME_0).data
	cat $(FILENAME_0).pal >> ../../bin/$(FILENAME_0).data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/$(FILENAME_0).data
	chmod 666 ../../bin/$(FILENAME_0).data
	chown 1000:1000 ../../bin/$(FILENAME_0).data
	cp ../../bin/$(FILENAME_0).data ../../buildadf/$(FILENAME_0).data
	ln -sf ../../bin/$(FILENAME_0).data ./$(FILENAME_0).data
	../../Shrinkler --data $(FILENAME_0).data $(FILENAME_0).shr
	chmod 777 $(FILENAME_0).shr
	cp $(FILENAME_0).shr ../../bin/$(FILENAME_0).shr
	chmod +r ../../bin/$(FILENAME_0).shr
	cp $(FILENAME_0).shr ../../buildadf/$(FILENAME_0).shr
	chmod +r ../../buildadf/$(FILENAME_0).shr

	ilbm2raw -f prost.iff $(FILENAME_1).raw -p $(FILENAME_1).pal
	cp $(FILENAME_1).raw ../../bin/$(FILENAME_1).data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/$(FILENAME_1).data
	cat $(FILENAME_1).pal >> ../../bin/$(FILENAME_1).data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/$(FILENAME_1).data
	chmod 666 ../../bin/$(FILENAME_1).data
	chown 1000:1000 ../../bin/$(FILENAME_1).data
	cp ../../bin/$(FILENAME_1).data ../../buildadf/$(FILENAME_1).data
	ln -sf ../../bin/$(FILENAME_1).data ./$(FILENAME_1).data
	../../Shrinkler --data $(FILENAME_1).data $(FILENAME_1).shr
	chmod 777 $(FILENAME_1).shr
	cp $(FILENAME_1).shr ../../bin/$(FILENAME_1).shr
	chmod +r ../../bin/$(FILENAME_1).shr
	cp $(FILENAME_1).shr ../../buildadf/$(FILENAME_1).shr
	chmod +r ../../buildadf/$(FILENAME_1).shr

	ilbm2raw -f tambay.iff $(FILENAME_2).raw -p $(FILENAME_2).pal
	cp $(FILENAME_2).raw ../../bin/$(FILENAME_2).data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/$(FILENAME_2).data
	cat $(FILENAME_2).pal >> ../../bin/$(FILENAME_2).data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/$(FILENAME_2).data
	chmod 666 ../../bin/$(FILENAME_2).data
	chown 1000:1000 ../../bin/$(FILENAME_2).data
	cp ../../bin/$(FILENAME_2).data ../../buildadf/$(FILENAME_2).data
	ln -sf ../../bin/$(FILENAME_2).data ./$(FILENAME_2).data
	../../Shrinkler --data $(FILENAME_2).data $(FILENAME_2).shr
	chmod 777 $(FILENAME_2).shr
	cp $(FILENAME_2).shr ../../bin/$(FILENAME_2).shr
	chmod +r ../../bin/$(FILENAME_2).shr
	cp $(FILENAME_2).shr ../../buildadf/$(FILENAME_2).shr
	chmod +r ../../buildadf/$(FILENAME_2).shr

	ilbm2raw -f patrese.iff $(FILENAME_3).raw -p $(FILENAME_3).pal
	cp $(FILENAME_3).raw ../../bin/$(FILENAME_3).data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/$(FILENAME_3).data
	cat $(FILENAME_3).pal >> ../../bin/$(FILENAME_3).data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/$(FILENAME_3).data
	chmod 666 ../../bin/$(FILENAME_3).data
	chown 1000:1000 ../../bin/$(FILENAME_3).data
	cp ../../bin/$(FILENAME_3).data ../../buildadf/$(FILENAME_3).data
	ln -sf ../../bin/$(FILENAME_3).data ./$(FILENAME_3).data
	../../Shrinkler --data $(FILENAME_3).data $(FILENAME_3).shr
	chmod 777 $(FILENAME_3).shr
	cp $(FILENAME_3).shr ../../bin/$(FILENAME_3).shr
	chmod +r ../../bin/$(FILENAME_3).shr
	cp $(FILENAME_3).shr ../../buildadf/$(FILENAME_3).shr
	chmod +r ../../buildadf/$(FILENAME_3).shr

	ilbm2raw -f alboreto.iff $(FILENAME_4).raw -p $(FILENAME_4).pal
	cp $(FILENAME_4).raw ../../bin/$(FILENAME_4).data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/$(FILENAME_4).data
	cat $(FILENAME_4).pal >> ../../bin/$(FILENAME_4).data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/$(FILENAME_4).data
	chmod 666 ../../bin/$(FILENAME_4).data
	chown 1000:1000 ../../bin/$(FILENAME_4).data
	cp ../../bin/$(FILENAME_4).data ../../buildadf/$(FILENAME_4).data
	ln -sf ../../bin/$(FILENAME_4).data ./$(FILENAME_4).data
	../../Shrinkler --data $(FILENAME_4).data $(FILENAME_4).shr
	chmod 777 $(FILENAME_4).shr
	cp $(FILENAME_4).shr ../../bin/$(FILENAME_4).shr
	chmod +r ../../bin/$(FILENAME_4).shr
	cp $(FILENAME_4).shr ../../buildadf/$(FILENAME_4).shr
	chmod +r ../../buildadf/$(FILENAME_4).shr

	ilbm2raw -f lauda.iff $(FILENAME_5).raw -p $(FILENAME_5).pal
	cp $(FILENAME_5).raw ../../bin/$(FILENAME_5).data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/$(FILENAME_5).data
	cat $(FILENAME_5).pal >> ../../bin/$(FILENAME_5).data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/$(FILENAME_5).data
	chmod 666 ../../bin/$(FILENAME_5).data
	chown 1000:1000 ../../bin/$(FILENAME_5).data
	cp ../../bin/$(FILENAME_5).data ../../buildadf/$(FILENAME_5).data
	ln -sf ../../bin/$(FILENAME_5).data ./$(FILENAME_5).data
	../../Shrinkler --data $(FILENAME_5).data $(FILENAME_5).shr
	chmod 777 $(FILENAME_5).shr
	cp $(FILENAME_5).shr ../../bin/$(FILENAME_5).shr
	chmod +r ../../bin/$(FILENAME_5).shr
	cp $(FILENAME_5).shr ../../buildadf/$(FILENAME_5).shr
	chmod +r ../../buildadf/$(FILENAME_5).shr

	ilbm2raw -f fittipaldo.iff $(FILENAME_6).raw -p $(FILENAME_6).pal
	cp $(FILENAME_6).raw ../../bin/$(FILENAME_6).data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/$(FILENAME_6).data
	cat $(FILENAME_6).pal >> ../../bin/$(FILENAME_6).data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/$(FILENAME_6).data
	chmod 666 ../../bin/$(FILENAME_6).data
	chown 1000:1000 ../../bin/$(FILENAME_6).data
	cp ../../bin/$(FILENAME_6).data ../../buildadf/$(FILENAME_6).data
	ln -sf ../../bin/$(FILENAME_6).data ./$(FILENAME_6).data
	../../Shrinkler --data $(FILENAME_6).data $(FILENAME_6).shr
	chmod 777 $(FILENAME_6).shr
	cp $(FILENAME_6).shr ../../bin/$(FILENAME_6).shr
	chmod +r ../../bin/$(FILENAME_6).shr
	cp $(FILENAME_6).shr ../../buildadf/$(FILENAME_6).shr
	chmod +r ../../buildadf/$(FILENAME_6).shr

	ilbm2raw -f letho.iff $(FILENAME_7).raw -p $(FILENAME_7).pal
	cp $(FILENAME_7).raw ../../bin/$(FILENAME_7).data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/$(FILENAME_7).data
	cat $(FILENAME_7).pal >> ../../bin/$(FILENAME_7).data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/$(FILENAME_7).data
	chmod 666 ../../bin/$(FILENAME_7).data
	chown 1000:1000 ../../bin/$(FILENAME_7).data
	cp ../../bin/$(FILENAME_7).data ../../buildadf/$(FILENAME_7).data
	ln -sf ../../bin/$(FILENAME_7).data ./$(FILENAME_7).data
	../../Shrinkler --data $(FILENAME_7).data $(FILENAME_7).shr
	chmod 777 $(FILENAME_7).shr
	cp $(FILENAME_7).shr ../../bin/$(FILENAME_7).shr
	chmod +r ../../bin/$(FILENAME_7).shr
	cp $(FILENAME_7).shr ../../buildadf/$(FILENAME_7).shr
	chmod +r ../../buildadf/$(FILENAME_7).shr
