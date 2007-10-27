/*
NDStation v1.3 - flash GBA ROMs to a Slot 2 expansion pack
Copyright (C) 2007 Chaz Schlarp

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

#include "efs_lib.h"
#include "flash.h"
#include "graphics.h"
#include "reboot.h"
#include "sram.h"

int main(void) {

	irqInit();
	irqEnable(IRQ_VBLANK);
	
	scanKeys();
	if(keysDown() & KEY_R){
		// if the R button is depressed, we enter console mode
		videoSetMode(MODE_0_2D | DISPLAY_BG0_ACTIVE);
		vramSetBankA(VRAM_A_MAIN_BG);
		BG0_CR = BG_MAP_BASE(31);
		BG_PALETTE[255] = RGB15(31,31,31);
		consoleInitDefault((u16*)SCREEN_BASE_BLOCK(31), (u16*)CHAR_BASE_BLOCK(0), 16); 
	} else {
		// set up the VRAM to load in a splash/loading screen
		videoSetMode(MODE_5_2D | DISPLAY_BG3_ACTIVE);
		videoSetModeSub(MODE_0_2D | DISPLAY_BG0_ACTIVE);
		vramSetMainBanks(VRAM_A_MAIN_BG_0x06000000, VRAM_B_LCD,	VRAM_C_SUB_BG , VRAM_D_LCD);
		BG3_CR = BG_BMP16_256x256;
		BG3_XDX = 1 << 8;
		BG3_XDY = 0;
		BG3_YDX = 0;
		BG3_YDY = 1 << 8;
		BG3_CX = 0;
		BG3_CY = 0;
		loadSplash();
	}

	// lazy way to handle the firmware's GBA screen setting
	if(PersonalData->_user_data.gbaScreen) lcdSwap();

	if(fatInitDefault()) {
		iprintf("Survived FAT init.\n");

		if(EFS_Init()) {

			iprintf("Survived EFS init.\n");

			// backup save to Slot 1
			writeSAV();

			// write save to 3in1
			readSAV();

			if(isPSRAM("/mode.txt")){
				// using PSRAM...
				if(isGZ("/mode.txt")){
					copyToCard("/game.gz", "/game.gz");
					uncompressToCard("/game.gz", "/game.gba");
					writeToPSRAM("/game.gba", FAT_size("/game.gba"), 1);
				} else {
					writeToPSRAM("/game.gba", EFS_size("/game.gba"), 0);
				}
			} else {
				// using NOR...
				if(isGZ("/mode.txt")){
					copyToCard("/game.gz", "/game.gz");
					uncompressToCard("/game.gz", "/game.gba");
					writeToNOR("/game.gba", FAT_size("/game.gba"), 1);
				} else {
					writeToNOR("/game.gba", EFS_size("/game.gba"), 0);
				}
			}

			iprintf("Write complete.\n");

			// clean up from compressed mode
			remove("/game.gz");
			remove("/game.gba");

			// load the border and reset to GBA mode
			loadBorder();
			bootGBA();

		} else {
			iprintf("Error in EFS init!\n");
		}
	} else {
		iprintf("Error in FAT init!\n");
	}

	while(1) {
		swiWaitForVBlank();
	}

	return 0;
}
