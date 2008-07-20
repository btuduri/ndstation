#ifndef __3IN1_H
#define __3IN1_H

#include "nds.h"

#define FlashBase		0x08000000
#define _PSRAM      0x08060000

void Enable_Arm7DS(void);
void Enable_Arm9DS(void);

void OpenNorWrite();
void CloseNorWrite();
void SetRompage(u16 page);
void SetRampage(u16 page);
void OpenRamWrite();
void CloseRamWrite();
void SetSerialMode();
uint32 ReadNorFlashID();
void chip_reset();
void Block_Erase(u32 blockAdd);
void ReadNorFlash(u8* pBuf,u32 address,u16 len);
void WriteNorFlash(u32 address,u8 *buffer,u32 size);
void WriteSram(uint32 address, u8* data , uint32 size );
void ReadSram(uint32 address, u8* data , uint32 size );
void SetShake(u16 data);
void WritePSRAM(u32 address,u8 *buffer,u32 size);

#endif
