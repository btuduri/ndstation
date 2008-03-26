Attribute VB_Name = "modNDStationSetup"
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



Option Explicit

Public Sub clearTemp(binDirectory)
    On Error Resume Next
    Call unlink(binDirectory & "\x.nds")
    Call unlink(binDirectory & "\border.bmp")
    Call unlink(binDirectory & "\border.img.bin")
    Call unlink(binDirectory & "\splash.bmp")
    Call unlink(binDirectory & "\splash.img.bin")
    Call unlink(binDirectory & "\icon.bmp")
    Call unlink(binDirectory & "\data\config.ini")
    Call unlink(binDirectory & "\data\game.gba")
    Call unlink(binDirectory & "\data\game.nsar")
    Call unlink(binDirectory & "\data\border.lz7")
    Call unlink(binDirectory & "\data\splash.lz7")
End Sub

Public Sub clearEXE(binDirectory)
    On Error Resume Next
    Call unlink(binDirectory & "\grit.exe")
    Call unlink(binDirectory & "\gzip.exe")
    Call unlink(binDirectory & "\ndstool.exe")
    Call unlink(binDirectory & "\freeimage.dll")
    Call unlink(binDirectory & "\gbacrusher.exe")
    Call unlink(binDirectory & "\7.bin")
    Call unlink(binDirectory & "\9.bin")
    Call unlink(binDirectory & "\gfx\splash.bmp")
    Call unlink(binDirectory & "\gfx\border.bmp")
    Call unlink(binDirectory & "\gfx\icon.bmp")
    Call RmDir(binDirectory & "\data")
    Call RmDir(binDirectory & "\gfx")
    Call RmDir(binDirectory & "\lzss")
    Call RmDir(binDirectory)
End Sub

Public Sub unpackEXE(binDirectory)
    On Error Resume Next
    Call MkDir(binDirectory)
    Call MkDir(binDirectory & "\data")
    Call MkDir(binDirectory & "\gfx")
    Call MkDir(binDirectory & "\lzss")
    Call extractRes("exe", "grit", binDirectory & "\grit.exe")
    Call extractRes("exe", "ndstool", binDirectory & "\ndstool.exe")
    Call extractRes("exe", "freeimage", binDirectory & "\freeimage.dll")
    Call extractRes("exe", "gbacrusher", binDirectory & "\gbacrusher.exe")
    Call extractRes("bmp", "icon", binDirectory & "\gfx\icon.bmp")
    Call extractRes("bin", "arm7", binDirectory & "\7.bin")
    Call extractRes("bin", "arm9", binDirectory & "\9.bin")
End Sub

Public Sub extractRes(datadir As String, dataname As String, filename As String)
    Dim myArray() As Byte
    Dim myFile As Long
    If Dir(filename) = "" Then
        myArray = LoadResData(dataname, datadir)
        myFile = FreeFile
        Open filename For Binary Access Write As #myFile
        Put #myFile, , myArray
        Close #myFile
    End If
End Sub

