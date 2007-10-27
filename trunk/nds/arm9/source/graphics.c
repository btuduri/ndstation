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
#include <malloc.h>
#include <fat.h>
#include <string.h>

#include "efs_lib.h"

int getSize(uint8 * source, uint16 * dest, uint32 r2)
{
	u32 size = *((u32*)source) >> 8;
	return (size<<8) | 0x10;
}

uint8 readByte(uint8 * source)
{
	return *source++;
}

void decompressToVRAM(const void* source, void* dest)
{
	TDecompressionStream decStream;
	decStream.getSize = getSize;
	decStream.getResult = NULL;
	decStream.readByte = readByte;
	swiDecompressLZSSVram((void*)source, dest, 0, &decStream);
}

void loadSplash(void) {

	// load a splash/loading screen
	// this function is f***ed up at the moment

	/*EFS_FILE* splashFile;
	int fileSize = EFS_size("/splash.lz7");

	char* splashData = malloc(fileSize);
	memset(splashData, 1, fileSize);

	splashFile = EFS_fopen("/splash.lz7");

	EFS_fread(splashData, 1, fileSize, splashFile);
	EFS_fclose(splashFile);

	decompressToVRAM((void*)splashData, BG_GFX);

	free(splashData);*/


	/*EFS_FILE* splashFile = EFS_fopen("/splash.lz7");
	int fileSize = EFS_GetFileSize(splashFile);
	char* splashCompData = malloc(fileSize);
	char* splashDecompData = malloc(256*192*2);

	EFS_fread(splashCompData, 1, fileSize, splashFile);
	EFS_fclose(splashFile);
	swiDecompressLZSSWram(splashCompData, splashDecompData);

	memcpy((void*)BG_GFX, (void*)splashDecompData, 256*192*2);

	free(splashCompData);
	free(splashDecompData);*/

}

void loadBorder(void) {

	// load the border used in GBA mode

	videoSetMode(MODE_5_2D | DISPLAY_BG3_ACTIVE);
	videoSetModeSub(MODE_5_2D | DISPLAY_BG3_ACTIVE);
	vramSetMainBanks(VRAM_A_MAIN_BG_0x06000000, VRAM_B_MAIN_BG_0x06020000, VRAM_C_SUB_BG_0x06200000, VRAM_D_LCD);
	BG3_CR = BG_BMP16_256x256 | BG_BMP_BASE(0) | BG_WRAP_OFF;
	BG3_XDX = 1 << 8;
	BG3_XDY = 0;
	BG3_YDX = 0;
	BG3_YDY = 1 << 8;
	BG3_CX = 0;
	BG3_CY = 0;

	EFS_FILE* borderFile;
	int fileSize = EFS_size("/border.lz7");

	char* borderData = malloc(fileSize);
	memset(borderData, 0, fileSize);

	borderFile = EFS_fopen("/border.lz7");

	EFS_fread(borderData, 1, fileSize, borderFile);
	EFS_fclose(borderFile);

	decompressToVRAM((void*)borderData, (void*)BG_BMP_RAM(0));
	decompressToVRAM((void*)borderData, (void*)BG_BMP_RAM(8));

	free(borderData);

}		
