object FrmMain: TFrmMain
  Left = 511
  Top = 159
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = ' '
  ClientHeight = 367
  ClientWidth = 451
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
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 287
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 0
      Top = 206
      Width = 451
      Height = 81
      Align = alBottom
      TabOrder = 0
      object MemStatus: TLabel
        Left = 385
        Top = 23
        Width = 60
        Height = 12
        Alignment = taRightJustify
        Caption = #20869#23384':000MB'
      end
      object LbUserCount: TLabel
        Left = 228
        Top = 41
        Width = 216
        Height = 12
        Alignment = taRightJustify
        Caption = '('#21047#24618':0000000) '#29609#23478':000/000[000/000]'
      end
      object LbTimeCount: TLabel
        Left = 394
        Top = 57
        Width = 48
        Height = 12
        Alignment = taRightJustify
        Caption = '0.0000'#22825
      end
      object LbRunTime: TLabel
        Left = 282
        Top = 10
        Width = 162
        Height = 12
        Caption = #24341#25806#36816#34892':(00:00:00) [M] [S]'
      end
      object LbRunSocketTime: TLabel
        Left = 288
        Top = 56
        Width = 6
        Height = 12
      end
      object Lbcheck: TLabel
        Left = 312
        Top = 56
        Width = 6
        Height = 12
      end
      object Label5: TLabel
        Left = 8
        Top = 41
        Width = 217
        Height = 12
        AutoSize = False
        Caption = #38081#34880#39764#29579',111/111 - '#38081#34880#39764#29579'/111/111    '
      end
      object Label20: TLabel
        Left = 8
        Top = 57
        Width = 270
        Height = 12
        Caption = #21047#26032#24618#29289'(0/0/0) '#22788#29702#24618#29289'(0/0/0) '#35282#33394#22788#29702'(0/0)'
      end
      object Label2: TLabel
        Left = 8
        Top = 25
        Width = 294
        Height = 12
        Caption = #20154#29289'(0/0) '#24490#29615'(00/00) '#20132#26131'(00/00) '#31649#29702'(00/00) (0)'
      end
      object Label1: TLabel
        Left = 8
        Top = 10
        Width = 210
        Height = 12
        Caption = #22788#29702'(00/00) '#20256#36755'(0/0) '#35282#33394'(000/000)'
      end
    end
    object MemoLog: TMemo
      Left = 0
      Top = 0
      Width = 451
      Height = 206
      Align = alClient
      BevelInner = bvNone
      Color = clBlack
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object GridGate: TStringGrid
    Left = 0
    Top = 287
    Width = 451
    Height = 80
    Align = alBottom
    ColCount = 7
    Ctl3D = True
    DefaultRowHeight = 15
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentCtl3D = False
    TabOrder = 1
    ColWidths = (
      36
      110
      56
      54
      56
      56
      56)
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 212
    Top = 39
  end
  object RunTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = RunTimerTimer
    Left = 144
    Top = 39
  end
  object DBSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 6000
    Left = 48
    Top = 39
  end
  object ConnectTimer: TTimer
    Enabled = False
    Interval = 3000
    Left = 20
    Top = 39
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = StartTimerTimer
    Left = 180
    Top = 39
  end
  object SaveVariableTimer: TTimer
    Interval = 10000
    OnTimer = SaveVariableTimerTimer
    Left = 244
    Top = 40
  end
  object CloseTimer: TTimer
    Enabled = False
    Interval = 100
    Left = 316
    Top = 40
  end
  object MainMenu: TMainMenu
    Left = 80
    Top = 39
    object MENU_CONTROL: TMenuItem
      Caption = #25511#21046'(&C)'
      OnClick = MENU_CONTROLClick
      object MENU_CONTROL_START: TMenuItem
        Caption = #21551#21160#26381#21153
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = #20572#27490#26381#21153
        OnClick = MENU_CONTROL_STOPClick
      end
      object MENU_CONTROL_CLEARLOGMSG: TMenuItem
        Caption = #28165#38500#26085#24535
        OnClick = MENU_CONTROL_CLEARLOGMSGClick
      end
      object MENU_CONTROL_RELOAD: TMenuItem
        Caption = #37325#26032#21152#36733
        object N9: TMenuItem
          Caption = #21442#25968#35774#32622
          object MENU_CONTROL_RELOAD_CONF: TMenuItem
            Caption = #21442#25968#35774#32622
            OnClick = MENU_CONTROL_RELOAD_CONFClick
          end
          object N4: TMenuItem
            Caption = #24618#29289#26292#29575
            OnClick = N4Click
          end
          object MENU_CONTROL_RELOAD_MONSTERSAY: TMenuItem
            Caption = #24618#29289#35828#35805#35774#32622
            OnClick = MENU_CONTROL_RELOAD_MONSTERSAYClick
          end
          object N6: TMenuItem
            Caption = #28216#25103#20844#21578
            OnClick = N6Click
          end
          object MENU_CONTROL_RELOAD_DISABLEMAKE: TMenuItem
            Caption = #25968#25454#21015#34920
            OnClick = MENU_CONTROL_RELOAD_DISABLEMAKEClick
          end
          object MENU_CONTROL_RELOAD_STARTPOINT: TMenuItem
            Caption = #22320#22270#23433#20840#21306
            OnClick = MENU_CONTROL_RELOAD_STARTPOINTClick
          end
          object N1: TMenuItem
            Caption = #21830#22478#29289#21697#21015#34920
            OnClick = N1Click
          end
        end
        object NPC1: TMenuItem
          Caption = 'NPC'#33050#26412
          object QFunction1: TMenuItem
            Caption = 'QFunction'#33050#26412
            OnClick = QFunction1Click
          end
          object N7: TMenuItem
            Caption = ' '#27880#20876#25991#20214
            OnClick = N7Click
          end
          object N3: TMenuItem
            Caption = #26426#22120#20154#33050#26412
            OnClick = N3Click
          end
          object N2: TMenuItem
            Caption = #30331#38470#33050#26412
            OnClick = N2Click
          end
        end
        object N8: TMenuItem
          Caption = #25968#25454#24211
          object MENU_CONTROL_RELOAD_ITEMDB: TMenuItem
            Caption = #29289#21697#25968#25454#24211
            OnClick = MENU_CONTROL_RELOAD_ITEMDBClick
          end
          object MENU_CONTROL_RELOAD_MONSTERDB: TMenuItem
            Caption = #24618#29289#25968#25454#24211
            OnClick = MENU_CONTROL_RELOAD_MONSTERDBClick
          end
          object MENU_CONTROL_RELOAD_MAGICDB: TMenuItem
            Caption = #25216#33021#25968#25454#24211
            OnClick = MENU_CONTROL_RELOAD_MAGICDBClick
          end
          object N10: TMenuItem
            Caption = #24515#39764#25968#25454#24211
            OnClick = N10Click
          end
        end
      end
      object MENU_CONTROL_GATE: TMenuItem
        Caption = #28216#25103#32593#20851
        object MENU_CONTROL_GATE_OPEN: TMenuItem
          Caption = #25171#24320'(&O)'
          OnClick = MENU_CONTROL_GATE_OPENClick
        end
        object MENU_CONTROL_GATE_CLOSE: TMenuItem
          Caption = #20851#38381'(&C)'
          OnClick = MENU_CONTROL_GATE_CLOSEClick
        end
      end
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = #36864#20986
        OnClick = MENU_CONTROL_EXITClick
      end
    end
    object MENU_VIEW: TMenuItem
      Caption = #26597#30475'(&V)'
      object MENU_VIEW_ONLINEHUMAN: TMenuItem
        Caption = #22312#32447#20154#29289'(&O)'
        OnClick = MENU_VIEW_ONLINEHUMANClick
      end
      object MENU_VIEW_SESSION: TMenuItem
        Caption = #20840#23616#20250#35805'(&S)'
        OnClick = MENU_VIEW_SESSIONClick
      end
      object MENU_VIEW_LEVEL: TMenuItem
        Caption = #31561#32423#23646#24615'(&L)'
        OnClick = MENU_VIEW_LEVELClick
      end
      object MENU_VIEW_LIST: TMenuItem
        Caption = #21015#34920#20449#24687'(&L)'
        OnClick = MENU_VIEW_LISTClick
      end
      object MENU_VIEW_KERNELINFO: TMenuItem
        Caption = #20869#26680#25968#25454'(&K)'
        OnClick = MENU_VIEW_KERNELINFOClick
      end
      object MENU_VIEW_GATE: TMenuItem
        Caption = #32593#20851#29366#24577'(&G)'
        Checked = True
        OnClick = MENU_VIEW_GATEClick
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&P)'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = MENU_OPTION_GENERALClick
      end
      object MENU_OPTION_GAME: TMenuItem
        Caption = #21442#25968#35774#32622'(&O)'
        OnClick = MENU_OPTION_GAMEClick
      end
      object MENU_OPTION_ITEMFUNC: TMenuItem
        Caption = #29289#21697#35013#22791'(&I)'
        OnClick = MENU_OPTION_ITEMFUNCClick
      end
      object MENU_OPTION_FUNCTION: TMenuItem
        Caption = #21151#33021#35774#32622'(&F)'
        OnClick = MENU_OPTION_FUNCTIONClick
      end
      object G1: TMenuItem
        Caption = #28216#25103#21629#20196'(&C)'
        OnClick = G1Click
      end
      object MENU_OPTION_MONSTER: TMenuItem
        Caption = #24618#29289#35774#32622'(&M)'
        OnClick = MENU_OPTION_MONSTERClick
      end
      object MENU_OPTION_SERVERCONFIG: TMenuItem
        Caption = #24615#33021#21442#25968'(&P)'
        OnClick = MENU_OPTION_SERVERCONFIGClick
      end
      object N11: TMenuItem
        Caption = #22871#35013#35774#32622
        OnClick = N11Click
      end
    end
    object MENU_MANAGE: TMenuItem
      Caption = #31649#29702'(&M)'
      object MENU_MANAGE_ONLINEMSG: TMenuItem
        Caption = #22312#32447#28040#24687'(&S)'
        OnClick = MENU_MANAGE_ONLINEMSGClick
      end
      object MENU_MANAGE_PLUG: TMenuItem
        Caption = #21151#33021#25554#20214'(&P)'
        OnClick = MENU_MANAGE_PLUGClick
      end
      object MENU_MANAGE_CASTLE: TMenuItem
        Caption = #22478#22561#31649#29702'(&C)'
        OnClick = MENU_MANAGE_CASTLEClick
      end
    end
    object MENU_TOOLS: TMenuItem
      Caption = #24037#20855'(&T)'
      object MENU_TOOLS_MERCHANT: TMenuItem
        Caption = #20132#26131'NPC'#37197#32622'(&M)'
        OnClick = MENU_TOOLS_MERCHANTClick
      end
      object MENU_TOOLS_NPC: TMenuItem
        Caption = #31649#29702'NPC'#37197#32622'(&N)'
      end
      object MENU_TOOLS_MONGEN: TMenuItem
        Caption = #21047#24618#37197#32622'(&G)'
        OnClick = MENU_TOOLS_MONGENClick
      end
      object MENU_TOOLS_IPSEARCH: TMenuItem
        Caption = #22320#21306#26597#35810'(&S)'
        OnClick = MENU_TOOLS_IPSEARCHClick
      end
    end
    object MENU_HELP: TMenuItem
      Caption = #24110#21161'(&H)'
      object MENU_HELP_ABOUT: TMenuItem
        Caption = #20851#20110'(&A)'
        OnClick = MENU_HELP_ABOUTClick
      end
      object N5: TMenuItem
        Caption = #27880#20876
        OnClick = N5Click
      end
    end
  end
  object getLocalIp: TTimer
    Interval = 600000000
    Left = 280
    Top = 40
  end
end
