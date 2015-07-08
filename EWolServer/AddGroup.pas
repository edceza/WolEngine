unit AddGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,M2Share;

type
  TFrmAddGroup = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAddGroup: TFrmAddGroup;

implementation

uses CastleManage;

{$R *.dfm}

procedure TFrmAddGroup.Button2Click(Sender: TObject);
begin
close;
end;

procedure TFrmAddGroup.FormShow(Sender: TObject);
begin
SpinEdit1.Text:=FormatdateTime('yyyy',now);
SpinEdit2.Text:=FormatdateTime('mm',now);
SpinEdit3.Text:=FormatdateTime('dd',now);
end;

procedure TFrmAddGroup.Button1Click(Sender: TObject);
Var
  LoadLis:TStringList;
  sFileName,sConfigFile,GroupName:String;
begin
GroupName:=ListBox1.Items[ListBox1.ItemIndex];
If GroupName='' then
ShowMessage('请先选择要攻城的行会...')
else
  sConfigFile:='AttackSabukWall.txt';
  sFileName:=g_Config.sCastleDir  + '0\'  + sConfigFile;
  LoadLis:=TStringList.Create;
  LoadLis.Add(GroupName + '       "' + SpinEdit1.Text+'-'+SpinEdit2.Text+'-'+SpinEdit3.Text + '"');
  close;
  try
    LoadLis.SaveToFile(sFileName);
  except
    MainOutMessage('保存攻城信息失败: ' + sFileName);
  end;
  LoadLis.Free;
end;

end.
