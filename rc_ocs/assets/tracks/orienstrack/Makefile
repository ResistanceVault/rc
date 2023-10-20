IMAGE32COLORS = OriensTrack1d_32c
TRACKNAME = ORIENS
DESIRED_FILE_SIZE = 125916

all:
	ilbm2raw -f ./images/$(IMAGE32COLORS).iff ./images/$(IMAGE32COLORS).raw -p ./images/$(IMAGE32COLORS).pal
	dd if=/dev/zero of=./images/$(IMAGE32COLORS).raw bs=1 count=1 seek=47999

	# add raw image data
	cp ./images/$(IMAGE32COLORS).raw ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add palette
	cat ./images/$(IMAGE32COLORS).pal >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add metadata
	cat ./metadata/$(IMAGE32COLORS).data >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add starting positions
	printf "%04x%04x%04x\n" 208 43 200 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 227 33 200 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 233 54 200 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 251 45 200 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 253 70 200 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 277 64 200 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 268 86 200 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	printf "%04x%04x%04x\n" 293 88 200 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	#add CPU positions
	../build_trajectory.sh ./metadata/trajectory.xml | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	@DIMENSIONE_FILE=$$(stat -c %s ../../../buildadf/tracks/$(TRACKNAME).TRK);\
		DIFF=$$(expr $(DESIRED_FILE_SIZE) - $$DIMENSIONE_FILE - 4); \
		printf '\377%.0s' $$(seq 1 $$DIFF) | dd of=../../../buildadf/tracks/$(TRACKNAME).TRK bs=1 seek=$$DIMENSIONE_FILE conv=notrunc;

	# number of zones of the track
	echo 00 07 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# hotspot CPU distance
	echo 00 12 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	@if [ $$(stat -c %s ../../../buildadf/tracks/$(TRACKNAME).TRK) -ne $(DESIRED_FILE_SIZE) ]; then \
		echo "File $(TRACKNAME).TRK with faulty size"; \
		exit 1; \
	fi

	cp ../../../buildadf/tracks/$(TRACKNAME).TRK ../../../bin/tracks/$(TRACKNAME).TRK
	chmod 777 ../../../bin/tracks/$(TRACKNAME).TRK
	cd ../../../bin/tracks && ../../Shrinkler --data $(TRACKNAME).TRK ../tracksshr/$(TRACKNAME).TRK && chmod 666 ../tracksshr/$(TRACKNAME).TRK
	cp -p ../../../bin/tracksshr/$(TRACKNAME).TRK ../../../buildadf/tracksshr/$(TRACKNAME).TRK

