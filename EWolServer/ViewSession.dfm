object frmViewSession: TfrmViewSession
  Left = 351
  Top = 290
  Width = 393
  Height = 210
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #26597#30475#20840#23616#20250#35805
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object ButtonRefGrid: TButton
    Left = 8
    Top = 144
    Width = 73
    Height = 25
    Caption = #21047#26032'(&R)'
    TabOrder = 0
    OnClick = ButtonRefGridClick
  end
  object PanelStatus: TPanel
    Left = 8
    Top = 8
    Width = 369
    Height = 129
    TabOrder = 1
    object GridSession: TStringGrid
      Left = 0
      Top = 0
      Width = 369
      Height = 129
      ColCount = 6
      DefaultRowHeight = 18
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      ColWidths = (
        34
        83
        86
        56
        44
        58)
    end
  end
end
