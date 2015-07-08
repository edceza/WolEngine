{******************************************************************************}
{* DCPcrypt v2.0 written by David Barton (davebarton@bigfoot.com) *************}
{******************************************************************************}
{* A binary compatible implementation of Rijndael *****************************}
{******************************************************************************}
{* Copyright (c) 1999-2000 David Barton                                       *}
{* Permission is hereby granted, free of charge, to any person obtaining a    *}
{* copy of this software and associated documentation files (the "Software"), *}
{* to deal in the Software without restriction, including without limitation  *}
{* the rights to use, copy, modify, merge, publish, distribute, sublicense,   *}
{* and/or sell copies of the Software, and to permit persons to whom the      *}
{* Software is furnished to do so, subject to the following conditions:       *}
{*                                                                            *}
{* The above copyright notice and this permission notice shall be included in *}
{* all copies or substantial portions of the Software.                        *}
{*                                                                            *}
{* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR *}
{* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   *}
{* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL    *}
{* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER *}
{* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    *}
{* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER        *}
{* DEALINGS IN THE SOFTWARE.                                                  *}
{******************************************************************************}
unit Function7;

interface
uses
  Classes, SysUtils, Const1, Const2;

const
  BC                                    = 4;
  MAXROUNDS                             = 14;

type
  TTopdelphi7 = class(TDCP_blockcipher)
  protected
    NUMROUNDS: Longint;
    rk, drk: array[0..MAXROUNDS, 0..7] of DWORD;
  public
    class function GetID: Longint; override;
    class function GetAlgorithm: string; override;
    class function GetMaxKeySize: Longint; override;
    class function GetBlockSize: Longint; override;
    class function SelfTest: boolean; override;
    procedure Init(const Key; Size: Longint; InitVector: Pointer); override;
    procedure Burn; override;
    procedure EncryptECB(const InData; var OutData); override;
    procedure DecryptECB(const InData; var OutData); override;
  end;


  {******************************************************************************}
  {******************************************************************************}
implementation
{$R-}{$Q-}
{$I cont7.Inc}

class function TTopdelphi7.GetMaxKeySize: Longint;
begin
  Result := 256;
end;

class function TTopdelphi7.GetBlockSize: Longint;
begin
  Result := 128;
end;

class function TTopdelphi7.GetID: Longint;
begin
  Result := DCP_rijndael;
end;

class function TTopdelphi7.GetAlgorithm: string;
begin
  Result := 'Rijndael';
end;

class function TTopdelphi7.SelfTest: boolean;
const
  Key1                                  : array[0..15] of Byte =
    ($00, $01, $02, $03, $05, $06, $07, $08, $0A, $0B, $0C, $0D, $0F, $10, $11,
      $12);
  InData1                               : array[0..15] of Byte =
    ($50, $68, $12, $A4, $5F, $08, $C8, $89, $B9, $7F, $59, $80, $03, $8B, $83,
      $59);
  OutData1                              : array[0..15] of Byte =
    ($D8, $F5, $32, $53, $82, $89, $EF, $7D, $06, $B5, $06, $A4, $FD, $5B, $E9,
      $C9);
  Key2                                  : array[0..23] of Byte =
    ($A0, $A1, $A2, $A3, $A5, $A6, $A7, $A8, $AA, $AB, $AC, $AD, $AF, $B0, $B1,
      $B2,
    $B4, $B5, $B6, $B7, $B9, $BA, $BB, $BC);
  InData2                               : array[0..15] of Byte =
    ($4F, $1C, $76, $9D, $1E, $5B, $05, $52, $C7, $EC, $A8, $4D, $EA, $26, $A5,
      $49);
  OutData2                              : array[0..15] of Byte =
    ($F3, $84, $72, $10, $D5, $39, $1E, $23, $60, $60, $8E, $5A, $CB, $56, $05,
      $81);
  Key3                                  : array[0..31] of Byte =
    ($00, $01, $02, $03, $05, $06, $07, $08, $0A, $0B, $0C, $0D, $0F, $10, $11,
      $12,
    $14, $15, $16, $17, $19, $1A, $1B, $1C, $1E, $1F, $20, $21, $23, $24, $25,
      $26);
  InData3                               : array[0..15] of Byte =
    ($5E, $25, $CA, $78, $F0, $DE, $55, $80, $25, $24, $D3, $8D, $A3, $FE, $44,
      $56);
  OutData3                              : array[0..15] of Byte =
    ($E8, $B7, $2B, $4E, $8B, $E2, $43, $43, $8C, $9F, $FF, $1F, $0E, $20, $58,
      $72);
var
  Block                                 : array[0..15] of Byte;
  Cipher                                : TTopdelphi7;
begin
  Cipher := TTopdelphi7.Create(nil);
  Cipher.Init(Key1, sizeof(Key1) * 8, nil);
  Cipher.EncryptECB(InData1, Block);
  Result := boolean(CompareMemory(@Block, @OutData1, 16));
  Cipher.DecryptECB(Block, Block);
  Cipher.Burn;
  Result := Result and boolean(CompareMemory(@Block, @InData1, 16));
  Cipher.Init(Key2, sizeof(Key2) * 8, nil);
  Cipher.EncryptECB(InData2, Block);
  Result := Result and boolean(CompareMemory(@Block, @OutData2, 16));
  Cipher.DecryptECB(Block, Block);
  Cipher.Burn;
  Result := Result and boolean(CompareMemory(@Block, @InData2, 16));
  Cipher.Init(Key3, sizeof(Key3) * 8, nil);
  Cipher.EncryptECB(InData3, Block);
  Result := Result and boolean(CompareMemory(@Block, @OutData3, 16));
  Cipher.DecryptECB(Block, Block);
  Cipher.Burn;
  Result := Result and boolean(CompareMemory(@Block, @InData3, 16));
  Cipher.Free;
end;

procedure InvMixColumn(a: PByteArray; BC: Byte);
var
  j                                     : Longint;
begin
  for j := 0 to (BC - 1) do
    PDWord(@(a^[j * 4]))^ := PDWord(@U1[a^[j * 4 + 0]])^ xor
      PDWord(@U2[a^[j * 4 + 1]])^ xor
      PDWord(@U3[a^[j * 4 + 2]])^ xor
      PDWord(@U4[a^[j * 4 + 3]])^;
end;

procedure TTopdelphi7.Init(const Key; Size: Longint; InitVector: Pointer);
var
  KC, rounds, j, r, t, rconpointer      : Longint;
  tk                                    : array[0..MAXKC - 1, 0..3] of Byte;
begin
  inherited Init(Key, Size, InitVector);
  Size := Size div 8;

  FillChar(tk, sizeof(tk), 0);
  Move(Key, tk, Size);
  if Size <= 16 then
  begin
    KC := 4;
    rounds := 10;
  end
  else if Size <= 24 then
  begin
    KC := 6;
    rounds := 12;
  end
  else
  begin
    KC := 8;
    rounds := 14;
  end;
  NUMROUNDS := rounds;
  r := 0;
  t := 0;
  j := 0;
  while (j < KC) and (r < (rounds + 1)) do
  begin
    while (j < KC) and (t < BC) do
    begin
      rk[r, t] := PDWord(@tk[j])^;
      Inc(j);
      Inc(t);
    end;
    if t = BC then
    begin
      t := 0;
      Inc(r);
    end;
  end;
  rconpointer := 0;
  while (r < (rounds + 1)) do
  begin
    tk[0, 0] := tk[0, 0] xor S[tk[KC - 1, 1]];
    tk[0, 1] := tk[0, 1] xor S[tk[KC - 1, 2]];
    tk[0, 2] := tk[0, 2] xor S[tk[KC - 1, 3]];
    tk[0, 3] := tk[0, 3] xor S[tk[KC - 1, 0]];
    tk[0, 0] := tk[0, 0] xor rcon[rconpointer];
    Inc(rconpointer);
    if KC <> 8 then
    begin
      for j := 1 to (KC - 1) do
        PDWord(@tk[j])^ := PDWord(@tk[j])^ xor PDWord(@tk[j - 1])^;
    end
    else
    begin
      for j := 1 to ((KC div 2) - 1) do
        PDWord(@tk[j])^ := PDWord(@tk[j])^ xor PDWord(@tk[j - 1])^;
      tk[KC div 2, 0] := tk[KC div 2, 0] xor S[tk[KC div 2 - 1, 0]];
      tk[KC div 2, 1] := tk[KC div 2, 1] xor S[tk[KC div 2 - 1, 1]];
      tk[KC div 2, 2] := tk[KC div 2, 2] xor S[tk[KC div 2 - 1, 2]];
      tk[KC div 2, 3] := tk[KC div 2, 3] xor S[tk[KC div 2 - 1, 3]];
      for j := ((KC div 2) + 1) to (KC - 1) do
        PDWord(@tk[j])^ := PDWord(@tk[j])^ xor PDWord(@tk[j - 1])^;
    end;
    j := 0;
    while (j < KC) and (r < (rounds + 1)) do
    begin
      while (j < KC) and (t < BC) do
      begin
        rk[r, t] := PDWord(@tk[j])^;
        Inc(j);
        Inc(t);
      end;
      if t = BC then
      begin
        Inc(r);
        t := 0;
      end;
    end;
  end;
  Move(rk, drk, sizeof(rk));
  for r := 1 to (NUMROUNDS - 1) do
    InvMixColumn(@drk[r], BC);

  { Generate a "random" IV }
  if InitVector = nil then
  begin
    FillChar(IV^, BS, 0);
    EncryptECB(IV^, IV^);
    Reset;
  end
  else
  begin
    Move(InitVector^, IV^, BS);
    Reset;
  end;
end;

procedure TTopdelphi7.Burn;
begin
  NUMROUNDS := 0;
  FillChar(rk, sizeof(rk), 0);
  FillChar(drk, sizeof(drk), 0);
  inherited Burn;
end;

procedure TTopdelphi7.EncryptECB(const InData; var OutData);
var
  r                                     : Longint;
  tempb                                 : array[0..MAXBC - 1, 0..3] of Byte;
  a                                     : array[0..MAXBC, 0..3] of Byte;
begin
  if not fInitialized then
    raise EDCP_blockcipher.Create('Cipher not initialized');
  PDWord(@a[0, 0])^ := PDWord(@InData)^;
  PDWord(@a[1, 0])^ := PDWord(DWORD(@InData) + 4)^;
  PDWord(@a[2, 0])^ := PDWord(DWORD(@InData) + 8)^;
  PDWord(@a[3, 0])^ := PDWord(DWORD(@InData) + 12)^;
  for r := 0 to (NUMROUNDS - 2) do
  begin
    PDWord(@tempb[0])^ := PDWord(@a[0])^ xor rk[r, 0];
    PDWord(@tempb[1])^ := PDWord(@a[1])^ xor rk[r, 1];
    PDWord(@tempb[2])^ := PDWord(@a[2])^ xor rk[r, 2];
    PDWord(@tempb[3])^ := PDWord(@a[3])^ xor rk[r, 3];
    PDWord(@a[0])^ := PDWord(@t1[tempb[0, 0]])^ xor
      PDWord(@t2[tempb[1, 1]])^ xor
      PDWord(@t3[tempb[2, 2]])^ xor
      PDWord(@T4[tempb[3, 3]])^;
    PDWord(@a[1])^ := PDWord(@t1[tempb[1, 0]])^ xor
      PDWord(@t2[tempb[2, 1]])^ xor
      PDWord(@t3[tempb[3, 2]])^ xor
      PDWord(@T4[tempb[0, 3]])^;
    PDWord(@a[2])^ := PDWord(@t1[tempb[2, 0]])^ xor
      PDWord(@t2[tempb[3, 1]])^ xor
      PDWord(@t3[tempb[0, 2]])^ xor
      PDWord(@T4[tempb[1, 3]])^;
    PDWord(@a[3])^ := PDWord(@t1[tempb[3, 0]])^ xor
      PDWord(@t2[tempb[0, 1]])^ xor
      PDWord(@t3[tempb[1, 2]])^ xor
      PDWord(@T4[tempb[2, 3]])^;
  end;
  PDWord(@tempb[0])^ := PDWord(@a[0])^ xor rk[NUMROUNDS - 1, 0];
  PDWord(@tempb[1])^ := PDWord(@a[1])^ xor rk[NUMROUNDS - 1, 1];
  PDWord(@tempb[2])^ := PDWord(@a[2])^ xor rk[NUMROUNDS - 1, 2];
  PDWord(@tempb[3])^ := PDWord(@a[3])^ xor rk[NUMROUNDS - 1, 3];
  a[0, 0] := t1[tempb[0, 0], 1];
  a[0, 1] := t1[tempb[1, 1], 1];
  a[0, 2] := t1[tempb[2, 2], 1];
  a[0, 3] := t1[tempb[3, 3], 1];
  a[1, 0] := t1[tempb[1, 0], 1];
  a[1, 1] := t1[tempb[2, 1], 1];
  a[1, 2] := t1[tempb[3, 2], 1];
  a[1, 3] := t1[tempb[0, 3], 1];
  a[2, 0] := t1[tempb[2, 0], 1];
  a[2, 1] := t1[tempb[3, 1], 1];
  a[2, 2] := t1[tempb[0, 2], 1];
  a[2, 3] := t1[tempb[1, 3], 1];
  a[3, 0] := t1[tempb[3, 0], 1];
  a[3, 1] := t1[tempb[0, 1], 1];
  a[3, 2] := t1[tempb[1, 2], 1];
  a[3, 3] := t1[tempb[2, 3], 1];
  PDWord(@a[0])^ := PDWord(@a[0])^ xor rk[NUMROUNDS, 0];
  PDWord(@a[1])^ := PDWord(@a[1])^ xor rk[NUMROUNDS, 1];
  PDWord(@a[2])^ := PDWord(@a[2])^ xor rk[NUMROUNDS, 2];
  PDWord(@a[3])^ := PDWord(@a[3])^ xor rk[NUMROUNDS, 3];

  PDWord(@OutData)^ := PDWord(@a[0, 0])^;
  PDWord(DWORD(@OutData) + 4)^ := PDWord(@a[1, 0])^;
  PDWord(DWORD(@OutData) + 8)^ := PDWord(@a[2, 0])^;
  PDWord(DWORD(@OutData) + 12)^ := PDWord(@a[3, 0])^;
end;

procedure TTopdelphi7.DecryptECB(const InData; var OutData);
var
  r                                     : Longint;
  tempb                                 : array[0..MAXBC - 1, 0..3] of Byte;
  a                                     : array[0..MAXBC, 0..3] of Byte;
begin
  if not fInitialized then
    raise EDCP_blockcipher.Create('Cipher not initialized');
  PDWord(@a[0, 0])^ := PDWord(@InData)^;
  PDWord(@a[1, 0])^ := PDWord(DWORD(@InData) + 4)^;
  PDWord(@a[2, 0])^ := PDWord(DWORD(@InData) + 8)^;
  PDWord(@a[3, 0])^ := PDWord(DWORD(@InData) + 12)^;
  for r := NUMROUNDS downto 2 do
  begin
    PDWord(@tempb[0])^ := PDWord(@a[0])^ xor drk[r, 0];
    PDWord(@tempb[1])^ := PDWord(@a[1])^ xor drk[r, 1];
    PDWord(@tempb[2])^ := PDWord(@a[2])^ xor drk[r, 2];
    PDWord(@tempb[3])^ := PDWord(@a[3])^ xor drk[r, 3];
    PDWord(@a[0])^ := PDWord(@T5[tempb[0, 0]])^ xor
      PDWord(@T6[tempb[3, 1]])^ xor
      PDWord(@T7[tempb[2, 2]])^ xor
      PDWord(@T8[tempb[1, 3]])^;
    PDWord(@a[1])^ := PDWord(@T5[tempb[1, 0]])^ xor
      PDWord(@T6[tempb[0, 1]])^ xor
      PDWord(@T7[tempb[3, 2]])^ xor
      PDWord(@T8[tempb[2, 3]])^;
    PDWord(@a[2])^ := PDWord(@T5[tempb[2, 0]])^ xor
      PDWord(@T6[tempb[1, 1]])^ xor
      PDWord(@T7[tempb[0, 2]])^ xor
      PDWord(@T8[tempb[3, 3]])^;
    PDWord(@a[3])^ := PDWord(@T5[tempb[3, 0]])^ xor
      PDWord(@T6[tempb[2, 1]])^ xor
      PDWord(@T7[tempb[1, 2]])^ xor
      PDWord(@T8[tempb[0, 3]])^;
  end;
  PDWord(@tempb[0])^ := PDWord(@a[0])^ xor drk[1, 0];
  PDWord(@tempb[1])^ := PDWord(@a[1])^ xor drk[1, 1];
  PDWord(@tempb[2])^ := PDWord(@a[2])^ xor drk[1, 2];
  PDWord(@tempb[3])^ := PDWord(@a[3])^ xor drk[1, 3];
  a[0, 0] := S5[tempb[0, 0]];
  a[0, 1] := S5[tempb[3, 1]];
  a[0, 2] := S5[tempb[2, 2]];
  a[0, 3] := S5[tempb[1, 3]];
  a[1, 0] := S5[tempb[1, 0]];
  a[1, 1] := S5[tempb[0, 1]];
  a[1, 2] := S5[tempb[3, 2]];
  a[1, 3] := S5[tempb[2, 3]];
  a[2, 0] := S5[tempb[2, 0]];
  a[2, 1] := S5[tempb[1, 1]];
  a[2, 2] := S5[tempb[0, 2]];
  a[2, 3] := S5[tempb[3, 3]];
  a[3, 0] := S5[tempb[3, 0]];
  a[3, 1] := S5[tempb[2, 1]];
  a[3, 2] := S5[tempb[1, 2]];
  a[3, 3] := S5[tempb[0, 3]];
  PDWord(@a[0])^ := PDWord(@a[0])^ xor drk[0, 0];
  PDWord(@a[1])^ := PDWord(@a[1])^ xor drk[0, 1];
  PDWord(@a[2])^ := PDWord(@a[2])^ xor drk[0, 2];
  PDWord(@a[3])^ := PDWord(@a[3])^ xor drk[0, 3];
  PDWord(@OutData)^ := PDWord(@a[0, 0])^;
  PDWord(DWORD(@OutData) + 4)^ := PDWord(@a[1, 0])^;
  PDWord(DWORD(@OutData) + 8)^ := PDWord(@a[2, 0])^;
  PDWord(DWORD(@OutData) + 12)^ := PDWord(@a[3, 0])^;
end;


initialization
//  RegisterClass(TTopdelphi7);
  //DCPregcipher(TTopdelphi7, true);

end.
