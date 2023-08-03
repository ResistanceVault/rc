IMAGE32COLORS = Easy1semi3
TRACKNAME = EASY
all:
	ilbm2raw -f ./images/$(IMAGE32COLORS).iff ./images/$(IMAGE32COLORS).raw -p ./images/$(IMAGE32COLORS).pal
	dd if=/dev/zero of=./images/$(IMAGE32COLORS).raw bs=1 count=1 seek=47999
	
	# pad palette color for team 1
	echo 00 00 00 00 09 21 00 00 | xxd -r -p >> ./images/$(IMAGE32COLORS).pal

	# pad palette color for team 2
	echo 00 00 00 00 02 5b 00 00 | xxd -r -p >> ./images/$(IMAGE32COLORS).pal

	# pad palette color for team 3
	echo 00 00 00 00 0d d4 00 00 | xxd -r -p >> ./images/$(IMAGE32COLORS).pal

	# pad palette color for team 4
	echo 00 00 00 00 04 a4 00 00 | xxd -r -p >> ./images/$(IMAGE32COLORS).pal


	# add raw image data
	cp ./images/$(IMAGE32COLORS).raw ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add palette
	cat ./images/$(IMAGE32COLORS).pal >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add metadata
	cat ./metadata/$(IMAGE32COLORS).data >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add starting positions
	printf "%04x%04x%04x\n" 140 200 0 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 130 210 0 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 120 200 0 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 110 210 0 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 100 200 0 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 90 210 0 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 80 200 0 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 70 210 0 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	#add CPU positions
	for number in `seq 1 250`; do \
        echo FF FF FF FF | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK ;\
    done


	# number of zones of the track
	echo 00 07 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	cp ../../../buildadf/tracks/$(TRACKNAME).TRK ../../../bin/tracks/$(TRACKNAME).TRK
	chmod 777 ../../../bin/tracks/$(TRACKNAME).TRK
	cd ../../../bin/tracks && ../../Shrinkler --data $(TRACKNAME).TRK ../tracksshr/$(TRACKNAME).TRK && chmod 666 ../tracksshr/$(TRACKNAME).TRK
	cp -p ../../../bin/tracksshr/$(TRACKNAME).TRK ../../../buildadf/tracksshr/$(TRACKNAME).TRK

