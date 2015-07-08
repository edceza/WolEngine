{*******************************************************}
{                                                       }
{       服务端与客户端公用变量                          }
{                                                       }
{       版权所有 (C) 2006 JDboy                         }
{                                                       }
{*******************************************************}


unit _Const;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, JSocket;

const
  BUFFERSIZE = 1024;
  DEFBLOCKSIZE = 6;

  DefKey = 'A4Soft';

  Client_Login = 11000;
  Client_Reg = 12000;
  Client_ChangePass = 13000;
  Client_FindPass = 14000;
  Client_GetKey = 15000;
  Client_Search = 16000;
  Client_ChongZ = 17000;
  Send_SysMsg = 18000;
  Client_BindGameID = 19000;
  Client_ChangeBind = 20000;
  Client_GetViewInfo = 21000;
  Client_SearchCard = 22000;
  Client_CheckLogin = 23000;

  Client_Login_Success = 11001;
  Client_Login_Fail = 11002;
  Client_Reg_Success = 12001;
  Client_Reg_Fail = 12002;
  Client_ChangePass_Success = 13001;
  Client_ChangePass_Fail = 13002;
  Client_FindPass_Success = 14001;
  Client_FindPass_Fail = 14002;
  Client_GetKey_Sucess = 15001;
  Client_GetKey_Fail = 15002;
  Client_Search_Sucess = 16001;
  Client_Search_Fail = 16002;
  Client_ChongZ_Sucess = 17001;
  Client_ChongZ_Fail = 17002;
  Client_BindGameID_Sucess = 19001;
  Client_BindGameID_Fail = 19002;
  Client_ChangeBind_Sucess = 20001;
  Client_ChangeBind_Fail = 20002;
  Client_GetViewInfo_Sucess = 21001;
  Client_GetViewInfo_Fail = 21002;
  Client_SearchCard_Sucess = 22001;
  Client_SearchCard_Fail = 22002;
  Client_CheckLogin_Sucess = 23001;
  Client_CheckLogin_Fail = 23002;

type
  PLvLogColor = ^TLvLogColor;
  TLvLogColor = packed record
    Color: TColor;
  end;

  PTMsg = ^TMsg;
  TMsg = record
    Socket: TCustomWinSocket;
    Str: string;
  end;

  P_message = ^TDefaultMessage;
  TDefaultMessage = packed record
    Comm: Word;
    Param: word;
  end;

  TLogin = packed record
    UserName: string[15];
    UserPass: string[15];
    GameID: string[20];
    UserLoginType: Integer;
  end;

  TSendLoginInfo = packed record
    UserName: string[15];
    UserType: Integer;
    UserPoint: integer;
    UserEndDate: string[10];
    AutoJianQuing_CALL1: DWORD;
    FBCallAddr1: DWORD;
    FBCallAddr2: DWORD;
    GameSocketSendCall: DWORD;
  end;

  TReg = packed record
    UserName: string[15];
    UserPassWord: string[15];
    UserQUIZ1: string[25];
    UserANSWER1: string[25];
    UserQUIZ2: string[25];
    UserANSWER2: string[25];
    Name: string[10];
    Email: string[25];
    Tel: string[15];
  end;

  PSendKey = ^TSendKey;
  TSendKey = packed record
    Tag: Integer;
    Key: string[10];
  end;

  TChangePass = packed record
    UserName: string[15];
    UserOldPass: string[15];
    UserNewPass: string[15];
  end;

  TFindPass = packed record
    UserName: string[15];
    UserNewPass: string[15];
    UserQUIZ1: string[25];
    UserANSWER1: string[25];
    UserQUIZ2: string[25];
    UserANSWER2: string[25];
  end;

  TSendPass = packed record
    UserName: string[15];
    UserPass: string[15];
  end;

  TUserSearch = packed record
    UserName: string[15];
    UserPass: string[15];
    UserType: Integer;
  end;

  TSendSearch = packed record
    UserName: string[15];
    UserType: Integer;
    UserInfo: string[10];
  end;

  TUserChongZ = packed record
    UserName: string[15];
    UserType: Integer;
    CardNumber: string[32];
    CardPass: string[32];
  end;

  TSendSysMsg = packed record
    SysMessage: string[100];
  end;

  TBindGameID = packed record
    UserName: string[15];
    UserPass: string[15];
    GameID: string[20]
  end;

  TChangeBind = packed record
    UserName: string[15];
    UserPass: string[15];
    GameID: string[20];
  end;

  TClientGetViewInfo = packed record
    ConnCount: Integer;
    DLCount: Integer;
    OnLineCount: Integer;
    RegCount: Integer;
    LogCount: Integer;
    BuyCount: Integer;
    CardCount: Integer;
    ThisDayCardCount: Integer;
  end;

  TClientSearchCardInfo = packed record
    DateOld: TDateTime;
    DateNew: TDateTime;
  end;

  TServerSearchCardInfo = packed record
    CardInfo: string[255];
  end;

implementation

end.
