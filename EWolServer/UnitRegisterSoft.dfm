object FrmRegister: TFrmRegister
  Left = 395
  Top = 152
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #27880#20876'V1.5'
  ClientHeight = 134
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 251
    Height = 134
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 48
      Height = 12
      Caption = #28216#25103#21517#65306
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 48
      Height = 12
      Caption = #26412#26426#30721#65306
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 48
      Height = 12
      Caption = #27880#20876#30721#65306
    end
    object BtOK: TSpeedButton
      Left = 48
      Top = 104
      Width = 65
      Height = 22
      Caption = #30830#23450'(&O)'
      OnClick = BtOKClick
    end
    object BtESC: TSpeedButton
      Left = 144
      Top = 104
      Width = 65
      Height = 22
      Caption = #36864#20986'(&E)'
      OnClick = BtESCClick
    end
    object EditRegName: TEdit
      Left = 64
      Top = 20
      Width = 171
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
      TabOrder = 0
    end
    object EditHID: TEdit
      Left = 64
      Top = 44
      Width = 171
      Height = 20
      Color = clSkyBlue
      ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
      ReadOnly = True
      TabOrder = 1
    end
    object EditRegCode: TEdit
      Left = 64
      Top = 68
      Width = 171
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#20116#31508#21152#21152
      TabOrder = 2
    end
  end
end
