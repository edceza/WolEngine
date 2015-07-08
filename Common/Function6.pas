{******************************************************************************}
{* DCPcrypt v2.0 written by David Barton (davebarton@bigfoot.com) *************}
{******************************************************************************}
unit Function6;

interface
uses
  Classes, SysUtils, Const1, Const2;

const
  NUMROUNDS                             = 8;

type
  TTopdelphi6 = class(TDCP_blockcipher)
  protected
    KeyData: array[0..31] of DWORD;
    function FI(const FI_IN, FI_KEY: DWORD): DWORD;
    function FO(const FO_IN: DWORD; const k: Longint): DWORD;
    function FL(const FL_IN: DWORD; const k: Longint): DWORD;
    function FLINV(const FL_IN: DWORD; const k: Longint): DWORD;
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
{$I cont6.inc}

class function TTopdelphi6.GetID: Longint;
begin
  Result := DCP_misty1;
end;

class function TTopdelphi6.GetAlgorithm: string;
begin
  Result := 'Misty1';
end;

class function TTopdelphi6.GetMaxKeySize: Longint;
begin
  Result := 128;
end;

class function TTopdelphi6.GetBlockSize: Longint;
begin
  Result := 64;
end;

class function TTopdelphi6.SelfTest: boolean;
const
  Key                                   : array[0..15] of Byte =
    ($00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $AA, $BB, $CC, $DD, $EE,
      $FF);
  Plain1                                  : array[0..7] of Byte = ($01, $23, $45,
    $67, $89, $AB, $CD, $EF);
  Plain2                                  : array[0..7] of Byte = ($FE, $DC, $BA,
    $98, $76, $54, $32, $10);
  Cipher1                                 : array[0..7] of Byte = ($8B, $1D, $A5,
    $F5, $6A, $B3, $D0, $7C);
  Cipher2                                 : array[0..7] of Byte = ($04, $B6, $82,
    $40, $B1, $3B, $E9, $5D);
var
  Cipher                                : TTopdelphi6;
  Block                                 : array[0..7] of Byte;
begin
  Cipher := TTopdelphi6.Create(nil);
  Cipher.Init(Key, sizeof(Key) * 8, nil);
  Cipher.EncryptECB(Plain1, Block);
  Result := CompareMemory(@Cipher1, @Block, sizeof(Block));
  Cipher.DecryptECB(Block, Block);
  Result := Result and CompareMemory(@Plain1, @Block, sizeof(Block));
  Cipher.EncryptECB(Plain2, Block);
  Result := Result and CompareMemory(@Cipher2, @Block, sizeof(Block));
  Cipher.DecryptECB(Block, Block);
  Result := Result and CompareMemory(@Plain2, @Block, sizeof(Block));
  Cipher.Burn;
  Cipher.Free;
end;

function TTopdelphi6.FI(const FI_IN, FI_KEY: DWORD): DWORD;
var
  d7, d9                                : DWORD;
begin
  d9 := (FI_IN shr 7) and $1FF;
  d7 := FI_IN and $7F;
  d9 := S9Table[d9] xor d7;
  d7 := (S7Table[d7] xor d9) and $7F;
  d7 := d7 xor ((FI_KEY shr 9) and $7F);
  d9 := d9 xor (FI_KEY and $1FF);
  d9 := S9Table[d9] xor d7;
  Result := (d7 shl 9) or d9;
end;

function TTopdelphi6.FO(const FO_IN: DWORD; const k: Longint): DWORD;
var
  t0, t1                                : DWORD;
begin
  t0 := FO_IN shr 16;
  t1 := FO_IN and $FFFF;
  t0 := t0 xor KeyData[k];
  t0 := FI(t0, KeyData[((k + 5) mod 8) + 8]);
  t0 := t0 xor t1;
  t1 := t1 xor KeyData[(k + 2) mod 8];
  t1 := FI(t1, KeyData[((k + 1) mod 8) + 8]);
  t1 := t1 xor t0;
  t0 := t0 xor KeyData[(k + 7) mod 8];
  t0 := FI(t0, KeyData[((k + 3) mod 8) + 8]);
  t0 := t0 xor t1;
  t1 := t1 xor KeyData[(k + 4) mod 8];
  Result := (t1 shl 16) or t0;
end;

function TTopdelphi6.FL(const FL_IN: DWORD; const k: Longint): DWORD;
var
  d0, d1                                : DWORD;
  t                                     : Byte;
begin
  d0 := FL_IN shr 16;
  d1 := FL_IN and $FFFF;
  if (k mod 2) <> 0 then
  begin
    t := (k - 1) div 2;
    d1 := d1 xor (d0 and KeyData[((t + 2) mod 8) + 8]);
    d0 := d0 xor (d1 or KeyData[(t + 4) mod 8]);
  end
  else
  begin
    t := k div 2;
    d1 := d1 xor (d0 and KeyData[t]);
    d0 := d0 xor (d1 or KeyData[((t + 6) mod 8) + 8]);
  end;
  Result := (d0 shl 16) or d1;
end;

function TTopdelphi6.FLINV(const FL_IN: DWORD; const k: Longint): DWORD;
var
  d0, d1                                : DWORD;
  t                                     : Byte;
begin
  d0 := FL_IN shr 16;
  d1 := FL_IN and $FFFF;
  if (k mod 2) <> 0 then
  begin
    t := (k - 1) div 2;
    d0 := d0 xor (d1 or KeyData[(t + 4) mod 8]);
    d1 := d1 xor (d0 and KeyData[((t + 2) mod 8) + 8]);
  end
  else
  begin
    t := k div 2;
    d0 := d0 xor (d1 or KeyData[((t + 6) mod 8) + 8]);
    d1 := d1 xor (d0 and KeyData[t]);
  end;
  Result := (d0 shl 16) or d1;
end;

procedure TTopdelphi6.Init(const Key; Size: Longint; InitVector: Pointer);
var
  keyb                                  : array[0..15] of Byte;
  i                                     : Longint;
begin
  inherited Init(Key, Size, InitVector);

  FillChar(keyb, sizeof(keyb), 0);
  Move(Key, keyb, Size div 8);
  for i := 0 to 7 do
    KeyData[i] := (keyb[i * 2] * 256) + keyb[i * 2 + 1];
  for i := 0 to 7 do
  begin
    KeyData[i + 8] := FI(KeyData[i], KeyData[(i + 1) mod 8]);
    KeyData[i + 16] := KeyData[i + 8] and $1FF;
    KeyData[i + 24] := KeyData[i + 8] shr 9;
  end;

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

procedure TTopdelphi6.Burn;
begin
  FillChar(KeyData, sizeof(KeyData), 0);
  inherited Burn;
end;

procedure TTopdelphi6.EncryptECB(const InData; var OutData);
var
  d0, d1                                : DWORD;
  i                                     : Longint;
begin
  if not fInitialized then
    raise EDCP_blockcipher.Create('Cipher not initialized');
  d0 := SwapDWord(PDWord(@InData)^);
  d1 := SwapDWord(PDWord(Longint(@InData) + 4)^);
  for i := 0 to NUMROUNDS - 1 do
  begin
    if (i mod 2) = 0 then
    begin
      d0 := FL(d0, i);
      d1 := FL(d1, i + 1);
      d1 := d1 xor FO(d0, i);
    end
    else
      d0 := d0 xor FO(d1, i);
  end;
  d0 := FL(d0, NUMROUNDS);
  d1 := FL(d1, NUMROUNDS + 1);
  PDWord(@OutData)^ := SwapDWord(d1);
  PDWord(Longint(@OutData) + 4)^ := SwapDWord(d0);
end;

procedure TTopdelphi6.DecryptECB(const InData; var OutData);
var
  d0, d1                                : DWORD;
  i                                     : Longint;
begin
  if not fInitialized then
    raise EDCP_blockcipher.Create('Cipher not initialized');
  d1 := SwapDWord(PDWord(@InData)^);
  d0 := SwapDWord(PDWord(Longint(@InData) + 4)^);
  d1 := FLINV(d1, NUMROUNDS + 1);
  d0 := FLINV(d0, NUMROUNDS);
  for i := NUMROUNDS - 1 downto 0 do
  begin
    if (i mod 2) = 0 then
    begin
      d1 := d1 xor FO(d0, i);
      d0 := FLINV(d0, i);
      d1 := FLINV(d1, i + 1);
    end
    else
      d0 := d0 xor FO(d1, i);
  end;
  PDWord(@OutData)^ := SwapDWord(d0);
  PDWord(Longint(@OutData) + 4)^ := SwapDWord(d1);
end;

initialization
 // RegisterClass(TTopdelphi6);
  //DCPregcipher(TTopdelphi6, true);

end.
