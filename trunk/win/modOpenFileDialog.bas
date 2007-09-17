Attribute VB_Name = "modOpenFileDialog"
' This module brings up a file opening window

Option Explicit

Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OpenFilename) As Long

Private Type OpenFilename
    lStructSize As Long
    hWndOwner As Long
    hInstance As Long
    lpstrFilter As String
    lpstrCustomFilter As String
    nMaxCustFilter As Long
    iFilterIndex As Long
    lpstrFile As String
    nMaxFile As Long
    lpstrFileTitle As String
    nMaxFileTitle As Long
    lpstrInitialDir As String
    lpstrTitle As String
    flags As Long
    nFileOffset As Integer
    nFileExtension As Integer
    lpstrDefExt As String
    lCustData As Long
    lpfnHook As Long
    lpTemplateName As String
End Type

Public Enum OFNFlagsEnum
    OFN_ALLOWMULTISELECT = &H200
    OFN_CREATEPROMPT = &H2000
    OFN_ENABLEHOOK = &H20
    OFN_ENABLETEMPLATE = &H40
    OFN_ENABLETEMPLATEHANDLE = &H80
    OFN_EXPLORER = &H80000
    OFN_EXTENSIONDIFFERENT = &H400
    OFN_FILEMUSTEXIST = &H1000
    OFN_HIDEREADONLY = &H4
    OFN_LONGNAMES = &H200000
    OFN_NOCHANGEDIR = &H8
    OFN_NODEREFERENCELINKS = &H100000
    OFN_NOLONGNAMES = &H40000
    OFN_NONETWORKBUTTON = &H20000
    OFN_NOREADONLYRETURN = &H8000
    OFN_NOTESTFILECREATE = &H10000
    OFN_NOVALIDATE = &H100
    OFN_OVERWRITEPROMPT = &H2
    OFN_PATHMUSTEXIST = &H800
    OFN_READONLY = &H1
    OFN_SHAREAWARE = &H4000
    OFN_SHAREFALLTHROUGH = 2
    OFN_SHARENOWARN = 1
    OFN_SHAREWARN = 0
    OFN_SHOWHELP = &H10
End Enum

' Example:
'    MsgBox "File selected: " & ShowOpenFileDialog("Text files (*.txt)|*.txt|All files (*.*)|*.*", "txt", "C:\Documents", OFN_FILEMUSTEXIST)

Function OpenFileDialog(ByVal sFilter As String, Optional ByVal sDefExt As String, Optional ByVal sInitDir As String, Optional ByVal lFlags As Long, Optional ByVal hParent As Long) As String
    Dim OFN As OpenFilename
    On Error Resume Next
    
    With OFN
        .lStructSize = Len(OFN)
        .hWndOwner = hParent
        .lpstrFilter = Replace(sFilter, "|", vbNullChar) & vbNullChar
        .lpstrFile = Space$(255) & vbNullChar & vbNullChar
        .nMaxFile = Len(.lpstrFile)
        .flags = lFlags
        .lpstrInitialDir = sInitDir
        .lpstrDefExt = sDefExt
    End With
    
    If GetOpenFileName(OFN) Then
        OpenFileDialog = Left$(OFN.lpstrFile, InStr(OFN.lpstrFile, vbNullChar) - 1)
    End If
End Function

