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
#include <fat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "3in1.h"
#include "efs_lib.h"
#include "sram.h"

int sramBufferSize = 0x1000; //4096 bytes == one page

void sramBackup(void)
{
	iprintf("Reading save to Slot 1...\n");

	char* saveLocation = calloc(1, 512);
	FILE* locationFile;
	FILE* saveFile;
  u8* buf = (u8*)malloc(sramBufferSize);
  int i = 0;

  mkdir("fat0:/data/", 0);
	locationFile = fopen("fat0:/data/ndstation.sav", "a+");
	rewind(locationFile);
	fread(saveLocation, 512, 1, locationFile);
	fclose(locationFile);
  saveFile = fopen(saveLocation, "rb+");

  OpenNorWrite();
  for (i = 0; i < TOT_SRAM_PAGES; i++)
  {
    memset(buf, 0, sramBufferSize);
    SetRampage(i);
    ReadSram(0x0A000000, buf, sramBufferSize);
    fwrite(buf, sramBufferSize, 1, saveFile);
  }

  free(buf);
  fclose(saveFile);
  SetRampage(0);
  CloseNorWrite();
  
	free(saveLocation);
}

void sramWrite(void)
{
	iprintf("Writing save to SRAM...\n");

  char* saveLocation = calloc(1, 512);
	FILE* locationFile;
  FILE* saveFile;
	u8* saveBuf = (u8*)malloc(sramBufferSize);
  int ret = 1;
	int i = 16;

	strncpy(saveLocation, efs_path, strlen(efs_path) - 3);
	strcat(saveLocation, "sav");
  iprintf("Save file: %s\n", saveLocation);

  saveFile = fopen(saveLocation, "rb");

  iprintf("Erasing SRAM...\n");
	blankSRAM((64+256)/4);
  iprintf("Erasing OK!\n");

  iprintf("Copying...\n");
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
  iprintf("Save written OK!\n");

	locationFile = fopen("fat0:/data/ndstation.sav", "w");
	fwrite(saveLocation, strlen(saveLocation), 1, locationFile);
	fclose(locationFile);
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
