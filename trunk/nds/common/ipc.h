enum {
	IPC_GBA_BOOT
} IPC_MSG;

#define IPC_ARM9 (*(vu32*)0x27ff200)	//message from arm9

typedef void(*call0)(void);
typedef void(*call3)(u32,u32,u32);
