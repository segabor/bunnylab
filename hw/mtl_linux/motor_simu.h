
#ifndef __MOTOR_SIMU_H__
#define __MOTOR_SIMU_H__

/* Number of motors */
#define NBMOTOR 2


#define NBHOLES 20
#define MASKEDHOLES 3
// MAXMOTORVAL must be less than 256
#define MAXMOTORVAL 100


void motorsInit();
void motorsLoop();

void motorsSetDirection(int num_motor, int dir);
int motorsGetValue(int i);

#endif
