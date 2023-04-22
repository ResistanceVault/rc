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

	ilbm2raw -f testtitolo1.iff testtitolo1.raw -p testtitolo1.pal
	cp ./testtitolo1.raw ../../bin/raceresult.data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/raceresult.data
	cat ./testtitolo1.pal >> ../../bin/raceresult.data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/raceresult.data
	chmod 666 ../../bin/raceresult.data
	chown 1000:1000 ../../bin/raceresult.data
	cp ../../bin/raceresult.data ../../buildadf/raceresult.data

	ilbm2raw -f ./Sfondo\ Titolo\ Chiaro.iff ./Sfondo\ Titolo\ Chiaro.raw -p ./Sfondo\ Titolo\ Chiaro.pal
	cp ././Sfondo\ Titolo\ Chiaro.raw ../../bin/carsetup.data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/carsetup.data
	cat ././Sfondo\ Titolo\ Chiaro.pal >> ../../bin/carsetup.data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/carsetup.data
	chmod 666 ../../bin/carsetup.data
	chown 1000:1000 ../../bin/carsetup.data
	cp ../../bin/carsetup.data ../../buildadf/carsetup.data

	ilbm2raw -f ./Sfondo\ titolo\ Chiaro\ RC.iff ./Sfondo\ titolo\ Chiaro\ RC.raw -p ./Sfondo\ titolo\ Chiaro\ RC.pal
	cp ././Sfondo\ titolo\ Chiaro\ RC.raw ../../bin/carstartrace.data
	dd if=/dev/zero bs=1 count=10240 >> ../../bin/carstartrace.data
	cat ././Sfondo\ titolo\ Chiaro\ RC.pal >> ../../bin/carstartrace.data
	dd if=/dev/zero bs=1 count=32 >> ../../bin/carstartrace.data
	chmod 666 ../../bin/carstartrace.data
	chown 1000:1000 ../../bin/carstartrace.data
	cp ../../bin/carstartrace.data ../../buildadf/carstartrace.data
