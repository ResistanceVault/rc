all:
	ilbm2raw -f ./Sfondo\ titoli\ Scuro\ RC.iff ./Sfondo\ titoli\ Scuro\ RC.raw -p ./Sfondo\ titoli\ Scuro\ RC.pal
	ilbm2raw -f ./Sfondo\ titoli\ Scuro.iff ./Sfondo\ titoli\ Scuro.raw -p ./Sfondo\ titoli\ Scuro.pal
	ilbm2raw -f ./Sfondo\ Titolo\ Chiaro.iff ./Sfondo\ Titolo\ Chiaro.raw -p ./Sfondo\ Titolo\ Chiaro.pal
	ilbm2raw -f ./Sfondo\ titolo\ Chiaro\ RC.iff ./Sfondo\ titolo\ Chiaro\ RC.raw -p ./Sfondo\ titolo\ Chiaro\ RC.pal

	cp ./Sfondo\ titoli\ Scuro\ RC.raw ../../bin/main.data
	cat ./Sfondo\ titoli\ Scuro\ RC.pal >> ../../bin/main.data
	chmod 666 ../../bin/main.data
	chown 1000:1000 ../../bin/main.data
	cp ../../bin/main.data ../../buildadf/main.data
	ln -sf ../../bin/main.data ./main.data
	../../Shrinkler --data main.data main.shr
	cp main.shr ../../bin/main.shr
	chmod +r ../../bin/main.shr
	cp main.shr ../../buildadf/main.shr
	chmod +r ../../buildadf/main.shr

	cp ./Sfondo\ titoli\ Scuro.raw ../../bin/options.data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/options.data
	cat ./Sfondo\ titoli\ Scuro.pal >> ../../bin/options.data
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

	ilbm2raw -f testtitolo1.iff testtitolo1.raw -p testtitolo1.pal
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

	ilbm2raw -f ./Sfondo\ Titolo\ Chiaro.iff ./Sfondo\ Titolo\ Chiaro.raw -p ./Sfondo\ Titolo\ Chiaro.pal
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

	ilbm2raw -f ./Sfondo\ titolo\ Chiaro\ RC.iff ./Sfondo\ titolo\ Chiaro\ RC.raw -p ./Sfondo\ titolo\ Chiaro\ RC.pal
	cp ././Sfondo\ titolo\ Chiaro\ RC.raw ../../bin/carstartrace.data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/carstartrace.data
	cat ././Sfondo\ titolo\ Chiaro\ RC.pal >> ../../bin/carstartrace.data
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
