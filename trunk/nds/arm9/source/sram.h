/*
    GBALdr - manage files from and on GBA flash carts from a DS unit
    Copyright (C) 2007 cory1492 < cory1492 (at) gmail (dot) com >

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/
#ifndef NDS_SRAM_INCLUDE
#define NDS_SRAM_INCLUDE

#define TOT_SRAM_PAGES 128 // last selectable page is 127
#define MAX_SRAM_PAGES 80 // 64+256/4
#define SRAM_PAGE_SIZE 0x1000  	// SRAM Page Size
#define MAX_SRAM 0x50000 //0x80000	 4MBit/512KByte total SRAM - use only first 64k+256k

// 0 to pages are blanked
void blankSRAM(u8 pages);

// filename, path, bytesize - #pages must be checked externally for validity
void writeSAV(void);
void readSAV(void);
void writeSRAMToFile(char* filename);
void writeFileToSRAM(char* filename);
int getStartpage(void);

#endif // NDS_SRAM_INCLUDE
