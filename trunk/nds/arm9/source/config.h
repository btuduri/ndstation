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

#ifndef __CONFIG_H
#define __CONFIG_H

typedef struct
{
  unsigned int compress :1;
  unsigned int psram    :1;   
  unsigned int border   :1;
  unsigned int splash   :1;
  char* filename;
  int filesize;
} configStruct;

void populateConfig(configStruct* cfg);

#endif //__CONFIG_H