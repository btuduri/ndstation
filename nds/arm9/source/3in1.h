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

	void Enable_Arm7DS(void);
	void Enable_Arm9DS(void);

#define FlashBase 0x08000000
#define	_Ez5PsRAM 0x08000000

	void OpenNorWrite(void);
	void CloseNorWrite(void);
	void SetRompage(u16 page);
	void SetRampage(u16 page);
	void OpenRamWrite(void);
	void CloseRamWrite(void);
	void SetSerialMode(void);
	uint32 ReadNorFlashID(void);
	void chip_reset(void);
	void Block_Erase(u32 blockAdd);
	void ReadNorFlash(u8* pBuf,u32 address,u16 len);
	void WriteNorFlash(u32 address,u8 *buffer,u32 size);
	void WritePSRAM(u32 address,u8 *buffer,u32 size);
	void WriteSram(uint32 address, u8* data , uint32 size );
	void ReadSram(uint32 address, u8* data , uint32 size );
	void SetShake(u16 data);
	bool CheckNorFlashID(void);
