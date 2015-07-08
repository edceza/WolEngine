unit inCheatFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls,gateshare, ExtCtrls;

type
  TfrmDefCheat = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Bevel2: TBevel;
    edtWarnMsg: TEdit;
    CheckBox6: TCheckBox;
    cbxSendWarn: TCheckBox;
    cbxSendFail: TCheckBox;
    GroupBox4: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    speSpellTime: TSpinEdit;
    speSpellCount: TSpinEdit;
    GroupBox2: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    speHitTime: TSpinEdit;
    speHitCount: TSpinEdit;
    GroupBox1: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    speWalkTime: TSpinEdit;
    speWalkCount: TSpinEdit;
    GroupBox3: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    speTurnTIme: TSpinEdit;
    speTurnCount: TSpinEdit;
    cbxWalk: TCheckBox;
    cbxHit: TCheckBox;
    cbxSpell: TCheckBox;
    cbxTurn: TCheckBox;
    Bevel1: TBevel;
    CheckBox1: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cbxWalkClick(Sender: TObject);
    procedure cbxTurnClick(Sender: TObject);
    procedure cbxHitClick(Sender: TObject);
    procedure cbxSpellClick(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure cbxSendWarnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDefCheat: TfrmDefCheat;

implementation

{$R *.dfm}

procedure TfrmDefCheat.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmDefCheat.Button1Click(Sender: TObject);
begin
  dwWalkTime := speWalkTime.Value;
  nWalkErrorMax := speWalkCount.Value;
  dwHitTime := speHitTime.Value;
  nHitErrorMax := speHitCount.Value;
  dwTurnTime := speTurnTime.Value;
  nTurnErrorMax := speTurnCount.Value;
  dwSpellTime := speSpellTime.Value;
  nSpellErrorMax := speSpellCount.Value;
  boCtrlWalkSpeed := cbxWalk.Checked;
  boCtrlHitSpeed := cbxHit.Checked;
  boCtrlTurnSpeed := cbxTurn.Checked;
  boCtrlSpellSpeed := cbxSpell.Checked;
  boCtrlgameopenwg := CheckBox6.Checked;
  boSendFailMsg := cbxSendFail.Checked;
  boSendWarnMsg := cbxSendWarn.Checked;
  sWarnMsg := trim(edtWarnMsg.Text);
  conf.WriteInteger('Cheat','WalkTime',dwWalkTime);
  conf.WriteInteger('Cheat','WalkErrorMax',nWalkErrorMax);
  conf.WriteInteger('Cheat','HitTime',dwHitTime);
  conf.WriteInteger('Cheat','HitErrorMax',nHitErrorMax);
  conf.WriteInteger('Cheat','TurnTime',dwTurnTime);
  conf.WriteInteger('Cheat','TurnErrorMax',nTurnErrorMax);
  conf.WriteInteger('Cheat','SpellTime',dwSpellTime);
  conf.WriteInteger('Cheat','SpellErrorMax',nSpellErrorMax);
  conf.WriteBool('Cheat','CtrlWalkSpeed',boCtrlWalkSpeed);
  conf.WriteBool('Cheat','CtrlHitSpeed',boCtrlHitSpeed);
  conf.WriteBool('Cheat','CtrlTurnSpeed',boCtrlTurnSpeed);
  conf.WriteBool('Cheat','CtrlSpellSpeed',boCtrlSpellSpeed);
  conf.WriteBool('Cheat','Ctrlgameopenwg',boCtrlgameopenwg);
  conf.WriteBool('Cheat','SendFailMsg',boSendFailMsg);
  conf.WriteBool('Cheat','SendWarnMsg',boSendWarnMsg);
  conf.WriteString('Cheat','WarnMsg',sWarnMsg);
  close;
end;

procedure TfrmDefCheat.Button3Click(Sender: TObject);
begin
  if true then begin
    speWalkTime.Value:=600;
    speWalkCount.Value:=8;
    speTurnTime.Value:=600;
    speTurnCount.Value:=8;
    speHitTime.Value:=900;
    speHitCount.Value:=8;
    speSpellTime.Value:=800;
    speSpellCount.Value:=8;
  end;
end;

procedure TfrmDefCheat.cbxWalkClick(Sender: TObject);
begin
  speWalkTime.Enabled := cbxWalk.Checked;
  speWalkCount.Enabled := cbxWalk.Checked;
end;

procedure TfrmDefCheat.cbxTurnClick(Sender: TObject);
begin
  speTurnTIme.Enabled:=cbxTurn.Checked;
  speTurnCount.Enabled:=cbxTurn.Checked;
end;

procedure TfrmDefCheat.cbxHitClick(Sender: TObject);
begin
  speHitTime.Enabled:=cbxHit.Checked;
  speHitCount.Enabled:=cbxHit.Checked;
end;

procedure TfrmDefCheat.cbxSpellClick(Sender: TObject);
begin
  speSpellTime.Enabled:=cbxSpell.Checked;
  speSpellCount.Enabled:=cbxSpell.Checked;
end;

procedure TfrmDefCheat.CheckBox6Click(Sender: TObject);
begin
   if checkbox6.Checked =true then begin
      cbxWalk.Enabled := true ;
      cbxHit.Enabled := true;
      cbxTurn.Enabled := true;
      cbxSpell.Enabled := true;
      cbxSendWarn.Enabled := true;
      cbxSendFail.Enabled := true;
   end
   else begin
      cbxWalk.Enabled := false;
      cbxHit.Enabled := false;
      cbxTurn.Enabled := false;
      cbxSpell.Enabled := false;
      cbxSendWarn.Enabled := false;
      cbxSendFail.Enabled := false;
    end
end;

procedure TfrmDefCheat.cbxSendWarnClick(Sender: TObject);
begin
    if cbxSendWarn.Checked =true then begin
       edtWarnMsg.Enabled := true;
    end
    else begin
         edtWarnMsg.Enabled := false;
    end
end;

end.
