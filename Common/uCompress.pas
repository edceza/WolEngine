unit uCompress;

interface

uses
  Windows, Messages, SysUtils, Variants, NB30, Classes, ComCtrls, Dialogs,
    Function1, Function2, function3, function4, function5, Function6, Function7,
    function8, MD5,Math,myunits;

// 压缩/解压文件
procedure CompressFile(Source, Target: string); stdcall;
procedure DecompressFile(Source, Target: string); stdcall;

// 压缩/解压文件到流
procedure CompressToStream(FileName: string; Stream: TStream); stdcall;
procedure DecompressToStream(FileName: string; Stream: TStream); stdcall;

// 压缩/解压流
procedure CompressStream(InStream, OutStream: TStream); stdcall;
procedure DecompressStream(InStream, OutStream: TStream); stdcall;

function MyEncodeString(Str: string; Key: string;count:integer=1): string;
function MyDecodestring(Str: string; Key: string;count:integer=1): string;

implementation

uses
  ZLib, Base64;

const
  COMPRESS_ERROR                        = '压缩文件时出现内部错误:';
  DECOMPRESS_ERROR                      = '解压文件时出现内部错误:';
  COMPRESS_STRM_ERROR                   = '压缩流时出现内部错误:';
  DECOMPRESS_STRM_ERROR                 = '解压流时出现内部错误:';
  BufSize                               = $4096;





// 压缩文件

procedure CompressFile(Source, Target: string);
var
  i                                     : Integer;
  Buf                                   : array[0..BufSize] of Byte;
  ComStream                             : TCompressionStream;
  InStream, OutStream                   : TFileStream;
begin
  if not FileExists(Source) then
    Exit;
  InStream := nil;
  OutStream := nil;
  ComStream := nil;
  try
    // 生成流
    InStream := TFileStream.Create(Source, fmOpenRead or fmShareDenyNone);
    OutStream := TFileStream.Create(Target, fmCreate or fmShareDenyWrite);
    ComStream := TCompressionStream.Create(clMax, OutStream);

    // 压缩流
    for i := 1 to (InStream.Size div BufSize) do
    begin
      InStream.ReadBuffer(Buf, BufSize);
      ComStream.Write(Buf, BufSize);
    end;

    i := InStream.Size mod BufSize;
    if (i > 0) then
    begin
      InStream.ReadBuffer(Buf, i);
      ComStream.Write(Buf, i);
    end;

    InStream.Free;
    InStream := nil;

    // 注先后
    ComStream.Free;
    ComStream := nil;

    // 在此写加密流代码(要先释放 ComStream)
    // EncryptStream(OutStream);

    OutStream.Free;
    OutStream := nil;
  except
    on E: Exception do
    begin
      if (InStream <> nil) then
        InStream.Free;
      if (OutStream <> nil) then
        OutStream.Free;
      if (ComStream <> nil) then
        ComStream.Free;
      MessageDlg(COMPRESS_ERROR + #10 + E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

// 解压文件

procedure DecompressFile(Source, Target: string);
var
  i                                     : Integer;
  Buf                                   : array[0..BufSize] of Byte;
  DecomStream                           : TDecompressionStream;
  MemStream                             : TMemoryStream;
  OutStream                             : TFileStream;
begin
  if not FileExists(Source) then
    Exit;

  MemStream := nil;
  OutStream := nil;
  DecomStream := nil;
  try
    // 生成流
    // 先读文件到 MemStream 中解密(Source 只读).
    // DecomStream 的开始位置 = MemStream.Position
    MemStream := TMemoryStream.Create;
    MemStream.LoadFromFile(Source);
    // 在此写解密流代码
    // DecryptStream(MemStream);

    OutStream := TFileStream.Create(Target, fmCreate or fmShareDenyWrite);
    DecomStream := TDecompressionStream.Create(MemStream);

    {   InStream := TFileStream.Create(Source, fmOpenRead or fmShareDenyNone);
        OutStream := TFileStream.Create(Target, fmCreate or fmShareDenyWrite);
        DecomStream := TDeCompressionStream.Create(InStream); }

        // 解压流
    repeat
      i := DecomStream.Read(Buf, BufSize);
      OutStream.WriteBuffer(Buf, i);
    until (i = 0);

    // 注意先后
    OutStream.Free;
    OutStream := nil;

    DecomStream.Free;
    DecomStream := nil;

    MemStream.Free;
    MemStream := nil;
  except
    on E: Exception do
    begin
      if (MemStream <> nil) then
        MemStream.Free;
      if (OutStream <> nil) then
        OutStream.Free;
      if (DecomStream <> nil) then
        DecomStream.Free;
      MessageDlg(DECOMPRESS_ERROR + #10 + E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

// 压缩文件到流

procedure CompressToStream(FileName: string; Stream: TStream);
var
  i                                     : Integer;
  Buf                                   : array[0..BufSize] of Byte;
  ComStream                             : TCompressionStream;
  InStream                              : TFileStream;
begin
  if not FileExists(FileName) then
    Exit;
  InStream := nil;
  ComStream := nil;
  try
    // 生成流
    InStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    ComStream := TCompressionStream.Create(clMax, Stream);

    // 压缩流
    for i := 1 to (InStream.Size div BufSize) do
    begin
      InStream.ReadBuffer(Buf, BufSize);
      ComStream.Write(Buf, BufSize);
    end;

    i := InStream.Size mod BufSize;
    if (i > 0) then
    begin
      InStream.ReadBuffer(Buf, i);
      ComStream.Write(Buf, i);
    end;

    InStream.Free;
    InStream := nil;

    ComStream.Free;
    ComStream := nil;

    // 在此写加密流代码(要先释放 ComStream), Postion = 0
    // EncryptStream(Stream);
  except
    on E: Exception do
    begin
      if (InStream <> nil) then
        InStream.Free;
      if (ComStream <> nil) then
        ComStream.Free;
      MessageDlg(COMPRESS_ERROR + #10 + E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

// 解压文件到流

procedure DecompressToStream(FileName: string; Stream: TStream);
var
  i                                     : Integer;
  Buf                                   : array[0..BufSize] of Byte;
  DecomStream                           : TDecompressionStream;
  MemStream                             : TMemoryStream;
begin
  if not FileExists(FileName) then
    Exit;
  MemStream := nil;
  DecomStream := nil;
  try
    // 生成流
    // 先读文件到 MemStream 中解密(FileName 只读).
    // DecomStream 的开始位置 = MemStream.Position
    MemStream := TMemoryStream.Create;
    MemStream.LoadFromFile(FileName);
    // 在此写解密流代码
    // DecryptStream(MemStream);

    DecomStream := TDecompressionStream.Create(MemStream);

    // 解压流, Postion = 0
    repeat
      i := DecomStream.Read(Buf, BufSize);
      Stream.WriteBuffer(Buf, i);
    until (i = 0);
    Stream.Position := 0;

    DecomStream.Free;
    DecomStream := nil;

    MemStream.Free;
    MemStream := nil;
  except
    on E: Exception do
    begin
      if (MemStream <> nil) then
        MemStream.Free;
      if (DecomStream <> nil) then
        DecomStream.Free;
      MessageDlg(DECOMPRESS_ERROR + #10 + E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

// 压缩流

procedure CompressStream(InStream, OutStream: TStream);
var
  i                                     : Integer;
  Buf                                   : array[0..BufSize] of Byte;
  ComStream                             : TCompressionStream;
begin
  ComStream := nil;
  try
    InStream.Position := 0;
    ComStream := TCompressionStream.Create(clMax, OutStream);

    for i := 1 to (InStream.Size div BufSize) do
    begin
      InStream.ReadBuffer(Buf, BufSize);
      ComStream.Write(Buf, BufSize);
    end;

    i := InStream.Size mod BufSize;
    if (i > 0) then
    begin
      InStream.ReadBuffer(Buf, i);
      ComStream.Write(Buf, i);
    end;

    ComStream.Free;
    ComStream := nil;

    // 在此写加密流代码
    // EncryptStream(OutStream);
  except
    on E: Exception do
    begin
      if (ComStream <> nil) then
        ComStream.Free;
      MessageDlg(COMPRESS_STRM_ERROR + #10 + E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

// 解压流

procedure DecompressStream(InStream, OutStream: TStream);
var
  i                                     : Integer;
  Buf                                   : array[0..BufSize] of Byte;
  DecomStream                           : TDecompressionStream;
begin
  DecomStream := nil;
  try
    // 在此写解密流代码
    // DecryptStream(InStream);
    DecomStream := TDecompressionStream.Create(InStream);

    repeat
      i := DecomStream.Read(Buf, BufSize);
      OutStream.WriteBuffer(Buf, i);
    until (i = 0);
    OutStream.Position := 0;

    DecomStream.Free;
    DecomStream := nil;
  except
    on E: Exception do
    begin
      if (DecomStream <> nil) then
        DecomStream.Free;
      MessageDlg(DECOMPRESS_STRM_ERROR + #10 + E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

function GetMemSize: string;
var
  TMS                                   : TMemoryStatus;
begin
  TMS.dwLength := sizeof(TMS);
  GlobalMemorystatus(TMS);
  Result := Inttostr(TMS.dwTotalPhys);
 // Result := Base64EncodeStr(Result);
end;


function MyEncodeString(Str: string; Key: string;Count:Integer=1): string;
var
  Top1                                  : TTopdelphi1;
  Top3                                  : TTopdelphi3;
  Top5                                  : TTopdelphi5;
  Top8                                  : TTopdelphi4;
begin
 try
  Top1 := TTopdelphi1.Create(nil);
  Top1.InitStr(Key);
  Top1.Reset;
  Str := Top1.EncryptString(Str);
 finally
   Top1.free;
 end;
  if count>1 then
  Begin
  try
    Top3 := TTopdelphi3.Create(nil);
    Top3.InitStr(Key);
    Top3.Reset;
    Str := Top3.EncryptString(Str);
  finally
    Top3.Free;
  end;
  End;
  if count>2 then
  Begin
   try
    Top5 := TTopdelphi5.Create(nil);
    Top5.InitStr(Key);
    Top5.Reset;
    Str := Top5.EncryptString(Str);
     finally
    Top5.Free;
   end;
  End;
  if count>3 then
  Begin
   try
    Top8 := TTopdelphi4.Create(nil);
    Top8.InitStr(Key);
    Top8.Reset;
    Str := Top8.EncryptString(Str);
   finally
    Top8.Free;
   end;
  End;
  Result := Str;
end;

function MyDecodestring(Str: string; Key: string;count:INteger=1): string;
var
  Top1                                  : TTopdelphi1;
  Top3                                  : TTopdelphi3;
  Top5                                  : TTopdelphi5;
  Top8                                  : TTopdelphi4;
begin
  if count>3 then
  Begin
   try
    Top8 := TTopdelphi4.Create(nil);
    Top8.InitStr(Key);
    Top8.Reset;
    Str := Top8.DecryptString(Str);
   finally
    Top8.Free;
   end;
  End;
  if count>2 then
  Begin
   Try
    Top5 := TTopdelphi5.Create(nil);
    Top5.InitStr(Key);
    Top5.Reset;
    Str := Top5.DecryptString(Str);
   finally
    Top5.Free;
   end;

  End;
  if count>1 then
  Begin
  try
    Top3 := TTopdelphi3.Create(nil);
    Top3.InitStr(Key);
    Top3.Reset;
    Str := Top3.DecryptString(Str);
   finally
    Top3.Free;
   end;

  End;
   try
    Top1 := TTopdelphi1.Create(nil);
    Top1.InitStr(Key);
    Top1.Reset;
    Str := Top1.DecryptString(Str);
   finally
    Top1.Free;
   end;

  Result := Str;
end;
end.

