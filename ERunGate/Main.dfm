object FrmMain: TFrmMain
  Left = 447
  Top = 290
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FrmMain'
  ClientHeight = 160
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object MemoLog: TMemo
    Left = 0
    Top = 137
    Width = 260
    Height = 1
    ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
    ScrollBars = ssHorizontal
    TabOrder = 0
    OnChange = MemoLogChange
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 258
    Height = 137
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object LbLack: TLabel
      Left = 4
      Top = 57
      Width = 18
      Height = 12
      Caption = '0/0'
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 0
      Width = 257
      Height = 73
      Caption = #32593#32476#27969#37327
      TabOrder = 0
      object LabelReviceMsgSize: TLabel
        Left = 12
        Top = 21
        Width = 30
        Height = 12
        Caption = #25509#25910':'
      end
      object LabelSendBlockSize: TLabel
        Left = 12
        Top = 37
        Width = 30
        Height = 12
        Caption = #21457#36865':'
      end
      object LabelLogonMsgSize: TLabel
        Left = 92
        Top = 21
        Width = 30
        Height = 12
        Caption = #30331#24405':'
      end
      object LabelPlayMsgSize: TLabel
        Left = 92
        Top = 37
        Width = 30
        Height = 12
        Caption = #26222#36890':'
      end
      object LabelDeCodeMsgSize: TLabel
        Left = 172
        Top = 21
        Width = 30
        Height = 12
        Caption = #35299#30721':'
      end
      object LabelProcessMsgSize: TLabel
        Left = 172
        Top = 37
        Width = 30
        Height = 12
        Caption = #32534#30721':'
      end
      object LabelBufferOfM2Size: TLabel
        Left = 12
        Top = 53
        Width = 66
        Height = 12
        Caption = #26381#21153#22120#36890#35759':'
      end
      object LabelSelfCheck: TLabel
        Left = 132
        Top = 53
        Width = 54
        Height = 12
        Caption = #36890#35759#33258#26816':'
      end
    end
    object GroupBoxProcessTime: TGroupBox
      Left = 1
      Top = 75
      Width = 257
      Height = 57
      Caption = #22788#29702#26102#38388
      TabOrder = 1
      object LabelSendTime: TLabel
        Left = 12
        Top = 32
        Width = 30
        Height = 12
        Caption = #21457#36865':'
      end
      object LabelReceTime: TLabel
        Left = 12
        Top = 16
        Width = 30
        Height = 12
        Caption = #25509#25910':'
      end
      object LabelLoop: TLabel
        Left = 188
        Top = 16
        Width = 48
        Height = 12
        Caption = #25968#25454#22788#29702
      end
      object LabelReviceLimitTime: TLabel
        Left = 76
        Top = 16
        Width = 78
        Height = 12
        Caption = #25509#25910#22788#29702#38480#21046':'
      end
      object LabelSendLimitTime: TLabel
        Left = 76
        Top = 32
        Width = 78
        Height = 12
        Caption = #21457#36865#22788#29702#38480#21046':'
      end
      object LabelLoopTime: TLabel
        Left = 188
        Top = 32
        Width = 48
        Height = 12
        Alignment = taCenter
        AutoSize = False
        Caption = '--------'
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 140
    Width = 258
    Height = 20
    Panels = <
      item
        Alignment = taCenter
        Text = '????'
        Width = 45
      end
      item
        Alignment = taCenter
        Text = '---]    [---'
        Width = 60
      end
      item
        Alignment = taCenter
        Text = '????'
        Width = 70
      end
      item
        Alignment = taCenter
        Text = '????'
        Width = 50
      end>
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 34
  end
  object SendTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = SendTimerTimer
    Left = 61
  end
  object ClientSocket: TClientSocket
    Active = False
    Address = '127.0.0.1'
    ClientType = ctNonBlocking
    Port = 50000
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 2
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 92
  end
  object DecodeTimer: TTimer
    Interval = 1
    OnTimer = DecodeTimerTimer
    Left = 154
  end
  object MainMenu: TMainMenu
    Left = 187
    object MENU_CONTROL: TMenuItem
      Caption = #25511#21046'(&C)'
      object MENU_CONTROL_START: TMenuItem
        Caption = #21551#21160#26381#21153'(&S)'
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = #20572#27490#26381#21153'(&T)'
        OnClick = MENU_CONTROL_STOPClick
      end
      object MENU_CONTROL_RECONNECT: TMenuItem
        Caption = #21047#26032#36830#25509'(&R)'
        OnClick = MENU_CONTROL_RECONNECTClick
      end
      object MENU_CONTROL_RELOADCONFIG: TMenuItem
        Caption = #37325#21152#36733#37197#32622'(&R)'
        OnClick = MENU_CONTROL_RELOADCONFIGClick
      end
      object MENU_CONTROL_CLEAELOG: TMenuItem
        Caption = #28165#38500#26085#24535'(&C)'
        OnClick = MENU_CONTROL_CLEAELOGClick
      end
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = #36864#20986'(&E)'
        OnClick = MENU_CONTROL_EXITClick
      end
    end
    object MENU_VIEW: TMenuItem
      Caption = #26597#30475'(&V)'
      object MENU_VIEW_LOGMSG: TMenuItem
        Caption = #26597#30475#26085#24535'(&L)'
        OnClick = MENU_VIEW_LOGMSGClick
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&O)'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = MENU_OPTION_GENERALClick
      end
      object MENU_OPTION_PERFORM: TMenuItem
        Caption = #24615#33021#35774#32622'(&P)'
        OnClick = MENU_OPTION_PERFORMClick
      end
      object MENU_OPTION_FILTERMSG: TMenuItem
        Caption = #28040#24687#36807#28388'(&C)'
        OnClick = MENU_OPTION_FILTERMSGClick
      end
      object MENU_OPTION_IPFILTER: TMenuItem
        Caption = #23433#20840#36807#28388'(&S)'
        OnClick = MENU_OPTION_IPFILTERClick
      end
      object K1: TMenuItem
        Caption = #21453#22806#25346#35774#32622'(&K)'
        OnClick = K1Click
      end
    end
    object N2: TMenuItem
      Caption = #20851#20110
      OnClick = N2Click
    end
  end
  object StartTimer: TTimer
    Interval = 200
    OnTimer = StartTimerTimer
    Left = 124
  end
  object PopupMenu: TPopupMenu
    Left = 208
    Top = 80
    object POPMENU_PORT: TMenuItem
      AutoHotkeys = maManual
      Caption = #31471#21475
    end
    object POPMENU_CONNSTAT: TMenuItem
      AutoHotkeys = maManual
      Caption = #36830#25509#29366#24577
    end
    object POPMENU_CONNCOUNT: TMenuItem
      AutoHotkeys = maManual
      Caption = #36830#25509#25968
    end
    object POPMENU_CHECKTICK: TMenuItem
      AutoHotkeys = maManual
      Caption = #36890#35759#36229#26102
    end
    object N1: TMenuItem
      Caption = '--------------------'
    end
    object POPMENU_OPEN: TMenuItem
      Caption = #25171#24320#31383#21475'(&O)'
    end
    object POPMENU_START: TMenuItem
      Caption = #21551#21160#26381#21153'(&S)'
      OnClick = MENU_CONTROL_STARTClick
    end
    object POPMENU_CONNSTOP: TMenuItem
      Caption = #20572#27490#26381#21153'(&T)'
      OnClick = MENU_CONTROL_STOPClick
    end
    object POPMENU_RECONN: TMenuItem
      Caption = #21047#26032#36830#25509'(&R)'
      OnClick = MENU_CONTROL_RECONNECTClick
    end
    object POPMENU_EXIT: TMenuItem
      Caption = #36864#20986'(&X)'
      OnClick = MENU_CONTROL_EXITClick
    end
  end
end
