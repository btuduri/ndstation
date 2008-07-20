/*
NDStation v2.0 - flash GBA ROMs to a Slot 2 expansion pack
Copyright (C) 2008 Chaz Schlarp

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

#include <nds.h>
#include <stdio.h>
#include <fat.h>

#include "config.h"
#include "efs_lib.h"
#include "flash.h"
#include "graphics.h"
#include "sram.h"
#include "../../common/ipc.h"

int main(void)
{
	irqInit();
	irqEnable(IRQ_VBLANK);
	setupConsole();

  iprintf("Initializing FAT...\n");
  if(EFS_Init(EFS_AND_FAT | EFS_DEFAULT_DEVICE, NULL))
  {
    iprintf("FAT OK!\n");

    // Uncomment the following line to use true FAT instead of EFS
    // chdir("fat0:/");
    
    iprintf("Configuring...\n");
    configStruct cfg;
    populateConfig(&cfg);
    iprintf("Configuation OK!\n");
    iprintf("PSRAM: %i\n", cfg.psram);
    iprintf("NSAR: %i\n", cfg.compress);

    setupSplash(&cfg);

		sramBackup();
    sramWrite();

    if(cfg.psram)
      writeToPSRAM(&cfg);
    else
      writeToNOR(&cfg);

    setupBorder(&cfg);

    iprintf("Starting GBA mode...\n");
    sysSetBusOwners(BUS_OWNER_ARM7,BUS_OWNER_ARM7);
    IPC_ARM9 = IPC_GBA_BOOT;
  }
  else
  {
    iprintf("FAT error!\n");
  }

	while(1)
  {
		swiWaitForVBlank();
	}

	return 0;
}
