VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmNDStation 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "NDStation v1.3"
   ClientHeight    =   8775
   ClientLeft      =   45
   ClientTop       =   450
   ClientWidth     =   7335
   Icon            =   "frmNDStation.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   8775
   ScaleWidth      =   7335
   StartUpPosition =   3  'Windows Default
   Begin ComctlLib.ListView lvwBatch 
      Height          =   1935
      Left            =   120
      TabIndex        =   16
      Top             =   5880
      Width           =   7095
      _ExtentX        =   12515
      _ExtentY        =   3413
      View            =   3
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      _Version        =   327682
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   8
      BeginProperty ColumnHeader(1) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "GBA File"
         Object.Width           =   11906
      EndProperty
      BeginProperty ColumnHeader(2) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   1
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Output Folder"
         Object.Width           =   0
      EndProperty
      BeginProperty ColumnHeader(3) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   2
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Game Title"
         Object.Width           =   0
      EndProperty
      BeginProperty ColumnHeader(4) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   3
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Use PSRAM"
         Object.Width           =   0
      EndProperty
      BeginProperty ColumnHeader(5) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   4
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Use Compression"
         Object.Width           =   0
      EndProperty
      BeginProperty ColumnHeader(6) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   5
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Icon File"
         Object.Width           =   0
      EndProperty
      BeginProperty ColumnHeader(7) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   6
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Border File"
         Object.Width           =   0
      EndProperty
      BeginProperty ColumnHeader(8) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
         SubItemIndex    =   7
         Key             =   ""
         Object.Tag             =   ""
         Text            =   "Splash File"
         Object.Width           =   0
      EndProperty
   End
   Begin VB.CommandButton cmdAbout 
      Caption         =   "About"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5880
      TabIndex        =   21
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CommandButton cmdBorder 
      Caption         =   "Browse..."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5760
      TabIndex        =   13
      Top             =   4560
      Width           =   1215
   End
   Begin VB.CommandButton cmdIcon 
      Caption         =   "Browse..."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5760
      TabIndex        =   11
      Top             =   4080
      Width           =   1215
   End
   Begin VB.CommandButton cmdSplash 
      Caption         =   "Browse..."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5760
      TabIndex        =   15
      Top             =   5040
      Width           =   1215
   End
   Begin ComctlLib.ProgressBar pbrProgress 
      Height          =   255
      Left            =   240
      TabIndex        =   34
      Top             =   8400
      Width           =   6855
      _ExtentX        =   12091
      _ExtentY        =   450
      _Version        =   327682
      Appearance      =   1
   End
   Begin VB.CommandButton cmdRun 
      Caption         =   "Run"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4200
      TabIndex        =   20
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CommandButton cmdClear 
      Caption         =   "Clear"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2880
      TabIndex        =   19
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1560
      TabIndex        =   18
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CommandButton cmdAdd 
      Caption         =   "Add"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   17
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CheckBox chkCompression 
      Height          =   255
      Left            =   4080
      TabIndex        =   9
      ToolTipText     =   "Compresses the ROM to get smaller filesizes at the expense of loading time"
      Top             =   3045
      Value           =   1  'Checked
      Width           =   255
   End
   Begin VB.CheckBox chkPSRAM 
      Height          =   255
      Left            =   1440
      TabIndex        =   8
      ToolTipText     =   "PSRAM loads faster, but needs to be written every time"
      Top             =   3045
      Value           =   1  'Checked
      Width           =   255
   End
   Begin VB.CommandButton cmdOutput 
      Caption         =   "Select..."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5760
      TabIndex        =   4
      Top             =   840
      Width           =   1215
   End
   Begin VB.CommandButton cmdGBA 
      Caption         =   "Browse..."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5760
      TabIndex        =   2
      Top             =   360
      Width           =   1215
   End
   Begin VB.Frame fraGame 
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   7095
      Begin VB.TextBox txtOutput 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   1320
         OLEDropMode     =   1  'Manual
         TabIndex        =   3
         Top             =   720
         Width           =   4215
      End
      Begin VB.TextBox txtGBA 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   1320
         OLEDropMode     =   1  'Manual
         TabIndex        =   1
         Top             =   240
         Width           =   4215
      End
      Begin VB.Label lblGBA 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "GBA ROM File:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   120
         TabIndex        =   36
         Top             =   240
         Width           =   1065
      End
      Begin VB.Label lblOutput 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "Output Folder:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   120
         TabIndex        =   35
         Top             =   720
         Width           =   1020
      End
   End
   Begin VB.Frame fraOptions 
      Height          =   1935
      Left            =   120
      TabIndex        =   22
      Top             =   1440
      Width           =   7095
      Begin VB.TextBox txtTitle 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   2
         Left            =   1320
         TabIndex        =   7
         Top             =   1200
         Width           =   4215
      End
      Begin VB.TextBox txtTitle 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   1
         Left            =   1320
         TabIndex        =   6
         Top             =   720
         Width           =   4215
      End
      Begin VB.TextBox txtTitle 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   0
         Left            =   1320
         TabIndex        =   5
         Top             =   240
         Width           =   4215
      End
      Begin VB.Label lblCompression 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "Use Compression:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   2400
         TabIndex        =   25
         Top             =   1620
         Width           =   1320
      End
      Begin VB.Label lblPSRAM 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "Use PSRAM:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   120
         TabIndex        =   24
         Top             =   1620
         Width           =   915
      End
      Begin VB.Label lblTitle 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "Game Title:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   120
         TabIndex        =   23
         Top             =   240
         Width           =   795
      End
   End
   Begin VB.Frame fraCustomize 
      Height          =   2295
      Left            =   120
      TabIndex        =   26
      Top             =   3480
      Width           =   7095
      Begin VB.TextBox txtSplash 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   1320
         OLEDropMode     =   1  'Manual
         TabIndex        =   14
         Top             =   1575
         Width           =   4215
      End
      Begin VB.TextBox txtIcon 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   1320
         OLEDropMode     =   1  'Manual
         TabIndex        =   10
         Top             =   600
         Width           =   4215
      End
      Begin VB.TextBox txtBorder 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   1320
         OLEDropMode     =   1  'Manual
         TabIndex        =   12
         Top             =   1080
         Width           =   4215
      End
      Begin VB.Label lblSplash 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "Splash:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   210
         Left            =   120
         TabIndex        =   33
         Top             =   1560
         Width           =   540
      End
      Begin VB.Label lblSplashInfo 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "The splash/loading screen - 256x192"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   180
         Left            =   1440
         TabIndex        =   32
         Top             =   1905
         Width           =   2280
      End
      Begin VB.Label lblIcon 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "Icon:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   210
         Left            =   120
         TabIndex        =   31
         Top             =   600
         Width           =   345
      End
      Begin VB.Label lblBorder 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "Border:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   210
         Left            =   120
         TabIndex        =   30
         Top             =   1080
         Width           =   540
      End
      Begin VB.Label lblIconInfo 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "The icon of the NDS file - 32x32, 4 bit color"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   180
         Left            =   1440
         TabIndex        =   29
         Top             =   900
         Width           =   2745
      End
      Begin VB.Label lblBorderInfo 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "The border around the GBA game - 256x192"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   180
         Left            =   1440
         TabIndex        =   28
         Top             =   1395
         Width           =   2745
      End
      Begin VB.Label lblCustomizeInfo 
         AutoSize        =   -1  'True
         BackColor       =   &H00E0E000&
         BackStyle       =   0  'Transparent
         Caption         =   "Leave textboxes blank for default/original pictures."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   180
         Left            =   120
         TabIndex        =   27
         Top             =   240
         Width           =   3195
      End
   End
End
Attribute VB_Name = "frmNDStation"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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



' Uses the following component to have controls that are compatible with XP styles:
' Microsoft Windows Common Controls 5.0 (SP2)

' I use PE Explorer to add in a style manifest after compiling,
' and UPX to decrease executable size.



Option Explicit

Private Type tagInitCommonControlsEx
   lngSize As Long
   lngICC As Long
End Type

Private Declare Function InitCommonControlsEx Lib "comctl32.dll" _
   (iccex As tagInitCommonControlsEx) As Boolean
Private Const ICC_USEREX_CLASSES = &H200

Dim binDirectory As String

Private Function isFileType(filename As String, extension As String) As Boolean
    On Error Resume Next
    isFileType = False
    If LCase(Right(filename, Len(extension) + 1)) = "." & extension Then isFileType = True
End Function

Private Sub cmdAbout_Click()
    Dim msgAnswer As VbMsgBoxResult
    
    msgAnswer = MsgBox("NDStation v1.3 beta" & vbNewLine & "By chuckstudios" & vbNewLine & vbNewLine & "Many thanks to cory1492 (GBAldr), Noda (EFSlib), dg10050 (various things)," & vbNewLine & "and of course, the beta testers." & vbNewLine & vbNewLine & "If you like this software, please donate by clicking Yes!", vbYesNo, "About NDStation")

    If msgAnswer = vbYes Then
        Call OpenURL("https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=chuckstudios%40gmail%2ecom&item_name=NDStation%20v1%2e3&buyer_credit_promo_code=&buyer_credit_product_category=&buyer_credit_shipping_method=&buyer_credit_user_address_change=&no_shipping=0&no_note=1&tax=0&currency_code=USD&lc=US&bn=PP%2dDonationsBF&charset=UTF%2d8")
    End If
    
End Sub

Private Sub cmdSplash_Click()

    Dim returnedValue As String
    returnedValue = OpenFileDialog("Common image types|*.bmp;*.gif;*.jpg;*.png|All files|*.*", , ReadIniValue(App.path & "\NDStation.ini", "Paths", "Splash"), OFN_FILEMUSTEXIST)
    
    If file_exists(returnedValue) Then
        txtSplash.Text = returnedValue
        WriteIniValue App.path & "\NDStation.ini", "Paths", "Splash", Left(returnedValue, Len(returnedValue) - Len(basename(returnedValue)))
    End If
    
End Sub

Private Sub Form_Initialize()
   On Error Resume Next
   Dim iccex As tagInitCommonControlsEx
   ' Ensure CC available:
   With iccex
       .lngSize = LenB(iccex)
       .lngICC = ICC_USEREX_CLASSES
   End With
   InitCommonControlsEx iccex
   On Error GoTo 0
End Sub

Private Sub cmdBorder_Click()
   
    Dim returnedValue As String
    returnedValue = OpenFileDialog("Common image types|*.bmp;*.gif;*.jpg;*.png|All files|*.*", , ReadIniValue(App.path & "\NDStation.ini", "Paths", "Border"), OFN_FILEMUSTEXIST)
    
    If file_exists(returnedValue) Then
        txtBorder.Text = returnedValue
        WriteIniValue App.path & "\NDStation.ini", "Paths", "Border", Left(returnedValue, Len(returnedValue) - Len(basename(returnedValue)))
    End If
    
End Sub

Private Sub cmdOutput_Click()
    txtOutput.Text = BrowseFolders(hWnd, "Select a Folder", BrowseForFolders, CSIDL_DESKTOP)
End Sub

Private Sub cmdIcon_Click()

    Dim returnedValue As String
    returnedValue = OpenFileDialog("Bitmap images|*.bmp|All files|*.*", , ReadIniValue(App.path & "\NDStation.ini", "Paths", "Icon"), OFN_FILEMUSTEXIST)
    
    If file_exists(returnedValue) Then
        txtIcon.Text = returnedValue
        WriteIniValue App.path & "\NDStation.ini", "Paths", "Icon", Left(returnedValue, Len(returnedValue) - Len(basename(returnedValue)))
    End If

End Sub

Private Sub cmdGBA_Click()

    Dim returnedValue As String
    returnedValue = OpenFileDialog("GBA ROMs|*.gba;*.bin|All files|*.*", , ReadIniValue(App.path & "\NDStation.ini", "Paths", "GBA"), OFN_FILEMUSTEXIST)
    If file_exists(returnedValue) Then
        WriteIniValue App.path & "\NDStation.ini", "Paths", "GBA", Left(returnedValue, Len(returnedValue) - Len(basename(returnedValue)))
        txtGBA.Text = returnedValue
        txtOutput.Text = Left(returnedValue, Len(returnedValue) - Len(basename(returnedValue)))
        txtTitle(0).Text = basename(returnedValue, ".gba")
        
        If filesize(returnedValue) > 16777216 Then
            MsgBox "This ROM is larger than 16MB. PSRAM will be disabled.", , "NDStation"
            chkPSRAM.Enabled = False
            chkPSRAM.Value = 0
        Else
            chkPSRAM.Enabled = True
            chkPSRAM.Value = 1
        End If
    End If
    
End Sub

Private Sub clearTemp()
    Call unlink(binDirectory & "\x.nds")
    Call unlink(binDirectory & "\border.bmp")
    Call unlink(binDirectory & "\border.img.bin")
    Call unlink(binDirectory & "\splash.bmp")
    Call unlink(binDirectory & "\splash.img.bin")
    Call unlink(binDirectory & "\icon.bmp")
    Call unlink(binDirectory & "\data\mode.txt")
    Call unlink(binDirectory & "\data\game.gba")
    Call unlink(binDirectory & "\data\game.gz")
    Call unlink(binDirectory & "\data\game.gba.gz")
    Call unlink(binDirectory & "\data\game")
    Call unlink(binDirectory & "\data\border.lz7")
    Call unlink(binDirectory & "\data\splash.lz7")
End Sub

Private Sub processGame(gbaFile As String, outputFolder As String, gameTitle As String, _
                    usePSRAM As Boolean, useCompression As Boolean, _
                    iconFile As String, borderFile As String, splashFile As String)
                    
    Dim output As String
    
    
    'Output file
    output = outputFolder & basename(gbaFile, ".gba") & ".nds"
    
    
    'Handle the scenario of the output file already existing
    If file_exists(output) Then Call unlink(output)
    
    
    'Changing working directory
    ChDrive Left(binDirectory, 2)
    ChDir binDirectory
    
    
    'GBA handling
    Call copy(gbaFile, binDirectory & "\data\game.gba")
    If useCompression Then
        Call ShellandWait(binDirectory & "\gzip.exe --best data\game.gba")
        Call rename(binDirectory & "\data\game.gba.gz", binDirectory & "\data\game.gz")
        Call unlink(binDirectory & "\data\game.gba")
    End If
    
    
    'Border handling
    Call copy(borderFile, binDirectory & "\border.bmp")
    Call ShellandWait(binDirectory & "\grit.exe border.bmp -gB16 -gT! -gzl -fh! -ftbin")
    Call rename(binDirectory & "\border.img.bin", binDirectory & "\data\border.lz7")
    
    
    'Splash handling
    Call copy(splashFile, binDirectory & "\splash.bmp")
    Call ShellandWait(binDirectory & "\grit.exe splash.bmp -gB16 -gT! -gzl -fh! -ftbin")
    Call rename(binDirectory & "\splash.img.bin", binDirectory & "\data\splash.lz7")
    
    
    'Icon handling
    Call copy(iconFile, binDirectory & "\icon.bmp")
    
    
    'Modefile handling
    Dim modefile As Integer
    modefile = fopen(binDirectory & "\data\mode.txt")
    If usePSRAM Then
        If useCompression Then
            Call fwrite(modefile, "PC")
        Else
            Call fwrite(modefile, "PU")
        End If
    Else
        If useCompression Then
            Call fwrite(modefile, "NC")
        Else
            Call fwrite(modefile, "NU")
        End If
    End If
    Call fclose(modefile)
    
    
    'Compiling the NDS file
    Call ShellandWait(binDirectory & "\ndstool.exe -c x.nds -7 7.bin -9 9.bin -d data -g ""NDST"" ""13"" ""NDStation"" -b icon.bmp """ & gameTitle & """")
    Call EFS_patch(binDirectory & "\x.nds")
    
    
    'Moving the NDS to its final destination
    Call rename(binDirectory & "\x.nds", output)
    
    
    'Deleting the temporary files
    Call clearTemp
   
    
End Sub

Private Sub Form_Load()
    binDirectory = App.path & "\bin"
    Call clearTemp
End Sub


Private Sub cmdAdd_Click()

    If file_exists(txtGBA.Text) Then
        Dim rowNumber As Integer
        rowNumber = lvwBatch.ListItems.Count + 1
        
        lvwBatch.ListItems.Add rowNumber, , txtGBA.Text
        lvwBatch.ListItems(rowNumber).SubItems(1) = txtOutput.Text
        
        If Trim(txtTitle(0).Text) = vbNullString Then
            lvwBatch.ListItems(rowNumber).SubItems(2) = "NDStation"
        ElseIf Trim(txtTitle(1).Text) = vbNullString Then
            lvwBatch.ListItems(rowNumber).SubItems(2) = txtTitle(0).Text
        ElseIf Trim(txtTitle(2).Text) = vbNullString Then
            lvwBatch.ListItems(rowNumber).SubItems(2) = txtTitle(0).Text & ";" & txtTitle(1).Text
        Else
            lvwBatch.ListItems(rowNumber).SubItems(2) = txtTitle(0).Text & ";" & txtTitle(1).Text & ";" & txtTitle(2).Text
        End If
        
        lvwBatch.ListItems(rowNumber).SubItems(3) = chkPSRAM.Value
        lvwBatch.ListItems(rowNumber).SubItems(4) = chkCompression.Value
        
        If file_exists(txtIcon.Text) Then
            lvwBatch.ListItems(rowNumber).SubItems(5) = txtIcon.Text
        Else
            lvwBatch.ListItems(rowNumber).SubItems(5) = App.path & "\gfx\icon.bmp"
        End If
        
        If file_exists(txtBorder.Text) Then
            lvwBatch.ListItems(rowNumber).SubItems(6) = txtBorder.Text
        Else
            lvwBatch.ListItems(rowNumber).SubItems(6) = App.path & "\gfx\border.bmp"
        End If
    
        If file_exists(txtSplash.Text) Then
            lvwBatch.ListItems(rowNumber).SubItems(7) = txtSplash.Text
        Else
            lvwBatch.ListItems(rowNumber).SubItems(7) = App.path & "\gfx\splash.bmp"
        End If
    End If
    
End Sub

Private Sub cmdDelete_Click()
    On Error Resume Next
    lvwBatch.ListItems.Remove lvwBatch.SelectedItem.Index
End Sub

Private Sub cmdClear_Click()
    Dim I As Integer
    For I = 1 To lvwBatch.ListItems.Count
        lvwBatch.ListItems.Remove 1
    Next
End Sub

Private Sub cmdRun_Click()

    'These comments are dedicated to the memory of Dylan Garrett

    Dim I As Integer, progressOriginal As Integer
    
    'Remember how many items were in the ListView at the start
    progressOriginal = lvwBatch.ListItems.Count
    
    If progressOriginal > 0 Then
    
        'Set i equal to the number of items in the ListView
        For I = lvwBatch.ListItems.Count To 1 Step -1
            'Make the progress bar update... Current amount of items divided by original amount, all multiplied by 100
            pbrProgress.Value = 100 - ((I / progressOriginal) * 100)
            'Process the elements of row i in the ListView
            Call processGame(lvwBatch.ListItems(I).Text, lvwBatch.ListItems(I).SubItems(1), lvwBatch.ListItems(I).SubItems(2), lvwBatch.ListItems(I).SubItems(3), lvwBatch.ListItems(I).SubItems(4), lvwBatch.ListItems(I).SubItems(5), lvwBatch.ListItems(I).SubItems(6), lvwBatch.ListItems(I).SubItems(7))
            'Delete row i
            lvwBatch.ListItems.Remove (I)
            'Subtract 1 from i and repeat until i = 1 at this step
        Next
        
        pbrProgress.Value = 100
        MsgBox "Conversion complete!", , "NDStation"
        pbrProgress.Value = 0
    End If
End Sub

Private Sub txtGBA_OLEDragDrop(data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If isFileType(data.Files(1), "gba") Or isFileType(data.Files(1), "bin") Then
        txtGBA.Text = data.Files(1)
        txtOutput.Text = Left(data.Files(1), Len(data.Files(1)) - Len(basename(data.Files(1))))
        txtTitle(0).Text = basename(data.Files(1), ".gba")
        If filesize(data.Files(1)) > 16777216 Then
            MsgBox "This ROM is larger than 16MB. PSRAM will be disabled.", , "NDStation"
            chkPSRAM.Enabled = False
            chkPSRAM.Value = 0
        Else
            chkPSRAM.Enabled = True
            chkPSRAM.Value = 1
        End If
    End If
End Sub

Private Sub txtIcon_OLEDragDrop(data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If isFileType(data.Files(1), "bmp") Then txtIcon.Text = data.Files(1)
End Sub

Private Sub txtBorder_OLEDragDrop(data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If isFileType(data.Files(1), "bmp") Or isFileType(data.Files(1), "gif") Or isFileType(data.Files(1), "jpg") Or isFileType(data.Files(1), "png") Then txtBorder.Text = data.Files(1)
End Sub

Private Sub txtOutput_OLEDragDrop(data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If (GetAttr(data.Files(1)) And vbDirectory) = vbDirectory Then txtOutput.Text = data.Files(1) & "\"
End Sub

Private Sub txtSplash_OLEDragDrop(data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If isFileType(data.Files(1), "bmp") Or isFileType(data.Files(1), "gif") Or isFileType(data.Files(1), "jpg") Or isFileType(data.Files(1), "png") Then txtSplash.Text = data.Files(1)
End Sub
