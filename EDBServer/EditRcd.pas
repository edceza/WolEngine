unit EditRcd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Grobal2, ComCtrls, StdCtrls, Spin, Menus,localDb;

type
  TfrmEditRcd = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditChrName: TEdit;
    Label2: TLabel;
    EditAccount: TEdit;
    Label3: TLabel;
    EditPassword: TEdit;
    Label4: TLabel;
    EditDearName: TEdit;
    Label5: TLabel;
    EditMasterName: TEdit;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    EditIdx: TEdit;
    Label12: TLabel;
    EditCurMap: TEdit;
    Label13: TLabel;
    EditCurX: TSpinEdit;
    EditCurY: TSpinEdit;
    Label14: TLabel;
    Label15: TLabel;
    EditHomeMap: TEdit;
    EditHomeX: TSpinEdit;
    EditHomeY: TSpinEdit;
    EditLevel: TSpinEdit;
    EditGold: TSpinEdit;
    EditGameGold: TSpinEdit;
    EditGamePoint: TSpinEdit;
    Label16: TLabel;
    EditCreditPoint: TSpinEdit;
    Label10: TLabel;
    EditPayPoint: TSpinEdit;
    Label17: TLabel;
    EditPKPoint: TSpinEdit;
    Label18: TLabel;
    EditContribution: TSpinEdit;
    GroupBox3: TGroupBox;
    ListViewMagic: TListView;
    GroupBox4: TGroupBox;
    ListViewUserItem: TListView;
    GroupBox5: TGroupBox;
    ListViewStorage: TListView;
    ButtonSaveData: TButton;
    ButtonExportData: TButton;
    ButtonImportData: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    CheckBoxIsMaster: TCheckBox;
    TabSheet6: TTabSheet;
    GroupBox6: TGroupBox;
    ListViewBag: TListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    guanlianEdit: TEdit;
    Label19: TLabel;
    RadioButtonYS: TRadioButton;
    RadioButtonPLayer: TRadioButton;
    TabSheet7: TTabSheet;
    GroupBox7: TGroupBox;
    ListViewMonBag: TListView;
    procedure ButtonExportDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditPasswordChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure TabSheet5Enter(Sender: TObject);
   
    procedure TabSheet7Enter(Sender: TObject);
    procedure TabSheet4Enter(Sender: TObject);
    procedure TabSheet3Enter(Sender: TObject);
    procedure TabSheet6Enter(Sender: TObject);
  private
    m_boOpened:Boolean;
    procedure RefShow();
    procedure RefShowRcd();
    procedure RefShowMagic();
    procedure RefShowUserItem();
    procedure RefShowStorage();
    procedure RefShowBag();
    procedure RefShowmonBag();
    procedure ProcessSaveRcdToFile();
    procedure ProcessLoadRcdformFile();
    procedure ProcessSaveRcd();
    { Private declarations }
  public
    m_ChrRcd:THumDataInfo;
    m_nIdx  :Integer;
    procedure Open();
    { Public declarations }
  end;

var
  frmEditRcd: TfrmEditRcd;

implementation

uses HumDB;

{$R *.dfm}

{ TfrmEditRcd }


procedure TfrmEditRcd.FormCreate(Sender: TObject);
begin
  //
end;

procedure TfrmEditRcd.RefShowRcd;
begin
  EditIdx.Text        :=IntToStr(m_nIdx);
  EditChrName.Text    :=m_ChrRcd.Data.sChrName;
  EditAccount.Text    :=m_ChrRcd.Data.sAccount;
  EditPassword.Text   :=m_ChrRcd.Data.sStoragePwd;
  EditDearName.Text   :=m_ChrRcd.Data.sDearName;
  EditMasterName.Text :=m_ChrRcd.Data.sMasterName;
  CheckBoxIsMaster.Checked:=m_ChrRcd.Data.boMaster;

  EditCurMap.Text     :=m_ChrRcd.Data.sCurMap;
  EditCurX.Value      :=m_ChrRcd.Data.wCurX;
  EditCurY.Value      :=m_ChrRcd.Data.wCurY;

  EditHomeMap.Text    :=m_ChrRcd.Data.sHomeMap;
  EditHomeX.Value     :=m_ChrRcd.Data.wHomeX;
  EditHomeY.Value     :=m_ChrRcd.Data.wHomeY;

  EditLevel.Value     :=m_ChrRcd.Data.Abil.Level;
  EditGold.Value      :=m_ChrRcd.Data.nGold;
  EditGameGold.Value  :=m_ChrRcd.Data.nGameGold;
  EditGamePoint.Value :=m_ChrRcd.Data.nGamePoint;
  EditPayPoint.Value  :=m_ChrRcd.Data.nPayMentPoint;
  EditCreditPoint.Value:=m_ChrRcd.Data.btCreditPoint;
  EditPKPoint.Value    :=m_ChrRcd.Data.wPKPoint;
  if m_ChrRcd.Data.boYS then
  begin//元身
   RadioButtonYS.Checked:= true;
   guanlianEdit.Text:= m_ChrRcd.Data.sYsname;
  end else begin
    RadioButtonPLayer.Checked:=true;
    guanlianEdit.Text:= m_ChrRcd.Data.sYsname;
  end;
end;

procedure TfrmEditRcd.Open;
begin

  RefShow();
  Caption:=format('编辑人物数据 [%s]',[m_ChrRcd.Data.sChrName]);
  PageControl.ActivePageIndex:=0;
  
  ShowModal;
end;

procedure TfrmEditRcd.RefShow;
begin
  m_boOpened:=False;
  RefShowRcd();
  RefShowMagic();
  RefShowUserItem();
  RefShowStorage();
  RefShowBag();
  RefShowmonBag();
  m_boOpened:=True;
end;

procedure TfrmEditRcd.RefShowMagic;
var
  I: Integer;
  ListItem:TListItem;
  MagicInfo:pTHumMagicInfo;
begin
  ListViewMagic.Clear;

  for I := Low(m_ChrRcd.Data.Magic) to High(m_ChrRcd.Data.Magic) do begin
    MagicInfo:=@m_ChrRcd.Data.Magic[I];
    if MagicInfo.wMagIdx = 0 then Continue;        // break

    ListItem:=ListViewMagic.Items.Add;
    ListItem.Caption:=IntToStr(I);
    ListItem.SubItems.Add(IntToStr(MagicInfo.wMagIdx));
    ListItem.SubItems.Add(FindMagicName(MagicInfo.wMagIdx));
    ListItem.SubItems.Add(IntToStr(MagicInfo.btLevel));
    ListItem.SubItems.Add(IntToStr(MagicInfo.nTranPoint));
    ListItem.SubItems.Add(magkeytostr(MagicInfo.btKey));
  end;
end;

procedure TfrmEditRcd.RefShowUserItem;
var
  I: Integer;
  ListItem:TListItem;
  UserItem:pTUserItem;
ResourceString
  sItemValue = '%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d';
    //'%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d'  
begin
  ListViewUserItem.Clear;

  for I := Low(m_ChrRcd.Data.HumItems) to High(m_ChrRcd.Data.HumItems) do begin
    UserItem:=@m_ChrRcd.Data.HumItems[I];
    ListItem:=ListViewUserItem.Items.Add;
    ListItem.Caption:=IntToStr(I);
    if UserItem.wIndex = 0 then Continue;
    ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
    ListItem.SubItems.Add(IntToStr(UserItem.wIndex));
    ListItem.SubItems.Add(GetStdItemName(UserItem.wIndex));    ;
    ListItem.SubItems.Add(format('%d/%d',[UserItem.Dura,UserItem.DuraMax]));

    ListItem.SubItems.Add(format(sItemValue,[
                                 UserItem.btValue[0],
                                 UserItem.btValue[1],
                                 UserItem.btValue[2],
                                 UserItem.btValue[3],
                                 UserItem.btValue[4],
                                 UserItem.btValue[5],
                                 UserItem.btValue[6],
                                 UserItem.btValue[7],
                                 UserItem.btValue[8],
                                 UserItem.btValue[9],
                                 UserItem.btValue[10],
                                 UserItem.btValue[11],
                                 UserItem.btValue[12],
                                 UserItem.btValue[13]
    ]));

  end;

end;

procedure TfrmEditRcd.RefShowStorage;
var
  I: Integer;
  ListItem:TListItem;
  UserItem:pTUserItem;
begin
  ListViewStorage.Clear;

  for I := Low(m_ChrRcd.Data.StorageItems) to High(m_ChrRcd.Data.StorageItems) do begin
    UserItem:=@m_ChrRcd.Data.StorageItems[I];
    if UserItem.wIndex = 0 then Continue;
      
    ListItem:=ListViewStorage.Items.Add;
    ListItem.Caption:=IntToStr(I);
    ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
    ListItem.SubItems.Add(IntToStr(UserItem.wIndex));
    ListItem.SubItems.Add(GetStdItemName(UserItem.wIndex));    ;
    ListItem.SubItems.Add(format('%d/%d',[UserItem.Dura,UserItem.DuraMax]));
    ListItem.SubItems.Add(format('%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d',[
                                 UserItem.btValue[0],
                                 UserItem.btValue[1],
                                 UserItem.btValue[2],
                                 UserItem.btValue[3],
                                 UserItem.btValue[4],
                                 UserItem.btValue[5],
                                 UserItem.btValue[6],
                                 UserItem.btValue[7],
                                 UserItem.btValue[8],
                                 UserItem.btValue[9],
                                 UserItem.btValue[10],
                                 UserItem.btValue[11],
                                 UserItem.btValue[12],
                                 UserItem.btValue[13]
    ]));

  end;

end;

procedure TfrmEditRcd.RefShowmonBag;
var
  I: Integer;
  ListItem:TListItem;
  UserItem:pTUserItem;
begin
  ListViewmonBag.Clear;

  for I := Low(m_ChrRcd.Data.monStorageItems) to High(m_ChrRcd.Data.monStorageItems) do begin
    UserItem:=@m_ChrRcd.Data.monStorageItems[I];
    if UserItem.wIndex = 0 then Continue;
      
    ListItem:=ListViewmonBag.Items.Add;
    ListItem.Caption:=IntToStr(I);
    ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
    ListItem.SubItems.Add(IntToStr(UserItem.wIndex));
    ListItem.SubItems.Add(GetStdItemName(UserItem.wIndex));    ;
    ListItem.SubItems.Add(format('%d/%d',[UserItem.Dura,UserItem.DuraMax]));
    ListItem.SubItems.Add(format('%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d',[
                                 UserItem.btValue[0],
                                 UserItem.btValue[1],
                                 UserItem.btValue[2],
                                 UserItem.btValue[3],
                                 UserItem.btValue[4],
                                 UserItem.btValue[5],
                                 UserItem.btValue[6],
                                 UserItem.btValue[7],
                                 UserItem.btValue[8],
                                 UserItem.btValue[9],
                                 UserItem.btValue[10],
                                 UserItem.btValue[11],
                                 UserItem.btValue[12],
                                 UserItem.btValue[13]
    ]));

  end;

end;

procedure TfrmEditRcd.RefShowBag;
var
  I: Integer;
  ListItem:TListItem;
  UserItem:pTUserItem;
begin
  ListViewBag.Clear;

//  for I := Low(m_ChrRcd.Data.BagItems) to High(m_ChrRcd.Data.BagItems) do begin
 for I := 0 to  m_ChrRcd.Data.m_bMaxBagitem-1 do begin
    UserItem:=@m_ChrRcd.Data.BagItems[I];
    if UserItem.wIndex = 0 then Continue;

    ListItem:=ListViewBag.Items.Add;
    ListItem.Caption:=IntToStr(I);
    ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
    ListItem.SubItems.Add(IntToStr(UserItem.wIndex));
    ListItem.SubItems.Add(GetStdItemName(UserItem.wIndex));    ;
    ListItem.SubItems.Add(format('%d/%d',[UserItem.Dura,UserItem.DuraMax]));
    ListItem.SubItems.Add(format('%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d',[
                                 UserItem.btValue[0],
                                 UserItem.btValue[1],
                                 UserItem.btValue[2],
                                 UserItem.btValue[3],
                                 UserItem.btValue[4],
                                 UserItem.btValue[5],
                                 UserItem.btValue[6],
                                 UserItem.btValue[7],
                                 UserItem.btValue[8],
                                 UserItem.btValue[9],
                                 UserItem.btValue[10],
                                 UserItem.btValue[11],
                                 UserItem.btValue[12],
                                 UserItem.btValue[13]
    ]));

  end;

end;


procedure TfrmEditRcd.ButtonExportDataClick(Sender: TObject);
begin
  if Sender = ButtonExportData then begin
    ProcessSaveRcdToFile();
  end else
  if Sender = ButtonImportData then begin
    ProcessLoadRcdformFile();
  end else
  if Sender = ButtonSaveData then begin
    ProcessSaveRcd();
  end;
    
end;

procedure TfrmEditRcd.ProcessSaveRcdToFile;
var
  sSaveFileName:String;
  nFileHandle:Integer;
begin
  SaveDialog.FileName:=m_ChrRcd.Data.sChrName;
  SaveDialog.InitialDir:='.\';
  if not SaveDialog.Execute then exit;
  sSaveFileName:=SaveDialog.FileName;

  if FileExists(sSaveFileName) then
    nFileHandle:=FileOpen(sSaveFileName,fmOpenReadWrite or fmShareDenyNone)
  else nFileHandle:=FileCreate(sSaveFileName);
  if nFileHandle <= 0 then begin
    MessageBox(Handle,'保存文件出现错误！！！','错误信息',MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;
  FileWrite(nFileHandle,m_ChrRcd,SizeOf(THumDataInfo));
  FileClose(nFileHandle);
  MessageBox(Handle,'人物数据导出成功！！！','提示信息',MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmEditRcd.ProcessLoadRcdformFile;
var
  sLoadFileName:String;
  nFileHandle:Integer;
  ChrRcd:THumDataInfo;
begin
  OpenDialog.FileName:=m_ChrRcd.Data.sChrName;
  OpenDialog.InitialDir:='.\';
  if not OpenDialog.Execute then exit;
  sLoadFileName:=OpenDialog.FileName;

  if not FileExists(sLoadFileName) then begin
    MessageBox(Handle,'指定的文件未找到！！！','错误信息',MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;
  nFileHandle:=FileOpen(sLoadFileName,fmOpenReadWrite or fmShareDenyNone);

  if nFileHandle <= 0 then begin
    MessageBox(Handle,'打开文件出现错误！！！','错误信息',MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;
  if not FileRead(nFileHandle,ChrRcd,SizeOf(THumDataInfo)) = SizeOf(THumDataInfo) then begin
    MessageBox(Handle,'读取文件出现错误！！！'#13#13'文件格式可能不正确','错误信息',MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;
  ChrRcd.Header:=m_ChrRcd.Header;
  ChrRcd.Data.sChrName:=m_ChrRcd.Data.sChrName;
  ChrRcd.Data.sAccount:=m_ChrRcd.Data.sAccount;
  m_ChrRcd:=ChrRcd;
  FileClose(nFileHandle);
  RefShow();
  MessageBox(Handle,'人物数据导入成功！！！','提示信息',MB_OK + MB_ICONINFORMATION);
end;


procedure TfrmEditRcd.ProcessSaveRcd;
var
  nIdx     :Integer;
  boSaveOK :Boolean;
begin
  boSaveOK:=False;
  try
    if HumDataDB.Open then begin
      nIdx:=HumDataDB.Index(m_ChrRcd.Header.sName);
      if (nIdx >= 0) then begin
        HumDataDB.Update(nIdx,m_ChrRcd);
        boSaveOK:=True;
      end;
    end;
  finally
    HumDataDB.Close;
  end;
  if boSaveOK then begin
    MessageBox(Handle,'人物数据保存成功！！！','提示信息',MB_OK + MB_ICONINFORMATION);
  end else begin
    MessageBox(Handle,'人物数据保存失败！！！','错误信息',MB_OK + MB_ICONEXCLAMATION);
  end;
    
end;


procedure TfrmEditRcd.EditPasswordChange(Sender: TObject);
begin
  if not m_boOpened then exit;
  if Sender = guanlianEdit then
  begin
   if RadioButtonYS.Checked then
      m_ChrRcd.Data.sYsname:=Trim(guanlianEdit.Text);
      m_ChrRcd.data.boYS:= RadioButtonYS.Checked;
  end
  else
  if Sender = EditPassword then
  begin
    m_ChrRcd.Data.sStoragePwd:=Trim(EditPassword.Text);
  end else
  if Sender = EditDearName then
  begin
    m_ChrRcd.Data.sDearName:=Trim(EditDearName.Text);
  end
  else
  if Sender = EditMasterName then
  begin
    m_ChrRcd.Data.sMasterName:=Trim(EditMasterName.Text);
  end
  else
  if Sender = CheckBoxIsMaster then
  begin
    m_ChrRcd.Data.boMaster:=CheckBoxIsMaster.Checked;
  end else
  if Sender = EditCurMap then
   begin
    m_ChrRcd.Data.sCurMap:=Trim(EditCurMap.Text);
  end else
  if Sender = EditCurX then
   begin
    m_ChrRcd.Data.wCurX:=EditCurX.Value;
  end else
  if Sender = EditCurY then
  begin
    m_ChrRcd.Data.wCurY:=EditCurY.Value;
  end else
  if Sender = EditHomeMap then
  begin
    m_ChrRcd.Data.sHomeMap:=Trim(EditHomeMap.Text);
  end else    
  if Sender = EditHomeX then
  begin
    m_ChrRcd.Data.wHomeX:=EditHomeX.Value;
  end else
  if Sender = EditCurY then
   begin
    m_ChrRcd.Data.wHomeY:=EditHomeY.Value;
  end else
  if Sender = EditLevel then
   begin
    m_ChrRcd.Data.Abil.Level:=EditLevel.Value;
  end else
  if Sender = EditGold then
   begin
    m_ChrRcd.Data.nGold:=EditGold.Value;
  end else
  if Sender = EditGameGold then
   begin
    m_ChrRcd.Data.nGameGold:=EditGameGold.Value;
  end else
  if Sender = EditGamePoint then
   begin
    m_ChrRcd.Data.nGamePoint:=EditGamePoint.Value;
  end else
  if Sender = EditPayPoint then
   begin
    m_ChrRcd.Data.nPayMentPoint:=EditPayPoint.Value;
  end else
  if Sender = EditCreditPoint then
   begin
    m_ChrRcd.Data.btCreditPoint:=EditCreditPoint.Value;
  end else
  if Sender = EditPKPoint then
   begin
    m_ChrRcd.Data.wPKPoint:=EditPKPoint.Value;
  end else
  if Sender = EditContribution then
  begin
    m_ChrRcd.Data.wContribution:=EditContribution.Value;
  end

end;

procedure TfrmEditRcd.N1Click(Sender: TObject);
 var  UserItem:pTUserItem;
      I,itempos:integer;
      ListItem:TListItem;
begin
      if not m_boOpened then exit;
      if  PopupMenu1.Tag =2 then begin
        i:= ListViewBag.ItemIndex ;
        if (i>=0) and (i< ListViewBag.Items.Count) then begin
          itempos:=strtoint( ListViewBag.Items[i].Caption);
          UserItem:=@m_ChrRcd.Data.BagItems[itempos];
          UserItem.MakeIndex:=0;
          UserItem.wIndex:=0;
          ListViewBag.Items.Delete(I);
        end;
       end;
       if PopupMenu1.Tag =1 then begin
        i:= ListViewStorage.ItemIndex ;
        if (i>=0) and (i< ListViewStorage.Items.Count) then begin
        itempos:=strtoint( ListViewStorage.Items[i].Caption);
        UserItem:=@m_ChrRcd.Data.StorageItems[itempos];
        UserItem.MakeIndex:=0;
        UserItem.wIndex:=0;
        ListViewStorage.Items.Delete(I);
        end;
       end;
      if  PopupMenu1.Tag =3 then begin
        i:= ListViewmonBag.ItemIndex ;
       if (i>=0) and (i< ListViewmonBag.Items.Count) then begin

        itempos:=strtoint( ListViewmonBag.Items[i].Caption);
        UserItem:=@m_ChrRcd.Data.monStorageItems[itempos];
        UserItem.MakeIndex:=0;
        UserItem.wIndex:=0;
        ListViewmonBag.Items.Delete(I);
        end;
      end;
      if  PopupMenu1.Tag =4 then begin
        i:= ListViewUserItem.ItemIndex ;
         if (i>=0) and (i<= High(THumItems)) then begin

        itempos:=strtoint( ListViewUserItem.Items[i].Caption);
        UserItem:=@m_ChrRcd.Data.HumItems[itempos];
        UserItem.MakeIndex:=0;
        UserItem.wIndex:=0;
        ListViewUserItem.Items[I].SubItems.Clear;

        end;

        
        ListViewUserItem.UpdateItems(i,i);
      end;
      if  PopupMenu1.Tag =5 then begin
        i:= ListViewMagic.ItemIndex ;
       if (i>=0) and (i< ListViewMagic.Items.Count) then begin

        itempos:=strtoint( ListViewMagic.Items[i].Caption);
        UserItem:=@m_ChrRcd.Data.Magic[itempos];
        UserItem.MakeIndex:=0;
        UserItem.wIndex:=0;
        ListViewMagic.Items.Delete(I);
        end;
      end;


end;

procedure TfrmEditRcd.TabSheet5Enter(Sender: TObject);
begin
   PopupMenu1.Tag:=1;
end;


procedure TfrmEditRcd.TabSheet7Enter(Sender: TObject);
begin
PopupMenu1.Tag:=3;
end;

procedure TfrmEditRcd.TabSheet4Enter(Sender: TObject);
begin
   PopupMenu1.Tag:=4;
end;

procedure TfrmEditRcd.TabSheet3Enter(Sender: TObject);
begin
   PopupMenu1.Tag:=5;
end;

procedure TfrmEditRcd.TabSheet6Enter(Sender: TObject);
begin
    PopupMenu1.Tag:=2;
end;

end.
