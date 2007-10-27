VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmProcessing 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Now Processing..."
   ClientHeight    =   2415
   ClientLeft      =   2760
   ClientTop       =   3630
   ClientWidth     =   4695
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2415
   ScaleWidth      =   4695
   ShowInTaskbar   =   0   'False
   Begin VB.Frame fraFile 
      Caption         =   "File"
      Height          =   795
      Left            =   60
      TabIndex        =   3
      Top             =   60
      Width           =   4575
      Begin VB.Label lblFile 
         AutoSize        =   -1  'True
         Caption         =   "(null)"
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
         Left            =   180
         TabIndex        =   5
         Top             =   480
         Width           =   360
      End
      Begin VB.Label lblCurrentFile 
         AutoSize        =   -1  'True
         Caption         =   "Current file:"
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
         Left            =   180
         TabIndex        =   4
         Top             =   240
         Width           =   840
      End
   End
   Begin VB.Frame fraProgress 
      Caption         =   "Progress"
      Height          =   1395
      Left            =   60
      TabIndex        =   0
      Top             =   960
      Width           =   4575
      Begin ComctlLib.ProgressBar pbrTotal 
         Height          =   255
         Left            =   180
         TabIndex        =   1
         Top             =   1020
         Width           =   4275
         _ExtentX        =   7541
         _ExtentY        =   450
         _Version        =   327682
         Appearance      =   1
      End
      Begin VB.Label lblStep 
         AutoSize        =   -1  'True
         Caption         =   "(null)"
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
         Left            =   180
         TabIndex        =   7
         Top             =   480
         Width           =   360
      End
      Begin VB.Label lblCurrent 
         AutoSize        =   -1  'True
         Caption         =   "Current step:"
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
         Left            =   180
         TabIndex        =   6
         Top             =   240
         Width           =   945
      End
      Begin VB.Label lblTotal 
         AutoSize        =   -1  'True
         Caption         =   "Total:"
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
         Left            =   180
         TabIndex        =   2
         Top             =   780
         Width           =   390
      End
   End
End
Attribute VB_Name = "frmProcessing"
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



Option Explicit

Dim binDirectory As String

Private Sub Form_Activate()
    Dim i As Integer, progressOriginal As Integer
    'Remember how many items were in the ListView at the start
    progressOriginal = frmNDStation.lvwBatch.ListItems.Count
    'Set i equal to the number of items in the ListView
    For i = frmNDStation.lvwBatch.ListItems.Count To 1 Step -1
        'Make the progress bar update... Current amount of items divided by original amount, all multiplied by 100
        pbrTotal.Value = 100 - ((i / progressOriginal) * 100)
        'Update game name on processing form
        lblFile.Caption = basename(frmNDStation.lvwBatch.ListItems(i).Text)
        'Process the elements of row i in the ListView
        Call processGame(frmNDStation.lvwBatch.ListItems(i).Text, frmNDStation.lvwBatch.ListItems(i).SubItems(1), frmNDStation.lvwBatch.ListItems(i).SubItems(2), frmNDStation.lvwBatch.ListItems(i).SubItems(3), frmNDStation.lvwBatch.ListItems(i).SubItems(4), frmNDStation.lvwBatch.ListItems(i).SubItems(5), frmNDStation.lvwBatch.ListItems(i).SubItems(6), frmNDStation.lvwBatch.ListItems(i).SubItems(7))
        'Delete row i
        frmNDStation.lvwBatch.ListItems.Remove (i)
        'Subtract 1 from i and repeat until i = 1 at this step
    Next
    pbrTotal.Value = 100
    MsgBox "Conversion complete!"
    pbrTotal.Value = 0
    frmProcessing.Hide
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    Cancel = 1
End Sub

'The processing code
Private Sub processGame(gbaFile As String, outputFolder As String, gameTitle As String, _
                    usePSRAM As Boolean, useCompression As Boolean, _
                    iconFile As String, borderFile As String, splashFile As String)

    Dim output As String
    binDirectory = Environ("temp") & "\NDStation"
    
    'Output file
    output = outputFolder & basename(gbaFile, ".gba") & ".nds"
    
    'Handle the scenario of the output file already existing
    If file_exists(output) Then Call unlink(output)
    
    'Changing working directory
    ChDrive Left(binDirectory, 2)
    ChDir binDirectory
    
    'GBA ROM handling
    If useCompression Then
        lblStep.Caption = "Compressing ROM..."
        Call compressNSAR(gbaFile, binDirectory & "\data\game.nsar")
    Else
        lblStep.Caption = "Copying ROM to temp directory..."
        Call copy(gbaFile, binDirectory & "\data\game.gba")
    End If
    
    'Border handling
    If borderFile <> "0" Then
        lblStep.Caption = "Converting border image..."
        Call copy(borderFile, binDirectory & "\border.bmp")
        Call ShellandWait(binDirectory & "\grit.exe border.bmp -gB16 -gT! -gzl -fh! -ftbin")
        Call rename(binDirectory & "\border.img.bin", binDirectory & "\data\border.lz7")
    End If
    
    'Splash handling
    If splashFile <> "0" Then
        lblStep.Caption = "Converting splash image..."
        Call copy(splashFile, binDirectory & "\splash.bmp")
        Call ShellandWait(binDirectory & "\grit.exe splash.bmp -gB16 -gT! -gzl -fh! -ftbin")
        Call rename(binDirectory & "\splash.img.bin", binDirectory & "\data\splash.lz7")
    End If
    
    'Icon handling
    Call copy(iconFile, binDirectory & "\icon.bmp")
    
    'Modefile handling
    lblStep.Caption = "Creating configuration file..."
    Dim hasBorder As Boolean, hasSplash As Boolean
    If borderFile = "0" Then hasBorder = False Else hasBorder = True
    If splashFile = "0" Then hasSplash = False Else hasSplash = True
    Call makeConfig(useCompression, usePSRAM, hasSplash, hasBorder)
    
    'Compiling the NDS file
    lblStep.Caption = "Compiling NDS file..."
    Call ShellandWait(binDirectory & "\ndstool.exe -c x.nds -7 7.bin -9 9.bin -d data -g ""NDST"" ""13"" ""NDStation"" -b icon.bmp """ & gameTitle & """")
    Call EFS_patch(binDirectory & "\x.nds")
    
    'Moving the NDS to its final destination
    lblStep.Caption = "Copying to destination..."
    Call rename(binDirectory & "\x.nds", output)
    
    'Deleting the temporary files
    lblStep.Caption = "Cleaning up temporary files..."
    Call clearTemp(binDirectory)
   
    lblStep.Caption = "Done!"
End Sub


Private Sub makeConfig(usesNSAR As Boolean, usesPSRAM As Boolean, _
                            hasSplash As Boolean, hasBorder As Boolean)

    Call WriteIniValue(binDirectory & "\data\config.ini", "Mode", "NSAR", Bool2INI(usesNSAR))
    Call WriteIniValue(binDirectory & "\data\config.ini", "Mode", "PSRAM", Bool2INI(usesPSRAM))
    
    Call WriteIniValue(binDirectory & "\data\config.ini", "Graphics", "Border", Bool2INI(hasBorder))
    Call WriteIniValue(binDirectory & "\data\config.ini", "Graphics", "Splash", Bool2INI(hasSplash))

End Sub

Private Function Bool2INI(item As Boolean) As String
    Bool2INI = "0"
    If item = True Then Bool2INI = "1"
End Function
