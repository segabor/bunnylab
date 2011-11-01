/*
 * Code extracted from linux_simu
 */
#include "motor_simu.h"


int motorval[NBMOTOR];
int motorcount[NBMOTOR];
int motordir[NBMOTOR];

int motorwheel[256];


void motorsInit() {
	int i;
	
	for(i=0;i<NBMOTOR;i++)
	{
		motorval[i]=60;//(rand()&255)*MAXMOTORVAL/256;
		motorcount[i]=motordir[i]=0; 
	}
	for(i=0;i<256;i++) motorwheel[i]=0;
	for(i=0;i<MAXMOTORVAL;i++)
	{
		if ((i*2*NBHOLES/MAXMOTORVAL)&1) motorwheel[i]=1;
		if (i*NBHOLES/MAXMOTORVAL>=NBHOLES-MASKEDHOLES) motorwheel[i]=1;
	}
}




void motorsLoop() {
	int i;

	for(i=0;i<NBMOTOR;i++)
	{
		motorval[i]=60;//(rand()&255)*MAXMOTORVAL/256;
		motorcount[i]=motordir[i]=0; 
	}
	for(i=0;i<256;i++) motorwheel[i]=0;
	for(i=0;i<MAXMOTORVAL;i++)
	{
		if ((i*2*NBHOLES/MAXMOTORVAL)&1) motorwheel[i]=1;
		if (i*NBHOLES/MAXMOTORVAL>=NBHOLES-MASKEDHOLES) motorwheel[i]=1;
	}
}




// réglagle d'un moteur
void motorsSetDirection(int num_motor, int dir)
{
	int tmp_num, tmp_dir;
	tmp_num = num_motor?1:0;
	tmp_dir = (dir==0)?0:((dir==1)?1:-1);
	motordir[tmp_num]=tmp_dir;

	// my_printf(LOG_SIMUMOTORS, "Setting motor %d, direction %d (pos: %d)\n", tmp_num, tmp_dir);
}

int motorsGetValue(int i)
{
	int tmp_num = i?1:0;
	// my_printf(LOG_SIMUMOTORS, "Getting value for motor %d: %d\n", tmp_num, motorcount[tmp_num]);
	return motorcount[tmp_num];
}
