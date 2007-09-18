
#include <nds.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fat.h>
#include <zlib.h>

#include "flash.h"
#include "3in1.h"
#include "sram.h"
#include "efs_lib.h"

int FAT_size(char* path) {
	FILE* fatFile;
	int fatSize;
	
	fatFile = fopen(path, "rb");
	fseek(fatFile, 0, SEEK_END);
	fatSize = ftell(fatFile);
	
	fclose(fatFile);
	return fatSize;
}

int isPSRAM(char* path) {

	int result;
	EFS_FILE* modeFile;
	char* mode = calloc(1, 1);
	
	modeFile = EFS_fopen("/mode.txt");
	EFS_fread(mode, 1, 1, modeFile);
	result = !strcmp(mode, "P");
	
	EFS_fclose(modeFile);
	free(mode);
	
	return result;
}

int isGZ(char* path) {

	int result;
	EFS_FILE* modeFile;
	char* mode = calloc(1, 1);
	
	modeFile = EFS_fopen("/mode.txt");
	EFS_fseek(modeFile, 1, SEEK_SET);
	EFS_fread(mode, 1, 1, modeFile);
	result = !strcmp(mode, "C");
	
	EFS_fclose(modeFile);
	free(mode);
	
	return result;
}

void writeToNOR(char* filename, int size, int isFATmode)
{
    u8* buf;
    buf = (u8*) malloc(LEN);
    memset (buf, 0xFF, LEN);

	scanKeys();
	
    OpenNorWrite();
    SetSerialMode();
	
	if(!(checkNOR(filename) && !(keysDown() & KEY_A))){

		u32 kk = 0;
		u32 address = 0;

	    for(kk=0; kk <= size && kk < MAX_NOR; kk+=0x40000)
	    {
	        Block_Erase(kk);
	    }

	    CloseNorWrite();

		FILE* gbaFile_FAT = NULL;
		EFS_FILE* gbaFile_EFS = NULL;

		if(isFATmode){
			gbaFile_FAT = fopen(filename, "rb");
		} else {
			gbaFile_EFS = EFS_fopen(filename);
		}

		iprintf("Writing GBA game to NOR.\n");

	    OpenNorWrite();
	    SetSerialMode();

	    for (address = 0; address <= size && address < MAX_NOR; address += LEN)
	    {
			if(isFATmode) {
				fread(buf, 1, LEN, gbaFile_FAT);
			} else {
				EFS_fread(buf, 1, LEN, gbaFile_EFS);
				//EFS_fseek(gbaFile_EFS, LEN, SEEK_CUR);
			}
			WriteNorFlash(address, buf, LEN);
	        memset (buf, 0xFF, LEN);
	    }

		if(isFATmode){
			fclose(gbaFile_FAT);
		} else {
			EFS_fclose(gbaFile_EFS);
		}

	}
	
    CloseNorWrite();
   
    free(buf);

}

void writeToPSRAM(char* filename, int size, int isFATmode)
{
    u8* buf;
    buf = (u8*) malloc(LEN);
    memset (buf, 0xFF, LEN);

	FILE* gbaFile_FAT = NULL;
	EFS_FILE* gbaFile_EFS = NULL;
	
	if(isFATmode){
		gbaFile_FAT = fopen(filename, "rb");
	} else {
		gbaFile_EFS = EFS_fopen(filename);
	}
	
    u32 address = 0;

	iprintf("Writing GBA game to PSRAM.\n");

	REG_EXMEMCNT &= ~0x0880;
	SetRompage(381);
    OpenNorWrite();
    SetSerialMode();

    for (address = 0; address <= size && address < MAX_NOR; address += LEN)
    {
		if(isFATmode){
			fread(buf, 1, LEN, gbaFile_FAT);
		} else {
			EFS_fread(buf, 1, LEN, gbaFile_EFS);
			//EFS_fseek(gbaFile_EFS, LEN, SEEK_CUR);
		}
        WritePSRAM(address, buf, LEN); 
        memset (buf, 0xFF, LEN);
    }

    CloseNorWrite();
	SetRompage(384);

	if(isFATmode){
		fclose(gbaFile_FAT);
	} else {
		EFS_fclose(gbaFile_EFS);
    }
	
	free(buf);

}

int uncompressToCard(char *source, char *dest){
  gzFile inFile = gzopen(source, "rb");
  FILE *outFile = fopen(dest, "wb");
  char *buffer[512];
  int writeSize = 0;
  int test = 0;
  int result = 0;

  while((writeSize = gzread(inFile, buffer, sizeof(buffer))) > 0){
    if(writeSize < 0){
      gzerror(inFile, &result);
      break;
    }else if(writeSize == 0){
      result = EOF;
      break;
    }
    if((test = fwrite(buffer, 1, (unsigned)writeSize, outFile)) != writeSize){
      result = Z_ERRNO;
      break;
    }
  }

  gzclose(inFile);
  fclose(outFile);

  if(result == EOF){
    return Z_OK;
  }else if(result == Z_ERRNO){
    return Z_ERRNO;
  }else{
    return result;
  }
}

void copyToCard(char *source, char *dest)
{
   EFS_FILE* in = EFS_fopen(source);
   FILE* out = fopen(dest, "wb");

   unsigned char buffer[4096];

   unsigned int file_size;
   file_size = EFS_size(source);

   while (file_size)
   {
        unsigned int to_copy = file_size > 4096 ? 4096 : file_size;
        EFS_fread(buffer, to_copy, 1, in);
		//EFS_fseek(in, 4096, SEEK_CUR);
        fwrite(buffer, to_copy, 1, out);
        file_size -= to_copy;
   }

   EFS_fclose(in);
   fclose(out);
}

int checkNOR(char* filename){
	// checks if a file is already written to the NOR
	
	u8* test1;
	u8* test2;
	int result = 0;
	
	test1 = (u8*) malloc(LEN);
	test2 = (u8*) malloc(LEN);
	
	FILE* checkFile = fopen(filename, "rb");
	
	ReadNorFlash(test1, 0, LEN);
	fread(test2, 1, LEN, checkFile);
	
	result = memcmp(test1, test2, LEN);

	iprintf("%i\n", result);
	
	fclose(checkFile);
	free(test1);
	free(test2);
	
	if(result == 0)
		return 1;

	return 0;
	
}
