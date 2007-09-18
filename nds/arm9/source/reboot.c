#include <nds.h>
#include <stdio.h>

#include "../../common/ipc.h"

void bootGBA(void){
	iprintf("Starting execution.\n");
	sysSetBusOwners(BUS_OWNER_ARM7,BUS_OWNER_ARM7);
	IPC_ARM9=IPC_GBA_BOOT;
}
