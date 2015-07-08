unit UnitManage;

interface
uses
  WIndows, M2Share;
//type


procedure StartRegThread(Config: pTConfig; ThreadInfo: pTThreadInfo);
procedure RegServerThread(ThreadInfo: pTThreadInfo); stdcall;

implementation


procedure StartRegThread(Config: pTConfig; ThreadInfo: pTThreadInfo);
begin
  ThreadInfo.Config := Config;
  ThreadInfo.hThreadHandle := CreateThread(nil,
    0,
    @RegServerThread,
    ThreadInfo,
    0,
    ThreadInfo.dwThreadID);
end;

procedure RegServerThread(ThreadInfo: pTThreadInfo); stdcall;
begin

end;
end.
