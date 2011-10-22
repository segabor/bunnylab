# Makefile pour le compilateur de mtl.
UNAME := $(shell uname)

# Linux specific sources and libs
ifeq ($(UNAME), Linux)
PLATF_SIMU_SRC=linux_simu.c linux_simuaudio.c linux_simunet.c
PLATF_SIMU_LIB=
endif

# OS X specific sources and libs
ifeq ($(UNAME), Darwin)
PLATF_SIMU_SRC=mac_simu.c mac_simuaudio.c linux_simunet.c
PLATF_SIMU_LIB=-lresolv
endif

COMMON_OBJS=properties.o dumpbc.o log.o

COMP_OBJS=main_compiler.o

SIMU_SRC=main_simu.c $(PLATF_SIMU_SRC) vmem.c vloader.c vlog.c vinterp.c vaudio.c vnet.c
SIMU_OBJS=$(SIMU_SRC:.c=.o)

MONGOOSE_SRC=mongoose/mongoose.c
MONGOOSE_OBJS=$(MONGOOSE_SRC:.c=.o)

CXXFLAGS=-DVSIMU -DWEBUI -g3 -m32 -Imongoose
CFLAGS=-DVSIMU -DWEBUI -g3 -m32

CC=gcc
CXX=g++

all : mtl_simu mtl_comp

.PHONY : vcomp/libvcomp.a

vcomp/libvcomp.a :
	$(MAKE) -C vcomp libvcomp.a

mtl_comp : vcomp/libvcomp.a $(COMMON_OBJS) $(COMP_OBJS)
	$(CXX) $(CXXFLAGS)  $^ -o $@ vcomp/libvcomp.a
#	g++  $^ -o $@ vcomp/*.o

mtl_simu : vcomp/libvcomp.a $(COMMON_OBJS) $(SIMU_OBJS) $(MONGOOSE_OBJS)
	$(CXX) $(CXXFLAGS)  $^ -o $@ vcomp/libvcomp.a $(PLATF_SIMU_LIB)
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
