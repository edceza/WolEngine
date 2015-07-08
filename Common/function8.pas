unit function8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls,
  StdCtrls, Math;

type
  TAryStr = array[0..7] of string[8];

function BinToInt(Str: string): Integer;
function EncodeString(Str: PChar; len: Integer): PChar;
function Decodestring(var Str: PChar; len: Integer): PChar;
var
  ASIICTable                            : array[0..255] of string;
  ValueTable                              : array[0..7] of Integer = (128, 64, 32,
    16, 8, 4, 2, 1);
  Matrix                                : TAryStr;


implementation



function IntToBin(Value: Longint; Digits: Integer): string;
var
  i                                     : Integer;
begin
  Result := '';
  for i := Digits downto 0 do
    if Value and (1 shl i) <> 0 then
      Result := Result + '1'
    else
      Result := Result + '0';
end;

procedure GetASIICTable;
var
  i                                     : Integer;
begin
  for i := 0 to 255 do
  begin
    ASIICTable[i] := IntToBin(i, 7);
  end;
end;

function diversion(AStr: TAryStr): TAryStr;
var
  i, j                              : Integer;
begin
  i := 0;
  FillChar(Result, 64, '0');
  while i <= 7 do
  begin
    for j := 1 to 8 do
    begin
      if (i mod 2) = 0 then
      begin
        if (j in [1, 4, 5, 8]) then
          Result[i][j] := AStr[i][j]
        else if j in [2, 3, 6, 7] then
          Result[i + 1][j] := AStr[i][j];
      end
      else
      begin
        if (j in [1, 4, 5, 8]) then
          Result[i][j] := AStr[i][j]
        else if j in [2, 3, 6, 7] then
          Result[i - 1][j] := AStr[i][j];
      end;
    end;
    Inc(i);
  end;
end;

function BinToInt(Str: string): Integer;
var
  i                                     : Integer;
begin
  Result := 0;
  for i := 1 to 8 do
  begin
    Result := Result + StrToInt(Str[i]) * Round(IntPower(2, 8 - i));
  end;
end;

function EncodeString(Str: PChar; len: Integer): PChar;
var
  EncodeStr, TempStr                    : PChar;
  PLen, Num, Count, p, i, j, t, x, y    : Integer;
  c                                     : Char;
begin
  Num := len mod 8;
  Count := len div 8;
  PLen := Count * 8;
  if Num <> 0 then
    Inc(PLen, 8);

  GetMem(Result, PLen);

  p := 0;
  x := 0;
  t := 0;
  while t <= Count - 1 do
  begin

    for i := 0 to 7 do
    begin
      c := Str[t * 8 + i];
      Matrix[i] := ASIICTable[Ord(c)];
    end;

    Matrix := diversion(Matrix);

    y := 0;
    i := 0;
    while i < 8 do
    begin
      j := 1;
      while j <= 8 do
      begin
        if Matrix[i][j] = '1' then
          y := y + ValueTable[j - 1];
        Inc(j);
      end;

      Result[x] := Chr(y);
      y := 0;
      Inc(x);
      Inc(i);
    end;
    Inc(t);
  end;

  for i := 0 to Num - 1 do
  begin
    c := Str[t * 8 + i];
    Matrix[i] := ASIICTable[Ord(c)];
  end;

  Matrix := diversion(Matrix);

  y := 0;
  i := 0;
  while i < 8 do
  begin
    j := 1;
    while j <= 8 do
    begin
      if Matrix[i][j] = '1' then
        y := y + ValueTable[j - 1];
      Inc(j);
    end;

    Result[x] := Chr(y);
    y := 0;
    Inc(x);
    Inc(i);
  end;
end;

function Decodestring(var Str: PChar; len: Integer): PChar;
var
  TempStr, Resu                         : PChar;
  Num, Count, i, j, t, x, y, p, PLen    : Integer;
  c                                     : Char;
begin

  p := 0;
  x := 0;
  Num := len mod 8;
  Count := len div 8;
  if Num <> 0 then
    Inc(Count);
  GetMem(Resu, Count * 8);
  GetMem(Result, len);
  FillChar(Result^, len, 0);
  t := 0;
  while t < Count do
  begin
    for i := 0 to 7 do
    begin
      c := Str[t * 8 + i];
      Matrix[i] := ASIICTable[Ord(c)];
    end;

    Matrix := diversion(Matrix);

    y := 0;
    i := 0;
    while i < 8 do
    begin
      j := 1;
      while j <= 8 do
      begin
        if Matrix[i][j] = '1' then
          y := y + ValueTable[j - 1];
        Inc(j);
      end;
      Resu[x] := Chr(y);
      y := 0;
      Inc(x);
      Inc(i);
    end;
    Inc(t);
  end;

  Move(Resu[0], Result[0], len);
  Result[len] := #0;

  FreeMem(Resu);
end;

initialization
  GetASIICTable;

end.
