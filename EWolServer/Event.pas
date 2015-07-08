unit Event;

interface

uses
  Windows, Classes, SysUtils, SyncObjs, ObjBase, Envir, Grobal2;
type
  TEvent = class //0x40
    nVisibleFlag: Integer; //0x04
    m_Envir: TEnvirnoment;
    m_nX: Integer; //0x0C
    m_nY: Integer; //0x10
    m_nEventType: Integer; //0x14
    m_nEventParam: Integer; //0x18
    m_dwOpenStartTick: LongWord; //0x1C
    m_dwContinueTime: LongWord; //0x20  显示时间长度
    m_dwCloseTick: LongWord; //0x24
    m_boClosed: Boolean; //0x28
    m_nDamage: Integer; ///0x2C
    m_OwnBaseObject: TBaseObject; //0x30
    m_dwRunStart: LongWord; //0x34
    m_dwRunTick: LongWord; //0x38
    m_boVisible: Boolean; //0x3C
    m_boActive: Boolean; //0x3D
  public
    constructor Create(tEnvir: TEnvirnoment; ntX, ntY, nType: Integer; dwETime: LongWord; boVisible: Boolean);
    destructor Destroy; override;
    procedure Run(); virtual;
    procedure Close();
  end;
  TStoneMineEvent = class(TEvent) //0x4C      //矿石
    m_nMineCount: Integer; //0x40
    m_nAddStoneCount: Integer; //0x44
    m_dwAddStoneMineTick: LongWord; //0x48
    m_boAddmapok: boolean;
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
    destructor Destroy; override;
    procedure AddStoneMine();
  end;
  TPileStones = class(TEvent) //0x40         地上被挖了个洞
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    destructor Destroy; override;
    procedure AddEventParam();
  end;
  THolyCurtainEvent = class(TEvent) //0x40      //神圣
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    destructor Destroy; override;
  end;
  TFireBurnEvent = class(TEvent) //0x44      火墙
    m_dwRunTick: LongWord;
  public
    constructor Create(Creat: TBaseObject; nX, nY: Integer; nType: Integer; nTime, nDamage: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;
  TanyingEvent = class(TEvent)
    m_dwRunTick: dword;
    m_dwHiteTick: dword;
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer; nTime, nDamage: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;

  TSafeZoneLight = class(TEvent)

  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer; nTime: LongWord; nDamage: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;

  TEventManager = class //0x0C
    m_EventList: TGList;
    m_ClosedEventList: TGList;

  public
    constructor Create();
    destructor Destroy; override;
    function GetEvent(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer): TEvent;
    function GetRangeEvent(Envir: TEnvirnoment; OwnBaseObject: TBaseObject; nX, nY, nRange: Integer; nType: Integer): Integer;
    procedure AddEvent(Event: TEvent);
    procedure Run();
  end;
implementation

uses M2Share;

{ TStoneMineEvent }

constructor TStoneMineEvent.Create(Envir: TEnvirnoment; nX, nY,
  nType: Integer); //004A7D0C
begin
  inherited Create(Envir, nX, nY, nType, 0, False);
  m_boAddmapok := true;
  if m_Envir.AddToMapMineEvent(nX, nY, OS_EVENTOBJECT, Self) = nil then
    m_boAddmapok := false;
  m_boVisible := False;
  m_nMineCount := Random(200);
  m_dwAddStoneMineTick := GetTickCount();
  m_boActive := False;
  m_nAddStoneCount := Random(80);
end;

destructor TStoneMineEvent.Destroy;
begin

  inherited;
end;
{ TEventManager }

procedure TEventManager.Run; //004A8190
var
  I: Integer;
  Event: TEvent;
  nCheckCode: Integer;
resourcestring
  sExceptionMsg = '[Exception] TEventManager::Run CheckCode: %d';
begin
  nCheckCode := -1;
  try
    m_EventList.Lock;
    try
      I := 0;
      while (True) do
      begin
        if m_EventList.Count <= I then
          break;
        nCheckCode := 1;
        Event := TEvent(m_EventList.Items[I]);
        nCheckCode := 2;
        if Event.m_boActive and ((GetTickCount - Event.m_dwRunStart) > Event.m_dwRunTick) then
        begin
          nCheckCode := 3;
          Event.m_dwRunStart := GetTickcount();
          nCheckCode := 4;
          Event.Run();
          nCheckCode := 5;
          if Event.m_boClosed then
          begin
            nCheckCode := 6;
            m_ClosedEventList.Lock;
            try
              m_ClosedEventList.Add(Event);
            finally
              m_ClosedEventList.UnLock;
            end;
            nCheckCode := 7;
            m_EventList.Delete(I);
            nCheckCode := 8;
          end
          else
            Inc(I);
        end
        else
          Inc(I);
      end;
    finally
      m_EventList.UnLock;
    end;
    nCheckCode := 10;
    m_ClosedEventList.Lock;
    try
      for I := m_ClosedEventList.Count - 1 downto 0 do
      begin
        nCheckCode := 11;
        Event := TEvent(m_ClosedEventList.Items[i]);
        nCheckCode := 12;
        if (GetTickCount - Event.m_dwCloseTick) > 5 * 60 * 1000 then
        begin
          m_ClosedEventList.Delete(i);
          nCheckCode := 13;
          Event.Free;
          nCheckCode := 14;
        end;
      end;
    finally
      m_ClosedEventList.UnLock;
    end;
  except
    on e: Exception do
    begin
      MainOutMessage(format(sExceptionMsg, [nCheckCode]));
      MainOutMessage(E.Message);
      raise;
    end;

  end;
end;
function TEventManager.GetRangeEvent(Envir: TEnvirnoment; OwnBaseObject: TBaseObject;
  nX, nY, nRange: Integer; nType: Integer): Integer;
var
  I: Integer;
  Event: TEvent;
begin
  Result := 0;
  m_EventList.Lock;
  try
    for I := 0 to m_EventList.Count - 1 do begin
      Event := TEvent(m_EventList.Items[I]);
      if (Event.m_OwnBaseObject = OwnBaseObject) and
        (abs(Event.m_nX - nX) <= nRange) and
        (abs(Event.m_nY - nY) <= nRange) and
        (Event.m_nEventType = nType) then begin
        Inc(Result);
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;
function TEventManager.GetEvent(Envir: TEnvirnoment; nX, nY,
  nType: Integer): TEvent; //004A810C
var
  I: Integer;
  Event: TEvent;
begin
  Result := nil;
  m_EventList.Lock;
  try
    for I := 0 to m_EventList.Count - 1 do
    begin
      Event := TEvent(m_EventList.Items[i]);
      if (Event.m_Envir = Envir) and
        (Event.m_nX = nX) and
        (Event.m_nY = nY) and
        (Event.m_nEventType = nType) then
      begin

        Result := Event;
        break;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;

procedure TEventManager.AddEvent(Event: TEvent); //004A80EC
begin
  m_EventList.Lock;
  try
    m_EventList.Add(Event);
  finally
    m_EventList.UnLock;
  end;
end;

constructor TEventManager.Create(); //004A8014
begin
  m_EventList := TGList.Create;
  m_ClosedEventList := TGList.Create;

end;

destructor TEventManager.Destroy;
var
  I: Integer;
begin
{
  for I := 0 to m_EventList.Count - 1 do begin
    TEvent(m_EventList.Items[i]).Free;
  end;
}
  m_EventList.Free;


  for I := 0 to m_ClosedEventList.Count - 1 do
  begin
    TEvent(m_ClosedEventList.Items[i]).Free;
  end;

  m_ClosedEventList.Free;

  inherited;
end;


{ THolyCurtainEvent }

constructor THolyCurtainEvent.Create(Envir: TEnvirnoment; nX, nY, nType, nTime: Integer); //004A7E60
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
end;

destructor THolyCurtainEvent.Destroy;
begin

  inherited;
end;

    { TFireBurnEvent }//火墙

constructor TFireBurnEvent.Create(Creat: TBaseObject; nX, nY, nType, nTime, nDamage: Integer); //004A7EBC
begin
  inherited Create(Creat.m_PEnvir, nX, nY, nType, nTime, True);
  m_nDamage := nDamage;
  m_OwnBaseObject := Creat;
end;

destructor TFireBurnEvent.Destroy;
begin

  inherited;
end;

procedure TFireBurnEvent.Run; //004A7F30
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  if (GetTickCount - m_dwRunTick) > 3000 then
  begin
    m_dwRunTick := GetTickCount();
    BaseObjectList := TList.Create;
    if m_Envir <> nil then
    begin
      m_Envir.GeTBaseObjects(m_nX, m_nY, True, BaseObjectList); //
      for I :=  BaseObjectList.Count - 1 downto 0 do
      begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
        if TargeTBaseObject = nil then
          continue;
        if (TargeTBaseObject <> nil) and (m_OwnBaseObject <> nil) and (m_OwnBaseObject.IsProperTarget(TargeTBaseObject)) then
        begin
          TargeTBaseObject.SendMsg(m_OwnBaseObject, RM_MAGSTRUCK_MINE, 0, m_nDamage, 0, 0, '');
        end;
      end;
    end;
    BaseObjectList.Free;
  end;
  inherited;
end;

{ TEvent }

constructor TEvent.Create(tEnvir: TEnvirnoment; ntX, ntY, nType: Integer; dwETime: LongWord; boVisible: Boolean); //004A7B68
begin
  m_dwOpenStartTick := GetTickCount();
  m_nEventType := nType;
  m_nEventParam := 0;
  m_dwContinueTime := dwETime;
  m_boVisible := boVisible;
  m_boClosed := False;
  m_Envir := tEnvir;
  m_nX := ntX;
  m_nY := ntY;
  m_boActive := True;
  m_nDamage := 0;
  m_OwnBaseObject := nil;
  m_dwRunStart := GetTickCount();
  m_dwRunTick := 500;
  if (m_Envir <> nil) and (m_boVisible) then
  begin
    if m_Envir.AddToMap(m_nX, m_nY, OS_EVENTOBJECT, Self) = nil
      then
      m_dwContinueTime := 0; //如果不能放地图上就 释放掉

  end
  else
    m_boVisible := False;
  //EventCheck.Add(Self);
end;

destructor TEvent.Destroy;
var
  I: integer;
begin
  {
  for I := 0 to EventCheck.Count - 1 do begin
    if EventCheck.Items[I] = Self then begin
      EventCheck.Delete(I);
      break;
    end;
  end;
  }
  inherited;
end;

procedure TEvent.Run; //004A7CE0
begin
  if (GetTickCount - m_dwOpenStartTick) >= m_dwContinueTime then
  begin
    m_boClosed := True;
    Close();
  end;
  if (m_OwnBaseObject <> nil) and (m_OwnBaseObject.m_boGhost or (m_OwnBaseObject.m_boDeath)) then
    m_OwnBaseObject := nil;
end;

procedure TEvent.Close; //004A7C8C
begin
  m_dwCloseTick := GetTickCount();
  if m_boVisible then
  begin
    m_boVisible := False;
    if m_Envir <> nil then
    begin
      m_Envir.DeleteFromMap(m_nX, m_nY, OS_EVENTOBJECT, Self);
    end;
    m_Envir := nil;
  end;
end;


{ TPileStones }

constructor TPileStones.Create(Envir: TEnvirnoment; nX, nY, nType,
  nTime: Integer); //004A7DDC
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
  m_nEventParam := 1;
end;

destructor TPileStones.Destroy;
begin

  inherited;
end;

procedure TPileStones.AddEventParam; //sub_4A7E44;
begin
  if m_nEventParam < 5 then
    Inc(m_nEventParam);
end;

procedure TStoneMineEvent.AddStoneMine; //004A7DB8
begin
  m_nMineCount := m_nAddStoneCount;
  m_dwAddStoneMineTick := GetTickCount();
end;

{ TanyingEvent }

constructor TanyingEvent.Create(Envir: TEnvirnoment; nX, nY, nType, nTime,
  nDamage: Integer);
// var Envir:TEnvirnoment;
begin
 // Envir:=g_MapManager.FindMap(smap);
 // if Envir=nil then  exit;
  inherited Create(Envir, nX, nY, nType, nTime, True);
  m_nDamage := nDamage;
  m_OwnBaseObject := TBaseObject.create(); //Creat;
  m_OwnBaseObject.m_PEnvir := m_Envir;
  m_OwnBaseObject.m_sCharName := '暗影雷电';
  m_OwnBaseObject.m_nCurrX := nX;
  m_OwnBaseObject.m_nCurrY := ny;
  m_dwHiteTick := GetTickCount;
end;

destructor TanyingEvent.Destroy;
begin
  m_OwnBaseObject.Destroy;
  inherited;
end;

procedure TanyingEvent.Run;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  if (GetTickCount - m_dwOpenStartTick) < m_dwContinueTime then
  begin
    if (GetTickCount - m_dwRunTick) > 2000 then
    begin
      m_dwRunTick := GetTickCount();
      BaseObjectList := TList.Create;
      if m_Envir <> nil then
      begin

        if (m_OwnBaseObject <> nil) then
        begin
          if (GetTickCount - m_dwHiteTick) < 4000 then
            m_OwnBaseObject.SendRefMsg(RM_ANYING, 2, m_nX, m_nY, 0, '') //提示
          else
          begin
            m_dwHiteTick := GetTickCount;
            m_OwnBaseObject.SendRefMsg(RM_ANYING, 3, m_nX, m_nY, 0, ''); //提示


            m_Envir.GetRangeBaseObject(m_nX, m_nY, 2, True, BaseObjectList);

            for I := 0 to BaseObjectList.Count - 1 do
            begin
              TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
              if TargeTBaseObject = nil then
                continue;
              if (TargeTBaseObject <> nil) and (m_OwnBaseObject <> nil) and (m_OwnBaseObject.IsProperTarget(TargeTBaseObject)) then
              begin
                if (TargeTBaseObject.m_nCurrX = m_nX) and (TargeTBaseObject.m_nCurrX = m_nY) then
                  m_nDamage := 9999
                else
                  m_nDamage := TargeTBaseObject.m_WAbil.MaxHP * 3 div 5;
                TargeTBaseObject.SendMsg(m_OwnBaseObject, RM_MAGSTRUCK_MINE, 0, m_nDamage, 0, 0, '');
              end;
            end;
          end; //else
        end; // if (m_OwnBaseObject <> nil)
      end; // if m_Envir <> nil then begin
      BaseObjectList.Free;
    end;
  end; //   if (GetTickCount - m_dwOpenStartTick) < m_dwContinueTime then begin

  inherited;
end;

{ TSafeZoneLight }

constructor TSafeZoneLight.Create(Envir: TEnvirnoment; nX, nY, nType: Integer; nTime: LongWord;
  nDamage: Integer);
 //var Envir:TEnvirnoment;
begin
 //  Envir:=g_MapManager.FindMap(smap);
 // if Envir=nil then  exit;
  inherited Create(Envir, nX, nY, nType, nTime, True);
end;

destructor TSafeZoneLight.Destroy;
begin

  inherited;
end;

procedure TSafeZoneLight.Run;
begin
  m_dwOpenStartTick := GetTickCount; //永远不消失
  inherited;

end;

end.
