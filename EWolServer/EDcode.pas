unit EDcode;

interface

uses
  Windows, SysUtils, {Classes, Hutil32,} Grobal2, M2Share;
const
  OLDMODE = 0; //老版本编码
  NEWMODE = 1; //新版本编码
  ENDECODEMODE = OLDMODE;
function EncodeMessage(smsg: TDefaultMessage): string;
function DecodeMessage(str: string): TDefaultMessage;
function EncodeString(str: string): string;
function DecodeString(str: string): string;
function DecodeStringmir(str: string): string;
function EncodeBuffer(buf: pChar; bufsize: integer): string;
procedure DecodeBuffer(src: string; buf: PChar; bufsize: integer);
procedure myDecodeBuffer(src: string; buf: PChar; bufsize: integer);
procedure Decode6BitBuf(sSource: PChar; pBuf: PChar; nSrcLen, nBufLen: integer);
procedure Encode6BitBuf(pSrc, pDest: PChar; nSrcLen, nDestLen: integer);
function MakeDefaultMsg(wIdent: Word; nRecog: Integer; wParam, wTag, wSeries: Word): TDefaultMessage;
function myEncodeString(str: string): string;
function myDecodeString(str: string): string;
function myMulencodeString(str: string; n: integer): string;
function myMuldecodeString(str: string; n: integer): string;
function myEncode(pIn: pChar; pOut: pChar; Size: word): word;
function myDecode(pIn: string; pOut: pChar; Size: word): word;
   //var
//  CSEncode: TRTLCriticalSection;

implementation
var
  n4CEEF4: Integer = $408D4D;
  n4CEEF8: Integer = $0C08BA52E;
  w4CEF00: Word = $8D34;


  DecodeBitMasks: array[0..255] of Byte = (
    $2A, $E7, $18, $6F, $63, $9D, $48, $EA, $39, $CD, $38, $B8, $A0, $AB, $E0, $10,
    $35, $99, $37, $09, $C0, $69, $B2, $A4, $67, $88, $50, $34, $7F, $FC, $0B, $BE,
    $0C, $44, $59, $B6, $5B, $9C, $65, $D6, $94, $EB, $C4, $3B, $03, $3C, $C9, $3E,
    $6B, $9A, $D4, $F6, $C3, $4D, $11, $24, $AA, $FF, $4A, $ED, $95, $93, $D9, $46,
    $5F, $96, $87, $30, $BA, $CA, $CB, $FA, $8A, $1A, $68, $5C, $AC, $07, $40, $60,
    $29, $70, $57, $53, $41, $12, $DE, $1D, $64, $14, $97, $72, $FB, $8D, $2B, $08,
    $CF, $F4, $3A, $00, $C5, $91, $56, $A9, $9E, $71, $BC, $A3, $AF, $A6, $55, $DA,
    $79, $BB, $33, $A5, $25, $15, $7D, $EE, $C1, $2C, $C7, $D0, $19, $D8, $5A, $E8,
    $85, $FD, $2F, $6A, $78, $45, $DB, $B5, $F5, $1E, $04, $75, $B0, $7A, $20, $F2,
    $DF, $D3, $83, $F3, $54, $90, $A2, $C6, $0F, $80, $36, $4E, $C8, $01, $82, $76,
    $A1, $2E, $84, $86, $0E, $47, $8F, $E1, $F9, $7C, $C2, $74, $DC, $26, $22, $CE,
    $2D, $4F, $BF, $0D, $73, $27, $21, $B3, $98, $1F, $89, $EC, $FE, $52, $0A, $8C,
    $9F, $A8, $E5, $E6, $06, $8B, $CC, $F7, $5E, $E3, $7B, $D2, $05, $49, $13, $E9,
    $66, $B7, $AD, $B4, $F8, $A7, $1C, $F1, $02, $7E, $6E, $17, $62, $4C, $77, $8E,
    $DD, $F0, $43, $28, $6D, $61, $B9, $D7, $BD, $3D, $9B, $92, $16, $EF, $51, $23,
    $E2, $B1, $81, $31, $32, $58, $D1, $5D, $D5, $6C, $4B, $E4, $AE, $42, $1B, $3F
    );

  n4CEEFC: Integer = $408D97;

  EncodeBitMasks: array[0..255] of Byte = (
    $8C, $87, $0D, $85, $D4, $64, $63, $E5, $BA, $7E, $B8, $68, $9D, $9F, $F5, $BC,
    $A0, $E3, $3A, $22, $19, $21, $39, $78, $EE, $27, $36, $15, $74, $C7, $97, $C9,
    $CE, $E2, $7B, $4C, $98, $A1, $C2, $59, $41, $C0, $1E, $2E, $95, $EB, $DE, $69,
    $1D, $5B, $53, $DA, $F4, $0A, $4F, $BB, $B7, $24, $33, $0F, $C8, $84, $29, $89,
    $3C, $1C, $08, $49, $C6, $FE, $CC, $23, $3E, $E1, $4E, $8B, $13, $E7, $1A, $5D,
    $CF, $B1, $47, $8F, $D8, $72, $4B, $93, $6E, $73, $4D, $94, $DD, $82, $14, $A7,
    $03, $F9, $F1, $C5, $8D, $79, $2A, $C4, $DC, $60, $5F, $D7, $62, $B5, $E9, $B3,
    $B6, $12, $A8, $32, $D9, $C3, $6A, $75, $4A, $A2, $0C, $26, $91, $5A, $AD, $6D,
    $44, $10, $B4, $46, $1B, $66, $81, $20, $FD, $7F, $88, $25, $9C, $71, $D3, $E6,
    $80, $E4, $FA, $42, $9B, $37, $01, $FC, $DB, $45, $6B, $FB, $56, $F0, $AF, $9A,
    $BF, $AB, $D6, $CD, $02, $F2, $7C, $AA, $B2, $92, $FF, $57, $2F, $86, $A6, $7D,
    $35, $17, $34, $D5, $0E, $65, $09, $05, $28, $CA, $48, $31, $8E, $2D, $DF, $52,
    $F6, $1F, $A4, $50, $76, $40, $18, $04, $8A, $16, $2B, $AE, $43, $3F, $D0, $CB,
    $6C, $55, $54, $96, $99, $30, $67, $5E, $2C, $AC, $E0, $7A, $E8, $58, $90, $BE,
    $A5, $6F, $B0, $70, $EC, $61, $5C, $06, $3B, $77, $C1, $07, $EA, $A9, $F8, $11,
    $BD, $F3, $00, $ED, $83, $EF, $3D, $A3, $51, $9E, $38, $F7, $0B, $B9, $D2, $D1
    );
//var
//  EncBuf,TempBuf:PChar;

function MakeDefaultMsg(wIdent: Word; nRecog: Integer; wParam, wTag, wSeries: Word): TDefaultMessage;
begin
  Result.Recog := nRecog;
  Result.Ident := wIdent;
  Result.Param := wParam;
  Result.Tag := wTag;
  Result.Series := wSeries;
end;
{
procedure Encode6BitBuf (pSrc,pDest:PChar;nSrcLen,nDestLen: integer);
var
  Proc:procedure (pSrc,pDest:PChar;nSrcLen,nDestLen: integer);
begin
  Proc:=Pointer(g_Config.Encode6BitBuf);
  Proc(pSrc,pDest,nSrcLen,nDestLen);
end;
}

function CSDecode(pIn: string; pOut: pChar; Size: word): word;
var
  b1, b2, b3: byte;
  c1, c2, c3, c4: byte;
  i, oPtr: word;
  x, y: word;
begin
  //  i := 0;
  oPtr := 0;
  x := Length(pIn) div 4;
  if Length(pIn) > 3 then
    for i := 0 to x - 1 do
    begin
      c1 := ord(pIn[i * 4 + 1]) - $3B;
      c2 := ord(pIn[i * 4 + 2]) - $3B;
      c3 := ord(pIn[i * 4 + 3]) - $3B;
      c4 := ord(pIn[i * 4 + 4]) - $3B;
      b1 := (c1 and $FC) shl 2; //11111100->11110000
      b2 := (c1 and 3); //00000011
      b3 := c4 and $C; //00001100
      pOut[oPtr] := chr((b1 or b2 or b3) xor $EB);
      inc(oPtr);
      b1 := (c2 and $FC) shl 2; //11111100->11110000
      b2 := (c2 and 3); //00000011
      b3 := (c4 and 3) shl 2; //00000011  ->00001100
      pOut[oPtr] := chr((b1 or b2 or b3) xor $EB);
      inc(oPtr);
      b1 := (c4 and $30) shl 2; //00110000->11000000
      pOut[oPtr] := chr((c3 or b1) xor $EB);
      inc(oPtr);
    end;
  y := Length(pIn) mod 4;
  if y = 2 then
  begin
    c1 := ord(pIn[x * 4 + 1]) - $3B;
    c2 := ord(pIn[x * 4 + 2]) - $3B;

    b1 := (c1 and $FC) shl 2; //11111100->11110000
    b2 := (c1 and 3); //00000011
    b3 := (c2 and 3) shl 2; //00000011->00001100
    pOut[oPtr] := chr((b1 or b2 or b3) xor $EB);
    inc(oPtr);
  end;
  if y = 3 then
  begin
    c1 := ord(pIn[x * 4 + 1]) - $3B;
    c2 := ord(pIn[x * 4 + 2]) - $3B;

    c4 := ord(pIn[x * 4 + 3]) - $3B;

    b1 := (c1 and $FC) shl 2; //11111100->11110000
    b2 := (c1 and 3); //00000011
    b3 := c4 and $C; //00001100
    pOut[oPtr] := chr((b1 or b2 or b3) xor $EB);
    inc(oPtr);

    b1 := (c2 and $FC) shl 2; //11111100->11110000
    b2 := (c2 and 3); //00000011
    b3 := (c4 and 3) shl 2; //00000011  ->00001100
    pOut[oPtr] := chr((b1 or b2 or b3) xor $EB);
    inc(oPtr);

  end;
  pOut[oPtr] := chr(0);
  result := oPtr;

end;
//封包加密

function CSEncode(pIn: pChar; pOut: pChar; Size: word): word;
var
  b1, bcal: byte;
  bflag1, bflag2: byte;
  i, iPtr, oPtr: word;
begin
  //  b1 := 0;
  //  bcal := 0;
  //  bflag1 := 0;
  bflag2 := 0;
  i := 0;
  iPtr := 0;
  oPtr := 0;
  while iPtr < Size do
  begin
    b1 := ord(pIn[iPtr]) xor $EB;
    inc(iPtr);
    if i < 2 then
    begin
      bcal := b1;
      bcal := bcal shr 2;
      bflag1 := bcal;
      bcal := bcal and $3C;
      b1 := b1 and 3;
      bcal := bcal or b1;
      bcal := bcal + $3B;
      pOut[oPtr] := chr(bcal);
      inc(oPtr);
      bflag2 := (bflag1 and 3) or (bflag2 shl 2);
    end
    else
    begin
      bcal := b1;
      bcal := bcal and $3F;
      bcal := bcal + $3B;
      pOut[oPtr] := chr(bcal);
      inc(oPtr);
      b1 := b1 shr 2;
      b1 := b1 and $30;
      b1 := b1 or bflag2;
      b1 := b1 + $3B;
      pOut[oPtr] := chr(b1);
      inc(oPtr);
      bflag2 := 0;
    end;
    inc(i);
    i := i mod 3;
  end;
  pOut[oPtr] := chr(0);
  if i <> 0 then
  begin
    pOut[oPtr] := chr(bflag2 + $3B);
    inc(oPtr);
    pOut[oPtr] := chr(0);
  end;
  result := oPtr;
end;


function myDecode(pIn: string; pOut: pChar; Size: word): word;
var
  b1, b2, b3: byte;
  c1, c2, c3, c4: byte;
  i, oPtr: word;
  x, y: word;
begin
  //  i := 0;
  oPtr := 0;
  x := Length(pIn) div 4;
  if Length(pIn) > 3 then
    for i := 0 to x - 1 do
    begin
      c1 := ord(pIn[i * 4 + 1]) - $2B;
      c2 := ord(pIn[i * 4 + 2]) - $2B;
      c3 := ord(pIn[i * 4 + 3]) - $2B;
      c4 := ord(pIn[i * 4 + 4]) - $2B;
      b1 := (c1 and $FC) shl 2; //11111100->11110000
      b2 := (c1 and 3); //00000011
      b3 := c4 and $C; //00001100
      pOut[oPtr] := chr((b1 or b2 or b3) xor $BB);
      inc(oPtr);
      b1 := (c2 and $FC) shl 2; //11111100->11110000
      b2 := (c2 and 3); //00000011
      b3 := (c4 and 3) shl 2; //00000011  ->00001100
      pOut[oPtr] := chr((b1 or b2 or b3) xor $BB);
      inc(oPtr);
      b1 := (c4 and $30) shl 2; //00110000->11000000
      pOut[oPtr] := chr((c3 or b1) xor $BB);
      inc(oPtr);
    end;
  y := Length(pIn) mod 4;
  if y = 2 then
  begin
    c1 := ord(pIn[x * 4 + 1]) - $2B;
    c2 := ord(pIn[x * 4 + 2]) - $2B;

    b1 := (c1 and $FC) shl 2; //11111100->11110000
    b2 := (c1 and 3); //00000011
    b3 := (c2 and 3) shl 2; //00000011->00001100
    pOut[oPtr] := chr((b1 or b2 or b3) xor $BB);
    inc(oPtr);
  end;
  if y = 3 then
  begin
    c1 := ord(pIn[x * 4 + 1]) - $2B;
    c2 := ord(pIn[x * 4 + 2]) - $2B;

    c4 := ord(pIn[x * 4 + 3]) - $2B;

    b1 := (c1 and $FC) shl 2; //11111100->11110000
    b2 := (c1 and 3); //00000011
    b3 := c4 and $C; //00001100
    pOut[oPtr] := chr((b1 or b2 or b3) xor $BB);
    inc(oPtr);

    b1 := (c2 and $FC) shl 2; //11111100->11110000
    b2 := (c2 and 3); //00000011
    b3 := (c4 and 3) shl 2; //00000011  ->00001100
    pOut[oPtr] := chr((b1 or b2 or b3) xor $BB);
    inc(oPtr);

  end;
  pOut[oPtr] := chr(0);
  result := oPtr;

end;
//封包加密

function myEncode(pIn: pChar; pOut: pChar; Size: word): word;
var
  b1, bcal: byte;
  bflag1, bflag2: byte;
  i, iPtr, oPtr: word;
begin
  //  b1 := 0;
  //  bcal := 0;
  //  bflag1 := 0;
  bflag2 := 0;
  i := 0;
  iPtr := 0;
  oPtr := 0;
  while iPtr < Size do
  begin
    b1 := ord(pIn[iPtr]) xor $BB;
    inc(iPtr);
    if i < 2 then
    begin
      bcal := b1;
      bcal := bcal shr 2;
      bflag1 := bcal;
      bcal := bcal and $3C;
      b1 := b1 and 3;
      bcal := bcal or b1;
      bcal := bcal + $2B;
      pOut[oPtr] := chr(bcal);
      inc(oPtr);
      bflag2 := (bflag1 and 3) or (bflag2 shl 2);
    end
    else
    begin
      bcal := b1;
      bcal := bcal and $3F;
      bcal := bcal + $2B;
      pOut[oPtr] := chr(bcal);
      inc(oPtr);
      b1 := b1 shr 2;
      b1 := b1 and $30;
      b1 := b1 or bflag2;
      b1 := b1 + $2B;
      pOut[oPtr] := chr(b1);
      inc(oPtr);
      bflag2 := 0;
    end;
    inc(i);
    i := i mod 3;
  end;
  pOut[oPtr] := chr(0);
  if i <> 0 then
  begin
    pOut[oPtr] := chr(bflag2 + $2B);
    inc(oPtr);
    pOut[oPtr] := chr(0);
  end;
  result := oPtr;
end;





         // function CSEncode(pIn: pChar; pOut: pChar; Size: word): word;

procedure Encode6BitBuf(pSrc, pDest: PChar; nSrcLen, nDestLen: integer);
begin
  CSEncode(pSrc, pDest, nSrcLen);
end;


procedure Encode6BitBufbak(pSrc, pDest: PChar; nSrcLen, nDestLen: integer);
var
  I: Integer;
  nRestCount: Integer;
  nDestPos: Integer;
  btMade: Byte;
  btCh: Byte;
  btRest: Byte;
begin
  nRestCount := 0;
  btRest := 0;
  nDestPos := 0;
  for i := 0 to nSrcLen - 1 do
  begin
    if nDestPos >= nDestLen then
      break;
    btCh := Byte(pSrc[i]);
{$IF ENDECODEMODE = NEWMODE}
    btCh := (EncodeBitMasks[btCh] xor n4CEEFC) xor n4CEEF4;
    btCh := btCh xor (HiByte(LoWord(n4CEEF8)) + LoByte(LoWord(n4CEEF8)));
{$IFEND}
    btMade := Byte((btRest or (btCh shr (2 + nRestCount))) and $3F);
    btRest := Byte(((btCh shl (8 - (2 + nRestCount))) shr 2) and $3F);
    Inc(nRestCount, 2);

    if nRestCount < 6 then
    begin
      pDest[nDestPos] := Char(btMade + $3C);
      Inc(nDestPos);
    end
    else
    begin
      if nDestPos < nDestLen - 1 then
      begin
        pDest[nDestPos] := Char(btMade + $3C);
        pDest[nDestPos + 1] := Char(btRest + $3C);
        Inc(nDestPos, 2);
      end
      else
      begin
        pDest[nDestPos] := Char(btMade + $3C);
        Inc(nDestPos);
      end;
      nRestCount := 0;
      btRest := 0;
    end;
  end;
  if nRestCount > 0 then
  begin
    pDest[nDestPos] := Char(btRest + $3C);
    Inc(nDestPos);
  end;
  pDest[nDestPos] := #0;
end;

{
procedure Decode6BitBuf (sSource:PChar;pBuf:PChar;nSrcLen,nBufLen:Integer);
var
  Proc:procedure (sSource:PChar;pBuf:PChar;nSrcLen,nBufLen:Integer);
begin
  Proc:=Pointer(g_Config.Encode6BitBuf);
  if assigned(Proc) then
    Proc(sSource,pBuf,nSrcLen,nBufLen);
end;
}


     //function CSDecode(pIn: string; pOut: pChar; Size: word): word;

procedure Decode6BitBuf(sSource: PChar; pBuf: PChar; nSrcLen, nBufLen: Integer);
begin
  CSDecode(strpas(sSource), pBuf, nSrclen);

end;

procedure myDecode6BitBuf(sSource: PChar; pBuf: PChar; nSrcLen, nBufLen: Integer);
begin
  myDecode(strpas(sSource), pBuf, nSrclen);

end;

procedure Decode6BitBufbak(sSource: PChar; pBuf: PChar; nSrcLen, nBufLen: Integer);
const
  Masks: array[2..6] of byte = ($FC, $F8, $F0, $E0, $C0);
   //($FE, $FC, $F8, $F0, $E0, $C0, $80, $00);
var
  I, {nLen,} nBitPos, nMadeBit, nBufPos: Integer;
  btCh, btTmp, btByte: Byte;
begin
//  nLen:= Length (sSource);
  nBitPos := 2;
  nMadeBit := 0;
  nBufPos := 0;
  btTmp := 0;
  for I := 0 to nSrcLen - 1 do
  begin
    if Integer(sSource[I]) - $3C >= 0 then
      btCh := Byte(sSource[I]) - $3C
    else
    begin
      nBufPos := 0;
      break;
    end;
    if nBufPos >= nBufLen then
      break;
    if (nMadeBit + 6) >= 8 then
    begin
      btByte := Byte(btTmp or ((btCh and $3F) shr (6 - nBitPos)));
{$IF ENDECODEMODE = NEWMODE}
      btByte := btByte xor (HiByte(LoWord(n4CEEF8)) + LoByte(LoWord(n4CEEF8)));
      btByte := btByte xor LoByte(LoWord(n4CEEF4));
      btByte := DecodeBitMasks[btByte] xor LoByte(w4CEF00);
{$IFEND}
      pBuf[nBufPos] := Char(btByte);
      Inc(nBufPos);
      nMadeBit := 0;
      if nBitPos < 6 then
        Inc(nBitPos, 2)
      else
      begin
        nBitPos := 2;
        continue;
      end;
    end;
    btTmp := Byte(Byte(btCh shl nBitPos) and Masks[nBitPos]); // #### ##--
    Inc(nMadeBit, 8 - nBitPos);
  end;
  pBuf[nBufPos] := #0;
end;





function DecodeMessage(str: string): TDefaultMessage;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
  Msg: TDefaultMessage;
begin
  Decode6BitBuf(PChar(str), @EncBuf, Length(str), SizeOf(EncBuf));
  Move(EncBuf, msg, sizeof(TDefaultMessage));
  Result := msg;


end;


function DecodeString(str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Decode6BitBuf(PChar(str), @EncBuf, Length(str), SizeOf(EncBuf));
  Result := StrPas(EncBuf);
end;

function DecodeStringmir(str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Decode6BitBufbak(PChar(str), @EncBuf, Length(str), SizeOf(EncBuf));
  Result := StrPas(EncBuf);
end;

procedure DecodeBuffer(src: string; buf: PChar; bufsize: integer);
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  if bufsize>BUFFERSIZE Then Exit;
   Decode6BitBuf(PChar(src), @EncBuf, Length(src), SizeOf(EncBuf));
  Move(EncBuf, buf^, bufsize);
end;

procedure myDecodeBuffer(src: string; buf: PChar; bufsize: integer);
var
  EncBuf: array[0..10000 - 1] of Char;
begin
  myDecode6BitBuf(PChar(src), @EncBuf, Length(src), SizeOf(EncBuf));
  Move(EncBuf, buf^, bufsize);
end;

function EncodeMessage(smsg: TDefaultMessage): string;
var
  EncBuf, TempBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Move(smsg, TempBuf, sizeof(TDefaultMessage));
  Encode6BitBuf(@TempBuf, @EncBuf, sizeof(TDefaultMessage), SizeOf(EncBuf));
  Result := StrPas(EncBuf);
end;


function EncodeString(str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  Encode6BitBuf(PChar(str), @EncBuf, Length(str), SizeOf(EncBuf));
  Result := StrPas(EncBuf);
end;


function EncodeBuffer(buf: pChar; bufsize: integer): string;
var
  EncBuf, TempBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  if bufsize < BUFFERSIZE then
  begin
    Move(buf^, TempBuf, bufsize);
    Encode6BitBuf(@TempBuf, @EncBuf, bufsize, SizeOf(EncBuf));
    Result := StrPas(EncBuf);
  end
  else
    Result := '';
end;

function myEncodeString(str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  myEncode(PChar(str), @EncBuf, Length(str));
  Result := StrPas(EncBuf);
end;

function myDecodeString(str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
 // Decode6BitBuf (PChar(str), @EncBuf,Length(str), SizeOf(EncBuf));
  myDecode(str, @EncBuf, Length(str));
  Result := StrPas(EncBuf);
end;

function myMulEncodeString(str: string; n: integer): string;
var
  i: integer;
  s: string;
begin
  s := str;
  for i := 0 to n do
    s := myencodestring(s);
  result := s;
end;

function myMuldecodeString(str: string; n: integer): string;
var
  i: integer;
  s: string;
begin
  s := str;
  for i := 0 to n do
    s := mydecodestring(s);
  result := s;
end;




initialization
  begin
//  GetMem (EncBuf, 10240 + 100); //BUFFERSIZE + 100);
//  GetMem (TempBuf, 10240); //2048);
//  InitializeCriticalSection (CSEncode);
  end;


finalization
  begin
//  FreeMem (EncBuf, BUFFERSIZE + 100);
//  FreeMem (TempBuf, 2048);
//  DeleteCriticalSection (CSEncode);
  end;
end.
