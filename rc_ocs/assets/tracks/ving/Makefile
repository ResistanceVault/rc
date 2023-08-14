IMAGE32COLORS = ving1
TRACKNAME = VING1
DESIRED_FILE_SIZE = 125916

SAIL_ON_HALF_PIXEL_PER_SECOND_VELOCITY = 32768
BRAKE_ON_HALF_PIXEL_PER_SECOND_VELOCITY = 16384

SAIL = 32768
BRAKE = 16384
HALF_PX_SEC= 16
ONE_PX_SEC= 32

define generate_cpu_point
	@printf "%04x%04x\n" $$(($1)) $$(($2)) | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
endef

define generate_cpu_point_extended
	@printf "%04x%04x\n" $$(($1)) $$(($2 + $3 + $4 * 256)) | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
endef

all:
	ilbm2raw -f ./images/$(IMAGE32COLORS).iff ./images/$(IMAGE32COLORS).raw -p ./images/$(IMAGE32COLORS).pal
	
	# add raw image data
	cp ./images/$(IMAGE32COLORS).raw ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add palette
	cat ./images/$(IMAGE32COLORS).pal >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add metadata
	cat ./metadata/$(IMAGE32COLORS).data >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# add starting positions
	@printf "%04x%04x%04x\n" 185 105 335 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	@printf "%04x%04x%04x\n" 187 113 335 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	@printf "%04x%04x%04x\n" 171 111 335 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	@printf "%04x%04x%04x\n" 172 120 335 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	@printf "%04x%04x%04x\n" 158 117 335 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	@printf "%04x%04x%04x\n" 158 127 335 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	@printf "%04x%04x%04x\n" 142 121 335 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK
	@printf "%04x%04x%04x\n" 143 131 335 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	#add CPU positions
	# Building Section 1
	$(call generate_cpu_point, 206, 100)
	$(call generate_cpu_point_extended, 210, 82, $(BRAKE),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 208, 70, $(SAIL),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 199, 58, $(SAIL),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 176, 67, $(SAIL),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 153, 74, $(SAIL),$(ONE_PX_SEC))

	# Building Section 2
	$(call generate_cpu_point, 118, 68)
	$(call generate_cpu_point, 77, 73)
	$(call generate_cpu_point_extended, 54, 67, $(BRAKE),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 43, 49, $(BRAKE),$(ONE_PX_SEC))


	# Building Section 3
	$(call generate_cpu_point_extended, 42, 33, $(SAIL),$(ONE_PX_SEC))
	$(call generate_cpu_point_extended, 52, 22, $(SAIL),$(ONE_PX_SEC))
	$(call generate_cpu_point_extended, 70, 19, $(SAIL),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 97, 26, $(SAIL),$(ONE_PX_SEC))
	$(call generate_cpu_point, 131, 29)
	
	# Building Section 4
	$(call generate_cpu_point_extended, 146, 29, $(SAIL),$(ONE_PX_SEC))
	$(call generate_cpu_point, 170, 20)
	$(call generate_cpu_point, 187, 20)
	$(call generate_cpu_point, 209, 19)
	$(call generate_cpu_point_extended, 223, 28, $(SAIL),$(HALF_PX_SEC))
	$(call generate_cpu_point, 247, 64)
	
	# Building Section 5
	$(call generate_cpu_point, 245, 83)
	$(call generate_cpu_point, 250, 107)
	$(call generate_cpu_point, 272, 122)
	$(call generate_cpu_point_extended, 290, 132, $(SAIL),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 298, 160, $(SAIL),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 290, 177, $(BRAKE),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 273, 180, $(BRAKE),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 257, 172, $(BRAKE),$(ONE_PX_SEC))
	$(call generate_cpu_point_extended, 247, 156, $(SAIL),$(ONE_PX_SEC))
	$(call generate_cpu_point_extended, 232, 149, $(SAIL),$(ONE_PX_SEC))
	$(call generate_cpu_point_extended, 217, 143, $(SAIL),$(HALF_PX_SEC))

	# Building Section 6
	$(call generate_cpu_point_extended, 202, 150, $(SAIL),$(HALF_PX_SEC))
	$(call generate_cpu_point, 203, 164)
	$(call generate_cpu_point, 205, 186)
	$(call generate_cpu_point, 190, 209)
	$(call generate_cpu_point_extended, 166, 219, $(SAIL),$(HALF_PX_SEC))
	$(call generate_cpu_point_extended, 147, 214, $(SAIL),$(ONE_PX_SEC))
	$(call generate_cpu_point_extended, 137, 204, $(SAIL),$(ONE_PX_SEC))

	# Building Section 7
	$(call generate_cpu_point_extended, 130, 186, $(BRAKE),$(ONE_PX_SEC))
	$(call generate_cpu_point, 102, 165)
	$(call generate_cpu_point, 80, 153)
	$(call generate_cpu_point, 81, 129)
	$(call generate_cpu_point_extended, 86, 113, $(SAIL),$(ONE_PX_SEC))
	$(call generate_cpu_point_extended, 101, 109, $(SAIL),$(ONE_PX_SEC))
	$(call generate_cpu_point, 120, 118)
	$(call generate_cpu_point, 154, 118)
	$(call generate_cpu_point_extended, 181, 110, $(SAIL),$(ONE_PX_SEC))

	# Padding
	@for number in `seq 1 202`; do \
        echo FF FF FF FF | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK ;\
    done

	# Setting number of zones of the track
	echo 00 07 | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	# Setting hotspot CPU distance
	echo 00 0c | xxd -r -p >> ../../../buildadf/tracks/$(TRACKNAME).TRK

	@if [ $$(stat -c %s ../../../buildadf/tracks/$(TRACKNAME).TRK) -ne $(DESIRED_FILE_SIZE) ]; then \
		echo "File $(TRACKNAME).TRK with faulty size"; \
		exit 1; \
	fi

	# Copying data into game
	cp ../../../buildadf/tracks/$(TRACKNAME).TRK ../../../bin/tracks/$(TRACKNAME).TRK
	chmod 777 ../../../bin/tracks/$(TRACKNAME).TRK
	cd ../../../bin/tracks && ../../Shrinkler --data $(TRACKNAME).TRK ../tracksshr/$(TRACKNAME).TRK && chmod 666 ../tracksshr/$(TRACKNAME).TRK
	cp -p ../../../bin/tracksshr/$(TRACKNAME).TRK ../../../buildadf/tracksshr/$(TRACKNAME).TRK
