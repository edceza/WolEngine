unit RegSoft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,nb30,DESCrypt,Base64,registry,MD5;

type
  TFrmRegSoft = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRegSoft: TFrmRegSoft;

implementation

uses Main;

{$R *.dfm}

function GetIdeSerialNumber: pchar;  //获取硬盘的出厂系列号；
const IDENTIFY_BUFFER_SIZE = 512;
type
   TIDERegs = packed record
     bFeaturesReg: BYTE;
     bSectorCountReg: BYTE;
     bSectorNumberReg: BYTE;
     bCylLowReg: BYTE;
     bCylHighReg: BYTE;
     bDriveHeadReg: BYTE;
     bCommandReg: BYTE;
     bReserved: BYTE;
  end;

  TSendCmdInParams = packed record
    cBufferSize: DWORD;
    irDriveRegs: TIDERegs;
    bDriveNumber: BYTE;
    bReserved: array[0..2] of Byte;
    dwReserved: array[0..3] of DWORD;
    bBuffer: array[0..0] of Byte;
  end;

  TIdSector = packed record
    wGenConfig: Word;
    wNumCyls: Word;
    wReserved: Word;
    wNumHeads: Word;
    wBytesPerTrack: Word;
    wBytesPerSector: Word;
    wSectorsPerTrack: Word;
    wVendorUnique: array[0..2] of Word;
    sSerialNumber: array[0..19] of CHAR;
    wBufferType: Word;
    wBufferSize: Word;
    wECCSize: Word;
    sFirmwareRev: array[0..7] of Char;
    sModelNumber: array[0..39] of Char;
    wMoreVendorUnique: Word;
    wDoubleWordIO: Word;
    wCapabilities: Word;
    wReserved1: Word;
    wPIOTiming: Word;
    wDMATiming: Word;
    wBS: Word;
    wNumCurrentCyls: Word;
    wNumCurrentHeads: Word;
    wNumCurrentSectorsPerTrack: Word;
    ulCurrentSectorCapacity: DWORD;
    wMultSectorStuff: Word;
    ulTotalAddressableSectors: DWORD;
    wSingleWordDMA: Word;
    wMultiWordDMA: Word;
    bReserved: array[0..127] of BYTE;
  end;

  PIdSector = ^TIdSector;
  TDriverStatus = packed record
    bDriverError: Byte;
    bIDEStatus: Byte;
    bReserved: array[0..1] of Byte;
    dwReserved: array[0..1] of DWORD;
  end;

  TSendCmdOutParams = packed record
    cBufferSize: DWORD;
    DriverStatus: TDriverStatus;
    bBuffer: array[0..0] of BYTE;
  end;
var
  hDevice: Thandle;
  cbBytesReturned: DWORD;
  SCIP: TSendCmdInParams;
  aIdOutCmd: array[0..(SizeOf(TSendCmdOutParams) + IDENTIFY_BUFFER_SIZE-1)-1] of Byte;
  IdOutCmd: TSendCmdOutParams absolute aIdOutCmd;

procedure ChangeByteOrder(var Data; Size: Integer);
var
  ptr: Pchar;
  i: Integer;
  c: Char;
begin
  ptr := @Data;
  for I := 0 to (Size shr 1) - 1 do begin
    c := ptr^;
    ptr^ := (ptr + 1)^;
    (ptr + 1)^ := c;
    Inc(ptr, 2);
  end;
end;

begin
    Result := '';
    if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then
       begin // Windows NT, Windows 2000
         hDevice := CreateFile('\\.\PhysicalDrive0', GENERIC_READ or GENERIC_WRITE,
         FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
       end
    else // Version Windows 95 OSR2, Windows 98
       hDevice := CreateFile('\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0);
    if hDevice = INVALID_HANDLE_VALUE then Exit;
    try
      FillChar(SCIP, SizeOf(TSendCmdInParams) - 1, #0);
      FillChar(aIdOutCmd, SizeOf(aIdOutCmd), #0);
      cbBytesReturned := 0;
      with SCIP do
      begin
        cBufferSize := IDENTIFY_BUFFER_SIZE;
        with irDriveRegs do
        begin
          bSectorCountReg := 1;
          bSectorNumberReg := 1;
          bDriveHeadReg := $A0;
          bCommandReg := $EC;
        end;
      end;
      if not DeviceIoControl(hDevice, $0007C088, @SCIP, SizeOf(TSendCmdInParams) - 1,@aIdOutCmd, SizeOf(aIdOutCmd), cbBytesReturned, nil) then Exit;
    finally
      CloseHandle(hDevice);
    end;
    with PIdSector(@IdOutCmd.bBuffer)^ do
    begin
      ChangeByteOrder(sSerialNumber, SizeOf(sSerialNumber));
      (Pchar(@sSerialNumber) + SizeOf(sSerialNumber))^:= #0;
      Result := Pchar(@sSerialNumber);
    end;
end;
function GetMDd5(const aStr:String):string;
var md:MD5Digest; i:integer;
begin md:=MD5String(aStr);
result:='';
for i:=low(md) to high(md) do begin result:=result+IntToHex(md[i],2);
end;
end;

function GetHadNumber: String;  //获取硬盘的出厂系列号；
begin
result:=Copy(DESCrypt.EnCrypt(strpas(GetIdeSerialNumber),'asdfxxx;'),5,7)+GetMDd5(DESCrypt.EnCrypt(StrToBase64(DESCrypt.EnCrypt(strpas(GetIdeSerialNumber),'asdfxxx;')),'ABCDEFG'));
end;
procedure TFrmRegSoft.FormCreate(Sender: TObject);
begin
Edit1.Text:=getHadNumber;
end;

procedure TFrmRegSoft.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TFrmRegSoft.Button1Click(Sender: TObject);
var reg:tregistry;
begin
IF Memo1.Text<>'' then begin
reg:=tregistry.create;
reg.rootkey:=HKEY_LOCAL_MACHINE;
reg.openkey('SOFTWARE\GameOfWoool',true);
reg.WriteString('Registry',Memo1.Text);
reg.closekey;
reg.free;
ShowMessage('你需要重新启动程序来验证该信息..');
close;
end;
end;

end.
