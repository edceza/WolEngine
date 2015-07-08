object FrmAddGroup: TFrmAddGroup
  Left = 461
  Top = 240
  Width = 294
  Height = 213
  BorderIcons = [biSystemMenu]
  Caption = #22686#21152#25915#22478#34892#20250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 273
    Height = 169
    Caption = #25152#26377#34892#20250#21015#34920
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 62
      Top = 116
      Width = 12
      Height = 12
      Caption = #24180
    end
    object Label2: TLabel
      Left = 126
      Top = 116
      Width = 12
      Height = 12
      Caption = #26376
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 192
      Top = 116
      Width = 12
      Height = 12
      Caption = #26085
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 208
      Top = 116
      Width = 48
      Height = 12
      Caption = #20030#34892#25915#22478
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 257
      Height = 89
      ItemHeight = 12
      TabOrder = 0
    end
    object SpinEdit1: TSpinEdit
      Left = 8
      Top = 112
      Width = 49
      Height = 21
      MaxValue = 2009
      MinValue = 2002
      TabOrder = 1
      Value = 2002
    end
    object SpinEdit2: TSpinEdit
      Left = 80
      Top = 112
      Width = 41
      Height = 21
      MaxValue = 12
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
    object SpinEdit3: TSpinEdit
      Left = 144
      Top = 112
      Width = 41
      Height = 21
      MaxValue = 30
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object Button1: TButton
      Left = 8
      Top = 136
      Width = 57
      Height = 25
      Caption = #30830#23450
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 208
      Top = 136
      Width = 51
      Height = 25
      Caption = #21462#28040
      TabOrder = 5
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 96
      Top = 136
      Width = 75
      Height = 25
      Caption = #22686#21152#25152#26377
      TabOrder = 6
    end
  end
end
