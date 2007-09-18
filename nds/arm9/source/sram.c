#include <nds.h>
#include <fat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "3in1.h"
#include "efs_lib.h"
#include "sram.h"

int sramBufferSize = 0x1000; //4096 bytes == one page

void writeSAV(void) {

	iprintf("Backing up save file to Slot 1.\n");
	
	char* saveLocation = calloc(1, 512);
	FILE* configFile;
	FILE* saveTest;
	
	configFile = fopen("/gba.cfg", "a");
	fclose(configFile);
	configFile = fopen("/gba.cfg", "r");
	fread(saveLocation, 512, 1, configFile);
	fclose(configFile);
	if((saveTest = fopen(saveLocation, "r"))){
		fclose(saveTest);
		writeSRAMToFile(saveLocation);
	}
	
	free(saveLocation);
	
}

void readSAV(void) {

	iprintf("Writing save file to 3-in-1.\n");

	char savename[256] = "\0";
	FILE* saveConfig;
	
	strncpy(savename, efs_path, strlen(efs_path) - 3);
	strcat(savename, "sav");
	writeFileToSRAM(savename);	
	saveConfig = fopen("/gba.cfg", "w");
	fwrite(savename, strlen(savename), 1, saveConfig);
	
	fclose(saveConfig);
	
}

void writeSRAMToFile(char* filename)
{

    u8 pages = 0;

    FILE* saver = fopen(filename, "rb+");

    u8* buf = (u8*)malloc(sramBufferSize);

    int i = 0; // the setup for which page to start dumping from if it is a prototype
    
	pages = TOT_SRAM_PAGES;

    OpenNorWrite();
    for (; i < pages; i ++)
    {
        memset(buf, 0, sramBufferSize);
        SetRampage(i);
        ReadSram(0x0A000000, buf, sramBufferSize);
        fwrite(buf, sramBufferSize, 1, saver);
    }

    free(buf);
    fclose(saver);
    SetRampage(0);

    CloseNorWrite();
}

void blankSRAM(u8 pages)
{
    if (pages > MAX_SRAM_PAGES) pages = MAX_SRAM_PAGES;
    u8* saveBuf;
    saveBuf = (u8*)malloc(sramBufferSize);

    OpenNorWrite();
	int i = 0;
    for (i = 0; i < pages; i ++)
    {
        memset(saveBuf, 0, sramBufferSize);
        SetRampage(i);
        WriteSram(0x0A000000, saveBuf, sramBufferSize);
    }

    free(saveBuf);
    SetRampage(0);
    CloseNorWrite();
}

void writeFileToSRAM(char* filename)
{

    FILE* saveFile = fopen(filename, "rb");
	
    u8* saveBuf;
    saveBuf = (u8*)malloc(sramBufferSize);

    blankSRAM((64+256)/4);

    int ret = 1;

	int i = 16;
    for (i = getStartpage(); i < MAX_SRAM_PAGES && ret == 1; i ++)
    {
        memset(saveBuf, 0, sramBufferSize);
        SetRampage(i);
        ret = fread(saveBuf, sramBufferSize, 1, saveFile);
        if (ret == 1) WriteSram(0x0A000000, (u8*)saveBuf, sramBufferSize);
    }

    fclose(saveFile);
    free(saveBuf);
    SetRampage(0);

}

int getStartpage(void)
{
    u8 data[8];
    char teststr[8] = "PROTOTY";
    char testret[8];
    ReadSram(0x0A000000, (u8*)data, 8); // backup whatever data is there
    WriteSram(0x0A000000, (u8*)teststr, 8); // write our test string

    SetRampage(0); // if it comes back now we have a prototype
    ReadSram(0x0A000000, (u8*)testret, 8);
    if (strcmp(teststr, testret) == 0)
    {
        WriteSram(0x0A000000, data, 8);
        return 0;
    }
    else
    {
        SetRampage(0x10); // if it comes back now we have a prototype
        ReadSram(0x0A000000, (u8*)testret, 8);
        if (strcmp(teststr, testret) == 0)
        {
            WriteSram(0x0A000000, (u8*)data, 8);
            return 16;
        }
    }
	
    return 0;
}
