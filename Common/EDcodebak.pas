unit EDcode;

interface

uses
  Windows, SysUtils,Classes, Grobal2; {Classes, Hutil32,}

 TYPE
    TmirITEM = packed record
    Name: String[14];
    Shape: BYTE;//Word        //外形
    StdMode: Byte;      //物品种类(<=3时可以在快捷栏上显示)
    Weight: Word;       //重量
    Source: Word;//
    AniCount: Word;//BYTE;     //
    Looks: Word;//Integer;        //

//    SpecialPower: BYTE; //特殊用途
    NeedIdentify: BYTE; //需要鉴别

    DuraMax1: Word;//Integer;      //最大持久
    AC: Word;           //防
    MAC: Word;          //魔防
    DC: Word;           //攻击
    MC: Word;           //魔
    SC: Word;           //道
    Need: BYTE;         //
    NeedLevel: BYTE;    //需要等级
    Price: Integer;     //价格
    MakeIndex: Integer; //
    Dura: Word;         //持久
    DuraMax: Word;
  end;

TcsITEM = record
     id:word;
     item:tmiritem;
end;

tgamemsg=record
    wFlagh : word;
    wFlaglh: byte ;
    wFlagll: byte ;
    wcmd   : word;
    w1     : word;
    w2     : word;
    w3     : word;
    data: array [0.. 5000] of char;
  end;

 TtMagic =record        //+
    MagicId    :Word;
    MagicName :String[12];
    EffectType :Byte;
    Effect     :Byte;
    xx         :Byte;
    Spell    :Word;
    DefSpell :Word;
    TrainLevel:array[0..2] of Byte;
    TrainLeveX:array[0..2] of Byte;
    MaxTrain :array[0..2] of Integer;
    DelayTime  :Integer;
  end;
  TtClientMagic = record //84
    Key    :Char;
    Level  :Byte;
    CurTrain:Integer;
    Def    :TtMagic;
  end;


TDMAGIC =   record   //魔法   packed
    wMagicID: Word;          //编号
 //   Num:byte;          //这里应为MagicName:Array[0..13] of char //num 是我自己加的,表示后面名字的有效字符数.
    sMagicName:string[12]; //Array[0..12] of Char;   //名称 12
    btEffectType: BYTE;
    btEffect: BYTE;    //效果
    xx:byte;
    wSpell: Word;     //魔法
    wPower: Word;  //
    TrainLevel: Array[0..3] of BYTE;     //升级需要的等级
    MaxTrain: Array[0..3] of Integer; //锻炼
    btTrainLv : BYTE;           //最大锻炼等级
    btJob: BYTE;
    dwDelayTime: dword;   //延迟时间
    btDefSpell: BYTE;       //默认
    btDefPower: BYTE;
    wMaxPower : Word;
    btDefMaxPower: BYTE;
    sDescr: string[15];   //  Array[0..15] of Char; 
  end;

  TcsMAGIC =packed   record    //魔法       //84
    Key: Char;          //按键
    level:byte;            //等级
    undown1:word;
    CurTrain:integer;     //当前经验
    Def: TDMAGIC;
  end;


   function  EncodeMessage (smsg: TDefaultMessage): string;
   function  DecodeMessage (str: string): TDefaultMessage;
   function  EncodeString (str: string): string;
   function  DecodeString (str: string): string;
   function  EncodeBuffer (buf: pChar; bufsize: integer): string;
   procedure DecodeBuffer (src: string; buf: PChar; bufsize: integer);
   procedure Decode6BitBuf (sSource: PChar; pBuf: PChar; nSrcLen,nBufLen: integer);
   procedure Encode6BitBuf (pSrc, pDest: PChar; nSrcLen, nDestLen: integer);
   function  MakeDefaultMsg(wIdent: Word;nRecog: Integer; wParam, wTag, wSeries: Word):TDefaultMessage;
   function CSDecode(pIn: string; pOut: pChar; Size: word): word;   //传奇世界封包解密程序
   function CSEncode(pIn: pChar; pOut: pChar; Size: word): word;
   function cs2mir(s:pchar;var username:string;var tx:integer; var ty:integer):pchar;
   function mir2cs(s:pchar;slen:integer;var username:string;tx,ty:integer;var tfx,tfy:integer;var mysex:byte):pchar;
   //var
//  CSEncode: TRTLCriticalSection;

implementation

 VAR   //   tx,ty :integer;
          desc: TCharDesc  ;
          RACE, HAIR,DRESS,WEAPON,APPR :byte;
          feature:integer ;
   magics0:string ='vvfuvGfuvvfuvvfuqvfuvvfuvvduvtxFDEhADAx>D;>prkdttqgsvtftssvwzH`FzvfyvxftvvRuvvfurvfqvsduLF>yvvfuvvzuvvfuvvfUKefuvv';

   magics1:string ='fuvvfuvvvevvfuvvfuvvfuvvjuvvPSKEU;IQWXNI^<CqfmvvfyvvfuuuslwefuzvfyvxftvvRuvvfurvfqvsduhtfzvvfuvvfuvvfuvvfUKefuvvfu';
   magics2:string ='vvfuvvvevvfuovfuvsfvvvuuvtWCR?cBIIKWQDY?vvjuyvvuvvfuwwlvxdfnzvfyvxftvvRuvvfurvfqvsduvvTuvvfuvvfmvvfuvvve]ahz^iijuz';
   magics3:string ='fsvvfeFHjAqvfyvvfvvv_uvt]CADISIQRXGDYGvv]usv_qvvfuywqkydhrzvfyvxftvvRuvvfurvfqvsduat>zvvfuvvfuvvfuvv>uvvfuwvfuvu@U';
   magics4:string ='gtBr^jhnpvfyvufvvv`uvtsFFE=IPJ[HD;>prk]ttm_ovvfuxzlwxkXlzvfyvxftvvRuvvfurvfqvsduJF>qvvfuvvfuvvfuvvwuvvfuBWCrtzfzvv';
   magics5:string ='fuvvfupsfuvufuvvauvveC=O<;QFWY?;>lrk^tumiovvfsxynvzkXlzvfyvxftvvRuvvfurvfqvsduJFRqvvfuts\uvsfuvvwuvvfuVKeevvfuvvfuvvfu';


function SaveLog(LogStr:String):integer;
var
   Log:textfile;
begin
   assignfile(Log,'c:\PackLog.txt');
   if fileexists('c:\PackLog.txt')=false then rewrite(Log)
   else append(Log);
   Writeln(Log,LogStr);
   closefile(Log);
end;


Function  RACEfeature(Feature:Integer):byte;
begin
  result:=(LoByte(Loword(Feature)) and $3F);
end;

Function  WEAPONfeature(Feature:Integer):byte;
begin
  result:=HiByte(LoWord(Feature));
end;



Function  HAIRfeature(Feature:Integer):byte;
begin
    result:=LoByte(HiWord(Feature));
end;


Function  DRESSfeature(Feature:Integer):byte;
begin
  result:=HiByte(HiWord(Feature));
end;


Function  APPRfeature(Feature:Integer):Word;
begin
  result:=hiword(Feature) ;
//  result:=Loword(Feature) ;
end;

function  MakeFeature(Race,Hair,Dress,Weapon:byte):Integer;
begin
  result:=MakeLong( MakeWord(Race,weapon),MakeWord(Hair,Dress));
end;






function Encode(src, Dest: PChar; SrcLen, destlen: Integer): Integer;
var
  I, restcount, destpos: Integer;
  made, Ch, rest: Byte;
begin
  try
    restcount := 0;
    rest := 0;
    destpos := 0;
    for I := 0 to SrcLen - 1 do
    begin
      if destpos >= destlen then
        Break;
      Ch := Byte(src[I]);
      made := Byte((rest or (Ch shr (2 + restcount))) and $3F);
      rest := Byte(((Ch shl (8 - (2 + restcount))) shr 2) and $3F);
      Inc(restcount, 2);

      if restcount < 6 then
      begin
        Dest[destpos] := Char(made + $3C);
        Inc(destpos);
      end
      else
      begin
        if destpos < destlen - 1 then
        begin
          Dest[destpos] := Char(made + $3C);
          Dest[destpos + 1] := Char(rest +$3C);
          Inc(destpos, 2);
        end
        else
        begin
          Dest[destpos] := Char(made + $3C);
          Inc(destpos);
        end;
        restcount := 0;
        rest := 0;
      end;

    end;
    if restcount > 0 then
    begin
      Dest[destpos] := Char(rest + $3C);
      Inc(destpos);
    end;
    Dest[destpos] := #0;

  finally
    Result := destpos;
  end;
end;


function Decode(pszSrc, pszDest: PChar; nDestLen: Integer): Integer;
var
  I,
    nLen,
    nDestPos,
    nBitPos,
    nMadeBit: Integer;
  chCode,
    chTemp,
    tmp: Byte;
  Decode6BitMask: array[0..4] of Char;
begin
  nLen := StrLen(pszSrc);
  nDestPos := 0;
  nBitPos := 2;
  nMadeBit := 0;

  Decode6BitMask[0] := Char($FC);
  Decode6BitMask[1] := Char($F8);
  Decode6BitMask[2] := Char($F0);
  Decode6BitMask[3] := Char($E0);
  Decode6BitMask[4] := Char($C0);

  for I := 0 to nLen - 1 do //Iterate
  begin
    if pszSrc[I] >= Char($3C) then
    begin
      chTemp := Byte(Integer(pszSrc[I]) - $3C);
    end
    else
    begin
      nDestPos := 0;
      Break;
    end;

    if nDestPos >= nDestLen then
    begin
      Break;
    end;

    if nMadeBit >= 2 then
    begin
      chCode := Byte(Char(Integer(tmp) or ((Integer(chTemp) and ($3F)) shr (6 -
        nBitPos))));
      pszDest[nDestPos] := Char(chCode);
      Inc(nDestPos);

      nMadeBit := 0;

      if nBitPos < 6 then
      begin
        Inc(nBitPos);
        Inc(nBitPos);
      end
      else
      begin
        nBitPos := 2;
        Continue;
      end;
    end;

    tmp := Byte((Integer(chTemp) shl nBitPos) and (Integer(Decode6BitMask[nBitPos
      - 2])));
    nMadeBit := nMadeBit + 8 - nBitPos;
  end;

  pszDest[nDestPos] := #0;
  Result := nDestPos;
end;




function CSDecode(pIn: string; pOut: pChar; Size: word): word;
var b1, b2, b3: byte;
  c1, c2, c3, c4: byte;
  i, oPtr: word;
  x, y: word;
begin
  //  i := 0;
  oPtr := 0;
  x := Length(pIn) div 4;
  if Length(pIn) > 3 then
    for i := 0 to x - 1 do begin
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
  if y = 2 then begin
    c1 := ord(pIn[x * 4 + 1]) - $3B;
    c2 := ord(pIn[x * 4 + 2]) - $3B;

    b1 := (c1 and $FC) shl 2; //11111100->11110000
    b2 := (c1 and 3); //00000011
    b3 := (c2 and 3) shl 2; //00000011->00001100
    pOut[oPtr] := chr((b1 or b2 or b3) xor $EB);
    inc(oPtr);
  end;
  if y = 3 then begin
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
  result := oPtr;
end;
//封包加密
function CSEncode(pIn: pChar; pOut: pChar; Size: word): word;
var b1, bcal: byte;
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
  while iPtr < Size do begin
    b1 := ord(pIn[iPtr]) xor $EB;
    inc(iPtr);
    if i < 2 then begin
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
    else begin
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
  if i <> 0 then begin
    pOut[oPtr] := chr(bflag2 + $3B);
    inc(oPtr);
    pOut[oPtr] := chr(0);
  end;
  result := oPtr;
end;





//var
//  EncBuf,TempBuf:PChar;
function MakeDefaultMsg(wIdent: Word;nRecog: Integer; wParam, wTag, wSeries: Word):TDefaultMessage;
begin
  Result.Recog:=nRecog;
  Result.Ident:=wIdent;
  Result.Param:=wParam;
  Result.Tag:=wTag;
  Result.Series:=wSeries;
end;

procedure Encode6BitBuf (pSrc,pDest:PChar;nSrcLen,nDestLen: integer);
var
  I,nRestCount,nDestPos:Integer;
  btMade,btCh,btRest:Byte;
begin
  nRestCount:=0;
  btRest:= 0;
  nDestPos:= 0;
  for i:= 0 to nSrcLen - 1 do begin
    if nDestPos >= nDestLen then break;
    btCh:=Byte(pSrc[i]);
    btMade:=Byte((btRest or (btCh shr (2+ nRestCount))) and $3F);
    btRest:=Byte(((btCh shl (8 - (2+ nRestCount))) shr 2) and $3F);
    Inc (nRestCount,2);

    if nRestCount < 6 then begin
      pDest[nDestPos]:=Char(btMade + $3C);
      Inc(nDestPos);
    end else begin
      if nDestPos < nDestLen - 1 then begin
        pDest[nDestPos]:=Char(btMade + $3C);
        pDest[nDestPos + 1]:=Char(btRest + $3C);
        Inc (nDestPos,2);
      end else begin
        pDest[nDestPos]:=Char(btMade + $3C);
        Inc(nDestPos);
      end;
      nRestCount:=0;
      btRest:=0;
    end;
   end;
   if nRestCount > 0 then begin
     pDest[nDestPos]:=Char(btRest + $3C);
     Inc(nDestPos);
   end;
   pDest[nDestPos]:=#0;
end;

procedure Decode6BitBuf (sSource:PChar;pBuf:PChar;nSrcLen,nBufLen:Integer);
const
  Masks: array[2..6] of byte = ($FC, $F8, $F0, $E0, $C0);
   //($FE, $FC, $F8, $F0, $E0, $C0, $80, $00);
var
  I,{nLen,}nBitPos,nMadeBit,nBufPos:Integer;
  btCh,btTmp,btByte:Byte;
begin
//  nLen:= Length (sSource);
  nBitPos:= 2;
  nMadeBit:= 0;
  nBufPos:= 0;
  btTmp:= 0;
  for I:= 0 to nSrcLen - 1 do begin
    if Integer(sSource[I]) - $3C >= 0 then
      btCh := Byte(sSource[I]) - $3C
    else begin
      nBufPos := 0;
      break;
    end;
    if nBufPos >= nBufLen then break;
    if (nMadeBit + 6) >= 8 then begin
      btByte := Byte(btTmp or ((btCh and $3F) shr (6- nBitPos)));
      pBuf[nBufPos] := Char(btByte);
      Inc(nBufPos);
      nMadeBit := 0;
      if nBitPos < 6 then Inc (nBitPos, 2)
      else begin
        nBitPos := 2;
        continue;
      end;
    end;
    btTmp:= Byte (Byte(btCh shl nBitPos) and Masks[nBitPos]);   // #### ##--
    Inc(nMadeBit, 8 - nBitPos);
  end;
  pBuf[nBufPos] := #0;

{
  nLen:= Length (sSource);
  nBitPos:= 2;
  nMadeBit:= 0;
  nBufPos:= 0;
  btTmp:= 0;
  for I:= 1 to nLen do begin
    if Integer(sSource[I]) - $3C >= 0 then
      btCh := Byte(sSource[I]) - $3C
    else begin
      nBufPos := 0;
      break;
    end;
    if nBufPos >= nBufLen then break;
    if (nMadeBit + 6) >= 8 then begin
      btByte := Byte(btTmp or ((btCh and $3F) shr (6- nBitPos)));
      pBuf[nBufPos] := Char(btByte);
      Inc(nBufPos);
      nMadeBit := 0;
      if nBitPos < 6 then Inc (nBitPos, 2)
      else begin
        nBitPos := 2;
        continue;
      end;
    end;
    btTmp:= Byte (Byte(btCh shl nBitPos) and Masks[nBitPos]);   // #### ##--
    Inc(nMadeBit, 8 - nBitPos);
  end;
  pBuf[nBufPos] := #0;
  }
end;





function DecodeMessage (str: string): TDefaultMessage;
var
  EncBuf:array[0..BUFFERSIZE - 1] of Char;
  Msg: TDefaultMessage;
begin
  Decode6BitBuf (PChar(str), @EncBuf,Length(str),SizeOf(EncBuf));
  Move (EncBuf, msg, sizeof(TDefaultMessage));
  Result := msg;
   {
   try
      EnterCriticalSection (CSencode);
      Decode6BitBuf (str, EncBuf, 1024);
      Move (EncBuf^, msg, sizeof(TDefaultMessage));
      Result := msg;
   finally
   	LeaveCriticalSection (CSencode);
   end;
   }
end;


function DecodeString (str: string): string;
var
  EncBuf:array[0..BUFFERSIZE - 1] of Char;
begin
  Decode6BitBuf (PChar(str), @EncBuf,Length(str), SizeOf(EncBuf));
  Result := StrPas (EncBuf);
{
  try
    EnterCriticalSection (CSencode);
    Decode6BitBuf (str, EncBuf, BUFFERSIZE);
    Result := StrPas (EncBuf); //error, 1, 2, 3,...
  finally
    LeaveCriticalSection (CSencode);
  end;
}
end;

procedure DecodeBuffer (src: string; buf: PChar; bufsize: integer);
var
  EncBuf:array[0..BUFFERSIZE - 1] of Char;
begin
      Decode6BitBuf (PChar(src), @EncBuf,Length(src), SizeOf(EncBuf));
      Move (EncBuf, buf^, bufsize);
   {
   try
      EnterCriticalSection (CSencode);
      Decode6BitBuf (src, EncBuf, BUFFERSIZE);
      Move (EncBuf^, buf^, bufsize);
   finally
   	LeaveCriticalSection (CSencode);
   end;
   }
end;


function  EncodeMessage (smsg: TDefaultMessage): string;
var
  EncBuf,TempBuf:array[0..BUFFERSIZE - 1] of Char;
begin
  Move (smsg, TempBuf, sizeof(TDefaultMessage));
  Encode6BitBuf(@TempBuf, @EncBuf, sizeof(TDefaultMessage), SizeOf(EncBuf));
  Result:=StrPas(EncBuf);
  {
  EnterCriticalSection(CSencode);
  try
    Move (smsg, TempBuf^, sizeof(TDefaultMessage));
    Encode6BitBuf(TempBuf, EncBuf, sizeof(TDefaultMessage), 1024);
    Result:=StrPas(EncBuf);  //Error: 1, 2, 3, 4, 5, 6, 7, 8, 9
  finally
    LeaveCriticalSection(CSencode);
  end;
  }
end;


function EncodeString (str: string): string;
var
  EncBuf:array[0..BUFFERSIZE - 1] of Char;
begin
  Encode6BitBuf(PChar(str), @EncBuf, Length(str), SizeOf(EncBuf));
  Result:=StrPas(EncBuf);
  {
  EnterCriticalSection(CSencode);
  try
    Encode6BitBuf(PChar(str), EncBuf, Length(str), BUFFERSIZE);
    Result:=StrPas(EncBuf);
  finally
    LeaveCriticalSection(CSencode);
  end;
  }
end;


function  EncodeBuffer (buf: pChar; bufsize: integer): string;
var
  EncBuf,TempBuf:array[0..BUFFERSIZE - 1] of Char;
begin
  if bufsize < BUFFERSIZE then begin
    Move (buf^, TempBuf, bufsize);
    Encode6BitBuf (@TempBuf, @EncBuf, bufsize, SizeOf(EncBuf));
    Result := StrPas (EncBuf);
  end else Result := '';
  {
  EnterCriticalSection (CSencode);
  try
    if bufsize < BUFFERSIZE then begin
      Move (buf^, TempBuf^, bufsize);
      Encode6BitBuf (TempBuf, EncBuf, bufsize, BUFFERSIZE);
      Result := StrPas (EncBuf);
    end else Result := '';
  finally
    LeaveCriticalSection (CSencode);
  end;
  }
end;

procedure SeparateTerms(s : string;Separator : char;Terms : TStringList);
{ This browses a string and divide it into terms whenever the given
  separator is found. The separators will be removed }
  var
  hs : string;
  p : integer;

begin
  Terms.Clear; // First remove all remaining terms
  if Length(s)=0 then   // Nothin' to separate
    Exit;
  p:=Pos(Separator,s);
  while P<>0 do
  begin
    hs:=Copy(s,1,p-1);   // Copy term
    Terms.Add(hs);       // Add to list
    Delete(s,1,p);       // Remove term and separator
    p:=Pos(Separator,s); // Search next separator
  end;
  if Length(s)>0 then
    Terms.Add(s);        // Add remaining term
end;

function UnNameCode(pin:pchar;pout:pchar):word ;
var
	i:integer ;
  b1,b2:byte;
 // t:array[0..100] of char;
begin
//fillchar(t,sizeof(t),0);
  i:=0;
	while pin[i] <> chr(0) do   //   i<>strlen(pin)
  begin
  	b1 :=  (byte(pin[i]) and $3f ) shl  2;
  	b2 :=   b1 or ((byte(pin[i+ 1]) and $c0 ) shr 6);
  //  t[i]:=chr(b2);
    pout[i] := chr(b2);
    //	byte(pout[i]) :=b2;
  	inc(i);
	end;
 // t[i]:=#0;
  pout[i]:=#0;
// 	pout:= @t[0];
//  copymemory(pout,@t[0],strlen(@t[0]));
	UnNameCode:= 1;
end;


function cs2mir(s:pchar;var username:string; var tx:integer; var ty:integer):pchar;
var
temp1:array[0..2000]of char ;
temp2:array[0..2000]of char ;
len,tlen:integer;
msg:tgamemsg;
 s1,s2:string;

 Terms : TStringList;

begin
  if s[0]<>'#' then begin
  cs2mir:=s;
 //  form1.Memo1.Lines.Add('not send #'+s);
  exit;
  end;

   Terms:=TStringList.Create;

   len:=StrLen(s)-3 ;
   fillchar(temp1,sizeof(temp1),0);
   fillchar(temp2,sizeof(temp1),0);

   copymemory(@temp1[0],@s[2],len);
 //   form1.Memo1.Lines.Add(pchar(@s[0]));

   tlen:=CSdeCode(strpas(@temp1[0]), @temp2[0],len);

   fillchar(msg,sizeof(msg),0);
   copymemory(@msg,@temp2[0],tlen);
//   form1.Memo1.Lines.Add(msg.data);

    if msg.wcmd=$07d1 then
   begin
      msg.wFlagh:=0;
      msg.wFlaglh:=0;
      msg.wFlagll:=0;
      SeparateTerms(msg.data,'/',Terms);
      username:=terms[0];
   end;


   if msg.wcmd=101 then //发出建立人物
   begin
     s2:='';
     SeparateTerms(msg.data,'/',Terms);
     s2:=s2+terms[0]+'/';
     s2:=s2+terms[1]+'/';
     s2:=s2+'1/';
     s2:=s2+terms[3]+'/';
     s2:=s2+terms[4];
     strpcopy(msg.data,s2);
   end;

  IF (MSG.wcmd=3011) OR (MSG.wcmd=3013) THEN
 BEGIN
  tx:=msg.wFlagh;
  ty:=makeword(msg.wFlaglh,msg.wFlagll);

 END;
 

   copymemory(@temp2[0],@msg,tlen);


   fillchar(temp1,sizeof(temp1),0);

   copymemory(@temp1[0],@s[0],2);


   tlen:=Encode (@temp2[0],@temp1[2],tlen,2000);
   temp1[tlen+2]:='!';
   temp1[tlen+3]:=#0;

   cs2mir:=@temp1[0];
   Terms.Free;
end;

function mir2cs(s:pchar;slen:integer;var username:string;tx,ty:integer;var tfx,tfy:integer;var mysex:byte):pchar;
var
temp1:array[0..5000]of char ;
temp2:array[0..5000]of char ;
len,tlen:integer;
msg:tgamemsg;
Terms : TStringList;
s1,s2:array[0..100] of char;
stlen:integer;

magicflag:string;
temp:array[0..5000]of char;
i,j:integer;
miritem:tmiritem ;
csitem:tcsitem;
sendbuf:array[0..5000] of char;
hand:array[0..100]of char;
body:array[0..5000]of char;
itemstring:string;
sendmsg:tgamemsg;
pcm: TcsMAGIC;//TClientMagic;
rcvok:string;
lbyte,hbyte:byte;
tempdword:dword;
 sex:integer;
magtype,mageffect:byte;
begin


   Terms:=TStringList.Create;
   len:=slen -1  ;
   fillchar(temp1,sizeof(temp1),0);
   fillchar(temp2,sizeof(temp2),0);
   fillchar(body,sizeof(body),0);
   fillchar(hand,sizeof(hand),0);
   fillchar(sendbuf,sizeof(sendbuf),0);
   fillchar(temp,sizeof(temp),0);
  
   copymemory(@temp1[0],@s[1],len );        // 去掉 # ！
   len:= len -1  ;
if temp1[0]<> '+'  then
 begin
   copymemory(@hand[0],@temp1[0],16);
   copymemory(@body[0],@temp1[16], len-16);
   tlen:=deCode (@hand[0], @temp2[0],16);

   fillchar(msg,sizeof(msg),0);
   copymemory(@msg,@temp2[0],tlen);


   fillchar(temp2,sizeof(temp2),0);
   tlen:=deCode (@body[0], @temp2[0],5000);

   copymemory(@msg.data[0],@temp2[0],tlen);
   tlen:=tlen+12;
   if msg.wcmd=529 then
   begin
     strpcopy(@msg.data[0],username);   //收到登陆命令,返回用户名
   end;



 if msg.wcmd= 504  then //          SM_NEWID_SUCCESS = 504; //创建新ID成功
    begin
    end;
                               // SM_NEWID_FAIL = 505; //新ID失败

 if msg.wcmd= 505  then //
    begin
//    MessageBox(application.Handle,PChar('帐号建立失败'),'警告', MB_ICONWARNING);
  //  showmessage('帐号建立失败') ;
 //   exit;
    end;




    if msg.wcmd=$0212 then                   //selchargate
   begin
    //  SeparateTerms(msg.data,'/',Terms);
   //   id:=terms[2];
   end;


     if msg.wcmd=50 then            //登陆游戏成功
   begin
    username:='%loginok$'  ;
    mysex:=1;                    /// 0=man 1=women;              //	w3bl = dir
    msg.w3:= MakeWord(msg.w3,mysex);                             //	w3bh = sex;

   end;

   if (msg.wcmd=10) then          //人物出现,
   begin

   copymemory(@desc,@msg.data[0],sizeof(TCharDesc)) ;

   race:=RACEfeature(desc.feature) ;
   weapon:=WEAPONfeature(desc.Feature);
   hair:=HAIRfeature(desc.Feature);

   dress:=DRESSfeature(desc.Feature);

 //  APPR:=APPRfeature(desc.Feature);
   if race= 0 then begin
     sex:=  dress  mod 2 ;           //Dress=   feature and  $fc0
     Weapon:= round((Weapon-sex) /2);
 //   hair:=   round((hair-sex)/2)+sex  ;

   //  dress:=  round((dress-sex)/2)   ;
     desc.Feature:=MakeFeature(Race,Hair,Dress,Weapon) ;
     copymemory(@msg.data[0],@desc,sizeof(TCharDesc))  ;
    end;

     if msg.data[8]<>char(#0) then
      begin


            UnNameCode(@msg.data[8],s1);      //  先解码
          //  strpcopy(@s1[strlen(@s1[0])],'/255');        //  /250/255
            s1[strlen(@s1[0])-1]:='5';                         'J]gkxtfw@vZEvveu  pveuvvfuvvE JGKYADbJIDMZAkTtqqJ'
            tempdword:= makelong(100,100) ;                  //'J]gkxtfw@vZEvveu  pveuvvfuvvE ^vJiv=   JGKYADbJIDMZAkTtqqJ'
            copymemory(@msg.data[8],@tempdword,4);           // J]gkxtfw@vZEvveu  vviEvvfuvvJ ev^fv  ][Ue][D[abCc`qHirkTtqqJ  标准
            copymemory(@msg.data[12],@s1[0],strlen(@s1[0]));//               vveuvviEvvfuvvJev^fv][Ue][D[abCc`qHirkTtqqJ     


   //  SaveLog(format('flag=%d wcmd=%d w1=%d w2=%d w3=%d data=%s',[msg.wFlagh,msg.wcmd,msg.w1,msg.w2,msg.w3,msg.data]));

            tlen:=12+12+strlen(@s1[0]);
      end;
   end;


    if msg.wcmd=31 then
     begin
  
  //    msg.w1:=round(msg.w1/msg.w2*100);
  //    msg.w3:=round(msg.w3/msg.w2*100);
 //   msg.w2:=100 ;
  
//recvflag=56312 wcmd=31 w1=35 w2=50 w3=8 data= 减少 8的生命，剩下35的生命，总共50 的生命.",
						
//s.Format("(%x)减少8的生命，剩下35的生命，总共50的生命.",


     end;

    if msg.wcmd=52 then            //sm_ablity
   begin
    msg.w1:=msg.w1-25344;               //这里必须为JOB
    msg.w2:=mysex;                   
   end;



if msg.wcmd=211 then  //技能     已经学会的摸法
   begin
    itemstring:= strpas(@body[0]) ;
  //  SaveLog(format('flag=%d wcmd=%d w1=%d w2=%d w3=%d data=%s',[msg.wFlagh,msg.wcmd,msg.w1,msg.w2,msg.w3,itemstring]));

    SeparateTerms(itemstring,'/',Terms);
     msg.w3:=terms.count;
    fillchar(body,sizeof(body),0);

   for i:=0 to  msg.w3-1 do
   begin
     //if  terms[i]='' then break;
     fillchar(temp,sizeof(temp),#0);
     fillchar(pcm,sizeof(pcm),#0);

     len:=deCode(pchar(terms[i]), @temp[0],10000);
     copymemory(@pcm,@temp[0],len);
     if pcm.Def.wMagicID=2 then pcm.Def.xx:=57;
      if (pcm.Def.wMagicID=13) or (pcm.Def.wMagicID=14)  then pcm.Def.xx:=41;
  //   pcm.Def.xx:=41;
 //    pcm.undown1:=20000;
     copymemory (@body[sizeof(TcsMAGIC)*i],@pcm,sizeof(TcsMAGIC));

   end;
  fillchar(msg.data,sizeof(msg.data),0);
  copymemory(@msg.data[0],@body[0],sizeof(TcsMAGIC)*msg.w3) ;
//  SaveLog(format('flag=%d wcmd=%d w1=%d w2=%d w3=%d data=%s',[msg.wFlagh,msg.wcmd,msg.w1,msg.w2,msg.w3,msg.data]));

  tlen:=12+ sizeof(TcsMAGIC)*msg.w3;
  msg.w3:=0;
 //  magicflag:='ismagic';
end;


if msg.wcmd=610  then //地上出现物品
  begin
  if msg.data='金币' then
  msg.w3:=msg.w3+113;
  end;


 if msg.wcmd=615 then  //穿上戴上成功         41 //外型变化
   begin
  //  msg.wcmd:=4116  ;
{    hbyte:=HiByte(msg.wFlagh);
   lbyte:=lobyte(msg.wFlagh);
      hbyte:=round((hbyte-1) /2);
    wshape:= hbyte;
    msg.wFlagh:=makeword(lbyte,hbyte);

  copymemory(@tempdword,@msg,4);
 form1.Memo3.Lines.Add('戴上'+ format('flagh=%d flaglh=%d flagll=%d wcmd=%d 外观=%d ',[msg.wFlagh,msg.wFlaglh,msg.wFlagll,msg.wcmd,HiByte(LoWord(tempdword))]));
  }
   end;

   if (msg.wcmd=41)     then    //   41 //外型变化
   begin

   tempdword:=makelong(msg.w1,msg.w2);     //LoWord(Feature)=msg.w1  makelong(低16，高16)；
   copymemory(@feature,@tempdword,4);
   race:=RACEfeature( feature) ;
   weapon:=WEAPONfeature( Feature);
   hair:=HAIRfeature( Feature);
   dress:=DRESSfeature( Feature);

   if race= 0 then begin
    sex:=  dress  mod 2 ;           //Dress=   feature and  $fc0
    mysex:= dress  mod 2 ;
    Weapon:= round((Weapon-sex) /2);
 //   hair:=   round((hair-sex)/2)+sex;
  //  dress:=   round((dress-sex)/2) ;
   if dress=1 then dress:=0;
    msg.w1:= MakeWord( Race, weapon) ;
    msg.w2:= MakeWord( Hair,Dress) ;
    msg.w3:=MakeWord(0,sex);            //   这里必须为性别
    end;
  
  { if  LoByte(msg.w1) =0 then         //race =0 说明是人物， =50 是NPC
    begin
    sex:=   feature.dress  mod 2 ;           //Dress=   feature and  $fc0
    feature.Weapon:= round((feature.Weapon-sex) /2);
    msg.w1:=MakeWord(feature.Race,feature.weapon) ;
    end;   }
  end;

 if (msg.wcmd=801)or (msg.wcmd=802) or (msg.wcmd=10) or  (msg.wcmd=11) or (msg.wcmd=13) or (msg.wcmd=751) then     //外形变化  (msg.wcmd=807)or  or (msg.wcmd=20)  or (msg.wcmd=33)or (msg.wcmd=27)or
 begin
   copymemory(@desc,@msg.data[0],sizeof(TCharDesc)) ;

   race:=RACEfeature(desc.feature) ;
   weapon:=WEAPONfeature(desc.Feature);
   hair:=HAIRfeature(desc.Feature);

    dress:=DRESSfeature(desc.Feature);

 //  APPR:=APPRfeature(desc.Feature);
   if race= 0 then begin
    sex:=  dress  mod 2 ;           //Dress=   feature and  $fc0
    Weapon:= round((Weapon-sex) /2);
 //   hair:=   round((hair-sex)/2)+sex  ;
   //  dress:=  dress+sex;
   if dress=1 then dress:=0;
  //   dress:=  round((dress-sex)/2)   ;
     desc.Feature:=MakeFeature(Race,Hair,Dress,Weapon) ;
     copymemory(@msg.data[0],@desc,sizeof(TCharDesc))  ;
    end;

 end;


 if msg.wcmd=SM_SPELL then begin         //17

  copymemory(@msg.data[0] , @body[0],strlen(@body[0]) );
  itemstring:=strpas(@body[0]);
 // copymemory(@tempdword,@msg.data[0],2);
//   msg.w3:=strtoint(itemstring);//- 3; // ; btEffect

 end;

  if msg.wcmd=SM_MAGICFIRE then begin      //SM_MAGICFIRE=638
//   msg.w3:=3081;    //MakeWord(UserMagic.MagicInfo.btEffectType,UserMagic.MagicInfo.btEffect)
  magtype:= lobyte(msg.w3);
  mageffect:= hibyte (msg.w3);

   msg.w3:=makeword(magtype,mageffect) ;


  end;


 if msg.wcmd=SM_HEAVYHIT then begin    //15

 copymemory(@msg.data[0] , @body[0],strlen(@body[0]) );


 end;


{
  SM_TURN               = 10;
  SM_WALK               = 11;   //走
  SM_SITDOWN            = 12;
  SM_RUN                = 13;    }
 //  msg.w1:
 //   hbyte:=HiByte(msg.wFlagh);
 //   lbyte:=lobyte(msg.wFlagh);
 //   hbyte:= wshape;
 //   msg.wFlagh:=makeword(lbyte,hbyte);
 // copymemory(@tempdword,@msg,4);
// if feature.Race=0 then
 //  form1.Memo3.Lines.Add('外型变化 '+ format('wcmd=%d w1=%x w2=%x feature=%x ,dress=%x ,Weapon=%d',[msg.wcmd,msg.w1,msg.w2,makelong(msg.w1,msg.w2),feature.dress ,feature.Weapon]));

 //  end;

if msg.wcmd=621 then      //身上穿戴物品
begin
   itemstring:= strpas(@body[0]) ;
   SeparateTerms(itemstring,'/',Terms);
   msg.w3:=round(terms.count/2) ;
   fillchar(body,sizeof(body),0);

   i:=1;
   j:=0;
   while i< terms.count do
   begin
    // savelog2('terms/body'+inttostr(i)+ terms[i]);
     if terms[i]='' then break;
     fillchar(temp,sizeof(temp),0);
     fillchar(miritem,sizeof(miritem),0);
     fillchar(csitem,sizeof(csitem),0);

     len:=deCode(pchar(terms[i]), @temp[0],10000);
   //  savelog2('terms/body decode'+inttostr(i)+ strpas(temp));
     copymemory(@miritem,@temp[0],len);
     csitem.id:=strtoint(terms[i-1]);
     csitem.item:=miritem;
   //   csitem.item.shape:=round(csitem.item.shape / 2) ;
 //  csitem.item.Looks:=  csitem.item.Shape;
 //   csitem.item.Looks := csitem.item.Source  ;
  //    csitem.item.MakeIndex:=csitem.item.Shape;
   //   csitem.item.
   //  form1.memo4.lines.add(miritem.Name);
     copymemory (@body[sizeof(csitem)*j],@csitem,sizeof(csitem));
 //    form1.Memo4.Lines.Add(format('cstiem:%s',[StrToASCII(@body[0],sizeof(csitem)*(i+1))]));
     i:=i+2;
     j:=j+1;
   end;
  copymemory(@msg.data[0],@body[0],sizeof(csitem)*j) ;
  tlen:=12+ sizeof(csitem)*j;



end;




 if msg.wcmd=652 then  ////详细货物列表
 begin
   itemstring:= strpas(@msg.data[0]) ;
   SeparateTerms(itemstring,'/',Terms);
   msg.w3:=terms.count ;
   fillchar(body,sizeof(body),0);

   for i:=0 to  terms.count-1 do
   begin
    // savelog2('terms/body'+inttostr(i)+ terms[i]);
     if  terms[i]='' then break;
     fillchar(temp,sizeof(temp),0);
     fillchar(miritem,sizeof(miritem),0);

     len:=deCode(pchar(terms[i]), @temp[0],10000);
   //  savelog2('terms/body decode'+inttostr(i)+ strpas(temp));
     copymemory(@miritem,@temp[0],len);
   //  form1.memo4.lines.add(miritem.Name);
     copymemory (@body[sizeof(miritem)*i],@miritem,sizeof(miritem));
 //    form1.Memo4.Lines.Add(format('cstiem:%s',[StrToASCII(@body[0],sizeof(csitem)*(i+1))]));

   end;
  copymemory(@msg.data[0],@body[0],sizeof(miritem)*terms.count) ;
  tlen:=12+ sizeof(csitem)*terms.count;

 end;



 if msg.wcmd=704 then  ////仓库内容列表
 begin
   itemstring:= strpas(@body[0]) ;
   SeparateTerms(itemstring,'/',Terms);
    msg.w3:=terms.count ;
   fillchar(body,sizeof(body),0);

   for i:=0 to  terms.count-1 do
   begin
    // savelog2('terms/body'+inttostr(i)+ terms[i]);
     if  terms[i]='' then break;
     fillchar(temp,sizeof(temp),0);
     fillchar(miritem,sizeof(miritem),0);

     len:=deCode(pchar(terms[i]), @temp[0],10000);
   //  savelog2('terms/body decode'+inttostr(i)+ strpas(temp));
     copymemory(@miritem,@temp[0],len);

  //   csitem.id:=i;
  //   csitem.item:=miritem;
   //   form1.memo1.lines.add(miritem.Name);
       copymemory (@body[sizeof(miritem)*i],@miritem,sizeof(miritem));
     //    copymemory (@body[sizeof(csitem)*i],@csitem,sizeof(csitem));
 //    form1.Memo4.Lines.Add(format('cstiem:%s',[StrToASCII(@body[0],sizeof(csitem)*(i+1))]));

   end;
  copymemory(@msg.data[0],@body[0],sizeof(miritem)*terms.count) ;
 //   copymemory(@msg.data[0],@body[0],sizeof(csitem)*i) ;

  tlen:=12+ sizeof(csitem)*terms.count;

 end;


 ////包裹处理
if msg.wcmd=$00c9 then  //201

begin
//   form1.Memo4.Lines.Add(body);

 //  copymemory(@body[0],@temp1[17],strlen(@temp1[0])-16);
 //   savelog2('$00c9:temp1'+ temp1);
 //   savelog2('======>$00c9:body'+body);
   itemstring:= strpas(@body[0]) ;
   SeparateTerms(itemstring,'/',Terms);
   msg.w3:=terms.count ;
   fillchar(body,sizeof(body),0);

   for i:=0 to msg.w3-1 do
   begin
    // savelog2('terms/body'+inttostr(i)+ terms[i]);
     fillchar(temp,sizeof(temp),0);
     fillchar(csitem,sizeof(csitem),0);
     fillchar(miritem,sizeof(miritem),0);

     len:=deCode(pchar(terms[i]), @temp[0],10000);
   //  savelog2('terms/body decode'+inttostr(i)+ strpas(temp));
     copymemory(@miritem,@temp[0],len);
   //   miritem.shape:=(miritem.shape -1) shl 2 ;

 //    form1.memo4.lines.add(miritem.Name);
{     csitem.Name:=miritem.Name;
     csitem.StdMode:=miritem.StdMode;
     csitem.Shape:=miritem.Shape;
     csitem.Weight:=miritem.Weight;
     csitem.AniCount:=miritem.AniCount;
     csitem.SpecialPower:=0;
     csitem.NeedIdentify:=miritem.NeedIdentify;
     csitem.Looks:=miritem.Looks;
     csitem.DuraMax1:=miritem.DuraMax1;
     csitem.AC:=miritem.AC;
     csitem.MAC:=miritem.MAC;
     csitem.DC:=miritem.DC;
     csitem.MC:=miritem.MC;
     csitem.SC:=miritem.SC;
     csitem.Need:=miritem.Need;
     csitem.NeedLevel:=miritem.NeedLevel;
     csitem.Price:=miritem.Price;
     csitem.MakeIndex:=miritem.MakeIndex;
     csitem.Dura:=miritem.Dura;
     csitem.DuraMax:=miritem.DuraMax;  }
     copymemory (@body[sizeof(miritem)*i],@miritem,sizeof(miritem));
 //    form1.Memo4.Lines.Add(format('cstiem:%s',[StrToASCII(@body[0],sizeof(csitem)*(i+1))]));

   end;
  copymemory(@msg.data[0],@body[0],sizeof(csitem)*msg.w3) ;
  tlen:=12+ sizeof(csitem)*msg.w3;
end;


{  if msg.wcmd=658   then
   begin
    msg.wFlagh:=0;
    msg.wFlaglh:= 0;
    msg.wFlagll:= 0;
   end; }

   copymemory(@temp2[0],@msg,tlen);
 //  SaveLog1('recv string '+ format('flag=%s wcmd=%s w1=%s w2=%s w3=%s data=%s',[StrToASCII(@temp2[0],4),StrToASCII(@temp2[4],2),StrToASCII(@temp2[6],2),StrToASCII(@temp2[8],2),StrToASCII(@temp2[10],2),PChar(@temp2[12])]));



   fillchar(temp1,sizeof(temp1),0);
   copymemory(@temp1[0],@s[0],1);
   tlen:=csEncode (@temp2[0],@temp1[1],tlen);
   temp1[tlen+1]:='!';
   temp1[tlen+2]:=#0;
   copymemory(@sendbuf[0],@temp1[0],strlen(@temp1[0]));
   mir2cs:=@sendbuf[0];
//   if magicflag='ismagic' then     begin
//     mir2cs:=pchar('#'+magics0+magics1+magics2+magics3+magics4+magics5+'!');
//     magicflag:='';
 //  end;

end               //普通包
   else           //如果是 #+GOOD .
     begin
       if (temp1[1]='G') or (temp1[1]='P') or (temp1[1]='F')  then
      begin
       IF temp1[1]='G' THEN
        begin
        rcvok:='#+G/';      //#+FL/697/658!
        Rcvok:=rcvok+inttostr(tx)+'/'+inttostr(ty)+'!';
        tfx:=tx;
        tfy:=ty;
        end;
        if temp1[1]='F' THEN rcvok:='#+FL/'+inttostr(tfx)+'/'+inttostr(tfy)+'!';
        copymemory(@sendbuf[0],pchar(rcvok),length(rcvok));
     //   copymemory(@sendbuf[0],s,slen);
        mir2cs:=@sendbuf[0];
       // form1.Memo3.Lines.Add(sendbuf);

      end
        else
        begin
      //   copymemory(@sendbuf[0],s,slen);
       //  mir2cs:=@sendbuf[0];
          mir2cs:='*' ;
    //    form1.Memo3.Lines.Add(pchar(@temp1[0]));

        end;
 //     copymemory(@sendbuf[0],@s[0],slen);
     end;

     Terms.Free;



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
