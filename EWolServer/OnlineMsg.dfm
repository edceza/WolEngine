object frmOnlineMsg: TfrmOnlineMsg
  Left = 251
  Top = 136
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #22312#32447#21457#36865#28040#24687
  ClientHeight = 332
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 4
    Top = 169
    Width = 54
    Height = 12
    Caption = #22312#32447#20449#24687':'
  end
  object ComboBoxMsg: TComboBox
    Left = 63
    Top = 165
    Width = 374
    Height = 20
    Style = csSimple
    ItemHeight = 12
    TabOrder = 0
    OnChange = ComboBoxMsgChange
    OnKeyPress = ComboBoxMsgKeyPress
  end
  object MemoMsg: TMemo
    Left = 3
    Top = 4
    Width = 434
    Height = 153
    Lines.Strings = (
      'MemoMsg')
    TabOrder = 1
    OnChange = MemoMsgChange
  end
  object StringGrid: TStringGrid
    Left = 3
    Top = 219
    Width = 434
    Height = 106
    ColCount = 1
    DefaultColWidth = 430
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    ScrollBars = ssVertical
    TabOrder = 2
    OnClick = StringGridClick
    OnDblClick = StringGridDblClick
  end
  object ButtonAdd: TButton
    Left = 367
    Top = 191
    Width = 67
    Height = 23
    Caption = #22686#21152'(&A)'
    Enabled = False
    TabOrder = 3
    OnClick = ButtonAddClick
  end
  object ButtonDelete: TButton
    Left = 293
    Top = 191
    Width = 67
    Height = 23
    Caption = #21024#38500'(&D)'
    Enabled = False
    TabOrder = 4
    OnClick = ButtonDeleteClick
  end
  object ButtonSend: TButton
    Left = 212
    Top = 191
    Width = 67
    Height = 23
    Caption = #21457#36865'(&S)'
    TabOrder = 5
    OnClick = ButtonSendClick
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 194
    Width = 73
    Height = 17
    Caption = #32418#23383
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object CheckBox2: TCheckBox
    Left = 56
    Top = 194
    Width = 57
    Height = 17
    Caption = #28418#28014
    TabOrder = 7
  end
  object CheckBox3: TCheckBox
    Left = 104
    Top = 194
    Width = 57
    Height = 17
    Caption = #21491#23637
    TabOrder = 8
  end
  object CheckBox4: TCheckBox
    Left = 152
    Top = 194
    Width = 49
    Height = 17
    Caption = #39030#37096
    TabOrder = 9
  end
end
