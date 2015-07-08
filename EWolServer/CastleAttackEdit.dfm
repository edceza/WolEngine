object FormCastleAttackEdit: TFormCastleAttackEdit
  Left = 383
  Top = 328
  Width = 389
  Height = 184
  BorderIcons = [biSystemMenu]
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 160
    Top = 131
    Width = 192
    Height = 12
    Caption = #22686#21152#25915#22478#34892#20250#65292#35831#21452#20987#24038#36793#34892#20250#21015#34920
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 160
    Top = 8
    Width = 217
    Height = 89
    Caption = #25915#22478#30003#35831
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 48
      Height = 12
      Caption = #34892#20250#21517#31216
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 54
      Height = 12
      Caption = #25915#22478#26085#26399' '
    end
    object Label3: TLabel
      Left = 8
      Top = 72
      Width = 138
      Height = 12
      Caption = #35831#27491#30830#36873#25321#25915#22478#25112#26085#26399'...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object EditName: TEdit
      Left = 74
      Top = 19
      Width = 127
      Height = 20
      Color = clAqua
      ReadOnly = True
      TabOrder = 0
    end
    object DateTimePicker1: TDateTimePicker
      Left = 74
      Top = 47
      Width = 127
      Height = 20
      Date = 39259.476797592600000000
      Time = 39259.476797592600000000
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 161
    Top = 100
    Width = 75
    Height = 25
    Caption = #30830#23450
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 145
    Height = 137
    Caption = #25152#26377#34892#20250#21015#34920
    TabOrder = 2
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 129
      Height = 113
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = ListBox1DblClick
    end
  end
  object CBXAll: TCheckBox
    Left = 264
    Top = 108
    Width = 97
    Height = 17
    Caption = #25152#26377#34892#20250
    TabOrder = 3
  end
end
