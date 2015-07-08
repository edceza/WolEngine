unit function3;

interface
uses
  Classes, SysUtils, Const1, Const2;

type
  TTopdelphi3 = class(TDCP_blockcipher)
  protected
    kr, Km: array[0..11, 0..3] of DWORD;
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
{$I Cast256.inc}

function F1(a, rk, mk: DWORD): DWORD;
var
  t                                     : DWORD;
begin
  t := LRot32(mk + a, rk);
  Result := ((S1[t shr 24] xor S2[(t shr 16) and $FF]) - S3[(t shr 8) and $FF])
    + S4[t and $FF];
end;

function F2(a, rk, mk: DWORD): DWORD;
var
  t                                     : DWORD;
begin
  t := LRot32(mk xor a, rk);
  Result := ((S1[t shr 24] - S2[(t shr 16) and $FF]) + S3[(t shr 8) and $FF]) xor
    S4[t and $FF];
end;

function F3(a, rk, mk: DWORD): DWORD;
var
  t                                     : DWORD;
begin
  t := LRot32(mk - a, rk);
  Result := ((S1[t shr 24] + S2[(t shr 16) and $FF]) xor S3[(t shr 8) and $FF])
    - S4[t and $FF];
end;

class function TTopdelphi3.GetMaxKeySize: Longint;
begin
  Result := 256;
end;

class function TTopdelphi3.GetBlockSize: Longint;
begin
  Result := 128;
end;

class function TTopdelphi3.GetID: Longint;
begin
  Result := DCP_cast256;
end;

class function TTopdelphi3.GetAlgorithm: string;
begin
  Result := 'Cast256';
end;

class function TTopdelphi3.SelfTest: boolean;
const
  Key1                                  : array[0..15] of Byte =
    ($23, $42, $BB, $9E, $FA, $38, $54, $2C, $0A, $F7, $56, $47, $F2, $9F, $61,
      $5D);
  InBlock1                              : array[0..15] of Byte =
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0C, $9B, $28,
      $07);
  OutBlock1                             : array[0..15] of Byte =
    ($96, $3A, $8A, $50, $CE, $B5, $4D, $08, $E0, $DE, $E0, $F1, $D0, $41, $3D,
      $CF);
  Key2                                  : array[0..23] of Byte =
    ($23, $42, $BB, $9E, $FA, $38, $54, $2C, $BE, $D0, $AC, $83, $94, $0A, $C2,
      $98, $BA, $C7, $7A, $77, $17, $94, $28, $63);
  InBlock2                              : array[0..15] of Byte =
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $DE, $25, $5A,
      $FF);
  OutBlock2                             : array[0..15] of Byte =
    ($2B, $C1, $92, $9F, $30, $13, $47, $A9, $9D, $3F, $3E, $45, $AD, $34, $01,
      $E8);
  Key3                                  : array[0..31] of Byte =
    ($23, $42, $BB, $9E, $FA, $38, $54, $2C, $BE, $D0, $AC, $83, $94, $0A, $C2,
      $98, $8D, $7C, $47, $CE, $26, $49, $08, $46, $1C, $C1, $B5, $13, $7A, $E6,
      $B6, $04);
  InBlock3                              : array[0..15] of Byte =
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $C5, $FC, $EB,
      $19);
  OutBlock3                             : array[0..15] of Byte =
    ($1E, $2E, $BC, $6C, $9F, $2E, $43, $8E, $1D, $90, $D9, $B9, $C6, $85, $32,
      $86);
var
  Block                                 : array[0..15] of Byte;
  Cipher                                : TTopdelphi3;
begin
  Cipher := TTopdelphi3.Create(nil);
  Cipher.Init(Key1, sizeof(Key1) * 8, nil);
  Cipher.EncryptECB(InBlock1, Block);
  Result := boolean(CompareMemory(@Block, @OutBlock1, 8));
  Cipher.DecryptECB(Block, Block);
  Result := Result and boolean(CompareMemory(@Block, @InBlock1, 16));
  Cipher.Burn;
  Cipher.Init(Key2, sizeof(Key2) * 8, nil);
  Cipher.EncryptECB(InBlock2, Block);
  Result := Result and boolean(CompareMemory(@Block, @OutBlock2, 8));
  Cipher.DecryptECB(Block, Block);
  Result := Result and boolean(CompareMemory(@Block, @InBlock2, 16));
  Cipher.Burn;
  Cipher.Init(Key3, sizeof(Key3) * 8, nil);
  Cipher.EncryptECB(InBlock3, Block);
  Result := Result and boolean(CompareMemory(@Block, @OutBlock3, 8));
  Cipher.DecryptECB(Block, Block);
  Result := Result and boolean(CompareMemory(@Block, @InBlock3, 16));
  Cipher.Burn;
  Cipher.Free;
end;

procedure TTopdelphi3.Init(const Key; Size: Longint; InitVector: Pointer);
var
  x                                     : array[0..7] of DWORD;
  cm, cr                                : DWORD;
  i, j                                  : Longint;
  tr, tm                                : array[0..7] of DWORD;
begin
  inherited Init(Key, Size, InitVector);
  Size := Size div 8;

  FillChar(x, sizeof(x), 0);
  Move(Key, x, Size);

  cm := $5A827999;
  cr := 19;
  for i := 0 to 7 do
    x[i] := (x[i] shl 24) or ((x[i] shl 8) and $FF0000) or ((x[i] shr 8) and
      $FF00) or (x[i] shr 24);
  for i := 0 to 11 do
  begin
    for j := 0 to 7 do
    begin
      tm[j] := cm;
      Inc(cm, $6ED9EBA1);
      tr[j] := cr;
      Inc(cr, 17);
    end;
    x[6] := x[6] xor F1(x[7], tr[0], tm[0]);
    x[5] := x[5] xor F2(x[6], tr[1], tm[1]);
    x[4] := x[4] xor F3(x[5], tr[2], tm[2]);
    x[3] := x[3] xor F1(x[4], tr[3], tm[3]);
    x[2] := x[2] xor F2(x[3], tr[4], tm[4]);
    x[1] := x[1] xor F3(x[2], tr[5], tm[5]);
    x[0] := x[0] xor F1(x[1], tr[6], tm[6]);
    x[7] := x[7] xor F2(x[0], tr[7], tm[7]);

    for j := 0 to 7 do
    begin
      tm[j] := cm;
      Inc(cm, $6ED9EBA1);
      tr[j] := cr;
      Inc(cr, 17);
    end;
    x[6] := x[6] xor F1(x[7], tr[0], tm[0]);
    x[5] := x[5] xor F2(x[6], tr[1], tm[1]);
    x[4] := x[4] xor F3(x[5], tr[2], tm[2]);
    x[3] := x[3] xor F1(x[4], tr[3], tm[3]);
    x[2] := x[2] xor F2(x[3], tr[4], tm[4]);
    x[1] := x[1] xor F3(x[2], tr[5], tm[5]);
    x[0] := x[0] xor F1(x[1], tr[6], tm[6]);
    x[7] := x[7] xor F2(x[0], tr[7], tm[7]);

    kr[i, 0] := x[0] and 31;
    kr[i, 1] := x[2] and 31;
    kr[i, 2] := x[4] and 31;
    kr[i, 3] := x[6] and 31;
    Km[i, 0] := x[7];
    Km[i, 1] := x[5];
    Km[i, 2] := x[3];
    Km[i, 3] := x[1];
  end;
  FillChar(x, sizeof(x), $FF);

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

procedure TTopdelphi3.Burn;
begin
  FillChar(kr, sizeof(kr), $FF);
  FillChar(Km, sizeof(Km), $FF);
  inherited Burn;
end;

procedure TTopdelphi3.EncryptECB(const InData; var OutData);
var
  a                                     : array[0..3] of DWORD;
begin
  if not fInitialized then
    raise EDCP_blockcipher.Create('Cipher not initialized');
  a[0] := PDWord(@InData)^;
  a[1] := PDWord(Longint(@InData) + 4)^;
  a[2] := PDWord(Longint(@InData) + 8)^;
  a[3] := PDWord(Longint(@InData) + 12)^;

  a[0] := SwapDWord(a[0]);
  a[1] := SwapDWord(a[1]);
  a[2] := SwapDWord(a[2]);
  a[3] := SwapDWord(a[3]);
  a[2] := a[2] xor F1(a[3], kr[0, 0], Km[0, 0]);
  a[1] := a[1] xor F2(a[2], kr[0, 1], Km[0, 1]);
  a[0] := a[0] xor F3(a[1], kr[0, 2], Km[0, 2]);
  a[3] := a[3] xor F1(a[0], kr[0, 3], Km[0, 3]);
  a[2] := a[2] xor F1(a[3], kr[1, 0], Km[1, 0]);
  a[1] := a[1] xor F2(a[2], kr[1, 1], Km[1, 1]);
  a[0] := a[0] xor F3(a[1], kr[1, 2], Km[1, 2]);
  a[3] := a[3] xor F1(a[0], kr[1, 3], Km[1, 3]);
  a[2] := a[2] xor F1(a[3], kr[2, 0], Km[2, 0]);
  a[1] := a[1] xor F2(a[2], kr[2, 1], Km[2, 1]);
  a[0] := a[0] xor F3(a[1], kr[2, 2], Km[2, 2]);
  a[3] := a[3] xor F1(a[0], kr[2, 3], Km[2, 3]);
  a[2] := a[2] xor F1(a[3], kr[3, 0], Km[3, 0]);
  a[1] := a[1] xor F2(a[2], kr[3, 1], Km[3, 1]);
  a[0] := a[0] xor F3(a[1], kr[3, 2], Km[3, 2]);
  a[3] := a[3] xor F1(a[0], kr[3, 3], Km[3, 3]);
  a[2] := a[2] xor F1(a[3], kr[4, 0], Km[4, 0]);
  a[1] := a[1] xor F2(a[2], kr[4, 1], Km[4, 1]);
  a[0] := a[0] xor F3(a[1], kr[4, 2], Km[4, 2]);
  a[3] := a[3] xor F1(a[0], kr[4, 3], Km[4, 3]);
  a[2] := a[2] xor F1(a[3], kr[5, 0], Km[5, 0]);
  a[1] := a[1] xor F2(a[2], kr[5, 1], Km[5, 1]);
  a[0] := a[0] xor F3(a[1], kr[5, 2], Km[5, 2]);
  a[3] := a[3] xor F1(a[0], kr[5, 3], Km[5, 3]);

  a[3] := a[3] xor F1(a[0], kr[6, 3], Km[6, 3]);
  a[0] := a[0] xor F3(a[1], kr[6, 2], Km[6, 2]);
  a[1] := a[1] xor F2(a[2], kr[6, 1], Km[6, 1]);
  a[2] := a[2] xor F1(a[3], kr[6, 0], Km[6, 0]);
  a[3] := a[3] xor F1(a[0], kr[7, 3], Km[7, 3]);
  a[0] := a[0] xor F3(a[1], kr[7, 2], Km[7, 2]);
  a[1] := a[1] xor F2(a[2], kr[7, 1], Km[7, 1]);
  a[2] := a[2] xor F1(a[3], kr[7, 0], Km[7, 0]);
  a[3] := a[3] xor F1(a[0], kr[8, 3], Km[8, 3]);
  a[0] := a[0] xor F3(a[1], kr[8, 2], Km[8, 2]);
  a[1] := a[1] xor F2(a[2], kr[8, 1], Km[8, 1]);
  a[2] := a[2] xor F1(a[3], kr[8, 0], Km[8, 0]);
  a[3] := a[3] xor F1(a[0], kr[9, 3], Km[9, 3]);
  a[0] := a[0] xor F3(a[1], kr[9, 2], Km[9, 2]);
  a[1] := a[1] xor F2(a[2], kr[9, 1], Km[9, 1]);
  a[2] := a[2] xor F1(a[3], kr[9, 0], Km[9, 0]);
  a[3] := a[3] xor F1(a[0], kr[10, 3], Km[10, 3]);
  a[0] := a[0] xor F3(a[1], kr[10, 2], Km[10, 2]);
  a[1] := a[1] xor F2(a[2], kr[10, 1], Km[10, 1]);
  a[2] := a[2] xor F1(a[3], kr[10, 0], Km[10, 0]);
  a[3] := a[3] xor F1(a[0], kr[11, 3], Km[11, 3]);
  a[0] := a[0] xor F3(a[1], kr[11, 2], Km[11, 2]);
  a[1] := a[1] xor F2(a[2], kr[11, 1], Km[11, 1]);
  a[2] := a[2] xor F1(a[3], kr[11, 0], Km[11, 0]);
  a[0] := SwapDWord(a[0]);
  a[1] := SwapDWord(a[1]);
  a[2] := SwapDWord(a[2]);
  a[3] := SwapDWord(a[3]);

  PDWord(@OutData)^ := a[0];
  PDWord(Longint(@OutData) + 4)^ := a[1];
  PDWord(Longint(@OutData) + 8)^ := a[2];
  PDWord(Longint(@OutData) + 12)^ := a[3];
end;

procedure TTopdelphi3.DecryptECB(const InData; var OutData);
var
  a                                     : array[0..3] of DWORD;
begin
  if not fInitialized then
    raise EDCP_blockcipher.Create('Cipher not initialized');
  a[0] := PDWord(@InData)^;
  a[1] := PDWord(Longint(@InData) + 4)^;
  a[2] := PDWord(Longint(@InData) + 8)^;
  a[3] := PDWord(Longint(@InData) + 12)^;

  a[0] := SwapDWord(a[0]);
  a[1] := SwapDWord(a[1]);
  a[2] := SwapDWord(a[2]);
  a[3] := SwapDWord(a[3]);
  a[2] := a[2] xor F1(a[3], kr[11, 0], Km[11, 0]);
  a[1] := a[1] xor F2(a[2], kr[11, 1], Km[11, 1]);
  a[0] := a[0] xor F3(a[1], kr[11, 2], Km[11, 2]);
  a[3] := a[3] xor F1(a[0], kr[11, 3], Km[11, 3]);
  a[2] := a[2] xor F1(a[3], kr[10, 0], Km[10, 0]);
  a[1] := a[1] xor F2(a[2], kr[10, 1], Km[10, 1]);
  a[0] := a[0] xor F3(a[1], kr[10, 2], Km[10, 2]);
  a[3] := a[3] xor F1(a[0], kr[10, 3], Km[10, 3]);
  a[2] := a[2] xor F1(a[3], kr[9, 0], Km[9, 0]);
  a[1] := a[1] xor F2(a[2], kr[9, 1], Km[9, 1]);
  a[0] := a[0] xor F3(a[1], kr[9, 2], Km[9, 2]);
  a[3] := a[3] xor F1(a[0], kr[9, 3], Km[9, 3]);
  a[2] := a[2] xor F1(a[3], kr[8, 0], Km[8, 0]);
  a[1] := a[1] xor F2(a[2], kr[8, 1], Km[8, 1]);
  a[0] := a[0] xor F3(a[1], kr[8, 2], Km[8, 2]);
  a[3] := a[3] xor F1(a[0], kr[8, 3], Km[8, 3]);
  a[2] := a[2] xor F1(a[3], kr[7, 0], Km[7, 0]);
  a[1] := a[1] xor F2(a[2], kr[7, 1], Km[7, 1]);
  a[0] := a[0] xor F3(a[1], kr[7, 2], Km[7, 2]);
  a[3] := a[3] xor F1(a[0], kr[7, 3], Km[7, 3]);
  a[2] := a[2] xor F1(a[3], kr[6, 0], Km[6, 0]);
  a[1] := a[1] xor F2(a[2], kr[6, 1], Km[6, 1]);
  a[0] := a[0] xor F3(a[1], kr[6, 2], Km[6, 2]);
  a[3] := a[3] xor F1(a[0], kr[6, 3], Km[6, 3]);

  a[3] := a[3] xor F1(a[0], kr[5, 3], Km[5, 3]);
  a[0] := a[0] xor F3(a[1], kr[5, 2], Km[5, 2]);
  a[1] := a[1] xor F2(a[2], kr[5, 1], Km[5, 1]);
  a[2] := a[2] xor F1(a[3], kr[5, 0], Km[5, 0]);
  a[3] := a[3] xor F1(a[0], kr[4, 3], Km[4, 3]);
  a[0] := a[0] xor F3(a[1], kr[4, 2], Km[4, 2]);
  a[1] := a[1] xor F2(a[2], kr[4, 1], Km[4, 1]);
  a[2] := a[2] xor F1(a[3], kr[4, 0], Km[4, 0]);
  a[3] := a[3] xor F1(a[0], kr[3, 3], Km[3, 3]);
  a[0] := a[0] xor F3(a[1], kr[3, 2], Km[3, 2]);
  a[1] := a[1] xor F2(a[2], kr[3, 1], Km[3, 1]);
  a[2] := a[2] xor F1(a[3], kr[3, 0], Km[3, 0]);
  a[3] := a[3] xor F1(a[0], kr[2, 3], Km[2, 3]);
  a[0] := a[0] xor F3(a[1], kr[2, 2], Km[2, 2]);
  a[1] := a[1] xor F2(a[2], kr[2, 1], Km[2, 1]);
  a[2] := a[2] xor F1(a[3], kr[2, 0], Km[2, 0]);
  a[3] := a[3] xor F1(a[0], kr[1, 3], Km[1, 3]);
  a[0] := a[0] xor F3(a[1], kr[1, 2], Km[1, 2]);
  a[1] := a[1] xor F2(a[2], kr[1, 1], Km[1, 1]);
  a[2] := a[2] xor F1(a[3], kr[1, 0], Km[1, 0]);
  a[3] := a[3] xor F1(a[0], kr[0, 3], Km[0, 3]);
  a[0] := a[0] xor F3(a[1], kr[0, 2], Km[0, 2]);
  a[1] := a[1] xor F2(a[2], kr[0, 1], Km[0, 1]);
  a[2] := a[2] xor F1(a[3], kr[0, 0], Km[0, 0]);
  a[0] := SwapDWord(a[0]);
  a[1] := SwapDWord(a[1]);
  a[2] := SwapDWord(a[2]);
  a[3] := SwapDWord(a[3]);

  PDWord(@OutData)^ := a[0];
  PDWord(Longint(@OutData) + 4)^ := a[1];
  PDWord(Longint(@OutData) + 8)^ := a[2];
  PDWord(Longint(@OutData) + 12)^ := a[3];
end;


initialization

  //DCPregcipher(TTopdelphi3, true);

end.
