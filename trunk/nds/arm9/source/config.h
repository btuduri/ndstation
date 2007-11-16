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

#define CONFIG_NSAR_ENABLED    1
#define CONFIG_PSRAM_ENABLED   2
#define CONFIG_DEVICE_TYPE     3

#define CONFIG_BORDER_ENABLED  4
#define CONFIG_SPLASH_ENABLED  5

bool config_file(int key);
