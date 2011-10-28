This folder is intended to be the place of files needed to run bootcode in simulator.

Brief steps:

1. Build mtl_linux project
     make
     make install

2. Build bootcode
     make

3. Copy simulator.mtl from bootcode folder here
4. Adjust conf.bin for the preferred network environment
5. Create config.txt, add lines below

SOURCE simulator.mtl
MAC 001122334455

6. No step six. You're ready to run simulator!

On Linux:

~/.bunnylab/bin/mtl_simu

On Mac:

~/Library/bunnylab/mtl_simu

PS.: don't forget to start RabbitSociety app and a Jabber server.


