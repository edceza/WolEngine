object FrmRegSoft: TFrmRegSoft
  Left = 308
  Top = 424
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #27880#20876
  ClientHeight = 163
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 210
    Height = 12
    Caption = #20506#22825#32593#28216#24037#20316#23460#21830#19994#24341#25806#37197#22871#31243#24207'V1.04'
  end
  object Label2: TLabel
    Left = 16
    Top = 32
    Width = 48
    Height = 12
    Caption = #30828#20214#30721#65306
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 48
    Height = 12
    Caption = #27880#20876#30721#65306
  end
  object Edit1: TEdit
    Left = 64
    Top = 28
    Width = 161
    Height = 20
    Color = clAqua
    ReadOnly = True
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 64
    Top = 56
    Width = 161
    Height = 73
    TabOrder = 1
  end
  object Button1: TButton
    Left = 88
    Top = 131
    Width = 67
    Height = 25
    Caption = #27880#20876
    TabOrder = 2
    OnClick = Button1Click
  end
end
