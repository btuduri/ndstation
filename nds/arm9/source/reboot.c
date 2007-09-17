#include <nds.h>
#include <stdio.h>
#include <malloc.h>
#include <fat.h>

#include "../../common/ipc.h"
#include "efs_lib.h"
#include "string.h"
		
void bootGBA(void){
	iprintf("Starting execution.\n");
	sysSetBusOwners(BUS_OWNER_ARM7,BUS_OWNER_ARM7);
	IPC_ARM9=IPC_GBA_BOOT;
}
