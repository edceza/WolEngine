unit Objmonty;

interface
uses
  Windows, Classes, Grobal2, ObjBase, sysutils, HUtil32, ObjMon;
type
  Ttymon = class(TAnimalObject)
    n54C: Integer; //0x54C
    m_dwThinkTick: LongWord; //0x550
    bo554: Boolean; //0x554
    m_boDupMode: Boolean; //0x555


  private
    function Think: Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC

    procedure Run; override;
  end;

  Tkilltymon = class(TMonster)
  private
    procedure SearchTYTarget();
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  Ttiaopi = class(TMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;

  end;
implementation
uses UsrEngn, M2Share, Event;
{ Ttymon }



constructor Ttymon.Create;
begin
  inherited;
  m_boDupMode := False;
  bo554 := False;
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 17; //公主类型

end;

destructor Ttymon.Destroy;
begin

  inherited;
end;


function Ttymon.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure Ttymon.Run;
var
  nX, nY: Integer;

begin
  if not m_boGhost and
    not m_boDeath and
    not m_boFixedHideMode and
    not m_boStoneMode and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
  begin
    if Think then
    begin
      inherited;
      exit;
    end;
    if m_boWalkWaitLocked then
    begin
      if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then
      begin
        m_boWalkWaitLocked := False;
      end;
    end;
    if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then
    begin
      m_dwWalkTick := GetTickCount();
      Inc(m_nWalkCount);
      if m_nWalkCount > m_nWalkStep then
      begin
        m_nWalkCount := 0;
        m_boWalkWaitLocked := True;
        m_dwWalkWaitTick := GetTickCount();
      end; //004A9151
      if not m_boRunAwayMode then
      begin

        if m_Master <> nil then
        begin
       //   if m_TargetCret = nil then begin
          m_Master.GetBackPosition(nX, nY);
          if (abs(m_nTargetX - nX) > 1) or (abs(m_nTargetY - nY {nX}) > 1) then
          begin //004A922D
            m_nTargetX := nX;
            m_nTargetY := nY;
            if (abs(m_nCurrX - nX) <= 2) and (abs(m_nCurrY - nY) <= 2) then
            begin
              if m_PEnvir.GetMovingObject(nX, nY, True) <> nil then
              begin
                m_nTargetX := m_nCurrX;
                m_nTargetY := m_nCurrY;
              end //004A92A5
            end;
          end; //004A92A5
        //  end; //004A92A5 if m_TargetCret = nil then begin
          if m_Master.m_bodeath or (m_Master.m_PEnvir <> m_PEnvir) then
          begin
            m_WAbil.HP := 0;
          end; // 004A937E
        end; // 004A937E if m_Master <> nil then begin
      end
      else
      begin //004A9344
        if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then
        begin
          m_boRunAwayMode := False;
          m_dwRunAwayTime := 0;
        end;
      end; //004A937E


      if m_nTargetX <> -1 then
      begin
        GotoTargetXY(); //004A93B5 0FFEF
      end
      else
      begin
        if m_TargetCret = nil then
          Wondering(); // FFEE   //Jacky
      end; //004A93D8
    end; //004A93D8  if not bo510 and ((GetTickCount - m_dwWalkTick) > n4FC) then begin
  end; //004A93D8

  inherited;

end;

function Ttymon.Think: Boolean;
var
  nOldX, nOldY: integer;
begin
  Result := False;
  if (GetTickCount - m_dwThinkTick) > 3 * 1000 then
  begin
    m_dwThinkTick := GetTickCount();
    if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then
      m_boDupMode := True;
    if not IsProperTarget {FFFF4}(m_TargetCret) then
      m_TargetCret := nil;
  end; //004A8ED2
  if m_boDupMode then
  begin //人物重叠了
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    WalkTo(Random(8), False);
    if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then
    begin
      m_boDupMode := False;
      Result := True;
    end;
  end;
end;




{ Tkilltymon }

constructor Tkilltymon.Create;
begin
  inherited;
  m_btRaceServer := 209;
end;

destructor Tkilltymon.Destroy;
begin

  inherited;
end;

procedure Tkilltymon.Run;
begin
  if not m_boDeath and
    not bo554 and
    not m_boGhost and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
  begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then
    begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTYTarget();
    end;
  end;
  inherited;
end;

procedure Tkilltymon.SearchTYTarget;
var
  BaseObject, BaseObject18: TBaseObject;
  i, nC, n10: integer;
begin
  BaseObject18 := nil;
  n10 := 999;
  for i := 0 to m_VisibleActors.Count - 1 do
  begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject);
    if not BaseObject.m_boDeath then
    begin
      if IsProperTarget(BaseObject) and
        (not BaseObject.m_boHideMode or m_boCoolEye) then
      begin
        nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
        if BaseObject.m_btRaceServer = 17 then
        begin
          BaseObject18 := BaseObject;
          break;
        end;
        if nC < n10 then
        begin
          n10 := nC;
          BaseObject18 := BaseObject;
        end;
      end;
    end;
  end;
  if BaseObject18 <> nil then
    SetTargetCreat {FFF2}(BaseObject18);
end;

{ Ttiaopi }

procedure Ttiaopi.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  BaseObject: TBaseObject;
  i, nDamage, nPower: integer;
  WAbil: pTAbility;
  Range,
    nStartX,
    nEndX,
    nStartY,
    nEndY, nx, ny, nHTime: integer;
  FireBurnEvent: TFireBurnEvent;
  bohaspush: boolean;
begin
  inherited;
  for I := 0 to m_VisibleActors.Count - 1 do
  begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if BaseObject.m_boDeath then
      Continue;
    if IsProperTarget(BaseObject) then
    begin
      if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then
      begin
        nDamage := 0;
        WAbil := @m_WAbil;
        nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));

        Inc(nDamage, BaseObject.GetHitStruckDamage(Self, nPower));
        Inc(nDamage, BaseObject.GetMagStruckDamage(Self, nPower));
        if nDamage > 0 then
        begin

          BaseObject.StruckDamage(nDamage);
          BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 200);
          bohaspush := false;
          if random(6) < 4 then
            BaseObject.CharPushed(GetNextDirection(m_nCurrx, m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY), random(5) + 3);
          bohaspush := true;


        end;
      end;
    end;
  end; // for
  if bohaspush then
  begin
    Range := 4;
    nStartX := m_nCurrX - Range;
    nEndX := m_nCurrX + Range;
    nStartY := m_nCurrY - Range;
    nEndY := m_nCurrY + Range;

    for nx := nStartX to nEndX do
    begin
      for ny := nStartY to nEndY do
      begin
        nHTime := 20; //random(5)+5;
        if m_PEnvir.GetEvent(nx, ny) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nx, ny, ET_FIRE, nHTime * 1000, nPower div 2);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //0492CFC   x
      end; //for
    end; //for
  end; // random(10)<2

end;


constructor Ttiaopi.Create;
begin
  inherited;
  m_btRaceServer := 210;
end;

destructor Ttiaopi.Destroy;
begin

  inherited;
end;

procedure Ttiaopi.Run;
begin
  if not m_boDeath and
    not bo554 and
    not m_boGhost and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
  begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then
    begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;
  end;

  inherited;
end;




end.
