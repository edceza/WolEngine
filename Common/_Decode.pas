{*******************************************************}
{                                                       }
{       封包加密解密                                    }
{                                                       }
{       版权所有 (C) 2006 JDboy                         }
{                                                       }
{*******************************************************}


unit _Decode;

interface

uses
  Windows, Messages, SysUtils, Classes;

{DES Function Start}
type
  TKeyByte = array[0..5] of Byte;
  TDesMode = (dmEncry, dmDecry);

function EncryStr(Str, Key: string): string;
function DecryStr(Str, Key: string): string;
function EncryStrHex(Str, Key: string): string;
function DecryStrHex(StrHex, Key: string): string;
{DES Function End}
function My_Encode(Str, Key: string): string;
function My_Decode(str, Key: string): string;
{Base64 Function Start}
function MimeEncodeString(const s: AnsiString): AnsiString;
function MimeEncodeStringNoCRLF(const s: AnsiString): AnsiString;
function MimeDecodeString(const s: AnsiString): AnsiString;
procedure MimeEncodeStream(const InputStream: TStream; const OutputStream: TStream);
procedure MimeEncodeStreamNoCRLF(const InputStream: TStream; const OutputStream: TStream);
procedure MimeDecodeStream(const InputStream: TStream; const OutputStream: TStream);
function MimeEncodedSize(const i: Cardinal): Cardinal;
function MimeEncodedSizeNoCRLF(const i: Cardinal): Cardinal;
function MimeDecodedSize(const i: Cardinal): Cardinal;
procedure DecodeHttpBasicAuthentication(const BasicCredentials: AnsiString;
  out UserId, PassWord: AnsiString);
procedure MimeEncode(const InputBuffer; const InputByteCount: Cardinal; out OutputBuffer);
procedure MimeEncodeNoCRLF(const InputBuffer; const InputByteCount: Cardinal; out OutputBuffer);
procedure MimeEncodeFullLines(const InputBuffer; const InputByteCount: Cardinal; out OutputBuffer);
function MimeDecode(const InputBuffer; const InputBytesCount: Cardinal; out OutputBuffer): Cardinal;
function MimeDecodePartial(const InputBuffer; const InputBytesCount: Cardinal;
  out OutputBuffer; var ByteBuffer: Cardinal; var ByteBufferSpace: Cardinal): Cardinal;
function MimeDecodePartialEnd(out OutputBuffer; const ByteBuffer: Cardinal;
  const ByteBufferSpace: Cardinal): Cardinal;
procedure Base64Encode(InputFile, OutputFile: string);
procedure Base64Decode(InputFile, OutputFile: string);
const
  MIME_ENCODED_LINE_BREAK = 76;
  MIME_DECODED_LINE_BREAK = MIME_ENCODED_LINE_BREAK div 4 * 3;
  BUFFER_SIZE = MIME_DECODED_LINE_BREAK * 3 * 4 * 16;
  MIME_ENCODE_TABLE: array[0..63] of Byte = (
    065, 066, 067, 068, 069, 070, 071, 072, // 00 - 07
    073, 074, 075, 076, 077, 078, 079, 080, // 08 - 15
    081, 082, 083, 084, 085, 086, 087, 088, // 16 - 23
    089, 090, 097, 098, 099, 100, 101, 102, // 24 - 31
    103, 104, 105, 106, 107, 108, 109, 110, // 32 - 39
    111, 112, 113, 114, 115, 116, 117, 118, // 40 - 47
    119, 120, 121, 122, 048, 049, 050, 051, // 48 - 55
    052, 053, 054, 055, 056, 057, 043, 047); // 56 - 63

  MIME_PAD_CHAR = Byte('=');

  MIME_DECODE_TABLE: array[Byte] of Cardinal = (
    255, 255, 255, 255, 255, 255, 255, 255, //  00 -  07
    255, 255, 255, 255, 255, 255, 255, 255, //  08 -  15
    255, 255, 255, 255, 255, 255, 255, 255, //  16 -  23
    255, 255, 255, 255, 255, 255, 255, 255, //  24 -  31
    255, 255, 255, 255, 255, 255, 255, 255, //  32 -  39
    255, 255, 255, 062, 255, 255, 255, 063, //  40 -  47
    052, 053, 054, 055, 056, 057, 058, 059, //  48 -  55
    060, 061, 255, 255, 255, 255, 255, 255, //  56 -  63
    255, 000, 001, 002, 003, 004, 005, 006, //  64 -  71
    007, 008, 009, 010, 011, 012, 013, 014, //  72 -  79
    015, 016, 017, 018, 019, 020, 021, 022, //  80 -  87
    023, 024, 025, 255, 255, 255, 255, 255, //  88 -  95
    255, 026, 027, 028, 029, 030, 031, 032, //  96 - 103
    033, 034, 035, 036, 037, 038, 039, 040, // 104 - 111
    041, 042, 043, 044, 045, 046, 047, 048, // 112 - 119
    049, 050, 051, 255, 255, 255, 255, 255, // 120 - 127
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255);
  BitIP: array[0..63] of Byte = //初始值置IP
  (57, 49, 41, 33, 25, 17, 9, 1,
    59, 51, 43, 35, 27, 19, 11, 3,
    61, 53, 45, 37, 29, 21, 13, 5,
    63, 55, 47, 39, 31, 23, 15, 7,
    56, 48, 40, 32, 24, 16, 8, 0,
    58, 50, 42, 34, 26, 18, 10, 2,
    60, 52, 44, 36, 28, 20, 12, 4,
    62, 54, 46, 38, 30, 22, 14, 6);

  BitCP: array[0..63] of Byte = //逆初始置IP-1
  (39, 7, 47, 15, 55, 23, 63, 31,
    38, 6, 46, 14, 54, 22, 62, 30,
    37, 5, 45, 13, 53, 21, 61, 29,
    36, 4, 44, 12, 52, 20, 60, 28,
    35, 3, 43, 11, 51, 19, 59, 27,
    34, 2, 42, 10, 50, 18, 58, 26,
    33, 1, 41, 9, 49, 17, 57, 25,
    32, 0, 40, 8, 48, 16, 56, 24);

  BitExp: array[0..47] of Integer = // 位选择函数E
  (31, 0, 1, 2, 3, 4, 3, 4, 5, 6, 7, 8, 7, 8, 9, 10,
    11, 12, 11, 12, 13, 14, 15, 16, 15, 16, 17, 18, 19, 20, 19, 20,
    21, 22, 23, 24, 23, 24, 25, 26, 27, 28, 27, 28, 29, 30, 31, 0);

  BitPM: array[0..31] of Byte = //置换函数P
  (15, 6, 19, 20, 28, 11, 27, 16, 0, 14, 22, 25, 4, 17, 30, 9,
    1, 7, 23, 13, 31, 26, 2, 8, 18, 12, 29, 5, 21, 10, 3, 24);

  sBox: array[0..7] of array[0..63] of Byte = //S盒
  ((14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
    0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
    4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
    15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13),

    (15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10,
    3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
    0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
    13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9),

    (10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
    13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
    13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
    1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12),

    (7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
    13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
    10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
    3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14),

    (2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
    14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
    4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14,
    11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3),

    (12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
    10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
    9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
    4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13),

    (4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
    13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
    1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
    6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12),

    (13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
    1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
    7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
    2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11));

  BitPMC1: array[0..55] of Byte = //选择置换PC-1
  (56, 48, 40, 32, 24, 16, 8,
    0, 57, 49, 41, 33, 25, 17,
    9, 1, 58, 50, 42, 34, 26,
    18, 10, 2, 59, 51, 43, 35,
    62, 54, 46, 38, 30, 22, 14,
    6, 61, 53, 45, 37, 29, 21,
    13, 5, 60, 52, 44, 36, 28,
    20, 12, 4, 27, 19, 11, 3);

  BitPMC2: array[0..47] of Byte = //选择置换PC-2
  (13, 16, 10, 23, 0, 4,
    2, 27, 14, 5, 20, 9,
    22, 18, 11, 3, 25, 7,
    15, 6, 26, 19, 12, 1,
    40, 51, 30, 36, 46, 54,
    29, 39, 50, 44, 32, 47,
    43, 48, 38, 55, 33, 52,
    45, 41, 49, 35, 28, 31);

type
  PByte4 = ^TByte4;
  TByte4 = packed record
    b1: Byte;
    b2: Byte;
    b3: Byte;
    b4: Byte;
  end;

  PByte3 = ^TByte3;
  TByte3 = packed record
    b1: Byte;
    b2: Byte;
    b3: Byte;
  end;
{Base64 Function End}

var
  subKey: array[0..15] of TKeyByte;
implementation
//..........................Base64 Start

function MimeEncodeString(const s: AnsiString): AnsiString;
var
  l: Cardinal;
begin
  if Pointer(s) <> nil then
  begin
    l := Cardinal(Pointer(Cardinal(s) - 4)^);
    SetLength(Result, MimeEncodedSize(l));
    MimeEncode(Pointer(s)^, l, Pointer(Result)^);
  end
  else
    Result := '';
end;

function MimeEncodeStringNoCRLF(const s: AnsiString): AnsiString;
var
  l: Cardinal;
begin
  if Pointer(s) <> nil then
  begin
    l := Cardinal(Pointer(Cardinal(s) - 4)^);
    SetLength(Result, MimeEncodedSizeNoCRLF(l));
    MimeEncodeNoCRLF(Pointer(s)^, l, Pointer(Result)^);
  end
  else
    Result := '';
end;

function MimeDecodeString(const s: AnsiString): AnsiString;
var
  ByteBuffer, ByteBufferSpace: Cardinal;
  l: Cardinal;
begin
  if Pointer(s) <> nil then
  begin
    l := Cardinal(Pointer(Cardinal(s) - 4)^);
    SetLength(Result, (l + 3) div 4 * 3);
    ByteBuffer := 0;
    ByteBufferSpace := 4;
    l := MimeDecodePartial(Pointer(s)^, l, Pointer(Result)^, ByteBuffer, ByteBufferSpace);
    Inc(l, MimeDecodePartialEnd(Pointer(Cardinal(Result) + l)^,
      ByteBuffer, ByteBufferSpace));
    SetLength(Result, l);
  end
  else
    Result := '';
end;

procedure MimeEncodeStream(const InputStream: TStream; const OutputStream: TStream);
var
  InputBuffer: array[0..BUFFER_SIZE - 1] of Byte;
  OutputBuffer: array[0..(BUFFER_SIZE + 2) div 3 * 4 + BUFFER_SIZE div
  MIME_DECODED_LINE_BREAK * 2 - 1] of Byte;
  BytesRead: Cardinal;
  IDelta, ODelta: Cardinal;
begin
  BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));

  while BytesRead = SizeOf(InputBuffer) do
  begin
    MimeEncodeFullLines(InputBuffer, SizeOf(InputBuffer), OutputBuffer);
    OutputStream.Write(OutputBuffer, SizeOf(OutputBuffer));
    BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));
  end;

  MimeEncodeFullLines(InputBuffer, BytesRead, OutputBuffer);

  IDelta := BytesRead div MIME_DECODED_LINE_BREAK; // Number of lines processed.
  ODelta := IDelta * (MIME_ENCODED_LINE_BREAK + 2);
  IDelta := IDelta * MIME_DECODED_LINE_BREAK;
  MimeEncodeNoCRLF(Pointer(Cardinal(@InputBuffer) + IDelta)^, BytesRead - IDelta,
    Pointer(Cardinal(@OutputBuffer) + ODelta)^);

  OutputStream.Write(OutputBuffer, MimeEncodedSize(BytesRead));
end;

procedure MimeEncodeStreamNoCRLF(const InputStream: TStream; const OutputStream: TStream);
var
  InputBuffer: array[0..BUFFER_SIZE - 1] of Byte;
  OutputBuffer: array[0..((BUFFER_SIZE + 2) div 3) * 4 - 1] of Byte;
  BytesRead: Cardinal;
begin
  BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));
  while BytesRead = SizeOf(InputBuffer) do
  begin
    MimeEncodeNoCRLF(InputBuffer, SizeOf(InputBuffer), OutputBuffer);
    OutputStream.Write(OutputBuffer, SizeOf(OutputBuffer));
    BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));
  end;

  MimeEncodeNoCRLF(InputBuffer, BytesRead, OutputBuffer);
  OutputStream.Write(OutputBuffer, (BytesRead + 2) div 3 * 4);
end;

procedure MimeDecodeStream(const InputStream: TStream; const OutputStream: TStream);
var
  ByteBuffer, ByteBufferSpace: Cardinal;
  InputBuffer: array[0..BUFFER_SIZE - 1] of Byte;
  OutputBuffer: array[0..(BUFFER_SIZE + 3) div 4 * 3 - 1] of Byte;
  BytesRead: Cardinal;
begin
  ByteBuffer := 0;
  ByteBufferSpace := 4;
  BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));
  while BytesRead > 0 do
  begin
    OutputStream.Write(OutputBuffer, MimeDecodePartial(InputBuffer, BytesRead,
      OutputBuffer, ByteBuffer, ByteBufferSpace));
    BytesRead := InputStream.Read(InputBuffer, SizeOf(InputBuffer));
  end;
  OutputStream.Write(OutputBuffer, MimeDecodePartialEnd(OutputBuffer, ByteBuffer,
    ByteBufferSpace));
end;

procedure DecodeHttpBasicAuthentication(const BasicCredentials: AnsiString; out UserId, PassWord: AnsiString);
label
  Fail;
const
  LBasic = 6; { Length ('Basic ') }
var
  DecodedPtr, p: PAnsiChar;
  i, l: Cardinal;
begin
  p := Pointer(BasicCredentials);
  if p = nil then
    goto Fail;

  l := Cardinal(Pointer(p - 4)^);
  if l <= LBasic then
    goto Fail;

  Dec(l, LBasic);
  Inc(p, LBasic);

  GetMem(DecodedPtr, (l + 3) div 4 * 3 { MimeDecodedSize (l) });
  l := MimeDecode(p^, l, DecodedPtr^);
  i := 0;
  p := DecodedPtr;
  while (l > 0) and (p[i] <> ':') do
  begin
    Inc(i);
    Dec(l);
  end;
  SetString(UserId, DecodedPtr, i);
  if l > 1 then
    SetString(PassWord, DecodedPtr + i + 1, l - 1)
  else
    PassWord := '';

  FreeMem(DecodedPtr);
  Exit;

  Fail:
  UserId := '';
  PassWord := '';
end;

function MimeEncodedSize(const i: Cardinal): Cardinal;
begin
  Result := (i + 2) div 3 * 4 + (i - 1) div MIME_DECODED_LINE_BREAK * 2;
end;

function MimeEncodedSizeNoCRLF(const i: Cardinal): Cardinal;
begin
  Result := (i + 2) div 3 * 4;
end;

function MimeDecodedSize(const i: Cardinal): Cardinal;
begin
  Result := (i + 3) div 4 * 3;
end;

procedure MimeEncode(const InputBuffer; const InputByteCount: Cardinal; out OutputBuffer);
var
  IDelta, ODelta: Cardinal;
begin
  MimeEncodeFullLines(InputBuffer, InputByteCount, OutputBuffer);
  IDelta := InputByteCount div MIME_DECODED_LINE_BREAK;
  ODelta := IDelta * (MIME_ENCODED_LINE_BREAK + 2);
  IDelta := IDelta * MIME_DECODED_LINE_BREAK;
  MimeEncodeNoCRLF(Pointer(Cardinal(@InputBuffer) + IDelta)^,
    InputByteCount - IDelta, Pointer(Cardinal(@OutputBuffer) + ODelta)^);
end;

procedure MimeEncodeFullLines(const InputBuffer; const InputByteCount: Cardinal; out OutputBuffer);
var
  b, OuterLimit: Cardinal;
  InPtr, InnerLimit: ^Byte;
  OutPtr: PByte4;
begin
  if InputByteCount = 0 then
    Exit;
  InPtr := @InputBuffer;
  OutPtr := @OutputBuffer;

  InnerLimit := InPtr;
  Inc(Cardinal(InnerLimit), MIME_DECODED_LINE_BREAK);

  OuterLimit := Cardinal(InPtr);
  Inc(OuterLimit, InputByteCount);

  while Cardinal(InnerLimit) <= OuterLimit do
  begin

    while InPtr <> InnerLimit do
    begin
      b := InPtr^;
      b := b shl 8;
      Inc(InPtr);
      b := b or InPtr^;
      b := b shl 8;
      Inc(InPtr);
      b := b or InPtr^;
      Inc(InPtr);
      OutPtr^.b4 := MIME_ENCODE_TABLE[b and $3F];
      b := b shr 6;
      OutPtr^.b3 := MIME_ENCODE_TABLE[b and $3F];
      b := b shr 6;
      OutPtr^.b2 := MIME_ENCODE_TABLE[b and $3F];
      b := b shr 6;
      OutPtr^.b1 := MIME_ENCODE_TABLE[b];
      Inc(OutPtr);
    end;
    OutPtr^.b1 := 13;
    OutPtr^.b2 := 10;
    Inc(Cardinal(OutPtr), 2);

    Inc(InnerLimit, MIME_DECODED_LINE_BREAK);
  end;

end;

procedure MimeEncodeNoCRLF(const InputBuffer; const InputByteCount: Cardinal; out OutputBuffer);
var
  b, OuterLimit: Cardinal;
  InPtr, InnerLimit: ^Byte;
  OutPtr: PByte4;
begin
  if InputByteCount = 0 then
    Exit;
  InPtr := @InputBuffer;
  OutPtr := @OutputBuffer;

  OuterLimit := InputByteCount div 3 * 3;

  InnerLimit := @InputBuffer;
  Inc(Cardinal(InnerLimit), OuterLimit);
  while InPtr <> InnerLimit do
  begin
    b := InPtr^;
    b := b shl 8;
    Inc(InPtr);
    b := b or InPtr^;
    b := b shl 8;
    Inc(InPtr);
    b := b or InPtr^;
    Inc(InPtr);
    OutPtr^.b4 := MIME_ENCODE_TABLE[b and $3F];
    b := b shr 6;
    OutPtr^.b3 := MIME_ENCODE_TABLE[b and $3F];
    b := b shr 6;
    OutPtr^.b2 := MIME_ENCODE_TABLE[b and $3F];
    b := b shr 6;
    OutPtr^.b1 := MIME_ENCODE_TABLE[b];
    Inc(OutPtr);
  end;
  case InputByteCount - OuterLimit of
    1:
      begin
        b := InPtr^;
        b := b shl 4;
        OutPtr.b2 := MIME_ENCODE_TABLE[b and $3F];
        b := b shr 6;
        OutPtr.b1 := MIME_ENCODE_TABLE[b];
        OutPtr.b3 := MIME_PAD_CHAR;
        OutPtr.b4 := MIME_PAD_CHAR;
      end;
    2:
      begin
        b := InPtr^;
        Inc(InPtr);
        b := b shl 8;
        b := b or InPtr^;
        b := b shl 2;
        OutPtr.b3 := MIME_ENCODE_TABLE[b and $3F];
        b := b shr 6;
        OutPtr.b2 := MIME_ENCODE_TABLE[b and $3F];
        b := b shr 6;
        OutPtr.b1 := MIME_ENCODE_TABLE[b];
        OutPtr.b4 := MIME_PAD_CHAR; { Pad remaining byte. }
      end;
  end;
end;

function MimeDecode(const InputBuffer; const InputBytesCount: Cardinal;
  out OutputBuffer): Cardinal;
var
  ByteBuffer, ByteBufferSpace: Cardinal;
begin
  ByteBuffer := 0;
  ByteBufferSpace := 4;
  Result := MimeDecodePartial(InputBuffer, InputBytesCount,
    OutputBuffer, ByteBuffer, ByteBufferSpace);
  Inc(Result, MimeDecodePartialEnd(Pointer(Cardinal(@OutputBuffer) + Result)^,
    ByteBuffer, ByteBufferSpace));
end;

function MimeDecodePartial(const InputBuffer; const InputBytesCount: Cardinal;
  out OutputBuffer; var ByteBuffer: Cardinal; var ByteBufferSpace: Cardinal): Cardinal;
var
  lByteBuffer, lByteBufferSpace, c: Cardinal;
  InPtr, OuterLimit: ^Byte;
  OutPtr: PByte3;
begin
  if InputBytesCount > 0 then
  begin
    InPtr := @InputBuffer;
    Cardinal(OuterLimit) := Cardinal(InPtr) + InputBytesCount;
    OutPtr := @OutputBuffer;
    lByteBuffer := ByteBuffer;
    lByteBufferSpace := ByteBufferSpace;
    while InPtr <> OuterLimit do
    begin
      c := MIME_DECODE_TABLE[InPtr^];
      Inc(InPtr);
      if c = $FF then
        Continue;
      lByteBuffer := lByteBuffer shl 6;
      lByteBuffer := lByteBuffer or c;
      Dec(lByteBufferSpace);
      if lByteBufferSpace <> 0 then
        Continue;
      OutPtr^.b3 := Byte(lByteBuffer);
      lByteBuffer := lByteBuffer shr 8;
      OutPtr^.b2 := Byte(lByteBuffer);
      lByteBuffer := lByteBuffer shr 8;
      OutPtr^.b1 := Byte(lByteBuffer);
      lByteBuffer := 0;
      Inc(OutPtr);
      lByteBufferSpace := 4;
    end;
    ByteBuffer := lByteBuffer;
    ByteBufferSpace := lByteBufferSpace;
    Result := Cardinal(OutPtr) - Cardinal(@OutputBuffer);
  end
  else
    Result := 0;
end;

function MimeDecodePartialEnd(out OutputBuffer; const ByteBuffer: Cardinal;
  const ByteBufferSpace: Cardinal): Cardinal;
var
  lByteBuffer: Cardinal;
begin
  case ByteBufferSpace of
    1:
      begin
        lByteBuffer := ByteBuffer shr 2;
        PByte3(@OutputBuffer)^.b2 := Byte(lByteBuffer);
        lByteBuffer := lByteBuffer shr 8;
        PByte3(@OutputBuffer)^.b1 := Byte(lByteBuffer);
        Result := 2;
      end;
    2:
      begin
        lByteBuffer := ByteBuffer shr 4;
        PByte3(@OutputBuffer)^.b1 := Byte(lByteBuffer);
        Result := 1;
      end;
  else
    Result := 0;
  end;
end;

procedure Base64Encode(InputFile, OutputFile: string);
var
  Ms: TMemoryStream;
  Ss: TStringStream;
  Str: string;
  List: TStringList;
begin {Base64 encode}
  Ms := TMemoryStream.Create;
  try
    Ms.LoadFromFile(InputFile);
    Ss := TStringStream.Create(Str);
    try
      MimeEncodeStream(Ms, Ss);
      List := TStringList.Create;
      try
        List.Text := Ss.DataString;
        List.SaveToFile(OutputFile);
      finally
        List.Free;
      end;
    finally
      Ss.Free;
    end;
  finally
    Ms.Free;
  end;
end;

procedure Base64Decode(InputFile, OutputFile: string);
var
  Ms: TMemoryStream;
  Ss: TStringStream;
  List: TStringList;
begin {Base64 decode}
  List := TStringList.Create;
  try
    List.LoadFromFile(InputFile);
    Ss := TStringStream.Create(List.Text);
    try
      Ms := TMemoryStream.Create;
      try
        MimeDecodeStream(Ss, Ms);
        Ms.SaveToFile(OutputFile);
      finally
        Ms.Free;
      end;
    finally
      Ss.Free;
    end;
  finally
    List.Free;
  end;
end;
//......................Base64 End

//......................Des Start

procedure initPermutation(var inData: array of Byte);
var
  newData: array[0..7] of Byte;
  i: Integer;
begin
  FillChar(newData, 8, 0);
  for i := 0 to 63 do
    if (inData[BitIP[i] shr 3] and (1 shl (7 - (BitIP[i] and $07)))) <> 0 then
      newData[i shr 3] := newData[i shr 3] or (1 shl (7 - (i and $07)));
  for i := 0 to 7 do
    inData[i] := newData[i];
end;

procedure conversePermutation(var inData: array of Byte);
var
  newData: array[0..7] of Byte;
  i: Integer;
begin
  FillChar(newData, 8, 0);
  for i := 0 to 63 do
    if (inData[BitCP[i] shr 3] and (1 shl (7 - (BitCP[i] and $07)))) <> 0 then
      newData[i shr 3] := newData[i shr 3] or (1 shl (7 - (i and $07)));
  for i := 0 to 7 do
    inData[i] := newData[i];
end;

procedure expand(inData: array of Byte; var outData: array of Byte);
var
  i: Integer;
begin
  FillChar(outData, 6, 0);
  for i := 0 to 47 do
    if (inData[BitExp[i] shr 3] and (1 shl (7 - (BitExp[i] and $07)))) <> 0 then
      outData[i shr 3] := outData[i shr 3] or (1 shl (7 - (i and $07)));
end;

procedure permutation(var inData: array of Byte);
var
  newData: array[0..3] of Byte;
  i: Integer;
begin
  FillChar(newData, 4, 0);
  for i := 0 to 31 do
    if (inData[BitPM[i] shr 3] and (1 shl (7 - (BitPM[i] and $07)))) <> 0 then
      newData[i shr 3] := newData[i shr 3] or (1 shl (7 - (i and $07)));
  for i := 0 to 3 do
    inData[i] := newData[i];
end;

function si(s, inByte: Byte): Byte;
var
  c: Byte;
begin
  c := (inByte and $20) or ((inByte and $1E) shr 1) or
    ((inByte and $01) shl 4);
  Result := (sBox[s][c] and $0F);
end;

procedure permutationChoose1(inData: array of Byte;
  var outData: array of Byte);
var
  i: Integer;
begin
  FillChar(outData, 7, 0);
  for i := 0 to 55 do
    if (inData[BitPMC1[i] shr 3] and (1 shl (7 - (BitPMC1[i] and $07)))) <> 0 then
      outData[i shr 3] := outData[i shr 3] or (1 shl (7 - (i and $07)));
end;

procedure permutationChoose2(inData: array of Byte;
  var outData: array of Byte);
var
  i: Integer;
begin
  FillChar(outData, 6, 0);
  for i := 0 to 47 do
    if (inData[BitPMC2[i] shr 3] and (1 shl (7 - (BitPMC2[i] and $07)))) <> 0 then
      outData[i shr 3] := outData[i shr 3] or (1 shl (7 - (i and $07)));
end;

procedure cycleMove(var inData: array of Byte; bitMove: Byte);
var
  i: Integer;
begin
  for i := 0 to bitMove - 1 do
  begin
    inData[0] := (inData[0] shl 1) or (inData[1] shr 7);
    inData[1] := (inData[1] shl 1) or (inData[2] shr 7);
    inData[2] := (inData[2] shl 1) or (inData[3] shr 7);
    inData[3] := (inData[3] shl 1) or ((inData[0] and $10) shr 4);
    inData[0] := (inData[0] and $0F);
  end;
end;

procedure makeKey(inKey: array of Byte; var outKey: array of TKeyByte);
const
  bitDisplace: array[0..15] of Byte =
  (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1);
var
  outData56: array[0..6] of Byte;
  key28l: array[0..3] of Byte;
  key28r: array[0..3] of Byte;
  key56o: array[0..6] of Byte;
  i: Integer;
begin
  permutationChoose1(inKey, outData56);

  key28l[0] := outData56[0] shr 4;
  key28l[1] := (outData56[0] shl 4) or (outData56[1] shr 4);
  key28l[2] := (outData56[1] shl 4) or (outData56[2] shr 4);
  key28l[3] := (outData56[2] shl 4) or (outData56[3] shr 4);
  key28r[0] := outData56[3] and $0F;
  key28r[1] := outData56[4];
  key28r[2] := outData56[5];
  key28r[3] := outData56[6];

  for i := 0 to 15 do
  begin
    cycleMove(key28l, bitDisplace[i]);
    cycleMove(key28r, bitDisplace[i]);
    key56o[0] := (key28l[0] shl 4) or (key28l[1] shr 4);
    key56o[1] := (key28l[1] shl 4) or (key28l[2] shr 4);
    key56o[2] := (key28l[2] shl 4) or (key28l[3] shr 4);
    key56o[3] := (key28l[3] shl 4) or (key28r[0]);
    key56o[4] := key28r[1];
    key56o[5] := key28r[2];
    key56o[6] := key28r[3];
    permutationChoose2(key56o, outKey[i]);
  end;
end;

procedure encry(inData, subKey: array of Byte;
  var outData: array of Byte);
var
  outBuf: array[0..5] of Byte;
  buf: array[0..7] of Byte;
  i: Integer;
begin
  expand(inData, outBuf);
  for i := 0 to 5 do
    outBuf[i] := outBuf[i] xor subKey[i];
  buf[0] := outBuf[0] shr 2;
  buf[1] := ((outBuf[0] and $03) shl 4) or (outBuf[1] shr 4);
  buf[2] := ((outBuf[1] and $0F) shl 2) or (outBuf[2] shr 6);
  buf[3] := outBuf[2] and $3F;
  buf[4] := outBuf[3] shr 2;
  buf[5] := ((outBuf[3] and $03) shl 4) or (outBuf[4] shr 4);
  buf[6] := ((outBuf[4] and $0F) shl 2) or (outBuf[5] shr 6);
  buf[7] := outBuf[5] and $3F;
  for i := 0 to 7 do
    buf[i] := si(i, buf[i]);
  for i := 0 to 3 do
    outBuf[i] := (buf[i * 2] shl 4) or buf[i * 2 + 1];
  permutation(outBuf);
  for i := 0 to 3 do
    outData[i] := outBuf[i];
end;

procedure desData(desMode: TDesMode;
  inData: array of Byte; var outData: array of Byte);
// inData, outData 都为8Bytes，否则出错
var
  i, j: Integer;
  temp, buf: array[0..3] of Byte;
begin
  for i := 0 to 7 do
    outData[i] := inData[i];
  initPermutation(outData);
  if desMode = dmEncry then
  begin
    for i := 0 to 15 do
    begin
      for j := 0 to 3 do
        temp[j] := outData[j]; //temp = Ln
      for j := 0 to 3 do
        outData[j] := outData[j + 4]; //Ln+1 = Rn
      encry(outData, subKey[i], buf); //Rn ==Kn==> buf
      for j := 0 to 3 do
        outData[j + 4] := temp[j] xor buf[j]; //Rn+1 = Ln^buf
    end;

    for j := 0 to 3 do
      temp[j] := outData[j + 4];
    for j := 0 to 3 do
      outData[j + 4] := outData[j];
    for j := 0 to 3 do
      outData[j] := temp[j];
  end
  else
    if desMode = dmDecry then
    begin
      for i := 15 downto 0 do
      begin
        for j := 0 to 3 do
          temp[j] := outData[j];
        for j := 0 to 3 do
          outData[j] := outData[j + 4];
        encry(outData, subKey[i], buf);
        for j := 0 to 3 do
          outData[j + 4] := temp[j] xor buf[j];
      end;
      for j := 0 to 3 do
        temp[j] := outData[j + 4];
      for j := 0 to 3 do
        outData[j + 4] := outData[j];
      for j := 0 to 3 do
        outData[j] := temp[j];
    end;
  conversePermutation(outData);
end;

//////////////////////////////////////////////////////////////

function EncryStr(Str, Key: string): string;
var
  StrByte, OutByte, KeyByte: array[0..7] of Byte;
  StrResult: string;
  I, J: Integer;
begin
  if (Length(Str) > 0) and (Ord(Str[Length(Str)]) = 0) then
    raise Exception.Create('Error: the last char is NULL char.');
  if Length(Key) < 8 then
    while Length(Key) < 8 do
      Key := Key + Chr(0);
  while Length(Str) mod 8 <> 0 do
    Str := Str + Chr(0);

  for J := 0 to 7 do
    KeyByte[J] := Ord(Key[J + 1]);
  makeKey(keyByte, subKey);

  StrResult := '';

  for I := 0 to Length(Str) div 8 - 1 do
  begin
    for J := 0 to 7 do
      StrByte[J] := Ord(Str[I * 8 + J + 1]);
    desData(dmEncry, StrByte, OutByte);
    for J := 0 to 7 do
      StrResult := StrResult + Chr(OutByte[J]);
  end;

  Result := StrResult;
end;

function DecryStr(Str, Key: string): string;
var
  StrByte, OutByte, KeyByte: array[0..7] of Byte;
  StrResult: string;
  I, J: Integer;
begin
  if Length(Key) < 8 then
    while Length(Key) < 8 do
      Key := Key + Chr(0);

  for J := 0 to 7 do
    KeyByte[J] := Ord(Key[J + 1]);
  makeKey(keyByte, subKey);

  StrResult := '';

  for I := 0 to Length(Str) div 8 - 1 do
  begin
    for J := 0 to 7 do
      StrByte[J] := Ord(Str[I * 8 + J + 1]);
    desData(dmDecry, StrByte, OutByte);
    for J := 0 to 7 do
      StrResult := StrResult + Chr(OutByte[J]);
  end;
  while (Length(StrResult) > 0) and
    (Ord(StrResult[Length(StrResult)]) = 0) do
    Delete(StrResult, Length(StrResult), 1);
  Result := StrResult;
end;

///////////////////////////////////////////////////////////

function EncryStrHex(Str, Key: string): string;
var
  StrResult, TempResult, Temp: string;
  I: Integer;
begin
  TempResult := EncryStr(Str, Key);
  StrResult := '';
  for I := 0 to Length(TempResult) - 1 do
  begin
    Temp := Format('%x', [Ord(TempResult[I + 1])]);
    if Length(Temp) = 1 then
      Temp := '0' + Temp;
    StrResult := StrResult + Temp;
  end;
  Result := StrResult;
end;

function DecryStrHex(StrHex, Key: string): string;
  function HexToInt(Hex: string): Integer;
  var
    I, Res: Integer;
    ch: Char;
  begin
    Res := 0;
    for I := 0 to Length(Hex) - 1 do
    begin
      ch := Hex[I + 1];
      if (ch >= '0') and (ch <= '9') then
        Res := Res * 16 + Ord(ch) - Ord('0')
      else
        if (ch >= 'A') and (ch <= 'F') then
          Res := Res * 16 + Ord(ch) - Ord('A') + 10
        else
          if (ch >= 'a') and (ch <= 'f') then
            Res := Res * 16 + Ord(ch) - Ord('a') + 10
          else
            raise Exception.Create('错误的加密文件...');
    end;
    Result := Res;
  end;

var
  Str, Temp: string;
  I: Integer;
begin
  Str := '';
  for I := 0 to Length(StrHex) div 2 - 1 do
  begin
    Temp := Copy(StrHex, I * 2 + 1, 2);
    Str := Str + Chr(HexToInt(Temp));
  end;
  Result := DecryStr(Str, Key);
end;
//.....................Des End

function My_Encode(Str, Key: string): string;
begin
  Result := EncryStrhex(MimeEncodeString(str), key); //加密
end;

function My_Decode(str, Key: string): string;
begin
  result := MimeDecodeString(DecryStrHex(str, key)); //解密
end;

end.
