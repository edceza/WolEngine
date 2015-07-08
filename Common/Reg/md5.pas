unit MD5;
interface
uses
  SysUtils, Classes;
const
  MD5Version                            = 102;
  CopyRight                               : string =
    ' MD5 Message-Digest (c) 97-98 F. Piette V1.02 ';
{$Q-}
{$R-}
type
  TMD5Context = record
    State: array[0..3] of Longint;
    Count: array[0..1] of Longint;
    case Integer of
      0: (BufChar: array[0..63] of Byte);
      1: (BufLong: array[0..15] of Longint);
  end;
  TMD5Digest = array[0..15] of Byte;

procedure MD5Init(var MD5Context: TMD5Context);
procedure MD5Update(var MD5Context: TMD5Context;
  const Data;
  len: Integer);
procedure MD5Transform(var Buf: array of Longint;
  const Data: array of Longint);
procedure MD5UpdateBuffer(var MD5Context: TMD5Context;
  Buffer: Pointer;
  BufSize: Integer);
procedure MD5Final(var Digest: TMD5Digest; var MD5Context: TMD5Context);

function GetMD5(Buffer: Pointer; BufSize: Integer): string;
function StrMD5(Buffer: string): string;
function FileMD5(const FileName: string): string;
implementation

const
  MaxBufSize                            = 16384;

type
  PMD5Buffer = ^TMD5Buffer;
  TMD5Buffer = array[0..(MaxBufSize - 1)] of Char;
  {* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
  { MD5 initialization. Begins an MD5 operation, writing a new context.         }

procedure MD5Init(var MD5Context: TMD5Context);
begin
  FillChar(MD5Context, sizeof(TMD5Context), #0);
  with MD5Context do
  begin
    { Load magic initialization constants. }
    State[0] := Longint($67452301);
    State[1] := Longint($EFCDAB89);
    State[2] := Longint($98BADCFE);
    State[3] := Longint($10325476);
  end
end;
{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ MD5 block update operation. Continues an MD5 message-digest operation,      }
{ processing another message block, and updating the context.                 }

procedure MD5Update(
  var MD5Context: TMD5Context; { Context                         }
  const Data; { Input block                     }
  len: Integer); { Length of input block           }
type
  TByteArray = array[0..0] of Byte;
var
  Index                                 : Word;
  t                                     : Longint;
begin
  with MD5Context do
  begin
    t := Count[0];
    Inc(Count[0], Longint(len) shl 3);
    if Count[0] < t then
      Inc(Count[1]);
    Inc(Count[1], len shr 29);
    t := (t shr 3) and $3F;
    Index := 0;
    if t <> 0 then
    begin
      Index := t;
      t := 64 - t;
      if len < t then
      begin
        Move(Data, BufChar[Index], len);
        Exit;
      end;
      Move(Data, BufChar[Index], t);
      MD5Transform(State, BufLong);
      Dec(len, t);
      Index := t; { Wolfgang Klein, 05/06/99 }
    end;
    while len >= 64 do
    begin
      Move(TByteArray(Data)[Index], BufChar, 64);
      MD5Transform(State, BufLong);
      Inc(Index, 64);
      Dec(len, 64);
    end;
    Move(TByteArray(Data)[Index], BufChar, len);
  end
end;
{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ MD5 finalization. Ends an MD5 message-digest operation, writing the message }
{ digest and zeroizing the context.                                           }

procedure MD5Final(var Digest: TMD5Digest; var MD5Context: TMD5Context);
var
  Cnt                                   : Word;
  p                                     : Byte;
begin
  with MD5Context do
  begin
    Cnt := (Count[0] shr 3) and $3F;
    p := Cnt;
    BufChar[p] := $80;
    Inc(p);
    Cnt := 64 - 1 - Cnt;
    if Cnt < 8 then
    begin
      FillChar(BufChar[p], Cnt, #0);
      MD5Transform(State, BufLong);
      FillChar(BufChar, 56, #0);
    end
    else
      FillChar(BufChar[p], Cnt - 8, #0);
    BufLong[14] := Count[0];
    BufLong[15] := Count[1];
    MD5Transform(State, BufLong);
    Move(State, Digest, 16)
  end;
  FillChar(MD5Context, sizeof(TMD5Context), #0)
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ MD5 basic transformation. Transforms state based on block.                  }

procedure MD5Transform(
  var Buf: array of Longint;
  const Data: array of Longint);
var
  a, B, c, d                            : Longint;

  procedure Round1(var w: Longint; x, y, z, Data: Longint; S: Byte);
  begin
    Inc(w, (z xor (x and (y xor z))) + Data);
    w := (w shl S) or (w shr (32 - S));
    Inc(w, x)
  end;

  procedure Round2(var w: Longint; x, y, z, Data: Longint; S: Byte);
  begin
    Inc(w, (y xor (z and (x xor y))) + Data);
    w := (w shl S) or (w shr (32 - S));
    Inc(w, x)
  end;

  procedure Round3(var w: Longint; x, y, z, Data: Longint; S: Byte);
  begin
    Inc(w, (x xor y xor z) + Data);
    w := (w shl S) or (w shr (32 - S));
    Inc(w, x)
  end;

  procedure Round4(var w: Longint; x, y, z, Data: Longint; S: Byte);
  begin
    Inc(w, (y xor (x or not z)) + Data);
    w := (w shl S) or (w shr (32 - S));
    Inc(w, x)
  end;
begin
  a := Buf[0];
  B := Buf[1];
  c := Buf[2];
  d := Buf[3];

  Round1(a, B, c, d, Data[0] + Longint($D76AA478), 7);
  Round1(d, a, B, c, Data[1] + Longint($E8C7B756), 12);
  Round1(c, d, a, B, Data[2] + Longint($242070DB), 17);
  Round1(B, c, d, a, Data[3] + Longint($C1BDCEEE), 22);
  Round1(a, B, c, d, Data[4] + Longint($F57C0FAF), 7);
  Round1(d, a, B, c, Data[5] + Longint($4787C62A), 12);
  Round1(c, d, a, B, Data[6] + Longint($A8304613), 17);
  Round1(B, c, d, a, Data[7] + Longint($FD469501), 22);
  Round1(a, B, c, d, Data[8] + Longint($698098D8), 7);
  Round1(d, a, B, c, Data[9] + Longint($8B44F7AF), 12);
  Round1(c, d, a, B, Data[10] + Longint($FFFF5BB1), 17);
  Round1(B, c, d, a, Data[11] + Longint($895CD7BE), 22);
  Round1(a, B, c, d, Data[12] + Longint($6B901122), 7);
  Round1(d, a, B, c, Data[13] + Longint($FD987193), 12);
  Round1(c, d, a, B, Data[14] + Longint($A679438E), 17);
  Round1(B, c, d, a, Data[15] + Longint($49B40821), 22);

  Round2(a, B, c, d, Data[1] + Longint($F61E2562), 5);
  Round2(d, a, B, c, Data[6] + Longint($C040B340), 9);
  Round2(c, d, a, B, Data[11] + Longint($265E5A51), 14);
  Round2(B, c, d, a, Data[0] + Longint($E9B6C7AA), 20);
  Round2(a, B, c, d, Data[5] + Longint($D62F105D), 5);
  Round2(d, a, B, c, Data[10] + Longint($02441453), 9);
  Round2(c, d, a, B, Data[15] + Longint($D8A1E681), 14);
  Round2(B, c, d, a, Data[4] + Longint($E7D3FBC8), 20);
  Round2(a, B, c, d, Data[9] + Longint($21E1CDE6), 5);
  Round2(d, a, B, c, Data[14] + Longint($C33707D6), 9);
  Round2(c, d, a, B, Data[3] + Longint($F4D50D87), 14);
  Round2(B, c, d, a, Data[8] + Longint($455A14ED), 20);
  Round2(a, B, c, d, Data[13] + Longint($A9E3E905), 5);
  Round2(d, a, B, c, Data[2] + Longint($FCEFA3F8), 9);
  Round2(c, d, a, B, Data[7] + Longint($676F02D9), 14);
  Round2(B, c, d, a, Data[12] + Longint($8D2A4C8A), 20);

  Round3(a, B, c, d, Data[5] + Longint($FFFA3942), 4);
  Round3(d, a, B, c, Data[8] + Longint($8771F681), 11);
  Round3(c, d, a, B, Data[11] + Longint($6D9D6122), 16);
  Round3(B, c, d, a, Data[14] + Longint($FDE5380C), 23);
  Round3(a, B, c, d, Data[1] + Longint($A4BEEA44), 4);
  Round3(d, a, B, c, Data[4] + Longint($4BDECFA9), 11);
  Round3(c, d, a, B, Data[7] + Longint($F6BB4B60), 16);
  Round3(B, c, d, a, Data[10] + Longint($BEBFBC70), 23);
  Round3(a, B, c, d, Data[13] + Longint($289B7EC6), 4);
  Round3(d, a, B, c, Data[0] + Longint($EAA127FA), 11);
  Round3(c, d, a, B, Data[3] + Longint($D4EF3085), 16);
  Round3(B, c, d, a, Data[6] + Longint($04881D05), 23);
  Round3(a, B, c, d, Data[9] + Longint($D9D4D039), 4);
  Round3(d, a, B, c, Data[12] + Longint($E6DB99E5), 11);
  Round3(c, d, a, B, Data[15] + Longint($1FA27CF8), 16);
  Round3(B, c, d, a, Data[2] + Longint($C4AC5665), 23);

  Round4(a, B, c, d, Data[0] + Longint($F4292244), 6);
  Round4(d, a, B, c, Data[7] + Longint($432AFF97), 10);
  Round4(c, d, a, B, Data[14] + Longint($AB9423A7), 15);
  Round4(B, c, d, a, Data[5] + Longint($FC93A039), 21);
  Round4(a, B, c, d, Data[12] + Longint($655B59C3), 6);
  Round4(d, a, B, c, Data[3] + Longint($8F0CCC92), 10);
  Round4(c, d, a, B, Data[10] + Longint($FFEFF47D), 15);
  Round4(B, c, d, a, Data[1] + Longint($85845DD1), 21);
  Round4(a, B, c, d, Data[8] + Longint($6FA87E4F), 6);
  Round4(d, a, B, c, Data[15] + Longint($FE2CE6E0), 10);
  Round4(c, d, a, B, Data[6] + Longint($A3014314), 15);
  Round4(B, c, d, a, Data[13] + Longint($4E0811A1), 21);
  Round4(a, B, c, d, Data[4] + Longint($F7537E82), 6);
  Round4(d, a, B, c, Data[11] + Longint($BD3AF235), 10);
  Round4(c, d, a, B, Data[2] + Longint($2AD7D2BB), 15);
  Round4(B, c, d, a, Data[9] + Longint($EB86D391), 21);

  Inc(Buf[0], a);
  Inc(Buf[1], B);
  Inc(Buf[2], c);
  Inc(Buf[3], d);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

procedure MD5UpdateBuffer(
  var MD5Context: TMD5Context;
  Buffer: Pointer;
  BufSize: Integer);
var
  BufTmp                                : PMD5Buffer;
  BufPtr                                : PChar;
  Bytes                                 : Word;
begin
  New(BufTmp);
  BufPtr := Buffer;
  try
    repeat
      if BufSize > MaxBufSize then
        Bytes := MaxBufSize
      else
        Bytes := BufSize;
      Move(BufPtr^, BufTmp^, Bytes);
      Inc(BufPtr, Bytes);
      Dec(BufSize, Bytes);
      if Bytes > 0 then
        MD5Update(MD5Context, BufTmp^, Bytes);
    until Bytes < MaxBufSize;
  finally
    Dispose(BufTmp);
  end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

function GetMD5(Buffer: Pointer; BufSize: Integer): string;
var
  i                                     : Integer;
  MD5Digest                             : TMD5Digest;
  MD5Context                            : TMD5Context;
begin
  for i := 0 to 15 do
    Byte(MD5Digest[i]) := i + 1;
  MD5Init(MD5Context);
  MD5UpdateBuffer(MD5Context, Buffer, BufSize);
  MD5Final(MD5Digest, MD5Context);
  Result := '';
  for i := 0 to 15 do
    Result := Result + Format('%.2X', [MD5Digest[i]]);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

function StrMD5(Buffer: string): string;
begin
  Result := GetMD5(@Buffer[1], Length(Buffer));
end;

function FileMD5(const FileName: string): string;
const
{$IFDEF VER80}
  ChunkSize                             : Cardinal = 1024 * 31;
{$ELSE}
  ChunkSize                             : Cardinal = 102400;
{$ENDIF}
var
  i                                     : Integer;
  j                                     : Integer;
  Num                                   : Integer;
  Rest                                  : Integer;
  MD5Digest                             : TMD5Digest;
  MD5Context                            : TMD5Context;
  Buf                                   : ^Byte;
  Stream                                : TFileStream;
begin
  Result := '';

  { Open file }
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    { Allocate buffer to read file }
    GetMem(Buf, ChunkSize);
    try
      { Initialize MD5 engine }
      for i := 0 to 15 do
        Byte(MD5Digest[i]) := i + 1;
      MD5Init(MD5Context);

      { Calculate number of full chunks that will fit into the buffer }
      Num := Cardinal(Stream.Size) div ChunkSize;
      { Calculate remaining bytes }
      Rest := Cardinal(Stream.Size) mod ChunkSize;

      { Set the stream to the beginning of the file }
      Stream.Position := 0;

      { Process full chunks }
      for j := 0 to Num - 1 do
      begin
        Stream.Read(Buf^, ChunkSize);
        MD5UpdateBuffer(MD5Context, Buf, ChunkSize);
      end;

      { Process remaining bytes }
      if Rest > 0 then
      begin
        Stream.Read(Buf^, Rest);
        MD5UpdateBuffer(MD5Context, Buf, Rest);
      end;

    finally
      FreeMem(Buf, ChunkSize);
    end;

    { Finalize MD5 calculation }
    MD5Final(MD5Digest, MD5Context);
    for i := 0 to 15 do
      Result := Result + IntToHex(Byte(MD5Digest[i]), 2);
  finally
    { Free the file }
    Stream.Free;
  end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.
