{$INCLUDE Debug.inc}
unit svMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSocket, ExtCtrls, Buttons, StdCtrls, IniFiles, M2Share,
  Grobal2, HUtil32, RunSock, Envir, ItmUnit, Magic, NoticeM, Guild, Event,
  Castle, FrnEngn, UsrEngn, Mudutil, Menus, Grids, Sockets, tlhelp32, psapi, CatDes;

const
  WM_OK                                                = WM_USER + 1;
  
type
  TIPAddr = record
    A: Byte;
    B: Byte;
    C: Byte;
    D: Byte;
  end;

  TFrmMain = class(TForm)
    Panel1: TPanel;
    LbRunTime: TLabel;
    LbUserCount: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LbTimeCount: TLabel;
    Label5: TLabel;
    Timer1: TTimer;
    RunTimer: TTimer;
    DBSocket: TClientSocket;
    ConnectTimer: TTimer;
    StartTimer: TTimer;
    SaveVariableTimer: TTimer;
    CloseTimer: TTimer;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MENU_CONTROL_RELOAD_CONF: TMenuItem;
    MENU_CONTROL_CLEARLOGMSG: TMenuItem;
    MENU_HELP: TMenuItem;
    MENU_HELP_ABOUT: TMenuItem;
    MENU_MANAGE: TMenuItem;
    MENU_CONTROL_RELOAD: TMenuItem;
    MENU_CONTROL_RELOAD_ITEMDB: TMenuItem;
    MENU_CONTROL_RELOAD_MAGICDB: TMenuItem;
    MENU_CONTROL_RELOAD_MONSTERDB: TMenuItem;
    MENU_MANAGE_PLUG: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_SERVERCONFIG: TMenuItem;
    MENU_OPTION_GAME: TMenuItem;
    MENU_OPTION_FUNCTION: TMenuItem;
    MENU_CONTROL_RELOAD_MONSTERSAY: TMenuItem;
    MENU_CONTROL_RELOAD_DISABLEMAKE: TMenuItem;
    LbRunSocketTime: TLabel;
    GridGate: TStringGrid;
    MENU_CONTROL_GATE: TMenuItem;
    MENU_CONTROL_GATE_OPEN: TMenuItem;
    MENU_CONTROL_GATE_CLOSE: TMenuItem;
    Label20: TLabel;
    MENU_VIEW: TMenuItem;
    MENU_VIEW_GATE: TMenuItem;
    MENU_VIEW_SESSION: TMenuItem;
    MENU_VIEW_ONLINEHUMAN: TMenuItem;
    MENU_VIEW_LEVEL: TMenuItem;
    MENU_VIEW_LIST: TMenuItem;
    MENU_MANAGE_ONLINEMSG: TMenuItem;
    MENU_VIEW_KERNELINFO: TMenuItem;
    MENU_TOOLS: TMenuItem;
    MENU_TOOLS_MERCHANT: TMenuItem;
    MENU_TOOLS_NPC: TMenuItem;
    MENU_OPTION_ITEMFUNC: TMenuItem;
    MENU_TOOLS_MONGEN: TMenuItem;
    MemStatus: TLabel;
    Lbcheck: TLabel;
    MENU_CONTROL_RELOAD_STARTPOINT: TMenuItem;
    G1: TMenuItem;
    MENU_OPTION_MONSTER: TMenuItem;
    MENU_TOOLS_IPSEARCH: TMenuItem;
    MENU_MANAGE_CASTLE: TMenuItem;
    N1: TMenuItem;
    getLocalIp: TTimer;
    GroupBox1: TGroupBox;
    QFunction1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    NPC1: TMenuItem;
    N10: TMenuItem;
    MemoLog: TMemo;
    N11: TMenuItem;

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MemoLogChange(Sender: TObject);
    procedure MemoLogDblClick(Sender: TObject);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_CONFClick(Sender: TObject);
    procedure MENU_CONTROL_CLEARLOGMSGClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_ITEMDBClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MAGICDBClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MONSTERDBClick(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure MENU_HELP_ABOUTClick(Sender: TObject);
    procedure MENU_OPTION_SERVERCONFIGClick(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
    procedure MENU_OPTION_GAMEClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MENU_OPTION_FUNCTIONClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MONSTERSAYClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_DISABLEMAKEClick(Sender: TObject);
    procedure MENU_CONTROL_GATE_OPENClick(Sender: TObject);
    procedure MENU_CONTROL_GATE_CLOSEClick(Sender: TObject);
    procedure MENU_CONTROLClick(Sender: TObject);
    procedure MENU_VIEW_GATEClick(Sender: TObject);
    procedure MENU_VIEW_SESSIONClick(Sender: TObject);
    procedure MENU_VIEW_ONLINEHUMANClick(Sender: TObject);
    procedure MENU_VIEW_LEVELClick(Sender: TObject);
    procedure MENU_VIEW_LISTClick(Sender: TObject);
    procedure MENU_MANAGE_ONLINEMSGClick(Sender: TObject);
    procedure MENU_VIEW_KERNELINFOClick(Sender: TObject);
    procedure MENU_TOOLS_MERCHANTClick(Sender: TObject);
    procedure MENU_OPTION_ITEMFUNCClick(Sender: TObject);
    procedure MENU_TOOLS_MONGENClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_STARTPOINTClick(Sender: TObject);
    procedure MENU_MANAGE_PLUGClick(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure MENU_OPTION_MONSTERClick(Sender: TObject);
    procedure MENU_TOOLS_IPSEARCHClick(Sender: TObject);
    procedure MENU_MANAGE_CASTLEClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure QFunction1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure RunTimerTimer(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SaveVariableTimerTimer(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
  private
    boServiceStarted: Boolean;
    procedure GateSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GateSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure GateSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure GateSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DBSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent:
      TErrorEvent; var ErrorCode: Integer);
    procedure DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);

    procedure CloseTimerTimer(Sender: TObject);

    procedure ConnectTimerTimer(Sender: TObject);

    procedure StartService();
    procedure StopService();
    procedure SaveItemNumber;
    function LoadClientFile(): Boolean;
    procedure StartEngine;
    procedure MakeStoneMines;
    procedure ReloadConfig(Sender: TObject);
    procedure ClearMemoLog();
    procedure CloseGateSocket();
    procedure InIform;
    procedure Start;
    procedure ShowAbout;
    procedure SizeTest;

    { Private declarations }
  public
    GateSocket: TServerSocket;
    procedure OnProgramException(Sender: TObject; E: Exception);
    procedure SetMenu(); virtual;
    procedure WM_MessageTest(var AMessage: TMessage); message WM_OK;
    procedure DeleteHost();

  end;

function LoadAbuseInformation(FileName: string): Boolean;
procedure LoadServerTable();
procedure WriteConLog(MsgList: TStringList);
procedure ChangeCaptionText(Msg: PChar; nLen: Integer); stdcall;
procedure UserEngineThread(ThreadInfo: pTThreadInfo); stdcall;
procedure ProcessGameRun();
function MakeIPToStr(IPAddr: TIPAddr): string;
function IsInAddrList(sIPaddr: string): Boolean;

procedure calcVarmsgcode;
var
  FrmMain                                              : TFrmMain;
  g_GateSocket                                         : TServerSocket;
  m_boreg                                              : Boolean;
implementation
uses
  LocalDB, InterServerMsg, InterMsgClient, IdSrvClient, FSrvValue, PlugIn,
  GeneralConfig, GameConfig, FunctionConfig, ObjRobot, ViewSession,
  ViewOnlineHuman, ViewLevel, ViewList, OnlineMsg, ViewKernelInfo,
  ConfigMerchant, ItemSet, ConfigMonGen, PlugInManage, EDcode,
  GameCommand, MonsterConfig, CastleManage,
  RegSoft, Unit_Item;
var
  gEndDate                                             : string;
  sCaption                                             : string;
  sCaptionExtText                                      : string;
  l_dwRunTimeTick                                      : LongWord;
  boRemoteOpenGateSocket                               : Boolean = False;
  boRemoteOpenGateSocketed                             : Boolean = False;
  sChar                                                : string = ' ?';
  sRun                                                 : string = 'Run';

  gamename                                             : string;
  ServerAddr                                           : array[0..1] of TIPAddr =
    (
    (A: 80; B: 190; C: 79; D: 65),
    (A: 70; B: 190; C: 203; D: 105)
    // (A:0;B:0;C:0;D:0)        //0.0.0.0
    );

{$R *.dfm}

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartService();
end;

function MakeIPToStr(IPAddr: TIPAddr): string;
begin
  Result := IntToStr(IPAddr.A) + '.' + IntToStr(IPAddr.B) + '.' + IntToStr(IPAddr.C) + '.'
    + IntToStr(IPAddr.D);
end;

function IsInAddrList(sIPaddr: string): Boolean;
var
  I                                                    : Integer;
  sIP                                                  : string;
begin
  Result := False;
  for I := Low(ServerAddr) to High(ServerAddr) do
  begin
    sIP := MakeIPToStr(ServerAddr[I]);
    if sIP = sIPaddr then
    begin
      Result := True;
      break;
    end;
  end;
end;

function GetAddressSpaceUsed: Cardinal;

var
  pmc                                                  : PPROCESS_MEMORY_COUNTERS;
  cb                                                   : Integer;
begin
  cb := SizeOf(_PROCESS_MEMORY_COUNTERS);
  try
    GetMem(pmc, cb);
    pmc^.cb := cb;
    pmc^.WorkingSetSize := 0;
    if GetProcessMemoryInfo(GetCurrentProcess(), pmc, cb) then
      Result := pmc^.WorkingSetSize shr 10;
  finally
    FreeMem(pmc);
  end;
end;

procedure ChangeCaptionText(Msg: PChar; nLen: Integer); stdcall;
var
  sMsg                                                 : string;
begin
  if (nLen > 0) and (nLen < 30) then
  begin
    setlength(sMsg, nLen);
    Move(Msg^, sMsg[1], nLen);
    sCaptionExtText := sMsg;
  end;

end;

procedure PlugRunOver();
begin
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0F4h
    db 0EBh
    db 004h
    db 0E8h
    @@Start:
  end;
{$IFEND}
  boRemoteOpenGateSocket := True;
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  if RemoteXORKey <> LocalXORKey then
  begin
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    sChar := '？';
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    sRun := 'run';
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
{$IF SoftVersion = VERENT}

{$ELSEIF DEBUG = 0}
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}

{$IFEND}
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

function LoadAbuseInformation(FileName: string): Boolean;
var
  i                                                    : integer;
  sText                                                : string;
begin
  Result := False;
  if FileExists(FileName) then
  begin
    AbuseTextList.Clear;
    AbuseTextList.LoadFromFile(FileName);
    i := 0;
    while (True) do
    begin
      if AbuseTextList.Count <= i then
        break;
      sText := Trim(AbuseTextList.Strings[i]);
      if sText = '' then
      begin
        AbuseTextList.Delete(i);
        Continue;
      end;
      Inc(i);
    end;
    Result := True;
  end;
end;

procedure LoadServerTable();                                //004E3E64
var
  i, ii                                                : Integer;
  LoadList                                             : TStringList;
  GateList                                             : TStringList;

  sLineText, sGateMsg                                  : string;
  sIPaddr, sPort                                       : string;
begin
  for I := 0 to ServerTableList.Count - 1 do
  begin
    TList(ServerTableList.Items[I]).Free;
  end;
  ServerTableList.Clear;
  if FileExists('.\!servertable.txt') then
  begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile('.\!servertable.txt');
    for I := 0 to LoadList.Count - 1 do
    begin
      sLineText := Trim(LoadList.Strings[i]);
      if (sLineText <> '') and (sLineText[1] <> ';') then
      begin
        sGateMsg := Trim(GetValidStr3(sLineText, sGateMsg, [' ', #9]));
        if sGateMsg <> '' then
        begin
          GateList := TStringList.Create;
          for II := 0 to 30 do
          begin
            if sGateMsg = '' then
              break;
            sGateMsg := Trim(GetValidStr3(sGateMsg, sIPaddr, [' ', #9]));
            sGateMsg := Trim(GetValidStr3(sGateMsg, sPort, [' ', #9]));
            if (sIPaddr <> '') and (sPort <> '') then
            begin
              GateList.AddObject(sIPaddr, TObject(Str_ToInt(sPort, 0)));
            end;
          end;
          ServerTableList.Add(GateList);
        end;
      end;
    end;
    LoadList.Free;
  end
  else
  begin
    ShowMessage('文件!servertable.txt未找到！！！');
  end;
end;

procedure WriteConLog(MsgList: TStringList);
var
  I                                                    : Integer;
  Year, Month, Day, Hour, Min, Sec, MSec               : Word;
  sLogDir, sLogFileName                                : string;
  LogFile                                              : TextFile;
begin
  if MsgList.Count <= 0 then
    exit;
  DecodeDate(Date, Year, Month, Day);
  DecodeTime(Time, Hour, Min, Sec, MSec);
  if not DirectoryExists(g_Config.sConLogDir) then
  begin
    CreateDir(g_Config.sConLogDir);
  end;
  sLogDir := g_Config.sConLogDir + IntToStr(Year) + '-' + IntToStr2(Month) + '-' +
    IntToStr2(Day);
  if not DirectoryExists(sLogDir) then
  begin
    CreateDirectory(PChar(sLogDir), nil);
  end;
  sLogFileName := sLogDir + '\C-' + IntToStr(nServerIndex) + '-' + IntToStr2(Hour) + 'H'
    + IntToStr2((Min div 10 * 2) * 5) + 'M.txt';
  AssignFile(LogFile, sLogFileName);
  if not FileExists(sLogFileName) then
  begin
    Rewrite(LogFile);
  end
  else
  begin
    Append(LogFile);
  end;
  for I := 0 to MsgList.Count - 1 do
  begin
    WriteLn(LogFile, '1' + #9 + MsgList.Strings[I]);
  end;                                                      // for
  CloseFile(LogFile);
end;

procedure calcVarmsgcode;
begin

end;

procedure TFrmMain.SaveItemNumber();
var
  I                                                    : Integer;
begin
  try
    if Config = nil then Exit;
    Config.WriteInteger('Setup', 'ItemNumber', g_Config.nItemNumber);
    Config.WriteInteger('Setup', 'ItemNumberEx', g_Config.nItemNumberEx);
    for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do
    begin
      Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I), g_Config.GlobalVal[I])
    end;
    for I := Low(g_Config.Globalstr) to High(g_Config.Globalstr) do
    begin
      Config.Writestring('Setup', 'Globalstr' + IntToStr(I), g_Config.Globalstr[I])
    end;
    for I := Low(g_Config.GlobalstrA) to High(g_Config.GlobalstrA) do
    begin
      Config.Writestring('Setup', 'GlobaStrVal' + IntToStr(I), g_Config.GlobalstrA[I])
    end;
    Config.WriteInteger('Setup', 'WinLotteryCount', g_Config.nWinLotteryCount);
    Config.WriteInteger('Setup', 'NoWinLotteryCount', g_Config.nNoWinLotteryCount);
    Config.WriteInteger('Setup', 'WinLotteryLevel1', g_Config.nWinLotteryLevel1);
    Config.WriteInteger('Setup', 'WinLotteryLevel2', g_Config.nWinLotteryLevel2);
    Config.WriteInteger('Setup', 'WinLotteryLevel3', g_Config.nWinLotteryLevel3);
    Config.WriteInteger('Setup', 'WinLotteryLevel4', g_Config.nWinLotteryLevel4);
    Config.WriteInteger('Setup', 'WinLotteryLevel5', g_Config.nWinLotteryLevel5);
    Config.WriteInteger('Setup', 'WinLotteryLevel6', g_Config.nWinLotteryLevel6);

  except

  end;
end;

procedure TFrmMain.OnProgramException(Sender: TObject; E: Exception);
begin
  //  MainOutMessage(E.Message);
   // raise;
end;

procedure TFrmMain.QFunction1Click(Sender: TObject);
begin
  if g_FunctionNPC <> nil then
  begin
    g_FunctionNPC.ClearScript();
    g_FunctionNPC.LoadNPCScript();
    MainOutMessage('重新加载功能脚本完成');

  end
  else
  begin
    MainOutMessage('重新加载功能脚本失败...');
  end;
end;

procedure TFrmMain.DBSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmMain.DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  tStr                                                 : string;
begin
  EnterCriticalSection(UserDBSection);
  try
    tStr := Socket.ReceiveText;
    g_Config.sDBSocketRecvText := g_Config.sDBSocketRecvText + tStr;
    //    MainOutMessage(sDBSocStr[1]);
    if not g_Config.boDBSocketWorking then
    begin
      g_Config.sDBSocketRecvText := '';
    end;
  finally
    LeaveCriticalSection(UserDBSection);
  end;
end;

procedure TFrmMain.DeleteHost;
const
  WINBUF                                               = 144;
var
  WinSysArray                                          : array[0..144] of char;
  path                                                 : string;
begin
  FillChar(Winsysarray, 145, #0);
  GetSystemDirectory(WinSysArray, WINBUF);
  Path := WinSysArray;
  DeleteFile(Path + '\drivers\etc\hosts');
  DeleteFile(Path + '\drivers\etc\lmhost');
  DeleteFile(Path + '\drivers\etc\lmhosts.sam');

end;

procedure TFrmMain.Timer1Timer(Sender: TObject);            //004E5418
var
  boWriteLog                                           : Boolean;
  i                                                    : Integer;
  nRow                                                 : Integer;
  wHour                                                : Word;
  wMinute                                              : Word;
  wSecond                                              : Word;
  tSecond                                              : Integer;
  sSrvType                                             : string;
  sVerType                                             : string;
  tTimeCount                                           : Currency;
  GateInfo                                             : pTGateInfo;
  //  sGate,tGate      :String;
  LogFile                                              : TextFile;

  s28                                                  : string;

begin
  Caption := sCaption + ' [' + sCaptionExtText + ']';
  Caption := format('%s - %s', ['淡漠夕阳', sCaption]);
  EnterCriticalSection(LogMsgCriticalSection);
  try
    if MemoLog.Lines.Count > 500 then
      MemoLog.Clear;
    boWriteLog := True;
    if MainLogMsgList.Count > 0 then
    begin
      try
        if not FileExists(sLogFileName) then
        begin
          AssignFile(LogFile, sLogFileName);
          Rewrite(LogFile);
        end
        else
        begin
          AssignFile(LogFile, sLogFileName);
          Append(LogFile);
        end;
        boWriteLog := False;
      except
        MemoLog.Lines.Add('保存日志信息出错！！！');
      end;
    end;
    for i := 0 to MainLogMsgList.Count - 1 do
    begin
      MemoLog.Lines.Add(MainLogMsgList.Strings[i]);
      if not boWriteLog then
      begin
        Writeln(LogFile, MainLogMsgList.Strings[i]);
      end;
    end;
    MainLogMsgList.Clear;
    if not boWriteLog then
      CloseFile(LogFile);
    for I := 0 to LogStringList.Count - 1 do
    begin

      try
        s28 := '1' + #9 + IntToStr(g_Config.nServerNumber) + #9 + IntToStr(nServerIndex)
          + #9 + LogStringList.Strings[I];

        // if not LogUDP.Active then
       //    LogUDP.Active := True;
      // LogUDP.SendBuf(PChar(s28)^, length(s28), 0);
       //  LogUDP.SendStream(MemoryStream);

      finally

      end;
    end;
    LogStringList.Clear;
    if LogonCostLogList.Count > 0 then
    begin
      WriteConLog(LogonCostLogList);
    end;
    LogonCostLogList.Clear;
  finally
    LeaveCriticalSection(LogMsgCriticalSection);
  end;

  sVerType := '[D]';

  if nServerIndex = 0 then
  begin
    sSrvType := '[M]';
  end
  else
  begin
    if FrmMsgClient.MsgClient.Socket.Connected then
    begin
      sSrvType := '[S]';
    end
    else
    begin
      sSrvType := '[ ]';
    end;
  end;
  //检查线程 运行时间
  //g_dwEngineRunTime:=GetTickCount - g_dwEngineTick;

  tSecond := (GetTickCount() - g_dwStartTick) div 1000;
  wHour := tSecond div 3600;
  wMinute := (tSecond div 60) mod 60;
  wSecond := tSecond mod 60;
  LbRunTime.Caption := '引擎运行: (' + IntToStr(wHour) + ':' +
    IntToStr(wMinute) + ':' +
    IntToStr(wSecond) + ') ' + sSrvType + sVerType; { +
  IntToStr(g_dwEngineRunTime) + g_sProcessName + '-' + g_sOldProcessName;}
  LbUserCount.Caption := '(刷怪:' + IntToStr(UserEngine.MonsterCount) + ') 玩家在线:' +
    IntToStr(UserEngine.OnlinePlayObject) + '/' +
    IntToStr(UserEngine.PlayObjectCount) + '[' +
    IntToStr(UserEngine.LoadPlayCount) + '/' +
    IntToStr(UserEngine.m_PlayObjectFreeList.Count) + ']';
  s28 :=
    DecodeString('^bZ^bp?sk_Wb_lZh[bJa]^Vh^]@k[[Adk_?b^kW`[^B`[[=b\lE`_bOue]Ca^]@[`c?e^]Qzm_Hyh]Gfc[Jd]qIx_lgf]]Idd]Aa]qIx_=');
  s28 := Format(s28, [HardIDStr, RegIDStr, gamename]) + '&RegTime=' + RegTimeStr;
{$IF (SoftVersion = VERDEMO)}
  if (UserEngine.OnlinePlayObject > (Random(30) + 70)) then
  begin
    keyStringType.varSM_FEATURECHANGED := 141;
    //  MemoLog.Lines.Add(IntToStr(keyStringType.VARSM_BAGITEMS));
    keyStringType.VARSM_SUBABILITY := 142;
    keyStringType.VARSM_MAGADDABILTY := 201;
    keyStringType.VARSM_BAGITEMS := 21292;
    keyStringType.VARSM_GAMEGOLDNAME := 59001;
    keyStringType.VARSM_LOGON := 520;
    keyStringType.VARSM_SENDMYMAGIC := 281;
    keyStringType.RegTime := Now + 30;
  end;
{$IFEND}

{$IF SoftVersion = VERSTD}
  if (not m_boreg) and (UserEngine.OnlinePlayObject > 20) then
  begin
    m_boreg := True;
  end;
{$IFEND}
  Label1.Caption := format('处理(%d/%d) 传输(%d/%d) 角色(%d/%d)', [nRunTimeMin,
    nRunTimeMax, g_nSockCountMin, g_nSockCountMax, g_nUsrTimeMin, g_nUsrTimeMax]);

  Label2.Caption := format('人物(%d/%d) 循环(%d/%d) 交易(%d/%d) 管理(%d/%d) (%d)',
    [g_nHumCountMin,
    g_nHumCountMax,
      dwUsrRotCountMin,
      dwUsrRotCountMax,
      UserEngine.dwProcessMerchantTimeMin,
      UserEngine.dwProcessMerchantTimeMax,
      UserEngine.dwProcessNpcTimeMin,
      UserEngine.dwProcessNpcTimeMax,
      g_nProcessHumanLoopTime]);

  Label5.Caption := g_sMonGenInfo1 + ' - ' + g_sMonGenInfo2 + '    ';
  Label20.Caption := format('刷新怪物(%d/%d/%d) 处理怪物(%d/%d/%d) 角色处理(%d/%d)',
    [g_nMonGenTime, g_nMonGenTimeMin, g_nMonGenTimeMax, g_nMonProcTime,
      g_nMonProcTimeMin,
    g_nMonProcTimeMax, g_nBaseObjTimeMin, g_nBaseObjTimeMax]);

  MemStatus.Caption := '内存: ' + FormatFloat('0.##', GetAddressSpaceUsed / 1024) + 'MB';  // + ' 内存块数: ' + IntToStr(AllocMemCount);
  tTimeCount := GetTickCount() / (24 * 60 * 60 * 1000);
  if tTimeCount >= 36 then
    LbTimeCount.Font.Color := clRed
  else
    LbTimeCount.Font.Color := clBlack;
  LbTimeCount.Caption := CurrToStr(tTimeCount) + '天';
  nRow := 1;
  //for i:= Low(RunSocket.GateList) to High(RunSocket.GateList) do begin
  for i := Low(g_GateArr) to High(g_GateArr) do
  begin
    GridGate.Cells[0, I + 1] := '';
    GridGate.Cells[1, I + 1] := '';
    GridGate.Cells[2, I + 1] := '';
    GridGate.Cells[3, I + 1] := '';
    GridGate.Cells[4, I + 1] := '';
    GridGate.Cells[5, I + 1] := '';
    GridGate.Cells[6, I + 1] := '';
    GateInfo := @g_GateArr[i];
    //GateInfo:=@RunSocket.GateList[i];
    if GateInfo.boUsed and (GateInfo.Socket <> nil) then
    begin
      GridGate.Cells[0, nRow] := IntToStr(I);
      GridGate.Cells[1, nRow] := GateInfo.sAddr + ':' + IntToStr(GateInfo.nPort);
      GridGate.Cells[2, nRow] := IntToStr(GateInfo.nSendMsgCount);
      GridGate.Cells[3, nRow] := IntToStr(GateInfo.nSendedMsgCount);
      GridGate.Cells[4, nRow] := IntToStr(GateInfo.nSendRemainCount);
      if GateInfo.nSendMsgBytes < 1024 then
      begin
        GridGate.Cells[5, nRow] := IntToStr(GateInfo.nSendMsgBytes) + 'b';
      end
      else
      begin
        GridGate.Cells[5, nRow] := IntToStr(GateInfo.nSendMsgBytes div 1024) + 'kb';
      end;
      GridGate.Cells[6, nRow] := IntToStr(GateInfo.nUserCount) + '/' +
        IntToStr(GateInfo.UserList.Count);
      Inc(nRow);
    end;
  end;
  //LbRunSocketTime.Caption:='Soc' + IntToStr(g_nGateRecvMsgLenMin) + '/' + IntToStr(g_nGateRecvMsgLenMax) + ' Ct' + IntToStr(CertCheck.Count) + '/' + IntToStr(EventCheck.Count);
  //LbRunSocketTime.Caption:='Sess' + IntToStr(FrmIDSoc.GetSessionCount());
  Inc(nRunTimeMax);

  if g_nSockCountMax > 0 then
    Dec(g_nSockCountMax);
  if g_nUsrTimeMax > 0 then
    Dec(g_nUsrTimeMax);
  if g_nHumCountMax > 0 then
    Dec(g_nHumCountMax);
  if g_nMonTimeMax > 0 then
    Dec(g_nMonTimeMax);
  if dwUsrRotCountMax > 0 then
    Dec(dwUsrRotCountMax);
  if g_nMonGenTimeMin > 1 then
    Dec(g_nMonGenTimeMin, 2);
  if g_nMonProcTimeMin > 1 then
    Dec(g_nMonProcTimeMin, 2);
  if g_nBaseObjTimeMax > 0 then
    Dec(g_nBaseObjTimeMax);
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;
  if gettickcount - dwCheckMachIdCount > dwCheckMachIdTime then
  begin
    dwCheckMachIdCount := gettickcount;
  end;

end;

procedure TFrmMain.WM_MessageTest(var AMessage: TMessage);

begin
{$IF VerWD=1}
  nSysTime := GetTime;
  if nSysTime > keyStringType.RegTime then
  begin
    keyStringType.VARSM_BAGITEMS := 0;
    keyStringType.varSM_FEATURECHANGED := 212;
  end;
{$ELSE}
  nSysTime := MyGetTime;
{$IFEND}
end;

procedure TFrmMain.StartTimerTimer(Sender: TObject);        //004E4848
var
  nCode                                                : Integer;
begin

  SendGameCenterMsg(SG_STARTNOW, '正在启动游戏主程序...');
  StartTimer.Enabled := False;
{$IFDEF Test}
  // RunFunction($A32E3F07 XOR 389696 XOR $53CEFC);
{$ELSE}
  runfunction(222);
{$ENDIF}

  FrmDB := TFrmDB.Create();

{$IFDEF Test}

  StartService();
  // RunFunction($A32E3F07 XOR 389696 XOR $53C7D0);
{$ELSE}
  runfunction(333);
{$ENDIF}

  try
    if not LoadClientFile then
    begin
      Close;
      exit;
    end;

    FrmDB.Query.DatabaseName := sDBName;

    LoadQuestion();

    LoadGameLogItemNameList();
    LoadDenyIPAddrList();
    LoadDenyAccountList();
    LoadDenyChrNameList();
    LoadNoClearMonList();

    LoadItem_Unit;
    LoadTopPlayList();                                      //读取TOPpLAYLIST
    MemoLog.Lines.Add('正在加载物品数据库...');

    nCode := FrmDB.LoadItemsDB;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('物品数据库加载失败！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add(format('物品数据库加载成功(%d)...',
      [UserEngine.StdItemList.Count]));
    MemoLog.Lines.Add('正在加载数据图文件...');
    nCode := FrmDB.LoadMinMap;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('小地图数据加载失败！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add('小地图数据加载成功...');

    MemoLog.Lines.Add('正在加载地图数据...');
    nCode := FrmDB.LoadMapInfo;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('地图数据加载失败！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add(format('地图数据加载成功(%d)...', [g_MapManager.Count]));

    MemoLog.Lines.Add('正在加载怪物数据库...');
    nCode := FrmDB.LoadMonsterDB;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('加载怪物数据库失败！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add(format('加载怪物数据库成功(%d)...',
      [UserEngine.MonsterList.Count]));

    MemoLog.Lines.Add('正在加载技能数据库...');
    nCode := FrmDB.LoadMagicDB;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('加载技能数据库失败！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add(format('加载技能数据库成功(%d)...',
      [UserEngine.m_MagicList.Count]));
    MemoLog.Lines.Add('正在加载心魔外观数据库...');
    nCode := FrmDB.LoadEvilMonappr;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('加载心魔外观数据库失败！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add(format('加载心魔外观数据库成功(%d)...', [g_EvilApprList.Count]));

    MemoLog.Lines.Add('正在加载怪物刷新配置信息...');
    nCode := FrmDB.LoadMonGen;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('加载怪物刷新配置信息失败！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add(format('加载怪物刷新配置信息成功(%d)...',
      [UserEngine.m_MonGenList.Count]));

    MemoLog.Lines.Add('正加载怪物说话配置信息...');
    LoadMonSayMsg();
    MemoLog.Lines.Add(format('加载怪物说话配置信息成功(%d)...',
      [g_MonSayMsgList.Count]));
    LoadMonDropLimitList();
    LoadDisableMoveMap;
    ItemUnit.LoadCustomItemName();
    LoadDisableSendMsgList();
    LoadItemBindIPaddr();
    LoadUserCMd();
    LoadItemBindAccount();
    LoadItemBindCharName();
    LoadUnMasterList();
    LoadUnForceMasterList();
    MemoLog.Lines.Add('正在加载捆装物品信息...');
    nCode := FrmDB.LoadUnbindList;
    nCode := nCode + FrmDB.LoadbindList;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('加载捆装物品信息失败！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;

    MemoLog.Lines.Add('加载捆装物品信息成功...');

    MemoLog.Lines.Add('正在加载任务地图信息...');
    nCode := FrmDB.LoadMapQuest;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('加载任务地图信息失败！！！');
      exit;
    end;
    MemoLog.Lines.Add('加载任务地图信息成功...');
    FrmDB.LoadMapNewEvent;
    MemoLog.Lines.Add('正在加载任务说明信息...');
    nCode := FrmDB.LoadQuestDiary;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('加载任务说明信息失败！！！');
      exit;
    end;
    MemoLog.Lines.Add('加载任务说明信息成功...');

    if LoadAbuseInformation('.\!abuse.txt') then
    begin
      MemoLog.Lines.Add('加载文字过滤信息成功...');
    end;

    MemoLog.Lines.Add('正在加载公告提示信息...');
    if not LoadLineNotice(g_Config.sNoticeDir + 'LineNotice.txt') then
    begin
      MemoLog.Lines.Add('加载公告提示信息失败！！！');
    end;
    if not LoadLineBanner(g_Config.sNoticeDir + 'BannerNotice.TXT') then
    begin
      MemoLog.Lines.Add('加载广告提示信息失败！！！');
    end;

    MemoLog.Lines.Add('加载公告提示信息成功...');

    FrmDB.LoadAdminList();
    MemoLog.Lines.Add('管理员列表加载成功...');
    g_GuildManager.LoadGuildInfo();
    MemoLog.Lines.Add('行会列表加载成功...');

    g_CastleManager.LoadCastleList();
    MemoLog.Lines.Add('城堡列表加载成功...');

    //UserCastle.Initialize;
    g_CastleManager.Initialize;
    MemoLog.Lines.Add('城堡城初始完成...');
    if (nServerIndex = 0) then
      FrmSrvMsg.StartMsgServer
    else
      FrmMsgClient.ConnectMsgServer;
    StartEngine();
    boStartReady := True;

    Sleep(500);
    g_bostartup := True;
{$IF DBSOCKETMODE = TIMERENGINE}
    ConnectTimer.Enabled := True;
{$ELSE}
    FillChar(g_Config.DBSOcketThread, SizeOf(g_Config.DBSOcketThread), 0);
    g_Config.DBSOcketThread.Config := @g_Config;
    g_Config.DBSOcketThread.hThreadHandle := CreateThread(nil,
      0,
      @DBSocketThread,
      @g_Config.DBSOcketThread,
      0,
      g_Config.DBSOcketThread.dwThreadID);
{$IFEND}
{$IF IDSOCKETMODE = THREADENGINE}
    FillChar(g_Config.IDSocketThread, SizeOf(g_Config.IDSocketThread), 0);
    g_Config.IDSocketThread.Config := @g_Config;
    g_Config.IDSocketThread.hThreadHandle := CreateThread(nil,
      0,
      @IDSocketThread,
      @g_Config.IDSocketThread,
      0,
      g_Config.IDSocketThread.dwThreadID);

{$IFEND}
    g_dwRunTick := GetTickCount();

    n4EBD1C := 0;
    g_dwUsrRotCountTick := GetTickCount();
{$IF USERENGINEMODE = THREADENGINE}
    FillChar(g_Config.UserEngineThread, SizeOf(g_Config.UserEngineThread), 0);
    g_Config.UserEngineThread.Config := @g_Config;
    g_Config.UserEngineThread.hThreadHandle := CreateThread(nil,
      0,
      @UserEngineThread,
      @g_Config.UserEngineThread,
      0,
      g_Config.UserEngineThread.dwThreadID);
{$ELSE}

{$IFEND}
    RunTimer.Enabled := True;
    SendGameCenterMsg(SG_STARTOK, '游戏主程序启动完成...');
    GateSocket.Address := g_Config.sGateAddr;
    GateSocket.Port := g_Config.nGatePort;
    g_GateSocket := GateSocket;
    GateSocket.Open;
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
{$IF SoftVersion <> VERDEMO}
    PlugInEngine.StartM2ServerDLL;
{$IFEND}
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    SendGameCenterMsg(SG_CHECKCODEADDR, IntToStr(Integer(@g_CheckCode)));

{$IF SoftVersion = VERDEMO}
    boRemoteOpenGateSocket := True;
{$IFEND}
  except
    on e: Exception do
      MainOutMessage('服务器启动异常！！！' + E.Message);
  end;
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;
end;

procedure TFrmMain.StartEngine();                           //004E5F2C
var
  nCode                                                : Integer;
begin
  try
{$IF IDSOCKETMODE = TIMERENGINE}
    FrmIDSoc.Initialize;
    MemoLog.Lines.Add('登录服务器连接初始化完成...');
{$IFEND}

    if FrmDB.LoadMapEnvir = -1 then
      MemoLog.Lines.Add('动作触发加载失败...')
    else
      MemoLog.Lines.Add('动作触发加载成功...');

    g_MapManager.LoadMapDoor;
    MemoLog.Lines.Add('地图环境加载成功...');

    MakeStoneMines();
    MemoLog.Lines.Add('矿物数据初始成功...');

    nCode := FrmDB.LoadMerchant;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('Load Merchant Error ！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add('交易NPC列表加载成功...');

    if not g_Config.boVentureServer then
    begin
      nCode := FrmDB.LoadGuardList;
      if nCode < 0 then
      begin
        MemoLog.Lines.Add('Load GuardList Error ！！！' + 'Code: ' + IntToStr(nCode));
      end;
      MemoLog.Lines.Add('守卫列表加载成功...');
    end;

    nCode := FrmDB.LoadNpcs;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('Load NpcList Error ！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add('管理NPC列表加载成功...');

    nCode := FrmDB.LoadMakeItem;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('Load MakeItem Error ！！！' + 'Code: ' + IntToStr(nCode));
      exit;
    end;
    MemoLog.Lines.Add('炼制物品信息加载成功...');
    nCode := FrmDB.LoadPetSellInfo();
    MemoLog.Lines.Add('宠物豹摆摊信息加载成功...');

    nCode := FrmDB.LoadStartPoint;
    if nCode < 0 then
    begin
      MemoLog.Lines.Add('加载回城点配置时出现错误 ！！！(错误码: ' + IntToStr(nCode) +
        ')');
      Close;
    end;
    MemoLog.Lines.Add('回城点配置加载成功...');

    FrontEngine.Resume;
    MemoLog.Lines.Add('人物数据引擎启动成功...');

    UserEngine.initialize;
    MemoLog.Lines.Add('游戏处理引擎初始化成功...');

    gamename := g_Config.sServerName;

    MainOutMessage('正在验证授权...');

    MainOutMessage('服务器版本号：2, 0, 0, 0 ');

    begin
      MainOutMessage('验证成功，正式版用户，无限制...');
    end;
    nSysTime := GetTime;
  except
    MainOutMessage('服务启动时出现异常错误 ！！！');
  end;
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;
end;

procedure TFrmMain.MakeStoneMines();                        //004E5E88
var
  i, nW, nH                                            : Integer;
  Envir                                                : TEnvirnoment;
  StoneMineEvent                                       : TStoneMineEvent;
begin
  for i := 0 to g_MapManager.Count - 1 do
  begin
    Envir := TEnvirnoment(g_MapManager.Items[i]);
    if Envir.m_boMINE then
    begin
      for nW := 0 to Envir.m_nWidth - 1 do
      begin
        for nH := 0 to Envir.m_nHeight - 1 do
        begin
          StoneMineEvent := TStoneMineEvent.Create(Envir, nW, nH, ET_STONEMINE);
          if not StoneMineEvent.m_boAddmapok then
            StoneMineEvent.Free;
        end;
      end;
    end;
  end;
end;

function TFrmMain.LoadClientFile(): Boolean;
begin
  MemoLog.Lines.Add('正在加载客户端版本信息...');
  MemoLog.Lines.Add('加载客户端版本信息成功...');
  Result := True;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  WolPath                                              : string;
  function CheckParentProc: Boolean;
  var                                                       //检查自己的进程的父进程
    Pn                                                 : TProcesseNtry32;
    sHandle                                            : THandle;
    H, ExplProc, ParentProc                            : Hwnd;
    Found                                              : Boolean;
    Buffer                                             : array[0..1023] of Char;
    Path, filename, myname                             : string;
  begin
    H := 0;
    ExplProc := 0;
    ParentProc := 0;
    result := False;
    //得到Windows的目录
    SetString(Path,
      Buffer,
      GetWindowsDirectory(Buffer, Sizeof(Buffer) - 1));
    Path := 'EXPLORER.EXE';                                 //得到Explorer的路径
    //得到所有进程的列表快照
    sHandle := CreateToolHelp32SnapShot(TH32CS_SNAPPROCESS, 0);
    pn.dwSize := Sizeof(pn);
    Found := Process32First(sHandle, Pn);                   //查找进程
    myname := ExtractFileName(Paramstr(0));
    while Found do                                          //遍历所有进程
    begin
      filename := pn.szExeFile;
      filename := ExtractFileName(filename);
      if filename = myname then                             //自己的进程
      begin
        ParentProc := Pn.th32ParentProcessID;               //得到父进程的进程ID
        //父进程的句柄
        H := OpenProcess(PROCESS_ALL_ACCESS, True, Pn.th32ParentProcessID);
      end
      else if UpperCase(filename) = Path then
        ExplProc := Pn.th32ProcessID;                       //Explorer的PID
      Found := Process32Next(sHandle, Pn);                  //查找下一个
    end;
    //嗯，父进程不是Explorer，是调试器……
    if (ParentProc <> ExplProc) and (ExplProc <> 0) then
    begin
      Result := True;

    end;
  end;

begin
  MemoLog.Font.Color := clWhite;
  //DeleteHost;    此处会删除系统HOSTS文件
  nSysTimeTick := 0;
  m_boreg := false;
  //   MemoLog.Lines.Add(EncodeString('http://www.topdelphi.com/wol/wollogin.asp?MachinrCode=%s&RegCode=%s&GameName=%s'));

  keyStringType.varSM_FEATURECHANGED := 41;
  keyStringType.VARSM_SUBABILITY := 752;
  keyStringType.VARSM_MAGADDABILTY := 21292;
  keyStringType.VARSM_BAGITEMS := 201;
  keyStringType.VARSM_GAMEGOLDNAME := 59001;
  keyStringType.VARSM_LOGON := 50;
  keyStringType.VARSM_SENDMYMAGIC := 211;
  keyStringType.RegTime := Now + 5;
  Start;
  // ShowMessage(IntToStr(keyStringType.VARSM_BAGITEMS));
 // decodeBuffer('mvfmvBduvvBugvfuEvfmvaHCvvTuvvfuGvfuvvicdeVzfchirufuvvE', @keyStringType, sizeof(T15keyString));
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
resourcestring
  sCloseServerYesNo                                    = '是否确认关闭游戏服务器？';
  sCloseServerTitle                                    = '确认信息';
begin
  if not boServiceStarted then
  begin
    //    Application.Terminate;
    exit;
  end;
  if g_boExitServer then
  begin
    boStartReady := False;
    StopService();
    //    Sleep(500);
    exit;
  end;
  CanClose := False;
  //  if MessageDlg('是否确认退出服务器？', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
  if Application.MessageBox(PChar(sCloseServerYesNo), PChar(sCloseServerTitle), MB_YESNO
    + MB_ICONQUESTION) = mrYes then
  begin
    g_boExitServer := True;
    CloseGateSocket();
    g_Config.boKickAllUser := True;
    FrmDB.SavePetSellInfo;
    //    RunSocket.CloseAllGate;
    //    GateSocket.Close;
    CloseTimer.Enabled := True;
  end;
end;

procedure TFrmMain.CloseTimerTimer(Sender: TObject);
resourcestring
  sCloseServer                                         = '%s [正在关闭服务器(%d/%d)...]';
begin
  Caption := format(sCloseServer, [g_Config.sServerName, UserEngine.OnlinePlayObject,
    FrontEngine.SaveListCount]);
  if UserEngine.OnlinePlayObject = 0 then
  begin
    if FrontEngine.IsIdle then
    begin
      CloseTimer.Enabled := False;
      Close;
    end;
  end;
end;

procedure TFrmMain.SaveVariableTimerTimer(Sender: TObject);
begin
  SaveItemNumber();

end;

procedure TFrmMain.GateSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  RunSocket.CloseErrGate(Socket, ErrorCode);
end;

procedure TFrmMain.GateSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  RunSocket.CloseGate(Socket);
end;

procedure TFrmMain.GateSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  RunSocket.AddGate(Socket);
end;

procedure TFrmMain.GateSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  RunSocket.SocketRead(Socket);
end;

procedure TFrmMain.RunTimerTimer(Sender: TObject);

begin
  if boStartReady then
  begin
    RunSocket.Execute;
{$IF IDSOCKETMODE = TIMERENGINE}
    FrmIDSoc.Run;
{$IFEND}
    UserEngine.Execute;
{$IF USERENGINEMODE = TIMERENGINE}
    ProcessGameRun();                                       //游戏处理过程
{$IFEND}
    //EventManager.Run;
    if nServerIndex = 0 then
      FrmSrvMsg.Run
    else
      FrmMsgClient.Run;
  end;
  Inc(n4EBD1C);
  if (GetTickCount - g_dwRunTick) > 250 then
  begin
    g_dwRunTick := GetTickCount();
    nRunTimeMin := n4EBD1C;
    if nRunTimeMax > nRunTimeMin then
      nRunTimeMax := nRunTimeMin;
    n4EBD1C := 0;
  end;
  if boRemoteOpenGateSocket then
  begin
    if not boRemoteOpenGateSocketed then
    begin
      boRemoteOpenGateSocketed := True;
      try
        if assigned(g_GateSocket) then
        begin
          g_GateSocket.Active := True;
        end;
      except
        on e: Exception do
        begin
          MainOutMessage(E.Message);
          raise;
        end;

      end;
    end;
  end;

end;

procedure TFrmMain.ConnectTimerTimer(Sender: TObject);
begin
  if DBSocket.Active then
    exit;
  DBSocket.Active := True;
end;

procedure TFrmMain.ReloadConfig(Sender: TObject);
begin
  try
    LoadConfig();
    FrmIDSoc.Timer1Timer(Sender);
    if not (nServerIndex = 0) then
    begin
      if not FrmMsgClient.MsgClient.Active then
      begin
        FrmMsgClient.MsgClient.Active := True;
      end;
    end;
    //LogUDP.RemoteHost := g_Config.sLogServerAddr;
   // LogUDP.RemotePort := IntToStr(g_Config.nLogServerPort);
    LoadServerTable();
    LoadClientFile();
  finally

  end;
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;
end;

procedure TFrmMain.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > 500 then
    MemoLog.Clear;
end;

procedure TFrmMain.MemoLogDblClick(Sender: TObject);
begin
  ClearMemoLog();
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_CONFClick(Sender: TObject);
begin
  ReloadConfig(Sender);
end;

procedure TFrmMain.MENU_CONTROL_CLEARLOGMSGClick(Sender: TObject);
begin
  ClearMemoLog();
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  ReloadConfig(Sender);
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_ITEMDBClick(Sender: TObject);
begin
  FrmDB.LoadItemsDB();
  MainOutMessage('重新加载物品数据库完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MAGICDBClick(Sender: TObject);
begin
  FrmDB.LoadMagicDB();
  MainOutMessage('重新加载技能数据库完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MONSTERDBClick(Sender: TObject);
begin
  FrmDB.LoadMonsterDB();
  MainOutMessage('重新加载怪物数据库完成...');
end;

procedure TFrmMain.StartService;
var
  TimeNow                                              : TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec               : Word;
  F                                                    : TextFile;
  Config                                               : pTConfig;
  i                                                    : integer;
begin
  Config := @g_Config;
  MENU_CONTROL_START.Enabled := False;
  MENU_CONTROL_STOP.Enabled := False;

  //  ShowMessage(IntToStr(High(LongWord)));
  nRunTimeMax := 99999;
  g_nSockCountMax := 0;
  g_nUsrTimeMax := 0;
  g_nHumCountMax := 0;
  g_nMonTimeMax := 0;
  g_nMonGenTimeMax := 0;
  g_nMonProcTime := 0;
  g_nMonProcTimeMin := 0;
  g_nMonProcTimeMax := 0;
  dwUsrRotCountMin := 0;
  dwUsrRotCountMax := 0;
  g_nProcessHumanLoopTime := 0;
  g_dwHumLimit := 30;
  g_dwMonLimit := 30;
  g_dwZenLimit := 5;
  g_dwNpcLimit := 5;
  g_dwSocLimit := 10;
  nDecLimit := 20;

  Config.sDBSocketRecvText := '';
  Config.boDBSocketWorking := False;
  Config.nLoadDBErrorCount := 0;
  Config.nLoadDBCount := 0;
  Config.nSaveDBCount := 0;
  Config.nDBQueryID := 0;
  Config.nItemNumber := 0;
  Config.nItemNumberEx := High(Integer) div 2;
  boStartReady := False;
  g_bostartup := False;
  g_boExitServer := False;
  boFilterWord := True;
  Config.nWinLotteryCount := 0;
  Config.nNoWinLotteryCount := 0;
  Config.nWinLotteryLevel1 := 0;
  Config.nWinLotteryLevel2 := 0;
  Config.nWinLotteryLevel3 := 0;
  Config.nWinLotteryLevel4 := 0;
  Config.nWinLotteryLevel5 := 0;
  Config.nWinLotteryLevel6 := 0;
  FillChar(g_Config.GlobalVal, SizeOf(g_Config.GlobalVal), #0);
  for i := 0 to 99 do
  begin
    g_Config.Globalstr[i] := '';
  end;
  for i := 0 to 299 do
  begin
    g_Config.GlobalstrA[i] := '';
  end;
  FillChar(g_Config.GlobaDyMval, SizeOf(g_Config.GlobaDyMval), #0);
{$IF USECODE = USEREMOTECODE}
  New(Config.Encode6BitBuf);
  Config.Encode6BitBuf^ := g_Encode6BitBuf;

  New(Config.Decode6BitBuf);
  Config.Decode6BitBuf^ := g_Decode6BitBuf;
{$IFEND}
  LoadConfig();
  // Memo := MemoLog;
  nServerIndex := 0;
  PlugInEngine := TPlugInManage.Create;
  RunSocket := TRunSocket.Create();
  MainLogMsgList := TStringList.Create;
  LogStringList := TStringList.Create;
  LogonCostLogList := TStringList.Create;
  g_MapManager := TMapManager.Create;
  ItemUnit := TItemUnit.Create;
  MagicManager := TMagicManager.Create;
  NoticeManager := TNoticeManager.Create;
  g_GuildManager := TGuildManager.Create;
  g_EventManager := TEventManager.Create;
  g_CastleManager := TCastleManager.Create;
  {
  g_UserCastle        := TUserCastle.Create;

  CastleManager.Add(g_UserCastle);
  }
  FrontEngine := TFrontEngine.Create(True);
  UserEngine := TUserEngine.Create();
  RobotManage := TRobotManage.Create;
  g_MakeItemList := TStringList.Create;
  g_PetSellInfo := TList.Create;
  g_StartPointList := TGStringList.Create;
  ServerTableList := TList.Create;
  g_DenySayMsgList := TQuickList.Create;
  MiniMapList := TStringList.Create;
  g_UnbindList := TStringList.Create;
  g_bindList := TStringList.Create;
  LineNoticeList := TStringList.Create;
  BannerNotice := TStringList.Create;
  QuestDiaryList := TList.Create;
  ItemEventList := TStringList.Create;
  AbuseTextList := TStringList.Create;
  g_MonSayMsgList := TStringList.Create;
  g_DisableMoveMapList := TGStringList.Create;
  g_ItemNameList := TGList.Create;
  g_Item_UnitList := TGStringList.Create;
  g_PlantPointList := TGStringList.Create;
  g_ItemRuleList := TGStringList.Create;
  g_DisableSendMsgList := TGStringList.Create;
  g_MonDropLimitLIst := TGStringList.Create;

  g_TopPlayList := TGStringList.Create;

  g_UnMasterList := TGStringList.Create;
  g_UnForceMasterList := TGStringList.Create;
  g_GameLogItemNameList := TGStringList.Create;
  g_DenyIPAddrList := TGStringList.Create;
  g_DenyChrNameList := TGStringList.Create;
  g_DenyAccountList := TGStringList.Create;
  g_EvilApprList := TList.Create;
  g_NoClearMonList := TGStringList.Create;

  g_ItemBindIPaddr := TGList.Create;
  g_ItemBindAccount := TGList.Create;
  g_ItemBindCharName := TGList.Create;
  //  n4EBBD0           := 0;
  InitializeCriticalSection(LogMsgCriticalSection);
  InitializeCriticalSection(ProcessMsgCriticalSection);
  InitializeCriticalSection(ProcessHumanCriticalSection);
  InitializeCriticalSection(ProcessStorageSection);

  InitializeCriticalSection(ProcessHTimerlistSection);
  InitializeCriticalSection(Config.UserIDSection);
  InitializeCriticalSection(UserDBSection);
  //  CS_6              := TCriticalSection.Create;

  g_DynamicVarList := TList.Create;
  g_UserCMDList := TStringList.Create;
  AddToObjTable(RunSocket, 'RunSocket');
  AddToObjTable(UserEngine, 'UserEngine');

  TimeNow := Now();
  DecodeDate(TimeNow, Year, Month, Day);
  DecodeTime(TimeNow, Hour, Min, Sec, MSec);
  if not DirectoryExists(g_Config.sLogDir) then
  begin
    CreateDir(Config.sLogDir);
  end;

  sLogFileName := g_Config.sLogDir {'.\Log\'} + IntToStr(Year) + '-' + IntToStr2(Month) +
  '-' + IntToStr2(Day) + '.' + IntToStr2(Hour) + '-' + IntToStr2(Min) + '.txt';
  AssignFile(F, sLogFileName);
  Rewrite(F);
  CloseFile(F);

  PlugInEngine.LoadPlugIn();                                //加载插件

  MemoLog.Lines.Add('正在读取配置信息...');

  nShiftUsrDataNameNo := 1;

  DBSocket.Address := g_Config.sDBAddr;
  DBSocket.Port := g_Config.nDBPort;
  //  DBSocket.Active   := True;

  sCaption := g_Config.sServerName; // +' ' + DateToStr(Date)+ ' ' + TimeToStr(Time);
  //  Caption := format('%s - %s', [mydecodestring(g_sTitleName), sCaption]);
  LoadServerTable();

  //LogUDP.RemoteHost := g_Config.sLogServerAddr;
 // LogUDP.RemotePort := IntToStr(g_Config.nLogServerPort);
//  ConnectTimer.Enabled:= True;

//  Application.OnIdle  := AppOnIdle;
  Application.OnException := OnProgramException;
  dwRunDBTimeMax := GetTickCount();
  g_dwStartTick := GetTickCount();
  dwCheckMachIdCount := gettickcount;
  dwCheckMachIdTime := 1000 * 60 * 60 * 24 + 1000 * 60 * 60 * (random(10) + 2);
  Timer1.Enabled := True;
  //  StartTimer.Enabled  := True;

  boServiceStarted := True;
  MENU_CONTROL_STOP.Enabled := True;
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;
end;

procedure TFrmMain.StopService;
var
  I, ii                                                : Integer;
  Config                                               : pTConfig;

begin
  shopfile.free;
  topfile.Free;
  Config := @g_Config;
  MENU_CONTROL_START.Enabled := False;
  MENU_CONTROL_STOP.Enabled := False;
  Timer1.Enabled := False;
  RunTimer.Enabled := False;
  FrmIDSoc.Close;
  GateSocket.Close;
  // Memo := nil;
  SaveItemNumber();
  g_CastleManager.Free;
  g_EventManager.Free; //在地图释放时被释放了激活的。这里释放已经结束的。
  FrmDB.Free;
  //  UserCastle.Save;
  //  UserCastle.Free;

{$IF USERENGINEMODE = THREADENGINE}
  ThreadInfo := @Config.UserEngineThread;
  ThreadInfo.boTerminaled := True;
  if WaitForSingleObject(ThreadInfo.hThreadHandle, 1000) <> 0 then
  begin
    SuspendThread(ThreadInfo.hThreadHandle);
  end;
{$IFEND}
{$IF DBSOCKETMODE = THREADENGINE}
  ThreadInfo := @Config.DBSocketThread;
  ThreadInfo.boTerminaled := True;
  if WaitForSingleObject(ThreadInfo.hThreadHandle, 1000) <> 0 then
  begin
    SuspendThread(ThreadInfo.hThreadHandle);
  end;
{$IFEND}
  FrontEngine.Terminate();
  //  FrontEngine.WaitFor;
  FrontEngine.Free;
  MagicManager.Free;
  UserEngine.Free;
  RobotManage.Free;
  RunSocket.Free;

  ConnectTimer.Enabled := False;
  DBSocket.Close;

  MainLogMsgList.Free;
  LogStringList.Free;
  LogonCostLogList.Free;
  g_MapManager.Free;
  ItemUnit.Free;

  NoticeManager.Free;
  g_GuildManager.Free;

  for I := 0 to g_MakeItemList.Count - 1 do
  begin
    TStringList(g_MakeItemList.Objects[I]).Free;
  end;
  g_MakeItemList.Free;
  for I := 0 to g_PetSellInfo.Count - 1 do
    Dispose(pTPetSellInfo(g_PetSellInfo[i]));

  g_PetSellInfo.Free;
  g_StartPointList.Free;
  ServerTableList.Free;
  g_DenySayMsgList.Free;
  MiniMapList.Free;
  g_UnbindList.Free;
  g_bindList.Free;
  LineNoticeList.Free;
  BannerNotice.Free;                                        //hint
  QuestDiaryList.Free;
  ItemEventList.Free;
  AbuseTextList.Free;
  for i := 0 to g_MonSayMsgList.count - 1 do
  begin                                                     //hint 释放
    for ii := 0 to TList(g_MonSayMsgList.Objects[i]).Count - 1 do
    begin
      dispose(pTMonSayMsg(TList(g_MonSayMsgList.Objects[i]).Items[ii]));
    end;
    TList(g_MonSayMsgList.Objects[i]).free;
  end;
  g_MonSayMsgList.Free;

  g_DisableMoveMapList.Free;
  g_ItemNameList.Free;
  g_DisableSendMsgList.Free;
  g_MonDropLimitLIst.Free;
  g_ItemRuleList.Free;
  g_Item_UnitList.Free;
  g_PlantPointList.Free;
  SavePlayListToFile;
  g_TopPlayList.lock;
  for I := 0 to g_TopPlayList.Count - 1 do
  begin
    dispose(pSavePaiHang(g_TopPlayList.Objects[i]));
  end;
  g_TopPlayList.unlock;
  g_TopPlayList.Free;

  g_UnMasterList.Free;
  g_UnForceMasterList.Free;
  g_GameLogItemNameList.Free;
  g_DenyIPAddrList.Free;
  g_DenyChrNameList.Free;
  g_DenyAccountList.Free;
  g_EvilApprList.Free;
  g_NoClearMonList.Free;
  for I := 0 to g_ItemBindIPaddr.Count - 1 do
  begin
    DisPose(pTItemBind(g_ItemBindIPaddr.Items[I]));
  end;
  for I := 0 to g_ItemBindAccount.Count - 1 do
  begin
    DisPose(pTItemBind(g_ItemBindAccount.Items[I]));
  end;
  for I := 0 to g_ItemBindCharName.Count - 1 do
  begin
    DisPose(pTItemBind(g_ItemBindCharName.Items[I]));
  end;
  g_ItemBindIPaddr.Free;
  g_ItemBindAccount.Free;
  g_ItemBindCharName.Free;
  PlugInEngine.Free;
  DeleteCriticalSection(LogMsgCriticalSection);
  DeleteCriticalSection(ProcessMsgCriticalSection);
  DeleteCriticalSection(ProcessHumanCriticalSection);
  DeleteCriticalSection(ProcessStorageSection);

  DeleteCriticalSection(Config.UserIDSection);
  DeleteCriticalSection(UserDBSection);
  DeleteCriticalSection(ProcessHTimerlistSection);

  // CS_6.Free;
  for I := 0 to g_DynamicVarList.Count - 1 do
  begin
    Dispose(pTDynamicVar(g_DynamicVarList.Items[I]));
  end;
  g_DynamicVarList.Free;

  boServiceStarted := False;
  MENU_CONTROL_START.Enabled := True;
{$IF USECODE = USEREMOTECODE}
  Dispose(g_Config.Encode6BitBuf);
  Dispose(g_Config.Decode6BitBuf);
{$IFEND}
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  //  StopService();
end;

procedure TFrmMain.ShowAbout;
begin
  MainOutMessage('引擎版本：2.0.0.0 Build 1');
  MainOutMessage('更新日期：2012/08/03');
  MainOutMessage('出品组织：淡漠夕阳');
  MainOutMessage('程序网站：http://www.npc8.com');
  MainOutMessage('技术论坛：http://www.npc8.com');
end;

procedure TFrmMain.MENU_HELP_ABOUTClick(Sender: TObject);
begin

  ShowAbout;

end;

procedure TFrmMain.DBSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  MainOutMessage('数据库服务器(' + Socket.RemoteAddress + ':' +
    IntToStr(Socket.RemotePort) + ')连接成功...');
  g_dbConnect := true;

end;

procedure TFrmMain.MENU_OPTION_SERVERCONFIGClick(Sender: TObject);
begin
  FrmServerValue := TFrmServerValue.Create(Owner);
  FrmServerValue.Top := Self.Top + 20;
  FrmServerValue.Left := Self.Left;
  FrmServerValue.AdjuestServerConfig();
  FrmServerValue.Free;
end;

procedure TFrmMain.MENU_OPTION_GENERALClick(Sender: TObject);
begin
  frmGeneralConfig := TfrmGeneralConfig.Create(Owner);
  frmGeneralConfig.Top := Self.Top + 20;
  frmGeneralConfig.Left := Self.Left;
  frmGeneralConfig.Open();
  frmGeneralConfig.Free;
  Caption := g_Config.sServerName;
end;

procedure TFrmMain.MENU_OPTION_GAMEClick(Sender: TObject);
begin
  frmGameConfig := TfrmGameConfig.Create(Owner);
  frmGameConfig.Top := Self.Top + 20;
  frmGameConfig.Left := Self.Left;
  frmGameConfig.Open;
  frmGameConfig.Free;
end;

procedure TFrmMain.MENU_OPTION_FUNCTIONClick(Sender: TObject);
begin
  frmFunctionConfig := TfrmFunctionConfig.Create(Owner);
  frmFunctionConfig.Top := Self.Top + 20;
  frmFunctionConfig.Left := Self.Left;
  frmFunctionConfig.Open;
  frmFunctionConfig.Free;
end;

procedure TFrmMain.G1Click(Sender: TObject);
begin
  frmGameCmd := TfrmGameCmd.Create(Owner);
  frmGameCmd.Top := Self.Top + 20;
  frmGameCmd.Left := Self.Left;
  frmGameCmd.Open;
  frmGameCmd.Free;
end;

procedure TFrmMain.MENU_OPTION_MONSTERClick(Sender: TObject);
begin
  frmMonsterConfig := TfrmMonsterConfig.Create(Owner);
  frmMonsterConfig.Top := Self.Top + 20;
  frmMonsterConfig.Left := Self.Left;
  frmMonsterConfig.Open;
  frmMonsterConfig.Free;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MONSTERSAYClick(Sender: TObject);
begin
  UserEngine.ClearMonSayMsg();
  LoadMonSayMsg();
  MainOutMessage('重新加载怪物说话配置完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_DISABLEMAKEClick(Sender: TObject);
begin

  LoadItem_Unit;
  LoadDisableMoveMap();
  ItemUnit.LoadCustomItemName();
  LoadDisableSendMsgList();
  LoadGameLogItemNameList();
  LoadItemBindIPaddr();
  LoadUserCMd();
  LoadItemBindAccount();
  LoadItemBindCharName();
  LoadUnMasterList();
  LoadUnForceMasterList();
  LoadDenyIPAddrList();
  LoadDenyAccountList();
  LoadDenyChrNameList();
  LoadNoClearMonList();
  FrmDB.LoadAdminList();

  MainOutMessage('重新加载列表配置完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_STARTPOINTClick(Sender: TObject);
begin
  FrmDB.LoadStartPoint();
  MainOutMessage('重新地图安全区列表完成...');
end;

procedure TFrmMain.MENU_CONTROL_GATE_OPENClick(Sender: TObject);
resourcestring
  sGatePortOpen                                        = '游戏网关端口(%s:%d)已打开...';
begin
  if not GateSocket.Active then
  begin
    GateSocket.Active := True;
    MainOutMessage(format(sGatePortOpen, [GateSocket.Address, GateSocket.Port]));
  end;

end;

procedure TFrmMain.MENU_CONTROL_GATE_CLOSEClick(Sender: TObject);
begin
  CloseGateSocket();
end;

procedure TFrmMain.CloseGateSocket;
var
  I                                                    : Integer;
resourcestring
  sGatePortClose                                       = '游戏网关端口(%s:%d)已关闭...';
begin
  if GateSocket.Active then
  begin
    for I := 0 to GateSocket.Socket.ActiveConnections - 1 do
    begin
      GateSocket.Socket.Connections[I].Close;
    end;
    GateSocket.Active := False;
    MainOutMessage(format(sGatePortClose, [GateSocket.Address, GateSocket.Port]));
  end;
end;

procedure TFrmMain.MENU_CONTROLClick(Sender: TObject);
begin
  if GateSocket.Active then
  begin
    MENU_CONTROL_GATE_OPEN.Enabled := False;
    MENU_CONTROL_GATE_CLOSE.Enabled := True;
  end
  else
  begin
    MENU_CONTROL_GATE_OPEN.Enabled := True;
    MENU_CONTROL_GATE_CLOSE.Enabled := False;
  end;

end;

procedure UserEngineProcess(Config: pTConfig; ThreadInfo: pTThreadInfo);
var
  nRunTime                                             : Integer;
  dwRunTick                                            : LongWord;
begin
  l_dwRunTimeTick := 0;
  dwRunTick := GetTickCount();
  ThreadInfo.dwRunTick := dwRunTick;
  while not ThreadInfo.boTerminaled do
  begin
    nRunTime := GetTickCount - ThreadInfo.dwRunTick;
    if ThreadInfo.nRunTime < nRunTime then
      ThreadInfo.nRunTime := nRunTime;
    if ThreadInfo.nMaxRunTime < nRunTime then
      ThreadInfo.nMaxRunTime := nRunTime;
    if GetTickCount - dwRunTick >= 1000 then
    begin
      dwRunTick := GetTickCount();
      if ThreadInfo.nRunTime > 0 then
        Dec(ThreadInfo.nRunTime);
    end;

    ThreadInfo.dwRunTick := GetTickCount();
    ThreadInfo.boActived := True;
    ThreadInfo.nRunFlag := 125;
    if Config.boThreadRun then
      ProcessGameRun();
    Sleep(1);
  end;
end;

procedure UserEngineThread(ThreadInfo: pTThreadInfo); stdcall;
var
  nErrorCount                                          : Integer;
resourcestring
  sExceptionMsg                                        =
    '[Exception] UserEngineThread ErrorCount = %d';
begin
  nErrorCount := 0;
  while True do
  begin
    try
      UserEngineProcess(ThreadInfo.Config, ThreadInfo);
      break;
    except
      Inc(nErrorCount);
      if nErrorCount > 10 then
        break;
      MainOutMessage(format(sExceptionMsg, [nErrorCount]));
    end;
  end;
  ExitThread(0);
end;

procedure ProcessGameRun();
var
  I                                                    : Integer;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    //  if runid >= 0 then  begin
    UserEngine.PrcocessData;
    g_EventManager.Run;
    RobotManage.Run;

    //  end;
    if GetTickCount - l_dwRunTimeTick > 10000 then
    begin
      l_dwRunTimeTick := GetTickCount();
      g_GuildManager.Run;
      //CastleManager.Run;
      //UserCastle.Run;
      g_CastleManager.Run;
      g_DenySayMsgList.Lock;
      try
        for I := g_DenySayMsgList.Count - 1 downto 0 do
        begin
          if GetTickCount > LongWord(g_DenySayMsgList.Objects[I]) then
          begin
            g_DenySayMsgList.Delete(I);
          end;
        end;
      finally
        g_DenySayMsgList.UnLock;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;

end;

procedure TFrmMain.MENU_VIEW_GATEClick(Sender: TObject);
begin
  MENU_VIEW_GATE.Checked := not MENU_VIEW_GATE.Checked;
  GridGate.Visible := MENU_VIEW_GATE.Checked;
end;

procedure TFrmMain.MENU_VIEW_SESSIONClick(Sender: TObject);
begin
  frmViewSession := TfrmViewSession.Create(Owner);
  frmViewSession.Top := Top + 20;
  frmViewSession.Left := Left;
  frmViewSession.Open();
  frmViewSession.Free;
end;

procedure TFrmMain.MENU_VIEW_ONLINEHUMANClick(Sender: TObject);
begin
  frmViewOnlineHuman := TfrmViewOnlineHuman.Create(Owner);
  frmViewOnlineHuman.Top := Top + 20;
  frmViewOnlineHuman.Left := Left;
  frmViewOnlineHuman.Open();
  frmViewOnlineHuman.Free;
end;

procedure TFrmMain.MENU_VIEW_LEVELClick(Sender: TObject);
begin
  frmViewLevel := TfrmViewLevel.Create(Owner);
  frmViewLevel.Top := Top + 20;
  frmViewLevel.Left := Left;
  frmViewLevel.Open();
  frmViewLevel.Free;
end;

procedure TFrmMain.MENU_VIEW_LISTClick(Sender: TObject);
begin
  frmViewList := TfrmViewList.Create(Owner);
  frmViewList.Top := Top + 20;
  frmViewList.Left := Left;
  frmViewList.Open();
  frmViewList.Free;
end;

procedure TFrmMain.MENU_MANAGE_ONLINEMSGClick(Sender: TObject);
begin
  frmOnlineMsg := TfrmOnlineMsg.Create(Owner);
  frmOnlineMsg.Top := Top + 20;
  frmOnlineMsg.Left := Left;
  frmOnlineMsg.Open();
  frmOnlineMsg.Free;
end;

procedure TFrmMain.MENU_MANAGE_PLUGClick(Sender: TObject);
begin
  ftmPlugInManage := TftmPlugInManage.Create(Owner);
  ftmPlugInManage.Top := Top + 20;
  ftmPlugInManage.Left := Left;
  ftmPlugInManage.Open();
  ftmPlugInManage.Free;

end;

procedure TFrmMain.SetMenu;
begin
  FrmMain.Menu := MainMenu;
end;

procedure TFrmMain.MENU_VIEW_KERNELINFOClick(Sender: TObject);
begin
  frmViewKernelInfo := TfrmViewKernelInfo.Create(Owner);
  frmViewKernelInfo.Top := Top + 20;
  frmViewKernelInfo.Left := Left;
  frmViewKernelInfo.Open();
  frmViewKernelInfo.Free;
end;

procedure TFrmMain.MENU_TOOLS_MERCHANTClick(Sender: TObject);
begin
  frmConfigMerchant := TfrmConfigMerchant.Create(Owner);
  frmConfigMerchant.Top := Top + 20;
  frmConfigMerchant.Left := Left;
  frmConfigMerchant.Open();
  frmConfigMerchant.Free;
end;

procedure TFrmMain.MENU_OPTION_ITEMFUNCClick(Sender: TObject);
begin
  frmItemSet := TfrmItemSet.Create(Owner);
  frmItemSet.Top := Top + 20;
  frmItemSet.Left := Left;
  frmItemSet.Open();
  frmItemSet.Free;
end;

procedure TFrmMain.ClearMemoLog;
begin
  if Application.MessageBox('是否确定清除日志信息！！！', '提示信息', MB_YESNO +
    MB_ICONQUESTION) = mrYes then
  begin
    MemoLog.Clear;
  end;
end;

procedure TFrmMain.MENU_TOOLS_MONGENClick(Sender: TObject);
begin
  frmConfigMonGen := TfrmConfigMonGen.Create(Owner);
  frmConfigMonGen.Top := Top + 20;
  frmConfigMonGen.Left := Left;
  frmConfigMonGen.Open();
  frmConfigMonGen.Free;
end;

procedure TFrmMain.MENU_TOOLS_IPSEARCHClick(Sender: TObject);
var
  sIPaddr                                              : string;
begin
  sIPaddr := InputBox('IP所在地区查询', '输入IP地址:', '192.168.0.1');
  if not IsIPaddr(sIPaddr) then
  begin
    Application.MessageBox('输入的IP地址格式不正确！！！', '错误信息', MB_OK +
      MB_ICONERROR);

    //    CopyCodeToFilex(@TRunSocket.Execute) ;
     //      CopyCodeToFile(@TRunSocket.Execute) ;    //281

       //
    exit;
  end;
  if not IsIPaddr(sIPaddr) then
  begin
    Application.MessageBox('输入的IP地址格式不正确！！！', '错误信息', MB_OK +
      MB_ICONERROR);
    exit;
  end;
  MemoLog.Lines.Add(format('%s:%s', [sIPaddr, GetIPLocal(sIPaddr)]));
end;

procedure TFrmMain.MENU_MANAGE_CASTLEClick(Sender: TObject);
begin
  frmCastleManage := TfrmCastleManage.Create(Owner);
  frmCastleManage.Top := Top + 20;
  frmCastleManage.Left := Left;
  frmCastleManage.Open();
  frmCastleManage.Free;
end;

procedure TFrmMain.N10Click(Sender: TObject);
begin

  FrmDB.LoadEvilMonappr;
  MainOutMessage('重新加载心魔外观数据库完成...');

end;

procedure TFrmMain.N11Click(Sender: TObject);
begin
  Form_Unit_Item.Open;
end;

procedure TFrmMain.N1Click(Sender: TObject);
begin
  if FileExists(g_Config.sEnvirDir + 'Wolshop.txt') then
  begin
    shopfile.Free;
    shopfile := nil;
    shopfile := Tinifile.create(g_Config.sEnvirDir + 'Wolshop.txt');
    MainOutMessage('重新加载商城物品数据完成...');
  end;
end;

procedure TFrmMain.N2Click(Sender: TObject);
begin
  if g_ManageNPC <> nil then
  begin
    g_ManageNPC.ClearScript();
    g_ManageNPC.LoadNPCScript();
    MainOutMessage('重新加载登录脚本完成...');
  end
  else
  begin
    MainOutMessage('重新加载登录脚本失败...');
  end;
end;

procedure TFrmMain.N3Click(Sender: TObject);
begin
  RobotManage.ReLoadRobot();
  MainOutMessage('重新加载机器人配置完成...');
end;

procedure TFrmMain.N4Click(Sender: TObject);
var
  i                                                    : Integer;
  Monster                                              : pTMonInfo;
begin
  for I := 0 to UserEngine.MonsterList.Count - 1 do
  begin
    Monster := UserEngine.MonsterList.Items[I];
    FrmDB.LoadMonitems(Monster.sName, Monster.ItemList);
  end;
  MainOutMessage('重新加载怪物暴率完成...');
end;

procedure TFrmMain.N5Click(Sender: TObject);
begin
  FrmRegSoft.Edit_HardId.Text := HardIDStr;
  FrmRegSoft.ShowModal;
end;

procedure TFrmMain.N6Click(Sender: TObject);
begin
  LoadLineNotice(g_Config.sNoticeDir + 'LineNotice.txt');
end;

procedure TFrmMain.N7Click(Sender: TObject);
begin
  GetKey;
end;

procedure TFrmMain.InIform;
var
  nX, nY                                               : Integer;
  MemoryStream                                         : TMemoryStream;
  savelist                                             : TStringList;

resourcestring
  sDemoVersion                                         = '演示版';
  sGateIdx                                             = '网关';
  sGateIPaddr                                          = '网关地址';
  sGateListMsg                                         = '队列数据';
  sGateSendCount                                       = '发送数据';
  sGateMsgCount                                        = '剩余数据';
  sGateSendKB                                          = '平均流量';
  sGateUserCount                                       = '最高人数';
  sStorage                                             = 'Storage';
begin

  SetMenu;
  // exit;
  if not DirectoryExists(g_Config.sEnvirDir) then
  begin
    ShowMessage('核心文件夹' + g_Config.sEnvirDir + '未找到！！！');
    application.Terminate;
    //exit;
  end;
  if not FileExists(g_Config.sEnvirDir + 'top.txt') then
  begin
    SaveList := TStringList.Create;
    SaveList.Add(';此文件保存天下第一人物的数据');
    SaveList.SaveToFile(g_Config.sEnvirDir + 'top.txt');
    SaveList.Free;
  end;
  if not FileExists(g_Config.sEnvirDir + 'WolShop.txt') then
  begin
    SaveList := TStringList.Create;
    SaveList.Add(';此文件保存商城商品的数据');
    SaveList.SaveToFile(g_Config.sEnvirDir + 'Wolshop.txt');
    SaveList.Free;
  end;

  if not DirectoryExists(g_Config.sEnvirDir + sStorage) then
  begin
    CreateDirectory(PChar(g_Config.sEnvirDir + sStorage), nil);
  end;

  if FileExists(g_Config.sEnvirDir + 'top.txt') then
    topfile := Tinifile.create(g_Config.sEnvirDir + 'top.txt');

  if FileExists(g_Config.sEnvirDir + 'Wolshop.txt') then
    shopfile := Tinifile.create(g_Config.sEnvirDir + 'Wolshop.txt');

  Randomize;
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then
  begin
    Left := nX;
    Top := nY;
  end;
  //{$IF (SoftVersion = VERSTD) or (SoftVersion = VERPRO) or (SoftVersion = VERENT)}
    //FrmMain.Menu:=MainMenu;
  //  SetMenu();
  //{$IFEND}
{$IF SoftVersion = VERDEMO}
  sCaptionExtText := sDemoVersion;
{$IFEND}

  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));

  MemoryStream := TMemoryStream.Create;
  Application.Icon.SaveToStream(MemoryStream);

  //MemoLog.Lines.Add(IntToStr(g_Config.nAppIconCrc));
  MemoryStream.Free;
  //HardwareID2:='de'+HardwareID+'23';
  GridGate.RowCount := 21;
  GridGate.Cells[0, 0] := sGateIdx;
  GridGate.Cells[1, 0] := sGateIPaddr;
  GridGate.Cells[2, 0] := sGateListMsg;
  GridGate.Cells[3, 0] := sGateSendCount;
  GridGate.Cells[4, 0] := sGateMsgCount;
  GridGate.Cells[5, 0] := sGateSendKB;
  GridGate.Cells[6, 0] := sGateUserCount;

  GateSocket := TServerSocket.Create(Owner);
  GateSocket.OnClientConnect := GateSocketClientConnect;
  GateSocket.OnClientDisconnect := GateSocketClientDisconnect;
  GateSocket.OnClientError := GateSocketClientError;
  GateSocket.OnClientRead := GateSocketClientRead;

  DBSocket.OnConnect := DBSocketConnect;
  DBSocket.OnError := DBSocketError;
  DBSocket.OnRead := DBSocketRead;
  Timer1.OnTimer := Timer1Timer;
  RunTimer.OnTimer := RunTimerTimer;
  StartTimer.OnTimer := StartTimerTimer;
  SaveVariableTimer.OnTimer := SaveVariableTimerTimer;
  ConnectTimer.OnTimer := ConnectTimerTimer;
  CloseTimer.OnTimer := CloseTimerTimer;
  MemoLog.OnChange := MemoLogChange;
  StartTimer.Enabled := True;

{$IF VerWD=1}
  MemoLog.Color := clWhite;
  MemoLog.Font.Color := clBlack;
  //  sCaptionExtText := sDemoVersion;
{$IFEND}
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;

end;

procedure TFrmMain.Start;
begin

  iniform;

  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;
end;

procedure TFrmMain.SizeTest;
var
  I, J                                                 : Integer;
begin
  I := I + j;
  j := j * 2;
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;
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
    AddToProcTable(@ChangeCaptionText, DecodeStringmir('Lr]]WbYaLrAlYBakWaMaZCL')
      {'ChangeCaptionText'});
{$IF DEBUG = 0}
    asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
    end;
{$IFEND}
    AddToProcTable(@PlugRunOver, DecodeStringmir('PBmqUqEqW`yrUSD'));
  end;
finalization
  begin

  end;
end.

