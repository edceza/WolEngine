unit RunDB;

interface
uses
  Windows, SysUtils, Grobal2, M2Share, WinSock;
procedure DBSocketThread(ThreadInfo: pTThreadInfo); stdcall;
function DBSocketConnected(): Boolean;
function GetDBSockMsg(nQueryID: Integer; var nIdent: integer; var nRecog: integer; var sStr: string; dwTimeOut: LongWord; boLoadRcd: Boolean): Boolean;
function MakeHumRcdFromLocal(var HumanRcd: THumDataInfo): Boolean;
function LoadHumRcdFromDB(sAccount, sCharName, sStr: string; boys:Boolean;var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean;
function SaveHumRcdToDB(sAccount, sCharName: string; nSessionID: Integer;sType:String; var HumanRcd: THumDataInfo): Boolean;
function SaveRcd(sAccount, sCharName: string; nSessionID: Integer; sType:String;var HumanRcd: THumDataInfo): Boolean; //004B42C8
function NewYsRcd(sAccount, sChrName: string; bHair, bJob, bSex: byte; sYsnameMaster: string; nSessionID: Integer): Boolean;

function DBLocalIp(): Boolean;
function LoadRcd(sAccount, sCharName, sStr: string; nCertCode: Integer;boys:Boolean ; var HumanRcd: THumDataInfo): Boolean;
procedure SendDBSockMsg(nQueryID: Integer; sMsg: string);
function GetQueryID(Config: pTConfig): Integer;
implementation

uses svMain, HUtil32, EDcode;

function GetCodeMsgSize(X: Double): Integer;
begin
  if INT(X) < X then
    Result := TRUNC(X) + 1
  else
    Result := TRUNC(X)
end;

procedure DBSocketRead(Config: pTConfig);
var
  dwReceiveTimeTick: LongWord;
  nReceiveTime: Integer;
  sRecvText: string;
  nRecvLen: Integer;
  nRet: Integer;
begin
  if Config.DBSocket = INVALID_SOCKET then
    exit;

  dwReceiveTimeTick := GetTickCount();
  nRet := ioctlsocket(Config.DBSocket, FIONREAD, nRecvLen);
  if (nRet = SOCKET_ERROR) or (nRecvLen = 0) then
  begin
    nRet := WSAGetLastError;
    Config.DBSocket := INVALID_SOCKET;
    Sleep(100);
    Config.boDBSocketConnected := False;
    exit;
  end;
  SetLength(sRecvText, nRecvLen);
  nRecvLen := recv(Config.DBSocket, Pointer(sRecvText)^, nRecvLen, 0);
  SetLength(sRecvText, nRecvLen);

  Inc(Config.nDBSocketRecvIncLen, nRecvLen);
  if (nRecvLen <> SOCKET_ERROR) and (nRecvLen > 0) then
  begin
    if nRecvLen > Config.nDBSocketRecvMaxLen then
      Config.nDBSocketRecvMaxLen := nRecvLen;
    EnterCriticalSection(UserDBSection);
    try
      Config.sDBSocketRecvText := Config.sDBSocketRecvText + sRecvText;
      if not Config.boDBSocketWorking then
      begin
        Config.sDBSocketRecvText := '';
      end;
    finally
      LeaveCriticalSection(UserDBSection);
    end;
  end;

  Inc(Config.nDBSocketRecvCount);
  nReceiveTime := GetTickCount - dwReceiveTimeTick;
  if Config.nDBReceiveMaxTime < nReceiveTime then
    Config.nDBReceiveMaxTime := nReceiveTime;
end;

procedure DBSocketProcess(Config: pTConfig; ThreadInfo: pTThreadInfo);
var
  s: TSocket;
  name: sockaddr_in;
  HostEnt: PHostEnt;
  argp: LongInt;
  readfds: TFDSet;
  timeout: TTimeVal;
  nRet: Integer;
  boRecvData: BOOL;
  nRunTime: Integer;
  dwRunTick: LongWord;
begin
  s := INVALID_SOCKET;
  if Config.DBSocket <> INVALID_SOCKET then
    s := Config.DBSocket;
  dwRunTick := GetTickCount();
  ThreadInfo.dwRunTick := dwRunTick;
  boRecvData := False;
  while True do
  begin
    if ThreadInfo.boTerminaled then
      break;
    if not boRecvData then
      Sleep(1)
    else
      Sleep(0);
    boRecvData := False;
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
    if (Config.DBSocket = INVALID_SOCKET) or (s = INVALID_SOCKET) then
    begin
      if Config.DBSocket <> INVALID_SOCKET then
      begin
        Config.DBSocket := INVALID_SOCKET;
        Sleep(100);
        ThreadInfo.nRunFlag := 126;
        Config.boDBSocketConnected := False;
      end;
      if s <> INVALID_SOCKET then
      begin
        closesocket(s);
        s := INVALID_SOCKET;
      end;
      if Config.sDBAddr = '' then
        Continue;

      s := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
      if s = INVALID_SOCKET then
        Continue;

      ThreadInfo.nRunFlag := 127;

      HostEnt := gethostbyname(PChar(@Config.sDBAddr[1]));
      if HostEnt = nil then
        Continue;

      PInteger(@name.sin_addr.S_addr)^ := PInteger(HostEnt.h_addr^)^;
      name.sin_family := HostEnt.h_addrtype;
      name.sin_port := htons(Config.nDBPort);
      name.sin_family := PF_INET;

      ThreadInfo.nRunFlag := 128;
      if connect(s, name, SizeOf(name)) = SOCKET_ERROR then
      begin
        nRet := WSAGetLastError;

        closesocket(s);
        s := INVALID_SOCKET;
        Continue;
      end;

      argp := 1;
      if ioctlsocket(s, FIONBIO, argp) = SOCKET_ERROR then
      begin
        closesocket(s);
        s := INVALID_SOCKET;
        Continue;
      end;
      ThreadInfo.nRunFlag := 129;
      Config.DBSocket := s;
      Config.boDBSocketConnected := True;
    end;
    readfds.fd_count := 1;
    readfds.fd_array[0] := s;
    timeout.tv_sec := 0;
    timeout.tv_usec := 20;
    ThreadInfo.nRunFlag := 130;
    nRet := select(0, @readfds, nil, nil, @timeout);
    if nRet = SOCKET_ERROR then
    begin
      ThreadInfo.nRunFlag := 131;
      nRet := WSAGetLastError;
      if nRet = WSAEWOULDBLOCK then
      begin
        Sleep(10);
        Continue;
      end;
      ThreadInfo.nRunFlag := 132;
      nRet := WSAGetLastError;
      Config.nDBSocketWSAErrCode := nRet - WSABASEERR;
      Inc(Config.nDBSocketErrorCount);
      Config.DBSocket := INVALID_SOCKET;
      Sleep(100);
      Config.boDBSocketConnected := False;
      closesocket(s);
      s := INVALID_SOCKET;
      Continue;
    end;
    boRecvData := True;
    ThreadInfo.nRunFlag := 133;
    while True do
    begin
      if nRet <= 0 then
        break;
      DBSocketRead(Config);
      Dec(nRet);
    end;
  end;
  if Config.DBSocket <> INVALID_SOCKET then
  begin
    Config.DBSocket := INVALID_SOCKET;
    Config.boDBSocketConnected := False;
  end;
  if s <> INVALID_SOCKET then
  begin
    closesocket(s);
  end;
end;

procedure DBSocketThread(ThreadInfo: pTThreadInfo); stdcall;
var
  nErrorCount: Integer;
resourcestring
  sExceptionMsg = '[Exception] DBSocketThread ErrorCount = %d';
begin
  nErrorCount := 0;
  while True do
  begin
    try
      DBSocketProcess(ThreadInfo.Config, ThreadInfo);
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

function DBSocketConnected(): Boolean;
begin
{$IF DBSOCKETMODE = TIMERENGINE}
  Result := FrmMain.DBSocket.Socket.Connected;
{$ELSE}
  Result := g_Config.boDBSocketConnected;
{$IFEND}
end;

function GetDBSockMsg(nQueryID: Integer; var nIdent: integer; var nRecog: integer; var sStr: string; dwTimeOut: LongWord; boLoadRcd: Boolean): Boolean;
var
  boLoadDBOK: Boolean;
  dwTimeOutTick: LongWord;
  s24, s28, s2C, sCheckFlag, sDefMsg, s38: string;
  nLen: Integer;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
resourcestring
  sLoadDBTimeOut = '[RunDB] 读取人物数据超时...';
  sSaveDBTimeOut = '[RunDB] 保存人物数据超时...';
begin
  boLoadDBOK := False;
  Result := False;
  dwTimeOutTick := GetTickCount();
  while (True) do
  begin
    if (GetTickCount - dwTimeOutTick) > dwTimeOut then
    begin
      n4EBB6C := n4EBB68;
      break;
    end;
    s24 := '';
    EnterCriticalSection(UserDBSection);
    try
      if Pos('!', g_Config.sDBSocketRecvText) > 0 then
      begin
        s24 := g_Config.sDBSocketRecvText;
        g_Config.sDBSocketRecvText := '';
      end;
    finally
      LeaveCriticalSection(UserDBSection);
    end;
    if s24 <> '' then
    begin
      s28 := '';
      s24 := ArrestStringEx(s24, '#', '!', s28);
      if s28 <> '' then
      begin
        s28 := GetValidStr3(s28, s2C, ['/']);
        nLen := Length(s28);
        if (nLen >= SizeOf(TDefaultMessage)) and (Str_ToInt(s2C, 0) = nQueryID) then
        begin
          nCheckCode := MakeLong(Str_ToInt(s2C, 0) xor 170, nLen);
          sCheckFlag := EncodeBuffer(@nCheckCode, SizeOf(Integer));
          if CompareBackLStr(s28, sCheckFlag, Length(sCheckFlag)) then
          begin
            if nLen = DEFBLOCKSIZE then
            begin
              sDefMsg := s28;
              s38 := ''; // -> 004B3F56
            end
            else
            begin //004B3F1F
              sDefMsg := Copy(s28, 1, DEFBLOCKSIZE);
              s38 := Copy(s28, DEFBLOCKSIZE + 1, Length(s28) - DEFBLOCKSIZE - 6);
            end; //004B3F56
            DefMsg := DecodeMessage(sDefMsg);
            nIdent := DefMsg.Ident;
            nRecog := DefMsg.Recog;

            if (nIdent = DBR_LOADHUMANRCD) and (nRecog = 2) then
            begin
              dwTimeOut := dwTimeOut * 2;
            end;
            sStr := s38;
            boLoadDBOK := True;
            Result := True;
            break;
          end
          else
          begin //004B3F87
            Inc(g_Config.nLoadDBErrorCount); // -> 004B3FA5
            break;
          end;
        end
        else
        begin //004B3F90
          Inc(g_Config.nLoadDBErrorCount); // -> 004B3FA5
          break;
        end;
      end; //004B3FA5
    end
    else
    begin //004B3F99
      Sleep(1);
     // Application.ProcessMessages;
    end;
  end;
  //end;//004B3FA5
  if not boLoadDBOK then
  begin
    if boLoadRcd then
    begin
      MainOutMessage(sLoadDBTimeOut);
    end
    else
    begin
      MainOutMessage(sSaveDBTimeOut);
    end;
  end; //004B3FD7
  if (GetTickCount - dwTimeOutTick) > dwRunDBTimeMax then
  begin
    dwRunDBTimeMax := GetTickCount - dwTimeOutTick;
  end;
  g_Config.boDBSocketWorking := False;
end;

function MakeHumRcdFromLocal(var HumanRcd: THumDataInfo): Boolean;
begin
  FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
  HumanRcd.Data.Abil.Level := 30;
  Result := True;
end;



function LoadHumRcdFromDB(sAccount, sCharName, sStr: string;boys:Boolean; var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean; //004B3A68
begin
  Result := False;
  FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
  if LoadRcd(sAccount, sCharName, sStr, nCertCode,boys, HumanRcd) then
  begin
    if (HumanRcd.Data.sChrName = sCharName) and ((HumanRcd.Data.sAccount = '') or (HumanRcd.Data.sAccount = sAccount)) then
      Result := True;
  end;
  Inc(g_Config.nLoadDBCount);
end;

function SaveHumRcdToDB(sAccount, sCharName: string; nSessionID: Integer; sType:String;var HumanRcd: THumDataInfo): Boolean; //004B3B5C
begin
  Result := SaveRcd(sAccount, sCharName, nSessionID,sType, HumanRcd);
  Inc(g_Config.nSaveDBCount);
end;


function NewYsRcd(sAccount, sChrName: string; bHair, bJob, bSex: byte; sYsnameMaster: string; nSessionID: Integer): Boolean;
var
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
begin
  nQueryID := GetQueryID(@g_Config);
  Result := False;
  n4EBB68 := 101;
  SendDBSockMsg(nQueryID, EncodeMessage(MakeDefaultMsg(DB_SAVEHUMANRCD, nSessionID, 0, 0, 0)) + EncodeString(sAccount + '/' + sChrName + '/' + inttostr(bHair) + '/' + inttostr(bJob) + '/' + inttostr(bSex) + '/' + sYsnameMaster));
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sStr, 6000, False) then
  begin
    if (nIdent = DBR_NEWYSRCD) and (nRecog = 1) then
      Result := True;
  end;
end;




function SaveRcd(sAccount, sCharName: string; nSessionID: Integer;sType:String; var HumanRcd: THumDataInfo): Boolean; //004B42C8
var
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
begin
  nQueryID := GetQueryID(@g_Config);
  Result := False;
  n4EBB68 := 101;

  SendDBSockMsg(nQueryID, EncodeMessage(MakeDefaultMsg(DB_SAVEHUMANRCD, nSessionID, 0, 0, 0)) + EncodeString(sAccount) + '/' + EncodeString(sCharName) + '/' +sType+'/'+ EncodeBuffer(@HumanRcd, SizeOf(THumDataInfo)));
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sStr, 6000, False) then
  begin
    if (nIdent = DBR_SAVEHUMANRCD) and (nRecog = 1) then
      Result := True;
  end;
end;

function DBLocalIp(): Boolean;
var
  Defmsg: TDefaultMessage;

  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sStr, sDBMsg: string;
  sLocalip: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_M2ASKFORLOCALIP, 0, 0, 0, 0);
  sDBMsg := EncodeMessage(DefMsg);

  SendDBSockMsg(nQueryID, sDBMsg + mdbyzstring);
  sStr := '';
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sStr, 10000, True) then
  begin
    Result := False;
    if nIdent = DBR_LOCALIP then
    begin

      sStr := GetValidStr3(sStr, sLocalip, ['/']);

      g_sLocalip := myDecodeString(sLocalip); //
     //   MainOutMessage('g_sLocalip:'+g_sLocalip);
      Result := true;

    end
    else
      Result := False; //004B4273
  end
  else
    Result := False; //004B4279
end;

//004B4080

function LoadRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; boys:Boolean ; var HumanRcd: THumDataInfo): Boolean;
var
  Defmsg: TDefaultMessage;
  LoadHuman: TLoadHuman;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sHumanRcdStr: string;
  sDBMsg, sDBCharName: string;
  nSize:array[0..1] of Integer;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_LOADHUMANRCD, 0, 0, 0, 0);
  LoadHuman.sAccount := sAccount;
  LoadHuman.sChrName := sCharName;
  LoadHuman.sUserAddr := sStr;
  LoadHuman.nSessionID := nCertCode;
  LoadHuman.boYS:=boys;
  sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@LoadHuman, SizeOf(TLoadHuman));
  n4EBB68 := 100;
  SendDBSockMsg(nQueryID, sDBMsg);
  sHumanRcdStr := '';
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sHumanRcdStr, 6000, True) then
  begin
    Result := False;
    if nIdent = DBR_LOADHUMANRCD then
    begin
      if nRecog = 2 then
      begin //HACK 攻击  代码已删。作调试使用...
        MainOutMessage('提示:请把该信息发送到:QQ14375762，该处存在后门攻击...(漏洞已封)');
      end;
      if nRecog = 1 then
      begin
        sHumanRcdStr := GetValidStr3(sHumanRcdStr, sDBMsg, ['/']);
//        MainOutMessage(s24);
        sDBCharName := DecodeString(sDBMsg);
        if sDBCharName = sCharName then
        begin
          nSize[0]:=GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3);
          nsize[1]:=length(sHumanRcdStr);
          if GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) = length(sHumanRcdStr) then
          begin
            DecodeBuffer(sHumanRcdStr, @HumanRcd, SizeOf(THumDataInfo));
            Result := True;
          end;
        end
        else
          Result := False; //004B4267
      end
      else
        Result := False; //004B426D
    end
    else
      Result := False; //004B4273
  end
  else
    Result := False; //004B4279
end;
//004B3BEC

procedure SendDBSockMsg(nQueryID: Integer; sMsg: string);
var
  sSendMsg: string;
  nCheckCode: Integer;
  sCheckStr: string;
  Config: pTConfig;
  ThreadInfo: pTThreadInfo;



begin
  Config := @g_Config;
  ThreadInfo := @g_Config.DBSocketThread;
  if not DBSocketConnected then
    exit;
  EnterCriticalSection(UserDBSection);
  try
    Config.sDBSocketRecvText := '';
  finally
    LeaveCriticalSection(UserDBSection);
  end;
  nCheckCode := MakeLong(nQueryID xor 170, length(sMsg) + 6);
  sCheckStr := EncodeBuffer(@nCheckCode, SizeOf(Integer));
  sSendMsg := '#' + IntToStr(nQueryID) + '/' + sMsg + sCheckStr + '!';
  Config.boDBSocketWorking := True;
{$IF DBSOCKETMODE = TIMERENGINE}
  FrmMain.DBSocket.Socket.SendText(sSendMsg);
{$ELSE}

  s := Config.DBSocket;
  boSendData := False;
  while True do
  begin
    if not boSendData then
      Sleep(1)
    else
      Sleep(0);
    boSendData := False;
    ThreadInfo.dwRunTick := GetTickCount();
    ThreadInfo.boActived := True;
    ThreadInfo.nRunFlag := 128;

    ThreadInfo.nRunFlag := 129;
    timeout.tv_sec := 0;
    timeout.tv_usec := 20;

    writefds.fd_count := 1;
    writefds.fd_array[0] := s;

    nRet := select(0, nil, @writefds, nil, @timeout);
    if nRet = SOCKET_ERROR then
    begin
      nRet := WSAGetLastError();
      Config.nDBSocketWSAErrCode := nRet - WSABASEERR;
      Inc(Config.nDBSocketErrorCount);
      if nRet = WSAEWOULDBLOCK then
      begin
        Continue;
      end;
      if Config.DBSocket = INVALID_SOCKET then
        break;
      Config.DBSocket := INVALID_SOCKET;
      Sleep(100);
      Config.boDBSocketConnected := False;
      break;
    end;
    if nRet <= 0 then
    begin
      Continue;
    end;
    boSendData := True;
    nRet := send(s, sSendMsg[1], length(sSendMsg), 0);
    if nRet = SOCKET_ERROR then
    begin
      Inc(Config.nDBSocketErrorCount);
      Config.nDBSocketWSAErrCode := WSAGetLastError - WSABASEERR;
      Continue;
    end;
    Inc(Config.nDBSocketSendLen, nRet);
    break;
  end;
{$IFEND}


end;

//004E3E04

function GetQueryID(Config: pTConfig): Integer;
begin
  Inc(Config.nDBQueryID);
  if Config.nDBQueryID > high(SmallInt) - 1 then
    Config.nDBQueryID := 1;
  Result := Config.nDBQueryID;
end;
end.
