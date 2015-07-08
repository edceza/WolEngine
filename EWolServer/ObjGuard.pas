unit ObjGuard;

interface
uses
  Windows, Classes, Grobal2, ObjNpc;
type
  TSuperGuard = class(TNormNpc)
    n564: Integer;
    botianyu: boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override; //FFFB
  end;
implementation

uses ObjBase, M2Share;


{ TSuperGuard }

function TSuperGuard.AttackTarget(): Boolean; //004977B4
var
  nOldX, nOldY: Integer;
  btOldDir: Byte;
  wHitMode: Word;
begin
  Result := False;
  if m_TargetCret.m_PEnvir = m_PEnvir then
  begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
    begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      btOldDir := m_btDirection;
      m_TargetCret.GetBackPosition(m_nCurrX, m_nCurrY);
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      wHitMode := 0;
      _Attack(wHitMode, m_TargetCret);
      m_TargetCret.SetLastHiter(Self);
      m_TargetCret.m_ExpHitter := nil;
      m_nCurrX := nOldX;
      m_nCurrY := nOldY;
      m_btDirection := btOldDir;
      TurnTo(m_btDirection);
      BreakHolySeizeMode();
    end;
    Result := True;
  end
  else
  begin
    DelTargetCreat();
  end;

end;

constructor TSuperGuard.Create; //004976B0
begin
  inherited;
  m_btRaceServer := 11;
  m_nViewRange := 7;
  m_nLight := 4;
  botianyu := false;
end;

destructor TSuperGuard.Destroy; //00497718
begin

  inherited;
end;

function TSuperGuard.Operate(ProcessMsg: pTProcessMessage): Boolean; //0049774C
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TSuperGuard.Run; //00497924
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  if m_Master <> nil then
    m_Master := nil; //不允许召唤为宝宝

  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
  begin
    for I := 0 to m_VisibleActors.Count - 1 do
    begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject.m_boDeath then
        Continue;
      if botianyu then
      begin //天玉侍卫行为
        if (BaseObject.m_Master = nil) and (BaseObject.m_btRaceServer >= RC_MONSTER) then
        begin
          SetTargetCreat(BaseObject);
          break;
        end;
      end
      else
      begin
        if (BaseObject.m_btRaceServer = RC_YSBJECT)and(BaseObject.m_Master = nil) then
        begin
            SetTargetCreat(BaseObject);
            break;
        end;
        if (BaseObject.PKLevel >= 2) or ((BaseObject.m_btRaceServer >= RC_MONSTER) and (not BaseObject.m_boMission) and (BaseObject.m_btRaceServer <> 112) and (BaseObject.m_btRaceServer <> RC_YSBJECT)) then
        begin
          SetTargetCreat(BaseObject);
          break;
        end;
      end;
    end;
  end;
  if (m_TargetCret <> nil) and (m_TargetCret.m_btRaceServer <> 211) then
    AttackTarget(); //替身不杀
  inherited;
end;

end.
