
unit UnitRegisterSoft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,IniFiles,registry;

type
  TFrmRegister = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditRegName: TEdit;
    EditHID: TEdit;
    EditRegCode: TEdit;
    BtOK: TSpeedButton;
    BtESC: TSpeedButton;
    procedure BtESCClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRegister: TFrmRegister;

implementation
uses ShareUnit,Grobal2;
{$R *.dfm}

procedure TFrmRegister.BtESCClick(Sender: TObject);
begin
 //  Application.Terminate;
   close;
end;

procedure TFrmRegister.FormShow(Sender: TObject);
var   Config:TIniFile;
begin
end;

procedure TFrmRegister.BtOKClick(Sender: TObject);
var re:Tregistry;
begin
   //  modalresult:=mrok;
     if  (EditHid.Text='') or  (editRegCode.Text='') then exit;

     // AntiDebug;
     // ProtectImport;
     // SecureWrite(SoftRegServerName,EditRegName.Text);
     // SecureWrite(SoftSerialNumber,EditRegCode.Text);
     // SecureWrite(SoftSerialHardwareID,IntToHex(GetHardwareID,8));
        if IsWindow(RegisterHandle) then  begin
            

            SetRegisterInfo(EditRegName.Text, EditRegCode.Text);
            re:=Tregistry.Create ;
            re.RootKey:=HKEY_LOCAL_MACHINE;
            if re.OpenKey('Software\AFT\REG',true) then  Begin
              Try
               re.WriteString('SN',EditRegCode.Text);
               Re.CloseKey;
              Finally
              Re.Free;
              end;
            end;


         //   Timer1Timer(Timer1);
         //   Application.MessageBox(PChar(Button1.Hint), '', MB_OK);
        end;

      //  modalresult:= mrNone;
        MessageBox(Handle,'必须重新启动应用程序才能完成注册!!','提示',MB_OK+MB_ICONINFORMATION);
       // if not CheckReg then 
        Application.Terminate;


end;

procedure TFrmRegister.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
 // Application.Terminate;
end;

end.
