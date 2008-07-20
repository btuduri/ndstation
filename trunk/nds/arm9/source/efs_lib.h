#ifndef __EFS_LIB_H
#define __EFS_LIB_H

#include <stdio.h>
#include <sys/dir.h>

// defines
#define EFS_MAXPATHLEN  256
#define EFS_MAXNAMELEN  128

// the NDS file path, dynamically set by the lib
extern char efs_path[256];

// init options
typedef enum
{
    EFS_ONLY = 0,           // init only the efslib, may require prior fatlib init
    EFS_AND_FAT = 1,        // init libfat with default options before efslib if needed
    EFS_DEFAULT_DEVICE = 2  // set as default device in devoptab
} EFS_Init_Options;

// initialize the file system, first trying to search the NDS at the given path if !NULL
// return 1 if the FS has been initialized properly
// return 0 if there was an error initializing the FS (libfat included)
int EFS_Init(int options, char *path);

// devoptab functions implementation (don't use those directly)
DIR_ITER* EFS_DirOpen(struct _reent *r, DIR_ITER *dirState, const char *path);
int EFS_DirReset(struct _reent *r, DIR_ITER *dirState);
int EFS_DirNext(struct _reent *r, DIR_ITER *dirState, char *filename, struct stat *st);
int EFS_DirClose(struct _reent *r, DIR_ITER *dirState);
int EFS_Open(struct _reent *r, void *fileStruct, const char *path, int flags, int mode);
int EFS_Close(struct _reent *r, int fd);
int EFS_Read(struct _reent *r, int fd, char *ptr, int len);
int EFS_Write(struct _reent *r, int fd, const char *ptr, int len);
int EFS_Seek(struct _reent *r, int fd, int pos, int dir);
int EFS_Fstat(struct _reent *r, int fd, struct stat *st);
int EFS_Stat(struct _reent *r, const char *file, struct stat *st);
int EFS_ChDir(struct _reent *r, const char *name);    

#endif
