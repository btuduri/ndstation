Attribute VB_Name = "modURL"
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



' This module lets you open a URL in the default browser

Option Explicit

Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
    (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, _
    ByVal lpParameters As String, ByVal lpDirectory As String, _
    ByVal nShowCmd As Long) As Long

Public Function OpenURL(ByVal URL As String) As Boolean
    Dim res As Long
    If InStr(1, URL, "http", vbTextCompare) <> 1 Then
        URL = "http://" & URL
    End If
    res = ShellExecute(0&, "open", URL, vbNullString, vbNullString, _
        vbNormalFocus)
    OpenURL = (res > 32)
End Function

