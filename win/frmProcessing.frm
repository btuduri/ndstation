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

Option Explicit

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    Cancel = 1
End Sub
