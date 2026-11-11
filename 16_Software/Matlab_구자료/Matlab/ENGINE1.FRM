VERSION 4.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   8550
   ClientLeft      =   5025
   ClientTop       =   1515
   ClientWidth     =   5760
   Height          =   8955
   Left            =   4965
   LinkTopic       =   "Form1"
   ScaleHeight     =   8550
   ScaleWidth      =   5760
   Top             =   1170
   Width           =   5880
   Begin VB.CommandButton cmdRequest 
      Caption         =   "Request"
      Height          =   375
      Left            =   4440
      TabIndex        =   4
      Top             =   5640
      Width           =   1095
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   4440
      TabIndex        =   3
      Top             =   5040
      Width           =   1095
   End
   Begin VB.PictureBox PicData 
      Height          =   3135
      Left            =   360
      ScaleHeight     =   3105
      ScaleMode       =   0  'User
      ScaleWidth      =   2210
      TabIndex        =   2
      Top             =   4560
      Width           =   3615
   End
   Begin VB.TextBox TextOutput 
      Height          =   1815
      Left            =   360
      MultiLine       =   -1  'True
      TabIndex        =   1
      Top             =   2520
      Width           =   5055
   End
   Begin VB.TextBox TextInput 
      Height          =   1815
      Left            =   360
      TabIndex        =   0
      Top             =   480
      Width           =   5055
   End
End
Attribute VB_Name = "Form1"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Const NONE = 0
Const AUTOMATIC = 1
Const MANUAL = 2
Const Notify = 3

Private Sub cmdExit_Click()
    End
End Sub

Private Sub cmdRequest_Click()
        TextOutput.LinkRequest
        If Not StrComp(TextOutput.Text, "yes") Then
            PicData.LinkMode = NONE
            PicData.LinkTopic = "Matlab|Engine"
            PicData.LinkItem = "EngFigureResult"
            PicData.LinkMode = MANUAL
            PicData.LinkRequest
        Else
            TextOutput.LinkMode = NONE
            TextOutput.LinkTopic = "Matlab|Engine"
            TextOutput.LinkItem = "EngStringResult"
            TextOutput.LinkMode = MANUAL
            TextOutput.LinkRequest
        End If

End Sub

Private Sub Form_Load()
    On Error GoTo E1:
        'Clear link
        TextInput.LinkMode = NONE
        'Set up link with matlab server
        TextInput.LinkTopic = "Matlab|Engine"
        'Set link to EngEvalString server
        TextInput.LinkItem = "EngEvalString"
        'Set link to manual=2
        TextInput.LinkMode = MANUAL
    '
        PicData.LinkMode = NONE
        PicData.LinkTopic = "Matlab|Engine"
        PicData.LinkItem = "EngEvalString"
        PicData.LinkMode = MANUAL
         
        TextOutput.LinkMode = NONE
        TextOutput.LinkTopic = "Matlab|Engine"
        TextOutput.LinkItem = "EngFigureResult"
        TextOutput.LinkMode = MANUAL
        Exit Sub
E1:
    SaveErr% = Err
    GeneralErrors
    Resume Next
End Sub

Private Sub TextInput_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        TextInput.LinkExecute TextInput.Text
        PicData.LinkExecute TextInput.Text
    End If
End Sub

