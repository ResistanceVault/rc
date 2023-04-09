all:
	ilbm2raw -f ./Sfondo\ titoli\ Scuro\ RC.iff ./Sfondo\ titoli\ Scuro\ RC.raw -p ./Sfondo\ titoli\ Scuro\ RC.pal
	ilbm2raw -f ./Sfondo\ titoli\ Scuro.iff ./Sfondo\ titoli\ Scuro.raw -p ./Sfondo\ titoli\ Scuro.pal
	ilbm2raw -f ./Sfondo\ Titolo\ Chiaro.iff ./Sfondo\ Titolo\ Chiaro.raw -p ./Sfondo\ Titolo\ Chiaro.pal
	ilbm2raw -f ./Sfondo\ titolo\ Chiaro\ RC.iff ./Sfondo\ titolo\ Chiaro\ RC.raw -p ./Sfondo\ titolo\ Chiaro\ RC.pal

	cp ./Sfondo\ titoli\ Scuro\ RC.raw ../../bin/main.data
	cat ./Sfondo\ titoli\ Scuro\ RC.pal >> ../../bin/main.data

	cp ../../bin/main.data ../../buildadf/main.data