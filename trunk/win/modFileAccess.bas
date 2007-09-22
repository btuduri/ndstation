Attribute VB_Name = "modFileAccess"
' NDStation GUI for Windows v1.3 - package GBA files into NDS files with NDStation
' Copyright (C) 2007 Chaz Schlarp
'
' This program is free software: you can redistribute it and/or modify
' it under the terms of the GNU General Public License as published by
' the Free Software Foundation, either version 3 of the License, or
' (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
' You should have received a copy of the GNU General Public License
' along with this program.  If not, see <http://www.gnu.org/licenses/>.



' This module provides some file access functions
' (yes, it is messy and there are a lot of bugs)

Option Explicit

Dim pointer(255) As Long
Dim filenames(255) As String

Public Type SHFILEOPSTRUCT
    hWnd As Long
    wFunc As Long
    pFrom As String
    pTo As String
    fFlags As Integer
    fAnyOperationsAborted As Long
    hNameMappings As Long
    lpszProgressTitle As Long ' only used if FOF_SIMPLEPROGRESS, sets dialog title
End Type

Public Const SEEK_SET = 0
Public Const SEEK_CUR = 1
Public Const SEEK_END = 2

Public Const FO_COPY = &H2 ' Copy File/Folder
Public Const FO_DELETE = &H3 ' Delete File/Folder
Public Const FO_MOVE = &H1 ' Move File/Folder
Public Const FO_RENAME = &H4 ' Rename File/Folder
Public Const FOF_ALLOWUNDO = &H40 ' Allow to undo rename, delete ie sends to recycle bin
Public Const FOF_FILESONLY = &H80  ' Only allow files
Public Const FOF_NOCONFIRMATION = &H10  ' No File Delete or Overwrite Confirmation Dialog
Public Const FOF_SILENT = &H4 ' No copy/move dialog
Public Const FOF_SIMPLEPROGRESS = &H100 ' Does not display file names

Public Declare Function SHFileOperation Lib "shell32.dll" Alias "SHFileOperationA" _
                        (lpFileOp As SHFILEOPSTRUCT) As Long
                        
Public Function basename(path As String, Optional suffix As String) As String
    Dim slashloc(1) As Integer, oldslashloc(2) As Integer
    Dim temppath As String
    On Error Resume Next
    temppath = path
    If UCase(Right(path, Len(suffix))) = UCase(suffix) Then temppath = Left(path, Len(path) - Len(suffix))
    Do
        oldslashloc(0) = slashloc(0)
        slashloc(0) = slashloc(0) + 1
        slashloc(0) = InStr(slashloc(0), path, "/")
    Loop Until slashloc(0) = 0
    Do
        oldslashloc(1) = slashloc(1)
        slashloc(1) = slashloc(1) + 1
        slashloc(1) = InStr(slashloc(1), path, "\")
    Loop Until slashloc(1) = 0
    If oldslashloc(0) > oldslashloc(1) Then
        oldslashloc(2) = oldslashloc(0)
    Else
        oldslashloc(2) = oldslashloc(1)
    End If
    basename = Mid(temppath, oldslashloc(2) + 1)
End Function
                    
Public Function copy(source As String, dest As String) As Boolean
    Dim fso
    Set fso = CreateObject("Scripting.FileSystemObject")
    fso.CopyFile source, dest
    If file_exists(dest) Then
        copy = True
    Else
        copy = False
    End If
    
End Function

Public Function fclose(handle As Integer) As Boolean
    On Error GoTo ErrorTrap
    Close handle
    fclose = True
    GoTo ExitFunction
ErrorTrap:
    fclose = False
ExitFunction:
End Function

Public Function file_exists(filename As String) As Boolean
    Dim fs
    Set fs = CreateObject("Scripting.FileSystemObject")
    file_exists = fs.FileExists(filename)
End Function

Public Function file_get_contents(filename As String, Optional offset As Long = 0, Optional maxlen As Long = -1) As String
    Dim fgc_handle As Integer
    On Error Resume Next
    fgc_handle = fopen(filename)
    file_get_contents = fread(fgc_handle, filesize(filename))
    file_get_contents = Right(file_get_contents, Len(file_get_contents) - offset)
    If maxlen > 0 Then file_get_contents = Left(file_get_contents, maxlen)
End Function

Public Function filesize(filename As String) As Long
    On Error Resume Next
    filesize = FileLen(filename)
End Function

Public Function fopen(filename As String) As Integer
    On Error GoTo ErrorTrap
    fopen = FreeFile
    Open filename For Binary As fopen
    pointer(fopen) = 1
ErrorTrap:
End Function

Public Function fread(handle As Integer, length As Long) As String
    Dim readtemp As String

    On Error GoTo ErrorTrap
    readtemp = Space(LOF(handle))
    If length > 0 Then
        Get handle, pointer(handle), readtemp
        pointer(handle) = pointer(handle) + length
        fread = Left(readtemp, length)
    End If
ErrorTrap:
End Function

Public Sub fseek(handle As Integer, ByVal offset As Long, Optional whence As Integer = SEEK_SET)
    On Error Resume Next
    
    Select Case whence
        Case SEEK_SET
            pointer(handle) = offset + 1
        Case SEEK_CUR
            pointer(handle) = pointer(handle) + offset
        Case SEEK_END
            pointer(handle) = filesize(filenames(handle)) + offset
            If pointer(handle) > filesize(filenames(handle)) Then pointer(handle) = filesize(filenames(handle))
    End Select
End Sub

Public Function ftell(handle As Integer) As Long
    On Error Resume Next
    ftell = pointer(handle) - 1
End Function

Public Function fwrite(handle As Integer, ByVal data As String, Optional length As Long = -1) As Integer
    On Error GoTo ErrorTrap
    If length > 0 Then data = Left(data, length)
    If Len(data) > 0 Then
        Put handle, pointer(handle), data
        pointer(handle) = pointer(handle) + Len(data)
    End If
ErrorTrap:
End Function

Public Function rewind(handle As Integer)
    On Error GoTo ErrorTrap
    pointer(handle) = 1
    GoTo ExitFunction
ErrorTrap:
    rewind = False
ExitFunction:
End Function

Public Function unlink(filename As String) As Boolean
    On Error Resume Next
    Call Kill(filename)
    If file_exists(filename) Then
        unlink = False
    Else
        unlink = True
    End If
End Function
