unit PlugIn;

interface
uses
  Windows, Classes, SysUtils, Forms, Grobal2;
type
  TPlugInfo = record
    DllName: string;
    sDesc: string;
    Module: THandle;
  end;
{  TMsgProc=   procedure(Msg:PChar;nMsgLen:Integer;nMode:Integer);stdcall;
  TFindProc=  function(ProcName:PChar;nNameLen:Integer):Pointer;stdcall;
  TSetProc=  function (ProcAddr:Pointer;ProcName:PChar;nNameLen:Integer):Boolean;stdcall  ;
  TFindObj = function   (ObjName:PChar;nNameLen:Integer):TObject;stdcall;
  TPlugInit=  function(AppHandle:HWnd;MsgProc:TMsgProc;FindProc:TFindProc;SetProc:TSetProc;FindObj:TFindObj):PChar; stdcall;
 }
  pTPlugInfo = ^TPlugInfo;
  TPlugInManage = class
    PlugList: TStringList;


  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadPlugIn();
    procedure UnLoadPlugIn();
    procedure StartM2ServerDLL();
  end;
procedure MainMessage(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
procedure SendBroadCastMsg(Msg: PChar; MsgType: TMsgType); stdcall;
procedure SetRunSocketRun(RunSockRun: TClassProc); stdcall;
function FindProcTable(ProcName: PChar; nNameLen: Integer): Pointer; stdcall;
function SetProcTable(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean; stdcall
function FindOBjTable(ObjName: PChar; nNameLen: Integer): TObject; stdcall;

implementation

uses M2Share, EDcode;
const
  StrProc5 = 'PrQpORAtQSIaX`IkYRup';
  StrProc6 = 'PrQpPbQiWsMaR@yNNrQu';
  //GetVersion
  StrFun1 = 'MrQpQbQnXrakW\';
  //GetXORKey
  StrFun2 = 'MrQpR@yNNrQu';
var
  nM2ServerVersion: Integer = -1;
  nStartPlug: Integer = -1;
  PN_SENDBROADCASTMSG: string;

procedure MainMessage(Msg: PChar; nMsgLen: Integer; nMode: Integer);
var
  MsgBuff: string;
begin
  if (Msg <> nil) and (nMsgLen > 0) then
  begin
    SetLength(MsgBuff, nMsgLen);
    Move(Msg^, MsgBuff[1], nMsgLen);
    case nMode of
      0:
        begin

        end;
    else
      MainOutMessage(MsgBuff);
    end;
  end;
end;

procedure SendBroadCastMsg(Msg: PChar; MsgType: TMsgType); stdcall;
begin
  if UserEngine <> nil then
    UserEngine.SendBroadCastMsgExt(Msg, MsgType);
end;

procedure SetRunSocketRun(RunSockRun: TClassProc); stdcall;
begin

end;

//=================================
//由DLL调用按名字查找函数地址

function FindProcTable(ProcName: PChar; nNameLen: Integer): Pointer;
var
  I: Integer;
  sProcName: string;
begin
  Result := nil;
  SetLength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for I := Low(ProcArray) to High(ProcArray) do
  begin
    if (ProcArray[I].nProcAddr <> nil) and (CompareText(sProcName, ProcArray[I].sProcName) = 0) then
    begin
      Result := ProcArray[I].nProcAddr;
      break;
    end;
  end;
end;
//=================================
//由DLL调用按名字设置插件中的函数地址

function SetProcTable(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean;
var
  I: Integer;
  sProcName: string;
begin
  Result := False;
  SetLength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for I := Low(PlugProcArray) to High(PlugProcArray) do
  begin
    if (PlugProcArray[I].nProcAddr = nil) and (CompareText(sProcName, PlugProcArray[I].sProcName) = 0) then
    begin
      PlugProcArray[I].nProcAddr := ProcAddr;
      Result := True;
      break;
    end;
  end;
end;
//=================================
//由DLL调用按名字查找全局对象地址

function FindOBjTable(ObjName: PChar; nNameLen: Integer): TObject;
var
  I: Integer;
  sObjName: string;
begin
  Result := nil;
  SetLength(sObjName, nNameLen);
  Move(ObjName^, sObjName[1], nNameLen);
  for I := Low(ProcArray) to High(ProcArray) do
  begin
    if (OBjectArray[I].Obj <> nil) and (CompareText(sObjName, OBjectArray[I].sObjcName) = 0) then
    begin
      Result := OBjectArray[I].Obj;
      break;
    end;
  end;
end;
{ TPlugIn }



constructor TPlugInManage.Create;
begin
  PlugList := TStringList.Create;
//  FillChar(ProcArray,SizeOf(ProcArray),0);
end;

destructor TPlugInManage.Destroy;
var
  I: integer;
begin
  if PlugList.Count > 0 then
    UnLoadPlugIn();
  for I := 0 to PlugList.count - 1 do
  begin
    dispose(pTPlugInfo(PlugList.Objects[i]));
  end;
  PlugList.Free;
  inherited;
end;

procedure TPlugInManage.LoadPlugIn;
var
  I: Integer;
  LoadList: TStringList;
  sPlugFileName: string;
  sPlugLibName: string;
  sPlugLibFileName: string;
  Moudle: THandle;
  PFunc: TPlugInit;
  PlugInfo: pTPlugInfo;
begin
{$IF SoftVersion = VERDEMO}
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  InitPlugArrayTable();
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
//  exit;
{$IFEND}
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  sPlugFileName := g_Config.sPlugDir + 'PlugList.txt';
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}

exit;

//  if FileExists(sPlugFileName) then begin
  if not FileExists(sPlugFileName) then
  begin
    LoadList := TStringList.Create;
    LoadList.Add('M2Server.dll');
    LoadList.SaveToFile(sPlugFileName);
    LoadList.Free;
  end;
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  LoadList := TStringList.Create;
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  LoadList.LoadFromFile(sPlugFileName);
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  for I := 0 to LoadList.Count - 1 do
  begin
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    sPlugLibName := Trim(LoadList.Strings[I]);
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    if (sPlugLibName = '') or (sPlugLibName[1] = ';') then
      Continue;
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    sPlugLibFileName := g_Config.sPlugDir + sPlugLibName;
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    if FileExists(sPlugLibFileName) then
    begin
{$IF DEBUG = 0}
      asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
      end;
{$IFEND}
      Moudle := Loadlibrary(PChar(sPlugLibFileName)); //FreeLibrary
{$IF DEBUG = 0}
      asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
      end;
{$IFEND}
      if Moudle > 32 then
      begin
{$IF DEBUG = 0}
        asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
        end;
{$IFEND}
        PFunc := GetProcAddress(Moudle, 'Init');
{$IF DEBUG = 0}
        asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
        end;
{$IFEND}
        if @PFunc <> nil then
        begin
{$IF DEBUG = 0}
          asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
          end;
{$IFEND}
          New(PlugInfo);
{$IF DEBUG = 0}
          asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
          end;
{$IFEND}
          PlugInfo.DllName := sPlugLibFileName;
{$IF DEBUG = 0}
          asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
          end;
{$IFEND}
          PlugInfo.sDesc := PFunc(Application.Handle, MainMessage, FindProcTable, SetProcTable, FindOBjTable);
{$IF DEBUG = 0}
          asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
          end;
{$IFEND}
          PlugList.AddObject(PlugInfo.sDesc, TObject(PlugInfo));
{$IF DEBUG = 0}
          asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
          end;
{$IFEND}
        end;
      end;
    end;
  end;
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  LoadList.Free;
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
//  end;

end;

procedure TPlugInManage.StartM2ServerDLL;
type
  TGetVersion = function(): Single; stdcall;
  TStartPlug = procedure(Config: pTConfig);
begin
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  if (nM2ServerVersion >= 0) and Assigned(PlugProcArray[nM2ServerVersion].nProcAddr) then
  begin
{$IF SoftVersion = VERENT}
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    if TGetVersion(PlugProcArray[nM2ServerVersion].nProcAddr) = 98 then
    begin
{$ELSE}
{$IF DEBUG = 0}
      asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
      end;
{$IFEND}
      if TGetVersion(PlugProcArray[nM2ServerVersion].nProcAddr) = 5 then
      begin
{$IFEND}

{$IF DEBUG = 0}
        asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
        end;
{$IFEND}
        if (nStartPlug >= 0) and Assigned(PlugProcArray[nStartPlug].nProcAddr) then
        begin
{$IF DEBUG = 0}
          asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
          end;
{$IFEND}
          TStartPlug(PlugProcArray[nStartPlug].nProcAddr)(@g_Config);
{$IF DEBUG = 0}
          asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
          end;
{$IFEND}
        end;
      end;
    end;
  end;

procedure TPlugInManage.UnLoadPlugIn;
var
  I: Integer;
  Module: THandle;
  PFunc: procedure();
begin
  for I := 0 to PlugList.Count - 1 do
  begin
    Module := THandle(PlugList.Objects[I]);
    PFunc := GetProcAddress(Module, 'UnInit');
    if @PFunc <> nil then
      PFunc();
    FreeLibrary(Module);
  end;
end;

//设远程XORKey

procedure SetRemoteXORKey(nRemoteXORKey: Integer; XORStr: PChar); stdcall;
begin
  RemoteXORKey := nRemoteXORKey;
end;

function GetVersion(): Single; stdcall;
begin
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  Result := M2ServerVersion;
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
end;

function GetXORKey(): Integer; stdcall;
begin
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  LocalXORKey := GetTickCount;
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  Result := LocalXORKey;
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
end;

procedure SetMaxUserCount(nUserCount: Integer); stdcall;
begin

end;
initialization
  begin
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    AddToProcTable(@SendBroadCastMsg, PN_SENDBROADCASTMSG);
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    nM2ServerVersion := AddToPulgProcTable(DecodeStringmir('OOEOUSErUSERUSEoVRyj') {'M2ServerVersion'});
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    nStartPlug := AddToPulgProcTable(DecodeStringmir('PsM]XcMLWCQc') {'StartPlug'});
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}

//  AddToProcTable(@SetMaxUserCount,DecodeString('SetMaxUserCount'));
    AddToProcTable(@SetMaxUserCount, DecodeStringmir(StrProc5));
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
//  AddToProcTable(@SetRemoteXORKey,'SetRemoteXORKey');
    AddToProcTable(@SetRemoteXORKey, DecodeStringmir(StrProc6));
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
//  AddToProcTable(@GetVersion,'GetVersion');
    AddToProcTable(@GetVersion, DecodeStringmir(StrFun1));
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
//  AddToProcTable(@GetVersion,'GetVersion');
    AddToProcTable(@GetXORKey, DecodeStringmir(StrFun2));
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
  end;
finalization
  begin

  end;

end.
