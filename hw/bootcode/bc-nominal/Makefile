PREPROC=cpp
PPFLAGS=-traditional-cpp -P

PREPROC2=bin/preproc_remove_extra_protos.pl

COMPILER=~/bin/mtl_comp

all: nominal simulator

nominal: src/main.mtl
	$(PREPROC) $(PPFLAGS) src/main.mtl | $(PREPROC2) > nominal.mtl
	$(COMPILER) -s nominal.mtl bc-nominal.bin

simulator: src/main.mtl
	$(PREPROC) $(PPFLAGS) -DSIMU src/main.mtl | $(PREPROC2) > simulator.mtl

clean: 
	rm -f nominal.mtl bc-nominal.bin simulator.mtl
