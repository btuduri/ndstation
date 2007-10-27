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

#define LEN 0x8000         // 1mbit NOR page size
#define MAX_NOR 0x2000000  // 32MByte 
#define MAX_PSRAM 0x1000000

int isPSRAM(char* path);
int isGZ(char* path);

int FAT_size(char* path);

void writeToNOR(char* filename, int size, int isFATmode);
void writeToPSRAM(char* filename, int size, int isFATmode);

int uncompressToCard(char *source, char *dest);
void copyToCard(char *source, char *dest);

int checkNOR(char* filename);
