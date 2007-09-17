#include <nds.h>
#include <stdio.h>
#include <fat.h>
#include <string.h>

#include "efs_lib.h"
#include "flash.h"
#include "sram.h"
#include "reboot.h"
#include "graphics.h"

int main(void) {

	irqInit();
	irqEnable(IRQ_VBLANK);
	
	scanKeys();
	if(keysDown() & KEY_START){

		videoSetMode(MODE_0_2D | DISPLAY_BG0_ACTIVE);
	    vramSetBankA(VRAM_A_MAIN_BG);
	    BG0_CR = BG_MAP_BASE(31);
	    BG_PALETTE[255] = RGB15(31,31,31);
	    consoleInitDefault((u16*)SCREEN_BASE_BLOCK(31), (u16*)CHAR_BASE_BLOCK(0), 16); 

	} else {

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
	
	if(PersonalData->_user_data.gbaScreen) lcdSwap();
	
    if(fatInitDefault()) {
        iprintf("Survived FAT init.\n");
        
        if(EFS_Init()) {
			
            iprintf("Survived EFS init.\n");
			
			writeSAV();

			readSAV();
			
			if(isPSRAM("/mode.txt")){
				if(isGZ("/mode.txt")){
					copyToCard("/game.gz", "/game.gz");
					uncompressToCard("/game.gz", "/game.gba");
					writeToPSRAM("/game.gba", FAT_size("/game.gba"), 1);
				} else {
					writeToPSRAM("/game.gba", EFS_size("/game.gba"), 0);
				}
			} else {
				if(isGZ("/mode.txt")){
					copyToCard("/game.gz", "/game.gz");
					uncompressToCard("/game.gz", "/game.gba");
					writeToNOR("/game.gba", FAT_size("/game.gba"), 1);
				} else {
					writeToNOR("/game.gba", EFS_size("/game.gba"), 0);
				}
			}
			
			iprintf("Write complete.\n");
			
			remove("/game.gz");
			remove("/game.gba");
			
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
