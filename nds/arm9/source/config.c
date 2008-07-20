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
#include "config.h"
#include "iniparser.h"
#include "flash.h"

void populateConfig(configStruct* cfg)
{
  iprintf("Loading configuration file...\n");
	dictionary* iniFile = iniparser_load("/config.ini");
  
  iprintf("Populating configuration...\n");
	cfg->compress = iniparser_getboolean(iniFile, "mode:nsar", 0);
	cfg->psram = iniparser_getboolean(iniFile, "mode:psram", 0);
	cfg->border = iniparser_getboolean(iniFile, "graphics:border", 0);
	cfg->splash = iniparser_getboolean(iniFile, "graphics:splash", 0);
  
  iprintf("Unloading configuration file...\n");
  iniparser_freedict(iniFile);
  
  iprintf("Finding game file...\n");
  cfg->filename = (char*) malloc(16);
  memset(cfg->filename, 0x00, 16);
  if(cfg->compress)
    strcpy(cfg->filename, "/game.nsar");
  else
    strcpy(cfg->filename, "/game.gba");
  iprintf("Game file: %s\n", cfg->filename);

  iprintf("Calculating game size...\n");
  cfg->filesize = filesize(cfg->filename);
  iprintf("Game size: %u bytes\n", cfg->filesize);
}
