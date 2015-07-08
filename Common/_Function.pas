{*******************************************************}
{                                                       }
{       封包加密解密                                    }
{                                                       }
{       版权所有 (C) 2006 JDboy                         }
{                                                       }
{*******************************************************}

unit _Function;

interface

uses
  Windows, Dialogs, SysUtils, _Decode, _Const, JSocket, WinSock, EDcode;

{  function ArrestStringEx (Source, SearchAfter, ArrestBefore: string; var ArrestStr: string;Key:String): string;
  function  MakeDefaultMsg (Comm,param:word):TDefaultMessage;
  function  DecodeMessage (str: string): TDefaultMessage;
  function  EncodeMessage (smsg: TDefaultMessage): string;
  procedure Encode6BitBuf (src, dest: PChar; srclen, destlen: integer);
  procedure Decode6BitBuf (source: string; buf: PChar; buflen: integer);
  function  EncodeBuffer (buf: pChar; bufsize: integer): string;
  procedure DecodeBuffer (src: string; buf: PChar; bufsize: integer);
  function SendSocket (Socket:TCustomWinSocket;sendstr,EncodeKey: string):Integer;      }
function CheckStr(Str: string): Boolean;
function DecodeStr(str, DecodeKey: string): string;
function EncodeStr(str, DecodeKey: string): string;

function DecodeStrjb(str, DecodeKey: string): string;
function EncodeStrjb(str, DecodeKey: string): string;

function HostToIP(Name: string; var Ip: string): Boolean; //域名解析

var
  CSEncode: TRTLCriticalSection;
  CSEncodeBuf: TRTLCriticalSection;

implementation

var
  EncBuf, TempBuf: PChar;

function HostToIP(Name: string; var Ip: string): Boolean;
var
  WsData: TWSAData;
  hostName: array[0..255] of char;
  hostEnt: PHostEnt;
  addr: PChar;
begin
  WSAStartup($0101, wsdata);
  try
    gethostname(hostName, sizeof(hostName));
    StrPCopy(hostName, Name);
    hostEnt := gethostbyname(hostName);
    if Assigned(hostEnt) then
      if Assigned(hostEnt^.h_addr_list) then
      begin
        addr := hostEnt^.h_addr_list^;
        if Assigned(addr) then
        begin
          IP := Format('%d.%d.%d.%d', [byte(addr[0]), byte(addr[1]), byte(addr[2]), byte(addr[3])]);
          Result := True;
        end
        else
          Result := False;
      end
      else
        Result := False
    else
    begin Result := False;
    end;
  finally
    WSACleanup;
  end;
end;

function DecodeStr(str, DecodeKey: string): string;

begin
  try
    EnterCriticalSection(CSEncodeBuf);
    Result := My_Decode(str, DecodeKey);

  finally
    LeaveCriticalSection(CSEncodeBuf);
  end;
end;

function EncodeStr(str, DecodeKey: string): string;

begin
  try
    EnterCriticalSection(CSEncodeBuf);
  //  s:=myEncodeString(str);
    Result := My_Encode(str, DecodeKey);
  finally
    LeaveCriticalSection(CSEncodeBuf);
  end;
end;

function DecodeStrjb(str, DecodeKey: string): string;
var
  s: string;
begin
  try
    EnterCriticalSection(CSEncodeBuf);
    s := My_Decode(str, DecodeKey);
    Result := myDecodeString(s);
  finally
    LeaveCriticalSection(CSEncodeBuf);
  end;
end;

function EncodeStrjb(str, DecodeKey: string): string;
var
  s: string;
begin
  try
    EnterCriticalSection(CSEncodeBuf);
    s := myEncodeString(str);
    Result := My_Encode(s, DecodeKey);
  finally
    LeaveCriticalSection(CSEncodeBuf);
  end;
end;

function CheckStr(Str: string): Boolean;
var
  i, j: integer;
begin
  Result := True;
  j := Length(Str);
  if j <= 0 then
  begin Result := False;
    Exit;
  end;
  for i := 1 to j do
  begin
    if not (Str[i] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

function MakeDefaultMsg(Comm, param: word): TDefaultMessage;
begin
  result.Comm := comm;
  result.Param := Param;
end;
(*
function  EncodeMessage (smsg: TDefaultMessage): string;
begin
   try
      EnterCriticalSection (CSencode);
      Move (smsg, TempBuf^, sizeof(TDefaultMessage));
      Encode6BitBuf (TempBuf, EncBuf, sizeof(TDefaultMessage), 1024);
      Result := StrPas (EncBuf);  //Error: 1, 2, 3, 4, 5, 6, 7, 8, 9
   finally
    LeaveCriticalSection (CSencode);
   end;
end;

procedure Encode6BitBuf (src, dest: PChar; srclen, destlen: integer);
var
   i, restcount, destpos: integer;
   made, ch, rest: byte;
begin
  try
   restcount := 0;
   rest 		 := 0;
   destpos	 := 0;
   for i:=0 to srclen - 1 do begin
      if destpos >= destlen then break;
      ch := byte (src[i]);
      made := byte ((rest or (ch shr (2+restcount))) and $3F);
      rest := byte (((ch shl (8 - (2+restcount))) shr 2) and $3F);
      Inc (restcount, 2);

      if restcount < 6 then begin
       dest[destpos] := char(made + $3C);
         Inc (destpos);
      end else begin
       if destpos < destlen-1 then begin
            dest[destpos]   := char(made + $3C);
            dest[destpos+1] := char(rest + $3C);
            Inc (destpos, 2);
         end else begin
            dest[destpos]   := char(made + $3C);
            Inc (destpos);
         end;
         restcount := 0;
         rest := 0;
      end;

   end;
   if restcount > 0 then begin
    dest[destpos] := char (rest + $3C);
      Inc (destpos);
   end;
   dest[destpos] := #0;
  except
  end;
end;

procedure Decode6BitBuf (source: string; buf: PChar; buflen: integer);
const
 Masks: array[2..6] of byte = ($FC, $F8, $F0, $E0, $C0);
   //($FE, $FC, $F8, $F0, $E0, $C0, $80, $00);
var
   i, len, bitpos, madebit, bufpos: integer;
   ch, tmp, _byte: Byte;
begin
  try
     len := Length (source);
     bitpos  := 2;
     madebit := 0;
     bufpos  := 0;
     tmp	  := 0;
     ch := 0;
     for i:=1 to len do begin
        if Integer(source[i]) - $3C >= 0 then
       ch := Byte(source[i]) - $3C
        else begin
           bufpos := 0;
          break;
        end;

        if bufpos >= buflen then break;

        if (madebit+6) >= 8 then begin
           _byte := Byte(tmp or ((ch and $3F) shr (6-bitpos)));
            buf[bufpos] := Char(_byte);
           Inc (bufpos);
           madebit := 0;
           if bitpos < 6 then Inc (bitpos, 2)
           else begin
            bitpos := 2;
              continue;
           end;
        end;

        tmp := Byte (Byte(ch shl bitpos) and Masks[bitpos]);   // #### ##--
        Inc (madebit, 8-bitpos);
     end;
     buf [bufpos] := #0;
  except end;
end;

function ArrestStringEx (Source, SearchAfter, ArrestBefore: string; var ArrestStr: string;Key:String): string;
var
   SrcLen: integer;
   GoodData: Boolean;
   i, n: integer;
begin
   if Source = '' then begin
      Result := '';
      exit;
   end;

   ArrestStr := ''; {result string}
   try
      SrcLen := Length (Source);
      GoodData := FALSE;
      if SrcLen >= 2 then
         if Source[1] = SearchAfter then begin
            Source := Copy (Source, 2, SrcLen-1);
            SrcLen := Length (Source);
            GoodData := TRUE;
         end else begin
            n := Pos (SearchAfter, Source);
            if n > 0 then begin
               Source := Copy (Source, n+1, SrcLen-(n));
               SrcLen := Length(Source);
               GoodData := TRUE;
            end;
         end;
      //Fin := FALSE;
      if GoodData then begin
         n := Pos (ArrestBefore, Source);
         if n > 0 then begin
            ArrestStr := Copy (Source, 1, n-1);
            Result := Copy (Source, n+1, SrcLen-n);
         end else begin
            Result := SearchAfter + Source;
         end;
      end else begin
         for i:=1 to SrcLen do begin
            if Source[i] = SearchAfter then begin
               Result := Copy (Source, i, SrcLen-i+1);
               break;
            end;
         end;
      end;
   except
      ArrestStr := '';
      Result := '';
   end;
   ArrestStr := DecodeStr(ArrestStr,Key);
end;

procedure DecodeBuffer (src: string; buf: PChar; bufsize: integer);
begin
   try
      EnterCriticalSection (CSencode);
      Decode6BitBuf (src, EncBuf, BUFFERSIZE);
      Move (EncBuf^, buf^, bufsize);
   finally
    LeaveCriticalSection (CSencode);
   end;
end;

function  EncodeBuffer (buf: pChar; bufsize: integer): string;
begin
   try
      EnterCriticalSection (CSencode);
      if bufsize < BUFFERSIZE then begin
         Move (buf^, TempBuf^, bufsize);
         Encode6BitBuf (TempBuf, EncBuf, bufsize, BUFFERSIZE);
         Result := StrPas (EncBuf);
      end else
         Result := '';
   finally
    LeaveCriticalSection (CSencode);
   end;
end;

function DecodeMessage (str: string): TDefaultMessage;
var
   msg: TDefaultMessage;
begin
   try
      EnterCriticalSection (CSencode);
      Decode6BitBuf (str, EncBuf, 1024);
      Move (EncBuf^, msg, sizeof(TDefaultMessage));
      Result := msg;
   finally
    LeaveCriticalSection (CSencode);
   end;
end;

function SendSocket (Socket:TCustomWinSocket;SendStr,EncodeKey: string):Integer;
var
  nStr:string;
begin
  Result := 0;
  if Socket.Connected then
  begin
    SendStr := EncodeStr(SendStr,EncodeKey);
    nStr:='#' + SendStr + '!';
    Result := Socket.SendText(nStr);
  end;
end;
 *)
initialization
  begin
    GetMem(EncBuf, 10240 + 100); //BUFFERSIZE + 100);
    GetMem(TempBuf, 10240); //2048);
    InitializeCriticalSection(CSEncode);
    InitializeCriticalSection(CSEncodeBuf);
  end;

finalization
  begin
    FreeMem(EncBuf, 10240 + 100);
    FreeMem(TempBuf, 10240);
    DeleteCriticalSection(CSEncode);
    DeleteCriticalSection(CSEncodeBuf);
  end;

end.
