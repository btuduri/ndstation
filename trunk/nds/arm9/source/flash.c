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
#include <stdlib.h>
#include <string.h>
#include <fat.h>

#include "3in1.h"
#include "efs_lib.h"
#include "flash.h"
#include "sram.h"
#include "config.h"

int filesize(char* file)
{
  FILE* fp = fopen(file, "rb");
	fseek(fp, 0, SEEK_END);
	long size = ftell(fp);
	fclose(fp);
  return size;
}

void writeToNOR(configStruct* cfg)
{
  scanKeys();
  
	if(!(checkNOR(cfg) && !(keysDown() & KEY_A)))
  {
    iprintf("Erasing NOR...\n");
    OpenNorWrite();
    SetSerialMode();
		u32 kk = 0;
		for(kk=0; kk <= cfg->filesize && kk < MAX_NOR; kk+=0x40000)
			Block_Erase(kk);
    CloseNorWrite();
    iprintf("Erase OK!...\n");

    
    
		OpenNorWrite();
		SetSerialMode();
    
    FILE* gbaFile = fopen(cfg->filename, "rb");
    u32 address = 0;
    u8* buf = (u8*) malloc(LEN);
    memset(buf, 0xFF, LEN);

    iprintf("Writing game to NOR...\n");
		for (address = 0; address <= cfg->filesize && address < MAX_NOR; address += LEN)
		{
      if(cfg->compress)
      {
      
      }
      else
      {
        fread(buf, 1, LEN, gbaFile);
      }
			WriteNorFlash(address, buf, LEN);
			memset(buf, 0xFF, LEN);
		}
    iprintf("Write OK!...\n");

    CloseNorWrite();
    fclose(gbaFile);
    free(buf);
	}
}

void writeToPSRAM(configStruct* cfg)
{
	REG_EXMEMCNT &= ~0x0880;
	SetRompage(381);
	OpenNorWrite();
	SetSerialMode();
  
  FILE* gbaFile = fopen(cfg->filename, "rb");
  u8* buf = (u8*) malloc(LEN);
	memset(buf, 0xFF, LEN);
  u32 address = 0;

  iprintf("Writing game to PSRAM....\n");
	for (address = 0; address <= cfg->filesize && address < MAX_PSRAM; address += LEN)
	{
    if(cfg->compress)
    {
      
    }
    else
    {
      fread(buf, 1, LEN, gbaFile);
		}
    WritePSRAM(address, buf, LEN); 
		memset(buf, 0xFF, LEN);
	}
  iprintf("Write OK!...\n");

	CloseNorWrite();
	SetRompage(384);
  fclose(gbaFile);
	free(buf);
}

int checkNOR(configStruct* cfg)
{
	u8* test1 = (u8*) malloc(LEN);
	u8* test2 = (u8*) malloc(LEN);
	FILE* checkFile = fopen(cfg->filename, "rb");
  
	ReadNorFlash(test1, 0, LEN);
  
  if(cfg->compress)
  {
    
  }
  else
  {
    fread(test2, 1, LEN, checkFile);
  }
  
	int result = memcmp(test1, test2, LEN);
  result = (int)(result == 0);
	iprintf("NOR redundancy check: %i\n", result);
	fclose(checkFile);
	free(test1);
	free(test2);
  
	return result;
}
