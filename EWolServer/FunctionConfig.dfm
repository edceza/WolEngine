object frmFunctionConfig: TfrmFunctionConfig
  Left = 217
  Top = 346
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21151#33021#35774#32622
  ClientHeight = 378
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label14: TLabel
    Left = 8
    Top = 359
    Width = 432
    Height = 12
    Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object FunctionConfigControl: TPageControl
    Left = 8
    Top = 8
    Width = 457
    Height = 345
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 0
    OnChanging = FunctionConfigControlChanging
    object TabSheetGeneral: TTabSheet
      Caption = #22522#26412#21151#33021
      ImageIndex = 3
      object GroupBox7: TGroupBox
        Left = 296
        Top = 8
        Width = 145
        Height = 185
        Caption = #33021#37327#25511#21046
        TabOrder = 0
        object CheckBoxHungerSystem: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Hint = #21551#29992#27492#21151#33021#21518#65292#20154#29289#24517#39035#23450#26102#21507#39135#29289#20197#20445#25345#33021#37327#65292#22914#26524#38271#26102#38388#26410#21507#39135#29289#65292#20154#29289#23558#34987#39295#27515#12290
          Caption = #21551#29992#33021#37327#25511#21046#31995#32479
          TabOrder = 0
          OnClick = CheckBoxHungerSystemClick
        end
        object GroupBoxHunger: TGroupBox
          Left = 8
          Top = 40
          Width = 129
          Height = 57
          Caption = #33021#37327#19981#22815#26102
          TabOrder = 1
          object CheckBoxHungerDecPower: TCheckBox
            Left = 8
            Top = 32
            Width = 97
            Height = 17
            Hint = #20154#29289#30340#25915#20987#21147#65292#19982#20154#29289#30340#33021#37327#30456#20851#65292#33021#37327#19981#22815#26102#20154#29289#30340#25915#20987#21147#23558#38543#20043#19979#38477#12290
            Caption = #33258#21160#20943#25915#20987#21147
            TabOrder = 0
            OnClick = CheckBoxHungerDecPowerClick
          end
          object CheckBoxHungerDecHP: TCheckBox
            Left = 8
            Top = 16
            Width = 89
            Height = 17
            Hint = #24403#20154#29289#38271#26102#38388#27809#21507#39135#29289#21518#33021#37327#38477#21040'0'#21518#65292#23558#24320#22987#33258#21160#20943#23569'HP'#20540#65292#38477#21040'0'#21518#65292#20154#29289#27515#20129#12290
            Caption = #33258#21160#20943'HP'
            TabOrder = 1
            OnClick = CheckBoxHungerDecHPClick
          end
        end
      end
      object ButtonGeneralSave: TButton
        Left = 368
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonGeneralSaveClick
      end
      object GroupBox34: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 161
        Caption = #21517#23383#26174#31034#39068#33394
        TabOrder = 2
        object Label85: TLabel
          Left = 11
          Top = 16
          Width = 54
          Height = 12
          Caption = #25915#20987#29366#24577':'
        end
        object LabelPKFlagNameColor: TLabel
          Left = 112
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label87: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #40644#21517#29366#24577':'
        end
        object LabelPKLevel1NameColor: TLabel
          Left = 112
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label89: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #32418#21517#29366#24577':'
        end
        object LabelPKLevel2NameColor: TLabel
          Left = 112
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label91: TLabel
          Left = 11
          Top = 88
          Width = 54
          Height = 12
          Caption = #32852#30431#25112#20105':'
        end
        object LabelAllyAndGuildNameColor: TLabel
          Left = 112
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label93: TLabel
          Left = 11
          Top = 112
          Width = 54
          Height = 12
          Caption = #25932#23545#25112#20105':'
        end
        object LabelWarGuildNameColor: TLabel
          Left = 112
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label95: TLabel
          Left = 11
          Top = 136
          Width = 54
          Height = 12
          Caption = #25112#20105#21306#22495':'
        end
        object LabelInFreePKAreaNameColor: TLabel
          Left = 112
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditPKFlagNameColor: TSpinEdit
          Left = 64
          Top = 12
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#25915#20987#20854#20182#20154#29289#26102#21517#23383#39068#33394#65292#40664#35748#20026'47'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditPKFlagNameColorChange
        end
        object EditPKLevel1NameColor: TSpinEdit
          Left = 64
          Top = 36
          Width = 41
          Height = 21
          Hint = #24403#20154#29289'PK'#28857#36229#36807'100'#28857#26102#21517#23383#39068#33394#65292#40664#35748#20026'251'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditPKLevel1NameColorChange
        end
        object EditPKLevel2NameColor: TSpinEdit
          Left = 64
          Top = 60
          Width = 41
          Height = 21
          Hint = #24403#20154#29289'PK'#28857#36229#36807'200'#28857#26102#21517#23383#39068#33394#65292#40664#35748#20026'249'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditPKLevel2NameColorChange
        end
        object EditAllyAndGuildNameColor: TSpinEdit
          Left = 64
          Top = 84
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#26412#34892#20250#21450#32852#30431#34892#20250#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'180'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditAllyAndGuildNameColorChange
        end
        object EditWarGuildNameColor: TSpinEdit
          Left = 64
          Top = 108
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#25932#23545#34892#20250#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'69'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditWarGuildNameColorChange
        end
        object EditInFreePKAreaNameColor: TSpinEdit
          Left = 64
          Top = 132
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#21306#22495#26102#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'221'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditInFreePKAreaNameColorChange
        end
      end
      object GroupBox114: TGroupBox
        Left = 4
        Top = 175
        Width = 145
        Height = 55
        Caption = #30462#29260
        TabOrder = 3
        object Label228: TLabel
          Left = 3
          Top = 23
          Width = 108
          Height = 12
          Caption = #38450#24481#20960#29575':       '#65285
        end
        object EditShieldRate: TSpinEdit
          Left = 57
          Top = 19
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#21306#22495#26102#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'221'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditShieldRateChange
        end
      end
    end
    object PasswordSheet: TTabSheet
      Caption = #23494#30721#20445#25252
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 8
        Top = 0
        Width = 433
        Height = 193
        TabOrder = 0
        object CheckBoxEnablePasswordLock: TCheckBox
          Left = 8
          Top = -5
          Width = 121
          Height = 25
          Caption = #21551#29992#23494#30721#20445#25252#31995#32479
          TabOrder = 0
          OnClick = CheckBoxEnablePasswordLockClick
        end
        object GroupBox2: TGroupBox
          Left = 8
          Top = 16
          Width = 265
          Height = 169
          Caption = #38145#23450#25511#21046
          TabOrder = 1
          object CheckBoxLockGetBackItem: TCheckBox
            Left = 8
            Top = 16
            Width = 121
            Height = 17
            Caption = #31105#27490#21462#20179#24211#20179#24211
            TabOrder = 0
            OnClick = CheckBoxLockGetBackItemClick
          end
          object GroupBox4: TGroupBox
            Left = 8
            Top = 40
            Width = 249
            Height = 105
            Caption = #30331#24405#38145#23450
            TabOrder = 1
            object CheckBoxLockWalk: TCheckBox
              Left = 8
              Top = 32
              Width = 105
              Height = 17
              Caption = #31105#27490#36208#36335
              TabOrder = 0
              OnClick = CheckBoxLockWalkClick
            end
            object CheckBoxLockRun: TCheckBox
              Left = 8
              Top = 48
              Width = 105
              Height = 17
              Caption = #31105#27490#36305#27493
              TabOrder = 1
              OnClick = CheckBoxLockRunClick
            end
            object CheckBoxLockHit: TCheckBox
              Left = 8
              Top = 64
              Width = 105
              Height = 17
              Caption = #31105#27490#25915#20987
              TabOrder = 2
              OnClick = CheckBoxLockHitClick
            end
            object CheckBoxLockSpell: TCheckBox
              Left = 8
              Top = 80
              Width = 105
              Height = 17
              Caption = #31105#27490#39764#27861
              TabOrder = 3
              OnClick = CheckBoxLockSpellClick
            end
            object CheckBoxLockSendMsg: TCheckBox
              Left = 120
              Top = 32
              Width = 105
              Height = 17
              Caption = #31105#27490#32842#22825
              TabOrder = 4
              OnClick = CheckBoxLockSendMsgClick
            end
            object CheckBoxLockInObMode: TCheckBox
              Left = 120
              Top = 16
              Width = 121
              Height = 17
              Hint = #22914#26524#26377#23494#30721#20445#25252#26102#65292#20154#29289#30331#24405#26102#20026#38544#36523#29366#24577#65292#24618#29289#19981#20250#25915#20987#20154#29289#65292#22312#36755#20837#23494#30721#24320#38145#21518#24674#22797#27491#24120#12290
              Caption = #38145#23450#26102#20026#38544#36523#27169#24335
              TabOrder = 5
              OnClick = CheckBoxLockInObModeClick
            end
            object CheckBoxLockLogin: TCheckBox
              Left = 8
              Top = 16
              Width = 105
              Height = 17
              Caption = #38145#23450#20154#29289#30331#24405
              TabOrder = 6
              OnClick = CheckBoxLockLoginClick
            end
            object CheckBoxLockUseItem: TCheckBox
              Left = 120
              Top = 80
              Width = 105
              Height = 17
              Caption = #31105#27490#20351#29992#21697
              TabOrder = 7
              OnClick = CheckBoxLockUseItemClick
            end
            object CheckBoxLockDropItem: TCheckBox
              Left = 120
              Top = 64
              Width = 105
              Height = 17
              Caption = #31105#27490#25172#29289#21697
              TabOrder = 8
              OnClick = CheckBoxLockDropItemClick
            end
            object CheckBoxLockDealItem: TCheckBox
              Left = 120
              Top = 48
              Width = 121
              Height = 17
              Caption = #31105#27490#20132#26131#29289#21697
              TabOrder = 9
              OnClick = CheckBoxLockDealItemClick
            end
          end
        end
        object GroupBox3: TGroupBox
          Left = 280
          Top = 16
          Width = 145
          Height = 65
          Caption = #23494#30721#36755#20837#38169#35823#25511#21046
          TabOrder = 2
          object Label1: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #38169#35823#27425#25968':'
          end
          object EditErrorPasswordCount: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #22312#24320#38145#26102#36755#20837#23494#30721#65292#22914#26524#36755#20837#38169#35823#36229#36807#25351#23450#27425#25968#65292#21017#38145#23450#23494#30721#65292#24517#39035#37325#26032#30331#24405#19968#27425#25165#21487#20197#20877#27425#36755#20837#23494#30721#12290
            EditorEnabled = False
            MaxValue = 10
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditErrorPasswordCountChange
          end
          object CheckBoxErrorCountKick: TCheckBox
            Left = 8
            Top = 40
            Width = 129
            Height = 17
            Caption = #36229#36807#25351#23450#27425#25968#36386#19979#32447
            Enabled = False
            TabOrder = 1
            OnClick = CheckBoxErrorCountKickClick
          end
        end
        object ButtonPasswordLockSave: TButton
          Left = 360
          Top = 157
          Width = 65
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 3
          OnClick = ButtonPasswordLockSaveClick
        end
      end
    end
    object TabSheet32: TTabSheet
      Caption = #32467#23130#31995#32479
      ImageIndex = 4
    end
    object TabSheet33: TTabSheet
      Caption = #24072#24466#31995#32479
      ImageIndex = 5
      object GroupBox21: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 153
        Caption = #24466#24351#20986#24072
        TabOrder = 0
        object GroupBox22: TGroupBox
          Left = 8
          Top = 16
          Width = 145
          Height = 49
          Caption = #20986#24072#31561#32423
          TabOrder = 0
          object Label29: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #20986#24072#31561#32423':'
          end
          object EditMasterOKLevel: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #20986#24072#31561#32423#35774#32622#65292#20154#29289#22312#25308#24072#21518#65292#21040#25351#23450#31561#32423#21518#23558#33258#21160#20986#24072#12290
            MaxValue = 65535
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKLevelChange
          end
        end
        object GroupBox23: TGroupBox
          Left = 8
          Top = 72
          Width = 145
          Height = 73
          Caption = #24072#29238#25152#24471
          TabOrder = 1
          object Label30: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #22768#26395#28857#25968':'
          end
          object Label31: TLabel
            Left = 8
            Top = 42
            Width = 54
            Height = 12
            Caption = #20998#37197#28857#25968':'
          end
          object EditMasterOKCreditPoint: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#22768#26395#28857#25968#12290
            MaxValue = 100
            MinValue = 0
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKCreditPointChange
          end
          object EditMasterOKBonusPoint: TSpinEdit
            Left = 68
            Top = 39
            Width = 53
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#20998#37197#28857#25968#12290
            MaxValue = 1000
            MinValue = 0
            TabOrder = 1
            Value = 10
            OnChange = EditMasterOKBonusPointChange
          end
        end
      end
      object ButtonMasterSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonMasterSaveClick
      end
      object CheckBoxMasterRunScript: TCheckBox
        Left = 8
        Top = 168
        Width = 161
        Height = 17
        Caption = #21551#29992#33050#26412#25511#21046#20986#24072#31995#32479
        TabOrder = 2
        OnClick = CheckBoxMasterRunScriptClick
      end
    end
    object TabSheet38: TTabSheet
      Caption = #36716#29983#31995#32479
      ImageIndex = 9
      object GroupBox29: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 257
        Caption = #33258#21160#21464#33394
        TabOrder = 0
        object Label56: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelReNewNameColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label58: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelReNewNameColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label60: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelReNewNameColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label62: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelReNewNameColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label64: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelReNewNameColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label66: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelReNewNameColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label68: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelReNewNameColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label70: TLabel
          Left = 11
          Top = 184
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelReNewNameColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label72: TLabel
          Left = 11
          Top = 208
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelReNewNameColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label74: TLabel
          Left = 11
          Top = 232
          Width = 18
          Height = 12
          Caption = #21313':'
        end
        object LabelReNewNameColor10: TLabel
          Left = 88
          Top = 230
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditReNewNameColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditReNewNameColor1Change
        end
        object EditReNewNameColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditReNewNameColor2Change
        end
        object EditReNewNameColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditReNewNameColor3Change
        end
        object EditReNewNameColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditReNewNameColor4Change
        end
        object EditReNewNameColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditReNewNameColor5Change
        end
        object EditReNewNameColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditReNewNameColor6Change
        end
        object EditReNewNameColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditReNewNameColor7Change
        end
        object EditReNewNameColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditReNewNameColor8Change
        end
        object EditReNewNameColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditReNewNameColor9Change
        end
        object EditReNewNameColor10: TSpinEdit
          Left = 40
          Top = 228
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 100
          OnChange = EditReNewNameColor10Change
        end
      end
      object ButtonReNewLevelSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonReNewLevelSaveClick
      end
      object GroupBox30: TGroupBox
        Left = 128
        Top = 8
        Width = 105
        Height = 65
        Caption = #21517#23383#21464#33394
        TabOrder = 2
        object Label57: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = #38388#38548':'
        end
        object Label59: TLabel
          Left = 83
          Top = 44
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditReNewNameColorTime: TSpinEdit
          Left = 44
          Top = 39
          Width = 37
          Height = 21
          Hint = #20986#24072#31561#32423#35774#32622#65292#20154#29289#22312#25308#24072#21518#65292#21040#25351#23450#31561#32423#21518#23558#33258#21160#20986#24072#12290
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditReNewNameColorTimeChange
        end
        object CheckBoxReNewChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = #25171#24320#27492#21151#33021#21518#65292#36716#29983#30340#20154#29289#30340#21517#23383#39068#33394#20250#33258#21160#21464#21270#12290
          Caption = #33258#21160#21464#33394
          TabOrder = 1
          OnClick = CheckBoxReNewChangeColorClick
        end
      end
      object GroupBox33: TGroupBox
        Left = 128
        Top = 80
        Width = 105
        Height = 41
        Caption = #36716#29983#25511#21046
        TabOrder = 3
        object CheckBoxReNewLevelClearExp: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = #36716#29983#26102#26159#21542#28165#38500#24050#32463#26377#30340#32463#39564#20540#12290
          Caption = #28165#38500#24050#26377#32463#39564
          TabOrder = 0
          OnClick = CheckBoxReNewLevelClearExpClick
        end
      end
    end
    object TabSheet39: TTabSheet
      Caption = #23453#23453#21319#32423
      ImageIndex = 10
      object ButtonMonUpgradeSave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonMonUpgradeSaveClick
      end
      object GroupBox32: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 233
        Caption = #31561#32423#39068#33394
        TabOrder = 1
        object Label65: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelMonUpgradeColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label67: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelMonUpgradeColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label69: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelMonUpgradeColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label71: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelMonUpgradeColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label73: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelMonUpgradeColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label75: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelMonUpgradeColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label76: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelMonUpgradeColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label77: TLabel
          Left = 11
          Top = 184
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelMonUpgradeColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label86: TLabel
          Left = 11
          Top = 208
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelMonUpgradeColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditMonUpgradeColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeColor1Change
        end
        object EditMonUpgradeColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeColor2Change
        end
        object EditMonUpgradeColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeColor3Change
        end
        object EditMonUpgradeColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeColor4Change
        end
        object EditMonUpgradeColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeColor5Change
        end
        object EditMonUpgradeColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeColor6Change
        end
        object EditMonUpgradeColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeColor7Change
        end
        object EditMonUpgradeColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpgradeColor8Change
        end
        object EditMonUpgradeColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpgradeColor9Change
        end
      end
      object GroupBox31: TGroupBox
        Left = 128
        Top = 8
        Width = 97
        Height = 233
        Caption = #21319#32423#26432#24618#25968
        TabOrder = 2
        object Label61: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object Label63: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object Label78: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object Label79: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object Label80: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object Label81: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object Label82: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object Label83: TLabel
          Left = 11
          Top = 184
          Width = 30
          Height = 12
          Caption = #22522#25968':'
        end
        object Label84: TLabel
          Left = 11
          Top = 208
          Width = 30
          Height = 12
          Caption = #20493#29575':'
        end
        object EditMonUpgradeKillCount1: TSpinEdit
          Left = 40
          Top = 12
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeKillCount1Change
        end
        object EditMonUpgradeKillCount2: TSpinEdit
          Left = 40
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeKillCount2Change
        end
        object EditMonUpgradeKillCount3: TSpinEdit
          Left = 40
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeKillCount3Change
        end
        object EditMonUpgradeKillCount4: TSpinEdit
          Left = 40
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeKillCount4Change
        end
        object EditMonUpgradeKillCount5: TSpinEdit
          Left = 40
          Top = 108
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeKillCount5Change
        end
        object EditMonUpgradeKillCount6: TSpinEdit
          Left = 40
          Top = 132
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeKillCount6Change
        end
        object EditMonUpgradeKillCount7: TSpinEdit
          Left = 40
          Top = 156
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeKillCount7Change
        end
        object EditMonUpLvNeedKillBase: TSpinEdit
          Left = 40
          Top = 180
          Width = 49
          Height = 21
          Hint = #26432#24618#25968#37327'='#31561#32423' * '#20493#29575' + '#31561#32423' + '#22522#25968' + '#27599#32423#25968#37327
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpLvNeedKillBaseChange
        end
        object EditMonUpLvRate: TSpinEdit
          Left = 40
          Top = 204
          Width = 49
          Height = 21
          Hint = #26432#24618#25968#37327'='#24618#29289#31561#32423' * '#20493#29575' + '#31561#32423' + '#22522#25968' + '#27599#32423#25968#37327
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpLvRateChange
        end
      end
      object GroupBox35: TGroupBox
        Left = 232
        Top = 8
        Width = 137
        Height = 113
        Caption = #20027#20154#27515#20129#25511#21046
        TabOrder = 3
        object Label88: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #21464#24322#26426#29575':'
        end
        object Label90: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #22686#21152#25915#20987':'
        end
        object Label92: TLabel
          Left = 11
          Top = 88
          Width = 54
          Height = 12
          Caption = #22686#21152#36895#24230':'
        end
        object CheckBoxMasterDieMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #20027#20154#27515#20129#21518#21464#24322
          TabOrder = 0
          OnClick = CheckBoxMasterDieMutinyClick
        end
        object EditMasterDieMutinyRate: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = #25968#23383#36234#23567#65292#21464#24322#26426#29575#36234#22823#12290
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditMasterDieMutinyRateChange
        end
        object EditMasterDieMutinyPower: TSpinEdit
          Left = 72
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 2
          Value = 100
          OnChange = EditMasterDieMutinyPowerChange
        end
        object EditMasterDieMutinySpeed: TSpinEdit
          Left = 72
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 3
          Value = 100
          OnChange = EditMasterDieMutinySpeedChange
        end
      end
      object GroupBox47: TGroupBox
        Left = 232
        Top = 128
        Width = 137
        Height = 73
        Caption = #19971#24425#23453#23453
        TabOrder = 4
        object Label112: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #26102#38388#38388#38548':'
        end
        object CheckBoxBBMonAutoChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #23453#23453#33258#21160#21464#33394
          TabOrder = 0
          OnClick = CheckBoxBBMonAutoChangeColorClick
        end
        object EditBBMonAutoChangeColorTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = #25968#23383#36234#23567#65292#21464#33394#36895#24230#36234#24555#65292#21333#20301'('#31186')'#12290
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditBBMonAutoChangeColorTimeChange
        end
      end
    end
    object MonSaySheet: TTabSheet
      Caption = #24618#29289#35828#35805
      object GroupBox40: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 49
        Caption = #24618#29289#35828#35805
        TabOrder = 0
        object CheckBoxMonSayMsg: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #24320#21551#24618#29289#35828#35805
          TabOrder = 0
          OnClick = CheckBoxMonSayMsgClick
        end
      end
      object ButtonMonSayMsgSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonMonSayMsgSaveClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = #25216#33021#39764#27861
      ImageIndex = 1
      object ButtonSkillSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonSkillSaveClick
      end
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 449
        Height = 271
        ActivePage = TabSheet53
        TabOrder = 1
        object TabSheet53: TTabSheet
          Caption = #25216#33021#21442#25968
          ImageIndex = 1
          object GroupBox17: TGroupBox
            Left = 196
            Top = 18
            Width = 145
            Height = 66
            Caption = #39764#27861#25915#20987#33539#22260#38480#21046
            TabOrder = 0
            object Label12: TLabel
              Left = 8
              Top = 18
              Width = 54
              Height = 12
              Caption = #33539#22260#22823#23567':'
            end
            object Label231: TLabel
              Left = 8
              Top = 41
              Width = 54
              Height = 12
              Caption = #35823#24046#33539#22260':'
            end
            object EditMagicAttackRage: TSpinEdit
              Left = 68
              Top = 15
              Width = 53
              Height = 21
              Hint = #39764#27861#25915#20987#26377#25928#36317#31163#65292#36229#36807#25351#23450#36317#31163#25915#20987#26080#25928#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
            object SpinEdit4: TSpinEdit
              Left = 68
              Top = 38
              Width = 53
              Height = 21
              Hint = #39764#27861#25915#20987#26377#25928#36317#31163#65292#36229#36807#25351#23450#36317#31163#25915#20987#26080#25928#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
          end
          object GroupBox117: TGroupBox
            Left = 195
            Top = 95
            Width = 145
            Height = 44
            Caption = #21452#20493#32463#39564#25216#33021#20960#29575
            TabOrder = 1
            object Label232: TLabel
              Left = 12
              Top = 19
              Width = 54
              Height = 12
              Caption = #20960#29575#21442#25968':'
            end
            object SpinEdit5: TSpinEdit
              Left = 68
              Top = 15
              Width = 53
              Height = 21
              Hint = #39764#27861#25915#20987#26377#25928#36317#31163#65292#36229#36807#25351#23450#36317#31163#25915#20987#26080#25928#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
          end
          object GroupBox118: TGroupBox
            Left = 7
            Top = 152
            Width = 159
            Height = 51
            Caption = #39569#25112#25216#33021#20919#21364#26102#38388
            TabOrder = 2
            object Label233: TLabel
              Left = 8
              Top = 18
              Width = 54
              Height = 12
              Caption = #20960#29575#21442#25968':'
            end
            object SpinEdit7: TSpinEdit
              Left = 68
              Top = 15
              Width = 53
              Height = 21
              Hint = #39569#25112#25216#33021#20919#21364#26102#38388','#21333#20301#31186
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
          end
          object GroupBox119: TGroupBox
            Left = 5
            Top = 12
            Width = 160
            Height = 127
            Caption = #22522#26412#35774#32622
            TabOrder = 3
            object Label234: TLabel
              Left = 16
              Top = 80
              Width = 72
              Height = 12
              Caption = #20803#27668#24674#22797#36895#24230
            end
            object CheckBoxYSskillTree: TCheckBox
              Left = 16
              Top = 38
              Width = 113
              Height = 17
              Caption = #21551#29992#20803#31070#25216#33021#26641
              TabOrder = 0
              OnClick = CheckBoxYSskillTreeClick
            end
            object CheckBoxSkillTree: TCheckBox
              Left = 16
              Top = 15
              Width = 113
              Height = 17
              Caption = #21551#29992#20154#29289#25216#33021#26641
              TabOrder = 1
              OnClick = CheckBoxSkillTreeClick
            end
            object CheckBoxComSkillNoDecVitaLity: TCheckBox
              Left = 16
              Top = 60
              Width = 129
              Height = 17
              Caption = #32452#21512#25216#33021#19981#28040#32791#20803#27668
              TabOrder = 2
              OnClick = CheckBoxComSkillNoDecVitaLityClick
            end
            object TrackBar2: TTrackBar
              Left = 15
              Top = 94
              Width = 130
              Height = 23
              Hint = #20803#27668#24674#22797#36895#24230','#25968#20540#36234#22823','#24674#22797#36234#24930
              Max = 30
              PageSize = 1
              TabOrder = 3
              ThumbLength = 10
              OnChange = TrackBar2Change
            end
          end
        end
        object TabSheet36: TTabSheet
          Caption = #25112#22763#25216#33021
          ImageIndex = 2
          object PageControl7: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 244
            ActivePage = TabSheet19
            Align = alClient
            TabOrder = 0
            TabPosition = tpBottom
            object TabSheet2: TTabSheet
              Caption = #21050#26432#21073#27861
              object GroupBox10: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label4: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label10: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSwordLongPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSwordLongPowerRateChange
                end
              end
              object GroupBox9: TGroupBox
                Left = 3
                Top = 61
                Width = 127
                Height = 41
                Caption = #26080#38480#21050#26432
                TabOrder = 1
                object CheckBoxLimitSwordLong: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23558#26816#26597#26816#26597#38548#20301#26159#21542#26377#35282#33394#23384#22312#65292#20197#31105#27490#20992#20992#21050#26432#12290
                  Caption = #31105#27490#26080#38480#21050#26432
                  TabOrder = 0
                  OnClick = CheckBoxLimitSwordLongClick
                end
              end
            end
            object TabSheet17: TTabSheet
              Caption = #28872#28779#21073#27861
              ImageIndex = 1
              object GroupBox120: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 64
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label235: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label236: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditFireHitPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditFireHitPowerRateChange
                end
                object CheckBoxNoDoubleFireHit: TCheckBox
                  Left = 6
                  Top = 40
                  Width = 97
                  Height = 17
                  Caption = #31105#27490#21452#20493#28872#28779
                  TabOrder = 1
                  OnClick = CheckBoxNoDoubleFireHitClick
                end
              end
            end
            object TabSheet19: TTabSheet
              Caption = #30772#20987#21073#27861
              ImageIndex = 2
              object GroupBox121: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label237: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label238: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditPJPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditPJPowerRateChange
                end
              end
            end
            object TabSheet23: TTabSheet
              Caption = #30772#30462#26025
              ImageIndex = 3
              object GroupBox122: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label239: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label240: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditPDPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditPDPowerRateChange
                end
              end
            end
            object TabSheet24: TTabSheet
              Caption = #37329#21018#25252#20307
              ImageIndex = 4
              object GroupBox123: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #26368#22823#25345#20037#21147
                TabOrder = 0
                object Label241: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #25345#20037#20493#25968':'
                end
                object SpinEditMagDefenceUpPerdureEx: TSpinEdit
                  Left = 66
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditMagDefenceUpPerdureExChange
                end
              end
            end
            object TabSheet25: TTabSheet
              Caption = #24378#21270#25915#26432
              ImageIndex = 5
              object GroupBox124: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label242: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label243: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditSkill88PowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditSkill88PowerRateChange
                end
              end
              object GroupBox127: TGroupBox
                Left = 151
                Top = 9
                Width = 129
                Height = 41
                Caption = #20803#27668#28040#32791
                TabOrder = 1
                object Label244: TLabel
                  Left = 8
                  Top = 20
                  Width = 42
                  Height = 12
                  Caption = #30334#20998#27604':'
                end
                object Label245: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEdit14: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #28040#32791#20803#27668#30334#20998#27604','#40664#35748'100'
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSwordLongPowerRateChange
                end
              end
            end
            object TabSheet27: TTabSheet
              Caption = #24443#22320#38025
              ImageIndex = 6
              object GroupBox128: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label246: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label247: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object SpinEditDiDingPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditDiDingPowerRateChange
                end
              end
              object GroupBox129: TGroupBox
                Left = 159
                Top = 8
                Width = 129
                Height = 41
                Caption = #20801#35768'PK'
                TabOrder = 1
                object CheckBoxDiDingAllowPK: TCheckBox
                  Left = 13
                  Top = 16
                  Width = 110
                  Height = 17
                  Caption = #20801#35768#20316#29992#22312#20154#29289
                  TabOrder = 0
                  OnClick = CheckBoxDiDingAllowPKClick
                end
              end
              object GroupBox130: TGroupBox
                Left = 3
                Top = 63
                Width = 129
                Height = 41
                Caption = #38388#38548#26102#38388
                TabOrder = 2
                object Label248: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #26102#38388':'
                end
                object Label249: TLabel
                  Left = 96
                  Top = 20
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditDiDingUseTime: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditDiDingUseTimeChange
                end
              end
            end
            object TabSheet30: TTabSheet
              Caption = #31361#26025
              ImageIndex = 7
              object Label254: TLabel
                Left = 11
                Top = 56
                Width = 132
                Height = 12
                Caption = #27492#35774#32622#21516#26102#24433#21709#37326#34542#20914#25758
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox131: TGroupBox
                Left = 3
                Top = 7
                Width = 159
                Height = 41
                Caption = #21345#20154#35774#32622
                TabOrder = 0
                object Label251: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #26102#38388':'
                end
                object Label253: TLabel
                  Left = 108
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = #27627#31186
                end
                object SpinEditDoMotaeboDelay: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 58
                  Height = 21
                  Hint = #31361#26025#21345#20154#30340#25345#20037#26102#38388','#34987#25915#20987#32773#22312#35813#26102#38388#20869#19981#33021#36305#27493','#36208#36335','#25915#20987','#39764#27861','#36716#36523
                  EditorEnabled = False
                  Increment = 10
                  MaxValue = 100000
                  MinValue = 1
                  TabOrder = 0
                  Value = 2000
                  OnChange = SpinEditDoMotaeboDelayChange
                end
              end
            end
            object TabSheet31: TTabSheet
              Caption = #31227#24418#25442#24433
              ImageIndex = 8
              object Label257: TLabel
                Left = 11
                Top = 56
                Width = 162
                Height = 12
                Caption = #27492#35774#32622#21516#26102#24433#21709#21270#36523#34649#34656' '#36929#22320
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox132: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #26368#22823#36317#31163
                TabOrder = 0
                object Label255: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object SpinEditBatflyMaxRage: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #31227#24418#25442#24433#30340#26368#22823#20801#35768#36317#31163
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditBatflyMaxRageChange
                end
              end
              object GroupBox133: TGroupBox
                Left = 155
                Top = 8
                Width = 129
                Height = 41
                Caption = #25104#21151#20960#29575
                TabOrder = 1
                object Label256: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20960#29575':'
                end
                object SpinEditBatflyRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #31227#24418#25442#24433#25104#21151#20960#29575','#25968#20540#36234#22823','#25104#21151#27010#29575#36234#23567
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditBatflyRateChange
                end
              end
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = #27861#24072#25216#33021
          ImageIndex = 3
          object PageControl4: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 244
            ActivePage = TabSheet52
            Align = alClient
            TabOrder = 0
            TabPosition = tpBottom
            object TabSheet21: TTabSheet
              Caption = #29190#35010#28779#28976
              ImageIndex = 20
              object GroupBox13: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label7: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditFireBoomRage: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditFireBoomRageChange
                end
              end
            end
            object TabSheet29: TTabSheet
              Caption = #20912#21638#21742
              ImageIndex = 28
              object GroupBox14: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label8: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditSnowWindRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditSnowWindRangeChange
                end
              end
            end
            object TabSheet22: TTabSheet
              Caption = #22320#29425#38647#20809
              ImageIndex = 21
              object GroupBox15: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label9: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditElecBlizzardRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditElecBlizzardRangeChange
                end
              end
            end
            object TabSheet20: TTabSheet
              Caption = #28779#22681
              ImageIndex = 19
              object GroupBox46: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #23433#20840#21306#31105#27490#28779#22681
                TabOrder = 0
                object CheckBoxFireCrossInSafeZone: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#22312#23433#20840#21306#19981#20801#35768#25918#28779#22681#12290
                  Caption = #31105#27490#28779#22681
                  TabOrder = 0
                  OnClick = CheckBoxFireCrossInSafeZoneClick
                end
              end
            end
            object TabSheet28: TTabSheet
              Caption = #22307#35328#26415
              ImageIndex = 27
              object GroupBox37: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label97: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTurnUndeadLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#22307#35328#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#22307#35328#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTurnUndeadLevelChange
                end
              end
            end
            object TabSheet18: TTabSheet
              Caption = #35825#24785#20043#20809
              ImageIndex = 17
              object GroupBox38: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label98: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTammingLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#35825#24785#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#35825#24785#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingLevelChange
                end
              end
              object GroupBox39: TGroupBox
                Left = 8
                Top = 56
                Width = 113
                Height = 73
                Caption = #35825#24785#26426#29575
                TabOrder = 1
                object Label99: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#31561#32423':'
                end
                object Label100: TLabel
                  Left = 8
                  Top = 44
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#34880#37327':'
                end
                object EditMagTammingTargetLevel: TSpinEdit
                  Left = 64
                  Top = 15
                  Width = 41
                  Height = 21
                  Hint = #24618#29289#31561#32423#27604#29575#65292#27492#25968#23383#36234#23567#26426#29575#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingTargetLevelChange
                end
                object EditMagTammingHPRate: TSpinEdit
                  Left = 64
                  Top = 39
                  Width = 41
                  Height = 21
                  Hint = #24618#29289#34880#37327#27604#29575#65292#27492#25968#23383#36234#22823#65292#26426#29575#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 1
                  OnChange = EditMagTammingHPRateChange
                end
              end
              object GroupBox45: TGroupBox
                Left = 128
                Top = 8
                Width = 113
                Height = 41
                Caption = #35825#24785#25968#37327
                TabOrder = 2
                object Label111: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #25968#37327':'
                end
                object EditTammingCount: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #21487#35825#24785#24618#29289#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditTammingCountChange
                end
              end
            end
            object TabSheet41: TTabSheet
              Caption = #28779#28976#20912
              ImageIndex = 32
              object GroupBox41: TGroupBox
                Left = 8
                Top = 8
                Width = 145
                Height = 73
                Caption = #35282#33394#31561#32423#26426#29575#35774#32622
                TabOrder = 0
                object Label101: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#26426#29575':'
                end
                object Label102: TLabel
                  Left = 8
                  Top = 42
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#38480#21046':'
                end
                object EditMabMabeHitRandRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitRandRateChange
                end
                object EditMabMabeHitMinLvLimit: TSpinEdit
                  Left = 68
                  Top = 39
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditMabMabeHitMinLvLimitChange
                end
              end
              object GroupBox42: TGroupBox
                Left = 8
                Top = 88
                Width = 145
                Height = 49
                Caption = #40635#30201#21629#20013#26426#29575
                TabOrder = 1
                object Label103: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitSucessRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#40635#30201#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitSucessRateChange
                end
              end
              object GroupBox43: TGroupBox
                Left = 160
                Top = 8
                Width = 145
                Height = 49
                Caption = #40635#30201#26102#38388#21442#25968#20493#29575
                TabOrder = 2
                object Label104: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitMabeTimeRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #40635#30201#26102#38388#38271#24230#20493#29575#65292#22522#25968#19982#35282#33394#30340#39764#27861#26377#20851#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitMabeTimeRateChange
                end
              end
            end
            object TabSheet52: TTabSheet
              Caption = #27969#26143#28779#38632
              ImageIndex = 7
            end
            object TabSheet54: TTabSheet
              Caption = #39764#39746#26415
              ImageIndex = 8
            end
            object TabSheet55: TTabSheet
              Caption = #29378#40857#32043#30005
              ImageIndex = 9
            end
            object TabSheet56: TTabSheet
              Caption = #20912#26059#39118
              ImageIndex = 10
            end
            object TabSheet57: TTabSheet
              Caption = #24378#21270#28779#29699#26415
              ImageIndex = 11
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = #36947#22763#25216#33021
          ImageIndex = 4
          object PageControl5: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 244
            ActivePage = TabSheet4
            Align = alClient
            TabOrder = 0
            TabPosition = tpBottom
            object TabSheet6: TTabSheet
              Caption = #26045#27602#26415
              ImageIndex = 4
              object GroupBox16: TGroupBox
                Left = 8
                Top = 8
                Width = 137
                Height = 49
                Caption = #27602#33647#38477#28857
                TabOrder = 0
                object Label11: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #28857#25968#25511#21046':'
                end
                object EditAmyOunsulPoint: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #20013#27602#21518#25351#23450#26102#38388#20869#38477#28857#25968#65292#23454#38469#28857#25968#36319#25216#33021#31561#32423#21450#26412#36523#36947#26415#39640#20302#26377#20851#65292#27492#21442#25968#21482#26159#35843#20854#20013#31639#27861#21442#25968#65292#27492#25968#23383#36234#23567#65292#28857#25968#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditAmyOunsulPointChange
                end
              end
            end
            object TabSheet3: TTabSheet
              Caption = #21484#21796#39607#39621
              ImageIndex = 1
              object GroupBox5: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label2: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label3: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditBoneFammName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
                  TabOrder = 0
                  OnChange = EditBoneFammNameChange
                end
                object EditBoneFammCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditBoneFammCountChange
                end
              end
              object GroupBox6: TGroupBox
                Left = 144
                Top = 2
                Width = 289
                Height = 135
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridBoneFamm: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 113
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = #21484#21796#31070#20861
              ImageIndex = 2
              object GroupBox11: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label5: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label6: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditDogzName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object EditDogzCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditDogzCountChange
                end
              end
              object GroupBox12: TGroupBox
                Left = 144
                Top = 2
                Width = 289
                Height = 135
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridDogz: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 113
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet43: TTabSheet
              Caption = #29422#23376#21564
              ImageIndex = 33
              object GroupBox48: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #23545#20154#29289#25915#20987#26377#25928
                TabOrder = 0
                object CheckBoxGroupMbAttackPlayObject: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23601#21487#20197#40635#30201#20154#29289
                  Caption = #20801#35768#40635#30201#20154#29289
                  TabOrder = 0
                  OnClick = CheckBoxGroupMbAttackPlayObjectClick
                end
              end
            end
          end
        end
        object TabSheet11: TTabSheet
          Caption = #32452#21512#25216#33021
          ImageIndex = 5
          object PageControl6: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 244
            ActivePage = TabSheet14
            Align = alClient
            TabOrder = 0
            TabPosition = tpBottom
            object TabSheet8: TTabSheet
              Caption = #24594#26025#22825#19979
              object Label192: TLabel
                Left = 10
                Top = 119
                Width = 168
                Height = 12
                Caption = #38468#21152#25928#26524#65306#31359#36879#26432#20260#65292#20960#29575#30772#38450
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox98: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label189: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label190: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSkill78PowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill78PowerRateChange
                end
              end
              object GroupBox99: TGroupBox
                Left = 3
                Top = 61
                Width = 127
                Height = 42
                TabOrder = 1
                object Label191: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object EditSkill78SpecialPower: TSpinEdit
                  Left = 44
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill78SpecialPowerChange
                end
              end
              object CbxSkill78SpecialPower: TCheckBox
                Left = 7
                Top = 56
                Width = 64
                Height = 17
                Hint = #25171#24320#27492#21151#33021#21518#65292#23558#26816#26597#26816#26597#38548#20301#26159#21542#26377#35282#33394#23384#22312#65292#20197#31105#27490#20992#20992#21050#26432#12290
                Caption = #29305#27530#25928#26524'('#21270#21151')'
                TabOrder = 2
                OnClick = CbxSkill78SpecialPowerClick
              end
            end
            object TabSheet9: TTabSheet
              Caption = #22825#24594#24778#38647
              ImageIndex = 1
              object Label196: TLabel
                Left = 10
                Top = 119
                Width = 192
                Height = 12
                Caption = #38468#21152#25928#26524#65306#22278#38754#26432#20260#65292#24573#35270#39764#27861#36530#36991
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox100: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label193: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label194: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSkill79PowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill79PowerRateChange
                end
              end
              object GroupBox101: TGroupBox
                Left = 3
                Top = 61
                Width = 127
                Height = 42
                TabOrder = 1
                object Label195: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object EditSkill79SpecialPower: TSpinEdit
                  Left = 44
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill79SpecialPowerChange
                end
              end
              object CbxSkill79SpecialPower: TCheckBox
                Left = 7
                Top = 57
                Width = 104
                Height = 17
                Caption = #29305#27530#25928#26524'('#38647#32469')'
                TabOrder = 2
                OnClick = CbxSkill79SpecialPowerClick
              end
            end
            object TabSheet10: TTabSheet
              Caption = #22825#22899#25955#33457
              ImageIndex = 2
              object Label200: TLabel
                Left = 5
                Top = 118
                Width = 228
                Height = 12
                Caption = #38468#21152#25928#26524#65306#29615#23556#25928#26524#65292#26497#25928#36172#21650'('#26080#27861#35299#27602')'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox102: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label197: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label198: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSkill80PowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill80PowerRateChange
                end
              end
              object GroupBox103: TGroupBox
                Left = 3
                Top = 61
                Width = 127
                Height = 42
                TabOrder = 1
                object Label199: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object EditSkill80SpecialPower: TSpinEdit
                  Left = 44
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill80SpecialPowerChange
                end
              end
              object CbxSkill80SpecialPower: TCheckBox
                Left = 7
                Top = 58
                Width = 101
                Height = 17
                Caption = #29305#27530#25928#26524'('#22238#22825')'
                TabOrder = 2
                OnClick = CbxSkill80SpecialPowerClick
              end
            end
            object TabSheet12: TTabSheet
              Caption = #36855#20809#28872#28976
              ImageIndex = 3
              object Label204: TLabel
                Left = 10
                Top = 119
                Width = 192
                Height = 12
                Caption = #38468#21152#25928#26524#65306#33539#22260#26432#20260#65292#24573#30053#39764#27861#36530#36991
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox104: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label201: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label202: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSkill81PowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill81PowerRateChange
                end
              end
              object GroupBox105: TGroupBox
                Left = 3
                Top = 61
                Width = 127
                Height = 42
                TabOrder = 1
                object Label203: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object EditSkill81SpecialPower: TSpinEdit
                  Left = 44
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill81SpecialPowerChange
                end
              end
              object CbxSkill81SpecialPower: TCheckBox
                Left = 7
                Top = 56
                Width = 102
                Height = 17
                Caption = #29305#27530#25928#26524'('#30772#30002')'
                TabOrder = 2
                OnClick = CbxSkill81SpecialPowerClick
              end
            end
            object TabSheet13: TTabSheet
              Caption = #28779#27602#25915#24515#21073
              ImageIndex = 4
              object Label208: TLabel
                Left = 10
                Top = 119
                Width = 168
                Height = 12
                Caption = #38468#21152#25928#26524#65306#33539#22260#27602#38654#65292#25915#24515#27602#28779
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox106: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label205: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label206: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSkill83PowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill83PowerRateChange
                end
              end
              object GroupBox107: TGroupBox
                Left = 3
                Top = 61
                Width = 127
                Height = 42
                TabOrder = 1
                object Label207: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object EditSkill83SpecialPower: TSpinEdit
                  Left = 44
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill83SpecialPowerChange
                end
              end
              object CbxSkill83SpecialPower: TCheckBox
                Left = 6
                Top = 58
                Width = 100
                Height = 17
                Caption = #29305#27530#25928#26524'('#21380#36816')'
                TabOrder = 2
                OnClick = CbxSkill83SpecialPowerClick
              end
            end
            object TabSheet14: TTabSheet
              Caption = #31070#20043#21484#21796
              ImageIndex = 5
              object Label212: TLabel
                Left = 10
                Top = 119
                Width = 96
                Height = 12
                Caption = #38468#21152#25928#26524#65306#39764#29579#25216
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox108: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 0
                object Label209: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label210: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSkill85PowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill85PowerRateChange
                end
              end
              object GroupBox109: TGroupBox
                Left = 3
                Top = 61
                Width = 127
                Height = 42
                TabOrder = 1
                object Label211: TLabel
                  Left = 8
                  Top = 18
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object EditSkill85SpecialPower: TSpinEdit
                  Left = 44
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill85SpecialPowerChange
                end
              end
              object CbxSkill85SpecialPower: TCheckBox
                Left = 6
                Top = 56
                Width = 101
                Height = 17
                Caption = #29305#27530#25928#26524'('#31119#20305')'
                TabOrder = 2
                OnClick = CbxSkill85SpecialPowerClick
              end
              object GroupBox110: TGroupBox
                Left = 147
                Top = 2
                Width = 171
                Height = 170
                Caption = #22522#26412#35774#32622
                TabOrder = 3
                object Label213: TLabel
                  Left = 7
                  Top = 18
                  Width = 36
                  Height = 12
                  Caption = #24618#29289'1:'
                end
                object Label214: TLabel
                  Left = 7
                  Top = 45
                  Width = 36
                  Height = 12
                  Caption = #24618#29289'2:'
                end
                object Label215: TLabel
                  Left = 7
                  Top = 100
                  Width = 36
                  Height = 12
                  Caption = #24618#29289'4:'
                end
                object Label216: TLabel
                  Left = 7
                  Top = 73
                  Width = 36
                  Height = 12
                  Caption = #24618#29289'3:'
                end
                object Label218: TLabel
                  Left = 7
                  Top = 123
                  Width = 36
                  Height = 12
                  Caption = #24618#29289'5:'
                end
                object EditSkill85Mon1: TEdit
                  Left = 56
                  Top = 12
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
                  TabOrder = 0
                  OnChange = EditSkill85Mon1Change
                end
                object EditSkill85Mon2: TEdit
                  Left = 56
                  Top = 39
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
                  TabOrder = 1
                  OnChange = EditSkill85Mon2Change
                end
                object EditSkill85Mon4: TEdit
                  Left = 56
                  Top = 94
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
                  TabOrder = 2
                  OnChange = EditSkill85Mon4Change
                end
                object EditSkill85Mon3: TEdit
                  Left = 56
                  Top = 67
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
                  TabOrder = 3
                  OnChange = EditSkill85Mon3Change
                end
                object EditSkill85Mon5: TEdit
                  Left = 56
                  Top = 117
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
                  TabOrder = 4
                  OnChange = EditSkill85Mon5Change
                end
              end
            end
          end
        end
        object TabSheet16: TTabSheet
          Caption = #20844#20849#25216#33021
          ImageIndex = 5
          object PageControl8: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 244
            ActivePage = TabSheet26
            Align = alClient
            TabOrder = 0
            TabPosition = tpBottom
            object TabSheet26: TTabSheet
              Caption = #30495#20803#35776
              ImageIndex = 5
              object GroupBox125: TGroupBox
                Left = 3
                Top = 7
                Width = 129
                Height = 41
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label250: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #31561#32423#38480#21046':'
                end
                object EditSkill91MonLevel: TSpinEdit
                  Left = 44
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #24618#29289#31561#32423#38480#21046#65292#31561#32423#39640#20110#27492#35774#32622#30340#24618#29289#23558#26080#27861#34987#20987#20013
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill91MonLevelChange
                end
              end
              object GroupBox126: TGroupBox
                Left = 3
                Top = 61
                Width = 183
                Height = 70
                Caption = #20801#35768'PK'
                TabOrder = 1
                object Label252: TLabel
                  Left = 8
                  Top = 37
                  Width = 132
                  Height = 12
                  Caption = #31561#32423#24046#36317' >          '#32423
                end
                object EditSkill91HumLevel: TSpinEdit
                  Left = 74
                  Top = 32
                  Width = 45
                  Height = 21
                  Hint = #24403#25915#20987#32773#31561#32423' '#22823#20110#34987#25915#20987#32773#25351#23450#31561#32423#21518#25165#26377#25928
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill91MonLevelChange
                end
                object CheckBoxSKill91Hum: TCheckBox
                  Left = 12
                  Top = 12
                  Width = 155
                  Height = 17
                  Hint = #24320#21551#27492#21151#33021#21518#65292#30495#20803#35776#21487#20197#20316#29992#22312#29609#23478#36523#19978
                  Caption = #20801#35768#20316#29992#22312#29609#23478#36523#19978
                  TabOrder = 1
                  OnClick = EditSkill91MonLevelChange
                end
              end
              object GroupBox115: TGroupBox
                Left = 138
                Top = 7
                Width = 129
                Height = 41
                Caption = #20960#29575#21442#25968
                TabOrder = 2
                object Label229: TLabel
                  Left = 8
                  Top = 20
                  Width = 90
                  Height = 12
                  Caption = #20960#29575':         %'
                end
                object EditSkill91Rate: TSpinEdit
                  Left = 44
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #25216#33021#25104#21151#30340#20960#29575#65292#30334#20998#27604
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill91MonLevelChange
                end
              end
              object GroupBox116: TGroupBox
                Left = 281
                Top = 7
                Width = 129
                Height = 41
                Caption = #25216#33021#23041#21147
                TabOrder = 3
                object Label230: TLabel
                  Left = 8
                  Top = 20
                  Width = 108
                  Height = 12
                  Caption = #20493#25968':         /100'
                end
                object EditSkill91Power: TSpinEdit
                  Left = 44
                  Top = 13
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567#38500#20197'100'#20026#23454#38469#20493#25968
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill91MonLevelChange
                end
              end
            end
          end
        end
      end
    end
    object TabSheet34: TTabSheet
      Caption = #21319#32423#27494#22120
      ImageIndex = 6
      object GroupBox8: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 121
        Caption = #22522#26412#35774#32622
        TabOrder = 0
        object Label13: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #26368#39640#28857#25968':'
        end
        object Label15: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #25152#38656#36153#29992':'
        end
        object Label16: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #25152#38656#26102#38388':'
        end
        object Label17: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #36807#26399#26102#38388':'
        end
        object Label18: TLabel
          Left = 136
          Top = 65
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label19: TLabel
          Left = 136
          Top = 89
          Width = 12
          Height = 12
          Caption = #22825
        end
        object EditUpgradeWeaponMaxPoint: TSpinEdit
          Left = 68
          Top = 15
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditUpgradeWeaponMaxPointChange
        end
        object EditUpgradeWeaponPrice: TSpinEdit
          Left = 68
          Top = 39
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditUpgradeWeaponPriceChange
        end
        object EditUPgradeWeaponGetBackTime: TSpinEdit
          Left = 68
          Top = 63
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 36000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditUPgradeWeaponGetBackTimeChange
        end
        object EditClearExpireUpgradeWeaponDays: TSpinEdit
          Left = 68
          Top = 87
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditClearExpireUpgradeWeaponDaysChange
        end
      end
      object GroupBox18: TGroupBox
        Left = 176
        Top = 8
        Width = 265
        Height = 89
        Caption = #25915#20987#21147#21319#32423
        TabOrder = 1
        object Label20: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label21: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label22: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponDCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#25915#20987#21147#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponDCRateChange
        end
        object EditUpgradeWeaponDCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponDCTwoPointRateChange
        end
        object EditUpgradeWeaponDCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponDCThreePointRateChange
        end
        object EditUpgradeWeaponDCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox19: TGroupBox
        Left = 176
        Top = 104
        Width = 265
        Height = 97
        Caption = #36947#26415#21319#32423
        TabOrder = 2
        object Label23: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label24: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label25: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponSCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#36947#26415#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponSCRateChange
        end
        object EditUpgradeWeaponSCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponSCTwoPointRateChange
        end
        object EditUpgradeWeaponSCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponSCThreePointRateChange
        end
        object EditUpgradeWeaponSCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox20: TGroupBox
        Left = 176
        Top = 208
        Width = 265
        Height = 89
        Caption = #39764#27861#21319#32423
        TabOrder = 3
        object Label26: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label27: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label28: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponMCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#39764#27861#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponMCRateChange
        end
        object EditUpgradeWeaponMCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponMCTwoPointRateChange
        end
        object EditUpgradeWeaponMCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponMCThreePointRateChange
        end
        object EditUpgradeWeaponMCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object ButtonUpgradeWeaponSave: TButton
        Left = 8
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonUpgradeWeaponSaveClick
      end
      object ButtonUpgradeWeaponDefaulf: TButton
        Left = 80
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 5
        OnClick = ButtonUpgradeWeaponDefaulfClick
      end
    end
    object TabSheet35: TTabSheet
      Caption = #25366#30719#25511#21046
      ImageIndex = 7
      object GroupBox24: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 60
        Caption = #24471#21040#30719#30707#26426#29575
        TabOrder = 0
        object Label32: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #21629#20013#26426#29575':'
        end
        object Label33: TLabel
          Left = 8
          Top = 36
          Width = 54
          Height = 12
          Caption = #25366#30719#26426#29575':'
        end
        object ScrollBarMakeMineHitRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Hint = #35774#32622#30340#25968#23383#36234#23567#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarMakeMineHitRateChange
        end
        object EditMakeMineHitRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarMakeMineRate: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = #35774#32622#30340#25968#23383#36234#23567#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarMakeMineRateChange
        end
        object EditMakeMineRate: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
      end
      object GroupBox25: TGroupBox
        Left = 8
        Top = 72
        Width = 273
        Height = 217
        Caption = #30719#30707#31867#22411#26426#29575
        TabOrder = 1
        object Label34: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #30719#30707#22240#23376':'
        end
        object Label35: TLabel
          Left = 8
          Top = 38
          Width = 42
          Height = 12
          Caption = #37329#30719#29575':'
        end
        object Label36: TLabel
          Left = 8
          Top = 56
          Width = 42
          Height = 12
          Caption = #38134#30719#29575':'
        end
        object Label37: TLabel
          Left = 8
          Top = 76
          Width = 42
          Height = 12
          Caption = #38081#30719#29575':'
        end
        object Label38: TLabel
          Left = 8
          Top = 96
          Width = 54
          Height = 12
          Caption = #40657#38081#30719#29575':'
        end
        object ScrollBarStoneTypeRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarStoneTypeRateChange
        end
        object EditStoneTypeRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarGoldStoneMax: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarGoldStoneMaxChange
        end
        object EditGoldStoneMax: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarSilverStoneMax: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarSilverStoneMaxChange
        end
        object EditSilverStoneMax: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarSteelStoneMax: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarSteelStoneMaxChange
        end
        object EditSteelStoneMax: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditBlackStoneMax: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarBlackStoneMax: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarBlackStoneMaxChange
        end
      end
      object ButtonMakeMineSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonMakeMineSaveClick
      end
      object GroupBox26: TGroupBox
        Left = 288
        Top = 8
        Width = 153
        Height = 121
        Caption = #30719#30707#21697#36136
        TabOrder = 3
        object Label39: TLabel
          Left = 8
          Top = 18
          Width = 78
          Height = 12
          Caption = #30719#30707#26368#23567#21697#36136':'
        end
        object Label40: TLabel
          Left = 8
          Top = 42
          Width = 78
          Height = 12
          Caption = #26222#36890#21697#36136#33539#22260':'
        end
        object Label41: TLabel
          Left = 8
          Top = 66
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#26426#29575':'
        end
        object Label42: TLabel
          Left = 8
          Top = 90
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#33539#22260':'
        end
        object EditStoneMinDura: TSpinEdit
          Left = 92
          Top = 15
          Width = 45
          Height = 21
          Hint = #30719#30707#20986#29616#26368#20302#21697#36136#28857#25968#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStoneMinDuraChange
        end
        object EditStoneGeneralDuraRate: TSpinEdit
          Left = 92
          Top = 39
          Width = 45
          Height = 21
          Hint = #30719#30707#38543#26426#20986#29616#21697#36136#28857#25968#33539#22260#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditStoneGeneralDuraRateChange
        end
        object EditStoneAddDuraRate: TSpinEdit
          Left = 92
          Top = 63
          Width = 45
          Height = 21
          Hint = #30719#30707#20986#29616#39640#21697#36136#28857#25968#26426#29575#65292#39640#21697#36136#37327#25351#21487#36798#21040'20'#25110#20197#19978#30340#28857#25968#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditStoneAddDuraRateChange
        end
        object EditStoneAddDuraMax: TSpinEdit
          Left = 92
          Top = 87
          Width = 45
          Height = 21
          Hint = #39640#21697#36136#30719#30707#38543#26426#20986#29616#21697#36136#28857#25968#33539#22260#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditStoneAddDuraMaxChange
        end
      end
      object ButtonMakeMineDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 4
        OnClick = ButtonMakeMineDefaultClick
      end
    end
    object TabSheet42: TTabSheet
      Caption = #31069#31119#27833#25511#21046
      ImageIndex = 12
      object GroupBox44: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 217
        Caption = #26426#29575#35774#32622
        TabOrder = 0
        object Label105: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #35781#21650#26426#29575':'
        end
        object Label106: TLabel
          Left = 8
          Top = 38
          Width = 54
          Height = 12
          Caption = #19968#32423#28857#25968':'
        end
        object Label107: TLabel
          Left = 8
          Top = 56
          Width = 54
          Height = 12
          Caption = #20108#32423#28857#25968':'
        end
        object Label108: TLabel
          Left = 8
          Top = 76
          Width = 54
          Height = 12
          Caption = #20108#32423#26426#29575':'
        end
        object Label109: TLabel
          Left = 8
          Top = 96
          Width = 54
          Height = 12
          Caption = #19977#32423#28857#25968':'
        end
        object Label110: TLabel
          Left = 8
          Top = 116
          Width = 54
          Height = 12
          Caption = #19977#32423#26426#29575':'
        end
        object ScrollBarWeaponMakeUnLuckRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Hint = #20351#29992#31069#31119#27833#35781#21650#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWeaponMakeUnLuckRateChange
        end
        object EditWeaponMakeUnLuckRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWeaponMakeLuckPoint1: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017'100% '#25104#21151#12290
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWeaponMakeLuckPoint1Change
        end
        object EditWeaponMakeLuckPoint1: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWeaponMakeLuckPoint2: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWeaponMakeLuckPoint2Change
        end
        object EditWeaponMakeLuckPoint2: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWeaponMakeLuckPoint2RateChange
        end
        object EditWeaponMakeLuckPoint2Rate: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWeaponMakeLuckPoint3: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWeaponMakeLuckPoint3: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWeaponMakeLuckPoint3Change
        end
        object ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar
          Left = 72
          Top = 116
          Width = 129
          Height = 15
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWeaponMakeLuckPoint3RateChange
        end
        object EditWeaponMakeLuckPoint3Rate: TEdit
          Left = 208
          Top = 116
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
      end
      object ButtonWeaponMakeLuckDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 1
        OnClick = ButtonWeaponMakeLuckDefaultClick
      end
      object ButtonWeaponMakeLuckSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonWeaponMakeLuckSaveClick
      end
    end
    object TabSheet37: TTabSheet
      Caption = #24425#31080#25511#21046
      ImageIndex = 8
      object GroupBox27: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 169
        Caption = #20013#22870#26426#29575
        TabOrder = 0
        object Label43: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label44: TLabel
          Left = 8
          Top = 62
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label45: TLabel
          Left = 8
          Top = 80
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label46: TLabel
          Left = 8
          Top = 100
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label47: TLabel
          Left = 8
          Top = 120
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label48: TLabel
          Left = 8
          Top = 140
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object Label49: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = #22240#23376':'
        end
        object ScrollBarWinLottery1Max: TScrollBar
          Left = 56
          Top = 40
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWinLottery1MaxChange
        end
        object EditWinLottery1Max: TEdit
          Left = 192
          Top = 40
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWinLottery2Max: TScrollBar
          Left = 56
          Top = 60
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWinLottery2MaxChange
        end
        object EditWinLottery2Max: TEdit
          Left = 192
          Top = 60
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWinLottery3Max: TScrollBar
          Left = 56
          Top = 80
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWinLottery3MaxChange
        end
        object EditWinLottery3Max: TEdit
          Left = 192
          Top = 80
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWinLottery4Max: TScrollBar
          Left = 56
          Top = 100
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWinLottery4MaxChange
        end
        object EditWinLottery4Max: TEdit
          Left = 192
          Top = 100
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWinLottery5Max: TEdit
          Left = 192
          Top = 120
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWinLottery5Max: TScrollBar
          Left = 56
          Top = 120
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWinLottery5MaxChange
        end
        object ScrollBarWinLottery6Max: TScrollBar
          Left = 56
          Top = 140
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWinLottery6MaxChange
        end
        object EditWinLottery6Max: TEdit
          Left = 192
          Top = 140
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
        object EditWinLotteryRate: TEdit
          Left = 192
          Top = 16
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#35895#27468#25340#38899#36755#20837#27861
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 12
        end
        object ScrollBarWinLotteryRate: TScrollBar
          Left = 56
          Top = 16
          Width = 129
          Height = 15
          Max = 100000
          PageSize = 0
          TabOrder = 13
          OnChange = ScrollBarWinLotteryRateChange
        end
      end
      object GroupBox28: TGroupBox
        Left = 288
        Top = 8
        Width = 145
        Height = 169
        Caption = #22870#37329
        TabOrder = 1
        object Label50: TLabel
          Left = 8
          Top = 18
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label51: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label52: TLabel
          Left = 8
          Top = 66
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label53: TLabel
          Left = 8
          Top = 90
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label54: TLabel
          Left = 8
          Top = 114
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label55: TLabel
          Left = 8
          Top = 138
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object EditWinLottery1Gold: TSpinEdit
          Left = 56
          Top = 15
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 100000000
          OnChange = EditWinLottery1GoldChange
        end
        object EditWinLottery2Gold: TSpinEdit
          Left = 56
          Top = 39
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditWinLottery2GoldChange
        end
        object EditWinLottery3Gold: TSpinEdit
          Left = 56
          Top = 63
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditWinLottery3GoldChange
        end
        object EditWinLottery4Gold: TSpinEdit
          Left = 56
          Top = 87
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditWinLottery4GoldChange
        end
        object EditWinLottery5Gold: TSpinEdit
          Left = 56
          Top = 111
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 4
          Value = 10
          OnChange = EditWinLottery5GoldChange
        end
        object EditWinLottery6Gold: TSpinEdit
          Left = 56
          Top = 135
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditWinLottery6GoldChange
        end
      end
      object ButtonWinLotterySave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        ModalResult = 1
        TabOrder = 2
        OnClick = ButtonWinLotterySaveClick
      end
      object ButtonWinLotteryDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 3
        OnClick = ButtonWinLotteryDefaultClick
      end
    end
    object TabSheet40: TTabSheet
      Caption = #31048#31095#29983#25928
      ImageIndex = 11
      object GroupBox36: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 89
        Caption = #31048#31095#29983#25928
        TabOrder = 0
        object Label94: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #29983#25928#26102#38271':'
        end
        object Label96: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #33021#37327#20493#25968':'
          Enabled = False
        end
        object CheckBoxSpiritMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #21551#29992#31048#31095#29305#27530#21151#33021
          TabOrder = 0
          OnClick = CheckBoxSpiritMutinyClick
        end
        object EditSpiritMutinyTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditSpiritMutinyTimeChange
        end
        object EditSpiritPowerRate: TSpinEdit
          Left = 72
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditSpiritPowerRateChange
        end
      end
      object ButtonSpiritMutinySave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSpiritMutinySaveClick
      end
    end
    object TabSheet44: TTabSheet
      Caption = #24515#39764#31995#32479
      ImageIndex = 13
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 449
        Height = 255
        ActivePage = TabSheet15
        TabOrder = 0
        object TabSheet45: TTabSheet
          Caption = #24515#39764#21442#25968
          object GroupBox49: TGroupBox
            Left = 7
            Top = 8
            Width = 135
            Height = 83
            Caption = #22522#26412#35774#32622
            TabOrder = 0
            object CheckBoxEvilAddItemVal: TCheckBox
              Left = 8
              Top = 16
              Width = 121
              Height = 17
              Caption = #24515#39764#35745#31639#35013#22791#23646#24615
              TabOrder = 0
              OnClick = CheckBoxEvilAddItemValClick
            end
            object CheckBox1: TCheckBox
              Left = 8
              Top = 42
              Width = 121
              Height = 17
              Caption = #26412#20307#22686#21152#38468#39764#23646#24615
              TabOrder = 1
              OnClick = CheckBoxEvilAddItemValClick
            end
          end
          object GroupBox50: TGroupBox
            Left = 148
            Top = 8
            Width = 135
            Height = 83
            Caption = #20803#31070#24515#39764#23646#24615#20493#29575
            TabOrder = 1
            object Label113: TLabel
              Left = 8
              Top = 18
              Width = 54
              Height = 12
              Caption = #25915#20987#20493#25968':'
            end
            object Label114: TLabel
              Left = 8
              Top = 47
              Width = 54
              Height = 12
              Caption = #38450#24481#20493#25968':'
            end
            object SpinEdit1: TSpinEdit
              Left = 68
              Top = 15
              Width = 61
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditUpgradeWeaponMaxPointChange
            end
            object SpinEdit2: TSpinEdit
              Left = 68
              Top = 43
              Width = 61
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = EditUpgradeWeaponMaxPointChange
            end
          end
          object GroupBox51: TGroupBox
            Left = 299
            Top = 7
            Width = 135
            Height = 83
            Caption = #20854#20182#35774#32622
            TabOrder = 2
            object Label115: TLabel
              Left = 8
              Top = 18
              Width = 54
              Height = 12
              Caption = #25915#20987#20493#25968':'
            end
            object Label116: TLabel
              Left = 119
              Top = 20
              Width = 12
              Height = 12
              Caption = #31186
            end
            object SpinEdit3: TSpinEdit
              Left = 68
              Top = 15
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditUpgradeWeaponMaxPointChange
            end
          end
          object GroupBox52: TGroupBox
            Left = 11
            Top = 103
            Width = 424
            Height = 115
            Caption = #38215#39764#20540#65295#40657#26263#39764#21147
            TabOrder = 3
            object Label117: TLabel
              Left = 9
              Top = 24
              Width = 84
              Height = 12
              Caption = #38215#39764#20540#28040#32791#36895#24230
            end
            object Label118: TLabel
              Left = 6
              Top = 63
              Width = 108
              Height = 12
              Caption = #26432#24618#22686#21152#38215#39764#20540#20960#29575
            end
            object Label119: TLabel
              Left = 161
              Top = 62
              Width = 66
              Height = 12
              Caption = #65285' '#26368#39640#28857#25968
            end
            object Label120: TLabel
              Left = 284
              Top = 61
              Width = 48
              Height = 12
              Caption = #28857#25968#20960#29575
              Visible = False
            end
            object Label121: TLabel
              Left = 8
              Top = 92
              Width = 156
              Height = 12
              Caption = #22686#21152#40657#26263#39764#21147#25511#21046#65309#38215#39764#20540#65290
            end
            object Label122: TLabel
              Left = 218
              Top = 89
              Width = 12
              Height = 12
              Caption = #65291
            end
            object Label123: TLabel
              Left = 284
              Top = 89
              Width = 60
              Height = 12
              Caption = #65291#38543#26426#28857#25968
            end
            object LabelMagicValue: TLabel
              Left = 403
              Top = 20
              Width = 6
              Height = 12
              Caption = '0'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
            end
            object TrackBar1: TTrackBar
              Left = 117
              Top = 17
              Width = 284
              Height = 39
              Hint = #20026'0'#26102#23558#19981#33258#21160#20943#23569#38215#39764#20540
              Max = 30
              TabOrder = 0
              OnChange = TrackBar1Change
            end
            object EditKillMonAddZMZRate: TSpinEdit
              Left = 120
              Top = 58
              Width = 40
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = EditKillMonAddZMZRateChange
            end
            object EditKillMonAddZMZMAX: TSpinEdit
              Left = 229
              Top = 58
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 2
              Value = 10
              OnChange = EditKillMonAddZMZMAXChange
            end
            object SpinEdit6: TSpinEdit
              Left = 344
              Top = 57
              Width = 61
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 3
              Value = 10
              Visible = False
              OnChange = EditUpgradeWeaponMaxPointChange
            end
            object EditAddDarkZMZ: TSpinEdit
              Left = 167
              Top = 86
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 4
              Value = 10
              OnChange = EditAddDarkZMZChange
            end
            object EditAddDarkofValue: TSpinEdit
              Left = 236
              Top = 85
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 5
              Value = 10
              OnChange = EditAddDarkofValueChange
            end
            object EditAddDarkofRandValue: TSpinEdit
              Left = 350
              Top = 84
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 6
              Value = 10
              OnChange = EditAddDarkofRandValueChange
            end
          end
        end
        object TabSheet46: TTabSheet
          Caption = #35013#22791#38468#39764
          ImageIndex = 1
          object PageControl2: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 228
            ActivePage = TabSheet47
            Align = alClient
            TabOrder = 0
            object TabSheet47: TTabSheet
              Caption = #22266#26412#26399
              object Label136: TLabel
                Left = 14
                Top = 225
                Width = 240
                Height = 12
                Caption = #24403#35013#22791#20026#34915#26381#31867#26102#38468#39764#25152#21152#23646#24615#20026#38450#24481#21644#39764#38450
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox53: TGroupBox
                Left = 6
                Top = 6
                Width = 135
                Height = 212
                Caption = #25112#22763#24515#39764
                TabOrder = 0
                object GroupBox54: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'DC/AC'
                  TabOrder = 0
                  object Label124: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label125: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditDc11: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditDc11Change
                  end
                  object SpinEdit11: TSpinEdit
                    Left = -148
                    Top = 379
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditUpgradeWeaponMaxPointChange
                  end
                  object EditDc11Rate: TSpinEdit
                    Left = 69
                    Top = 43
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 2
                    Value = 10
                    OnChange = EditDc11RateChange
                  end
                end
                object GroupBox55: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'DC2/AC2'
                  TabOrder = 1
                  object Label126: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label127: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditDc21: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditDc21Change
                  end
                  object EditDc21Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditDc21RateChange
                  end
                end
              end
              object GroupBox56: TGroupBox
                Left = 154
                Top = 6
                Width = 135
                Height = 212
                Caption = #27861#24072#24515#39764
                TabOrder = 1
                object GroupBox57: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'MC/MAC'
                  TabOrder = 0
                  object Label128: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label129: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditMc11: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditMc11Change
                  end
                  object EditMc11Rate: TSpinEdit
                    Left = 65
                    Top = 42
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc11RateChange
                  end
                end
                object GroupBox58: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'MC2/MAC2'
                  TabOrder = 1
                  object Label130: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label131: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditMc21: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditMc21Change
                  end
                  object EditMc21Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc21RateChange
                  end
                end
              end
              object GroupBox59: TGroupBox
                Left = 295
                Top = 6
                Width = 135
                Height = 212
                Caption = #36947#22763#24515#39764
                TabOrder = 2
                object GroupBox60: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'SC'
                  TabOrder = 0
                  object Label132: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label133: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditSc11: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditSc11Change
                  end
                  object EditSc11Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditSc11RateChange
                  end
                end
                object GroupBox61: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'SC2'
                  TabOrder = 1
                  object Label134: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label135: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditSc21: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditSc21Change
                  end
                  object EditSc21Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditSc21RateChange
                  end
                end
              end
            end
            object TabSheet48: TTabSheet
              Caption = #22521#20803#26399
              ImageIndex = 1
              object Label149: TLabel
                Left = 14
                Top = 225
                Width = 240
                Height = 12
                Caption = #24403#35013#22791#20026#34915#26381#31867#26102#38468#39764#25152#21152#23646#24615#20026#38450#24481#21644#39764#38450
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox62: TGroupBox
                Left = 6
                Top = 6
                Width = 135
                Height = 212
                Caption = #25112#22763#24515#39764
                TabOrder = 0
                object GroupBox63: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'DC/AC'
                  TabOrder = 0
                  object Label137: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label138: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditDc12: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditDc12Change
                  end
                  object EditDc12Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditDc12RateChange
                  end
                end
                object GroupBox64: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'DC2/AC2'
                  TabOrder = 1
                  object Label139: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label140: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditDc22: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditDc22Change
                  end
                  object EditDc22Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditDc22RateChange
                  end
                end
              end
              object GroupBox65: TGroupBox
                Left = 154
                Top = 6
                Width = 135
                Height = 212
                Caption = #27861#24072#24515#39764
                TabOrder = 1
                object GroupBox66: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'MC/MAC'
                  TabOrder = 0
                  object Label141: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label142: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditMc12: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditMc12Change
                  end
                  object EditMc12Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc12RateChange
                  end
                end
                object GroupBox67: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'MC2/MAC2'
                  TabOrder = 1
                  object Label143: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label144: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditMc22: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditMc22Change
                  end
                  object EditMc22Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc22RateChange
                  end
                end
              end
              object GroupBox68: TGroupBox
                Left = 295
                Top = 6
                Width = 135
                Height = 212
                Caption = #36947#22763#24515#39764
                TabOrder = 2
                object GroupBox69: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'SC'
                  TabOrder = 0
                  object Label145: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label146: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object Editsc12: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = Editsc12Change
                  end
                  object Editsc12Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = Editsc12RateChange
                  end
                end
                object GroupBox70: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'SC2'
                  TabOrder = 1
                  object Label147: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label148: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object Editsc22: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = Editsc22Change
                  end
                  object Editsc22Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = Editsc22RateChange
                  end
                end
              end
            end
            object TabSheet49: TTabSheet
              Caption = #26126#24515#26399
              ImageIndex = 2
              object Label162: TLabel
                Left = 14
                Top = 225
                Width = 240
                Height = 12
                Caption = #24403#35013#22791#20026#34915#26381#31867#26102#38468#39764#25152#21152#23646#24615#20026#38450#24481#21644#39764#38450
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox71: TGroupBox
                Left = 6
                Top = 6
                Width = 135
                Height = 212
                Caption = #25112#22763#24515#39764
                TabOrder = 0
                object GroupBox72: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'DC/AC'
                  TabOrder = 0
                  object Label150: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label151: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object Editdc13: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = Editdc13Change
                  end
                  object Editdc13Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = Editdc13RateChange
                  end
                end
                object GroupBox73: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'DC2/AC2'
                  TabOrder = 1
                  object Label152: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label153: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object editdc23: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = editdc23Change
                  end
                  object EditDc23Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditDc23RateChange
                  end
                end
              end
              object GroupBox74: TGroupBox
                Left = 154
                Top = 6
                Width = 135
                Height = 212
                Caption = #27861#24072#24515#39764
                TabOrder = 1
                object GroupBox75: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'MC/MAC'
                  TabOrder = 0
                  object Label154: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label155: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditMc13: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditMc13Change
                  end
                  object EditMc13Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc13RateChange
                  end
                end
                object GroupBox76: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'MC2/MAC2'
                  TabOrder = 1
                  object Label156: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label157: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditMc23: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditMc23Change
                  end
                  object EditMc23Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc23RateChange
                  end
                end
              end
              object GroupBox77: TGroupBox
                Left = 295
                Top = 6
                Width = 135
                Height = 212
                Caption = #36947#22763#24515#39764
                TabOrder = 2
                object GroupBox78: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'SC'
                  TabOrder = 0
                  object Label158: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label159: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object Editsc13: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = Editsc13Change
                  end
                  object Editsc13Rate: TSpinEdit
                    Left = 67
                    Top = 44
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = Editsc13RateChange
                  end
                end
                object GroupBox79: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'SC2'
                  TabOrder = 1
                  object Label160: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label161: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object Editsc23: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = Editsc23Change
                  end
                  object EditSc23Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditSc23RateChange
                  end
                end
              end
            end
            object TabSheet50: TTabSheet
              Caption = #22823#24735#26399
              ImageIndex = 3
              object Label175: TLabel
                Left = 14
                Top = 225
                Width = 240
                Height = 12
                Caption = #24403#35013#22791#20026#34915#26381#31867#26102#38468#39764#25152#21152#23646#24615#20026#38450#24481#21644#39764#38450
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox80: TGroupBox
                Left = 6
                Top = 6
                Width = 135
                Height = 212
                Caption = #25112#22763#24515#39764
                TabOrder = 0
                object GroupBox81: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'DC/AC'
                  TabOrder = 0
                  object Label163: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label164: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditDc14: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditDc14Change
                  end
                  object EditDc14Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditDc14RateChange
                  end
                end
                object GroupBox82: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'DC2/AC2'
                  TabOrder = 1
                  object Label165: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label166: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditDc24: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditDc24Change
                  end
                  object EditDc24Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditDc24RateChange
                  end
                end
              end
              object GroupBox83: TGroupBox
                Left = 154
                Top = 6
                Width = 135
                Height = 212
                Caption = #27861#24072#24515#39764
                TabOrder = 1
                object GroupBox84: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'MC/MAC'
                  TabOrder = 0
                  object Label167: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label168: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditMc14: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditMc14Change
                  end
                  object EditMc14Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc14RateChange
                  end
                end
                object GroupBox85: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'MC2/MAC2'
                  TabOrder = 1
                  object Label169: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label170: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object Editmc24: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = Editmc24Change
                  end
                  object EditMc24Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc24RateChange
                  end
                end
              end
              object GroupBox86: TGroupBox
                Left = 295
                Top = 6
                Width = 135
                Height = 212
                Caption = #36947#22763#24515#39764
                TabOrder = 2
                object GroupBox87: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'SC'
                  TabOrder = 0
                  object Label171: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label172: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object Editsc14: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = Editsc14Change
                  end
                  object Editsc14Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = Editsc14RateChange
                  end
                end
                object GroupBox88: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'SC2'
                  TabOrder = 1
                  object Label173: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label174: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object Editsc24: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = Editsc24Change
                  end
                  object Editsc24Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = Editsc24RateChange
                  end
                end
              end
            end
            object TabSheet51: TTabSheet
              Caption = #39134#21319#26399
              ImageIndex = 4
              object Label188: TLabel
                Left = 14
                Top = 225
                Width = 240
                Height = 12
                Caption = #24403#35013#22791#20026#34915#26381#31867#26102#38468#39764#25152#21152#23646#24615#20026#38450#24481#21644#39764#38450
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object GroupBox89: TGroupBox
                Left = 6
                Top = 6
                Width = 135
                Height = 212
                Caption = #25112#22763#24515#39764
                TabOrder = 0
                object GroupBox90: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'DC/AC'
                  TabOrder = 0
                  object Label176: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label177: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditDC15: TSpinEdit
                    Left = 69
                    Top = 14
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditDC15Change
                  end
                  object EditDc15Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditDc15RateChange
                  end
                end
                object GroupBox91: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'DC2/AC2'
                  TabOrder = 1
                  object Label178: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label179: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditDc25: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditDc25Change
                  end
                  object EditDc25Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditDc25RateChange
                  end
                end
              end
              object GroupBox92: TGroupBox
                Left = 154
                Top = 6
                Width = 135
                Height = 212
                Caption = #27861#24072#24515#39764
                TabOrder = 1
                object GroupBox93: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'MC/MAC'
                  TabOrder = 0
                  object Label180: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label181: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditMc15: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditMc15Change
                  end
                  object EditMc15Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc15RateChange
                  end
                end
                object GroupBox94: TGroupBox
                  Left = 8
                  Top = 109
                  Width = 124
                  Height = 83
                  Caption = 'MC2/MAC2'
                  TabOrder = 1
                  object Label182: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label183: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditMc25: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditMc25Change
                  end
                  object EditMc25Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditMc25RateChange
                  end
                end
              end
              object GroupBox95: TGroupBox
                Left = 295
                Top = 6
                Width = 135
                Height = 212
                Caption = #36947#22763#24515#39764
                TabOrder = 2
                object GroupBox96: TGroupBox
                  Left = 5
                  Top = 15
                  Width = 124
                  Height = 83
                  Caption = 'SC'
                  TabOrder = 0
                  object Label184: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label185: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditSc15: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditSc15Change
                  end
                  object EditSc15Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditSc15RateChange
                  end
                end
                object GroupBox97: TGroupBox
                  Left = 8
                  Top = 110
                  Width = 124
                  Height = 83
                  Caption = 'SC2'
                  TabOrder = 1
                  object Label186: TLabel
                    Left = 8
                    Top = 18
                    Width = 48
                    Height = 12
                    Caption = #26368#39640#28857#25968
                  end
                  object Label187: TLabel
                    Left = 8
                    Top = 47
                    Width = 48
                    Height = 12
                    Caption = #28857#25968#20960#29575
                  end
                  object EditSc25: TSpinEdit
                    Left = 68
                    Top = 15
                    Width = 49
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = EditSc25Change
                  end
                  object EditSc25Rate: TSpinEdit
                    Left = 68
                    Top = 43
                    Width = 50
                    Height = 21
                    EditorEnabled = False
                    MaxValue = 1000
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = EditSc25RateChange
                  end
                end
              end
            end
          end
        end
        object TabSheet15: TTabSheet
          Caption = #31070#23041#29425
          ImageIndex = 2
          object GroupBox111: TGroupBox
            Left = 7
            Top = 8
            Width = 216
            Height = 115
            Caption = #38215#39764#31526
            TabOrder = 0
            object Label217: TLabel
              Left = 15
              Top = 40
              Width = 120
              Height = 12
              Caption = #26368#22810#20801#35768#21484#21796#24515#39764#25968#37327
            end
            object Label219: TLabel
              Left = 86
              Top = 65
              Width = 132
              Height = 12
              Caption = #25104#21151#20960#29575'            '#65285
            end
            object Label220: TLabel
              Left = 14
              Top = 91
              Width = 120
              Height = 12
              Caption = #20923#32467#26102#38388#65306#38215#39764#20540'/10*'
            end
            object CheckBox_CanRecallEvil: TCheckBox
              Left = 8
              Top = 14
              Width = 143
              Height = 17
              Caption = #20801#35768#20351#29992#38215#39764#31526#21484#24515#39764
              TabOrder = 0
              OnClick = CheckBox_CanRecallEvilClick
            end
            object Edit_MaxRecallEvilCount: TSpinEdit
              Left = 159
              Top = 34
              Width = 45
              Height = 21
              Hint = #26368#22810#20801#35768#20351#29992#38215#39764#31526'/'#38215#39764#31070#31526' '#21484#21796#24515#39764#25968#37327
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
            object Edit_RecallEvilRate: TSpinEdit
              Left = 157
              Top = 60
              Width = 45
              Height = 21
              Hint = #20351#29992#38215#39764#31526'/'#38215#39764#31070#31526' '#21484#21796#24515#39764#25104#21151#30340#27010#29575' '#30334#20998#27604
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
            object Edit_AntiEvilDontMoveTime: TSpinEdit
              Left = 159
              Top = 87
              Width = 45
              Height = 21
              Hint = #24515#39764#34987#38215#39764#31526#25915#20987#21518#20923#32467#26102#38388#65292#21333#20301#20026#31186
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 3
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
          end
          object GroupBox112: TGroupBox
            Left = 3
            Top = 126
            Width = 215
            Height = 94
            Caption = #24515#39764#25511#21046
            TabOrder = 1
            object Label221: TLabel
              Left = 21
              Top = 19
              Width = 120
              Height = 12
              Caption = #26368#22823#38656#35201#38215#39764#21147#28857#25968#65306
            end
            object Label222: TLabel
              Left = 10
              Top = 45
              Width = 132
              Height = 12
              Caption = #38215#39764#21147#27599'10'#31186#28040#32791#28857#25968#65306
            end
            object Label223: TLabel
              Left = 21
              Top = 70
              Width = 120
              Height = 12
              Caption = #22870#21169#27744#20840#28385#38656#35201#28857#25968#65306
            end
            object Edit_EvilCtrlMaxPower: TSpinEdit
              Left = 159
              Top = 13
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
            object Edit_EvilCtrl10SecDecPower: TSpinEdit
              Left = 159
              Top = 39
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
            object Edit_EvilHellGifMaxValue: TSpinEdit
              Left = 159
              Top = 66
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 2
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
          end
          object GroupBox113: TGroupBox
            Left = 228
            Top = 15
            Width = 210
            Height = 104
            Caption = #24515#39764#32477#26432
            TabOrder = 2
            object Label224: TLabel
              Left = 21
              Top = 19
              Width = 96
              Height = 12
              Caption = #28040#32791#38215#39764#21147#28857#25968#65306
            end
            object Label225: TLabel
              Left = 21
              Top = 39
              Width = 96
              Height = 12
              Caption = #24515#39764#25915#20987#21147#20493#25968#65306
            end
            object Label226: TLabel
              Left = 9
              Top = 59
              Width = 108
              Height = 12
              Caption = #24618#29289#20923#32467#26102#38388'('#31186')'#65306
            end
            object Label227: TLabel
              Left = 9
              Top = 80
              Width = 108
              Height = 12
              Caption = #20351#29992#38388#38548#26102#38388'('#31186')'#65306
            end
            object Edit_EvilUniQueSkillDecPower: TSpinEdit
              Left = 124
              Top = 12
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
            object Edit_EvilUniQueSkillRate: TSpinEdit
              Left = 124
              Top = 33
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
            object Edit_EvilUniQueSkillDontMoveTime: TSpinEdit
              Left = 124
              Top = 54
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 2
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
            object Edit_UseEvilUniQueSkillTick: TSpinEdit
              Left = 124
              Top = 77
              Width = 45
              Height = 21
              EditorEnabled = False
              MaxValue = 1000
              MinValue = 1
              TabOrder = 3
              Value = 10
              OnChange = Edit_MaxRecallEvilCountChange
            end
          end
        end
      end
      object BtnEvilSave: TButton
        Left = 341
        Top = 267
        Width = 75
        Height = 25
        Caption = #20445#23384
        TabOrder = 1
        OnClick = BtnEvilSaveClick
      end
    end
  end
end
