object Formbackup: TFormbackup
  Left = 199
  Top = 120
  Width = 306
  Height = 209
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #33258#21160#22791#20221
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 113
    TabOrder = 0
    object Label2: TLabel
      Left = 24
      Top = 41
      Width = 48
      Height = 13
      Caption = #22791#20221#26102#38388
    end
    object Label1: TLabel
      Left = 24
      Top = 72
      Width = 48
      Height = 13
      Caption = #22791#20221#30446#24405
    end
    object ComboBox_Day: TComboBox
      Left = 78
      Top = 38
      Width = 83
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = #27599#22825
      Items.Strings = (
        #27599#22825
        #21608#26085
        #21608#19968
        #21608#20108
        #21608#19977
        #21608#22235
        #21608#20116
        #21608#20845
        '')
    end
    object RbtnDay: TRadioButton
      Left = 24
      Top = 15
      Width = 113
      Height = 17
      Caption = #27599#22825#22791#20221
      TabOrder = 1
    end
    object RbtnWeek: TRadioButton
      Left = 160
      Top = 15
      Width = 113
      Height = 17
      Caption = #27599#21608#22791#20221
      TabOrder = 2
    end
    object DateTimePicker1: TDateTimePicker
      Left = 176
      Top = 38
      Width = 89
      Height = 21
      Date = 39699.804240081020000000
      Time = 39699.804240081020000000
      Kind = dtkTime
      TabOrder = 3
    end
    object Edit_BackUpPath: TEdit
      Left = 78
      Top = 67
      Width = 163
      Height = 21
      TabOrder = 4
      Text = 'Edit_BackUpPath'
    end
    object Button1: TButton
      Left = 240
      Top = 65
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  object Cbx_BackUpEnable: TCheckBox
    Left = 19
    Top = 2
    Width = 97
    Height = 17
    Caption = #21551#29992#33258#21160#22791#20221
    TabOrder = 1
    OnClick = Cbx_BackUpEnableClick
  end
  object BtnOK: TButton
    Left = 73
    Top = 134
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 2
    OnClick = BtnOKClick
  end
  object Button2: TButton
    Left = 168
    Top = 134
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    OnClick = Button2Click
  end
end
