unit Objys;

interface
uses
  Windows, Classes, Grobal2, ObjBase, sysutils, HUtil32,EDcode,magic;
type
  TMonsteys = class(TPlayObject)
    n54C: Integer; //0x54C
    m_dwThinkTick: LongWord; //0x550
    m_dwuseskilltick: LongWord;
    m_nNextSkillTime: Integer;
    bo554: Boolean; //0x554
    m_boDupMode: Boolean; //0x555
    m_btUsePoison: integer;
    toonear: boolean;
    ADDHPMODE: BOOLEAN;
    m_btRealm:Byte;
    m_btwing:Byte;
     m_SkillUseTick: array[0..60 - 1] of LongWord; //魔法使用间隔
  private
    function Think: Boolean;
  public

    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    function magAttackTarget(): Boolean; virtual; //FFEB
    function AttackTarget(): Boolean; virtual; //FFEB
    procedure Run; override;
    procedure RecalcAbilitys(); override; //FFF7
    procedure Initialize; override;
     procedure SearchViewRange(); override;
    function SelectMagic:Integer;
    function IsAllowUseMagic(wMagIdx: Word): Boolean;
    function GetSpellPoint(UserMagic: pTUserMagic): Integer;
    function CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
    function CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;
    function GetUserItemList(nItemType: Integer): Integer;
    function UseItem(nItemType, nIndex: Integer): Boolean;
    function CheckUserItemType(nItemType: Integer): Boolean;
    function CheckItemType(nItemType: Integer; StdItem: pTStdItem): Boolean;
     
  end;
  TEvilMonster=class(TMonsteys)
    private
    public
       constructor Create(); override;
       destructor Destroy; override;
       procedure Die; override;
       procedure Clone(BaseObject:TPlayObject);
  end;


implementation
uses UsrEngn, M2Share;
{ TMonsteys }

function TMonsteys.magAttackTarget: Boolean;
var
  bt06: Byte;

  UserMagic: pTUserMagic;

begin
  Result := False;
  toonear := false;
  if m_TargetCret <> nil then
  begin
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurry - m_TargetCret.m_nCurry) <= 5) then
    begin // GetAttackDir(m_TargetCret,bt06)
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
      begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();


        bt06:=SelectMagic;







        if bt06>=0 then
        begin
          UserMagic := GetMagicInfo(bt06);
          if (UserMagic <> nil)  then

          if DoSpell(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret) then
              Result := True;
          BreakHolySeizeMode();
        end; //距离够了

      end;

    end
    else
    begin
      if m_TargetCret.m_PEnvir = m_PEnvir then
      begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) >= 5) and (abs(m_nCurry - m_TargetCret.m_nCurry) >= 5) then
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

constructor TMonsteys.Create;
begin
  inherited;
  m_boDupMode := False;
  m_boFixedHideMode := false;
  bo554 := False;
  m_dwThinkTick := GetTickCount();
  m_dwuseskilltick := GetTickCount();
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_nWalkSpeed := 700;
  m_nNextHitTime := 1200;
  m_nNextSkillTime := 5200;
  m_btRaceServer := RC_YSBJECT;
  //UserEngine.makenewplay(,self);
  nskill := 0;
end;

destructor TMonsteys.Destroy;
begin

  inherited;
end;

procedure TMonsteys.Initialize;
var
   I  : Integer;
   pEvilMonAppr: pTEvilMonAppr;

   Magic: pTMagic;
   UserMagic: pTUserMagic;
begin
  inherited;
 // m_boAddtoMapSuccess:=True;
  if m_btRaceImg=253 then m_btRaceImg:=254;
  pEvilMonAppr:=GetEvilAppr(m_wAppr);
  if pEvilMonAppr=nil then exit;
  m_btJob:=pEvilMonappr.nJob;
  m_btGender:=pEvilMonappr.nSex;
  m_btRealm:=pEvilMonAppr.nRealm;
  m_btwing:=pEvilMonappr.nWings;
 // m_btHair:=1;
  RecalcLevelAbilitys ;
  m_btHair:=3;
  m_Abil.HP:=m_Abil.MaxHP;
  m_Abil.MP:=m_Abil.MaxMP;
  m_WAbil :=m_Abil;
//   RecalcAbilitys();
  for I := 0 to 12 do
  begin
    if pEvilMonAppr.sUserItem[i]<>'' then
    begin
      UserEngine.CopyToUserItemFromName(pEvilMonAppr.sUserItem[i], @m_UseItems[i]);
     end;
  end;
  for I := 0 to 19 do
  begin
    if pEvilMonAppr.sMagic[i]<>'' then
    begin
       Magic := UserEngine.FindMagic(pEvilMonAppr.sMagic[i]);
       if Magic=nil then Continue;
       New(UserMagic);
       UserMagic.MagicInfo := Magic;
       UserMagic.wMagIdx := Magic.wMagicId;
       UserMagic.btLevel := 3;
       UserMagic.btKey := 0;
       UserMagic.nTranPoint := 0;
       m_MagicList.Add(UserMagic);
    end;
  end;
end;

function TMonsteys.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TMonsteys.RecalcAbilitys;
begin
//
  m_Abil.AC:=MakeLong((Loword(m_Abil.AC) div 2) ,(Hiword(m_Abil.AC) div 2));
  m_Abil.MAC:=MakeLong((Loword(m_Abil.MAC) div 2) ,(Hiword(m_Abil.MAC) div 2));
  m_Abil.DC:=MakeLong((Loword(m_Abil.DC) div 2) ,(Hiword(m_Abil.DC) div 2));
  m_Abil.HP:=m_Abil.HP div 2;
  m_Abil.MaxHP:=m_Abil.MaxHP div 2;


end;

procedure TMonsteys.Run;
var
  nX, nY,   nDir: Integer;

  doskill: boolean;
  UserMagic: pTUserMagic;
begin
  toonear := false;
  doskill:=False;
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
////////////
      if (m_TargetCret <> nil) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurry - m_TargetCret.m_nCurry) <= 2) then
        toonear := true
      else
        toonear := false;

      if m_WAbil.HP * 3 < m_WAbil.MaxHP then
        addhpmode := true;

      if (m_btJob > 0) or addhpmode then
      begin //如果是法师
        if m_TargetCret <> nil then
        begin //先跑命
      // if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurry- m_TargetCret.m_nCurry) <= 2) then begin

          if toonear then
          begin
           // m_btDirection:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrx,m_TargetCret.m_nCurry);

            nDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            nDir := GetBackDir(nDir);
            m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, nDir, 5, m_nTargetX, m_nTargetY);

           //  GetBackPosition(m_nTargetX,m_nTargetY);
          //  m_Master.SysMsg(Format('%d/(%d/%d)', [m_btDirection,m_nTargetX,m_nTargetY]),c_Red,t_Hint);



          end;
        end;
      end; //job>0

      if Integer(GetTickCount - m_dwuseskilltick) > m_nNextSkillTime then
      begin
        m_dwuseskilltick := GetTickCount();
        if not toonear then
        begin //够远了  或者没有怪物危险
          doskill := false;

          UserMagic := GetMagicInfo(2); // //如果治疗术
          if (not doskill) and (UserMagic <> nil) then
          begin
            if (m_WAbil.HP * 2 < m_WAbil.MaxHP) or addhpmode then
           //  if  MagicManager.DoSpell(Self,UserMagic,m_nCurrX,m_nCurrY,self) then
              if DoSpell(UserMagic, m_nCurrX, m_nCurrY, self) then
                doskill := true;
            if m_WAbil.HP = m_WAbil.MaxHP then
              addhpmode := false;

            if not doskill then
            begin
              if (m_Master <> nil) and (m_Master.m_WAbil.HP * 2 < m_Master.m_WAbil.MaxHP) then
                 // if  MagicManager.DoSpell(Self,UserMagic,m_Master.m_nCurrX,m_Master.m_nCurrY,m_Master) then
                if DoSpell(UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master) then
                  doskill := true;
            end;
          end;


          UserMagic := GetMagicInfo(31); //如果有魔法盾且魔法盾没有开
          if (not doskill) and (UserMagic <> nil) and (not m_boAbilMagBubbleDefence) then
          begin // m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP]=0
        //  if  MagicManager.DoSpell(Self,UserMagic,m_nCurrX,m_nCurrY,self) then
            if DoSpell(UserMagic, m_nCurrX, m_nCurrY, self) then
              doskill := true;
          end;

          UserMagic := GetMagicInfo(61); // //如果有金刚且金刚没有开
          if (not doskill) and (UserMagic <> nil) and (not m_boAbilMagPowerDefence) then
          begin //(m_wStatusArrValue[6]=0)
         // if  MagicManager.DoSpell(Self,UserMagic,m_nCurrX,m_nCurrY,self) then
            if DoSpell(UserMagic, m_nCurrX, m_nCurrY, self) then
              doskill := true;
          end;

          UserMagic := GetMagicInfo(42); // //如果有护身真气且护身真气没有开
          if (not m_boAbilMagPowerDefence) and (not doskill) and (UserMagic <> nil) and (not m_boAbilMagzqDefence) then
          begin // (m_wStatusTimeArr[STATE_14]=0)
       //  if  MagicManager.DoSpell(Self,UserMagic,m_nCurrX,m_nCurrY,self) then
            if DoSpell(UserMagic, m_nCurrX, m_nCurrY, self) then
              doskill := true;
          end;


          UserMagic := GetMagicInfo(70); // //如果有风影且风影没有开
          if (not doskill) and (UserMagic <> nil) and (not m_boAbilMagfyDefence) then
          begin // m_wStatusArrValue[7]=0
         // if  MagicManager.DoSpell(Self,UserMagic,m_nCurrX,m_nCurrY,self) then
            if DoSpell(UserMagic, m_nCurrX, m_nCurrY, self) then
              doskill := true;
          end;

        end; // if not toonear then begin
      end; //    if Integer(GetTickCount - m_dwuseskilltick) > m_nNextSkillTime

//////////////
      if (not m_boRunAwayMode) and (not doskill) and (not addhpmode) then
      begin //  and (not toonear)如果没有使用魔法，就去攻击怪物
        if not m_boNoAttackMode then
        begin
          if m_TargetCret <> nil then
          begin
            if m_btJob > 0 then
            begin
              if magAttackTarget {FFEB} then
              begin
                inherited;
                exit;
              end
              else
              if AttackTarget {FFEB} then
              begin
                inherited;
                exit;
              end;
            end
            else
            begin
              if AttackTarget {FFEB} then
              begin
                inherited;
                exit;
              end;
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
          if (not m_Master.m_boSlaveRelax) and
            ((m_PEnvir <> m_Master.m_PEnvir) or
            (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
            (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) and (not m_bohorserelax) then
          begin
            //

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
      if ((m_Master <> nil) and m_Master.m_boSlaveRelax) or m_bohorserelax then
      begin
        inherited;
        exit;
      end; //004A93A6


      if m_nTargetX <> -1 then
      begin
        if (abs(m_nTargetX - m_nCurrX) > 2) or (abs(m_nTargety - m_nCurry) > 2) or toonear then
        begin
          nDir := GetNextDirection(m_nCurrX, m_nCurrY, m_nTargetX, m_nTargety);
          if not RunTo(nDir, False, m_nTargetX, m_nTargety) then
            GotoTargetXY(); //004A93B5 0FFEF
        end
        else
          GotoTargetXY();
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

function TMonsteys.GetSpellPoint(UserMagic: pTUserMagic): Integer;
begin
  Result := Round(UserMagic.MagicInfo.wSpell / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + UserMagic.MagicInfo.btDefSpell;
end;
function TMonsteys.GetUserItemList(nItemType: Integer): Integer;
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := -1;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem := m_ItemList.Items[I];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      if CheckItemType(nItemType, StdItem) then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TMonsteys.IsAllowUseMagic(wMagIdx: Word): Boolean;
var
  UserMagic: pTUserMagic;
begin
  Result := False;
  UserMagic := GetMagicInfo(wMagIdx);
  if UserMagic <> nil then begin
    if GetSpellPoint(UserMagic) < m_WAbil.MP then Result := True;
  end;
end;
function TMonsteys.CheckItemType(nItemType: Integer;
  StdItem: pTStdItem): Boolean;
begin
  Result := False;
  case nItemType of
    1: begin
        if (StdItem.StdMode = 25) and (StdItem.Shape = 5) then Result := True;
      end;
    2: begin
        if (StdItem.StdMode = 25) and (StdItem.Shape <= 2) then Result := True;
      end;
  end;
end;

function TMonsteys.CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
var
  BaseObject: TBaseObject;
  I, nC, n10: Integer;
begin
  Result := 0;
  n10 := nRange;
  for I := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if BaseObject <> nil then begin
      if not BaseObject.m_boDeath then begin
        if IsProperTarget(BaseObject) and
          (not BaseObject.m_boHideMode or m_boCoolEye) then begin
          nC := abs(nX - BaseObject.m_nCurrX) + abs(nY - BaseObject.m_nCurrY);
          if nC <= n10 then begin
            Inc(Result);
            //if Result > 2 then break;
          end;
        end;
      end;
    end;
  end;
end;
function TMonsteys.CheckTargetXYCountOfDirection(nX, nY, nDir,
  nRange: Integer): Integer;
var
  BaseObject: TBaseObject;
  I,  n10: Integer;
begin
  Result := 0;
  n10 := 2;
  for I := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if BaseObject <> nil then begin
      if not BaseObject.m_boDeath then begin
        if IsProperTarget(BaseObject) and
          (not BaseObject.m_boHideMode or m_boCoolEye) then begin
          case nDir of
            DR_UP: begin
                if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((BaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
              end;
            DR_UPRIGHT: begin
                if ((BaseObject.m_nCurrX - nX) in [0..nRange]) and ((BaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
              end;
            DR_RIGHT: begin
                if ((BaseObject.m_nCurrX - nX) in [0..nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
              end;
            DR_DOWNRIGHT: begin
                if ((BaseObject.m_nCurrX - nX) in [0..nRange]) and ((nY - BaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
              end;
            DR_DOWN: begin
                if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((nY - BaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
              end;
            DR_DOWNLEFT: begin
                if ((nX - BaseObject.m_nCurrX) in [0..nRange]) and ((nY - BaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
              end;
            DR_LEFT: begin
                if ((nX - BaseObject.m_nCurrX) in [0..nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
              end;
            DR_UPLEFT: begin
                if ((nX - BaseObject.m_nCurrX) in [0..nRange]) and ((BaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
              end;
          end;
          //if Result > 2 then break;
        end;
      end;
    end;
  end;
end;

function TMonsteys.CheckUserItemType(nItemType: Integer): Boolean;
var

  StdItem: pTStdItem;
begin
  Result := False;
  if m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex > 0 then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex);
    if StdItem <> nil then begin
      Result := CheckItemType(nItemType, StdItem);
    end;
  end;
end;

procedure TMonsteys.SearchViewRange;
begin
  inherited;

end;

function TMonsteys.SelectMagic:Integer;
var


  nAmuletIdx:Integer;
  nCOunt,i:INteger;
begin
  Result := -1;
  case m_btJob of
    0: begin //战士
        if IsAllowUseMagic(26) and (not m_boFireHitSkill) and ((GetTickCount - m_dwLatestFireHitTick) > 10 * 1000) then
        begin {烈火}
            if (GetTickCount - m_dwLatestFireHitTick) > 10 * 1000 then
              begin
                m_dwLatestFireHitTick := GetTickCount();
                m_boFireHitSkill := True;


              end;
          Result := 26;
          Exit;
        end;
        if CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) >= 4 then
        begin //被怪物包围

            if IsAllowUseMagic(43) then
            begin //英雄抱月刀法
              if not m_boCrsHitkill then
              begin
                m_boCrsHitkill:=True;
              end;
              Result := 43;
              Exit;
            end;
        end
        else
        begin
              if IsAllowUseMagic(12) then
              begin //英雄刺杀剑术
                if not m_boUseThrusting then
                begin
                  m_boUseThrusting :=True;
                end;
                Result := 12;
              end
              else
                if IsAllowUseMagic(25) then
                begin
                  if not m_boUseHalfMoon then
                      m_boUseHalfMoon:=True;
                  Result := 25;
                end
                else
                   if IsAllowUseMagic(40) then
                   begin //英雄抱月刀法
                      if not m_boCrsHitkill then
                      begin
                         m_boCrsHitkill:=True;
                      end;
                      Result := 43;
                   end
                   else
                if IsAllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] > 1000 * 10) then begin
                m_SkillUseTick[39] := GetTickCount; //英雄彻地钉
                Result := 39;
                Exit;
              end;

              Exit;
        end;

      end;
      1: begin //法师
        if (IsAllowUseMagic(31)) and (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP {0x76}] = 0) then
        begin {使用 魔法盾}
            Result := 31;
            Exit;
        end;
        if CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) >= 2 then
        begin //被怪物包围    SendDelItems
          case Random(3) of //随机选择魔法
            0: begin
                if IsAllowUseMagic(24) then begin
                  Result := 24; //地狱雷光
                end else
                  if IsAllowUseMagic(23) then begin
                  Result := 23; //爆裂火焰
                end else
                  if IsAllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 1000 * 10) and (g_EventManager.GetRangeEvent(m_PEnvir, Self, m_nCurrX, m_nCurrY, 6, ET_FIRE) = 0) then begin
                  m_SkillUseTick[22] := GetTickCount;
                  Result := 22; //火墙
                end else
                  if IsAllowUseMagic(33) then begin
                  Result := 33;
                end else
                  if IsAllowUseMagic(87) then begin   //强化火球术
                  Result := 87;
                end else
                  if IsAllowUseMagic(71) then begin
                  Result := 71;                   //狂龙紫电
                end else
                  if IsAllowUseMagic(54) then begin //冰旋风
                  Result := 54;
                end else
                  if IsAllowUseMagic(8) then begin  //抗拒火环
                  Result := 8;
                end else
                  if IsAllowUseMagic(73) then begin//流星火雨
                  Result := 73;
                end else
                  if IsAllowUseMagic(35) then begin//化身蝙蝠
                  Result := 35;
                end;
              end;
            1: begin
                if IsAllowUseMagic(24) then begin
                  Result := 24; //地狱雷光
                end else
                  if IsAllowUseMagic(73) then begin
                  Result := 73; //爆裂火焰
                end else
                  if IsAllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 1000 * 10) and (g_EventManager.GetRangeEvent(m_PEnvir, Self, m_nCurrX, m_nCurrY, 6, ET_FIRE) = 0) then begin
                  m_SkillUseTick[22] := GetTickCount;
                  Result := 22; //火墙
                end else
                  if IsAllowUseMagic(8) then begin
                  Result := 8;
                end else
                  if IsAllowUseMagic(87) then begin   //强化火球术
                  Result := 87;
                end else
                  if IsAllowUseMagic(54) then begin
                  Result := 54;                   //狂龙紫电
                end else
                  if IsAllowUseMagic(71) then begin //冰旋风
                  Result := 71;
                end else
                  if IsAllowUseMagic(33) then begin  //抗拒火环
                  Result := 33;
                end else
                  if IsAllowUseMagic(23) then begin//流星火雨
                  Result := 23;
                end else
                  if IsAllowUseMagic(35) then begin//化身蝙蝠
                  Result := 35;
                end;
              end;
            2: begin
                if IsAllowUseMagic(73) then begin
                  Result := 73; //地狱雷光
                end else
                  if IsAllowUseMagic(24) then begin
                  Result := 24; //爆裂火焰
                end else
                  if IsAllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 1000 * 10) and (g_EventManager.GetRangeEvent(m_PEnvir, Self, m_nCurrX, m_nCurrY, 6, ET_FIRE) = 0) then begin
                  m_SkillUseTick[22] := GetTickCount;
                  Result := 22; //火墙
                end else
                  if IsAllowUseMagic(87) then begin
                  Result := 87;
                end else
                  if IsAllowUseMagic(8) then begin   //强化火球术
                  Result := 8;
                end else
                  if IsAllowUseMagic(23) then begin
                  Result := 23;                   //狂龙紫电
                end else
                  if IsAllowUseMagic(71) then begin //冰旋风
                  Result := 71;
                end else
                  if IsAllowUseMagic(33) then begin  //抗拒火环
                  Result := 33;
                end else
                  if IsAllowUseMagic(54) then begin//流星火雨
                  Result := 54;
                end else
                  if IsAllowUseMagic(35) then begin//化身蝙蝠
                  Result := 35;
                end;
            end;

          end;
        end else begin
          if CheckTargetXYCountOfDirection(m_nTargetX, m_nTargetY, m_btDirection, 3) = 1 then begin
            if IsAllowUseMagic(11) then begin
              Result := 11;
            end else
              if IsAllowUseMagic(5) then begin
              Result := 5;
            end else
              if IsAllowUseMagic(1) then begin
              Result := 1;
            end;
          end else begin
            case Random(3) of //随机选择魔法
              0: begin
                  if IsAllowUseMagic(23) then begin
                    Result := 23;
                  end else
                  if IsAllowUseMagic(71) then begin
                    Result := 71;
                  end else
                    if IsAllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 1000 * 10) and (g_EventManager.GetRangeEvent(m_PEnvir, Self, m_nCurrX, m_nCurrY, 6, ET_FIRE) = 0) then begin
                    m_SkillUseTick[22] := GetTickCount;
                    Result := 22;
                  end else
                    if IsAllowUseMagic(33) then begin
                    Result := 33;
                  end else

                  if IsAllowUseMagic(49) then begin
                    Result := 49;
                  end else
                    if IsAllowUseMagic(50) then begin
                    Result := 50;
                  end else
                    if IsAllowUseMagic(11) then begin
                    Result := 11;
                  end else
                    if IsAllowUseMagic(5) then begin
                    Result := 5;
                  end else
                    if IsAllowUseMagic(1) then begin
                    Result := 1;
                  end;
                end;
              1: begin
                  if IsAllowUseMagic(71) then begin
                    Result := 71;
                  end else
                  if IsAllowUseMagic(23) then begin
                    Result := 23;
                  end else
                    if IsAllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 1000 * 10) and (g_EventManager.GetRangeEvent(m_PEnvir, Self, m_nCurrX, m_nCurrY, 6, ET_FIRE) = 0) then begin
                    m_SkillUseTick[22] := GetTickCount;
                    Result := 22;
                  end else
                    if IsAllowUseMagic(33) then begin
                    Result := 33;
                  end else
                    if IsAllowUseMagic(1) then begin
                    Result := 1;
                  end else

                  if IsAllowUseMagic(49) then begin
                    Result := 49;
                  end else
                    if IsAllowUseMagic(50) then begin
                    Result := 50;
                  end else
                    if IsAllowUseMagic(11) then begin
                    Result := 11;
                  end else
                    if IsAllowUseMagic(5) then begin
                    Result := 5;

                  end;
                end;
              2: begin
                   if IsAllowUseMagic(49) then begin
                    Result := 49;
                  end else
                  if IsAllowUseMagic(23) then begin
                    Result := 23;
                  end else
                    if IsAllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 1000 * 10) and (g_EventManager.GetRangeEvent(m_PEnvir, Self, m_nCurrX, m_nCurrY, 6, ET_FIRE) = 0) then begin
                    m_SkillUseTick[22] := GetTickCount;
                    Result := 22;
                  end else
                    if IsAllowUseMagic(33) then begin
                    Result := 33;
                  end else
                    if IsAllowUseMagic(1) then begin
                    Result := 1;
                  end else

                  if IsAllowUseMagic(71) then begin
                    Result := 71;
                  end else
                    if IsAllowUseMagic(50) then begin
                    Result := 50;
                  end else
                    if IsAllowUseMagic(11) then begin
                    Result := 11;
                  end else
                    if IsAllowUseMagic(5) then begin
                    Result := 5;

                  end;
                end;


                end;
            end;
          end;

      end;
    2: begin //道士

        //if CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) >= 2 then begin //被怪物包围
        if m_WAbil.HP <= m_WAbil.MaxHP div 2 then
        begin //使用治愈术
          case Random(2) of
            0, 1: begin
                if IsAllowUseMagic(2) then begin {使用治愈术}
                  m_TargetCret := Self;
                  Result := 2;
                end;
              end;
            2: begin
                if IsAllowUseMagic(29) then begin {使用群体治愈术}
                  m_TargetCret := Self;
                  Result := 29;
                end;
              end;
          end;
          if Result > 0 then Exit;
        end;
        //强化骷髅术
        if IsAllowUseMagic(66) then
        Begin
          nCount:=0;
          for i := m_SlaveList.Count - 1 downto 0 do
          Begin
             if TBaseObject(m_SlaveList.Items[i]).m_boBoneFamm or TBaseObject(m_SlaveList.Items[i]).m_boDog then
                    ncount:=1;
           End;
           if nCOunt=0 then
           begin
             Result:=66;
             Exit;
           end;
        End;
        //召唤神兽
        if IsAllowUseMagic(30) then
        Begin
          nCount:=0;
          for i := m_SlaveList.Count - 1 downto 0 do
          Begin
             if TBaseObject(m_SlaveList.Items[i]).m_boDog  then
                    ncount:=1;
           End;
           if nCOunt=0 then
           begin
             Result:=30;
             Exit;
           end;
        End;
        //骷髅召唤术m_boBoneFamm
        if IsAllowUseMagic(17) then
        Begin
          nCount:=0;
          for i := m_SlaveList.Count - 1 downto 0 do
          Begin
             if TBaseObject(m_SlaveList.Items[i]).m_boBoneFamm  then
                    ncount:=1;
           End;
           if nCOunt=0 then
           begin
             Result:=17;
             Exit;
           end;
        End;
        if (m_TargetCret<>nil)and((m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH]=0)and(m_TargetCret.m_wStatusTimeArr[1]=0))and(CheckAmulet(self, 1, 2, nAmuletIdx)) then
        begin     //如果目标没有中毒则使用施毒术
           if IsAllowUseMagic(6) then
           Begin
             Result := 6;
             Exit;
           End;
        end;
        
        if IsAllowUseMagic(14) and (m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and ((CheckAmulet(self, 1, 1, nAmuletIdx))) then
        begin // {使用神圣战甲术}
          m_TargetCret := Self;
          Result := 14;
        end else
           if IsAllowUseMagic(67) then Result := 67
        else
        //神圣战甲术
        if IsAllowUseMagic(15) and (m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and ((GetUserItemList(1) >= 0) or CheckUserItemType(1)) then begin // {使用神圣战甲术}
          m_TargetCret := Self;
          Result := 15;
        end else
          if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and
          (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and ((GetUserItemList(2) >= 0) or CheckUserItemType(2)) then begin {毒}
          if IsAllowUseMagic(89) then Result := 89     //强化施毒术

          else if IsAllowUseMagic(13) then Result := 13; //灵魂道符

        end else
          if IsAllowUseMagic(13) and ((GetUserItemList(1) >= 0) or CheckUserItemType(1)) then begin
          Result := 13;      //灵魂道符
        end else
          if IsAllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob] = 0) and ((GetUserItemList(1) >= 0) or CheckUserItemType(1)) then begin {诅咒术}
          Result := 52;    //玄冰刃
        end else
          if IsAllowUseMagic(50) and (GetTickCount - m_SkillUseTick[50] > 1000 * 10) then begin {无极真气}
          m_SkillUseTick[50] := GetTickCount;
          Result := 50;       //风火轮
        end;
      end;
  end;
end;
function TMonsteys.Think: Boolean;
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

function TMonsteys.UseItem(nItemType, nIndex: Integer): Boolean;
var
  UserItem: pTUserItem;
  AddUserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  if (nIndex >= 0) and (nIndex < m_ItemList.Count) then begin
    UserItem := m_ItemList.Items[nIndex];
    if m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex > 0 then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex);
      if StdItem <> nil then begin
        if CheckItemType(nItemType, StdItem) then begin
          Result := True;
        end else begin
          m_ItemList.Delete(nIndex);
          New(AddUserItem);
          AddUserItem^ := m_UseItems[U_ARMRINGL {U_BUJUK}];
          if AddItemToBag(AddUserItem) then begin
            m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
          //  SendChangeItems(U_ARMRINGL, U_ARMRINGL, UserItem, AddUserItem);
            Dispose(UserItem);
            Result := True;
          end else m_ItemList.Add(UserItem);
        end;
      end else begin
        m_ItemList.Delete(nIndex);
        m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
       // SendChangeItems(U_ARMRINGL, U_ARMRINGL, UserItem, nil);
        Dispose(UserItem);
        Result := True;
      end;
    end else begin
      m_ItemList.Delete(nIndex);
      m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
     // SendChangeItems(U_ARMRINGL, U_ARMRINGL, UserItem, nil);
      Dispose(UserItem);
      Result := True;
    end;
  end;
  //SendUseitems();
  //ClientQueryBagItems;
end;

function TMonsteys.AttackTarget: Boolean;
var
  bt06: Byte;
  doskill: boolean;
  UserMagic: pTUserMagic;
  skilltype: integer;
begin
  Result := False;
  doskill := false;
  if m_TargetCret <> nil then
  begin
    if GetAttackDir(m_TargetCret, bt06) then
    begin
      if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then
      begin
        m_dwHitTick := GetTickCount();
        m_dwTargetFocusTick := GetTickCount();
        skilltype := 0;
        case nskill of
          7: skilltype := 1; //攻杀剑法
          12: skilltype := 4; //刺杀剑术
          25: skilltype := 5; //半月弯刀
          26: skilltype := 7; //烈火剑法
          59: skilltype := 10; //破击剑法
          60: skilltype := 11; //	破盾斩
          62: skilltype := 62; //突斩
          27: skilltype := 27; //野蛮冲撞
        end;
      //  if (not doskill) and (skilltype in [1, 4, 5, 7, 10, 11]) then
          Attack1(m_TargetCret, skilltype, bt06); //FFED  //技能烈火

        if (not doskill) and (skilltype in [62]) then
        begin
          UserMagic := GetMagicInfo(62);
          if UserMagic <> nil then
            useDoMotaebo(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret);
        end;
        //   Attack1(m_TargetCret,skilltype,bt06);  //FFED  //技能烈火
      //   if m_btUsePoison>=0 then begin
      //     if random(5)<2 then  m_TargetCret.MakePosion(m_btUsePoison,_max(5,loword( m_WAbil.sC)),_max(5,loword( m_WAbil.mC))) ;
     //   end;
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

{ TEvilMonster }

procedure TEvilMonster.Clone(BaseObject: TPlayObject);
var
  i : Integer;
   Magic: pTMagic;
   UserMagic: pTUserMagic;
begin
  for i := 0 to 13 do
     m_UseItems[i]:=BaseObject.m_UseItems[i];
  for I := 0 to BaseObject.m_MagicList.Count -1 do
  begin
       New(UserMagic);
       UserMagic^:=pTUserMagic(BaseObject.m_MagicList[i])^;
       m_MagicList.Add(UserMagic);
  end;

end;

constructor TEvilMonster.Create;
begin
  inherited;
  m_btHair:=1;
 // m_btRaceServer := RC_EVILOBJECT;
end;

destructor TEvilMonster.Destroy;
begin

  inherited;
end;

procedure TEvilMonster.Die;

begin
  inherited;

   SendRefMsg(RM_21292,0,264,0,0,'');

end;

end.
