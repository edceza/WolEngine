unit CastleAttackEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, castle, M2Share;

type
  TFormCastleAttackEdit = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EditName: TEdit;
    DateTimePicker1: TDateTimePicker;
    Button1: TButton;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    CBXAll: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open(AttackerInfo: pTAttackerInfo; IsEdit: Boolean);
  end;

var
  FormCastleAttackEdit: TFormCastleAttackEdit;
  OK: Boolean;
  GroupName: string;
implementation

{$R *.dfm}

procedure TFormCastleAttackEdit.Open(AttackerInfo: pTAttackerInfo;
  IsEdit: Boolean);
begin
  CBXAll.Checked:=False;
  if IsEdit then
  begin
    Caption := '±‡º≠π•≥«…Í«Î';
    listbox1.Enabled := false;
    CBXAll.Enabled:=False;
    EditName.Text := AttackerInfo^.sGuildName;
    DateTimePicker1.DateTime := AttackerInfo^.AttackDate;
    ShowModal;

  end
  else
  begin
    listbox1.Enabled := true;
    Caption := '‘ˆº”π•≥«…Í«Î';
    DateTimePicker1.DateTime:=Now;
    ShowModal;
  end;
  if Ok and (GroupName = 'A') then
  begin
    AttackerInfo^.sGuildName := EditName.Text;
    AttackerInfo^.AttackDate := DateTimePicker1.Date;
    if CBXAll.Checked then
      AttackerInfo^.sGuildName:='A';
    EditName.Text := '';
  end;
end;

procedure TFormCastleAttackEdit.Button1Click(Sender: TObject);
begin
  if (EditName.Text = '')and(not CBXAll.Checked) then
    exit
  else
  begin
    GroupName := 'A';
    ok := True;
    Close;
  end;
end;

procedure TFormCastleAttackEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if GroupName = 'A' then
  else
  begin
    GroupName := 'B';
    EditName.Text := '';
  end;
end;

procedure TFormCastleAttackEdit.FormShow(Sender: TObject);
begin
  ListBox1.Items.LoadFromFile(g_Config.sGuildFile);
end;

procedure TFormCastleAttackEdit.ListBox1DblClick(Sender: TObject);
begin
  if ListBox1.ItemIndex = -1 then
    exit;
  EditName.Text := ListBox1.Items[ListBox1.ItemIndex];
end;

end.
