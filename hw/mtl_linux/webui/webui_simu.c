/**
** WEB UI implementation of Simu module
**/
/***

"_simuInit", referenced from:
"_simuDoLoop", referenced from:
"_simuSetLed", referenced from:
"_set_motor_dir", referenced from:
"_get_motor_val", referenced from:

"_getButton", referenced from:
"_get_button3", referenced from:
"_get_rfid", referenced from:

"_PlayStart", referenced from:
"_PlayEof", referenced from:
"_PlayStop", referenced from:
"_audioSetVolume", referenced from:
"_RecStart", referenced from:
"_RecStop", referenced from:

**/


/*
 * ---------- General functions ---------- 
 */


int simuInit() {
	return 0;
}



int simuDoLoop() {
	return 0;
}



/*
 * ---------- Ear motor functions ---------- 
 */


void simuSetMotor(int i, int val) {
	
}



void set_motor_dir(int num_motor, int sens) {
	
}


int get_motor_val(int i) {
	return 0;
}



/*
 * ---------- Buttons and LEDs ---------- 
 */


void simuSetLed(int i, int val)
{
	
}



// FIXME: what does it do?
int getButton() { return 0; }



// FIXME: ???
int get_button3() {
	return 0;
}


// char buf_rfid[256];
// FIXME
char* get_rfid()
{
	return 0;
}


/*
 * ---------- Audio functions ---------- 
 */
int PlayStart() {
	return 0;
}


int PlayStop() {
	return 0;
}


int PlayEof() {
	return 0;
}


int RecStart(int rate,int ChannelSize,int nbBuffers) {
	return 0;
}


int RecStop() {
	return 0;
}

void audioSetVolume(int vol) {
}

