unit ScriptEncode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls,Dialogs,FileCtrl;

type
   _ENcode=Function (sour,Key:String;Count:Integer):Pchar;
   _HardID=Function:PChar;
   _GetCrc=function (FileName:String):Pchar;
  TForm1 = class(TForm)
    EditKey: TEdit;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    EditFileName: TEdit;
    Button1: TButton;
    Label3: TLabel;
    EditDir: TEdit;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    FileListBox1: TFileListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
 
  private
    { Private declarations }
  public
    Procedure EnCodeFile(FileName:String);
    Procedure DeCodeFile(FileName:String);

  end;

var
  Form1                                 : TForm1;
  ENcode,Decode                         : _ENcode;
  HardID                                : _HardID;
  GetCrc                                : _GetCrc;
  HardIDStr                             : String;
  CrcStr                                : String;
  DllHandle                            : INteger;
implementation

uses uCompress, Base64;

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
var
  DllHandle:INteger;
begin
   if OpenDialog1.Execute then
     EditFileName.Text:=OpenDialog1.FileName;
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
  DllHandle:=loadlibrary( 'woool2008.dll' );
  if DllHandle=0 then
  Begin
    SHowMessage('没有正确加载DLL文件');
    Exit;
  End;

  ENcode:=GetProcAddress(DllHandle,'FUNCTION1');
  Decode:=GetProcAddress(DllHandle,'FUNCTION2');
  HardID:=GetProcAddress(DllHandle,'FUNCTION3');
  GetCrc:=GetProcAddress(DllHandle,'FUNCTION4');
  HardIDStr:=StrPas(Hardid);
  CrcStr:=Strpas(GetCrc('woool2008.dll'));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i:Integer;
  fileName:String;
begin
 //加密
 if EditFileName.Text<>'' then
  EnCodeFile(EditFileName.Text)
 else
 Begin
   if EditDir.Text<>'' then
   Begin
     for i:=0 to FileListBox1.Count-1 do
     Begin
        FileName:=FileListBox1.Directory+'\'+FileListBox1.Items[i];
        EncodeFile(FileName);
     ENd;

   End;

 End;
  ShowMessage('加密成功!');

end;



procedure TForm1.Button3Click(Sender: TObject);
var
  Dir: string;
begin
  Dir := 'D:\Mirserver\Mir200\Envir';
  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],0) then
  Begin
    EditDir.text := Dir;
    FileListBox1.Directory:=Dir;
  End;
end;
procedure TForm1.EnCodeFile(FileName: String);
var
   StrList:TStringList;
   str:String;
   EnList:TStringList;
   i:Integer;
Const
   FileHeader=';ENCODESCRIPTFILEWOL2008';
begin
  if FileExists(FileName) then
  Begin
   StrList:=TStringList.Create;
   StrList.LoadFromFile(Filename);
    try
    if StrList.Count>0 then
    Begin
      str:=StrList.Strings[0];
      if AnsiCompareText(str,FileHeader)<>0 then//不是加密文件
      Begin
        try
         ENList:=TStringList.Create;
         EnList.Add(FileHeader);
         for i:=0 to StrList.Count-1 do
         Begin
            Str:=StrList[i];
            Str:=Base64EncodeStr(str);
            Str:=Encode(Str,EditKey.Text,3);
            Str:=Encode(Str,CrcStr,3);
            EnList.Add(str);

         End;
      finally
         ENlist.SaveToFile(FileName);
         StrList.SaveToFile(FileName+'.Encode.bak');
         ENList.Free;
      End;

      End;

    End;
    finally
       StrList.Free;
    End;


  End;


end;

procedure TForm1.DeCodeFile(FileName: String);
var
   StrList:TStringList;
   str:String;
   EnList:TStringList;
   i:Integer;
Const
   FileHeader=';ENCODESCRIPTFILEWOL2008';
begin
  if FileExists(FileName) then
  Begin
   StrList:=TStringList.Create;
   StrList.LoadFromFile(Filename);
    try
    if StrList.Count>0 then
    Begin
      str:=StrList.Strings[0];
      if AnsiCompareText(str,FileHeader)=0 then//不是加密文件
      Begin
        try
         ENList:=TStringList.Create;

         for i:=1 to StrList.Count-1 do
         Begin
            Str:=StrList[i];
            
            Str:=Decode(Str,CrcStr,3);
            Str:=Decode(Str,EditKey.Text,3);
            Str:=Base64DecodeStr(str);
            EnList.Add(str);

         End;
      finally
         ENlist.SaveToFile(FileName);
         StrList.SaveToFile(FileName+'.Decode.bak');
         ENList.Free;
      End;

      End;

    End;
    finally
       StrList.Free;
    End;


  End;


end;

procedure TForm1.Button4Click(Sender: TObject);
var
  i:Integer;
begin
 if EditFileName.Text<>'' then
  DeCodeFile(EditFileName.Text)
 else
 Begin
   if EditDir.Text<>'' then
   Begin
     for i:=0 to FileListBox1.Count-1 do
        DecodeFile(FileListBox1.Items[i]);

   End;

 End;
 ShowMessage('解密成功!');

end;
end.

