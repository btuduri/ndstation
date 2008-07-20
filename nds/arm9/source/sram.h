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

#ifndef __SRAM_H
#define __SRAM_H

#define TOT_SRAM_PAGES 128    // last selectable page is 127
#define MAX_SRAM_PAGES 80     // 64+256/4
#define SRAM_PAGE_SIZE 0x1000 // SRAM Page Size
#define MAX_SRAM 0x50000      //0x80000	4MBit/512KByte total SRAM - use only first 64k+256k

void blankSRAM(u8 pages);

void sramBackup(void);
void sramWrite(void);
int getStartpage(void);

#endif
