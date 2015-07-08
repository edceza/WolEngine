unit Unit_Item;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,Grobal2;

type
  TForm_Unit_Item = class(TForm)
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Cbx_ClothName: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Cbx_XunZhangName: TComboBox;
    Cbx_WeaponName: TComboBox;
    Cbx_ARMRINGNAME: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Cbx_HELMETNAME: TComboBox;
    Cbx_NECKLACENAME: TComboBox;
    Label6: TLabel;
    Cbx_CHARMNAME: TComboBox;
    Label7: TLabel;
    Cbx_BOOTSNAME: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Cbx_ShieldName: TComboBox;
    Label10: TLabel;
    Cbx_BELTNAME: TComboBox;
    Cbx_BUJUKNAME: TComboBox;
    Label11: TLabel;
    Label12: TLabel;
    Cbx_RINGNAME: TComboBox;
    CheckBoxTwoARMRING: TCheckBox;
    CheckBoxTwoRing: TCheckBox;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Edit_HP: TSpinEdit;
    Edit_MP: TSpinEdit;
    Label14: TLabel;
    Edit_AC2: TSpinEdit;
    Label15: TLabel;
    Edit_AC1: TSpinEdit;
    Label16: TLabel;
    Edit_DC1: TSpinEdit;
    Label17: TLabel;
    Label18: TLabel;
    Edit_DC2: TSpinEdit;
    Label19: TLabel;
    Edit_MAC1: TSpinEdit;
    Label20: TLabel;
    Edit_MAC2: TSpinEdit;
    Edit_AntiPoison: TSpinEdit;
    Label21: TLabel;
    Label22: TLabel;
    Edit_AntiMagic: TSpinEdit;
    Label23: TLabel;
    Edit_hit: TSpinEdit;
    Label24: TLabel;
    Edit_Speed: TSpinEdit;
    Label25: TLabel;
    Edit_SC1: TSpinEdit;
    Label26: TLabel;
    Edit_SC2: TSpinEdit;
    Edit_MC2: TSpinEdit;
    Label27: TLabel;
    Label28: TLabel;
    Edit_MC1: TSpinEdit;
    CheckBox_boParalysis: TCheckBox;
    CheckBox_boMagicShield: TCheckBox;
    CheckBox_boRevival: TCheckBox;
    CheckBox_boTeleport: TCheckBox;
    CheckBox_boProbeNecklace: TCheckBox;
    CheckBox_boMuscleRing: TCheckBox;
    CheckBox_boFastTrain: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox_boTransparent: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label29: TLabel;
    Edit_UnitName: TEdit;
    btn_Save: TButton;
    Label30: TLabel;
    Edit_TakeOn: TEdit;
    Label31: TLabel;
    Edit_TakeOff: TEdit;
    Label32: TLabel;
    Edit_TakeOnHint: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  Form_Unit_Item: TForm_Unit_Item;

implementation
uses M2Share, UsrEngn, Envir, HUtil32, LocalDB;
{$R *.dfm}

{ TForm_Unit_Item }

procedure TForm_Unit_Item.btn_SaveClick(Sender: TObject);
begin
 SaveItem_Unit;
      btn_Save.Enabled:=false;
end;

procedure TForm_Unit_Item.Button1Click(Sender: TObject);
var
  pUnit_Item:pTUnit_Item;
  i : Integer;
begin
   if Edit_UnitName.Text<>'' then
   begin
     for I := 0 to g_Item_UnitList.Count - 1 do
     begin
        pUnit_Item := pTUnit_Item(g_Item_UnitList.Objects[i]);
        if pUnit_Item.Name=Edit_UnitName.Text  then
        begin
          ShowMessage('Ì××°Ãû³ÆÖØ¸´');
          Exit;
        end;
     end;
     New(pUnit_Item);
     pUnit_Item.Name:=Edit_UnitName.Text;
     pUnit_Item.ItemName[U_DRESS]:=Cbx_ClothName.Text;
     pUnit_Item.ItemName[U_WEAPON]:=Cbx_WeaponName.Text;
     pUnit_Item.ItemName[U_RIGHTHAND]:=Cbx_XunZhangName.Text;
     pUnit_Item.ItemName[U_NECKLACE]:=Cbx_NECKLACENAME.Text;
     pUnit_Item.ItemName[U_HELMET]:=Cbx_HELMETNAME.Text;
     pUnit_Item.ItemName[U_ARMRINGL]:=Cbx_ARMRINGNAME.Text;
     pUnit_Item.ItemName[U_ARMRINGR]:=Cbx_ARMRINGNAME.Text;
     pUnit_Item.ItemName[U_RINGL]:=Cbx_RINGNAME.Text;
     pUnit_Item.ItemName[U_RINGR]:=Cbx_RINGNAME.Text;
     pUnit_Item.ItemName[U_BOOTS]:=Cbx_BOOTSNAME.Text;
     pUnit_Item.ItemName[U_BELT]:=Cbx_BELTNAME.Text;
     pUnit_Item.ItemName[U_CHARM]:=Cbx_CHARMNAME.Text;
     pUnit_Item.ItemName[U_BUJUK]:=Cbx_BUJUKNAME.Text;
     pUnit_Item.ItemName[U_Shield]:=Cbx_ShieldName.Text;
     pUnit_Item.sTakeOn:=Edit_TakeOn.Text;
     pUnit_Item.sTakeOff:=Edit_TakeOff.Text;
     pUnit_Item.sTakeOnHint:=Edit_TakeOnHint.Text;

     pUnit_Item.boTwoARMRING:=CheckBoxTwoARMRING.Checked;
     pUnit_Item.boTwoRing:=CheckBoxTwoRing.Checked;
     pUnit_Item.boParalysis:=CheckBox_boParalysis.Checked;
     pUnit_Item.boMagicShield:=CheckBox_boMagicShield.Checked;
     pUnit_Item.boRevival:=CheckBox_boRevival.Checked;
     pUnit_Item.boTeleport:=CheckBox_boTeleport.Checked;
     pUnit_Item.boProbeNecklace:=CheckBox_boProbeNecklace.Checked;
     pUnit_Item.boMuscleRing:=CheckBox_boMuscleRing.Checked;
     pUnit_Item.boFastTrain:=CheckBox_boFastTrain.Checked;
     pUnit_Item.boTransparent:=CheckBox_boTransparent.Checked;

     pUnit_Item.btHP:=Edit_HP.Value;
     pUnit_Item.btMp:=Edit_MP.Value;
     pUnit_Item.btAC1:=Edit_AC1.Value;
     pUnit_Item.btAC2:=Edit_AC2.Value;
     pUnit_Item.btDC1:=Edit_DC1.Value;
     pUnit_Item.btDC2:=Edit_DC2.Value;
     pUnit_Item.btMAC1:=Edit_MAC1.Value;
     pUnit_Item.btMAC2:=Edit_MAC2.Value;
     pUnit_Item.btSC1:=Edit_SC1.Value;
     pUnit_Item.btSC2:=Edit_SC2.Value;
     pUnit_Item.btHit:=Edit_hit.Value;
     pUnit_Item.btMC1:=Edit_MC1.Value;
     pUnit_Item.btMC2:=Edit_MC2.Value;
     pUnit_Item.btSpeed:=Edit_Speed.Value;
     pUnit_Item.btAntiMagic:=Edit_AntiMagic.Value;
     pUnit_Item.btAntiPoison:=Edit_AntiPoison.Value;




     ListBox1.Items.AddObject(pUnit_Item.Name, TObject(punit_item));
     g_Item_UnitList.AddObject(pUnit_Item.Name, TObject(punit_item));
          btn_Save.Enabled:=True;
   end
   else
      ShowMessage('ÇëÌîÐ´Ì××°Ãû³Æ');
   

end;

procedure TForm_Unit_Item.Button2Click(Sender: TObject);
var

  pUnit_Item:pTUnit_Item;
begin
   if ListBox1.ItemIndex>=0 then
   begin
     pUnit_Item:=pTUnit_Item(ListBox1.Items.Objects[ListBox1.ItemIndex]);
     g_Item_UnitList.Delete(ListBox1.ItemIndex);
     ListBox1.Items.Delete(ListBox1.ItemIndex);
     
     Dispose(pUnit_Item);
     btn_Save.Enabled:=True;
   end;
end;

procedure TForm_Unit_Item.Button3Click(Sender: TObject);
var

  pUnit_Item:pTUnit_Item;
begin
   if ListBox1.ItemIndex>=0 then
   begin
     pUnit_Item:=pTUnit_Item(ListBox1.Items.Objects[ListBox1.ItemIndex]);
     ListBox1.Items[ListBox1.ItemIndex]:=Edit_UnitName.Text;
     pUnit_Item.Name:=Edit_UnitName.Text;
     pUnit_Item.ItemName[U_DRESS]:=Cbx_ClothName.Text;
     pUnit_Item.ItemName[U_WEAPON]:=Cbx_WeaponName.Text;
     pUnit_Item.ItemName[U_RIGHTHAND]:=Cbx_XunZhangName.Text;
     pUnit_Item.ItemName[U_NECKLACE]:=Cbx_NECKLACENAME.Text;
     pUnit_Item.ItemName[U_HELMET]:=Cbx_HELMETNAME.Text;
     pUnit_Item.ItemName[U_ARMRINGL]:=Cbx_ARMRINGNAME.Text;
     pUnit_Item.ItemName[U_ARMRINGR]:=Cbx_ARMRINGNAME.Text;
     pUnit_Item.ItemName[U_RINGL]:=Cbx_RINGNAME.Text;
     pUnit_Item.ItemName[U_RINGR]:=Cbx_RINGNAME.Text;
     pUnit_Item.ItemName[U_BOOTS]:=Cbx_BOOTSNAME.Text;
     pUnit_Item.ItemName[U_BELT]:=Cbx_BELTNAME.Text;
     pUnit_Item.ItemName[U_CHARM]:=Cbx_CHARMNAME.Text;
     pUnit_Item.ItemName[U_BUJUK]:=Cbx_BUJUKNAME.Text;
     pUnit_Item.ItemName[U_Shield]:=Cbx_ShieldName.Text;
     pUnit_Item.sTakeOn:=Edit_TakeOn.Text;
     pUnit_Item.sTakeOff:=Edit_TakeOff.Text;
     pUnit_Item.sTakeOnHint:=Edit_TakeOnHint.Text;

     pUnit_Item.boTwoARMRING:=CheckBoxTwoARMRING.Checked;
     pUnit_Item.boTwoRing:=CheckBoxTwoRing.Checked;
     pUnit_Item.boParalysis:=CheckBox_boParalysis.Checked;
     pUnit_Item.boMagicShield:=CheckBox_boMagicShield.Checked;
     pUnit_Item.boRevival:=CheckBox_boRevival.Checked;
     pUnit_Item.boTeleport:=CheckBox_boTeleport.Checked;
     pUnit_Item.boProbeNecklace:=CheckBox_boProbeNecklace.Checked;
     pUnit_Item.boMuscleRing:=CheckBox_boMuscleRing.Checked;
     pUnit_Item.boFastTrain:=CheckBox_boFastTrain.Checked;
     pUnit_Item.boTransparent:=CheckBox_boTransparent.Checked;

     pUnit_Item.btHP:=Edit_HP.Value;
     pUnit_Item.btMp:=Edit_MP.Value;
     pUnit_Item.btAC1:=Edit_AC1.Value;
     pUnit_Item.btAC2:=Edit_AC2.Value;
     pUnit_Item.btDC1:=Edit_DC1.Value;
     pUnit_Item.btDC2:=Edit_DC2.Value;
     pUnit_Item.btMAC1:=Edit_MAC1.Value;
     pUnit_Item.btMAC2:=Edit_MAC2.Value;
     pUnit_Item.btSC1:=Edit_SC1.Value;
     pUnit_Item.btSC2:=Edit_SC2.Value;
     pUnit_Item.btHit:=Edit_hit.Value;
     pUnit_Item.btMC1:=Edit_MC1.Value;
     pUnit_Item.btMC2:=Edit_MC2.Value;
     pUnit_Item.btSpeed:=Edit_Speed.Value;
     pUnit_Item.btAntiMagic:=Edit_AntiMagic.Value;
     pUnit_Item.btAntiPoison:=Edit_AntiPoison.Value;
     btn_Save.Enabled:=True;
   end;
end;

procedure TForm_Unit_Item.ListBox1Click(Sender: TObject);
var

  pUnit_Item:pTUnit_Item;
begin
   if ListBox1.ItemIndex>=0 then
   begin
     pUnit_Item:=pTUnit_Item(ListBox1.Items.Objects[ListBox1.ItemIndex]);
     Edit_UnitName.Text := pUnit_Item.Name;
     Cbx_ClothName.Text := pUnit_Item.ItemName[U_DRESS];
     Cbx_WeaponName.Text := pUnit_Item.ItemName[U_WEAPON];
     Cbx_HELMETNAME.Text := pUnit_Item.ItemName[U_HELMET];
     Cbx_NECKLACENAME.Text := pUnit_Item.ItemName[U_NECKLACE];
     Cbx_HELMETNAME.Text := pUnit_Item.ItemName[U_HELMET];
     Cbx_ARMRINGNAME.Text := pUnit_Item.ItemName[U_ARMRINGL];
     Cbx_XunZhangName.Text:=pUnit_Item.ItemName[U_RIGHTHAND];
     Cbx_RINGNAME.Text := pUnit_Item.ItemName[U_RINGL];

     Cbx_BOOTSNAME.Text := pUnit_Item.ItemName[U_BOOTS];
     Cbx_BELTNAME.Text := pUnit_Item.ItemName[U_BELT];
     Cbx_CHARMNAME.Text := pUnit_Item.ItemName[U_CHARM];
     Cbx_BUJUKNAME.Text := pUnit_Item.ItemName[U_BUJUK];
     Cbx_ShieldName.Text := pUnit_Item.ItemName[U_Shield];
     Edit_TakeOn.Text := pUnit_Item.sTakeOn;
     Edit_TakeOff.Text := pUnit_Item.sTakeOff;
     Edit_TakeOnHint.Text := pUnit_Item.sTakeOnHint;

     CheckBoxTwoARMRING.Checked := pUnit_Item.boTwoARMRING;
     CheckBoxTwoRing.Checked := pUnit_Item.boTwoRing;
     CheckBox_boParalysis.Checked := pUnit_Item.boParalysis;
     CheckBox_boMagicShield.Checked := pUnit_Item.boMagicShield;
     CheckBox_boRevival.Checked := pUnit_Item.boRevival;
     CheckBox_boTeleport.Checked := pUnit_Item.boTeleport;
     CheckBox_boProbeNecklace.Checked := pUnit_Item.boProbeNecklace;
     CheckBox_boMuscleRing.Checked := pUnit_Item.boMuscleRing;
     CheckBox_boFastTrain.Checked := pUnit_Item.boFastTrain;
     CheckBox_boTransparent.Checked := pUnit_Item.boTransparent;

     Edit_HP.Value := pUnit_Item.btHP;
     Edit_MP.Value := pUnit_Item.btMp;
     Edit_AC1.Value := pUnit_Item.btAC1;
     Edit_AC2.Value := pUnit_Item.btAC2;
     Edit_DC1.Value := pUnit_Item.btDC1;
     Edit_DC2.Value := pUnit_Item.btDC2;
     Edit_MAC1.Value := pUnit_Item.btMAC1;
     Edit_MAC2.Value := pUnit_Item.btMAC2;
     Edit_SC1.Value := pUnit_Item.btSC1;
     Edit_SC2.Value := pUnit_Item.btSC2;
     Edit_hit.Value := pUnit_Item.btHit;
     Edit_MC1.Value := pUnit_Item.btMC1;
     Edit_MC2.Value := pUnit_Item.btMC2;
     Edit_Speed.Value := pUnit_Item.btSpeed;
     Edit_AntiMagic.Value := pUnit_Item.btAntiMagic;
     Edit_AntiPoison.Value := pUnit_Item.btAntiPoison;

   end;
end;

procedure TForm_Unit_Item.Open;
var
  I: Integer;
  StdItem: pTStdItem;
    pUnit_Item:pTUnit_Item;
begin

  try
    Cbx_ClothName.Items.Clear;
    Cbx_XunZhangName.Items.Clear;
    Cbx_WeaponName.Items.Clear;
    Cbx_ARMRINGNAME.Items.Clear;
    Cbx_HELMETNAME.Items.Clear;
    Cbx_NECKLACENAME.Items.Clear;
    Cbx_CHARMNAME.Items.Clear;
    Cbx_BOOTSNAME.Items.Clear;
    Cbx_ShieldName.Items.Clear;
    Cbx_BELTNAME.Items.Clear;
    Cbx_BUJUKNAME.Items.Clear;
    Cbx_RINGNAME.Items.Clear;

    for I := 0 to UserEngine.StdItemList.Count - 1 do
    begin
      StdItem := UserEngine.StdItemList.Items[I];
      if CheckUserItems(U_DRESS,stditem) then
         Cbx_ClothName.Items.Add(stditem^.Name);
      if CheckUserItems(U_WEAPON,stditem) then
         Cbx_WeaponName.Items.Add(stditem^.Name);
      if CheckUserItems(U_RIGHTHAND,stditem) then
         Cbx_XunZhangName.Items.Add(stditem^.Name);
      if CheckUserItems(U_NECKLACE,stditem) then
         Cbx_NECKLACENAME.Items.Add(stditem^.Name);
      if CheckUserItems(U_HELMET,stditem) then
         Cbx_HELMETNAME.Items.Add(stditem^.Name);
      if CheckUserItems(U_ARMRINGL,stditem) then
         Cbx_ARMRINGNAME.Items.Add(stditem^.Name);
      if CheckUserItems(U_RINGL,stditem) then
         Cbx_RINGNAME.Items.Add(stditem^.Name);
      if CheckUserItems(U_BOOTS,stditem) then
         Cbx_BOOTSNAME.Items.Add(stditem^.Name);
      if CheckUserItems(U_BELT,stditem) then
         Cbx_BELTNAME.Items.Add(stditem^.Name);
      if CheckUserItems(U_CHARM,stditem) then
         Cbx_CHARMNAME.Items.Add(stditem^.Name);
      if CheckUserItems(U_BUJUK,stditem) then
         Cbx_BUJUKNAME.Items.Add(stditem^.Name);
      if CheckUserItems(U_Shield,stditem) then
         Cbx_ShieldName.Items.Add(stditem^.Name);

    end;
    ListBox1.Items.Clear ;
    for I := 0 to g_Item_UnitList.Count - 1 do
     begin
        pUnit_Item := pTUnit_Item(g_Item_UnitList.Objects[i]);
         ListBox1.Items.AddObject(pUnit_Item.Name,TObject(pUnit_Item));
     end;
  finally
     ShowModal;
  end;
end;

end.
