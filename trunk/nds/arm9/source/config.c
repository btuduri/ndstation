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

#include "config.h"
#include "iniparser.h"

bool config_file(int key){
	dictionary* iniFile = iniparser_new("/config.ini");
	switch(key)
	{
		case 1: // NSAR enabled?
			return iniparser_getboolean(iniFile, "mode:nsar", 0);
			break;
		case 2: // PSRAM enabled?
			return iniparser_getboolean(iniFile, "mode:psram", 0);
			break;
		case 3: // Device type?
			break;
		case 4: // Border enabled?
			return iniparser_getboolean(iniFile, "graphics:border", 0);
			break;
		case 5: // Splash enabled?
			return iniparser_getboolean(iniFile, "graphics:splash", 0);
			break;
	}
	return false;
}
