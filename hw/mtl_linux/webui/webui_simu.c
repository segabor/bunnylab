/**
** WEB UI implementation of Simu module
**/

#include <stdio.h>

#include "motor_simu.h"

// linux_simunet.c
extern void checkAllEvents(void);
extern int checkNetworkEvents(void);



/*
 * ---------- General functions ---------- 
 */


int simuInit() {
	fprintf(stderr, "simuInit()\n");

	// function defined in linux_simunet.c
	simunetinit();

	motorsInit();

	return 0;
}



int simuDoLoop() {
	// always called
	// fprintf(stderr, "simuDoLoop()\n");
	
	// function defined in linux_simunet.c
	checkNetworkEvents();

	motorsLoop();

	return 0;
}



/*
 * ---------- Ear motor functions ---------- 
 */



void set_motor_dir(int num_motor, int sens) {
	// fprintf(stderr, "set_motor_dir(%d, %d)\n", num_motor, sens);
	motorsSetDirection(num_motor, sens);
}


int get_motor_val(int i) {
	int v = motorsGetValue(i);
	// fprintf(stderr, "get_motor_val(%d) => %d\n",i, v);
	return v;
}



/*
 * ---------- Buttons and LEDs ---------- 
 */


void simuSetLed(int i, int val) {
	fprintf(stderr, "simuSetLed(%d, %d)\n", i, val);
	
}



// FIXME: what does it do?
int getButton() {
	// always called
	// fprintf(stderr, "getButton()\n");
	return 0;
}



// FIXME: ???
int get_button3() {
	// always called
	// fprintf(stderr, "get_button3()\n");
	return 0;
}


// char buf_rfid[256];
// FIXME
char* get_rfid() {
	fprintf(stderr, "get_rfid()\n");
	return 0;
}


/*
 * ---------- Audio functions ---------- 
 */
int PlayStart() {
	fprintf(stderr, "PlayStart()\n");
	return 0;
}


int PlayStop() {
	fprintf(stderr, "PlayStop()\n");
	return 0;
}


int PlayEof() {
	fprintf(stderr, "PlayEof()\n");
	return 0;
}


int RecStart(int rate,int ChannelSize,int nbBuffers) {
	fprintf(stderr, "RecStart(%d, %d, %d)\n", rate, ChannelSize, nbBuffers);
	return 0;
}


int RecStop() {
	fprintf(stderr, "RecStop()\n");
	return 0;
}


void audioSetVolume(int vol) {
	fprintf(stderr, "audioSetVolume(%d)\n", vol);
}

