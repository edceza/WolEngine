
unit Function1;

interface
uses
  Classes, SysUtils, Const1, Const2;

const
  INPUTWHITEN                           = 0;
  OUTPUTWHITEN                          = 4;
  NUMROUNDS                             = 16;
  ROUNDSUBKEYS                          = (OUTPUTWHITEN + 4);
  TOTALSUBKEYS                          = (ROUNDSUBKEYS + NUMROUNDS * 2);
  RS_GF_FDBK                            = $14D;
  MDS_GF_FDBK                           = $169;
  SK_STEP                               = $02020202;
  SK_BUMP                               = $01010101;
  SK_ROTL                               = 9;

type
  TTopdelphi1 = class(TDCP_blockcipher)
  protected
    SubKeys: array[0..TOTALSUBKEYS - 1] of DWORD;
    sbox: array[0..3, 0..255] of DWORD;
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
    constructor Create(AOwner: TComponent); override;
  end;


  {******************************************************************************}
  {******************************************************************************}
implementation
{$R-}{$Q-}
{$I Const.inc}

var
  MDS                                   : array[0..3, 0..255] of DWORD;
  MDSDone                               : boolean;

class function TTopdelphi1.GetID: Longint;
begin
  Result := DCP_twofish;
end;

class function TTopdelphi1.GetAlgorithm: string;
begin
  Result := 'Twofish';
end;

class function TTopdelphi1.GetMaxKeySize: Longint;
begin
  Result := 256;
end;

class function TTopdelphi1.GetBlockSize: Longint;
begin
  Result := 128;
end;

class function TTopdelphi1.SelfTest: boolean;
const
  Out128                                : array[0..15] of Byte =
    ($5D, $9D, $4E, $EF, $FA, $91, $51, $57, $55, $24, $F1, $15, $81, $5A, $12,
      $E0);
  Out192                                : array[0..15] of Byte =
    ($E7, $54, $49, $21, $2B, $EE, $F9, $F4, $A3, $90, $BD, $86, $0A, $64, $09,
      $41);
  Out256                                : array[0..15] of Byte =
    ($37, $FE, $26, $FF, $1C, $F6, $61, $75, $F5, $DD, $F4, $C3, $3B, $97, $A2,
      $05);
var
  i                                     : Integer;
  Key                                   : array[0..31] of Byte;
  Block                                 : array[0..15] of Byte;
  Cipher                                : TTopdelphi1;
begin
  Cipher := TTopdelphi1.Create(nil);
  FillChar(Key, sizeof(Key), 0);
  FillChar(Block, sizeof(Block), 0);
  for i := 1 to 49 do
  begin
    Cipher.Init(Key, 128, nil);
    Move(Block, Key, 16);
    Cipher.EncryptECB(Block, Block);
    Cipher.Burn;
  end;
  Result := boolean(CompareMemory(@Block, @Out128, 16));
  FillChar(Key, sizeof(Key), 0);
  FillChar(Block, sizeof(Block), 0);
  for i := 1 to 49 do
  begin
    Cipher.Init(Key, 192, nil);
    Move(Key[0], Key[16], 8);
    Move(Block, Key, 16);
    Cipher.EncryptECB(Block, Block);
    Cipher.Burn;
  end;
  Result := Result and boolean(CompareMemory(@Block, @Out192, 16));
  FillChar(Key, sizeof(Key), 0);
  FillChar(Block, sizeof(Block), 0);
  for i := 1 to 49 do
  begin
    Cipher.Init(Key, 256, nil);
    Move(Key[0], Key[16], 16);
    Move(Block, Key, 16);
    Cipher.EncryptECB(Block, Block);
    Cipher.Burn;
  end;
  Result := Result and boolean(CompareMemory(@Block, @Out256, 16));
  Cipher.Burn;
  Cipher.Free;
end;

function LFSR1(x: DWORD): DWORD;
begin
  if (x and 1) <> 0 then
    Result := (x shr 1) xor (MDS_GF_FDBK div 2)
  else
    Result := (x shr 1);
end;

function LFSR2(x: DWORD): DWORD;
begin
  if (x and 2) <> 0 then
    if (x and 1) <> 0 then
      Result := (x shr 2) xor (MDS_GF_FDBK div 2) xor (MDS_GF_FDBK div 4)
    else
      Result := (x shr 2) xor (MDS_GF_FDBK div 2)
  else if (x and 1) <> 0 then
    Result := (x shr 2) xor (MDS_GF_FDBK div 4)
  else
    Result := (x shr 2);
end;

function Mul_X(x: DWORD): DWORD;
begin
  Result := x xor LFSR2(x);
end;

function Mul_Y(x: DWORD): DWORD;
begin
  Result := x xor LFSR1(x) xor LFSR2(x);
end;

function RS_MDS_Encode(lK0, lK1: DWORD): DWORD;
var
  lR, nJ, lG2, lG3                      : DWORD;
  bB                                    : Byte;
begin
  lR := lK1;
  for nJ := 0 to 3 do
  begin
    bB := lR shr 24;
    if (bB and $80) <> 0 then
      lG2 := ((bB shl 1) xor RS_GF_FDBK) and $FF
    else
      lG2 := (bB shl 1) and $FF;
    if (bB and 1) <> 0 then
      lG3 := ((bB shr 1) and $7F) xor (RS_GF_FDBK shr 1) xor lG2
    else
      lG3 := ((bB shr 1) and $7F) xor lG2;
    lR := (lR shl 8) xor (lG3 shl 24) xor (lG2 shl 16) xor (lG3 shl 8) xor bB;
  end;
  lR := lR xor lK0;
  for nJ := 0 to 3 do
  begin
    bB := lR shr 24;
    if (bB and $80) <> 0 then
      lG2 := ((bB shl 1) xor RS_GF_FDBK) and $FF
    else
      lG2 := (bB shl 1) and $FF;
    if (bB and 1) <> 0 then
      lG3 := ((bB shr 1) and $7F) xor (RS_GF_FDBK shr 1) xor lG2
    else
      lG3 := ((bB shr 1) and $7F) xor lG2;
    lR := (lR shl 8) xor (lG3 shl 24) xor (lG2 shl 16) xor (lG3 shl 8) xor bB;
  end;
  Result := lR;
end;

function f32(x: DWORD; K32: PDWordArray; len: DWORD): DWORD;
var
  t0, t1, t2, t3                        : DWORD;
begin
  t0 := x and $FF;
  t1 := (x shr 8) and $FF;
  t2 := (x shr 16) and $FF;
  t3 := x shr 24;
  if len = 256 then
  begin
    t0 := p8x8[1, t0] xor ((K32^[3]) and $FF);
    t1 := p8x8[0, t1] xor ((K32^[3] shr 8) and $FF);
    t2 := p8x8[0, t2] xor ((K32^[3] shr 16) and $FF);
    t3 := p8x8[1, t3] xor ((K32^[3] shr 24));
  end;
  if len >= 192 then
  begin
    t0 := p8x8[1, t0] xor ((K32^[2]) and $FF);
    t1 := p8x8[1, t1] xor ((K32^[2] shr 8) and $FF);
    t2 := p8x8[0, t2] xor ((K32^[2] shr 16) and $FF);
    t3 := p8x8[0, t3] xor ((K32^[2] shr 24));
  end;
  Result := MDS[0, p8x8[0, p8x8[0, t0] xor ((K32^[1]) and $FF)] xor ((K32^[0])
    and $FF)] xor
    MDS[1, p8x8[0, p8x8[1, t1] xor ((K32^[1] shr 8) and $FF)] xor ((K32^[0] shr
      8) and $FF)] xor
    MDS[2, p8x8[1, p8x8[0, t2] xor ((K32^[1] shr 16) and $FF)] xor ((K32^[0] shr
      16) and $FF)] xor
    MDS[3, p8x8[1, p8x8[1, t3] xor ((K32^[1] shr 24))] xor ((K32^[0] shr 24))];
end;

procedure Xor256(Dst, Src: PDWordArray; v: Byte);
var
  i, j                                  : DWORD;
begin
  i := 0;
  j := v * $01010101;
  while i < 64 do
  begin
    Dst^[i] := Src^[i] xor j;
    Dst^[i + 1] := Src^[i + 1] xor j;
    Dst^[i + 2] := Src^[i + 2] xor j;
    Dst^[i + 3] := Src^[i + 3] xor j;
    Inc(i, 4);
  end;
end;

procedure TTopdelphi1.Init(const Key; Size: Longint; InitVector: Pointer);
const
  subkeyCnt                             = ROUNDSUBKEYS + 2 * NUMROUNDS;
var
  key32                                 : array[0..7] of DWORD;
  k32e, k32o, sboxkeys                  : array[0..3] of DWORD;
  k64Cnt, i, j, a, B, q                 : DWORD;
  L0, L1                                : array[0..255] of Byte;
begin
  inherited Init(Key, Size, InitVector);
  FillChar(key32, sizeof(key32), 0);
  Move(Key, key32, Size div 8);
  if Size <= 128 then { pad the key to either 128bit, 192bit or 256bit}
    Size := 128
  else if Size <= 192 then
    Size := 192
  else
    Size := 256;
  k64Cnt := Size div 64;
  j := k64Cnt - 1;
  for i := 0 to j do
  begin
    k32e[i] := key32[2 * i];
    k32o[i] := key32[2 * i + 1];
    sboxkeys[j] := RS_MDS_Encode(k32e[i], k32o[i]);
    Dec(j);
  end;
  q := 0;
  for i := 0 to ((subkeyCnt div 2) - 1) do
  begin
    a := f32(q, @k32e, Size);
    B := f32(q + SK_BUMP, @k32o, Size);
    B := (B shl 8) or (B shr 24);
    SubKeys[2 * i] := a + B;
    B := a + 2 * B;
    SubKeys[2 * i + 1] := (B shl SK_ROTL) or (B shr (32 - SK_ROTL));
    Inc(q, SK_STEP);
  end;
  case Size of
    128:
      begin
        Xor256(@L0, @p8x8[0], (sboxkeys[1] and $FF));
        a := (sboxkeys[0] and $FF);
        i := 0;
        while i < 256 do
        begin
          sbox[0 and 2, 2 * i + (0 and 1)] := MDS[0, p8x8[0, L0[i]] xor a];
          sbox[0 and 2, 2 * i + (0 and 1) + 2] := MDS[0, p8x8[0, L0[i + 1]] xor
            a];
          Inc(i, 2);
        end;
        Xor256(@L0, @p8x8[1], (sboxkeys[1] shr 8) and $FF);
        a := (sboxkeys[0] shr 8) and $FF;
        i := 0;
        while i < 256 do
        begin
          sbox[1 and 2, 2 * i + (1 and 1)] := MDS[1, p8x8[0, L0[i]] xor a];
          sbox[1 and 2, 2 * i + (1 and 1) + 2] := MDS[1, p8x8[0, L0[i + 1]] xor
            a];
          Inc(i, 2);
        end;
        Xor256(@L0, @p8x8[0], (sboxkeys[1] shr 16) and $FF);
        a := (sboxkeys[0] shr 16) and $FF;
        i := 0;
        while i < 256 do
        begin
          sbox[2 and 2, 2 * i + (2 and 1)] := MDS[2, p8x8[1, L0[i]] xor a];
          sbox[2 and 2, 2 * i + (2 and 1) + 2] := MDS[2, p8x8[1, L0[i + 1]] xor
            a];
          Inc(i, 2);
        end;
        Xor256(@L0, @p8x8[1], (sboxkeys[1] shr 24));
        a := (sboxkeys[0] shr 24);
        i := 0;
        while i < 256 do
        begin
          sbox[3 and 2, 2 * i + (3 and 1)] := MDS[3, p8x8[1, L0[i]] xor a];
          sbox[3 and 2, 2 * i + (3 and 1) + 2] := MDS[3, p8x8[1, L0[i + 1]] xor
            a];
          Inc(i, 2);
        end;
      end;
    192:
      begin
        Xor256(@L0, @p8x8[1], sboxkeys[2] and $FF);
        a := sboxkeys[0] and $FF;
        B := sboxkeys[1] and $FF;
        i := 0;
        while i < 256 do
        begin
          sbox[0 and 2, 2 * i + (0 and 1)] := MDS[0, p8x8[0, p8x8[0, L0[i]] xor
            B] xor a];
          sbox[0 and 2, 2 * i + (0 and 1) + 2] := MDS[0, p8x8[0, p8x8[0, L0[i +
            1]] xor B] xor a];
          Inc(i, 2);
        end;
        Xor256(@L0, @p8x8[1], (sboxkeys[2] shr 8) and $FF);
        a := (sboxkeys[0] shr 8) and $FF;
        B := (sboxkeys[1] shr 8) and $FF;
        i := 0;
        while i < 256 do
        begin
          sbox[1 and 2, 2 * i + (1 and 1)] := MDS[1, p8x8[0, p8x8[1, L0[i]] xor
            B] xor a];
          sbox[1 and 2, 2 * i + (1 and 1) + 2] := MDS[1, p8x8[0, p8x8[1, L0[i +
            1]] xor B] xor a];
          Inc(i, 2);
        end;
        Xor256(@L0, @p8x8[0], (sboxkeys[2] shr 16) and $FF);
        a := (sboxkeys[0] shr 16) and $FF;
        B := (sboxkeys[1] shr 16) and $FF;
        i := 0;
        while i < 256 do
        begin
          sbox[2 and 2, 2 * i + (2 and 1)] := MDS[2, p8x8[1, p8x8[0, L0[i]] xor
            B] xor a];
          sbox[2 and 2, 2 * i + (2 and 1) + 2] := MDS[2, p8x8[1, p8x8[0, L0[i +
            1]] xor B] xor a];
          Inc(i, 2);
        end;
        Xor256(@L0, @p8x8[0], (sboxkeys[2] shr 24));
        a := (sboxkeys[0] shr 24);
        B := (sboxkeys[1] shr 24);
        i := 0;
        while i < 256 do
        begin
          sbox[3 and 2, 2 * i + (3 and 1)] := MDS[3, p8x8[1, p8x8[1, L0[i]] xor
            B] xor a];
          sbox[3 and 2, 2 * i + (3 and 1) + 2] := MDS[3, p8x8[1, p8x8[1, L0[i +
            1]] xor B] xor a];
          Inc(i, 2);
        end;
      end;
    256:
      begin
        Xor256(@L1, @p8x8[1], (sboxkeys[3]) and $FF);
        i := 0;
        while i < 256 do
        begin
          L0[i] := p8x8[1, L1[i]];
          L0[i + 1] := p8x8[1, L1[i + 1]];
          Inc(i, 2);
        end;
        Xor256(@L0, @L0, (sboxkeys[2]) and $FF);
        a := (sboxkeys[0]) and $FF;
        B := (sboxkeys[1]) and $FF;
        i := 0;
        while i < 256 do
        begin
          sbox[0 and 2, 2 * i + (0 and 1)] := MDS[0, p8x8[0, p8x8[0, L0[i]] xor
            B] xor a];
          sbox[0 and 2, 2 * i + (0 and 1) + 2] := MDS[0, p8x8[0, p8x8[0, L0[i +
            1]] xor B] xor a];
          Inc(i, 2);
        end;
        Xor256(@L1, @p8x8[0], (sboxkeys[3] shr 8) and $FF);
        i := 0;
        while i < 256 do
        begin
          L0[i] := p8x8[1, L1[i]];
          L0[i + 1] := p8x8[1, L1[i + 1]];
          Inc(i, 2);
        end;
        Xor256(@L0, @L0, (sboxkeys[2] shr 8) and $FF);
        a := (sboxkeys[0] shr 8) and $FF;
        B := (sboxkeys[1] shr 8) and $FF;
        i := 0;
        while i < 256 do
        begin
          sbox[1 and 2, 2 * i + (1 and 1)] := MDS[1, p8x8[0, p8x8[1, L0[i]] xor
            B] xor a];
          sbox[1 and 2, 2 * i + (1 and 1) + 2] := MDS[1, p8x8[0, p8x8[1, L0[i +
            1]] xor B] xor a];
          Inc(i, 2);
        end;

        Xor256(@L1, @p8x8[0], (sboxkeys[3] shr 16) and $FF);
        i := 0;
        while i < 256 do
        begin
          L0[i] := p8x8[0, L1[i]];
          L0[i + 1] := p8x8[0, L1[i + 1]];
          Inc(i, 2);
        end;
        Xor256(@L0, @L0, (sboxkeys[2] shr 16) and $FF);
        a := (sboxkeys[0] shr 16) and $FF;
        B := (sboxkeys[1] shr 16) and $FF;
        i := 0;
        while i < 256 do
        begin
          sbox[2 and 2, 2 * i + (2 and 1)] := MDS[2, p8x8[1, p8x8[0, L0[i]] xor
            B] xor a];
          sbox[2 and 2, 2 * i + (2 and 1) + 2] := MDS[2, p8x8[1, p8x8[0, L0[i +
            1]] xor B] xor a];
          Inc(i, 2);
        end;
        Xor256(@L1, @p8x8[1], (sboxkeys[3] shr 24));
        i := 0;
        while i < 256 do
        begin
          L0[i] := p8x8[0, L1[i]];
          L0[i + 1] := p8x8[0, L1[i + 1]];
          Inc(i, 2);
        end;
        Xor256(@L0, @L0, (sboxkeys[2] shr 24));
        a := (sboxkeys[0] shr 24);
        B := (sboxkeys[1] shr 24);
        i := 0;
        while i < 256 do
        begin
          sbox[3 and 2, 2 * i + (3 and 1)] := MDS[3, p8x8[1, p8x8[1, L0[i]] xor
            B] xor a];
          sbox[3 and 2, 2 * i + (3 and 1) + 2] := MDS[3, p8x8[1, p8x8[1, L0[i +
            1]] xor B] xor a];
          Inc(i, 2);
        end;
      end;
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

procedure TTopdelphi1.Burn;
begin
  FillChar(sbox, sizeof(sbox), $FF);
  FillChar(SubKeys, sizeof(SubKeys), $FF);
  inherited Burn;
end;

procedure TTopdelphi1.EncryptECB(const InData; var OutData);
var
  i                                     : Longint;
  t0, t1                                : DWORD;
  x                                     : array[0..3] of DWORD;
begin
  if not fInitialized then
    raise EDCP_blockcipher.Create('Cipher not initialized');
  x[0] := PDWord(@InData)^ xor SubKeys[INPUTWHITEN];
  x[1] := PDWord(Longint(@InData) + 4)^ xor SubKeys[INPUTWHITEN + 1];
  x[2] := PDWord(Longint(@InData) + 8)^ xor SubKeys[INPUTWHITEN + 2];
  x[3] := PDWord(Longint(@InData) + 12)^ xor SubKeys[INPUTWHITEN + 3];
  i := 0;
  while i <= NUMROUNDS - 2 do
  begin
    t0 := sbox[0, (x[0] shl 1) and $1FE] xor sbox[0, ((x[0] shr 7) and $1FE) + 1]
      xor sbox[2, (x[0] shr 15) and $1FE] xor sbox[2, ((x[0] shr 23) and $1FE) +
        1];
    t1 := sbox[0, ((x[1] shr 23) and $1FE)] xor sbox[0, ((x[1] shl 1) and $1FE)
      + 1]
      xor sbox[2, ((x[1] shr 7) and $1FE)] xor sbox[2, ((x[1] shr 15) and $1FE)
        + 1];
    x[3] := (x[3] shl 1) or (x[3] shr 31);
    x[2] := x[2] xor (t0 + t1 + SubKeys[ROUNDSUBKEYS + 2 * i]);
    x[3] := x[3] xor (t0 + 2 * t1 + SubKeys[ROUNDSUBKEYS + 2 * i + 1]);
    x[2] := (x[2] shr 1) or (x[2] shl 31);

    t0 := sbox[0, (x[2] shl 1) and $1FE] xor sbox[0, ((x[2] shr 7) and $1FE) + 1]
      xor sbox[2, ((x[2] shr 15) and $1FE)] xor sbox[2, ((x[2] shr 23) and $1FE)
        + 1];
    t1 := sbox[0, ((x[3] shr 23) and $1FE)] xor sbox[0, ((x[3] shl 1) and $1FE)
      + 1]
      xor sbox[2, ((x[3] shr 7) and $1FE)] xor sbox[2, ((x[3] shr 15) and $1FE)
        + 1];
    x[1] := (x[1] shl 1) or (x[1] shr 31);
    x[0] := x[0] xor (t0 + t1 + SubKeys[ROUNDSUBKEYS + 2 * (i + 1)]);
    x[1] := x[1] xor (t0 + 2 * t1 + SubKeys[ROUNDSUBKEYS + 2 * (i + 1) + 1]);
    x[0] := (x[0] shr 1) or (x[0] shl 31);
    Inc(i, 2);
  end;
  PDWord(Longint(@OutData) + 0)^ := x[2] xor SubKeys[OUTPUTWHITEN];
  PDWord(Longint(@OutData) + 4)^ := x[3] xor SubKeys[OUTPUTWHITEN + 1];
  PDWord(Longint(@OutData) + 8)^ := x[0] xor SubKeys[OUTPUTWHITEN + 2];
  PDWord(Longint(@OutData) + 12)^ := x[1] xor SubKeys[OUTPUTWHITEN + 3];
end;

procedure TTopdelphi1.DecryptECB(const InData; var OutData);
var
  i                                     : Longint;
  t0, t1                                : DWORD;
  x                                     : array[0..3] of DWORD;
begin
  if not fInitialized then
    raise EDCP_blockcipher.Create('Cipher not initialized');
  x[2] := PDWord(@InData)^ xor SubKeys[OUTPUTWHITEN];
  x[3] := PDWord(Longint(@InData) + 4)^ xor SubKeys[OUTPUTWHITEN + 1];
  x[0] := PDWord(Longint(@InData) + 8)^ xor SubKeys[OUTPUTWHITEN + 2];
  x[1] := PDWord(Longint(@InData) + 12)^ xor SubKeys[OUTPUTWHITEN + 3];
  i := NUMROUNDS - 2;
  while i >= 0 do
  begin
    t0 := sbox[0, (x[2] shl 1) and $1FE] xor sbox[0, ((x[2] shr 7) and $1FE) + 1]
      xor sbox[2, ((x[2] shr 15) and $1FE)] xor sbox[2, ((x[2] shr 23) and $1FE)
        + 1];
    t1 := sbox[0, ((x[3] shr 23) and $1FE)] xor sbox[0, ((x[3] shl 1) and $1FE)
      + 1]
      xor sbox[2, ((x[3] shr 7) and $1FE)] xor sbox[2, ((x[3] shr 15) and $1FE)
        + 1];
    x[0] := (x[0] shl 1) or (x[0] shr 31);
    x[0] := x[0] xor (t0 + t1 + SubKeys[ROUNDSUBKEYS + 2 * (i + 1)]);
    x[1] := x[1] xor (t0 + 2 * t1 + SubKeys[ROUNDSUBKEYS + 2 * (i + 1) + 1]);
    x[1] := (x[1] shr 1) or (x[1] shl 31);

    t0 := sbox[0, (x[0] shl 1) and $1FE] xor sbox[0, ((x[0] shr 7) and $1FE) + 1]
      xor sbox[2, (x[0] shr 15) and $1FE] xor sbox[2, ((x[0] shr 23) and $1FE) +
        1];
    t1 := sbox[0, ((x[1] shr 23) and $1FE)] xor sbox[0, ((x[1] shl 1) and $1FE)
      + 1]
      xor sbox[2, ((x[1] shr 7) and $1FE)] xor sbox[2, ((x[1] shr 15) and $1FE)
        + 1];
    x[2] := (x[2] shl 1) or (x[2] shr 31);
    x[2] := x[2] xor (t0 + t1 + SubKeys[ROUNDSUBKEYS + 2 * i]);
    x[3] := x[3] xor (t0 + 2 * t1 + SubKeys[ROUNDSUBKEYS + 2 * i + 1]);
    x[3] := (x[3] shr 1) or (x[3] shl 31);
    Dec(i, 2);
  end;
  PDWord(Longint(@OutData) + 0)^ := x[0] xor SubKeys[INPUTWHITEN];
  PDWord(Longint(@OutData) + 4)^ := x[1] xor SubKeys[INPUTWHITEN + 1];
  PDWord(Longint(@OutData) + 8)^ := x[2] xor SubKeys[INPUTWHITEN + 2];
  PDWord(Longint(@OutData) + 12)^ := x[3] xor SubKeys[INPUTWHITEN + 3];
end;

procedure PreCompMDS;
var
  m1, mx, my                            : array[0..1] of DWORD;
  nI                                    : Longint;
begin
  for nI := 0 to 255 do
  begin
    m1[0] := p8x8[0, nI];
    mx[0] := Mul_X(m1[0]);
    my[0] := Mul_Y(m1[0]);
    m1[1] := p8x8[1, nI];
    mx[1] := Mul_X(m1[1]);
    my[1] := Mul_Y(m1[1]);
    MDS[0, nI] := (m1[1] shl 0) or
      (mx[1] shl 8) or
      (my[1] shl 16) or
      (my[1] shl 24);
    MDS[1, nI] := (my[0] shl 0) or
      (my[0] shl 8) or
      (mx[0] shl 16) or
      (m1[0] shl 24);
    MDS[2, nI] := (mx[1] shl 0) or
      (my[1] shl 8) or
      (m1[1] shl 16) or
      (my[1] shl 24);
    MDS[3, nI] := (mx[0] shl 0) or
      (m1[0] shl 8) or
      (my[0] shl 16) or
      (mx[0] shl 24);
  end;
end;

constructor TTopdelphi1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not MDSDone then
  begin
    PreCompMDS;
    MDSDone := true;
  end;
end;

initialization
  MDSDone := false;
 // RegisterClass(TTopdelphi1);
  //DCPregcipher(TTopdelphi1, true);

end.
