Attribute VB_Name = "modEFSPatch"
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



' EFS patching code based on the work of Noda

Option Explicit

Private Const efsMagicString = "Î©¿ EFSstr"

Private Function dec2hex(ByVal num As String) As String
    Dim number As String
    Dim neg As Boolean
    number = num
    If Left(number, 1) = "-" Then
        neg = True
        number = Right(number, Len(number) - 1)
    Else
        neg = False
    End If
    While Left(number, 1) = "0"
        number = Right(number, Len(number) - 1)
    Wend
    If Len(number) = 0 Then
        dec2hex = 0
        Exit Function
    End If
    number = Hex(number)
    If neg = True Then
        number = "-" & number
    End If
    dec2hex = LCase(number)
End Function

Private Function hex2nds(ByVal num As String) As String
    Dim number As String
    number = num
    Do While Len(number) < 8
        number = "0" & number
    Loop
    hex2nds = Chr("&H" & Mid(number, 7, 2)) & Chr("&H" & Mid(number, 5, 2)) & Chr("&H" & Mid(number, 3, 2)) & Chr("&H" & Mid(number, 1, 2))
End Function

Public Sub EFS_patch(appFileName As String)

    Dim patchOffset As Long ' Position of patch destination in the file
    Dim appFile As Integer
    Dim appFileData As String
    Dim appFileSize As Long
    Dim new_id As Integer

    appFile = fopen(appFileName)
    
    ' Load the app file
    appFileSize = filesize(appFileName)
    appFileData = fread(appFile, appFileSize)
    
    ' Find the EFS reserved space in the file
    patchOffset = InStr(1, appFileData, efsMagicString) - 1

    If patchOffset = 0 Then
        MsgBox appFileName & " does not have an EFS section"
        Exit Sub
    End If
    
    ' Generate a random ID
    Randomize
    new_id = Int(Rnd * 32768)
    
    ' Write EFS ID & filesize
    Call fseek(appFile, patchOffset + 12, SEEK_SET)
    Call fwrite(appFile, hex2nds(dec2hex(new_id)))
    Call fwrite(appFile, hex2nds(dec2hex(appFileSize)))
    Call fclose(appFile)

End Sub
