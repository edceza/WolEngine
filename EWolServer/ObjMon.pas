unit ObjMon;

interface
uses
  Windows, Classes, Grobal2, ObjBase, sysutils, HUtil32, Envir;    
type
  TMonster = class(TAnimalObject)
    n54C: Integer; //0x54C
    m_dwThinkTick: LongWord; //0x550
    bo554: Boolean; //0x554
    m_boDupMode: Boolean; //0x555
    m_btUsePoison: integer;

  private
    function Think: Boolean;
    function MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    function AttackTarget(): Boolean; virtual; //FFEB
    procedure Run; override;
  end;

  TMonster1 = class(TAnimalObject)
    n54C: Integer; //0x54C
    m_dwThinkTick: LongWord; //0x550
    bo554: Boolean; //0x554
    m_boDupMode: Boolean; //0x555
    m_btusefire: integer;
    m_btUsePoison: integer;
    curpos: integer;
    setpcount: integer;
    m_canpickup: Boolean;
    bo_oldrelax: boolean;
  private
    function Think: Boolean;
    function MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject;
    function Makefire(nx, ny, btdir: integer): boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    function AttackTarget(): Boolean; virtual; //FFEB
    procedure Run; override;
  end;

  TAIMAN = class(TAnimalObject)
    n54C: Integer; //0x54C
    m_dwThinkTick: LongWord; //0x550
    bo554: Boolean; //0x554
    m_boDupMode: Boolean; //0x555

    curpos: integer;
    setpcount: integer;
  private
    function Think: Boolean;
    function MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    function AttackTarget(): Boolean; virtual; //FFEB
    procedure SearchViewRange(); override;
    procedure Run; override;
  end;







  TChickenDeer = class(TMonster)

  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;


  TATMonster = class(TMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TfireMonster = class(TMonster1)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
   TMonster12 = class(TMonster)
  private
    m_Targetx1,m_Targety1:array[0..3] of Integer;
    nIndex:Integer;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TSlowATMonster = class(TATMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TScorpion = class(TATMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TSpitSpider = class(TATMonster)
    m_boUsePoison: Boolean;
  private
    procedure SpitAttack(btDir: Byte);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; {virtual;//}
    override; //FFEB
  end;
  THighRiskSpider = class(TSpitSpider)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TBigPoisionSpider = class(TSpitSpider)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TGasAttackMonster = class(TATMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget: Boolean; override;
    function sub_4A9C78(bt05: Byte): TBaseObject; virtual; //FFEA
  end;
  TCowMonster = class(TATMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TMagCowMonster = class(TATMonster)
  private
    procedure sub_4A9F6C(btDir: Byte);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget: Boolean; override;
  end;
  TCowKingMonster = class(TATMonster)
    dw558: LongWord;
    bo55C: Boolean;
    bo55D: Boolean;
    n560: integer;
    dw564: LongWord;
    dw568: LongWord;
    dw56C: LongWord;
    dw570: LongWord;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
    procedure Initialize(); override;
  end;

  TElectronicScolpionMon = class(TMonster)
  private
    m_boUseMagic: Boolean;
    procedure LightingAttack(nDir: Integer);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TLightingZombi = class(TMonster)
  private
    procedure LightingAttack(nDir: Integer);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TDigOutZombi = class(TMonster)
  private
    procedure sub_4AA8DC;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TZilKinZombi = class(TATMonster)
    dw558: LongWord;
    nZilKillCount: Integer;
    dw560: LongWord;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Die; override;
    procedure Run; override;
  end;
  TWhiteSkeleton = class(TATMonster)
    m_boIsFirst: Boolean;
  private
    procedure sub_4AAD54;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;

  TScultureMonster = class(TMonster)

  private
    procedure MeltStone; //
    procedure MeltStoneAll;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TNIMOKEMonster = class(TMonster)
    pm_wAppr: integer;
  private
    procedure MeltStone; //
    procedure MeltStoneAll;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;


  TScultureKingMonster = class(TMonster)
    m_nDangerLevel: Integer;
    m_SlaveObjectList: TList; //0x55C
    pm_wAppr: integer;
  private
    procedure MeltStone;
    procedure CallSlave;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override; //0FFED
    procedure Run; override;
  end;
 //铁血魔王类型    06.1.16
  Ttiexueking = class(TMonster)
    m_nDangerLevel: Integer;
    m_SlaveObjectList: TList; //0x55C
    dw558: LongWord;
  private
    procedure MeltStone;
    procedure CallSlave;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;
 ////////////


  TGasMothMonster = class(TGasAttackMonster) //楔蛾
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function sub_4A9C78(bt05: Byte): TBaseObject; override; //FFEA
  end;
  TGasDungMonster = class(TGasAttackMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TElfMonster = class(TMonster)
    boIsFirst: Boolean; //0x558
  private
    procedure AppearNow;
    procedure ResetElfMon;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;
  TElfWarriorMonster = class(TSpitSpider)
    n55C: Integer;
    boIsFirst: Boolean; //0x560
    dwDigDownTick: LongWord; //0x564
  private
    procedure AppearNow;
    procedure ResetElfMon;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;
implementation

uses UsrEngn, M2Share, Event;
{ TMonster }

constructor TMonster.Create; //004A8B74
begin
  inherited;
  m_boDupMode := False;
  bo554 := False;
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 80;
 // curpos:=0;
 // setpcount:=0;
  m_btUsePoison := -1;
 // m_btusefire:=-1;
end;

destructor TMonster.Destroy; //004A8C24
begin
  inherited;
end;
{function TMonster.Makefire(nx,ny,btdir:integer):boolean;
 var
  FireBurnEvent:TFireBurnEvent;
  nHTime,nDamage:integer;
begin
  nHTime:=_max(3,loword( m_WAbil.sC));

  nDamage:=_max(5,loword( m_WAbil.mC));
  if m_PEnvir.GetEvent(nX,nY-1) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY-1,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492CFC   x
  if m_PEnvir.GetEvent(nX-1,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX-1,nY,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492D4D
  if  m_PEnvir.GetEvent(nX,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492D9C
  if  m_PEnvir.GetEvent(nX+1,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX+1,nY,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492DED
  if  m_PEnvir.GetEvent(nX,nY+1) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY+1,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492E3E
  Result:=true;
end;
}

function TMonster.MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject; //004A8C58
var
  ElfMon: TBaseObject;
begin
  Result := nil;
  ElfMon := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, m_nCurrX, m_nCurrY, sMonName);
  if ElfMon <> nil then
  begin
    ElfMon.m_Master := OldMon.m_Master;
    ElfMon.m_dwMasterRoyaltyTick := OldMon.m_dwMasterRoyaltyTick;
    ElfMon.m_btSlaveMakeLevel := OldMon.m_btSlaveMakeLevel;
    ElfMon.m_btSlaveExpLevel := OldMon.m_btSlaveExpLevel;
    ElfMon.RecalcAbilitys;
    ElfMon.RefNameColor;
    if OldMon.m_Master <> nil then
      OldMon.m_Master.m_SlaveList.Add(ElfMon);
    ElfMon.m_WAbil := OldMon.m_WAbil;
    ElfMon.m_wStatusTimeArr := OldMon.m_wStatusTimeArr;
    ElfMon.m_TargetCret := OldMon.m_TargetCret;
    ElfMon.m_dwTargetFocusTick := OldMon.m_dwTargetFocusTick;
    ElfMon.m_LastHiter := OldMon.m_LastHiter;
    ElfMon.m_LastHiterTick := OldMon.m_LastHiterTick;
    ElfMon.m_btDirection := OldMon.m_btDirection;
    Result := ElfMon;
  end;
end;

function TMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);

end;

function TMonster.Think(): Boolean; //004A8E54
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

function TMonster.AttackTarget(): Boolean; //004A8F34
var
  bt06: Byte;
  nX, nY: INTEGER;
begin
  Result := False;
  if m_TargetCret <> nil then
  begin
    if GetAttackDir(m_TargetCret, bt06) then
    begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
      begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, bt06); //FFED
        if m_btUsePoison >= 0 then
        begin
          if random(5) < 2 then
            m_TargetCret.MakePosion(m_btUsePoison, _max(5, loword(m_WAbil.sC)), _max(5, loword(m_WAbil.mC)));
        end;
      {  if m_btusefire >=0 then begin
          GetFrontPosition(nX,nY);
          Makefire(nX,nY,BT06);

        end;
     }
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else
    begin
      if m_TargetCret.m_PEnvir = m_PEnvir then
      begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end
      else
      begin
        DelTargetCreat(); {0FFF1h}
        //004A9009
      end;
    end;
  end;
end;

procedure TMonster.Run; //004A9020
var
  nX, nY, i, count: Integer;
//  VisibleMapItem:pTVisibleMapItem;

begin
  if not m_boGhost and (not m_boPetOnSell)and
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
        if not m_boNoAttackMode then
        begin
          if m_TargetCret <> nil then
          begin
            if AttackTarget {FFEB} then
            begin
              inherited;
              exit;
            end;
          end
          else
          begin
            m_nTargetX := -1;
            if m_boMission then
            begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end; //004A91D3
          end;
        end; 
        if m_Master <> nil then
        begin
          if m_TargetCret = nil then
          begin
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
                end
              end;
            end;
          end;
          if (not m_Master.m_boSlaveRelax) and(not m_boPetOnSell) and
            ((m_PEnvir <> m_Master.m_PEnvir) or
            (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
            (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) and (not m_bohorserelax) then
          begin
            SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
          end;
        end;
      end
      else
      begin //004A9344
        if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then
        begin
          m_boRunAwayMode := False;
          m_dwRunAwayTime := 0;
        end;
      end; //004A937E
      if ((m_Master <> nil) and m_Master.m_boSlaveRelax) or m_bohorserelax or (m_boPetOnSell) then
      begin
        inherited;
        exit;
      end; //004A93A6



      if m_nTargetX <> -1 then
      begin
        GotoTargetXY();
      end
      else
      begin
        if m_TargetCret = nil then
          Wondering();
      end;
    end;
  end;




  inherited;

end;

{ TMonster 1}

constructor TMonster1.Create; //004A8B74
begin
  inherited;
  m_boDupMode := False;
  bo554 := False;
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 80;
  curpos := 0;
  setpcount := 0;
  m_btUsePoison := -1;
  m_btusefire := -1;
end;

destructor TMonster1.Destroy; //004A8C24
begin
  inherited;
end;

function TMonster1.Makefire(nx, ny, btdir: integer): boolean;
var
  FireBurnEvent: TFireBurnEvent;
  nHTime, nDamage, i, tx, ty: integer;
begin
  nHTime := _max(3, loword(m_WAbil.sC));

  nDamage := _max(5, loword(m_WAbil.mC));
  for i := 0 to 2 do
  begin
    m_PEnvir.GetNextPosition(nx, ny, btdir, i, tx, ty);
    if m_PEnvir.GetEvent(tX, tY) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(self, tx, ty, m_btusefire, nHTime * 1000, nDamage);
      g_EventManager.AddEvent(FireBurnEvent);
    end;


  end;
 {
  if m_PEnvir.GetEvent(nX,nY-1) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY-1,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492CFC   x
  if m_PEnvir.GetEvent(nX-1,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX-1,nY,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492D4D
  if  m_PEnvir.GetEvent(nX,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492D9C
  if  m_PEnvir.GetEvent(nX+1,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX+1,nY,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492DED
  if  m_PEnvir.GetEvent(nX,nY+1) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY+1,m_btusefire,nHTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492E3E }
  Result := true;
end;


function TMonster1.MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject; //004A8C58
var
  ElfMon: TBaseObject;
begin
  Result := nil;
  ElfMon := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, m_nCurrX, m_nCurrY, sMonName);
  if ElfMon <> nil then
  begin
    ElfMon.m_Master := OldMon.m_Master;
    ElfMon.m_dwMasterRoyaltyTick := OldMon.m_dwMasterRoyaltyTick;
    ElfMon.m_btSlaveMakeLevel := OldMon.m_btSlaveMakeLevel;
    ElfMon.m_btSlaveExpLevel := OldMon.m_btSlaveExpLevel;
    ElfMon.RecalcAbilitys;
    ElfMon.RefNameColor;
    if OldMon.m_Master <> nil then
      OldMon.m_Master.m_SlaveList.Add(ElfMon);
    ElfMon.m_WAbil := OldMon.m_WAbil;
    ElfMon.m_wStatusTimeArr := OldMon.m_wStatusTimeArr;
    ElfMon.m_TargetCret := OldMon.m_TargetCret;
    ElfMon.m_dwTargetFocusTick := OldMon.m_dwTargetFocusTick;
    ElfMon.m_LastHiter := OldMon.m_LastHiter;
    ElfMon.m_LastHiterTick := OldMon.m_LastHiterTick;
    ElfMon.m_btDirection := OldMon.m_btDirection;
    Result := ElfMon;
  end;
end;

function TMonster1.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);

end;

function TMonster1.Think(): Boolean; //004A8E54
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
  if m_boPetOnSell then
     Result:=True;
end;

function TMonster1.AttackTarget(): Boolean; //004A8F34
var
  bt06: Byte;
  nX, nY: INTEGER;
begin
  Result := False;
  if m_TargetCret <> nil then
  begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
    begin
      if GetAttackDirx(m_TargetCret, 3, bt06) then
      begin

      //  m_dwHitTick:=GetTickCount();
      //  m_dwTargetFocusTick:=GetTickCount();
        m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        if m_btusefire >= 0 then
        begin
          GetFrontPosition(nX, nY);
          turnto(m_btDirection);
          Makefire(nX, nY, m_btDirection);

        end;

      end; // GetAttackDirx
      if GetAttackDir(m_TargetCret, bt06) then
      begin
     // if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime  then begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, bt06); //FFED
        if m_btUsePoison >= 0 then
        begin
          if random(5) < 2 then
            m_TargetCret.MakePosion(m_btUsePoison, _max(5, loword(m_WAbil.sC)), _max(5, loword(m_WAbil.mC)));
        end;


        BreakHolySeizeMode();
    //  end;
        Result := True;
      end

      else
      begin
        if m_TargetCret.m_PEnvir = m_PEnvir then
        begin
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
        end
        else
        begin
          DelTargetCreat(); {0FFF1h}
        //004A9009
        end;
      end;
    end // if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime
  end; //if m_TargetCret <> nil
end;

procedure TMonster1.Run; //004A9020
var
  nX, nY, i, count: Integer;
  VisibleMapItem: pTVisibleMapItem;

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
        if not m_boNoAttackMode then
        begin
          if m_TargetCret <> nil then
          begin
            if AttackTarget {FFEB} then
            begin
              inherited;
              exit;
            end;
          end
          else
          begin
            m_nTargetX := -1;
            if m_boMission then
            begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end; //004A91D3
          end;
        end; //004A91D3  if not bo2C0 then begin
        if m_Master <> nil then
        begin
          if m_TargetCret = nil then
          begin
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
          end; //004A92A5 if m_TargetCret = nil then begin
          if (not m_Master.m_boSlaveRelax) and (not m_boPetOnSell)and
            ((m_PEnvir <> m_Master.m_PEnvir) or
            (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
            (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) and (not m_bohorserelax) then
          begin
            SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
          end; // 004A937E
          if bo_oldrelax <> m_Master.m_boSlaveRelax then
          begin
            bo_oldrelax := m_Master.m_boSlaveRelax;
            if m_Master.m_boSlaveRelax or m_boPetOnSell then
            begin //属下休息
              m_nBaoziStatus := 1;
              SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
            end
            else
            begin
              m_nBaoziStatus := 0;
              SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
            end;
          end;
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
      if ((m_Master <> nil) and m_Master.m_boSlaveRelax) or m_bohorserelax then
      begin
        inherited;
        exit;
      end; //004A93A6



      if m_canpickup then
      begin
        if m_Master <> nil then
        begin
          if (abs(m_nCurrX - m_Master.m_nCurrX) > 10) or (abs(m_nCurrY - m_Master.m_nCurrY) > 10) then
          begin
            curpos := 0;
            setpcount := 0;
            count := m_Master.m_mobpicupItems.Count;

            if count > 0 then
            begin
              m_Master.m_bocanaddpickupitem := false;
              for i := 0 to Count - 1 do
              begin
                VisibleMapItem := m_Master.m_mobpicupItems.Items[i];
                //  m_Master.m_mobpicupItems.Delete(0);
                Dispose(VisibleMapItem);
              end; //004B82E3
              m_Master.m_mobpicupItems.Clear;
              m_Master.m_bocanaddpickupitem := true;
            end;
       //     MainOutMessage('清除检物品列表');
          end;
          if m_Master.m_mobpicupItems.Count > 0 then
          begin
            if curpos <= m_Master.m_mobpicupItems.Count - 1 then
            begin
              VisibleMapItem := m_Master.m_mobpicupItems[curpos];
              if m_PEnvir.CanWalk(VisibleMapItem.nX, VisibleMapItem.nY, False) then
              begin //如果这个物品可以走上去
                m_nTargetX := VisibleMapItem.nX;
                m_nTargetY := VisibleMapItem.nY;
         //     MainOutMessage(format('当前处理目标 %d/%d 为(%d/%d)',[curpos,m_Master.m_mobpicupItems.Count-1,m_nTargetX,m_nTargetY]));
              end
              else
              begin
                if (m_nCurrX <> VisibleMapItem.nX) and (m_nCurrY <> VisibleMapItem.nY) then
                begin

                  inc(curpos); //如果不能走,且不是自己在物品上 就检下一个。

           //     MainOutMessage(format('如果不能走到有人在上面，检取下一个%d 为(%d/%d)',[curpos,VisibleMapItem.nX,VisibleMapItem.nY]));
                end;
                setpcount := 0;
              end;
              if (m_nCurrX = VisibleMapItem.nX) and (m_nCurrY = VisibleMapItem.nY) then
              begin
                if (m_Master.m_btRaceServer = RC_PLAYOBJECT) and Tplayobject(m_Master).ClientPickUpItemxy(m_nCurrX, m_nCurrY) then
                begin
                  if curpos <= m_Master.m_mobpicupItems.Count - 1 then
                  begin
                    VisibleMapItem := m_Master.m_mobpicupItems.Items[curpos];
                    m_Master.m_mobpicupItems.Delete(curpos);
                    Dispose(VisibleMapItem);
                  end;
                  setpcount := 0;
                end
                else
                begin //如果检起失败
                  inc(curpos); //检下一个   如果超过 就不再检了。
                  setpcount := 0;
              // if curpos> m_Master.m_VisibleItems.Count-1 then
                end;

              end //     m_nCurrX= VisibleMapItem.nX
              else
              begin //如果走了10步还不能检取就检下一个
                inc(setpcount);

                if setpcount > 10 then
                begin
                  if curpos < m_Master.m_mobpicupItems.Count then
                  begin
                    inc(curpos);
                 //    MainOutMessage(format('如果走了10步不能检取就检下一个%d 为(%d/%d)',[curpos,VisibleMapItem.nX,VisibleMapItem.nY]));
                  end;
                  setpcount := 0;
                end;

              end;
            end; //  curpos<= m_Master.m_VisibleItems.Count-1

          end;
        end;
      end;


      ////
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



///////////aiman

constructor TAIMAN.Create; //004A8B74
begin
  inherited;
  m_boDupMode := False;
  bo554 := False;
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 80;
  curpos := 0;
  setpcount := 0;
end;

destructor TAIMAN.Destroy; //004A8C24
begin
  inherited;
end;

function TAIMAN.MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject; //004A8C58
var
  ElfMon: TBaseObject;
begin
  Result := nil;
  ElfMon := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, m_nCurrX, m_nCurrY, sMonName);
  if ElfMon <> nil then
  begin
    ElfMon.m_Master := OldMon.m_Master;
    ElfMon.m_dwMasterRoyaltyTick := OldMon.m_dwMasterRoyaltyTick;
    ElfMon.m_btSlaveMakeLevel := OldMon.m_btSlaveMakeLevel;
    ElfMon.m_btSlaveExpLevel := OldMon.m_btSlaveExpLevel;
    ElfMon.RecalcAbilitys;
    ElfMon.RefNameColor;
    if OldMon.m_Master <> nil then
      OldMon.m_Master.m_SlaveList.Add(ElfMon);
    ElfMon.m_WAbil := OldMon.m_WAbil;
    ElfMon.m_wStatusTimeArr := OldMon.m_wStatusTimeArr;
    ElfMon.m_TargetCret := OldMon.m_TargetCret;
    ElfMon.m_dwTargetFocusTick := OldMon.m_dwTargetFocusTick;
    ElfMon.m_LastHiter := OldMon.m_LastHiter;
    ElfMon.m_LastHiterTick := OldMon.m_LastHiterTick;
    ElfMon.m_btDirection := OldMon.m_btDirection;
    Result := ElfMon;
  end;
end;

function TAIMAN.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

function TAIMAN.Think(): Boolean; //004A8E54
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

function TAIMAN.AttackTarget(): Boolean; //004A8F34
var
  bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then
  begin
    if GetAttackDir(m_TargetCret, bt06) then
    begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
      begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        Attack(m_TargetCret, bt06); //FFED
        BreakHolySeizeMode();
      end;
      Result := True;
    end
    else
    begin
      if m_TargetCret.m_PEnvir = m_PEnvir then
      begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end
      else
      begin
        DelTargetCreat(); {0FFF1h}
        //004A9009
      end;
    end;
  end;
end;

procedure TAIMAN.SearchViewRange;
//begin
 // inherited;
//end;
var
  I: Integer;
  nStartX: Integer;
  nEndX: Integer;
  nStartY: Integer;
  nEndY: Integer;
  n18: Integer;
  n1C: Integer;
  nIdx: Integer;
  n24: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  MapItem: PTMapItem;
  MapEvent: TEvent;
  VisibleBaseObject: pTVisibleBaseObject;
  nCheckCode: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TBaseObject::SearchViewRange Code:%d';
  sExceptionMsg2 = '[Exception] TBaseObject::SearchViewRange 1-%d %s %s %d %d %d';

begin
  nCheckCode := 0;
  if m_PEnvir = nil then
  begin
    MainOutMessage('SearchViewRange nil PEnvir');
    exit;
  end;
  nCheckCode := 1;
  n24 := 0;
  m_boIsVisibleActive := False; //先置为FALSE
  try
    nCheckCode := 4;
    for I := 0 to m_VisibleActors.Count - 1 do
    begin
      pTVisibleBaseObject(m_VisibleActors.Items[I]).nVisibleFlag := 0;
    end;
    nCheckCode := 5;
  except
    MainOutMessage(format(sExceptionMsg1, [nCheckCode]));
    KickException();
  end;
  nCheckCode := 6;

  nStartX := m_nCurrX - m_nViewRange;
  nEndX := m_nCurrX + m_nViewRange;
  nStartY := m_nCurrY - m_nViewRange;
  nEndY := m_nCurrY + m_nViewRange;
  try
    nCheckCode := 7;
    for n18 := nStartX to nEndX do
    begin
      nCheckCode := 8;
      for n1C := nStartY to nEndY do
      begin
        nCheckCode := 9;
        if m_PEnvir.GetMapCellInfo(n18, n1C, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
        begin
          nCheckCode := 10;
          n24 := 1;
          nIdx := 0;
          while (True) do
          begin
            nCheckCode := 11;
            if MapCellInfo.ObjList.Count <= nIdx then
              break; //004B9858
            OSObject := MapCellInfo.ObjList.Items[nIdx];
            nCheckCode := 12;
             //////////  2006，8，3 处理抱错
            if OSObject = nil then
            begin
              MapCellInfo.ObjList.Delete(nIdx);
              if MapCellInfo.ObjList.Count > 0 then
                Continue;
              MapCellInfo.ObjList.Free;
              MapCellInfo.ObjList := nil;
              break;
            end;
              ///////////
            if OSObject <> nil then
            begin
              nCheckCode := 13;
              if OSObject.btType = OS_MOVINGOBJECT then
              begin
                nCheckCode := 14;
                if (GetTickCount - OSObject.dwAddTime) >= 60 * 1000 then
                begin
                  Dispose(OSObject);
                  MapCellInfo.ObjList.Delete(nIdx);
                  if MapCellInfo.ObjList.Count > 0 then
                    Continue;
                  MapCellInfo.ObjList.Free;
                  MapCellInfo.ObjList := nil;
                  break;
                end; //004B9907
                nCheckCode := 15;
                BaseObject := TBaseObject(OSObject.CellObj);
                if BaseObject <> nil then
                begin
                  nCheckCode := 16;
                  if not BaseObject.m_boGhost and not BaseObject.m_boFixedHideMode and not BaseObject.m_boObMode then
                  begin
                    nCheckCode := 17;
                    if (m_btRaceServer < RC_ANIMAL) or
                      (m_Master <> nil) or
                      m_boCrazyMode or
                      m_boWantRefMsg or
                      ((BaseObject.m_Master <> nil) and (abs(BaseObject.m_nCurrX - m_nCurrX) <= 3) and (abs(BaseObject.m_nCurrY - m_nCurrY) <= 3)) or
                      (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then
                    begin
                      nCheckCode := 18;
                      UpdateVisibleGay(BaseObject);
                      nCheckCode := 19;
                    end;
                  end;
                end;
              end;
            end; // if OSObject.btType = OS_MOVINGOBJECT
           ///
             //  if m_btRaceServer=16 then begin  //如果是垃圾收集员
            if OSObject.btType = OS_ITEMOBJECT then
            begin
              nCheckCode := 21;
              if (GetTickCount - OSObject.dwAddTime) > g_Config.dwClearDropOnFloorItemTime {60 * 60 * 1000} then
              begin
                Dispose(pTMapItem(OSObject.CellObj)); //Jacky 10/22  防止占用内存不释放现象
                Dispose(OSObject);
                MapCellInfo.ObjList.Delete(nIdx);
                if MapCellInfo.ObjList.Count > 0 then
                  Continue;
                MapCellInfo.ObjList.Free;
                MapCellInfo.ObjList := nil;
                break;
              end; //004B9A8E
              MapItem := pTMapItem(OSObject.CellObj);
              nCheckCode := 28;
              UpdateVisibleItem(n18, n1C, MapItem);
              if (MapItem.OfBaseObject <> nil) or (MapItem.DropBaseObject <> nil) then
              begin
                nCheckCode := 29;
                if (GetTickCount - MapItem.dwCanPickUpTick) > g_Config.dwFloorItemCanPickUpTime {2 * 60 * 1000} then
                begin
                  nCheckCode := 30;
                  MapItem.OfBaseObject := nil;
                  MapItem.DropBaseObject := nil;
                end
                else
                begin //004B9AF6
                  nCheckCode := 31;
                  if TBaseObject(MapItem.OfBaseObject) <> nil then
                  begin
                    nCheckCode := 32;
                    if TBaseObject(MapItem.OfBaseObject).m_boGhost then
                      MapItem.OfBaseObject := nil;
                  end;
                  nCheckCode := 33;
                  if TBaseObject(MapItem.DropBaseObject) <> nil then
                  begin
                    nCheckCode := 34;
                    if TBaseObject(MapItem.DropBaseObject).m_boGhost then
                      MapItem.DropBaseObject := nil;
                  end;
                  nCheckCode := 35;
                end; //004B9B38
              end;
            end; //004B9B38 if OSObject.btType = OS_ITEMOBJECT then begin
             //   end; //m_btRaceServer=202


          ////
            Inc(nIdx);
          end;
        end;
      end;
    end;
  except
    on e: Exception do
    begin

      MainOutMessage(format(sExceptionMsg2, [n24, m_sCharName, m_sMapName, m_nCurrX, m_nCurrY, nCheckCode]));
      {
      MainOutMessage(m_sCharName + ',' +
                     m_sMapName + ',' +
                     IntToStr(m_nCurrX) + ',' +
                     IntToStr(m_nCurrY) + ',' +
                     ' SearchViewRange 1-' +
                     IntToStr(n24));
      }
      MainOutMessage(E.Message);
      raise;
      KickException();
    end;

  end;
  nCheckCode := 40;
  n24 := 2;
  try
    n18 := 0;
    while (True) do
    begin
      if m_VisibleActors.Count <= n18 then
        break;
      nCheckCode := 41;
      VisibleBaseObject := m_VisibleActors.Items[n18];
      nCheckCode := 42;
      if VisibleBaseObject.nVisibleFlag = 0 then
      begin
        nCheckCode := 43;
        m_VisibleActors.Delete(n18);
        nCheckCode := 48;
        Dispose(VisibleBaseObject);
        nCheckCode := 49;
        Continue;
      end;
      nCheckCode := 50;
      Inc(n18);
    end;
  except
    on e: Exception do
    begin
      MainOutMessage(format(sExceptionMsg2, [n24, m_sCharName, m_sMapName, m_nCurrX, m_nCurrY, nCheckCode]));
    {MainOutMessage(m_sCharName + ',' +
                   m_sMapName + ',' +
                   IntToStr(m_nCurrX) + ',' +
                   IntToStr(m_nCurrY) + ',' +
                   ' SearchViewRange 2');}
      KickException();
    end;
  end;
end;


procedure TAIMAN.Run; //004A9020
var
  nX, nY, i, count: Integer;
  VisibleMapItem: pTVisibleMapItem;
  MapItem: pTMapItem;
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
        if not m_boNoAttackMode then
        begin
          if m_TargetCret <> nil then
          begin
            if AttackTarget {FFEB} then
            begin
              inherited;
              exit;
            end;
          end
          else
          begin
            m_nTargetX := -1;
            if m_boMission then
            begin
              m_nTargetX := m_nMissionX;
              m_nTargetY := m_nMissionY;
            end; //004A91D3
          end;
        end; //004A91D3  if not bo2C0 then begin
        if m_Master <> nil then
        begin
          if m_TargetCret = nil then
          begin
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
          end; //004A92A5 if m_TargetCret = nil then begin
          if (not m_Master.m_boSlaveRelax) and (not m_boPetOnSell)and
            ((m_PEnvir <> m_Master.m_PEnvir) or
            (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
            (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) then
          begin
            SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
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
      if ((m_Master <> nil) and m_Master.m_boSlaveRelax )or( m_boPetOnSell) then
      begin
        inherited;
        exit;
      end; //004A93A6

      if m_VisibleItems.Count = 0 then
        curpos := 0;
      if m_VisibleItems.Count > 0 then
      begin
        if curpos <= m_VisibleItems.Count - 1 then
        begin
          VisibleMapItem := m_VisibleItems[curpos];
          m_nTargetX := VisibleMapItem.nX;
          m_nTargetY := VisibleMapItem.nY;


          if (m_nCurrX = VisibleMapItem.nX) and (m_nCurrY = VisibleMapItem.nY) then
          begin
            MapItem := m_PEnvir.GetItem(m_nCurrX, m_nCurrY);
            if (MapItem <> nil) and (m_PEnvir.DeleteFromMap(m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem)) = 1) then
            begin
              SearchViewRange;
              setpcount := 0;
              Dispose(MapItem);
            end
            else
            begin //如果检起失败
              inc(curpos); //检下一个   如果超过 就不再检了。
              setpcount := 0;
              // if curpos> m_Master.m_VisibleItems.Count-1 then
            end;

          end //     m_nCurrX= VisibleMapItem.nX
          else
          begin //如果走了10步还不能检取就检下一个
            inc(setpcount);

            if setpcount > 10 then
            begin
              if curpos < m_VisibleItems.Count then
              begin
                inc(curpos);
                 //    MainOutMessage(format('如果走了10步不能检取就检下一个%d 为(%d/%d)',[curpos,VisibleMapItem.nX,VisibleMapItem.nY]));
              end;
              setpcount := 0;
            end;
          end;

        end; //  curpos<= m_Master.m_VisibleItems.Count-1

      end;




      ////
      if m_nTargetX <> -1 then
      begin
        GotoTargetXY(); //004A93B5 0FFEF
      end
      else
      begin
        if m_TargetCret = nil then
          Wondering1(); // FFEE   //Jacky
      end; //004A93D8
    end; //004A93D8  if not bo510 and ((GetTickCount - m_dwWalkTick) > n4FC) then begin
  end; //004A93D8




  inherited;

end;







///////////////////end aiman
{ TChickenDeer }

constructor TChickenDeer.Create; //004A93E8
begin
  inherited;
  m_nViewRange := 5;
end;

destructor TChickenDeer.Destroy;
begin
  inherited;
end;

procedure TChickenDeer.Run; //004A9438
var
  I: Integer;
  nC, n10, n14, n1C: Integer;
  BaseObject1C, BaseObject: TBaseObject;
begin
  n10 := 9999;
  BaseObject := nil;
  BaseObject1C := nil;
  if not m_boDeath and
    not bo554 and
    not m_boGhost and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
  begin
    if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then
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
            nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nC < n10 then
            begin
              n10 := nC;
              BaseObject1C := BaseObject;
            end;
          end;
        end;
      end; // for
      if BaseObject1C <> nil then
      begin
        m_boRunAwayMode := True;
        m_TargetCret := BaseObject1C;
      end
      else
      begin
        m_boRunAwayMode := False;
        m_TargetCret := nil;
      end;
    end; //
    if m_boRunAwayMode and
      (m_TargetCret <> nil) and
      (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then
    begin
      if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 6) and (abs(m_nCurry - BaseObject.m_nCurry) <= 6) then
      begin
        n14 := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
      end;
    end;
  end;
  inherited;

end;

{ TATMonster }

constructor TATMonster.Create; //004A9690
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TATMonster.Destroy;
begin

  inherited;
end;

procedure TATMonster.Run; //004A9720
begin
  if not m_boDeath and
    not bo554 and
    not m_boGhost and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
  begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and ((m_TargetCret = nil) or ((m_TargetCret <> nil) and (m_TargetCret.m_bohastishen)))) then
    begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

{ TSlowATMonster }

constructor TSlowATMonster.Create; //004A97AC
begin
  inherited;
end;

destructor TSlowATMonster.Destroy;
begin

  inherited;
end;

{ TScorpion }

constructor TScorpion.Create; //004A97F0
begin
  inherited;
  m_boAnimal := True;
end;

destructor TScorpion.Destroy;
begin

  inherited;
end;

{ TSpitSpider }

constructor TSpitSpider.Create; //004A983C
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boAnimal := True;
  m_boUsePoison := True;
end;

destructor TSpitSpider.Destroy;
begin

  inherited;
end;

procedure TSpitSpider.SpitAttack(btDir: Byte); //004A98AC
var
  WAbil: pTAbility;
  nC, n10, n14, n18, n1C: Integer;
  BaseObject: TBaseObject;
begin
  m_btDirection := btDir;
  WAbil := @m_WAbil;
  n1C := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
  if n1C <= 0 then
    exit;
  SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  nC := 0;

  while (nC < 5) do
  begin
    n10 := 0;
    while (n10 < 5) do
    begin
      if g_Config.SpitMap[btDir, nC, n10] = 1 then
      begin
      {
                     (0, 0, 0, 0, 0),
                     (0, 0, 0, 0, 0),
                     (0, 0, 1, 0, 0),
                     (0, 0, 1, 0, 0)),
      }
        n14 := m_nCurrX - 2 + n10;
        n18 := m_nCurrY - 2 + nC;
        BaseObject := m_PEnvir.GetMovingObject(n14, n18, True);
        if (BaseObject <> nil) and
          (BaseObject <> Self) and
          (IsProperTarget(BaseObject)) and
          (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then
        begin
          n1C := BaseObject.GetMagStruckDamage(Self, n1C);
          if n1C > 0 then
          begin
            BaseObject.StruckDamage(n1C);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n1C, m_WAbil.HP, m_WAbil.MaxHP, Integer(Self), '', 300);
            if m_boUsePoison then
            begin
              if (Random(m_btAntiPoison + 20) = 0) then
                BaseObject.MakePosion(POISON_DECHEALTH, 30, 1);
              //if Random(2) = 0 then
              //  BaseObject.MakePosion(POISON_STONE,5,1);
            end;
          end;
        end;
      end;


      Inc(n10);
      {
      if n10 >= 5 then break;
      }
    end;
    Inc(nC);
    //if nC >= 5 then break;
  end; // while

end;

function TSpitSpider.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then
    exit;
  if TargetInSpitRange(m_TargetCret, btDir) then
  begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
    begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      SpitAttack(btDir);
      BreakHolySeizeMode();
    end;
    Result := True;
    exit;
  end;
  if m_TargetCret.m_PEnvir = m_PEnvir then
  begin
    SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  end
  else
  begin
    DelTargetCreat();
  end;

end;

{ THighRiskSpider }

constructor THighRiskSpider.Create; //004A9B64
begin
  inherited;
  m_boAnimal := False;
  m_boUsePoison := False;
end;

destructor THighRiskSpider.Destroy;
begin

  inherited;
end;

{ TBigPoisionSpider }

constructor TBigPoisionSpider.Create; //004A9BBC
begin
  inherited;
  m_boAnimal := False;
  m_boUsePoison := True;
end;

destructor TBigPoisionSpider.Destroy;
begin

  inherited;
end;

{ TGasAttackMonster }

constructor TGasAttackMonster.Create; //004A9C14
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boAnimal := True;
end;

destructor TGasAttackMonster.Destroy;
begin

  inherited;
end;

function TGasAttackMonster.sub_4A9C78(bt05: Byte): TBaseObject;
var
  WAbil: pTAbility;
  n10: integer;
  BaseObject: TBaseObject;
begin
  Result := nil;
  m_btDirection := bt05;
  WAbil := @m_WAbil;
  n10 := Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC);
  if n10 > 0 then
  begin
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    BaseObject := GetPoseCreate();
    if (BaseObject <> nil) and
      IsProperTarget(BaseObject) and
      (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then
    begin
      n10 := BaseObject.GetMagStruckDamage(Self, n10);
      if n10 > 0 then
      begin
        BaseObject.StruckDamage(n10);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n10, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 300);
        if Random(BaseObject.m_btAntiPoison + 20) = 0 then
        begin
          BaseObject.MakePosion(POISON_STONE, 5, 0)
        end;
        Result := BaseObject;
      end;
    end;
  end;

end;

function TGasAttackMonster.AttackTarget(): Boolean; //004A9DD4
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then
    exit;
  if GetAttackDir(m_TargetCret, btDir) then
  begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
    begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      sub_4A9C78(btDir);
      BreakHolySeizeMode();
    end;
    Result := True;
  end
  else
  begin
    if m_TargetCret.m_PEnvir = m_PEnvir then
    begin
      SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    end
    else
    begin
      DelTargetCreat();
    end;
  end;
end;

{ TCowMonster }

constructor TCowMonster.Create; //004A9EB4
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TCowMonster.Destroy;
begin

  inherited;
end;

{ TMagCowMonster }

constructor TMagCowMonster.Create; //004A9F10
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TMagCowMonster.Destroy;
begin

  inherited;
end;

procedure TMagCowMonster.sub_4A9F6C(btDir: Byte);
var
  WAbil: pTAbility;
  n10: integer;
  BaseObject: TBaseObject;
begin
  m_btDirection := btDir;
  WAbil := @m_WAbil;
  n10 := Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC);
  if n10 > 0 then
  begin
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    BaseObject := GetPoseCreate();
    if (BaseObject <> nil) and
      IsProperTarget(BaseObject) and
      (m_nAntiMagic >= 0) then
    begin
      n10 := BaseObject.GetMagStruckDamage(Self, n10);
      if n10 > 0 then
      begin
        BaseObject.StruckDamage(n10);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n10, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 300);
      end;
    end;
  end;

end;

function TMagCowMonster.AttackTarget: Boolean; //004AA084
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then
    exit;
  if GetAttackDir(m_TargetCret, btDir) then
  begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
    begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      sub_4A9F6C(btDir);
      BreakHolySeizeMode();
    end;
    Result := True;
  end
  else
  begin
    if m_TargetCret.m_PEnvir = m_PEnvir then
    begin
      SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    end
    else
    begin
      DelTargetCreat();
    end;
  end;
end;

{ TCowKingMonster }



constructor TCowKingMonster.Create; //004AA160
begin
  inherited;
  m_dwSearchTime := Random(1500) + 500;
  dw558 := GetTickCount();
  bo2BF := True;
  n560 := 0;
  bo55C := False;
  bo55D := False;
  m_boBOSS := true;
end;

destructor TCowKingMonster.Destroy;
begin

  inherited;
end;

procedure TCowKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer); //004AA1F0
var
  WAbil: pTAbility;
  nPower: integer;
begin
  WAbil := @m_WAbil;
  nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject, nPower div 2, nPower div 2, True);
//  inherited;

end;

procedure TCowKingMonster.Initialize;
begin
  dw56C := m_nNextHitTime;
  dw570 := m_nWalkSpeed;
  inherited;

end;

procedure TCowKingMonster.Run; //004AA294
var
  I: Integer;
  n8, nC, n10: Integer;
  BaseObject: TBaseObject;

begin
  if (not m_boDeath) and
    (not bo554) and
    (not m_boGhost) and
    ((GetTickCount - dw558) > 30 * 1000) then
  begin

    dw558 := GetTickCount();
    if (m_TargetCret <> nil) and (sub_4C3538 >= 5) then
    begin //
      m_TargetCret.GetBackPosition(n8, nC);
      if m_PEnvir.CanWalk(n8, nC, False) then
      begin
        SpaceMove(m_PEnvir.sMapName, n8, nC, 0);
        exit;
      end;
      MapRandomMove(m_PEnvir.sMapName, 0);
      exit;
    end;
    n10 := n560;

    n560 := 7 - m_WAbil.HP div (m_WAbil.MaxHP div 7);
    if (n560 >= 2) and (n560 <> n10) then
    begin
      bo55C := True;
      dw564 := GetTickCount();
    end;
    if bo55C then
    begin
      if (GetTickCount - dw564) < 8000 then
      begin
        m_nNextHitTime := 10000;
      end
      else
      begin
        bo55C := False;
        bo55D := True;
        dw568 := GetTickCount();
      end;
    end; //004AA43D
    if bo55D then
    begin
      if (GetTickCount - dw568) < 8000 then
      begin
        m_nNextHitTime := 500;
        m_nWalkSpeed := 400;
      end
      else
      begin
        bo55D := False;
        m_nNextHitTime := dw56C;
        m_nWalkSpeed := dw570;
      end;
    end;
  end;
  inherited;
end;
///  铁血魔王

constructor Ttiexueking.Create; //004AA160
begin

  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 8;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;
  m_btDirection := 5;
  m_nDangerLevel := 5;
  m_SlaveObjectList := TList.Create;
  dw558 := GetTickCount();
  m_boBOSS := true;
end;


destructor Ttiexueking.Destroy;
begin
  m_SlaveObjectList.Free;
  inherited;
end;

procedure Ttiexueking.MeltStone; //004AB208
var
  Event: TEvent;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
//  SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  m_boStoneMode := False;
//  Event:=TEvent.Create(m_PEnvir,m_nCurrX,m_nCurrY,6,5 * 60 * 1000,True);
//  Event.m_nEventParam  :=2;     //hint
//  g_EventManager.AddEvent(Event);
end;

procedure Ttiexueking.CallSlave; //004AB29C
var
  I: Integer;
  nC: Integer;
  n10, n14: Integer;
  //sMonName:array[0..3] of String;
  BaseObject: TBaseObject;
begin
  nC := Random(2) + 2;
  GetFrontPosition(n10, n14);
  {
  sMonName[0]:=sZuma1;
  sMonName[1]:=sZuma2;
  sMonName[2]:=sZuma3;
  sMonName[3]:=sZuma4;
  }
  for I := 1 to nC do
  begin
    if m_SlaveObjectList.Count >= 4 then
      break;
    BaseObject := UserEngine.RegenMonsterByName(m_sMapName, n10, n14, '炎魔'); // g_Config.sZuma[Random(4)]
    if BaseObject <> nil then
    begin
      //BaseObject.m_Master:=Self;
      //BaseObject.m_dwMasterRoyaltyTick:=GetTickCount + 24 * 60 * 60 * 1000;
      m_SlaveObjectList.Add(BaseObject);
    end;
  end; // for
end;

procedure Ttiexueking.Attack(TargeTBaseObject: TBaseObject; nDir: Integer); //004AA1F0
var
  WAbil: pTAbility;
  nPower: integer;
  dechp, n, nHTime: integer;
  FireBurnEvent: TFireBurnEvent;

  Range,
    nStartX,
    nEndX,
    nStartY,
    nEndY, nx, ny: integer;


begin
  WAbil := @m_WAbil;
  nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  dechp := wabil.MaxHP - wabil.hp;
  n := dechp div 1000;

  case n of
    0..1: tiexueHitAttackTarget(TargeTBaseObject, nPower div 2, nPower div 2, True, 0);
    2..4: tiexueHitwideTarget(TargeTBaseObject, nPower div 2, nPower div 2, True, 2);
    5..6: tiexueHitALLTarget(TargeTBaseObject, nPower div 2, nPower div 2, True, 4)
  else
    begin
      tiexueHitALLTarget(TargeTBaseObject, nPower div 2, nPower div 2, True, 4);
    end
  end; //case
  if random(8) < 4 then
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
        nHTime := random(5) + 5;
        if m_PEnvir.GetEvent(nx, ny) = nil then
        begin
          FireBurnEvent := TFireBurnEvent.Create(self, nx, ny, 21, nHTime * 1000, nPower div 2);
          g_EventManager.AddEvent(FireBurnEvent);
        end; //0492CFC   x
      end; //for
    end; //for
  end; // random(10)<2
 // end;   //else


end;

procedure Ttiexueking.run; //004AA1F0
var
  I: Integer;
  n8, nC, n10: Integer;
  BaseObject: TBaseObject;
  WAbil: pTAbility;
begin
  if (not m_boGhost) and
    (not m_boDeath) and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) and
    (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then
  begin
    n10 := 0;
    ////
    if ((GetTickCount - dw558) > 10 * 1000) then
    begin
      WAbil := @m_WAbil;
      dw558 := GetTickCount();
  {    if (m_TargetCret <> nil) and (WAbil.HP<2000)  then begin    //  and (sub_4C3538 >= 5)
         m_TargetCret.GetBackPosition(n8,nC);
         if m_PEnvir.CanWalk(n8,nC,False) then begin
           SpaceMove(m_PEnvir.sMapName,n8,nC,0);
           exit;
         end;
         n8:= n8+random(5)+2 ;
         nC:= nC+random(5)+2 ;
         if m_PEnvir.CanWalk(n8,nc,False) then begin
           SpaceMove(m_PEnvir.sMapName,n8,nC,0);
           exit;
         end;
      //  MapRandomMove(m_PEnvir.sMapName,0);
      //  exit;
       end;  }
    end;

   ////
    if m_boStoneMode then
    begin
      //MeltStone();//测试用
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
              MeltStone();
              break;
            end;
          end;
        end;
      end; // for
    end
    else
    begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then
      begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
        //CallSlave(); //测试用
        if (m_nDangerLevel > m_WAbil.HP / m_WAbil.MaxHP * 5) and (m_nDangerLevel > 0) then
        begin
          Dec(m_nDangerLevel);
          WAbil := @m_WAbil;
          if (WAbil.HP < 3000) then
            CallSlave();
        end;
        if m_WAbil.HP = m_WAbil.MaxHP then
          m_nDangerLevel := 5;
      end;
    end;
    for I := m_SlaveObjectList.Count - 1 downto 0 do
    begin
      BaseObject := TBaseObject(m_SlaveObjectList.Items[I]);
      if BaseObject.m_boDeath or BaseObject.m_boGhost then
        m_SlaveObjectList.Delete(I);
    end; // for




  end;
  inherited;

end;

///
{ TLightingZombi }

constructor TLightingZombi.Create; //004AA4B4
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TLightingZombi.Destroy;
begin

  inherited;
end;

procedure TLightingZombi.LightingAttack(nDir: Integer);
var
  nSX, nSY, nTX, nTY, nPwr: Integer;
  WAbil: pTAbility;
begin
  m_btDirection := nDir;
  SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
  if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, 1, nSX, nSY) then
  begin
    m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, 9, nTX, nTY);
    WAbil := @m_WAbil;
    nPwr := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    MagPassThroughMagic(nSX, nSY, nTX, nTY, nDir, nPwr, True);
  end;
  BreakHolySeizeMode();
end;

procedure TLightingZombi.Run; //004AA604
var
  n08, nAttackDir: Integer;
begin
  n08 := 9999;
  if (not m_boDeath) and
    (not bo554) and
    (not m_boGhost) and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) and
    ((GetTickCount - m_dwSearchEnemyTick) > 8000) then
  begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then
    begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;
    if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and
      (m_TargetCret <> nil) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and
      (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 4) then
    begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and
        (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) and
        (Random(3) <> 0) then
      begin
        inherited;
        exit;
      end;
      GetBackPosition(m_nTargetX, m_nTargetY);
    end;
    if (m_TargetCret <> nil) and
      (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 6) and
      (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 6) and
      (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then
    begin

      m_dwHitTick := GetTickCount();
      nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      LightingAttack(nAttackDir);
    end;
  end;
  inherited;
end;

{ TDigOutZombi }

constructor TDigOutZombi.Create; //004AA848
begin
  inherited;
  bo554 := False;
  m_nViewRange := 7;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 95;
  m_boFixedHideMode := True;
end;

destructor TDigOutZombi.Destroy;
begin

  inherited;
end;

procedure TDigOutZombi.sub_4AA8DC;
var
  Event: TEvent;
begin
  Event := TEvent.Create(m_PEnvir, m_nCurrX, m_nCurrY, 1, 5 * 60 * 1000, True);
  g_EventManager.AddEvent(Event);
  m_boFixedHideMode := False;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, Integer(Event), '');
end;

procedure TDigOutZombi.Run; //004AA95C
var
  I: Integer;
  n10: Integer;
  BaseObject: TBaseObject;
begin
  if (not m_boGhost) and
    (not m_boDeath) and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) and
    (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then
  begin
    n10 := 0;
    if m_boFixedHideMode then
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
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 3) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 3) then
            begin
              sub_4AA8DC();
              m_dwWalkTick := GetTickCount + 1000;
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


{ TZilKinZombi }

constructor TZilKinZombi.Create;
begin
  inherited;
  m_nViewRange := 6;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 96;
  nZilKillCount := 0;
  if Random(3) = 0 then
  begin
    nZilKillCount := Random(3) + 1;
  end;
end;

destructor TZilKinZombi.Destroy;
begin
  inherited;


end;

procedure TZilKinZombi.Die;
begin
  inherited;
  if nZilKillCount > 0 then
  begin
    dw558 := GetTickCount();
    dw560 := (Random(20) + 4) * 1000;
  end;
  Dec(nZilKillCount);
end;

procedure TZilKinZombi.Run; //004AABE4
begin
  if m_boDeath and
    (not m_boGhost) and
    (nZilKillCount >= 0) and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) and
    (m_VisibleActors.Count > 0) and
    ((GetTickCount - dw558) >= dw560) then
  begin
    m_Abil.MaxHP := m_Abil.MaxHP shr 1;
    m_dwFightExp := m_dwFightExp div 2;
    m_Abil.HP := m_Abil.MaxHP;
    m_WAbil.HP := m_Abil.MaxHP;
    ReAlive();
    m_dwWalkTick := GetTickCount + 1000
  end;
  inherited;
end;

{ TWhiteSkeleton }

constructor TWhiteSkeleton.Create; //00004AACCC
begin
  inherited;
  m_boIsFirst := True;
  m_boFixedHideMode := True;
  m_btRaceServer := 100;
  m_nViewRange := 6;
end;

destructor TWhiteSkeleton.Destroy;
begin

  inherited;
end;

procedure TWhiteSkeleton.RecalcAbilitys; //004AAD38
begin
  inherited;
  sub_4AAD54();
end;

procedure TWhiteSkeleton.Run;
begin
  if m_boIsFirst then
  begin
    m_boIsFirst := False;
    m_btDirection := 5;
    m_boFixedHideMode := False;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  end;
  inherited;
end;

procedure TWhiteSkeleton.sub_4AAD54; //004AAD54
begin
  m_nNextHitTime := 3000 - m_btSlaveMakeLevel * 600;
  m_nWalkSpeed := 1200 - m_btSlaveMakeLevel * 250;
  m_dwWalkTick := GetTickCount + 2000;
end;

constructor TNIMOKEMonster.Create; //004AAE20
begin

  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 7;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;

end;

destructor TNIMOKEMonster.Destroy;
begin

  inherited;
end;

procedure TNIMOKEMonster.MeltStone;
var //ElfMon:TBaseObject;
  FireBurnEvent: TFireBurnEvent;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
 //    SendRefMsg(rm_10206,m_btDirection,m_nCurrX,m_nCurrY,0,''); //破壳

  m_wAppr := pm_wAppr;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boStoneMode := False;


  FireBurnEvent := TFireBurnEvent.Create(self, m_nCurrX, m_nCurrY, 6, 5 * 60 * 1000, 0);
  FireBurnEvent.m_nEventParam := 1;
  g_EventManager.AddEvent(FireBurnEvent);
//  m_boStoneMode:=False;
//  if pos('1',m_sCharName)<=0 then begin

   // m_boDeath:=true;

//  m_boNoItem:=TRUE;
 // m_sCharName:='';
//  Die ;
 // m_WAbil.HP:=0;
//  end;

{  ElfMon:=MakeClone(m_sCharName + '1',Self);       //
   if ElfMon<>nil then begin
    ElfMon.SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');

    ElfMon.m_boStoneMode:=False;
   end; }
 // m_Abil.HP:=0;

  //KickException;
end;

procedure TNIMOKEMonster.MeltStoneAll;
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
      if BaseObject is TNIMOKEMonster then
      begin
        TNIMOKEMonster(BaseObject).MeltStone
      end;
    end;
  end; // for
  List10.Free;
end;

procedure TNIMOKEMonster.Run; //004AAF98
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



{ TScultureMonster }



constructor TScultureMonster.Create; //004AAE20
begin

  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 7;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;

end;

destructor TScultureMonster.Destroy;
begin

  inherited;
end;

procedure TScultureMonster.MeltStone;
//var  ElfMon:TBaseObject;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
  if m_boStoneMode then
  begin
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');

    m_boStoneMode := False;
  end;
 {    SendRefMsg(rm_10206,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  // m_boDeath:=true;
     m_boNoItem:=TRUE;
     m_WAbil.HP:=0;
  ElfMon:=MakeClone(m_sCharName + '1',Self);       //
  if ElfMon<>nil then begin
  ElfMon.SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');

  ElfMon.m_boStoneMode:=False;
  end;  }
 // m_Abil.HP:=0;

  //KickException;
end;

procedure TScultureMonster.MeltStoneAll;
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
      if BaseObject is TScultureMonster then
      begin
        TScultureMonster(BaseObject).MeltStone
      end;
    end;
  end; // for
  List10.Free;
end;

procedure TScultureMonster.Run; //004AAF98
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

{ TScultureKingMonster }

constructor TScultureKingMonster.Create; //004AB120
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 8;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;
  m_btDirection := 5;
  m_nDangerLevel := 5;
  m_SlaveObjectList := TList.Create;
  pm_wAppr := -1;
  m_boBOSS := true;
end;

destructor TScultureKingMonster.Destroy; //004AB1C8
begin
  m_SlaveObjectList.Free;
  inherited;
end;

procedure TScultureKingMonster.MeltStone; //004AB208
var
  Event: TEvent;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
  if pm_wAppr > 0 then
    m_wAppr := pm_wAppr;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boStoneMode := False;
  Event := TEvent.Create(m_PEnvir, m_nCurrX, m_nCurrY, 6, 5 * 60 * 1000, True);
  Event.m_nEventParam := 2; //hint
  g_EventManager.AddEvent(Event);
end;

procedure TScultureKingMonster.CallSlave; //004AB29C
var
  I: Integer;
  nC: Integer;
  n10, n14: Integer;
  //sMonName:array[0..3] of String;
  BaseObject: TBaseObject;
begin
  nC := Random(6) + 6;
  GetFrontPosition(n10, n14);
  {
  sMonName[0]:=sZuma1;
  sMonName[1]:=sZuma2;
  sMonName[2]:=sZuma3;
  sMonName[3]:=sZuma4;
  }
  for I := 1 to nC do
  begin
    if m_SlaveObjectList.Count >= 30 then
      break;
    BaseObject := UserEngine.RegenMonsterByName(m_sMapName, n10, n14, g_Config.sZuma[Random(4)]);
    if BaseObject <> nil then
    begin
      //BaseObject.m_Master:=Self;
      //BaseObject.m_dwMasterRoyaltyTick:=GetTickCount + 24 * 60 * 60 * 1000;
      m_SlaveObjectList.Add(BaseObject);
    end;
  end; // for
end;

procedure TScultureKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer); //004AB3E8
var
  WAbil: pTAbility;
  nPower: Integer;
begin
  WAbil := @m_WAbil;
  nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject, 0, nPower, True);
end;

procedure TScultureKingMonster.Run; //004AB444
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
      //MeltStone();//测试用
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
              MeltStone();
              break;
            end;
          end;
        end;
      end; // for
    end
    else
    begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then
      begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
        //CallSlave(); //测试用
        if (m_nDangerLevel > m_WAbil.HP / m_WAbil.MaxHP * 5) and (m_nDangerLevel > 0) then
        begin
          Dec(m_nDangerLevel);
          CallSlave();
        end;
        if m_WAbil.HP = m_WAbil.MaxHP then
          m_nDangerLevel := 5;
      end;
    end;
    for I := m_SlaveObjectList.Count - 1 downto 0 do
    begin
      BaseObject := TBaseObject(m_SlaveObjectList.Items[I]);
      if BaseObject.m_boDeath or BaseObject.m_boGhost then
        m_SlaveObjectList.Delete(I);
    end; // for
  end;
  inherited;
end;
{ TGasMothMonster }

constructor TGasMothMonster.Create; //004AB6B8
begin
  inherited;
  m_nViewRange := 7;
end;

destructor TGasMothMonster.Destroy;
begin

  inherited;
end;

function TGasMothMonster.sub_4A9C78(bt05: Byte): TBaseObject; //004AB708
var
  BaseObject: TBaseObject;
begin
  BaseObject := inherited sub_4A9C78(bt05);
  if (BaseObject <> nil) and (Random(3) = 0) and (BaseObject.m_boHideMode) then
  begin
    BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {8 0x70}] := 1;
  end;
  Result := BaseObject;
end;

procedure TGasMothMonster.Run; //004AB758
var
  n08, nC: INteger;
begin
  n08 := 9999;
  nC := 0;
  if (not m_boDeath) and
    (not bo554) and
    (not m_boGhost) and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) and
    (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then
  begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
      (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then
    begin
      m_dwSearchEnemyTick := GetTickCount();
      sub_4C959C();
    end;
  end;
  inherited;
end;
{ TGasDungMonster }

constructor TGasDungMonster.Create; //004AB7F4
begin
  inherited;
  m_nViewRange := 7;
end;

destructor TGasDungMonster.Destroy;
begin

  inherited;
end;





{ TElfMonster }

procedure TElfMonster.AppearNow; //004AB908 神兽
begin
  boIsFirst := FALSE;
  m_boFixedHideMode := FALSE;
   //SendRefMsg (RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
//   Appear;
//   ResetElfMon;
  RecalcAbilitys;
  m_dwWalkTick := m_dwWalkTick + 800; //
end;

constructor TElfMonster.Create;
//004AB844
begin
  inherited;
  m_nViewRange := 6;
  m_boFixedHideMode := True;
  m_boNoAttackMode := True;
  boIsFirst := True;
end;

destructor TElfMonster.Destroy;
begin

  inherited;
end;

procedure TElfMonster.RecalcAbilitys; //004AB8B0
begin
  inherited;
  ResetElfMon();
end;

procedure TElfMonster.ResetElfMon(); //004AB8CC
begin
  m_nWalkSpeed := 500 - m_btSlaveMakeLevel * 50;
  m_dwWalkTick := GetTickCount + 2000;
end;

procedure TElfMonster.Run; //4AB944
var
  boChangeFace: Boolean;
  ElfMon: TBaseObject;
begin
  if boIsFirst then
  begin
    boIsFirst := False;
    m_boFixedHideMode := False;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    ResetElfMon();
  end;
  if m_boDeath then
  begin
    if (GetTickCount - m_dwDeathTick > 2 * 1000) then
    begin
      MakeGhost();
    end;
  end
  else
  begin
    boChangeFace := False;
    if m_TargetCret <> nil then
      boChangeFace := True;
    if (m_Master <> nil) and ((m_Master.m_TargetCret <> nil) or (m_Master.m_LastHiter <> nil)) then
      boChangeFace := True;
    if boChangeFace then
    begin
      //ElfMon:=MakeClone(sDogz1,Self);
      ElfMon := MakeClone('麒麟', Self); // m_sCharName + '1'
      if ElfMon <> nil then
      begin
        ElfMon.m_boAutoChangeColor := m_boAutoChangeColor;
        if ElfMon is TElfWarriorMonster then
          TElfWarriorMonster(ElfMon).AppearNow;
        m_Master := nil;
        KickException();
      end;
    end;
  end;
  inherited;
end;
{ TElfWarriorMonster }

procedure TElfWarriorMonster.AppearNow; //004ABB60
begin
  boIsFirst := FALSE;
  m_boFixedHideMode := FALSE;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  RecalcAbilitys;
  m_dwWalkTick := m_dwWalkTick + 800; //函脚饶 距埃 掉饭捞 乐澜
  dwDigDownTick := GetTickCount();
end;

constructor TElfWarriorMonster.Create;
begin
  inherited;
  m_nViewRange := 6;
  m_boFixedHideMode := True;
  boIsFirst := True;
  m_boUsePoison := False;
end;

destructor TElfWarriorMonster.Destroy;
begin

  inherited;
end;
//004ABB08

procedure TElfWarriorMonster.RecalcAbilitys; //004ABAEC
begin
  inherited;
  ResetElfMon();
end;

procedure TElfWarriorMonster.ResetElfMon();
begin
  m_nNextHitTime := 1500 - m_btSlaveMakeLevel * 100;
  m_nWalkSpeed := 500 - m_btSlaveMakeLevel * 50;
  m_dwWalkTick := GetTickCount + 2000;
end;

procedure TElfWarriorMonster.Run; //004ABBD0
var
  boChangeFace: Boolean;
  ElfMon: TBaseObject;
  ElfName: string;
begin
  ElfMon := nil;
  if boIsFirst then
  begin
    boIsFirst := False;
    m_boFixedHideMode := False;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    ResetElfMon();
  end; //004ABC27
  if m_boDeath then
  begin
    if (GetTickCount - m_dwDeathTick > 2 * 1000) then
    begin
      MakeGhost();
    end;
  end
  else
  begin
    boChangeFace := True;
    if m_TargetCret <> nil then
      boChangeFace := False;
    if (m_Master <> nil) and ((m_Master.m_TargetCret <> nil) or (m_Master.m_LastHiter <> nil)) then
      boChangeFace := False;
    if boChangeFace then
    begin
      if (GetTickCount - dwDigDownTick) > 6 * 10 * 1000 then
      begin
      //if (GetTickCount - dwDigDownTick) > 10 * 1000 then begin
        //ElfMon:=MakeClone(sDogz,Self);

        ElfName := m_sCharName;
        if ElfName = '麒麟' then
        begin //ElfName[length(ElfName)] = '1'
          ElfName := '火灵珠'; //Copy(ElfName,1,length(ElfName) -1);
          ElfMon := MakeClone(ElfName, Self);
        end;
        if ElfMon <> nil then
        begin
          SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
          SendRefMsg(RM_CHANGEFACE, 0, Integer(Self), Integer(ElfMon), 0, '');
          ElfMon.m_boAutoChangeColor := m_boAutoChangeColor;
          if ElfMon is TElfMonster then
            TElfMonster(ElfMon).AppearNow;
          m_Master := nil;
          KickException();
        end;
      end;
    end
    else
    begin
      dwDigDownTick := GetTickCount();
    end;
  end;
  inherited;
end;


{ TElectronicScolpionMon }

constructor TElectronicScolpionMon.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boUseMagic := False;
end;

destructor TElectronicScolpionMon.Destroy;
begin

  inherited;
end;

procedure TElectronicScolpionMon.LightingAttack(nDir: Integer);
var
  WAbil: pTAbility;
  nPower, nDamage: integer;
  btGetBackHP: Integer;
begin
  m_btDirection := nDir;
  WAbil := @m_WAbil;

  nPower := GetAttackPower(LoWord(WAbil.MC), SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)));
  nDamage := m_TargetCret.GetMagStruckDamage(Self, nPower);
  if nDamage > 0 then
  begin
    btGetBackHP := LoByte(m_WAbil.MP);
    if btGetBackHP <> 0 then
      Inc(m_WAbil.HP, nDamage div btGetBackHP);

    m_TargetCret.StruckDamage(nDamage);
    m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 200);
  end;
  SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
end;

procedure TElectronicScolpionMon.Run;
var
  nAttackDir: Integer;
  nX, nY: Integer;
begin
  if (not m_boDeath) and
    (not bo554) and
    (not m_boGhost) and
    (m_wStatusTimeArr[POISON_STONE {5 0x6A}] = 0) then
  begin

     //血量低于一半时开始用魔法攻击
    if m_WAbil.HP < m_WAbil.MaxHP div 2 then
      m_boUseMagic := True
    else
      m_boUseMagic := False;

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then
    begin
      m_dwSearchEnemyTick := GetTickCount();
      SearchTarget();
    end;
    if m_TargetCret = nil then
      exit;

    nX := abs(m_nCurrX - m_TargetCret.m_nCurrX);
    nY := abs(m_nCurrY - m_TargetCret.m_nCurrY);

    if (nX <= 2) and (nY <= 2) then
    begin
      if m_boUseMagic or ((nX = 2) or (nY = 2)) then
      begin
        if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then
        begin
          m_dwHitTick := GetTickCount();
          nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          LightingAttack(nAttackDir);
        end;
      end;
    end;
  end;
  inherited Run;
end;



{ TfireMonster }

constructor TfireMonster.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TfireMonster.Destroy;
begin

  inherited;
end;

procedure TfireMonster.Run;
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

{ TMonster12 }

constructor TMonster12.Create;
begin
  inherited;
  nIndex:=0;
  m_Targetx1[0]:=19;
  m_Targety1[0]:=28;

  m_Targetx1[1]:=30;
  m_Targety1[1]:=18;

  m_Targetx1[2]:=40;
  m_Targety1[2]:=28;

  m_Targetx1[3]:=35;
  m_Targety1[3]:=35;

  m_nTargetX:=31;
  m_nTargetY:=40;
end;

destructor TMonster12.Destroy;
begin

  inherited;
end;

procedure TMonster12.Run;
var
  boSuccess:Boolean;
  dwRunTick: LongWord;
  ProcessMsg: TProcessMessage;
begin
 try
    dwRunTick := GetTickCount();
    while (GetTickCount - dwRunTick < 200) and GetMessage(@ProcessMsg) do
    begin
      Operate(@ProcessMsg);
    end;


  except

  end;
  if not m_boDeath then
  Begin
  if m_WAbil.HP = 0 then
  Begin
          Die;
         
  End;
  End
  else
    begin
      if (GetTickCount() - m_dwDeathTick > g_Config.dwMakeGhostTime {3 * 60 * 1000}) then
        MakeGhost();
    end;
  if m_WAbil.HP=0 then
      exit;
 if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then
 begin
   if nIndex<13 then
     boSuccess:= WalkTo(DR_UPRIGHT,false)
   else
     if nIndex<26 then
       boSuccess:=WalkTo(DR_UPLeft,false)
   else
     if nIndex<39 then
       boSuccess:=WalkTo(DR_UPRight,false)
   else
     if nIndex<51 then
       boSuccess:=WalkTo(DR_DOWNRIGHT,false)
     else
      if nIndex<59 then
       boSuccess:=WalkTo(DR_DownLeft,false)
      else
      begin
        if g_RobotNPC<>nil then g_RobotNPC.GotoLable(TPlayObject(RobotManage.RobotHuManPlayer),'@离火封魔阵',False);
         
         SendRefMsg(RM_3046,0,Loword(Integer(Self)),HiWord(Integer(Self)),7,'');
         MakeGhost;
      end;
      if boSuccess then
      Begin
        Inc(nIndex);
        m_dwWalkTick:=GetTickCount;
      end;
       m_dwWalkTick:=GetTickCount;
    //  inherited;
      m_nTargetX:=-1;
      m_nTargetY:=-1;
      m_TargetCret:=nil;
  //   GotoTargetXY();
   //  
 end;

end;

end.
