unit CatDes;

interface
uses
  MD5, Base64, ComCtrls, DESCrypt, Sockets, Windows, SysUtils, Dialogs;
function MacAddress: string;
function StrToHexStr(const S: string): string;
function HexStrToStr(const S: string): string;
function XorStr(const S: string): string;
function SetPassStr(const S: string): string;
function GetPassStr(const S: string): string;
function GetMDd5(const aStr: string): string;
function FormatStr(const MacAddress: string): string;
implementation

function MacAddress: string;
var
  Lib: Cardinal;
  Func: function(GUID: PGUID): Longint; stdcall;
  GUID1, GUID2: TGUID;
begin
  Result := '';
  Lib := LoadLibrary('rpcrt4.dll');
  if Lib <> 0 then
  begin
    if Win32Platform <> VER_PLATFORM_WIN32_NT then
      @Func := GetProcAddress(Lib, 'UuidCreate')
    else
      @Func := GetProcAddress(Lib, 'UuidCreateSequential');
    if Assigned(Func) then
    begin
      if (Func(@GUID1) = 0) and
        (Func(@GUID2) = 0) and
        (GUID1.D4[2] = GUID2.D4[2]) and
        (GUID1.D4[3] = GUID2.D4[3]) and
        (GUID1.D4[4] = GUID2.D4[4]) and
        (GUID1.D4[5] = GUID2.D4[5]) and
        (GUID1.D4[6] = GUID2.D4[6]) and
        (GUID1.D4[7] = GUID2.D4[7]) then
      begin
        Result :=
          IntToHex(GUID1.D4[2], 2) + '-' +
          IntToHex(GUID1.D4[3], 2) + '-' +
          IntToHex(GUID1.D4[4], 2) + '-' +
          IntToHex(GUID1.D4[5], 2) + '-' +
          IntToHex(GUID1.D4[6], 2) + '-' +
          IntToHex(GUID1.D4[7], 2);
      end;
    end;
    FreeLibrary(Lib);
  end;
end;

function StrToHexStr(const S: string): string;
var
  I: Integer;
begin
  for I := 1 to Length(S) do
  begin
    if I = 1 then
      Result := IntToHex(Ord(S[1]), 2)
    else
      Result := Result + IntToHex(Ord(S[I]), 2);
  end;
end;

function HexStrToStr(const S: string): string;
var
  t: Integer;
  ts: string;
  M, Code: Integer;
begin
  t := 1;
  Result := '';
  while t <= Length(S) do
  begin
    while not (S[t] in ['0'..'9', 'A'..'F', 'a'..'f']) do
      inc(t);
    if (t + 1 > Length(S)) or (not (S[t + 1] in ['0'..'9', 'A'..'F', 'a'..'f'])) then
      ts := '$' + S[t]
    else
      ts := '$' + S[t] + S[t + 1];
    Val(ts, M, Code);
    if Code = 0 then
      Result := Result + Chr(M);
    inc(t, 2);
  end;
end;

function XorStr(const S: string): string;
const
  aXorChar: array[0..19] of Byte = (1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 9, 8, 7, 6, 5, 4, 3, 2, 1, 10); //可以多写几个 ，这里用3个做示范
var
  I: Integer;
begin
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
  begin
    Result[I] := Char(Ord(S[I]) xor aXorChar[I mod (High(aXorChar) + 1)]);
  end;
end;

function SetPassStr(const S: string): string;
//字符串加密
begin
  Result := StrToHexStr(XorStr(S));
end;

function GetPassStr(const S: string): string;
//字符串解密
begin
  Result := XorStr(HexStrToStr(S));
end;




function GetMDd5(const aStr: string): string;
var
  md: TMD5Digest;
  i: integer;
begin

 result := StrMD5(aStr);
 
end;

function FormatStr(const MacAddress: string): string;
var
  TempStr1: string;
  I: Integer;
begin
  for I := 0 to Length(MacAddress) - 1 do
  begin

    TempStr1 := Copy(MacAddress, i + 1, 1) + TempStr1;
  end;
  result := GetMDd5(TempStr1);
end;


function FormatDate(const DateTime: string): string;
var
  TempStr: string;
  I: Integer;
begin
  for I := 0 to Length(DateTime) - 1 do
  begin
    if not ((Copy(DateTime, i + 1, 1)) = '-') then
      TempStr := TempStr + (Copy(DateTime, i + 1, 1));
  end;
  result := TempStr;
end;

function DuiBiTime(const KeyDateTime: string): Boolean;
var
  NowDate: string;
begin
  NowDate := FormatdateTime('yyy', now) + FormatdateTime('mm', now) + FormatdateTime('dd', now);
  if (StrToInt(NowDate)) > (StrToInt(FormatDate(KeyDateTime))) then
    result := false
  else
    result := True;
end;
end.
