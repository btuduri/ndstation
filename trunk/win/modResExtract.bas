Attribute VB_Name = "modResExtract"
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



' Extracts resources to a file

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

