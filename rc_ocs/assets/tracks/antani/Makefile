IMAGE32COLORS = antani
TRACKNAME = ANTANI
DESIRED_FILE_SIZE = 125916

all:
	ilbm2raw -f ./images/$(IMAGE32COLORS).iff ./images/$(IMAGE32COLORS).raw -p ./images/$(IMAGE32COLORS).pal -s 17,31 -s 18,28

	# dd if=/dev/zero of=./images/$(IMAGE32COLORS).raw bs=1 count=1 seek=47999
	
    # pad palette color for team 1
	#echo 00 00 00 00 09 21 00 00 | xxd -r -p >> ./images/$(IMAGE32COLORS).pal
	# pad palette color for team 2
	#echo 00 00 00 00 02 5b 00 00 | xxd -r -p >> ./images/$(IMAGE32COLORS).pal
	# pad palette color for team 3
	# echo 00 00 00 00 0d d4 00 00 | xxd -r -p >> ./images/$(IMAGE32COLORS).pal
	# pad palette color for team 4
	# echo 00 00 00 00 04 a4 00 00 | xxd -r -p >> ./images/$(IMAGE32COLORS).pal

	# add raw image data
	cp ./images/$(IMAGE32COLORS).raw ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add palette
	cat ./images/$(IMAGE32COLORS).pal >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add metadata
	cat ./metadata/$(IMAGE32COLORS).data >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add starting positions (X Y and degrees of the car)
	printf "%04x%04x%04x\n" 160 210 180 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 165 220 180 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 170 210 180 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 175 220 180 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 180 210 180 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 185 220 180 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 190 210 180 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 195 220 180 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	#add CPU positions
	# Section 1
	# Section 2
	# Section 3
	# Section 4
	# Section 5
	# Section 6
	# Section 7

	# Padding CPU positions
	for number in `seq 1 250`; do \
        echo FF FF FF FF | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK ;\
    done

	# number of zones of the track
	echo 00 0c | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# hotspot CPU distance
	echo 00 14 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	@if [ $$(stat -c %s ../../../buildadf/tracks/$(TRACKNAME).TRK) -ne $(DESIRED_FILE_SIZE) ]; then \
		echo "File $(TRACKNAME).TRK with faulty size"; \
		exit 1; \
	fi

    # Copy and compress to output dir

	cp ../../../buildadf/tracks/$(TRACKNAME).TRK ../../../bin/tracks/$(TRACKNAME).TRK
	chmod 777 ../../../bin/tracks/$(TRACKNAME).TRK
	cd ../../../bin/tracks && ../../Shrinkler --data $(TRACKNAME).TRK ../tracksshr/$(TRACKNAME).TRK && chmod 666 ../tracksshr/$(TRACKNAME).TRK
	cp -p ../../../bin/tracksshr/$(TRACKNAME).TRK ../../../buildadf/tracksshr/$(TRACKNAME).TRK