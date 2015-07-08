unit GateShare;

interface
uses
  SysUtils, Classes, JSocket, SyncObjs,IniFiles,Grobal2;
const
  GATEMAXSESSION      = 1000;
  MSGMAXLENGTH        = 20000;
  SENDCHECKSIZE       = 512;
  SENDCHECKSIZEMAX    = 2048;
type
  TBlockIPMethod = (mDisconnect,mBlock,mBlockList);
  TSessionInfo = record
    Socket           :TCustomWinSocket;//45AA8C
    sSocData         :String;          //45AA90
    sSendData        :String;          //45AA94
    nUserListIndex   :Integer;         //45AA98
    nPacketIdx       :Integer;         //45AA9C
    nPacketErrCount  :Integer;         //45AAA0  //数据包序号重复计数（客户端用封包发送数据检测）
    boStartLogon     :Boolean;         //45AAA4
    boSendLock       :Boolean;         //45AAA5
    boOverNomSize    :Boolean;
    nOverNomSizeCount:ShortInt; 
    dwSendLatestTime :LongWord;        //45AAA8
    nCheckSendLength :Integer;         //45AAAC
    boSendAvailable  :Boolean;         //45AAB0
    boSendCheck      :Boolean;         //45AAB1
    dwTimeOutTime    :LongWord; //0x28
    nReceiveLength   :Integer;         //45AAB8
    dwReceiveTick    :LongWord;        //45AABC Tick
    nSckHandle       :Integer;         //45AAC0
    sRemoteAddr      :String;          //45AAC4
    dwSayMsgTick     :LongWord;        //发言间隔控制
    dwHitTick        :LongWord;        //攻击时间
    nHitErrorCount   :integer;
    dwWalkTick       :LongWord;
    nWalkErrorCount  :integer;         //走加速次数
    dwTurnTick       :LongWord;
    nTurnErrorCount  :integer;
    dwSpellTick      :LongWord;
    nSpellErrorCount :integer;
    nCurrX,nCurrY    :integer;
  end;
  
  pTSessionInfo =^TSessionInfo;

  TSendUserData = record
    nSocketIdx    :Integer;  //0x00
    nSocketHandle :Integer;  //0x04
    sMsg          :String;   //0x08
    loginok:string;
  end;

  Tpos=record
  tx:integer;
  ty:integer;
  mysex:byte;
  end;
 Tposarr=array [0..GATEMAXSESSION -1] of  Tpos;


  pTSendUserData = ^TSendUserData;
  procedure AddMainLogMsg(Msg:String;nLevel:Integer);
  procedure LoadAbuseFile();
  procedure LoadBlockIPFile();
var
  CS_MainLog                  :TCriticalSection;
  CS_FilterMsg                :TCriticalSection;
  MainLogMsgList              :TStringList;
  nShowLogLevel               :Integer = 3;
  GateClass                   :String = 'GameGate';
  GateName                    :String  = '传世游戏网关';//'翎风数据引擎前置服务器';
  TitleName                   :String  = '王者引擎';
  ServerAddr                  :String  = '127.0.0.1';
  ServerPort                  :Integer = 5000;
  GateAddr                    :String  = '0.0.0.0';
  GatePort                    :Integer = 7200;
  boStarted                   :Boolean = False;
  boClose                     :Boolean = False;
  boShowBite                  :Boolean = True;  //显示B 或 KB
  boServiceStart              :Boolean = False;
  boGateReady                 :Boolean = False;  //0045AA74 网关是否就绪
  boCheckServerFail           :Boolean = False;  //网关 <->游戏服务器之间检测是否失败（超时）
//  dwCheckServerTimeOutTime    :LongWord = 60 * 1000 ;//网关 <->游戏服务器之间检测超时时间长度
  dwCheckServerTimeOutTime    :LongWord = 3 * 60 * 1000 ;//网关 <->游戏服务器之间检测超时时间长度
  boCheckProServer            :Boolean = False; //是否为专业版 服务器
  AbuseList                   :TStringList; //004694F4
  SessionArray                :Array [0..GATEMAXSESSION -1] of TSessionInfo;
  SessionCount                :Integer;  //0x32C 连接会话数
  boShowSckData               :Boolean;  //0x324 是否显示SOCKET接收的信息

  sReplaceWord                :String = '*';
  ReviceMsgList               :TList;    //0x45AA64
  SendMsgList                 :TList;    //0x45AA68
  nCurrConnCount              :Integer;
  boSendHoldTimeOut           :Boolean;
  dwSendHoldTick              :LongWord;
  n45AA80                     :Integer;
  n45AA84                     :Integer;
  dwCheckRecviceTick          :LongWord;
  dwCheckRecviceMin           :LongWord;
  dwCheckRecviceMax           :LongWord;

  dwCheckServerTick           :LongWord;
  dwCheckServerTimeMin        :LongWord;  
  dwCheckServerTimeMax        :LongWord;
  SocketBuffer                :PChar;    //45AA5C
  nBuffLen                    :Integer;  //45AA60
  List_45AA58                 :TList;
  boDecodeMsgLock             :Boolean;
  dwProcessReviceMsgTimeLimit :LongWord;
  dwProcessSendMsgTimeLimit   :LongWord;
  BlockIPList                 :TStringList;  //禁止连接IP列表
  TempBlockIPList             :TStringList;  //临时禁止连接IP列表
  nMaxConnOfIPaddr            :Integer = 50;
  nMaxClientPacketSize        :Integer = 7000;
  nNomClientPacketSize        :Integer = 150;
  dwClientCheckTimeOut        :LongWord =50;//50; {3000}
  nMaxOverNomSizeCount        :Integer = 2;
  nMaxClientMsgCount          :Integer = 15;
  BlockMethod                 :TBlockIPMethod = mDisconnect;
  bokickOverPacketSize        :Boolean = True;

//  nClientSendBlockSize        :Integer = 250; //发送给客户端数据包大小限制
  nClientSendBlockSize        :Integer = 1000; //发送给客户端数据包大小限制
  dwClientTimeOutTime         :LongWord = 5000;//客户端连接会话超时(指定时间内未有数据传输)
  Conf                        :TIniFile;
  sConfigFileName             :String = '.\Config.ini';
  nSayMsgMaxLen               :Integer = 70;    //发言字符长度
  dwSayMsgTime                :LongWord = 1000;  //发主间隔时间
  dwHitTime                   :LongWord = 900;  //攻击间隔时间
  nCheckSayCount              :integer = 3;      //发言刷屏次数
  dwSessionTimeOutTime        :LongWord = 60 * 60 * 1000;

  //dwHitTime                   :LongWord = 900;  //攻击间隔时间
  nHitErrorMax                :Integer  = 8;
  dwWalkTime                  :LongWord = 600;  //CM_WALK,CM_RUN消息间隔时间
  nWalkErrorMax               :Integer  = 8;     //CM_WALK,CM_RUN超速次数
  dwTurnTime                  :LongWord = 600;
  nTurnErrorMax               :integer = 8;
  dwSpellTime                 :LongWord = 800;
  nSpellErrorMax              :integer = 8;

  boCtrlWalkSpeed             :Boolean=true;
  boCtrlHitSpeed              :Boolean=true;
  boCtrlTurnSpeed             :Boolean=true;
  boCtrlSpellSpeed            :Boolean=true;
  boSendFailMsg               :boolean=true;
  boSendWarnMsg               :boolean=false;
  boCtrlgameopenwg            :Boolean=false;
  sWarnMsg                    :String='〖田野工作室提示〗请勿使用非法加速程序.爱护游戏...';
implementation

procedure AddMainLogMsg(Msg:String;nLevel:Integer);
var
 tMsg:String;
begin
  try
    CS_MainLog.Enter;
    if nLevel <= nShowLogLevel then begin
      tMsg:='[' + TimeToStr(Now) + '] ' + Msg;
      MainLogMsgList.Add(tMsg);
    end;
  finally
    CS_MainLog.Leave;
  end;
end;
procedure LoadAbuseFile();
var
  sFileName:String;
begin
  AddMainLogMsg('正在加载文字过滤配置信息...',4);
  sFileName:='.\WordFilter.txt';
  if FileExists(sFileName) then begin
    try
      CS_FilterMsg.Enter;
      AbuseList.LoadFromFile(sFileName);
    finally
      CS_FilterMsg.Leave;
    end;
  end;
  AddMainLogMsg('文字过滤信息加载完成...',4);
end;
procedure LoadBlockIPFile();
var
  sFileName:String;
begin
  AddMainLogMsg('正在加载IP过滤配置信息...',4);
  sFileName:='.\BlockIPList.txt';
  if FileExists(sFileName) then begin
    BlockIPList.LoadFromFile(sFileName);
  end;
  AddMainLogMsg('IP过滤配置信息加载完成...',4);
end;
initialization
begin
  Conf:=TIniFile.Create(sConfigFileName);
  nShowLogLevel:=Conf.ReadInteger(GateClass,'ShowLogLevel',nShowLogLevel);
  CS_MainLog:=TCriticalSection.Create;
  CS_FilterMsg:=TCriticalSection.Create;
  MainLogMsgList:=TStringList.Create;
  AbuseList:=TStringList.Create;
  ReviceMsgList:=TList.Create;
  SendMsgList:=TList.Create;
  List_45AA58:=TList.Create;
  boShowSckData:=False;
  BlockIPList:=TStringList.Create;
  TempBlockIPList:=TStringList.Create;
end;
finalization
begin
  List_45AA58.Free;
  ReviceMsgList.Free;
  SendMsgList.Free;
  AbuseList.Free;
  MainLogMsgList.Free;
  CS_MainLog.Free;
  CS_FilterMsg.Free;
  BlockIPList.Free;
  TempBlockIPList.Free;
  Conf.Free;
end; 
end.
