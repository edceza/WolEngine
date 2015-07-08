unit BiosHelp;

{$ALIGN ON}
{$MINENUMSIZE 4}

interface

uses
 Windows;

type
 PRomBiosDump = ^TRomBiosDump;
 TRomBiosDump = array[$000F0000..$000FFFFF] of Byte;

type
 TReadRomBiosMethod = (
   rrbmAutomatic, { Autodetect OS type and use proper method }
   rrbmGeneric, { Use 16-bit COM program to dump the BIOS  }
   rrbmMemory, { Read from memory (Win9x)                 }
   rrbmPhysical { Read from physical memory object (WinNT) }
   );

function ReadRomBios(var Dump: TRomBiosDump; Method: TReadRomBiosMethod;
 Timeout: DWORD = INFINITE): Boolean;

function GetRomBiosBuffer(const Dump: TRomBiosDump; Address: Pointer;
 var Buffer; BufferSize: Cardinal): Cardinal;
function GetRomBiosString(const Dump: TRomBiosDump; Address: Pointer): string;
function GetRomBiosLongLong(const Dump: TRomBiosDump; Address: Pointer):
 LONGLONG;
function GetRomBiosDWord(const Dump: TRomBiosDump; Address: Pointer): DWORD;
function GetRomBiosWord(const Dump: TRomBiosDump; Address: Pointer): Word;
function GetRomBiosByte(const Dump: TRomBiosDump; Address: Pointer): Byte;
function GetmotherboradKey: string; //取得系统系列号
function Getmotherboradver: string; //BIOS 版本
function Getmotherboraddate: string; //BIOS日期
function Getmotherboradverxx: string; //BIOS 版权信息
function Getmotherboradname: string; //BIOS 名称

implementation

{##############################################################################
#
# #
#                             GENERIC METHOD #
# #
# Create an temporary folder, save an 16bit COM program (RomDump.com) into it,
#
# execute program redirected to an file (Rom.dmp, RomDump.com simply dumps the
#
# memory range F000:0000-F000:FFFF to STDOUT), read dump file into the buffer,
#
# and finally cleanup all temporary files and directories. #
# #
# (the function RomDumpCode is x86 specific, which i wrote to generate 16-bit #
#  code with the help of the 23-bit Delphi compiler, never try to execute the #
#  pseudo-code in your program! it will not work in 32-bit protected mode) #
# #
###############################################################################
}

{ *INTERNAL* - Pseudo 16-bit code }

type
 PRomDumpCodeInfo = ^TRomDumpCodeInfo;
 TRomDumpCodeInfo = (rdciStart, rdciEnd, rdciSize);

function _RomDumpCode(Info: TRomDumpCodeInfo): Pointer;
var
 CodeStart: Pointer;
 CodeEnd: Pointer;
begin
 asm
         JMP     @@End

         { *BEGIN* 16-bit code  }
         { -- never use it in your program! -- }
         { COM which writes ROM-BIOS to StdOut }
 @@Start:
         { Dump F000:0000-F000:FFFE }
         XOR     eDX, eDX  // DS = 0xF000   ; Data segment
         MOV     DH, 0F0h
         MOV     DS, eDX
         XOR     eDX, eDX  // DX = 0x0000   ; Data offset
         XOR     eCX, eCX  // CX = 0xFFFF   ; Data length
         DEC     eCX
         XOR     eBX, eBX  // BX = 0x0001   ; STDOUT (file handle)
         INC     eBX
         MOV     AH, 40h   // DosCall(0x40) ; INT21, DOS_WRITE_TO_HANDLE
         INT     21h
         JC      @@Exit    // On error exit ; AL = Error code
         { Dump F000:FFFF }
         XOR     eDX, eDX  // DS = 0xF000   ; Data segment
         MOV     DH, 0F0h
         MOV     DS, eDX
         XOR     eDX, eDX  // DX = 0xFFFF   ; Data offset
         DEC     eDX
         XOR     eCX, eCX  // CX = 0x0001   ; Data length
         INC     eCX
         MOV     eBX, eCX  // BX = 0x0001   ; STDOUT (file handle)
         MOV     AH, 40h   // DosCall(0x40) ; INT21, DOS_WRITE_TO_HANDLE
         INT     21h
         JC      @@Exit    // On error exit ; AL = Error code
         MOV     AL, 0     // no error      ; AL = 0
 @@Exit:
         MOV     AH, 4Ch   // DosCall(0x4C) ; INT21, DOS_TERMINATE_EXE
         INT     21h
 @@End:
         { *END* 16-bit code  }

         MOV     CodeStart, OFFSET @@Start
         MOV     CodeEnd, OFFSET @@End
 end;
 case Info of
   rdciStart:
     Result := CodeStart;
   rdciEnd:
     Result := CodeEnd;
   rdciSize:
     Result := Pointer(Cardinal(CodeEnd) - Cardinal(CodeStart));
 else
   Result := nil;
 end;
end;

{ *INTERNAL* - Save 16-bit code to file }

function _RomDumpCodeToFile(const Filename: string): Boolean;
var
 ComFile: THandle;
 Size: Cardinal;
begin
 Result := False;
 ComFile := CreateFile(PChar(Filename), GENERIC_WRITE, FILE_SHARE_READ, nil,
   CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
 if ComFile <> INVALID_HANDLE_VALUE then
 try
   Result := WriteFile(ComFile, _RomDumpCode(rdciStart)^,
     Cardinal(_RomDumpCode(rdciSize)), Size, nil) and
     (Size = Cardinal(_RomDumpCode(rdciSize)));
   if not Result then
     DeleteFile(PChar(Filename));
 finally
   CloseHandle(ComFile);
 end;
end;

{ *INTERNAL* - Execute 16-bit code redirected to file }

function _RomDumpCodeExecute(const Com, Dmp: string; Timeout: DWORD): Boolean;
var
 ComSpec: string;
 si: TStartupInfo;
 pi: TProcessInformation;
begin
 Result := False;
 SetLength(ComSpec, MAX_PATH);
 SetLength(ComSpec,
   GetEnvironmentVariable('ComSpec', PChar(@ComSpec[1]), MAX_PATH));
 if Length(ComSpec) > 0 then
 begin
   FillChar(si, SizeOf(TStartupInfo), 0);
   si.cb := SizeOf(TStartupInfo);
   si.dwFlags := STARTF_USESHOWWINDOW;
   si.wShowWindow := SW_HIDE;
   if CreateProcess(nil, PChar(ComSpec + ' /C ' + Com + ' > ' + Dmp),
     nil, nil, False, CREATE_NEW_CONSOLE or CREATE_NEW_PROCESS_GROUP, nil,
     nil, si, pi) then
   try
     Result := WaitForSingleObject(pi.hProcess, Timeout) <> WAIT_TIMEOUT;
   finally
     CloseHandle(pi.hProcess);
     CloseHandle(pi.hThread);
   end;
 end;
end;

function DirectoryExists(const Dir: string): Boolean;
var
 Attr: DWORD;
begin
 Attr := GetFileAttributes(PChar(Dir));
 Result := (Attr <> $FFFFFFFF) and
   (Attr and FILE_ATTRIBUTE_DIRECTORY = FILE_ATTRIBUTE_DIRECTORY);
end;

{ Get BIOS dump the generic way }

function ReadRomBios16(var Buffer: TRomBiosDump; Timeout: DWORD): Boolean;
const
 TempSub = '~RomDmp';
 ComName = 'RomDump.com';
 DmpName = 'Rom.dmp';
var
 TempPath: string;
 TempDir: string;
 TempIdx: Integer;
 TempIdxStr: string;
 ComFile: string;
 DmpFile: string;
 DmpHandle: THandle;
 Written: DWORD;
begin
 Result := False;
 SetLength(TempPath, MAX_PATH);
 SetLength(TempPath, GetTempPath(MAX_PATH, PChar(@TempPath[1])));
 if Length(TempPath) > 0 then
 begin
   if (TempPath[Length(TempPath)] <> '\') then
     TempPath := TempPath + '\';
   TempIdx := 0;
   repeat
     Inc(TempIdx);
     Str(TempIdx, TempIdxStr);
     TempDir := TempPath + TempSub + TempIdxStr;
   until not DirectoryExists(TempDir);
   if CreateDirectory(PChar(TempDir), nil) then
   try
     TempDir := TempDir + '\';
     ComFile := TempDir + ComName;
     DmpFile := TempDir + DmpName;
     if _RomDumpCodeToFile(ComFile) then
     try
       if _RomDumpCodeExecute(ComFile, DmpFile, Timeout) then
       begin
         DmpHandle := CreateFile(PChar(DmpFile), GENERIC_READ,
           FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
         if DmpHandle <> INVALID_HANDLE_VALUE then
         try
           FillChar(Buffer, SizeOf(TRomBiosDump), 0);
           Result := ReadFile(DmpHandle, Buffer, SizeOf(TRomBiosDump),
             Written, nil) and (Written = SizeOf(TRomBiosDump));
         finally
           CloseHandle(DmpHandle);
         end;
       end;
     finally
       DeleteFile(PChar(DmpFile));
       DeleteFile(PChar(ComFile));
     end;
   finally
     RemoveDirectory(PChar(TempDir));
   end;
 end;
end;

{##############################################################################
#
# #
#                           DIRECT METHOD (Win9x) #
# #
# Due to the fact that Windows 95/98/ME maps the BIOS into every Win32 process
#
# for read access it is very simple to fill the buffer from memory. #
# #
###############################################################################
}

function ReadRomBios9x(var Buffer: TRomBiosDump): Boolean;
begin
 Result := False;
 try
   FillChar(Buffer, SizeOf(TRomBiosDump), 0);
   Move(Pointer(Low(TRomBiosDump))^, Buffer, SizeOf(TRomBiosDump));
   Result := True;
 except
   // ignore exceptions
 end
end;

{##############################################################################
#
# #
#                       PHYSICAL MEMORY METHOD (WinNT) #
# #
# On Windows NT the ROM BIOS is only available through the named kernel object
#
# '\Device\PhysicalMemory'. Because it is impossible to open kernel objects in
#
# user mode with standard Win32 API functions we make use of NT's nativeAPI in
#
# NtDll.dll ("NT-Layer") namely ZwOpenSection. #
# #
# (note: mostly there are two versions of every function ZwXxx and NtXxx. The #
#  only difference in kernel mode is that the NtXxx version works in conside- #
#  ration to security while ZwXxx not. But in user mode both work like NtXxx.)
#
# #
# At first the section is opened with ZwOpenSection. Normally we would proceed
#
# ZwMapViewOfSection, ZwUnmapViewOfSection, and NtClose. But the functions are
#
# more complex and there is no needing for it. With the handle (because we are
#
# in the "very simple" user mode =) we now use MapViewOfFile, UnmapViewOfFile,
#
# and CloseHandle to map an memory window (the ROM BIOS) into our process. #
# #
# Due to the fact that ZwOpenSection returns NT error-codes in case of failure
#
# we have to translate it to an Win32 error-code (RtlNtStatusToDosError). #
# All NT specific functions are dynamically loaded -- because the applications
#
# should start on Win9x systems =) #
# #
###############################################################################
}

{ For more information see Windows 2000/XP DDK  }
{ It works on Windows NT 4.0 too, use NtDll.dll }

type
 NTSTATUS = Integer;

const
 STATUS_SUCCESS = NTSTATUS(0);
 STATUS_INVALID_HANDLE = NTSTATUS($C0000008);
 STATUS_ACCESS_DENIED = NTSTATUS($C0000022);

type
 PUnicodeString = ^TUnicodeString;
 TUnicodeString = packed record
   Length: Word;
   MaximumLength: Word;
   Buffer: PWideChar;
 end;

const
 OBJ_INHERIT = $00000002;
 OBJ_PERMANENT = $00000010;
 OBJ_EXCLUSIVE = $00000020;
 OBJ_CASE_INSENSITIVE = $00000040;
 OBJ_OPENIF = $00000080;
 OBJ_OPENLINK = $00000100;
 OBJ_KERNEL_HANDLE = $00000200;
 OBJ_VALID_ATTRIBUTES = $000003F2;

type
 PObjectAttributes = ^TObjectAttributes;
 TObjectAttributes = record
   Length: ULONG;
   RootDirectory: THandle;
   ObjectName: PUnicodeString;
   Attributes: ULONG;
   SecurityDescriptor: PSecurityDescriptor;
   SecurityQualityOfService: PSecurityQualityOfService;
 end;

const
 ObjectPhysicalMemoryDeviceName = '\Device\PhysicalMemory';
 ObjectPhysicalMemoryName: TUnicodeString = (
   Length: Length(ObjectPhysicalMemoryDeviceName) * 2;
   MaximumLength: Length(ObjectPhysicalMemoryDeviceName) * 2 + 2;
   Buffer: ObjectPhysicalMemoryDeviceName;
   );
 ObjectPhysicalMemoryAccessMask: ACCESS_MASK = SECTION_MAP_READ;
 ObjectPhysicalMemoryAttributes: TObjectAttributes = (
   Length: SizeOf(TObjectAttributes);
   RootDirectory: 0;
   ObjectName: @ObjectPhysicalMemoryName;
   Attributes: OBJ_CASE_INSENSITIVE;
   SecurityDescriptor: nil;
   SecurityQualityOfService: nil;
   );

type
 TFNZwOpenSection = function(out SectionHandle: THandle;
   DesiredAccess: ACCESS_MASK; ObjectAttributes: PObjectAttributes): NTSTATUS;
 stdcall;
 TFNRtlNtStatusToDosError = function(Status: NTSTATUS): DWORD; stdcall;

const
 ntdll = 'ntdll.dll';

var
 ZwOpenSection: TFNZwOpenSection;
 RtlNtStatusToDosError: TFNRtlNtStatusToDosError;

function ReadRomBiosNt(var Buffer: TRomBiosDump; Timeout: DWORD): Boolean;
var
 NtLayer: HMODULE;
 Status: NTSTATUS;
 Section: THandle;
 View: Pointer;
begin
 Result := False;
 NtLayer := GetModuleHandle(ntdll);
 if NtLayer = 0 then
   SetLastError(ERROR_CALL_NOT_IMPLEMENTED)
 else
 begin
   if not Assigned(ZwOpenSection) then
     ZwOpenSection := GetProcAddress(NtLayer, 'ZwOpenSection');
   if not Assigned(RtlNtStatusToDosError) then
     RtlNtStatusToDosError := GetProcAddress(NtLayer,
       'RtlNtStatusToDosError');
   if not (Assigned(ZwOpenSection) and Assigned(RtlNtStatusToDosError)) then
     SetLastError(ERROR_CALL_NOT_IMPLEMENTED)
   else
   begin
     Status := ZwOpenSection(Section, ObjectPhysicalMemoryAccessMask,
       @ObjectPhysicalMemoryAttributes);
     case Status of
       STATUS_SUCCESS:
         try
           View := MapViewOfFile(Section, ObjectPhysicalMemoryAccessMask, 0,
             Low(TRomBiosDump), SizeOf(TRomBiosDump));
           if Assigned(View) then
           try
             FillChar(Buffer, SizeOf(TRomBiosDump), 0);
             Move(View^, Buffer, SizeOf(TRomBiosDump));
             Result := True;
           finally
             UnmapViewOfFile(View);
           end;
         finally
           CloseHandle(Section);
         end;
       STATUS_ACCESS_DENIED:
         Result := ReadRomBios16(Buffer, Timeout);
     else
       SetLastError(RtlNtStatusToDosError(Status))
     end;
   end;
 end;
end;

{##############################################################################
#
# #
#                               ReadRomBios #
# #
###############################################################################
}

function ReadRomBios(var Dump: TRomBiosDump; Method: TReadRomBiosMethod;
 Timeout: DWORD = INFINITE): Boolean;
begin
 Result := False;
 case Method of
   rrbmAutomatic:
     if (Integer(GetVersion) < 0) then
     try
       Result := ReadRomBios9x(Dump);
     except
       Result := ReadRomBios16(Dump, Timeout);
     end
     else
       Result := ReadRomBiosNt(Dump, Timeout);
   rrbmGeneric:
     Result := ReadRomBios16(Dump, Timeout);
   rrbmMemory:
     Result := ReadRomBios9x(Dump);
   rrbmPhysical:
     Result := ReadRomBiosNt(Dump, Timeout);
 else
   SetLastError(ERROR_INVALID_PARAMETER);
 end;
end;

{##############################################################################
#
# #
#     Utilities to simplify the access to data as generic standard types #
# #
###############################################################################
}

function GetRomBiosBuffer(const Dump: TRomBiosDump; Address: Pointer;
 var Buffer; BufferSize: Cardinal): Cardinal;
//Dump就是 ReadRomBios 读出来的数组，
//Address就是起始的读取的地址，BufferSize就是你要读取的大小。
begin
 Result := 0;
 if (Cardinal(Address) >= Low(TRomBiosDump)) and
   (Cardinal(Address) <= High(TRomBiosDump)) then
 begin
   Result := BufferSize;
   if (Cardinal(Address) + BufferSize > High(TRomBiosDump)) then
     Result := High(TRomBiosDump) - Cardinal(Address) + 1;
   Move(Dump[Cardinal(Address)], Buffer, Result);
 end;
end;

function GetRomBiosString(const Dump: TRomBiosDump; Address: Pointer): string;
begin
 Result := '';
 if (Cardinal(Address) >= Low(TRomBiosDump)) and
   (Cardinal(Address) <= High(TRomBiosDump)) then
   Result := string(PChar(@Dump[Cardinal(Address)]));
end;

function GetRomBiosLongLong(const Dump: TRomBiosDump; Address: Pointer):
 LONGLONG;
type
 PLongLong = ^LONGLONG;
begin
 Result := 0;
 if (Cardinal(Address) >= Low(TRomBiosDump)) and
   (Cardinal(Address) <= High(TRomBiosDump) - SizeOf(LONGLONG) + 1) then
   Result := PLongLong(@Dump[Cardinal(Address)])^;
end;

function GetRomBiosDWord(const Dump: TRomBiosDump; Address: Pointer): DWORD;
begin
 Result := 0;
 if (Cardinal(Address) >= Low(TRomBiosDump)) and
   (Cardinal(Address) <= High(TRomBiosDump) - SizeOf(DWORD) + 1) then
   Result := PDWORD(@Dump[Cardinal(Address)])^;
end;

function GetRomBiosWord(const Dump: TRomBiosDump; Address: Pointer): Word;
begin
 Result := 0;
 if (Cardinal(Address) >= Low(TRomBiosDump)) and
   (Cardinal(Address) <= High(TRomBiosDump) - SizeOf(Word) + 1) then
   Result := PWord(@Dump[Cardinal(Address)])^;
end;

function GetRomBiosByte(const Dump: TRomBiosDump; Address: Pointer): Byte;
begin
 Result := 0;
 if (Cardinal(Address) >= Low(TRomBiosDump)) and
   (Cardinal(Address) <= High(TRomBiosDump) - SizeOf(Byte) + 1) then
   Result := PByte(@Dump[Cardinal(Address)])^;
end;
function GetmotherboradKey: string; //取得主办序列号
var
 RBD: TRomBiosDump;
begin
 if ReadRomBios(RBD, rrbmAutomatic) then
 begin
   result := GetRomBiosString(RBD, Ptr($FEC71));
 end
 else
   result := 'sadgf00net';
end;
function Getmotherboradver: string; //BIOS 版本
var
 RBD: TRomBiosDump;
begin
 if ReadRomBios(RBD, rrbmAutomatic) then
 begin
   result := GetRomBiosString(RBD, Ptr($FE061));
 end
 else
   result := 'sadgf00net';
end;
function Getmotherboradverxx: string; //BIOS 版权信息
var
 RBD: TRomBiosDump;
begin
 if ReadRomBios(RBD, rrbmAutomatic) then
 begin
   result := GetRomBiosString(RBD, Ptr($FE091));
 end
 else
   result := 'sadgf00net';
end;
function Getmotherboraddate: string; //BIOS日期
var
 RBD: TRomBiosDump;
begin
 if ReadRomBios(RBD, rrbmAutomatic) then
 begin
   result := GetRomBiosString(RBD, Ptr($FFFF5));
 end
 else
   result := 'sadgf00net';
end;
function Getmotherboradname: string; //BIOS 名称
var
 RBD: TRomBiosDump;
begin
 if ReadRomBios(RBD, rrbmAutomatic) then
 begin
   result := GetRomBiosString(RBD, Ptr($FE0C1));
 end
 else
   result := 'sadgf00net';
end;
end.

