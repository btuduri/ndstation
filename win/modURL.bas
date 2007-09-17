Attribute VB_Name = "modURL"
' This module lets you open a URL in the default browser

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
    OpenBrowser = (res > 32)
End Function

