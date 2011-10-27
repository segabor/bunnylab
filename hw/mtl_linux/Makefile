# Makefile pour le compilateur de mtl.
UNAME := $(shell uname)

# Linux specific sources and libs
ifeq ($(UNAME), Linux)
PLATF_SIMU_SRC=linux_simu.c linux_simuaudio.c linux_simunet.c
PLATF_SIMU_LIB=-ldl -pthread
DSTROOT="$(HOME)/.bunnylab"
endif

# OS X specific sources and libs
ifeq ($(UNAME), Darwin)
PLATF_SIMU_SRC=mac_simu.c mac_simuaudio.c linux_simunet.c
PLATF_SIMU_LIB=-lresolv
DSTROOT="$(HOME)/Library/bunnylab"
endif

DOCROOT=$(DSTROOT)/webroot

COMMON_OBJS=properties.o dumpbc.o log.o

COMP_OBJS=main_compiler.o

SIMU_SRC=main_simu.c $(PLATF_SIMU_SRC) vmem.c vloader.c vlog.c vinterp.c vaudio.c vnet.c webui/webui.c
SIMU_OBJS=$(SIMU_SRC:.c=.o)

MONGOOSE_SRC=mongoose/mongoose.c
MONGOOSE_OBJS=$(MONGOOSE_SRC:.c=.o)

CXXFLAGS=-DVSIMU -DWEBUI -DWEBROOT=$(DOCROOT) -g3 -m32 -Imongoose
CFLAGS=-DVSIMU -DWEBUI -DWEBROOT=$(DOCROOT) -g3 -m32 -Imongoose

CC=gcc
CXX=g++

all : mtl_simu mtl_comp

.PHONY : vcomp/libvcomp.a install

vcomp/libvcomp.a :
	$(MAKE) -C vcomp libvcomp.a

mtl_comp : vcomp/libvcomp.a $(COMMON_OBJS) $(COMP_OBJS)
	$(CXX) $(CXXFLAGS)  $^ -o $@ vcomp/libvcomp.a
#	g++  $^ -o $@ vcomp/*.o

mtl_simu : vcomp/libvcomp.a $(COMMON_OBJS) $(SIMU_OBJS) $(MONGOOSE_OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@ vcomp/libvcomp.a $(PLATF_SIMU_LIB)
#	g++  $^ -o $@ vcomp/*.o

# .c.o:	
# 	g++ -c $<

# .cpp.o:
# 	g++ -c -I/usr/include/wine/windows -I/usr/include/wine/msvcrt

%.o : %.c
	$(CC) $(CFLAGS) -c $^ -o $@

%.o : %.cpp
	$(CXX) $(CXXFLAGS) -c $^ -o $@

clean :
	$(MAKE) -C vcomp clean
	rm -f $(COMMON_OBJS) $(COMP_OBJS) $(SIMU_OBJS) $(MONGOOSE_OBJS)

install:
	test -d $(DSTROOT) || mkdir $(DSTROOT)
	test -d $(DSTROOT)/bin || mkdir $(DSTROOT)/bin
	install -m 0755 mtl_comp $(DSTROOT)/bin
	install -m 0755 mtl_simu $(DSTROOT)/bin
	rm -rf $(DOCROOT)
	mkdir $(DOCROOT)
	cp -r webui/lib $(DOCROOT)/lib

