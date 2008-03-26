Attribute VB_Name = "modFileAccess"
' NDStation GUI for Windows v1.3 - package GBA files into NDS files with NDStation
' Copyright (C) 2007 Chaz Schlarp
'
' This program is free software: you can redistribute it and/or modify
' it under the terms of the GNU General Public License as published by
' the Free Software Foundation, either version 2 of the License, or
' (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
' You should have received a copy of the GNU General Public License along
' with this program; if not, write to the Free Software Foundation, Inc.,
' 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.



' This module provides some file access functions
' (yes, it is messy and there are bugs)

Option Explicit

Dim pointerArray(255) As Long
Dim filenames(255) As String

Public Const SEEK_SET = 0
Public Const SEEK_CUR = 1
Public Const SEEK_END = 2
                        
Public Function basename(path As String, Optional suffix As String) As String
    Dim pathLoc(1 To 2) As Integer
    Dim tempBasename As String
    pathLoc(1) = InStr(StrReverse(path), "\")
    pathLoc(2) = InStr(StrReverse(path), "/")
    If pathLoc(1) > 0 And (pathLoc(1) < pathLoc(2) Or pathLoc(2) = 0) Then
        tempBasename = Right(path, pathLoc(1) - 1)
    ElseIf pathLoc(2) > 0 And (pathLoc(2) < pathLoc(1) Or pathLoc(1) = 0) Then
        tempBasename = Right(path, pathLoc(2) - 1)
    Else
        tempBasename = path
    End If
    If Right(tempBasename, Len(suffix)) = suffix Then tempBasename = Left(tempBasename, Len(tempBasename) - Len(suffix))
    basename = tempBasename
End Function
                    
Public Sub copy(source As String, dest As String)
    Dim fso
    Set fso = CreateObject("Scripting.FileSystemObject")
    fso.CopyFile source, dest
End Sub

Public Sub fclose(handle As Integer)
    On Error Resume Next
    Close handle
End Sub

Public Function file_exists(filename As String) As Boolean
    Dim fso
    Set fso = CreateObject("Scripting.FileSystemObject")
    file_exists = fso.FileExists(filename)
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
    On Error Resume Next
    fopen = FreeFile
    Open filename For Binary As fopen
    pointerArray(fopen) = 1
End Function

Public Function fread(handle As Integer, length As Long) As Variant
    On Error Resume Next
    If length > 0 Then
        Dim readBuffer() As Byte
        ReDim readBuffer(0 To (length - 1))
        Get handle, pointerArray(handle), readBuffer
        pointerArray(handle) = pointerArray(handle) + length
        fread = readBuffer
    End If
End Function

Public Sub fseek(handle As Integer, ByVal offset As Long, Optional whence As Integer = SEEK_SET)
    On Error Resume Next
    
    Select Case whence
        Case SEEK_SET
            pointerArray(handle) = offset + 1
        Case SEEK_CUR
            pointerArray(handle) = pointerArray(handle) + offset
        Case SEEK_END
            pointerArray(handle) = filesize(filenames(handle)) + offset
            If pointerArray(handle) > filesize(filenames(handle)) Then pointerArray(handle) = filesize(filenames(handle))
    End Select
End Sub

Public Function ftell(handle As Integer) As Long
    On Error Resume Next
    ftell = pointerArray(handle) - 1
End Function

Public Function fwrite(handle As Integer, data() As Byte, Optional length As Long = -1) As Integer
    On Error Resume Next
    Dim tempData() As Byte
    tempData = data
    If length > 0 Then ReDim Preserve tempData(0 To (length - 1))
    If (UBound(tempData) - LBound(tempData) + 1) > 0 Then
        Put handle, pointerArray(handle), tempData
        pointerArray(handle) = pointerArray(handle) + (UBound(tempData) - LBound(tempData) + 1)
    End If
End Function

Public Sub rename(source As String, dest As String)
    On Error Resume Next
    Dim fso As FileSystemObject
    Set fso = CreateObject("Scripting.FileSystemObject")
    fso.MoveFile source, dest
End Sub

Public Sub rewind(handle As Integer)
    On Error Resume Next
    pointerArray(handle) = 1
End Sub

Public Sub unlink(filename As String)
    On Error Resume Next
    Call Kill(filename)
End Sub
