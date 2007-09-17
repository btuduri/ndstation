#ifndef NDS_3IN1_INCLUDE
#define NDS_3IN1_INCLUDE

#ifndef BYTE
typedef unsigned char BYTE;
#endif

#ifndef WORD
typedef unsigned short WORD;
#endif

#ifndef DWORD
typedef unsigned long DWORD;
#endif

#ifndef BOOL
typedef bool BOOL ;
#endif

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

#endif
