unit Unit_Reg;

interface
uses
  SysUtils,
  windows,
  Messages,
  IniFiles,
  Classes,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdDayTime,
  IdHTTP,
 uCompress ,
  function8 ,
  Function1,
  Function2 ,
  function3 ,
  function4 ,
  function5 ,
  Function6 ,
  Function7 ,
  MyUnits ,
  VersionId ,
  GetDSN  ,
  Base64  ,
  MD5,
  BiosHelp;

type

  THttpDown = class(TThread)
  private
    IdHTTP   : TIdHTTP;
    IdDayTime: TIdDayTime;
    Furl     : String;
  protected
    procedure Execute; override;
  public
    constructor Create(Url:String);
    destructor Destroy; override;
  end;

Const
  WM_OK=WM_USER+1;
var
   MainHandle:Integer;
   RegCode,MainFIleName:string;
   HttpDOwn:THttpDown;
   MainKey: string;
   BeijingTime:TDateTime;
   function FUNCTION3:String;
   Function FUNCTION1(sour,Key:String;Count:Integer;boUseMainKey:Boolean):Pchar;
   Function FUNCTION2(sour,Key:String;Count:Integer;boUseMainKey:Boolean):Pchar;
   function GetTime:TDateTime;
   function GetNetTime:Boolean;
   function CompareHard(oldStr,NewStr:String):Pchar;
   Procedure initHandle(H:Integer;MFileName,FileName:pchar);
implementation
function GetModuleFileSizeStr: string;
var
  Buffer    : array[0..261] of Char;
  Size      : Integer;
  FileName  : String;
  F         : TFileStream;
begin

  SetString(FileName, Buffer, Windows.GetModuleFileName(HInstance, Buffer, SizeOf(Buffer)));
  F:=TFileStream.Create(FileName,fmOpenRead or fmShareDenyNone);
  Size:=F.Size;
  F.Free;
  Result:=IntToStr(Size);

end;

//加密
Function FUNCTION1(sour,Key:String;Count:Integer;boUseMainKey:Boolean):Pchar;
var
  Outstr:String;

Begin
   if boUseMainKey then
     Key:=MainKey+Key;
   OutStr:=MyEncodeString(sour,Key,count);
   GetMem(Result,Length(OutStr)+1);
   Move(OutStr[1],Result[0],Length(OutStr));
   Result[Length(OutStr)]:=#0;
End;
//解密
Function FUNCTION2(sour,Key:String;Count:Integer;boUseMainKey:Boolean):Pchar;
var
  Outstr:String;
Begin
   if boUseMainKey then
     Key:=MainKey+Key;
   OutStr:=MyDecodeString(sour,key,count);
   GetMem(Result,Length(OutStr)+1);
   Move(OutStr[1],Result[0],Length(OutStr));
   Result[Length(OutStr)]:=#0;
End;
function CompareHard(oldStr,NewStr:String):Pchar;
var
  Outstr    : String;
  HDSerial  : String;
  Mac       : String;
  TopDelphi : TTopdelphi1;
  Key       : String;
  str1,str2 : string;
  i         : Integer;
begin
   oldStr:=Base64DecodeStr(oldStr);
   NewStr:=Base64DecodeStr(NewStr);
   Key:='GetModuleFileSizeStr';
   try
   TopDelphi:=TTopdelphi1.Create(nil);
   TopDelphi.InitStr(Key);
   TopDelphi.Reset;
   oldstr:=TopDelphi.DecryptString(oldstr);
   TopDelphi.Reset;
   newstr:=TopDelphi.DecryptString(newstr);
   finally
     TopDelphi.Free;
   ENd;
   i:=Pos('$%$',oldStr);
   if i>=1 then
   begin
     Str1:=Copy(oldStr,1,i-1);
     Delete(oldStr,1,i-1);
   End;
   i:=Pos('$%$',newStr);
   if i>=1 then
   begin
     Str2:=Copy(newStr,1,i-1);
     Delete(newStr,1,i-1);
   End;
   if str1<>str2 then
   begin
     Outstr:='主板发生变化';
   End;
   if oldStr<>NewStr then
   begin
      i:=Length(oldStr);
      str1:=Copy(oldStr,1,i-6);
      i:=Length(NewStr);
      str2:=Copy(NewStr,1,i-6);
      if str1<>str2 then
         Outstr:=Outstr+ '  CPU发生变化';
      if oldStr<>NewStr then
         Outstr:=Outstr+ '  网卡发生变化';
   End;
   GetMem(Result,Length(OutStr)+1);
   Move(OutStr[1],Result[0],Length(OutStr));
   Result[Length(OutStr)]:=#0;
End;
//获得硬件序列号
function FUNCTION3:String;
var
  Outstr    : String;
  HDSerial  : String;
  Mac       : String;
  TopDelphi : TTopdelphi1;
  Key       : String;
  nlen      : Integer;

Begin

  //Outstr:= (GetHardId);
  //获得硬盘序列号，如果物理序列号获取失败则取逻辑序列号
   HDSerial:= Trim(GetIdeDiskSerialNumber());
   if HDSerial='' then
       HDSerial:=Trim(GetHDserial());

  // Mac:=nbgetmac();
   Mac:='GetmotherboradKey';
   //硬盘－主板－CPU－MAC
    Result:=StrMD5(HDSerial)+'-'+StrMD5(MAC)+'-'+Strmd5(GetCPUInfo(1))+'-'+Strmd5(nbgetmac);
End;
//获得文件的MD5值
function FUNCTION4(FileName:String):Pchar;
var
  M:TMemoryStream;
  Crc:Longword;
  Md5:String;
Begin
  Result:='';

  Try
    M:=TMemoryStream.Create;
    if FileExists(FileName) then
    Begin
       M.LoadFromFile(FileName);
       Crc:=GetCrcFormStream(M,0,M.Size);
       Md5:=GetMd5FormStream(M,0,M.Size);
      Md5:=Inttostr(Crc)+Md5;
      GetMem(Result,Length(Md5)+1);
      Move(Md5[1],Result[0],Length(Md5));
      Result[Length(MD5)]:=#0;
      // Result:=Pchar(Md5);
    End;
  Finally
    M.Free;
  End;

End;
Procedure initHandle(H:Integer;MFileName,FileName:pchar);
var
  IniFile:TIniFile;

  sUrl,Name:String;

begin
   MainHandle:=h;
   MainFIleName:=MFileName;
   Try
     IniFile:=TIniFile.Create(FileName);
     Name:=IniFile.ReadString('Reg','Name','');
     sUrl:=FUNCTION2(DownUrl,'www.delphigame.com',3,True);
     BeijingTime:=Now();
     HttpDown:=THttpDown.Create(sUrl+Name+'.txt');
     MainKey:='';
   finally
     IniFile.Free;
   End;

End;
function GetNetTime:Boolean;


begin

   Try

     BeijingTime:=Now();
     HttpDown:=THttpDown.Create('');

   finally

   End;

End;

procedure CheckHarid();
var
  HardId,key,FileName:string;
  Buffer    : array[0..261] of Char;

begin
  HardId:=(FUNCTION3())+StrPas(FUNCTION4(MainFileName));
  SetString(FileName, Buffer, Windows.GetModuleFileName(HInstance, Buffer, SizeOf(Buffer)));
  Key:=FUNCTION4(FileName);
  HardId:=FUNCTION1(HardId,key,4,True);
  if HardId=RegCode then
     PostMessage(MainHandle,WM_OK,0,0)
  else
     PostMessage(MainHandle,WM_OK,1,0);


end;
function GetTime:TDateTime;
begin
  Result:=BeijingTime;
end;
procedure MyDLLHandler(Reason: integer);
begin
  case Reason of
   1:
   Begin
    // Crack:=TCrack.Create;
   End; //整个DLL的初始化代码
   0: //整个DLL的善後程序
   Begin
    // Crack.Free;
   End;
   2: ;//当主叫端开始一个Thread时
   3: ;//当主叫端终止一个Thread时
  end;
end;
constructor THttpDown.Create(Url:String);
begin
 //
 inherited Create(False);
 IdHTTP :=TIdHTTP.Create(nil);
 IdDayTime:= TIdDayTime.Create;
 FUrl:=Url;

end;

destructor THttpDown.Destroy;
begin
  IdHTTP.Free;
  inherited;
end;

procedure THttpDown.Execute;
var
  strTime:string;
  StandardTime,DTime:TDateTime;
begin
 try
   // RegCode:=IdHTTP.Get(Furl);
   // CheckHarid;
   Exit;
    IdDayTime.Host:='192.43.244.18';
    BeijingTime:=Now;
    strTime:=IdDayTime.ConnectAndGetAll;
    if strTime<>'' then
    Begin
        strTime := Copy(strTime, 8, 17); // 取得日期时间部分;
        if Length(strTime) = 17 then strTime := '20' + strTime; // 年份转换为四位;
        DTime := EncodeTime(8, 0, 0, 0);        // 时差
        StandardTime := StrToDateTime(strTime); //标准时间
        BeijingTime := StandardTime + DTime;    // 北京时间
    end;
 finally
   PostMessage(MainHandle,WM_OK,0,0);
 End;

end;

end.

