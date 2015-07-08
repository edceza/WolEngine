unit Share;

interface
uses
  Windows,Classes,SysUtils,JSocket,RSA;
const
  MAXSESSION = 2000;

const
  VERDEMO      = 0;
  VERFREE      = 1;
  VERSTD       = 2;
  VEROEM       = 3;
  VERPRO       = 4;
  VERENT       = 5;
  SoftVersion  = VERSTD; //程序版本类型
{$IF SoftVersion = VERENT}
  DLLVersion = 98;
{$ELSE}
  DLLVersion = 15;
{$IFEND}
  DEBUG      = 0;
  SELFCRC   :LongWord = 2190575127;//3937893187
type
  TCheckStatus = (c_Idle,c_Connect,c_Checking,c_CheckError,c_CheckFail,c_CheckOK);
  TCheckStep = (c_None,c_SendClinetKey,c_SendLicense,c_SendLicense2,c_CheckOver);
  TSessionStatus = (s_NoUse,s_Used,s_GetLic,s_SendLic,s_Finished);
  TUserLicense = record
    Userkey   :String[12];
    UserIP    :String[15];
    ServerIP  :String[15];
    ServerPort:Integer;
  end;
  TXORItem   = packed  record
    SoftType    : ShortInt;//1    1=M2Server 2=RunGate 3=DBServer
    MainVersion : Single;  //4    主程序版本号
    DLLVersion  : Single;  //4    DLL版本号
    IniRegIP    : Integer; //4    在INI中填写的Reg IP
    Param1      : Integer; //4    保留以后用
    Param2      : String[15];     //保留以后用
  end;
  TXORRecord = packed record
    XORKey      : Integer;       //重要字段，用来判断是否是我们的验证服务器
    XORItemLen  : Integer;
    XORItem     : String[33];    //长度和 TXORItem一样长
  end;
  TRSARecord = packed record
    RSAKey      : Int64;
    RSAItemLen  : Integer;
    RSAItem     : TInt64Item;   //保存TXORRecord RSA加密后的结果
  end;
  pRSARecord = ^TRSARecord;

  TUserLicenseEx = packed record
    UserLicese  : TUserLicense; //兼容RSA加密前的版本
    RSARecord   : TRSARecord;   //RSA加密
  end;

  TIPAddr = record
    A:Byte;
    B:Byte;
    C:Byte;
    D:Byte;
    Port:Integer;
  end;
  TSession = record
    Socket      :TCustomWinSocket;
    sReviceMsg  :String;
    nRemoteAddr :Integer;
    dwStartTick :LongWord;
    CheckStep   :TCheckStep;
    UserLicense :TUserLicense;
    CodeBuff    :PChar;
    nCodeLen    :Integer;
    nLicDays    :Integer; //授权剩余天数
    nUserCount  :Integer; //用户数
    Status      :TSessionStatus;//检查授权
    dwSendLicTick:LongWord;
    dwClientTick:LongWord;
    dwServerTick:LongWord;
  end;
  pTSession = ^TSession;

  function MakeIPToStr(IPAddr:TIPAddr):String;
  function MakeIPToInt(sIPaddr:String):Integer;
var
  nLocalXORKey:Integer;   //本地XOR Key
  nRemoteXORKey:Integer;
implementation

uses HUtil32;
function MakeIPToStr(IPAddr:TIPAddr):String;
begin
  Result:=IntToStr(IPAddr.A) + '.' + IntToStr(IPAddr.B) + '.' + IntToStr(IPAddr.C) + '.' + IntToStr(IPAddr.D);
end;
function MakeIPToInt(sIPaddr:String):Integer;
var
  sA,sB,sC,sD:String;
  A,B,C,D:Byte;
begin
  Result:= -1;
  sIPaddr:=Trim(GetValidStr3(sIPaddr, sA, ['.']));
  sIPaddr:=Trim(GetValidStr3(sIPaddr, sB, ['.']));
  sD:=Trim(GetValidStr3(sIPaddr, sC, ['.']));
  if (sA <> '') and (sB <> '') and (sC <> '') and (sD <> '') then begin
    A:=Str_ToInt(sA,0);
    B:=Str_ToInt(sB,0);
    C:=Str_ToInt(sC,0);
    D:=Str_ToInt(sD,0);
    Result:=MakeLong(MakeWord(A,B),MakeWord(C,D));
  end;
end;

end.
