unit ObjAxeMon;

interface
uses
  Windows, Classes, Grobal2, ObjBase, Event, ObjMon;
type
  TDualAxeMonster = class(TMonster)
    bo558: Boolean;
    m_nAttackCount: Integer; //0x55C
    m_nAttackMax: Integer; //0x560
  private
    procedure FlyAxeAttack(Target: TBaseObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override; //FFEB
    procedure Run; override;
  end;
  TMonster21 = class(TAnimalObject)

  private
   procedure FlyAxeAttack(Target: TBaseObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;




  TThornDarkMonster = class(TDualAxeMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TNIMOAXEMonster = class(TDualAxeMonster)
    pm_wAppr: Integer;
  private
    procedure MeltStone; //
    procedure MeltStoneAll;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;


  TArcherMonster = class(TDualAxeMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
implementation

uses M2Share, HUtil32;



{ TDualAxeMonster }

procedure TDualAxeMonster.FlyAxeAttack(Target: TBaseObject);
var
  WAbil: pTAbility;
  nDamage: Integer;
begin
  if m_PEnvir.CanFly(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY) then
  begin //
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY);
    WAbil := @m_WAbil;
    nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if nDamage > 0 then
    begin
      nDamage := Target.GetHitStruckDamage(Self, nDamage);
    end;
    if nDamage > 0 then
    begin
      Target.StruckDamage(nDamage);
      Target.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, Target.m_WAbil.HP, Target.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - Target.m_nCurrX), abs(m_nCurrY - Target.m_nCurrY)) * 50 + 600);
    end;
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(Target), '');
  end;

end;

function TDualAxeMonster.AttackTarget: Boolean; //00459B14
begin
  Result := False;
  if m_TargetCret = nil then
    exit;
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
  begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) and (abs(m_nCurry - m_TargetCret.m_nCurry) <= 7) then
    begin
      if (m_nAttackMax - 1) > m_nAttackCount then
      begin
        Inc(m_nAttackCount);
        m_dwTargetFocusTick := GetTickCount();
        FlyAxeAttack(m_TargetCret);
      end
      else
      begin
        if Random(5) = 0 then
        begin
          m_nAttackCount := 0;
        end;
      end;
      Result := True;
      exit;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then
    begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurry - m_TargetCret.m_nCurry) <= 11) then
      begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end
    else
    begin
      DelTargetCreat();
    end;
  end;
end;

constructor TDualAxeMonster.Create;
begin
  inherited;
  bo558 := False;
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000;
  m_nAttackCount := 0;
  m_nAttackMax := 2;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 87;
end;

destructor TDualAxeMonster.Destroy;
begin

  inherited;
end;

procedure TDualAxeMonster.Run; //00459C98
var
  I: Integer;
  nAbs: Integer;
  nRage: Integer;
  BaseObject: TBaseObject;
  TargetBaseObject: TBaseObject;
begin
  nRage := 9999;
  TargetBaseObject := nil;
  if not m_boDeath and
    not bo558 and
    not m_boGhost and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
  begin

    if (GetTickCount - m_dwSearchEnemyTick) >= 5000 then
    begin
      m_dwSearchEnemyTick := GetTickCount();
      for I := 0 to m_VisibleActors.Count - 1 do
      begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject.m_boDeath then
          Continue;
        if IsProperTarget(BaseObject) then
        begin
          if not BaseObject.m_boHideMode or m_boCoolEye then
          begin
            nAbs := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nAbs < nRage then
            begin
              nRage := nAbs;
              TargetBaseObject := BaseObject;
            end;
          end;
        end;
      end;
      if TargetBaseObject <> nil then
      begin
        SetTargetCreat(TargetBaseObject);
      end;
    end;

    if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and (m_TargetCret <> nil) then
    begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurry - m_TargetCret.m_nCurry) <= 4) then
      begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurry - m_TargetCret.m_nCurry) <= 2) then
        begin
          if Random(5) = 0 then
          begin
            GetBackPosition(m_nTargetX, m_nTargetY);
          end;
        end
        else
        begin
          GetBackPosition(m_nTargetX, m_nTargetY);
        end;
      end;
    end;
  end;
  inherited;
end;

{ TThornDarkMonster }

constructor TThornDarkMonster.Create; //00459EE4
begin
  inherited;
  m_nAttackMax := 3;
  m_btRaceServer := 93;


end;

destructor TThornDarkMonster.Destroy;
begin

  inherited;
end;


procedure TThornDarkMonster.Run; //00459C98

begin
  if not m_boGhost and
    not m_boDeath and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
  begin
    if m_VisibleActors.Count > 0 then
      AttackTarget();
  end;
  inherited;
end;
/////////// TNIMOAXEMonster

procedure TNIMOAXEMonster.MeltStone;
var //ElfMon:TBaseObject;
  Event: TEvent;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
 //    SendRefMsg(rm_10206,m_btDirection,m_nCurrX,m_nCurrY,0,''); //ÆÆ¿Ç

  m_wAppr := pm_wAppr;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boStoneMode := False;


  Event := TEvent.Create(m_PEnvir, m_nCurrX, m_nCurrY, 6, 5 * 60 * 1000, True);
  Event.m_nEventParam := 1;
  g_EventManager.AddEvent(Event);


end;

procedure TNIMOAXEMonster.MeltStoneAll;
var
  I: Integer;
  List10: TList;
  BaseObject: TBaseObject;
begin
  MeltStone();
  List10 := TList.Create;
  GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 2, List10); //7
  for I := 0 to List10.Count - 1 do
  begin
    BaseObject := TBaseObject(List10.Items[I]);
    if BaseObject.m_boStoneMode then
    begin
      if BaseObject is TNIMOAXEMonster then
      begin
        TNIMOAXEMonster(BaseObject).MeltStone
      end;
    end;
  end; // for
  List10.Free;
end;

constructor TNIMOAXEMonster.Create; //00459EE4
begin
  inherited;
  m_nAttackMax := 3;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 7;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;

end;

destructor TNIMOAXEMonster.Destroy;
begin

  inherited;
end;


procedure TNIMOAXEMonster.Run; //00459C98
var
  I: Integer;
  n10: Integer;
  BaseObject: TBaseObject;
begin
  if (not m_boGhost) and
    (not m_boDeath) and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) and
    (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then
  begin
    n10 := 0;
    if m_boStoneMode then
    begin
      for I := 0 to m_VisibleActors.Count - 1 do
      begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject.m_boDeath then
          Continue;
        if IsProperTarget(BaseObject) then
        begin
          if not BaseObject.m_boHideMode or m_boCoolEye then
          begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 2) then
            begin
              MeltStoneAll();
              break;
            end;
          end;
        end;
      end; // for
    end
    else
    begin //004AB0C7
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then
      begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
      end;
    end;
  end;
  inherited;
end;


{ TArcherMonster }

constructor TArcherMonster.Create;
begin
  inherited;
  m_nAttackMax := 6;
  m_btRaceServer := 104;
end;

destructor TArcherMonster.Destroy;
begin

  inherited;
end;
{ TMonster21 }

constructor TMonster21.Create;
begin
  inherited;

end;

destructor TMonster21.Destroy;
begin

  inherited;
end;

procedure TMonster21.FlyAxeAttack(Target: TBaseObject);
var
  WAbil: pTAbility;
  nDamage: Integer;
begin
  if m_PEnvir.CanFly(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY) then
  begin //
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY);
    WAbil := @m_WAbil;
    nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if nDamage > 0 then
    begin
      nDamage := Target.GetHitStruckDamage(Self, nDamage);
    end;
    if nDamage > 0 then
    begin
      Target.StruckDamage(nDamage);
      Target.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, Target.m_WAbil.HP, Target.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - Target.m_nCurrX), abs(m_nCurrY - Target.m_nCurrY)) * 50 + 600);
    end;
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(Target), '');
  end;

end;

procedure TMonster21.Run;
var
  I: Integer;
  nAbs: Integer;
  nRage: Integer;
  BaseObject: TBaseObject;
  TargetBaseObject: TBaseObject;
  bt06:Byte;
begin


  if  (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then
  begin
     if m_TargetCret = nil then
     begin
       SearchViewRange;
         for I := 0 to m_VisibleActors.Count - 1 do
      begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject.m_boDeath then
          Continue;
        if (BaseObject<>m_Master)and(BaseObject<>Self)and(BaseObject.m_Master=nil)and(not BaseObject.m_boGhost) then
        begin
           if m_btRaceServer=21 then
           Begin
             SetTargetCreat(BaseObject);
             Break;
           End
           else
           begin
               if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 2) and (abs(m_nCurry - BaseObject.m_nCurry) <= 2)and(not BaseObject.m_boGhost)and(not BaseObject.m_boDeath) then
               begin
                 if GetAttackDir(BaseObject, bt06) then
                  begin
                    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
                    begin
                      m_dwHitTick := GetTickCount();
                      m_dwTargetFocusTick := GetTickCount();
                      Attack(BaseObject, bt06); //FFED

                    end;

                  end
               end;
           end;

        end;
      end;
     end;
     if m_TargetCret <> nil then
          begin
               if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 7) and (abs(m_nCurry - m_TargetCret.m_nCurry) <= 7)and(not m_TargetCret.m_boGhost)and(not m_TargetCret.m_boDeath) then
               begin
                  FlyAxeAttack(m_TargetCret);
                  m_TargetCret.SetLastHiter(Self);
               end
               else
                 m_TargetCret:=nil;
          end;
            m_dwWalkTick:=GetTickCount;
  end;

  inherited ;
end;

end.
