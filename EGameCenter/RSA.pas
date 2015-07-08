unit RSA;
interface
const
  ItemMaxLen = 64;
type
  TInt64Item =record
    Length    :Integer;  //0x00
    Items     :array[0..ItemMaxLen]of Int64;
  end;
  TChItem = array[0..ItemMaxLen]of Char;

  procedure RSAEncode( Src:TChItem; Len:Integer; var Des:TInt64Item; E:Int64; N:Int64);
  procedure RSADecode( Src:TInt64Item; var Des:TChItem; D:Int64; N:Int64);
  procedure XORCode( XORMode:Char; Src:PChar; var Des:TChItem; Len:Integer);


implementation
function PowMod(base:Int64; pow:Int64; n:Int64):Int64;
var
  a, b, c : Int64;
begin
  a := base;
  b := Pow;
  c := 1;
  while( b>0 )do begin
    while( not ((b and 1)>0) )do begin
         b := b shr 1;
         a := a * a mod n;
    end;
    Dec(b);
    c := a * c mod n;
  end;
  Result := c;
end;

procedure RSAEncode( Src:TChItem; Len:Integer; var Des:TInt64Item; E:Int64; N:Int64 );
var
  i : Integer;
begin
  Des.Length := Len;
  for i:=0 to Len-1 do begin
    Des.Items[i] := PowMod(Int64(Src[i]),E,N);
  end;
end;

procedure RSADecode( Src:TInt64Item; var Des:TChItem; D:Int64; N:Int64);
var
  i,A : Integer;
begin
  FillChar(Des,ItemMaxLen,0);
  for i:=0 to Src.Length-1 do begin
    A := PowMod(Src.Items[i],D,N);
    Des[i] := Char(A);
  end;
end;

procedure XORCode( XORMode:Char; Src:PChar; var Des:TChItem; Len:Integer);
var
  I: Integer;
begin
  FillChar(Des,ItemMaxLen,0);
  for i:=0 to Len-1 do begin
    Des[i] := Char(Integer(Src[i]) xor Integer(XORMode)) ;
  end;
end;

end.
