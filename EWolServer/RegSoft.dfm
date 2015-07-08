object FrmRegSoft: TFrmRegSoft
  Left = 399
  Top = 329
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #27880#20876
  ClientHeight = 166
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 395
    Height = 166
    Align = alClient
    TabOrder = 0
    object Button1: TButton
      Left = 150
      Top = 127
      Width = 67
      Height = 25
      Caption = #30830#23450
      TabOrder = 0
      OnClick = Button1Click
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 377
      Height = 105
      Caption = #25480#26435#20449#24687
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 48
        Height = 12
        Caption = #30828#20214#20449#24687
      end
      object Label2: TLabel
        Left = 16
        Top = 50
        Width = 48
        Height = 12
        Caption = #27880#20876#26631#35782
      end
      object Label3: TLabel
        Left = 16
        Top = 76
        Width = 48
        Height = 12
        Caption = #27880#20876#22825#25968
      end
      object Label4: TLabel
        Left = 177
        Top = 76
        Width = 48
        Height = 12
        Caption = #21040#26399#26085#26399
      end
      object Edit_HardId: TEdit
        Left = 70
        Top = 21
        Width = 304
        Height = 20
        Color = clScrollBar
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 70
        Top = 47
        Width = 304
        Height = 20
        Color = clScrollBar
        TabOrder = 1
      end
      object Edit3: TEdit
        Left = 70
        Top = 73
        Width = 99
        Height = 20
        Color = clScrollBar
        TabOrder = 2
      end
      object DateTimePicker1: TDateTimePicker
        Left = 234
        Top = 72
        Width = 137
        Height = 20
        Date = 40186.513081770830000000
        Time = 40186.513081770830000000
        TabOrder = 3
      end
    end
  end
end
