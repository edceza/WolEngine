unit AutoBackUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,IniFiles,FileCtrl;

type
  TFormbackup = class(TForm)
    GroupBox1: TGroupBox;
    Cbx_BackUpEnable: TCheckBox;
    ComboBox_Day: TComboBox;
    Label2: TLabel;
    RbtnDay: TRadioButton;
    RbtnWeek: TRadioButton;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Edit_BackUpPath: TEdit;
    Button1: TButton;
    BtnOK: TButton;
    Button2: TButton;
    procedure Cbx_BackUpEnableClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure FillEdit;
    procedure SaveConfig;
    procedure Open;
  end;

var
  Formbackup: TFormbackup;

implementation

uses DBShare;

{$R *.dfm}

{ TFormbackup }

procedure TFormbackup.BtnOKClick(Sender: TObject);
begin
  SaveConfig;
  Close;
end;

procedure TFormbackup.Button1Click(Sender: TObject);
var table_path:string  ;
begin
SelectDirectory('请选择一个目录','',table_path);
Edit_BackUpPath.Text:=table_path;
end;

procedure TFormbackup.Button2Click(Sender: TObject);
begin
  CLose;
end;

procedure TFormbackup.Cbx_BackUpEnableClick(Sender: TObject);
begin
GroupBox1.Enabled:=Cbx_BackUpEnable.Checked;
end;

procedure TFormbackup.FillEdit;
begin
   Cbx_BackUpEnable.Checked:=g_boAutoBackup;
   GroupBox1.Enabled:=g_boAutoBackup;
   RbtnDay.Checked:=g_boBackUpDay;
   RbtnWeek.Checked:=Not g_boBackUpDay;
   ComboBox_Day.ItemIndex:=g_nBackupDay;
   DateTimePicker1.Time:=g_nBackupime;
   Edit_BackUpPath.Text:=g_sBackupPath;
end;

procedure TFormbackup.Open;
begin
  FillEdit;
  ShowModal;
  
end;

procedure TFormbackup.SaveConfig;
var
  Conf: TIniFile;
begin
   g_boAutoBackup := Cbx_BackUpEnable.Checked;
   g_boAutoBackup := GroupBox1.Enabled;
   g_boBackUpDay := RbtnDay.Checked;

   g_nBackupDay := ComboBox_Day.ItemIndex;
   g_nBackupime := DateTimePicker1.Time;
   g_sBackupPath := Edit_BackUpPath.Text;
  Conf:=TIniFile.Create(sConfFileName);
  
    Conf.WriteBool('BackUp','Enable',g_boAutoBackup);
    Conf.WriteBool('BackUp','BackUpDay',g_boBackUpDay);
    Conf.WriteInteger('Backup','Day',g_nBackupDay);
    Conf.WriteDateTime('Backup','Time',g_nBackupime);
    Conf.WriteString('Backup','Path',g_sBackupPath);
end;

end.
