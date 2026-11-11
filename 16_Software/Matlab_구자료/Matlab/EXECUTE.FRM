VERSION 4.00
Begin VB.Form frmExecute 
   Caption         =   "Command to Execute"
   ClientHeight    =   1410
   ClientLeft      =   1185
   ClientTop       =   3885
   ClientWidth     =   6240
   BeginProperty Font 
      name            =   "MS Sans Serif"
      charset         =   1
      weight          =   700
      size            =   8.25
      underline       =   0   'False
      italic          =   0   'False
      strikethrough   =   0   'False
   EndProperty
   Height          =   1815
   Left            =   1125
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   ScaleHeight     =   1410
   ScaleWidth      =   6240
   Top             =   3540
   Width           =   6360
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   495
      Left            =   4920
      TabIndex        =   2
      Top             =   720
      Width           =   1095
   End
   Begin VB.ComboBox cboExecuteString 
      BeginProperty Font 
         name            =   "MS Sans Serif"
         charset         =   1
         weight          =   400
         size            =   8.25
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   300
      Left            =   120
      TabIndex        =   1
      Top             =   240
      Width           =   4695
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Enabled         =   0   'False
      Height          =   495
      Left            =   4920
      TabIndex        =   0
      Top             =   120
      Width           =   1095
   End
End
Attribute VB_Name = "frmExecute"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Private Sub cboExecuteString_Change()
    cmdOK.Enabled = (LenB(cboExecuteString.Text) > 0)
End Sub

Private Sub cboExecuteString_Click()
    cmdOK.Enabled = (LenB(cboExecuteString.Text) > 0)
End Sub

Private Sub cmdCancel_Click()
    Unload frmExecute
End Sub

Private Sub cmdOK_Click()
On Error Resume Next
    frmMain.txtData.LinkExecute cboExecuteString.Text
    frmMain.picData.LinkExecute cboExecuteString.Text
    Unload frmExecute
End Sub

