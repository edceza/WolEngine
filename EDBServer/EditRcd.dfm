object frmEditRcd: TfrmEditRcd
  Left = 400
  Top = 41
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #32534#36753#20154#29289#25968#25454
  ClientHeight = 312
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 433
    Height = 265
    ActivePage = TabSheet7
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #26222#36890
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 217
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #20154#29289#21517#31216':'
        end
        object Label2: TLabel
          Left = 8
          Top = 68
          Width = 54
          Height = 12
          Caption = #30331#24405#24080#21495':'
        end
        object Label3: TLabel
          Left = 8
          Top = 92
          Width = 54
          Height = 12
          Caption = #20179#24211#23494#30721':'
        end
        object Label4: TLabel
          Left = 8
          Top = 116
          Width = 54
          Height = 12
          Caption = #37197#20598#21517#31216':'
        end
        object Label5: TLabel
          Left = 8
          Top = 140
          Width = 54
          Height = 12
          Caption = #24072#24466#21517#31216':'
        end
        object Label11: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 12
          Caption = #32034#24341#21495#30721':'
        end
        object Label12: TLabel
          Left = 168
          Top = 20
          Width = 54
          Height = 12
          Caption = #24403#21069#22320#22270':'
        end
        object Label13: TLabel
          Left = 168
          Top = 44
          Width = 54
          Height = 12
          Caption = #24403#21069#24231#26631':'
        end
        object Label14: TLabel
          Left = 168
          Top = 68
          Width = 54
          Height = 12
          Caption = #22238#22478#22320#22270':'
        end
        object Label15: TLabel
          Left = 168
          Top = 92
          Width = 54
          Height = 12
          Caption = #22238#22478#24231#26631':'
        end
        object Label19: TLabel
          Left = 185
          Top = 138
          Width = 48
          Height = 12
          Caption = #20851#32852#35282#33394
        end
        object EditChrName: TEdit
          Left = 64
          Top = 40
          Width = 97
          Height = 20
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 0
        end
        object EditAccount: TEdit
          Left = 64
          Top = 64
          Width = 97
          Height = 20
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 1
        end
        object EditPassword: TEdit
          Left = 64
          Top = 88
          Width = 97
          Height = 20
          TabOrder = 2
          OnChange = EditPasswordChange
        end
        object EditDearName: TEdit
          Left = 64
          Top = 112
          Width = 97
          Height = 20
          TabOrder = 3
          OnChange = EditPasswordChange
        end
        object EditMasterName: TEdit
          Left = 64
          Top = 136
          Width = 97
          Height = 20
          TabOrder = 4
          OnChange = EditPasswordChange
        end
        object EditIdx: TEdit
          Left = 64
          Top = 16
          Width = 97
          Height = 20
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 5
        end
        object EditCurMap: TEdit
          Left = 224
          Top = 16
          Width = 97
          Height = 20
          TabOrder = 6
          OnChange = EditPasswordChange
        end
        object EditCurX: TSpinEdit
          Left = 224
          Top = 40
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditCurY: TSpinEdit
          Left = 272
          Top = 40
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditHomeMap: TEdit
          Left = 224
          Top = 64
          Width = 97
          Height = 20
          TabOrder = 9
          OnClick = EditPasswordChange
        end
        object EditHomeX: TSpinEdit
          Left = 224
          Top = 88
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 10
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditHomeY: TSpinEdit
          Left = 272
          Top = 88
          Width = 49
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 11
          Value = 0
          OnChange = EditPasswordChange
        end
        object CheckBoxIsMaster: TCheckBox
          Left = 64
          Top = 160
          Width = 57
          Height = 17
          Caption = #24072#29238
          TabOrder = 12
          OnClick = EditPasswordChange
        end
        object guanlianEdit: TEdit
          Left = 240
          Top = 136
          Width = 81
          Height = 20
          TabOrder = 13
          OnChange = EditPasswordChange
        end
        object RadioButtonYS: TRadioButton
          Left = 200
          Top = 112
          Width = 73
          Height = 17
          Caption = #20803#31070
          TabOrder = 14
        end
        object RadioButtonPLayer: TRadioButton
          Left = 280
          Top = 112
          Width = 65
          Height = 17
          Caption = #20154#29289
          Checked = True
          TabOrder = 15
          TabStop = True
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25968#25454
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 217
        TabOrder = 0
        object Label6: TLabel
          Left = 8
          Top = 20
          Width = 30
          Height = 12
          Caption = #31561#32423':'
        end
        object Label7: TLabel
          Left = 8
          Top = 44
          Width = 30
          Height = 12
          Caption = #37329#24065':'
        end
        object Label8: TLabel
          Left = 8
          Top = 68
          Width = 30
          Height = 12
          Caption = #20803#23453':'
        end
        object Label9: TLabel
          Left = 8
          Top = 92
          Width = 42
          Height = 12
          Caption = #28216#25103#28857':'
        end
        object Label16: TLabel
          Left = 8
          Top = 140
          Width = 42
          Height = 12
          Caption = #22768#26395#28857':'
        end
        object Label10: TLabel
          Left = 8
          Top = 116
          Width = 42
          Height = 12
          Caption = #20805#20540#28857':'
        end
        object Label17: TLabel
          Left = 8
          Top = 164
          Width = 30
          Height = 12
          Caption = 'PK'#28857':'
        end
        object Label18: TLabel
          Left = 8
          Top = 188
          Width = 42
          Height = 12
          Caption = #36129#29486#24230':'
        end
        object EditLevel: TSpinEdit
          Left = 64
          Top = 16
          Width = 65
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGold: TSpinEdit
          Left = 64
          Top = 40
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGameGold: TSpinEdit
          Left = 64
          Top = 64
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditGamePoint: TSpinEdit
          Left = 64
          Top = 88
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditCreditPoint: TSpinEdit
          Left = 64
          Top = 136
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditPayPoint: TSpinEdit
          Left = 64
          Top = 112
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditPKPoint: TSpinEdit
          Left = 64
          Top = 160
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = EditPasswordChange
        end
        object EditContribution: TSpinEdit
          Left = 64
          Top = 184
          Width = 65
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnChange = EditPasswordChange
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25216#33021
      ImageIndex = 2
      OnEnter = TabSheet3Enter
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 217
        TabOrder = 0
        object ListViewMagic: TListView
          Left = 8
          Top = 16
          Width = 345
          Height = 185
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #25216#33021
            end
            item
              Caption = #25216#33021#21517#31216
              Width = 80
            end
            item
              Caption = #31561#32423
              Width = 40
            end
            item
              Caption = #20462#28860#28857
              Width = 60
            end
            item
              Caption = #24555#25463#38190
            end>
          GridLines = True
          RowSelect = True
          PopupMenu = PopupMenu1
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #35013#22791
      ImageIndex = 3
      OnEnter = TabSheet4Enter
      object GroupBox4: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 217
        TabOrder = 0
        object ListViewUserItem: TListView
          Left = 8
          Top = 16
          Width = 393
          Height = 185
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #26631#35782#24207#21495
              Width = 80
            end
            item
              Caption = #29289#21697
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 80
            end
            item
              Alignment = taCenter
              Caption = #25345#20037
              Width = 90
            end
            item
              Caption = #21442#25968
              Width = 220
            end>
          GridLines = True
          RowSelect = True
          PopupMenu = PopupMenu1
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #20179#24211
      ImageIndex = 4
      OnEnter = TabSheet5Enter
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 217
        TabOrder = 0
        object ListViewStorage: TListView
          Left = 8
          Top = 16
          Width = 393
          Height = 185
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #26631#35782#24207#21495
              Width = 80
            end
            item
              Caption = #29289#21697
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 80
            end
            item
              Alignment = taCenter
              Caption = #25345#20037
              Width = 90
            end
            item
              Caption = #21442#25968
              Width = 220
            end>
          GridLines = True
          RowSelect = True
          PopupMenu = PopupMenu1
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #32972#21253
      ImageIndex = 5
      OnEnter = TabSheet6Enter
      object GroupBox6: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 217
        TabOrder = 0
        object ListViewBag: TListView
          Left = 8
          Top = 16
          Width = 393
          Height = 185
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #26631#35782#24207#21495
              Width = 80
            end
            item
              Caption = #29289#21697
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 80
            end
            item
              Alignment = taCenter
              Caption = #25345#20037
              Width = 90
            end
            item
              Caption = #21442#25968
              Width = 220
            end>
          GridLines = True
          RowSelect = True
          PopupMenu = PopupMenu1
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #23456#29289#32972#21253
      ImageIndex = 6
      OnEnter = TabSheet7Enter
      object GroupBox7: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 217
        TabOrder = 0
        object ListViewMonBag: TListView
          Left = 8
          Top = 16
          Width = 393
          Height = 185
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #26631#35782#24207#21495
              Width = 80
            end
            item
              Caption = #29289#21697
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 80
            end
            item
              Alignment = taCenter
              Caption = #25345#20037
              Width = 90
            end
            item
              Caption = #21442#25968
              Width = 220
            end>
          GridLines = True
          RowSelect = True
          PopupMenu = PopupMenu1
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
    end
  end
  object ButtonSaveData: TButton
    Left = 8
    Top = 280
    Width = 81
    Height = 25
    Caption = #20445#23384#20462#25913'(&S)'
    TabOrder = 1
    OnClick = ButtonExportDataClick
  end
  object ButtonExportData: TButton
    Left = 96
    Top = 280
    Width = 81
    Height = 25
    Caption = #23548#20986#25968#25454'(&E)'
    TabOrder = 2
    OnClick = ButtonExportDataClick
  end
  object ButtonImportData: TButton
    Left = 184
    Top = 280
    Width = 81
    Height = 25
    Caption = #23548#20837#25968#25454'(&I)'
    TabOrder = 3
    OnClick = ButtonExportDataClick
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'hum'
    Filter = #20154#29289#25968#25454' (*.hum)|*.hum'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 296
    Top = 280
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'hum'
    Filter = #20154#29289#25968#25454' (*.hum)|*.hum'
    Left = 336
    Top = 280
  end
  object PopupMenu1: TPopupMenu
    Left = 356
    Top = 79
    object N1: TMenuItem
      Caption = #21024#38500
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
  end
end
