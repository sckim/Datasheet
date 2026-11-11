VERSION 4.00
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "DDE Experimenter"
   ClientHeight    =   5400
   ClientLeft      =   960
   ClientTop       =   1440
   ClientWidth     =   7290
   BeginProperty Font 
      name            =   "MS Sans Serif"
      charset         =   1
      weight          =   700
      size            =   8.25
      underline       =   0   'False
      italic          =   0   'False
      strikethrough   =   0   'False
   EndProperty
   FontTransparent =   0   'False
   Height          =   5805
   Left            =   900
   LinkMode        =   1  'Source
   LinkTopic       =   "System"
   ScaleHeight     =   5400
   ScaleWidth      =   7290
   Top             =   1095
   Width           =   7410
   Begin VB.Frame Frames 
      Caption         =   "Destination Data"
      Height          =   3015
      Index           =   2
      Left            =   120
      TabIndex        =   21
      Top             =   2280
      Width           =   6015
      Begin VB.TextBox txtData 
         Height          =   2160
         Left            =   240
         MultiLine       =   -1  'True
         ScrollBars      =   3  'Both
         TabIndex        =   22
         Text            =   "MAIN.frx":0000
         Top             =   720
         Width           =   5760
      End
      Begin VB.OptionButton optDataType 
         Caption         =   "Graphics"
         Height          =   255
         Index           =   1
         Left            =   1440
         TabIndex        =   14
         Top             =   360
         Width           =   1815
      End
      Begin VB.OptionButton optDataType 
         Caption         =   "Text"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   13
         Top             =   360
         Value           =   -1  'True
         Width           =   1095
      End
      Begin VB.PictureBox picData 
         AutoRedraw      =   -1  'True
         DrawWidth       =   2
         Height          =   2160
         Left            =   240
         ScaleHeight     =   2130
         ScaleWidth      =   5730
         TabIndex        =   23
         Top             =   720
         Visible         =   0   'False
         Width           =   5760
      End
   End
   Begin VB.Frame Frames 
      Caption         =   "Source Properties"
      Height          =   1440
      Index           =   1
      Left            =   5040
      TabIndex        =   20
      Top             =   735
      Width           =   1920
      Begin VB.TextBox txtSourceTopic 
         Height          =   285
         Left            =   120
         TabIndex        =   17
         Text            =   "System"
         Top             =   960
         Width           =   1695
      End
      Begin VB.CheckBox chkSourceMode 
         Caption         =   "&Source Enabled"
         Height          =   240
         Left            =   105
         TabIndex        =   15
         Top             =   360
         Value           =   1  'Checked
         Width           =   1680
      End
      Begin VB.Label Labels 
         Caption         =   "Source &Link Topic"
         Height          =   240
         Index           =   3
         Left            =   120
         TabIndex        =   16
         Top             =   720
         Width           =   1680
      End
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "E&xit"
      Height          =   480
      Left            =   5040
      TabIndex        =   18
      Top             =   105
      Width           =   1920
   End
   Begin VB.Frame Frames 
      Caption         =   "Destination Properties"
      Height          =   2160
      Index           =   0
      Left            =   120
      TabIndex        =   19
      Top             =   0
      Width           =   4620
      Begin VB.ComboBox cboAppName 
         Height          =   300
         Left            =   1200
         TabIndex        =   1
         Text            =   "ProgMan"
         Top             =   360
         Width           =   1650
      End
      Begin VB.ComboBox cboTopic 
         Height          =   300
         Left            =   720
         TabIndex        =   3
         Text            =   "ProgMan"
         Top             =   720
         Width           =   2130
      End
      Begin VB.ComboBox cboItem 
         Height          =   300
         Left            =   720
         TabIndex        =   5
         Top             =   1080
         Width           =   2130
      End
      Begin VB.OptionButton optLinkMode 
         Caption         =   "&Notify"
         Height          =   240
         Index           =   3
         Left            =   3045
         TabIndex        =   8
         Top             =   1200
         Width           =   960
      End
      Begin VB.CommandButton cmdExecute 
         Caption         =   "&Execute"
         Enabled         =   0   'False
         Height          =   480
         Left            =   3045
         TabIndex        =   12
         Top             =   1560
         Width           =   1380
      End
      Begin VB.CommandButton cmdPoke 
         Caption         =   "&Poke"
         Enabled         =   0   'False
         Height          =   480
         Left            =   1575
         TabIndex        =   11
         Top             =   1560
         Width           =   1305
      End
      Begin VB.CommandButton cmdRequest 
         Caption         =   "&Request"
         Enabled         =   0   'False
         Height          =   480
         Left            =   240
         TabIndex        =   10
         Top             =   1560
         Width           =   1245
      End
      Begin VB.OptionButton optLinkMode 
         Caption         =   "&Manual"
         Height          =   240
         Index           =   2
         Left            =   3045
         TabIndex        =   7
         Top             =   960
         Value           =   -1  'True
         Width           =   960
      End
      Begin VB.OptionButton optLinkMode 
         Caption         =   "A&utomatic"
         Height          =   240
         Index           =   1
         Left            =   3045
         TabIndex        =   6
         Top             =   735
         Width           =   1200
      End
      Begin VB.CommandButton cmdConnect 
         Caption         =   "&Connect"
         Height          =   480
         Left            =   3045
         TabIndex        =   9
         Top             =   240
         Width           =   1320
      End
      Begin VB.Label Labels 
         Caption         =   "Item"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   4
         Top             =   1080
         Width           =   615
      End
      Begin VB.Label Labels 
         Caption         =   "&Topic"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   2
         Top             =   720
         Width           =   615
      End
      Begin VB.Label Labels 
         Caption         =   "&Application"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   0
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.Label lblSysLink 
      Height          =   375
      Left            =   4440
      TabIndex        =   25
      Top             =   5400
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label Topics 
      Height          =   375
      Left            =   120
      TabIndex        =   24
      Top             =   5400
      Visible         =   0   'False
      Width           =   2175
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit
Option Compare Text     ' Perform case-insensitive string comparisons.
Dim TopicChangeFlag As Integer, appChangeFlag As Integer, Connected As Integer
Dim NotifyFlag As Integer

Const conDestText = 0, conDestPic = 1
Const conMenuCopy = 0, conMenuPaste = 1, conMenuPasteLink = 2

Private Sub cboAppName_Click()
    If Connected Then cmdConnect.Value = True
    FillTopicList
End Sub

Private Sub cboAppName_LostFocus()
    If appChangeFlag Then
        appChangeFlag = False
        If Connected Then cmdConnect.Value = True
        FillTopicList
    End If
End Sub

Private Sub cboItem_Change()
On Error Resume Next
    picData.LinkItem = cboItem.Text
    txtData.LinkItem = cboItem.Text
End Sub

Private Sub cboItem_Click()
    picData.LinkItem = cboItem.Text
    txtData.LinkItem = cboItem.Text
End Sub

Private Sub cboTopic_Change()
    TopicChangeFlag = True
    CheckForSystemTopic
End Sub

Private Sub cboTopic_Click()
    If Connected Then cmdConnect.Value = True
    CheckForSystemTopic
End Sub

Private Sub cboTopic_LostFocus()
    If TopicChangeFlag Then
        TopicChangeFlag = False
        If Connected Then cmdConnect.Value = True
        CheckForSystemTopic
    End If
End Sub

Private Sub CheckForSystemTopic()
Dim i
    If cboTopic.Text = "SYSTEM" Or cboTopic.Text = "PROGMAN" Then
        FillSysItems
        optLinkMode(1).Enabled = False
        optLinkMode(3).Enabled = False
        optLinkMode(2).Value = True
    Else
        For i = 1 To 3
            optLinkMode(i).Enabled = True
        Next
        cboItem.Clear
        cboItem.Text = ""
        If cboAppName.Text = "Matlab" Then
            cboItem.AddItem "EngEvalString"
            cboItem.AddItem "EngStringResult"
            cboItem.AddItem "EngFigureResult"
            cboItem.Text = "EngEvalString"
            cboItem.Refresh
        End If
    End If
End Sub

Private Sub chkSourceMode_Click()
    LinkMode = Abs(chkSourceMode.Value)
    txtSourceTopic.Enabled = chkSourceMode.Value
End Sub

Private Sub cmdConnect_Click()
Dim clientLinkMode As Integer
    If Not Connected Then
        For clientLinkMode = 1 To 3
            If optLinkMode(clientLinkMode).Value Then Exit For
        Next
        picData.Picture = LoadPicture()
        txtData.Text = ""
        Select Case MakeConnection(clientLinkMode)
            Case 0
                ConnectState True
            Case errNoAppResponded
                If MsgBox(cboAppName.Text & " doesn't seem to be running. Do you want to start it?", vbYesNo + vbQuestion) = vbYes Then
                    If StartApp((cboAppName.Text)) Then
                        Select Case MakeConnection(clientLinkMode)
                            Case 0
                                ConnectState True
                            Case errNoAppResponded
                                MsgBox "Sorry, still can't connect."
                        End Select
                    End If
                End If
        End Select
    Else
        Disconnect txtData
        Disconnect picData
        ConnectState False
    End If
End Sub

Private Sub CmdExecute_Click()
    ' Empty the combo box on Execute form.
    ' (This also implictly loads the form if it was unloaded).
    frmExecute.cboExecuteString.Clear

    frmExecute.Show vbModal

End Sub

Private Sub cmdExit_Click()
    Unload frmMain
    End
End Sub

Private Sub cmdPoke_Click()
On Error Resume Next
    txtData.LinkPoke
    If Err Then MsgBox Error
End Sub

Private Sub cmdRequest_Click()
On Error Resume Next
    txtData.LinkRequest
    picData.LinkRequest
    NotifyFlag = False
End Sub

Private Sub ConnectState(State As Integer)
Dim i As Integer

    If State Then
        cmdConnect.Caption = "Disconnect"
    Else
        cmdConnect.Caption = "Connect"
    End If
        
    Connected = State
    cmdRequest.Enabled = State
    cmdPoke.Enabled = (optLinkMode(vbLinkManual).Value And State)
    cmdExecute.Enabled = State

    ' cboAppName.Enabled = Not State
    ' cboTopic.Enabled = Not State
End Sub

Private Function CreateLink(Ctl As Control, appname As String, topic As String, item As String, LinkType As Integer) As Integer
On Error Resume Next
    Ctl.LinkMode = vbLinkNone
    Ctl.LinkTopic = appname & "|" & topic
    Ctl.LinkItem = item
    Ctl.LinkMode = LinkType
    CreateLink = Err
    If Err = 0 And LinkType <> vbLinkAutomatic Then
        Ctl.LinkRequest
    End If
End Function

Private Sub Disconnect(Ctl As Control)
Dim tempTimeOutVal
On Error Resume Next    ' Disconnecting with ProgMan causes a timeout error; just continue.
    tempTimeOutVal = Ctl.LinkTimeout
    Ctl.LinkTimeout = 1
    Ctl.LinkMode = vbLinkNone
    Ctl.LinkTimeout = tempTimeOutVal
End Sub

Private Sub FillList(cbo As Control, lbl As Control)
Dim i As Integer, lasti As Integer
    Do
        i = i + 1
        lasti = i
        i = InStr(lasti, lbl.Caption, Chr(9))
        If i = 0 Then
            cbo.AddItem Mid(lbl.Caption, lasti)
            Exit Do
        Else
            cbo.AddItem Mid(lbl.Caption, lasti, i - lasti)
        End If
    Loop
End Sub

Private Sub FillSysItems()
    cboItem.Clear
    Screen.MousePointer = vbHourglass
    lblSysLink.LinkMode = vbLinkNone
    lblSysLink.LinkTopic = cboAppName.Text & "|" & "System"
    lblSysLink.LinkItem = "SysItems"
    On Error Resume Next
    lblSysLink.LinkMode = vbLinkManual
    If Err = 0 Then
        lblSysLink.LinkRequest
        FillList cboItem, lblSysLink
        cboItem.Text = "SysItems"
    End If
    cboItem.Refresh
    Screen.MousePointer = vbDefault
End Sub

Private Sub FillTopicList()
    cboTopic.Clear
    cboTopic.Text = ""
    If cboAppName.Text = "Matlab" Then
        cboTopic.Text = "Engine"
    Else
        Screen.MousePointer = vbHourglass
        lblSysLink.LinkMode = vbLinkNone
        lblSysLink.LinkTopic = cboAppName.Text & "|" & "System"
        lblSysLink.LinkItem = "Topics"
        On Error Resume Next
        lblSysLink.LinkMode = vbLinkManual
        If Err Then
            cboTopic.AddItem "System"
        Else
            lblSysLink.LinkRequest
            FillList cboTopic, lblSysLink
            cboTopic.Text = "System"
        End If
        Screen.MousePointer = vbDefault
    End If
    cboTopic.Refresh
End Sub

Private Sub Form_Load()
    cboAppName.AddItem "Matlab"
    cboAppName.Text = "Matlab"


    LinkTopic = txtSourceTopic.Text
    Topics.Caption = "Topics" & Chr(9) & "picData" & Chr(9) & "txtData" & Chr(13) & Chr(10)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Disconnect txtData
    Disconnect picData
End Sub

Private Function MakeConnection(clientLinkMode As Integer) As Integer
Dim ConnectTxt As Integer, ConnectPic As Integer
    ConnectPic = CreateLink(picData, (cboAppName.Text), (cboTopic.Text), (cboItem.Text), clientLinkMode)
    ConnectTxt = CreateLink(txtData, (cboAppName.Text), (cboTopic.Text), (cboItem.Text), clientLinkMode)
    
    If ConnectPic = errNoAppResponded And ConnectTxt = errNoAppResponded Then
        MakeConnection = errNoAppResponded
    ElseIf ConnectTxt = 0 Then
        MakeConnection = 0
        optDataType(conDestText).Value = True
    ElseIf ConnectPic = 0 Then
        MakeConnection = 0
        optDataType(conDestPic).Value = True
    Else
        MakeConnection = ConnectPic
    End If
End Function

Private Sub optDataType_Click(Index As Integer)
    If Index = conDestText Then
        txtData.Visible = True
        picData.Visible = False
    ElseIf Index = conDestPic Then
        txtData.Visible = False
        picData.Visible = True
    End If
End Sub

Private Sub optLinkMode_Click(Index As Integer)
    If Connected Then
        cmdConnect.Value = True
        cmdConnect.Value = True
    End If
End Sub

Private Sub picData_LinkClose()
    ConnectState False
End Sub

Private Sub picData_LinkNotify()
    If Not NotifyFlag Then
        MsgBox "New data is available from the DDE Source.  Choose Request to update."
        NotifyFlag = True
    End If
End Sub

Private Sub picData_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button And 1 Then
        PSet (X, Y)
    Else
        picData.ForeColor = QBColor(Rnd * 16)
    End If
End Sub

Private Sub picData_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button And 1 Then picData.Line -(X, Y)
End Sub

Private Sub picData_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button And 1 Then
        picData.LinkSend
    End If
End Sub

Private Function StartApp(appname As String) As Integer
On Error Resume Next
    StartApp = (Shell(appname) > 31)
    If Err Then MsgBox "Couldn't start " & appname
    StartApp = 0
End Function

Private Sub txtData_LinkClose()
    ConnectState False
End Sub

Private Sub txtData_LinkNotify()
    If Not NotifyFlag Then
        MsgBox "New data is available from the DDE Source.  Choose Request to update."
        NotifyFlag = True
    End If
End Sub

Private Sub txtSourceTopic_Change()
    LinkTopic = txtSourceTopic.Text
End Sub

