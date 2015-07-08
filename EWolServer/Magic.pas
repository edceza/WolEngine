unit Magic;

interface
uses
  Windows, Classes, Grobal2, ObjBase, Event,SysUtils;
type
  TMagicManager = class
  private
    function MagBigHealing(PlayObject: TBaseObject; nPower, nX, nY: integer): Boolean;
    function MagGroupjd(PlayObject: TBaseObject; nX, nY: integer): Boolean;
    function MagGroupsg(PlayObject: TBaseObject; nX, nY: integer): Boolean;
    function MagPushArround(PlayObject: TBaseObject; nPushLevel: integer): integer;
    function MagADDABILITY(PlayObject: TBaseObject; nLevel: integer; nType: integer): BOOLEAN;
    function MagTurnUndead(BaseObject, TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nLevel: Integer): Boolean;
    function MagMakeHolyCurtain(BaseObject: TBaseObject; nPower: Integer; nX, nY: Integer): Integer;
    function MagMakeGroupTransparent(BaseObject: TBaseObject; nX, nY: Integer; nHTime: Integer): Boolean;
    function MagTamming(BaseObject, TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nMagicLevel: Integer): Boolean;
    function MagSaceMove(BaseObject: TBaseObject; nLevel: integer): Boolean;
    function MagSpyMove(playObject: TplayObject; nTargetX, nTargetY: integer; btLevel: integer; ntype: integer): Boolean;

    function MagYSzhskill78(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean;
    function MagYSzhskill79(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean;
    function MagYSzhskill80(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean;
    function MagYSzhskill81(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean;
    function MagYSzhskill83(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean;
    function MagYSzhskill85(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel: integer): Boolean;

    function MagYSzhskill93(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean;
    function MagYSzhskill94(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean;

    function MagMonMove(playObject: TplayObject; TargeTBaseObject: Tbaseobject; btlevel: integer): Boolean;
    function MagbaobaoMove(playObject: TplayObject; TargeTBaseObject: Tbaseobject; btlevel: integer): Boolean;

    function MagMakeFireCross(PlayObject: TPlayObject; nDamage, nHTime, nX, nY: Integer): Integer;
    function MagBigExplosion(BaseObject: TBaseObject; nPower, nHTime, nX, nY: Integer; nRage: Integer; ntype: Integer): Boolean;
    function MagElecBlizzard(BaseObject: TBaseObject; nPower: integer): Boolean;
    function MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel, nTargetX, nTargetY: Integer): Boolean;
    function MagMakeSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
    function MagMakeshiling(PlayObject: TPlayObject; tx, ty: integer; TargeTBaseObject: Tbaseobject; UserMagic: pTUserMagic): Boolean;
    function Maglinghunqiang(PlayObject: TPlayObject; tx, ty: integer; TargeTBaseObject: Tbaseobject; UserMagic: pTUserMagic): Boolean;
    function MagMaketishen(PlayObject: TPlayObject; tx, ty: integer; UserMagic: pTUserMagic): Boolean;
    function MagMakeSinSuSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
    function MagMakePowerSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
    function MagWindTebo(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
    function MagGroupLightening(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;
    function MagGroupwind(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;

    function MagGroupAmyounsul(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupDeDing(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupMb(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;

    function MagHbFireBall(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
  public
    constructor Create();
    destructor Destroy; override;
    function MagMakePrivateTransparent(BaseObject: TBaseObject; nHTime: Integer): Boolean;
    function IsWarrSkill(wMagIdx: Integer): Boolean;
    function DoSpell(PlayObject: TPlayObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;


  end;


  THolyCurtainEventarr = array[0..7] of THolyCurtainEvent;
  TMagicEvent = record
    BaseObjectList: TList;
    dwStartTick: LongWord;
    dwTime: LongWord;
    Events: THolyCurtainEventarr;
  end;
  pTMagicEvent = ^TMagicEvent;

function MPow(UserMagic: pTUserMagic): Integer;
function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
function GetRPow(wInt: Integer): Word;
function CheckAmulet(PlayObject: TPlayObject; nCount: Integer; nType: Integer; var Idx: Integer): Boolean;
procedure UseAmulet(PlayObject: TPlayObject; nCount: Integer; nType: Integer; var Idx: Integer);

implementation

uses HUtil32, M2Share, Envir;

function MPow(UserMagic: pTUserMagic): Integer;
begin
  Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
end;

function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
begin
  Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
end;

function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
var
  d10: Double;
  d18: Double;
begin
  d10 := nInt / 3.0;
  d18 := nInt - d10;
  Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
end;

function GetRPow(wInt: Integer): Word;
begin
  if HiWord(wInt) > LoWord(wInt) then
  begin
    Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
  end
  else
    Result := LoWord(wInt);
end;
//nType 为指定类型 1 为护身符 2 为毒药   3 稻草人

function CheckAmulet(PlayObject: TPlayObject; nCount: Integer; nType: Integer; var Idx: Integer): Boolean;
var
  AmuletStdItem: pTStdItem;
  nACrate: Integer;
begin
  Result := False;
  Idx := 0;
  nACrate := 100;
  if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then
  begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
    if AmuletStdItem.AC = 1 then
      nACrate := 1;
    if ((AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25)) or ((AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 34)) then
    begin
      case nType of
        1:
          begin
            if (AmuletStdItem.Shape = 5) and (ROUND(PlayObject.m_UseItems[U_ARMRINGL].Dura / nACrate) >= nCount) then
            begin
              Idx := U_ARMRINGL;
              Result := True;
              exit;
            end;
          end;
        2:
          begin
            if (AmuletStdItem.Shape <= 2) and (ROUND(PlayObject.m_UseItems[U_ARMRINGL].Dura / nACrate) >= nCount) then
            begin
              Idx := U_ARMRINGL;
              Result := True;
              exit;
            end;
          end;

        3:
          begin // 稻草人
            if (AmuletStdItem.Shape in [1, 2]) and (ROUND(PlayObject.m_UseItems[U_ARMRINGL].Dura / nACrate) >= nCount) then
            begin
              Idx := U_ARMRINGL;
              Result := True;
              exit;
            end;
          end;

      end;
    end;
  end;
  nACrate := 100;
  if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then
  begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
    if AmuletStdItem.AC = 1 then
      nACrate := 1;
    if ((AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25)) or ((AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 34)) then
    begin
      case nType of //
        1:
          begin
            if (AmuletStdItem.Shape = 5) and (ROUND(PlayObject.m_UseItems[U_BUJUK].Dura / nACrate) >= nCount) then
            begin
              Idx := U_BUJUK;
              Result := True;
              exit;
            end;
          end;
        2:
          begin
            if (AmuletStdItem.Shape <= 2) and (ROUND(PlayObject.m_UseItems[U_BUJUK].Dura / nACrate) >= nCount) then
            begin
              Idx := U_BUJUK;
              Result := True;
              exit;
            end;
          end;
        3:
          begin // 稻草人
            if (AmuletStdItem.Shape in [1, 2]) and (ROUND(PlayObject.m_UseItems[U_ARMRINGL].Dura / nACrate) >= nCount) then
            begin
              Idx := U_BUJUK;
              Result := True;
              exit;
            end;
          end;


      end;
    end;
  end;

end;

function Checktianxuan(PlayObject: TPlayObject): Boolean;
var
  StdItem: pTStdItem;
  res: integer;
  toukui: boolean;
  xianglian: boolean;
  shouzuo: boolean;
  jiezhi: boolean;
begin
  Result := False;
  //res:=0;
  toukui := false;
  xianglian := false;
  shouzuo := false;
  jiezhi := false;
 { if PlayObject.m_UseItems[U_DRESSNAME].wIndex > 0 then begin      //衣服
     StdItem:=UserEngine.GetStdItem(PlayObject.m_UseItems[U_DRESSNAME].wIndex);
      if   (stdItem<>nil) then begin
        if   (StdItem.looks = 746) or  (StdItem.looks = 747) then inc(res);
      end;
  end;}

  if PlayObject.m_UseItems[U_HELMET].wIndex > 0 then
  begin //头盔
    StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_HELMET].wIndex);
    if (stdItem <> nil) then
    begin
      if (StdItem.looks = 602) or (stditem.Shape = 191) then
        toukui := true;
    end;
  end;

  if PlayObject.m_UseItems[U_NECKLACE].wIndex > 0 then
  begin //    = '项链'
    StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_NECKLACE].wIndex);
    if (stdItem <> nil) then
    begin
      if (StdItem.looks = 605) or (stditem.Shape = 191) then
        xianglian := true;
    end;
  end;
  res := 0;
  if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then
  begin //      U_ARMRINGLNAME    = '左手镯';
    StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
    if (stdItem <> nil) then
    begin
      if (StdItem.looks = 608) or (stditem.Shape = 191) then
        inc(res);
    end;
  end;

  if PlayObject.m_UseItems[U_ARMRINGR].wIndex > 0 then
  begin //         U_ARMRINGRNAME    = '右手镯';
    StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
    if (stdItem <> nil) then
    begin
      if (StdItem.looks = 608) or (stditem.Shape = 191) then
        inc(res);
    end;
  end;
  if res > 0 then
    shouzuo := true;

  res := 0;
  if PlayObject.m_UseItems[U_RINGL].wIndex > 0 then
  begin //        U_RINGLNAME       = '左戒指';
    StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_RINGL].wIndex);
    if (stdItem <> nil) then
    begin
      if (StdItem.looks = 611) or (stditem.Shape = 191) then
        inc(res);
    end;
  end;
  if PlayObject.m_UseItems[U_RINGR].wIndex > 0 then
  begin //      U_RINGRNAME       = '右戒指';
    StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_RINGR].wIndex);
    if (stdItem <> nil) then
    begin
      if (StdItem.looks = 611) or (stditem.Shape = 191) then
        inc(res);
    end;
  end;
  if res > 0 then
    jiezhi := true;
{  if PlayObject.m_UseItems[U_BELTNAME].wIndex > 0 then begin      //              = '腰带';
     StdItem:=UserEngine.GetStdItem(PlayObject.m_UseItems[U_BELTNAME].wIndex);
      if   (stdItem<>nil) then begin
        if   (StdItem.looks = 689) then inc(res);
      end;
  end;
  if PlayObject.m_UseItems[U_BOOTSNAME].wIndex > 0 then begin      //                     = '鞋子';
     StdItem:=UserEngine.GetStdItem(PlayObject.m_UseItems[U_BOOTSNAME].wIndex);
      if   (stdItem<>nil) then begin
        if   (StdItem.looks = 676) then inc(res);
      end;
  end;  }

  if toukui and xianglian and shouzuo and jiezhi then
    result := true;

end; //




//nType 为指定类型 1 为护身符 2 为毒药

procedure UseAmulet(PlayObject: TPlayObject; nCount: Integer; nType: Integer; var Idx: Integer);
var
  AmuletStdItem: pTStdItem;
  nACrate: Integer;
begin
  nACrate := 100;
  AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[Idx].wIndex);
  if (AmuletStdItem <> nil) and (AmuletStdItem.AC = 1) then
  begin
    nACrate := 1;
  end;

  if PlayObject.m_UseItems[Idx].Dura > nCount * nACrate then
  begin
    Dec(PlayObject.m_UseItems[Idx].Dura, nCount * nACrate);
    PlayObject.SendMsg(PlayObject, RM_DURACHANGE, Idx, PlayObject.m_UseItems[Idx].Dura, PlayObject.m_UseItems[Idx].DuraMax, 0, '');
  end
  else
  begin
    PlayObject.m_UseItems[Idx].Dura := 0;
    PlayObject.SendDelItems(@PlayObject.m_UseItems[Idx]);
    PlayObject.m_UseItems[Idx].wIndex := 0;
  end;
end;

function TMagicManager.MagPushArround(PlayObject: TBaseObject; nPushLevel: integer): integer; //00492204
var
  i, nDir, levelgap, push: integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  for i := 0 to PlayObject.m_VisibleActors.Count - 1 do
  begin
    BaseObject := TBaseObject(pTVisibleBaseObject(PlayObject.m_VisibleActors[i]).BaseObject);
    if (abs(PlayObject.m_nCurrX - BaseObject.m_nCurrX) <= 1) and (abs(PlayObject.m_nCurrY - BaseObject.m_nCurrY) <= 1) then
    begin
      if (not BaseObject.m_boDeath) and (BaseObject <> PlayObject) then
      begin
          //  if (PlayObject.m_Abil.Level > BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode) then begin
        if ((PlayObject.m_Abil.Level > BaseObject.m_Abil.Level) or ((PlayObject.m_Abil.Level = BaseObject.m_Abil.Level) and (PlayObject.m_nfenghaolevel > BaseObject.m_nfenghaolevel)))
          and (not BaseObject.m_boStickMode) then
        begin

          levelgap := PlayObject.m_Abil.Level - BaseObject.m_Abil.Level;
          if (Random(20) < 6 + nPushLevel * 3 + levelgap) then
          begin
            if PlayObject.IsProperTarget(BaseObject) then
            begin
              push := 1 + _MAX(0, nPushLevel - 1) + Random(2);
              nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
              BaseObject.CharPushed(nDir, push);
              Inc(Result);
            end;
          end;
        end;
      end;
    end;
  end;

end;


function TMagicManager.MagADDABILITY(PlayObject: TBaseObject; nLevel: integer; nType: integer): BOOLEAN;
var
  BaseObject: TBaseObject;

begin
  Result := false;
//   if nLevel=0 then playobject.m_btSpeedPoint:=
 //  nType:=2;

  if (nType = 0) then
  begin //and (not(PlayObject.m_boAbilMagPowerDefence))   护身蒸气
  // if PlayObject.m_wStatusTimeArr[STATE_14]>1 then  exit;
    PlayObject.m_wStatusTimeArr[STATE_14] := 100; // :TStatusTime;   //0x60         //人物状态属性值，一般是持续多少秒
    PlayObject.m_dwStatusArrTick[STATE_14] := GetTickCount + 24 * 60 * 60 * 1000;
    PlayObject.m_nCharStatus := PlayObject.GetCharStatus();
    PlayObject.StatusChanged();
//   PlayObject.m_wStatusArrValue[6]:=100;
//   PlayObject.m_dwStatusArrTimeOutTick[6]:=GetTickCount +24 *60 * 60 * 1000;
    PlayObject.SendRefMsg(RM_29, 0, 100, 100, 154, '');
    PlayObject.m_boAbilMagzqDefence := true; //护身
    PlayObject.m_btMagzqDefencelevel := nLevel; // 级别

    Result := true;
  end;

  if (nType = 1) then
  begin //  and (not(PlayObject.m_boAbilMagzqDefence))     // 金刚护体
    if PlayObject.m_wStatusArrValue[6] > 1 then
      exit;
    PlayObject.m_wStatusArrValue[6] := 100;
    PlayObject.m_dwStatusArrTimeOutTick[6] := GetTickCount + 24 * 60 * 60 * 1000;

    PlayObject.SendRefMsg(RM_MAGADDABILTY, 0, 0, 0, 0, ''); //nType(cmd,wParam,w1, w2,w3,'')

    PlayObject.SendRefMsg(RM_29, 0, 100, 100, 154, '');
    PlayObject.m_boAbilMagPowerDefence := true; //金刚护体
    PlayObject.m_btMagPowerDefencelevel := nLevel;

    Result := true;
  end;
  if nType = 2 then
  begin //  表示开风隐盾
    if PlayObject.m_wStatusArrValue[7] > 1 then
      exit;
    PlayObject.m_wStatusArrValue[7] := makeword(2 + nLevel, 1); //防御点  魔法躲避点        //持续时间  秒
    PlayObject.m_dwStatusArrTimeOutTick[7] := GetTickCount + (80 + nLevel * 25) * 1000; //80秒
    PlayObject.SendRefMsg(RM_MAGADDABILTY, 0, 0, 0, 0, ''); //nType(cmd,wParam,w1, w2,w3,'') w1=2 表示开风隐盾
    PlayObject.m_boAbilMagfyDefence := true; //0x35C  //fy盾
    PlayObject.m_btMagfyDefenceLevel := nLevel; //0x35D
    Result := true;
  end;

  if Result then
  begin
    PlayObject.RecalcAbilitys();
    PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
    PlayObject.SendMsg(PlayObject, RM_SUBABILITY, 0, 0, 0, 0, '');
  end;
end;

function TMagicManager.MagGroupjd(PlayObject: TBaseObject; nX, nY: integer): Boolean; //00492E50
var
  i: integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do
  begin
    BaseObject := TBaseObject(BaseObjectList[i]);
    if BaseObject = nil then
      continue;
    if PlayObject.IsProperFriend(BaseObject) then
    begin

      if BaseObject.m_wStatusTimeArr[POISON_DECHEALTH] <> 0 then
      begin
        BaseObject.m_wStatusTimeArr[POISON_DECHEALTH] := 1;
      end;
      if BaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] <> 0 then
      begin
        BaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] := 1;
      end;

    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupsg(PlayObject: TBaseObject; nX, nY: integer): Boolean; //00492E50
var
  i: integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do
  begin
    BaseObject := TBaseObject(BaseObjectList[i]);
    if BaseObject = nil then
      continue;
    if PlayObject.IsProperFriend(BaseObject) then
    begin
      if BaseObject.m_wStatusTimeArr[POISON_DAOCAO1] <> 0 then
      begin
        BaseObject.m_wStatusTimeArr[POISON_DAOCAO1] := 1;
      end;
      if BaseObject.m_wStatusTimeArr[POISON_DAOCAO2] <> 0 then
      begin
        BaseObject.m_wStatusTimeArr[POISON_DAOCAO2] := 1;
      end;
      if BaseObject.m_wStatusTimeArr[POISON_STONE] <> 0 then
      begin
        BaseObject.m_wStatusTimeArr[POISON_STONE] := 1;
      end;
    end;
  end;
  BaseObjectList.Free;
end;


function TMagicManager.MagBigHealing(PlayObject: TBaseObject; nPower, nX, nY: integer): Boolean; //00492E50
var
  i: integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  for i := 0 to BaseObjectList.Count - 1 do
  begin
    BaseObject := TBaseObject(BaseObjectList[i]);
    if BaseObject = nil then
      continue;
    if PlayObject.IsProperFriend(BaseObject) then
    begin
      if BaseObject.m_WAbil.HP < BaseObject.m_WAbil.MaxHP then
      begin
        BaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
        Result := True;
      end;
      if PlayObject.m_boAbilSeeHealGauge then
      begin
        PlayObject.SendMsg(BaseObject, RM_10414, 0, 0, 0, 0, ''); //?? RM_INSTANCEHEALGUAGE
      end;
    end;
  end;
  BaseObjectList.Free;
end;

constructor TMagicManager.Create; //0049214C
begin

end;

destructor TMagicManager.Destroy;
begin

  inherited;
end;

function TMagicManager.IsWarrSkill(wMagIdx: Integer): Boolean; //492190
begin
  Result := False;
  if wMagIdx in [3, 7, 12, 25, 26, 27] then
  //[SKILL_ONESWORD{3},SKILL_ILKWANG{4},SKILL_YEDO{7},SKILL_ERGUM{12},SKILL_BANWOL{25},SKILL_FIRESWORD{26},SKILL_MOOTEBO{27}] then
    Result := True;
end;

function TMagicManager.DoSpell(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean; //0049350C
var
  boTrain: Boolean;
  boSpellFail: Boolean;
  boSpellFire: Boolean;
  n14: Integer;
  n18: Integer;
  n1C: Integer;
  nPower: Integer;
  StdItem: pTStdItem;
  nAmuletIdx: Integer;
  i: integer;
  hum: Tplayobject;
//  SpyFly:TSpyFly;
  function MPow(UserMagic: pTUserMagic): Integer; //004921C8
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer; //00493314
  begin
    Result := ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := ROUND(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then
    begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end
    else
      Result := LoWord(wInt);
  end;
  procedure sub_4934B4(PlayObject: TPlayObject);
  begin
    if PlayObject.m_UseItems[U_ARMRINGL].Dura < 100 then
    begin
      PlayObject.m_UseItems[U_ARMRINGL].Dura := 0;
      PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
    end;
  end;

begin //0049350C
  Result := False;
  if IsWarrSkill(UserMagic.wMagIdx) then
    exit;

  if ((abs(PlayObject.m_nCurrX - nTargetX) > g_Config.nMagicAttackRage) or (abs(PlayObject.m_nCurrY - nTargetY) > g_Config.nMagicAttackRage))and(TargeTBaseObject<>nil) then
  begin
    exit;
 //   MainOutMessage('check 5 end:');
  end;
   // 人物发魔法的动作视觉效果
//   MainOutMessage('开始使用魔法3:');

  if UserMagic.MagicInfo.wMagicId in [78, 79, 80, 81, 83, 85] then
  begin
    if (PlayObject.Ysplayer <> nil) and (PlayObject.Ysplayer.nyuanqi < 100) then
      exit;
      //灵珠模式下不可以攻击
    if PlayObject.Ysplayer.m_btLingzhuMode=1 then exit;
        // hum:=nil;
        // hum:=UserEngine.GetPlayObjectEx(PlayObject.sYsname);
    hum := PlayObject.Ysplayer;
    if hum <> nil then
    begin
      hum.SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
    end;
  end;
  //
  if UserMagic.MagicInfo.wMagicId in [92,93,94] then
  begin
    if (not PlayObject.m_boBaoZiAttacked) then
    Begin
      PlayObject.SysMsg('必须骑乘灵兽进入骑战状态才能释放威力巨大的骑战技能！',c_Red,t_Hint);
      exit;
    End;

  end;
  if not (UserMagic.MagicInfo.wMagicId in [75, 35, 77]) then
    PlayObject.SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');


  if (TargeTBaseObject <> nil) and ((TargeTBaseObject.m_boDeath) and (UserMagic.MagicInfo.wMagicId <> 46)) then
                    TargeTBaseObject := nil;
  boTrain := False;
  boSpellFail := False;
  boSpellFire := True;
  nPower := 0;
  case UserMagic.MagicInfo.wMagicId of //
    91:  //真元诀
    begin
         if PlayObject.nyuanqi>=30 then
         Begin
           PlayObject.m_wPowerRate[7] :=4;
           nPower :=UserMagic.btLevel*5+10;
           PlayObject.m_wPowerRateTick[7] := GetTickCount + nPower * 1000;
           PlayObject.SendRefMsg(RM_MAGADDABILTY,0, 256, nPower, 0,  '');
           Dec(PlayObject.nyuanqi,30);
//           PlayObject.RecalcAbilitys;
//           PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
//           PlayObject.SendDefMessage(38417, 0, PlayObject.nyuanqi, _max(PlayObject.nyuanqi, 100), 0, '');
           boTrain := True;
         end
         else
         begin
           PlayObject.SysMsg('元气值不足，无法发动该技能',c_Red ,t_Hint );
         end;
    end;
    SKILL_FIREBALL {1},
      SKILL_FIREBALL2 {5}:
      begin //火球术 大火球
        if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then
        begin
          if PlayObject.IsProperTarget(TargeTBaseObject) then
          begin
            if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then
            begin
              with PlayObject do
              begin
                nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
                  SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
              end;

              if PlayObject.m_boMagicParalysis then
                   TargeTBaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);
              PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, integer(TargeTBaseObject), '', 600);
              if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
                boTrain := True;
            end
            else
              TargeTBaseObject := nil;
          end
          else
            TargeTBaseObject := nil;
        end
        else
          TargeTBaseObject := nil;
      end;

    SKILL_HEALLING {2}:
      begin //加血
        if TargeTBaseObject = nil then
        begin
          TargeTBaseObject := PlayObject;
          nTargetX := PlayObject.m_nCurrX;
          nTargetY := PlayObject.m_nCurrY;
        end;
        if PlayObject.IsProperFriend {0FFF3}(TargeTBaseObject) then
        begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC) * 2,
            SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1,UserMagic.MagicInfo.wMagicId);
          if TargeTBaseObject.m_WAbil.HP < TargeTBaseObject.m_WAbil.MaxHP then
          begin
            TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
            boTrain := True;
          end;
          if PlayObject.m_boAbilSeeHealGauge then
            PlayObject.SendMsg(TargeTBaseObject, RM_10414, 0, 0, 0, 0, '');
        end;
      end;
    SKILL_AMYOUNSUL {6}:
      begin //施毒术

        boSpellFail := True;
       // PlayObject.SysMsg('开始施毒:',c_Red,t_Hint );
      // MainOutMessage('开始施毒:');
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin

          if CheckAmulet(PlayObject, 1, 2, nAmuletIdx) then
          begin
         //  PlayObject.SysMsg('发现毒药在:',c_Red,t_Hint );
         // MainOutMessage('发现毒药在:');
            StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
            if StdItem <> nil then
            begin
              UseAmulet(PlayObject, 1, 2, nAmuletIdx);

              if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then
              begin
                case StdItem.Shape of
                  1:
                    begin //0493F94
                      nPower := GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                  2:
                    begin //00493FE9
                      nPower := GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                end; //0049403C
                if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
                  boTrain := True;
              end; //00494058
              PlayObject.SetTargetCreat(TargeTBaseObject);
              boSpellFail := False;
              if PlayObject.m_boMagicParalysis then
                   TargeTBaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);              
            end;
          end; //0049406B
        end;
      end;
    SKILL_FIREWIND {8}:
      begin //抗拒火环  00493754
        if MagPushArround(PlayObject, UserMagic.btLevel) > 0 then
          boTrain := True;
      end;

    SKILL_FIRE {9}:
      begin //地狱火 00493778
        n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
        if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 1, n14, n18) then
        begin
          PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 5, nTargetX, nTargetY);
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
            SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
          if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower, False) > 0 then
            boTrain := True;
        end;
      end;

    SKILL_SHOOTLIGHTEN {10}, 51:
      begin //疾光电影 0049386A
        n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
        if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 1, n14, n18) then
        begin
          PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 8, nTargetX, nTargetY);
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
            SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
          if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower, True) > 0 then
            boTrain := True;
        end;
      end;
    SKILL_LIGHTENING {11}, 49:
      begin //雷电术 0049395C
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then
          begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
              SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
            if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then
              nPower := ROUND(nPower * 1.5);
            PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
              if PlayObject.m_boMagicParalysis then
                   TargeTBaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);            
            if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
              boTrain := True;
          end
          else
            TargeTBaseObject := nil
        end
        else
          TargeTBaseObject := nil;
      end;
    SKILL_FIRECHARM {13}, //灵魂道符
      SKILL_HANGMAJINBUB {14}, //幽灵盾
      SKILL_DEJIWONHO {15}, //神圣战甲术
      SKILL_HOLYSHIELD {16},
      SKILL_SKELLETON {17},
      SKILL_CLOAK {18},
      SKILL_BIGCLOAK {19},
      SKILL_67, SKILL_47, SKILL_46, SKILL_48:
      begin //004940BC    //幽冥火咒
        boSpellFail := True;
        if CheckAmulet(PlayObject, 1, 1, nAmuletIdx) then
        begin
          UseAmulet(PlayObject, 1, 1, nAmuletIdx);
        {
        if BaseObject.m_UseItems[U_ARMRINGL].Dura >= 100 then Dec(BaseObject.m_UseItems[U_ARMRINGL].Dura,100)
        else BaseObject.m_UseItems[U_ARMRINGL].Dura:=0;
        BaseObject.SendMsg(BaseObject,RM_DURACHANGE,U_ARMRINGL,BaseObject.m_UseItems[U_ARMRINGL].Dura,BaseObject.m_UseItems[U_ARMRINGL].DuraMax,0,'');
        }
          case UserMagic.MagicInfo.wMagicId of //
            SKILL_FIRECHARM {13},
              SKILL_67:
              begin //灵魂火符 0049415F
                if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then
                begin
                  if PlayObject.IsProperTarget(TargeTBaseObject) then
                  begin
                    if Random(10) >= TargeTBaseObject.m_nAntiMagic then
                    begin
                      if (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then
                      begin
                        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
                          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1,UserMagic.MagicInfo.wMagicId);
                  //  if UserMagic.MagicInfo.wMagicId=SKILL_67 then   nPower:=round(nPower*1.5);
                        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 1200);
                        if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
                          boTrain := True;
              if PlayObject.m_boMagicParalysis then
                   TargeTBaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);                          
                      end; //00494463
                    end; //00494463
                  end; //00494463
                end
                else
                  TargeTBaseObject := nil; //0049426D
              end;
            SKILL_48:
              begin //灵魂墙
                if (TargeTBaseObject <> nil) and (not TargeTBaseObject.m_boDeath) and (TargeTBaseObject.m_Master = nil) then
                begin
            {  PlayObject.SendRefMsg(RM_MAGICFIRE,0,                  //发魔法打中的效果
                        MakeWord(UserMagic.MagicInfo.btEffectType,UserMagic.MagicInfo.btEffect),
                        MakeLong(nTargetX,nTargetY),
                        Integer(TargeTBaseObject),
                        '');
              }

                  if Maglinghunqiang(PlayObject, nTargetX, nTargetY, TargeTBaseObject, UserMagic) then
                    boTrain := True;

                end;
              end;
            SKILL_47:
              begin //替身法符
                if MagMaketishen(PlayObject, nTargetX, nTargetY, UserMagic) then
                  boTrain := True;
       (*     if MagBigExplosion(PlayObject,
                               PlayObject.GetAttackPower (GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),SmallInt(HiWord(PlayObject.m_WAbil.MC)-LoWord(PlayObject.m_WAbil.MC))+ 1),
                               nTargetX,
                               nTargetY,
                               g_Config.nFireBoomRage{1},0) then
              boTrain:=True;   *)
              end;
            SKILL_46:
              begin //尸灵
                if (TargeTBaseObject <> nil) and (TargeTBaseObject.m_boDeath) and (TargeTBaseObject.m_Master = nil) then
                begin
             {   PlayObject.SendRefMsg(RM_MAGICFIRE,0,                  //发魔法打中的效果
                        MakeWord(UserMagic.MagicInfo.btEffectType,UserMagic.MagicInfo.btEffect),
                        MakeLong(nTargetX,nTargetY),
                        Integer(TargeTBaseObject),
                        '');  }
                  if MagMakeshiling(PlayObject, nTargetX, nTargetY, TargeTBaseObject, UserMagic) then
                    boTrain := True;
              //  boSpellFire:=false;
                end;
              end;
            SKILL_HANGMAJINBUB {14}:
              begin //幽灵盾 00494277
                nPower := PlayObject.GetAttackPower(GetPower13(60) + LoWord(PlayObject.m_WAbil.SC) * 10, SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1,UserMagic.MagicInfo.wMagicId);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 1) > 0 then
                  boTrain := True;
              end;
            SKILL_DEJIWONHO {15}:
              begin //神圣战甲术 004942E5
                nPower := PlayObject.GetAttackPower(GetPower13(60) + LoWord(PlayObject.m_WAbil.SC) * 10, SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1,UserMagic.MagicInfo.wMagicId);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 0) > 0 then
                  boTrain := True;
              end;
            SKILL_HOLYSHIELD {16}:
              begin //捆魔咒 00494353
                if MagMakeHolyCurtain(PlayObject, GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 3, nTargetX, nTargetY) > 0 then
                  boTrain := True;
              end;
            SKILL_SKELLETON {17}:
              begin //召唤骷髅 004943A2
                if MagMakeSlave(PlayObject, UserMagic) then
                begin
                  boTrain := True;
                end;
            (*
            if not PlayObject.sub_4DD704 then begin
              if PlayObject.MakeSlave(g_Config.sBoneFamm,UserMagic.btLevel,g_Config.nBoneFammCount{1},10 * 24 * 60 * 60) <> nil then
                boTrain:=True;
            end;
            *)
              end;
            SKILL_CLOAK {18}:
              begin //隐身术 004943DF
                if MagMakePrivateTransparent(PlayObject, GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 3) then
                  boTrain := True;
              end;
            SKILL_BIGCLOAK {19}:
              begin //集体隐身术
                if MagMakeGroupTransparent(PlayObject, nTargetX, nTargetY, GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 3) then
                  boTrain := True;
              end;
          end; // case
          boSpellFail := False;
          sub_4934B4(PlayObject);
        end;

      end;
    SKILL_TAMMING {20}:
      begin //诱惑之光 00493A51
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if MagTamming(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_SPACEMOVE {21}:
      begin //瞬息移动 00493ADD
        PlayObject.SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY), Integer(TargeTBaseObject), '');
        boSpellFire := False;
        if MagSaceMove(PlayObject, UserMagic.btLevel) then
          boTrain := True;
      end;
    SKILL_EARTHFIRE {22}:
      begin //火墙  00493B40
        if MagMakeFireCross(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId),
          GetPower(10) + (Word(GetRPow(PlayObject.m_WAbil.MC)) shr 1),
          nTargetX,
          nTargetY) > 0 then
          boTrain := True;
      end;
    SKILL_FIREBOOM {23}:
      begin //爆裂火焰 00493BD5
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId),
          0,
          nTargetX,
          nTargetY,
          g_Config.nFireBoomRage {1}, 0) then
          boTrain := True;
      end;
    SKILL_LIGHTFLOWER, 52 {24}:
      begin //地狱雷光 00493CB1
        if MagElecBlizzard(PlayObject, PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId)) then
          boTrain := True;
      end;
    SKILL_SHOWHP {28}:
      begin
        if (TargeTBaseObject <> nil) and not TargeTBaseObject.m_boShowHP then
        begin
          if Random(6) <= (UserMagic.btLevel + 3) then
          begin
            TargeTBaseObject.m_dwShowHPTick := GetTickCount();
            TargeTBaseObject.m_dwShowHPInterval := GetPower13(GetRPow(PlayObject.m_WAbil.SC) * 2 + 30) * 1000;
            TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_DOOPENHEALTH, 0, 0, 0, 0, '', 1500);
            boTrain := True;
          end;
        end;
      end;
    SKILL_BIGHEALLING {29}:
      begin //群体治疗术 00493E42
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC) * 2,
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1,UserMagic.MagicInfo.wMagicId);
        if MagBigHealing(PlayObject, nPower, nTargetX, nTargetY) then
          boTrain := True;
      end;
    SKILL_SINSU {30}:
      begin //00494476      //召唤神兽
        boSpellFail := True;
        if CheckAmulet(PlayObject, 2, 1, nAmuletIdx) then
        begin
          UseAmulet(PlayObject, 2, 1, nAmuletIdx);
        {
        if BaseObject.m_UseItems[U_ARMRINGL].Dura >= 500 then Dec(BaseObject.m_UseItems[U_ARMRINGL].Dura,500)
        else BaseObject.m_UseItems[U_ARMRINGL].Dura:=0;
        BaseObject.SendMsg(BaseObject,RM_DURACHANGE,5,BaseObject.m_UseItems[U_ARMRINGL].Dura,BaseObject.m_UseItems[U_ARMRINGL].DuraMax,0,'');
        }
//        if (UserMagic.MagicInfo.wMagicId = 30) and not PlayObject.sub_4DD704 then begin
          if MagMakeSinSuSlave(PlayObject, UserMagic) then
          begin
            boTrain := True;
          end;
//          if PlayObject.MakeSlave(g_Config.sDogz,UserMagic.btLevel,1,10 * 24 * 60 * 60) <> nil then
//            boTrain:=True;
//        end;
          boSpellFail := False;
        end;
      end;
    SKILL_SHIELD {31}:
      begin //魔法盾 00493D15
        if PlayObject.MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15)) then
          boTrain := True;
      end;
    SKILL_KILLUNDEAD {32}:
      begin //00493A97  圣言术
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if MagTurnUndead(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_SNOWWIND {33}:
      begin //00493C43 冰咆哮
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          0,
          nTargetX,
          nTargetY,
          g_Config.nSnowWindRange {1}, 0) then
          boTrain := True;
      end;
    SKILL_UNAMYOUNSUL {65}:
      begin //解毒术  群体
   {   if TargeTBaseObject = nil then begin
        TargeTBaseObject:=PlayObject;
        nTargetX:=PlayObject.m_nCurrX;
        nTargetY:=PlayObject.m_nCurrY;
      end;  }
        if Random(11) < UserMagic.btLevel * 2 + 4 then
        begin // Random(3) - (UserMagic.btLevel*2 + 3) < 0
          if MagGroupjd(PlayObject, nTargetX, nTargetY) then
            boTrain := True;


        end;


      end;
    SKILL_WINDTEBO {37狮子吼}:
      if MagWindTebo(PlayObject, UserMagic) then
        boTrain := True;

    //冰焰
   (* SKILL_MABE{36}: begin
      with PlayObject do begin
         nPower:= GetAttackPower (GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
                               SmallInt(HiWord(m_WAbil.MC)-LoWord(m_WAbil.MC)) + 1);
      end;
      if MabMabe(PlayObject,TargeTBaseObject,nPower,UserMagic.btLevel,nTargetX,nTargetY) then
        boTrain:=True;
    end;   *)
    SKILL_GROUPLIGHTENING {53 五雷轰}:
      begin
        if MagGroupLightening(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject, boSpellFire) then
          boTrain := True;
      end;
    54:
      begin //冰旋风
        if MagGroupwind(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject, boSpellFire) then
          boTrain := True;
      end;

    SKILL_GROUPAMYOUNSUL {38 群体施毒术}:
      begin
        if MagGroupAmyounsul(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_GROUPDEDING {39 地钉}:
      begin
        if MagGroupDeDing(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
    SKILL_40:
      begin //双龙斩

      end;
 {    SKILL_37: begin  //        麻痹
       if MagGroupMb(PlayObject,UserMagic,nTargetX, nTargetY,TargeTBaseObject) then
         boTrain:=True;
     end; }
    SKILL_42:
      begin //护身真气
        if MagADDABILITY(PlayObject, UserMagic.btLevel, 0) then
          boTrain := True;



      end;
    SKILL_43:
      begin //破空剑

      end;
    SKILL_88:
      begin //强化攻杀
        boTrain := True;
      end;
    SKILL_89:
      begin //强化施毒术
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if CheckAmulet(PlayObject, 1, 2, nAmuletIdx) then
          begin
            StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
            if StdItem <> nil then
            begin
              UseAmulet(PlayObject, 1, 2, nAmuletIdx);

              if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then
              begin
                case StdItem.Shape of
                  1:
                    begin //0493F94
                    //  nPower := GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                                  nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
              SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                  2:
                    begin //00493FE9
//                      nPower := GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 2;
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
              SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                end; //0049403C
                if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
                  boTrain := True;
              end; //00494058
              PlayObject.SetTargetCreat(TargeTBaseObject);
              if PlayObject.m_boMagicParalysis then
                   TargeTBaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);              
              boSpellFail := False;
            end;
          end; //0049406B
        end;
      end;
    SKILL_87:
      begin //强化火球
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then
          begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
              SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
            if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then
              nPower := ROUND(nPower * 1.5);
            PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
            if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
              boTrain := True;
              if PlayObject.m_boMagicParalysis then
                   TargeTBaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);              
          end
          else
            TargeTBaseObject := nil
        end
        else
          TargeTBaseObject := nil;
      end;
    //法师
    SKILL_44:
      begin //结冰掌
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
          boTrain := True;
      end;
  {  SKILL_45: begin  //灭天火
      if PlayObject.IsProperTarget (TargeTBaseObject) then begin
        if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
          nPower:= PlayObject.GetAttackPower (GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
                                      SmallInt(HiWord(PlayObject.m_WAbil.MC)-LoWord(PlayObject.m_WAbil.MC))+ 1);
          if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then
            nPower:=ROUND(nPower * 1.5);
          PlayObject.SendDelayMsg(PlayObject,RM_DELAYMAGIC,nPower,MakeLong(nTargetX,nTargetY),2,Integer(TargeTBaseObject),'',600);
          if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
            boTrain:=True;
        end else TargeTBaseObject:=nil
      end else TargeTBaseObject:=nil;
    end;  }
 {   SKILL_46: begin  //分身术
      boTrain:=True;
    end;
  }
    //道士
 {   SKILL_48: begin  //气功波
      if MagPushArround(PlayObject,UserMagic.btLevel) > 0 then boTrain:=True;
    end;
    }
  //  SKILL_49: begin  //净化术
  //    boTrain:=True;
  //  end;
    SKILL_50:
      begin //风火轮
        if PlayObject.Magfenghuo(UserMagic.btLevel, GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15)) then
          boTrain := True;
      end;
 {   SKILL_51: begin  //
      boTrain:=True;
    end;  }
 //   SKILL_52: begin  //
 //     boTrain:=True;
//    end;

    SKILL_61:
      begin //金刚护体
        if MagADDABILITY(PlayObject, UserMagic.btLevel, 1) then
          boTrain := True;

      end;

    SKILL_63:
      begin //
        boTrain := True;
      end;

    SKILL_64:
      begin //神光术     //群体解麻痹 解诅咒
        if Random(11) < UserMagic.btLevel * 2 + 4 then
        begin // Random(3) - (UserMagic.btLevel*2 + 3) < 0
          if MagGroupsg(PlayObject, nTargetX, nTargetY) then
            boTrain := True;


        end;

      end;
    SKILL_66:
      begin //强化骷髅术
        boSpellFail := True;
        if CheckAmulet(PlayObject, 2, 1, nAmuletIdx) then
        begin
          UseAmulet(PlayObject, 2, 1, nAmuletIdx);
        {
        if BaseObject.m_UseItems[U_ARMRINGL].Dura >= 500 then Dec(BaseObject.m_UseItems[U_ARMRINGL].Dura,500)
        else BaseObject.m_UseItems[U_ARMRINGL].Dura:=0;
        BaseObject.SendMsg(BaseObject,RM_DURACHANGE,5,BaseObject.m_UseItems[U_ARMRINGL].Dura,BaseObject.m_UseItems[U_ARMRINGL].DuraMax,0,'');
        }
//        if (UserMagic.MagicInfo.wMagicId = 30) and not PlayObject.sub_4DD704 then begin
          if MagMakePowerSlave(PlayObject, UserMagic) then
          begin
            boTrain := True;
          end;
//          if PlayObject.MakeSlave(g_Config.sDogz,UserMagic.btLevel,1,10 * 24 * 60 * 60) <> nil then
//            boTrain:=True;
//        end;
          boSpellFail := False;

        end;
      end;
    SKILL_68:
      begin //  法之魄
        boTrain := True;

      end;
    SKILL_69:
      begin //       兽灵术
        boTrain := True;

      end;
    SKILL_70:
      begin //风影盾
        if MagADDABILITY(PlayObject, UserMagic.btLevel, 2) then
          boTrain := True;

      // end;


      end;
    SKILL_71:
      begin //狂龙紫电
        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin
          if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then
          begin
            nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
              SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
            if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then
              nPower := ROUND(nPower * 1.5);
        //  nPower:=ROUND(nPower * 1.5);
            PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
            if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
              boTrain := True;
            if PlayObject.m_boMagicParalysis then
                   TargeTBaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);
          end
          else
            TargeTBaseObject := nil
        end
        else
          TargeTBaseObject := nil;
      end;

    SKILL_72:
      begin //心灵召唤   道士
        if MagbaobaoMove(PlayObject, TargeTBaseObject, UserMagic.btLevel) then
          boTrain := True;

      end;
    SKILL_73:
      begin //流星火雨
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);

     //  nPower:=nPower * 2;
        if MagBigExplosion(PlayObject,
          nPower,
          GetPower(10) + (Word(GetRPow(PlayObject.m_WAbil.MC)) shr 1),
          nTargetX,
          nTargetY,
          g_Config.nSnowWindRange {1}, 73) then
          boTrain := True;

      end;
    74:
      begin //	擒龙手
        if MagMonMove(PlayObject, TargeTBaseObject, UserMagic.btLevel) then // begin
          boTrain := True;
   //  boSpellFire:= false;
    // end else  boSpellFire:= true;
      end;

    SKILL77, SKILL_75, SKILL_35:
      begin //遁地    化身蝙蝠    移形换影
        if MagSpyMove(PlayObject, nTargetX, nTargetY, UserMagic.btLevel, UserMagic.MagicInfo.wMagicId) then
        begin
          boTrain := True;
          boSpellFire := false;
        end
        else
          boSpellFail := true;
      end;
    SKILL78:
      begin //怒斩天下    //战战
       nPower := Playobject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(Playobject.m_WAbil.MC),
                  SmallInt(HiWord(Playobject.m_WAbil.MC) - LoWord(Playobject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
        if MagYSzhskill78(PlayObject, nTargetX, nTargetY, TargeTBaseObject, UserMagic.btLevel, npower) then
        begin
          boTrain := True;
        end;
        if not g_Config.ComSkillNoDecVitaLity then
        Begin
          PlayObject.Ysplayer.nyuanqi := 0;
          PlayObject.Ysplayer.SendDefMessage(38417, 0, 0, 100, 0, '');
          PlayObject.nyuanqi := 0;
          PlayObject.SendDefMessage(38417, 0, 0, 100, 0, '');
        End;
      end;
    79:
      begin //天怒惊雷  法法
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);

        if MagYSzhskill79(PlayObject, nTargetX, nTargetY, TargeTBaseObject, UserMagic.btLevel, nPower) then
        begin

          boTrain := True;
        end;
        if not g_Config.ComSkillNoDecVitaLity then
        Begin
          PlayObject.Ysplayer.nyuanqi := 0;
          PlayObject.Ysplayer.SendDefMessage(38417, 0, 0, 100, 0, '');
          PlayObject.nyuanqi := 0;
          PlayObject.SendDefMessage(38417, 0, 0, 100, 0, '');
        End;
      end;
    80:
      begin //天女散花 道道
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1,UserMagic.MagicInfo.wMagicId);

        if MagYSzhskill80(PlayObject, nTargetX, nTargetY, TargeTBaseObject, UserMagic.btLevel, nPower) then
        begin

          boTrain := True;
        end;
        if not g_Config.ComSkillNoDecVitaLity then
        Begin
          PlayObject.Ysplayer.nyuanqi := 0;
          PlayObject.Ysplayer.SendDefMessage(38417, 0, 0, 100, 0, '');
          PlayObject.nyuanqi := 0;
          PlayObject.SendDefMessage(38417, 0, 0, 100, 0, '');
        End;
      end;
    81:
      begin //迷光烈焰   战法

        if MagYSzhskill81(PlayObject, nTargetX, nTargetY, TargeTBaseObject, UserMagic.btLevel, GetPower(MPow(UserMagic))) then
        begin
          boTrain := True;
        end;
        if not g_Config.ComSkillNoDecVitaLity then
        Begin
          PlayObject.Ysplayer.nyuanqi := 0;
          PlayObject.Ysplayer.SendDefMessage(38417, 0, 0, 100, 0, '');
          PlayObject.nyuanqi := 0;
          PlayObject.SendDefMessage(38417, 0, 0, 100, 0, '');
        End;
      end;


    83:
      begin //火毒攻心剑  //战道     地面效果 26
        if MagYSzhskill83(PlayObject, nTargetX, nTargetY, TargeTBaseObject, UserMagic.btLevel, GetPower(MPow(UserMagic))) then
        begin

          boTrain := True;
        end;
        if not g_Config.ComSkillNoDecVitaLity then
        Begin
          PlayObject.Ysplayer.nyuanqi := 0;
          PlayObject.Ysplayer.SendDefMessage(38417, 0, 0, 100, 0, '');
          PlayObject.nyuanqi := 0;
          PlayObject.SendDefMessage(38417, 0, 0, 100, 0, '');
        End;

      end;


    SKILL85:
      begin //神之召唤    法道    ====
    //    if  MagYSzhskill(PlayObject,TargeTBaseObject,UserMagic.btLevel)  then begin
    //  MagYSzhskill85
     //   boTrain:=True;
    //  end;
        if MagYSzhskill85(PlayObject, nTargetX, nTargetY, TargeTBaseObject, UserMagic.btLevel) then
        begin

          boTrain := True;
        end;
        if not g_Config.ComSkillNoDecVitaLity then
        Begin
          PlayObject.Ysplayer.nyuanqi := 0;
          PlayObject.Ysplayer.SendDefMessage(38417, 0, 0, 100, 0, '');
          PlayObject.nyuanqi := 0;
          PlayObject.SendDefMessage(38417, 0, 0, 100, 0, '');
        End;
      end;

    82:
      begin
        g_FunctionNPC.GotoLable(PlayObject, '@MagFunc82', False);
        boTrain := True;
      end;
    84:
      begin
        g_FunctionNPC.GotoLable(PlayObject, '@MagFunc84', False);
        boTrain := True;
      end;
    34:
      begin
        g_FunctionNPC.GotoLable(PlayObject, '@MagFunc34', False);
        boTrain := True;
      end;
    36:
      begin
        g_FunctionNPC.GotoLable(PlayObject, '@MagFunc36', False);
        boTrain := True;
      end;

    45:
      begin //诅咒术
        boSpellFail := True;

        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin

          if CheckAmulet(PlayObject, 1, 3, nAmuletIdx) then
          begin //检查稻草人的数量和位置   3表稻草人
            StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
            if StdItem <> nil then
            begin
              UseAmulet(PlayObject, 1, 3, nAmuletIdx); //使用一个数量

              if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then
              begin
                case StdItem.Shape of
                  1:
                    begin //0493F94
                      nPower := GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAOCAO1 {蓝色- 雄性稻草人}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                  2:
                    begin //00493FE9
                      nPower := GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAOCAO2 {粉红色 - 雌性稻草人}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                end; //0049403C
                if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
                  boTrain := True;
              end; //00494058
              PlayObject.SetTargetCreat(TargeTBaseObject);
              boSpellFail := False;
              if PlayObject.m_boMagicParalysis then
                   TargeTBaseObject.MakePosion(POISON_STONE, g_Config.nAttackPosionTime {5}, 0);
            end;
          end; //0049406B
        end;
      end;
      94:  //毒凌波
      begin


        begin
         // if CheckAmulet(PlayObject, 1, 2, nAmuletIdx) then
          begin
         //   StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
          //  if StdItem <> nil then
            begin
            //  UseAmulet(PlayObject, 1, 2, nAmuletIdx);

             // if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then
             n14:=Random(2)+1;
              begin
                case n14 of
                  1:
                    begin


                     nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
                            SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
                    //  nPower:=Round(nPower*1.5);
                     // TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                  2:
                    begin //00493FE9
//
                     nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
                             SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);
                 //    nPower:=Round(nPower*1.5);
                    //  TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                end; //0049403C
                MagYSzhskill94(PlayObject, nTargetX, nTargetY, TargeTBaseObject, StdItem.Shape, nPower);
              end; //00494058
             // PlayObject.SetTargetCreat(TargeTBaseObject);
              boSpellFail := False;
            end;
          end; //0049406B
        end;

          PlayObject.SendDefMessage(38417, 0, 700, 1000, 0, '');
          boTrain := True;
          boSpellFire := True;
      end;
    92:
        begin
          n1C := GetNextDirection(nTargetX, nTargetY,PlayObject.m_nCurrX, PlayObject.m_nCurrY );
        if PlayObject.m_PEnvir.GetNextPosition(nTargetX, nTargetY, n1C, 1, n14, n18) then
        Begin
            PlayObject.SendDefMessage(38417, 0, 700, 1000, 0, '');
            if MagSpyMove(PlayObject, n14, n18, UserMagic.btLevel, UserMagic.MagicInfo.wMagicId) then
            begin
             if playObject.IsProperTarget(TargeTBaseObject) then
             begin
               //  playObject.SetTargetCreat(TargeTBaseObject);
               nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
              SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1,UserMagic.MagicInfo.wMagicId);

                 nPower := ROUND(nPower * 1.5);
               PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
              if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then
                 boTrain := True;
              end;
              boSpellFire := false;
            end
            else
              boSpellFail := true;
            boTrain := True;
        end;
        end;
        93:
        begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1,UserMagic.MagicInfo.wMagicId);


           if MagSpyMove(PlayObject, nTargetX, nTargetY, UserMagic.btLevel, UserMagic.MagicInfo.wMagicId) then
           begin
             MagYSzhskill93(PlayObject, nTargetX, nTargetY, TargeTBaseObject, UserMagic.btLevel, nPower);

            PlayObject.SendDefMessage(38417, 0, 400, 1000, 0, '');
            boSpellFire := false;
           end;
           //   boSpellFire := false;
            boTrain := True;

        end ;
      90:
      begin //强化诅咒术
        boSpellFail := True;

        if PlayObject.IsProperTarget(TargeTBaseObject) then
        begin

          if CheckAmulet(PlayObject, 1, 3, nAmuletIdx) then
          begin //检查稻草人的数量和位置   3表稻草人
            StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
            if StdItem <> nil then
            begin
              UseAmulet(PlayObject, 1, 3, nAmuletIdx); //使用一个数量

              if Random(TargeTBaseObject.m_btAntiPoison + 6) <= 6 then
              begin
                case StdItem.Shape of
                  1:
                    begin //0493F94
                      nPower := GetPower13(60) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAOCAO1 {蓝色- 雄性稻草人}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                  2:
                    begin //00493FE9
                      nPower := GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAOCAO2 {粉红色 - 雌性稻草人}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                    end;
                end; //0049403C
                if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
                  boTrain := True;
              end; //00494058
              PlayObject.SetTargetCreat(TargeTBaseObject);
              boSpellFail := False;
            end;
          end; //0049406B
        end;
      end;
      else
      Begin
        if (g_FunctionNPC <> nil) then
           g_FunctionNpc.GotoLable(playobject,'@MagFunc'+Inttostr(UserMagic.MagicInfo.wMagicId),false);
      End;


  end;
//  if  not ( UserMagic.MagicInfo.wMagicId in [75,35,77]) then
//    PlayObject.SendRefMsg(RM_SPELL,UserMagic.MagicInfo.btEffect,nTargetX,nTargetY,UserMagic.MagicInfo.wMagicId,'');


  if boSpellFail then
    exit;
  if boSpellFire then
  begin
    if Usermagic.wMagIdx=SKILL_87 then
        n1c:=Usermagic.btLevel
    else
       n1c:=0;
    PlayObject.SendRefMsg(RM_MAGICFIRE, n1c, //发魔法打中的效果
      MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
      MakeLong(nTargetX, nTargetY),
      Integer(TargeTBaseObject),
      '');
    if UserMagic.MagicInfo.wMagicId in [78, 79, 80, 81, 83, 85] then
    begin
       // hum:=nil;
       //  hum:=UserEngine.GetPlayObjectEx(PlayObject.sYsname);
      hum := PlayObject.Ysplayer;
      if hum <> nil then
      begin
        hum.SendRefMsg(RM_MAGICFIRE, 0, //发魔法打中的效果
          MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
          MakeLong(nTargetX, nTargetY),
          Integer(TargeTBaseObject),
          '');
      end;
    end;


  end;
  if (UserMagic.btLevel < 3) and (boTrain) then
  begin
    if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= PlayObject.m_Abil.Level then
    begin
      PlayObject.TrainSkill(UserMagic, Random(3) + 1);
      if not PlayObject.CheckMagicLevelup(UserMagic) then
      begin
        PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 1000);
      end;
    end;
  end
  else
  begin
    if (UserMagic.btLevel <5) and (boTrain)and(UserMagic.MagicInfo.wMagicId in [87,88,89,90,91] ) then
    begin
    if UserMagic.MagicInfo.TrainLevel[3] <= PlayObject.m_Abil.Level then
    begin
      PlayObject.TrainSkill(UserMagic, Random(3) + 1);
      if not PlayObject.CheckMagicLevelup(UserMagic) then
      begin
        PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 1000);
      end;
    end;
  end;
  end;
  Result := True;

end;

function TMagicManager.MagMakePrivateTransparent(BaseObject: TBaseObject; nHTime: Integer): Boolean; //004930E8
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] > 0 then
    exit; //4930FE
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 9, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do
  begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if TargeTBaseObject = nil then
      continue;
    if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and (TargeTBaseObject.m_TargetCret = BaseObject) then
    begin
      if (abs(TargeTBaseObject.m_nCurrX - BaseObject.m_nCurrX) > 1) or
        (abs(TargeTBaseObject.m_nCurrY - BaseObject.m_nCurrY) > 1) or
        (Random(2) = 0) then
      begin
        TargeTBaseObject.m_TargetCret := nil;
      end;
    end;
  end;
  BaseObjectList.Free;
  BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := nHTime; //004931D2
  BaseObject.m_nCharStatus := BaseObject.GetCharStatus();
  BaseObject.StatusChanged();
  BaseObject.m_boHideMode := True;
  BaseObject.m_boTransparent := True;
  Result := True;
end;

function TMagicManager.MagTamming(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean; //00492368
var
  n14: Integer;
begin
  Result := False;
  if TargeTBaseObject.m_boTishen then
    exit;
  if (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and (TargeTBaseObject.m_btRaceServer <> RC_YSBJECT) and ((Random(4 - nMagicLevel) = 0)) then
  begin
    TargeTBaseObject.m_TargetCret := nil;
    if TargeTBaseObject.m_Master = BaseObject then
    begin
      TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
      Result := True;
    end
    else
    begin
      if Random(1) = 0 then
      begin //2
        if TargeTBaseObject.m_Abil.Level <= BaseObject.m_Abil.Level + 2 then
        begin
          if Random(2) = 0 then
          begin //3
            if Random((BaseObject.m_Abil.Level + 20)) + (nMagicLevel * 5) > (TargeTBaseObject.m_Abil.Level + g_Config.nMagTammingTargetLevel {10}) then
            begin
              if not (TargeTBaseObject.bo2C1) and
                (TargeTBaseObject.m_btLifeAttrib = 0) and
                (TargeTBaseObject.m_Abil.Level < g_Config.nMagTammingLevel {50}) and
                (BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount {(nMagicLevel + 2)}) then
              begin
                n14 := TargeTBaseObject.m_WAbil.MaxHP div g_Config.nMagTammingHPRate {100};
                if n14 <= 2 then
                  n14 := 2
                else
                  Inc(n14, n14);
                if (TargeTBaseObject.m_Master <> BaseObject) and (Random(n14) = 0) then
                begin
                  TargeTBaseObject.BreakCrazyMode();
                  if TargeTBaseObject.m_Master <> nil then
                  begin
                    TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.HP div 10;
                  end;
                  TargeTBaseObject.m_Master := BaseObject;
                  TargeTBaseObject.m_dwMasterRoyaltyTick := LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel shl 2) * 5 + 20) * 60 * 1000) + GetTickCount;


                  if Tplayobject(BaseObject).m_Magic69skill <> nil then
                  begin //兽灵术：06.01.23
                    case Tplayobject(BaseObject).m_Magic69skill.btLevel of
                      0: TargeTBaseObject.m_btSlaveExpLevel := 1;
                      1: TargeTBaseObject.m_btSlaveExpLevel := 2; //怪物等级
                      2: TargeTBaseObject.m_btSlaveExpLevel := 3;
                      3: TargeTBaseObject.m_btSlaveExpLevel := 4;
                    end;
                    if Tplayobject(BaseObject).m_Magic69skill.btLevel < 3 then
                    begin
                      if Tplayobject(BaseObject).m_Magic69skill.MagicInfo.TrainLevel[Tplayobject(BaseObject).m_Magic69skill.btLevel] <= Tplayobject(BaseObject).m_Abil.Level then
                      begin
                        Tplayobject(BaseObject).TrainSkill(Tplayobject(BaseObject).m_Magic69skill, Random(3) + 1);
                        if not Tplayobject(BaseObject).CheckMagicLevelup(Tplayobject(BaseObject).m_Magic69skill) then
                        begin
                          Tplayobject(BaseObject).SendDelayMsg(Tplayobject(BaseObject), RM_MAGIC_LVEXP, 0, Tplayobject(BaseObject).m_Magic69skill.MagicInfo.wMagicId, Tplayobject(BaseObject).m_Magic69skill.btLevel, Tplayobject(BaseObject).m_Magic69skill.nTranPoint, '', 1000);
                        end;
                      end;
                    end;


                  end;

                  TargeTBaseObject.m_btSlaveMakeLevel := nMagicLevel;

                  if TargeTBaseObject.m_dwMasterTick = 0 then
                    TargeTBaseObject.m_dwMasterTick := GetTickCount();
                  TargeTBaseObject.BreakHolySeizeMode();
                  if LongWord(1500 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nWalkSpeed) then
                  begin
                    TargeTBaseObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
                  end;
                  if LongWord(2000 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nNextHitTime) then
                  begin
                    TargeTBaseObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
                  end;
                  TargeTBaseObject.RefShowName();
                  BaseObject.m_SlaveList.Add(TargeTBaseObject);
                end
                else
                begin //004925F2
                  if Random(14) = 0 then
                    TargeTBaseObject.m_WAbil.HP := 0;
                end;
              end
              else
              begin //00492615
                if (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) = 0) then
                  TargeTBaseObject.m_WAbil.HP := 0;
              end;
            end
            else
            begin //00492641
              if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) = 0) then
                TargeTBaseObject.OpenCrazyMode(Random(20) + 10);
            end;
          end
          else
          begin //00492674
            if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
              TargeTBaseObject.OpenCrazyMode(Random(20) + 10); //变红
          end;
        end; //004926B0
      end
      else
      begin //00492699
        TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
      end;
      Result := True;
    end;
  end
  else
  begin
    if Random(1) = 0 then
      Result := True; //2
  end;

end;

function TMagicManager.MagTurnUndead(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nLevel: Integer): Boolean; //004926D4
var
  n14: Integer;
begin
  Result := False;
  if TargeTBaseObject.m_boSuperMan or not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
    exit;
  TAnimalObject(TargeTBaseObject).Struck {FFEC}(BaseObject);
  if TargeTBaseObject.m_TargetCret = nil then
  begin
    TAnimalObject(TargeTBaseObject).m_boRunAwayMode := True;
    TAnimalObject(TargeTBaseObject).m_dwRunAwayStart := GetTickCount();
    TAnimalObject(TargeTBaseObject).m_dwRunAwayTime := 10 * 1000;
  end;
  BaseObject.SetTargetCreat(TargeTBaseObject);
  if (Random(2) + (BaseObject.m_Abil.Level - 1)) > TargeTBaseObject.m_Abil.Level then
  begin
    if TargeTBaseObject.m_Abil.Level < g_Config.nMagTurnUndeadLevel then
    begin
      n14 := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
      if Random(100) < ((nLevel shl 3) - nLevel + 15 + n14) then
      begin
        TargeTBaseObject.SetLastHiter(BaseObject);
        TargeTBaseObject.m_WAbil.HP := 0;
        Result := True;
      end
    end;
  end; //004927CB
end;

{function TMagicManager.MagWindTebo(PlayObject: TPlayObject;     //  狮子吼
  UserMagic: pTUserMagic): Boolean;
var
  PoseBaseObject:TBaseObject;    //   (PlayObject.m_Abil.Level > PoseBaseObject.m_Abil.Level)
begin
  Result:=False;
  PoseBaseObject:=PlayObject.GetPoseCreate;
//  TbaseObject(PlayObject).m_btDirection  :=GetNextDirection(PlayObject.m_nCurrX,PlayObject.m_nCurrY,TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY);
  if (PoseBaseObject <> nil) and   (PoseBaseObject <> PlayObject)   and
     (not PoseBaseObject.m_boDeath) and
     (not PoseBaseObject.m_boGhost) and
     (PlayObject.IsProperTarget(PoseBaseObject)) and
     (not PoseBaseObject.m_boStickMode) then begin
    if (abs(PlayObject.m_nCurrX - PoseBaseObject.m_nCurrX) <= 1) and
       (abs(PlayObject.m_nCurrY - PoseBaseObject.m_nCurrY) <= 1) and
        ((PlayObject.m_Abil.Level > PoseBaseObject.m_Abil.Level) or ((PlayObject.m_Abil.Level = PoseBaseObject.m_Abil.Level)and(PlayObject.m_nfenghaolevel>PoseBaseObject.m_nfenghaolevel)))  then begin
      if Random(20) < UserMagic.btLevel * 6 + 6 + (PlayObject.m_Abil.Level - PoseBaseObject.m_Abil.Level) then begin
        PoseBaseObject.CharPushedX(GetNextDirection(PlayObject.m_nCurrX,PlayObject.m_nCurrY,PoseBaseObject.m_nCurrX,PoseBaseObject.m_nCurrY),_MAX(0,UserMagic.btLevel -1) + 2);
      //  if (PoseBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (playobject.m_btRaceServer = RC_PLAYOBJECT) then begin
      //      PoseBaseObject.SetPKFlag(playobject);
      //    end;
      //  PoseBaseObject.SetLastHiter(PlayObject);
        PoseBaseObject.StruckDamage(UserMagic.btLevel*2+5);
        PoseBaseObject.SendRefMsg(RM_STRUCK,UserMagic.btLevel*2+5, PoseBaseObject.m_WAbil.HP, PoseBaseObject.m_WAbil.MaxHP,Integer(PlayObject),'');
       if PoseBaseObject.m_btRaceServer <> RC_PLAYOBJECT then
           PoseBaseObject.m_dwWalkTick := PoseBaseObject.m_dwWalkTick + 1000    //狮子 怪物卡位 1秒
       else // TPlayObject(PoseBaseObject).MakePosion(POISON_STONE,1,0);
       TPlayObject(PoseBaseObject).m_dwtuzhanMoveTick := GetTickCount() +g_Config.PushTEBOTime;  //人物卡位 1。5



        TbaseObject(PlayObject).m_btDirection :=GetNextDirection(PlayObject.m_nCurrX,PlayObject.m_nCurrY,PoseBaseObject.m_nCurrX,PoseBaseObject.m_nCurrY);
        Result:=True;
      end;
    end;
  end;
end;
}

function TMagicManager.MagWindTebo(PlayObject: TPlayObject; //  狮子吼
  UserMagic: pTUserMagic): Boolean;
  function CanWindTebo(BaseObject: TBaseObject): Boolean; //0x004C30B0
  var
    nC: Integer;
  begin //    (m_Abil.Level > BaseObject.m_Abil.Level)
    Result := False;


    if (BaseObject <> nil) and
      (not BaseObject.m_boDeath) and
      (not BaseObject.m_boGhost) and
      (PlayObject.IsProperTarget(BaseObject)) and
      (not BaseObject.m_boStickMode) and
      ((PlayObject.m_Abil.Level > BaseObject.m_Abil.Level) or (PlayObject.m_Abil.Level = BaseObject.m_Abil.Level) and (PlayObject.m_nfenghaolevel > BaseObject.m_nfenghaolevel))
      then
    begin



      Result := True;
    end;

  end;


var
  PoseBaseObject, BaseObject_30: TBaseObject;
  nX, nY, i: integer;
  pushok: boolean;
begin
  Result := False;
  pushok := false;
  if UserMagic.btLevel >= 3 then
  begin
    PoseBaseObject := PlayObject.GetPoseCreate;

    if CanWindTebo(PoseBaseObject) and
      (abs(PlayObject.m_nCurrX - PoseBaseObject.m_nCurrX) <= 1) and
      (abs(PlayObject.m_nCurrY - PoseBaseObject.m_nCurrY) <= 1) then
    begin

      PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, PlayObject.m_btDirection, 2, nX, nY);
      BaseObject_30 := nil;
      BaseObject_30 := PlayObject.m_PEnvir.GetMovingObject(nX, nY, True);
      if BaseObject_30 = nil then
      begin
        PoseBaseObject.CharPushedX(GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, PoseBaseObject.m_nCurrX, PoseBaseObject.m_nCurrY), 4);
        pushok := true;
      end;
      if (BaseObject_30 <> nil) and CanWindTebo(BaseObject_30) then
      begin
        BaseObject_30.CharPushed(GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, BaseObject_30.m_nCurrX, BaseObject_30.m_nCurrY), 4);
        PoseBaseObject.CharPushedX(GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, PoseBaseObject.m_nCurrX, PoseBaseObject.m_nCurrY), 4);
        pushok := true;
      end;
      if pushok then
      begin
        PoseBaseObject.StruckDamage(UserMagic.btLevel * 2 + 5);
        PoseBaseObject.SendRefMsg(RM_STRUCK, UserMagic.btLevel * 2 + 5, PoseBaseObject.m_WAbil.HP, PoseBaseObject.m_WAbil.MaxHP, Integer(PlayObject), '');
        if PoseBaseObject.m_btRaceServer <> RC_PLAYOBJECT then
          PoseBaseObject.m_dwWalkTick := PoseBaseObject.m_dwWalkTick + 1000 //狮子 怪物卡位 1秒
        else // TPlayObject(PoseBaseObject).MakePosion(POISON_STONE,1,0);
          TPlayObject(PoseBaseObject).m_dwtuzhanMoveTick := GetTickCount() + g_Config.PushTEBOTime; //人物卡位 1。5


      end; //     if pushok then begin

    end;



    exit;
  end;



  PoseBaseObject := PlayObject.GetPoseCreate;


//  TbaseObject(PlayObject).m_btDirection  :=GetNextDirection(PlayObject.m_nCurrX,PlayObject.m_nCurrY,TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY);
  if (PoseBaseObject <> nil) and (PoseBaseObject <> PlayObject) and
    (not PoseBaseObject.m_boDeath) and
    (not PoseBaseObject.m_boGhost) and
    (PlayObject.IsProperTarget(PoseBaseObject)) and
    (not PoseBaseObject.m_boStickMode) then
  begin
    if (abs(PlayObject.m_nCurrX - PoseBaseObject.m_nCurrX) <= 1) and
      (abs(PlayObject.m_nCurrY - PoseBaseObject.m_nCurrY) <= 1) and
      ((PlayObject.m_Abil.Level > PoseBaseObject.m_Abil.Level) or (PlayObject.m_Abil.Level = PoseBaseObject.m_Abil.Level) and (PlayObject.m_nfenghaolevel > PoseBaseObject.m_nfenghaolevel)) then
    begin
      if Random(20) < UserMagic.btLevel * 6 + 6 + (PlayObject.m_Abil.Level - PoseBaseObject.m_Abil.Level) then
      begin
        PoseBaseObject.CharPushedX(GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, PoseBaseObject.m_nCurrX, PoseBaseObject.m_nCurrY), _MAX(0, UserMagic.btLevel - 1) + 2);

        PoseBaseObject.StruckDamage(UserMagic.btLevel * 2 + 5);
        PoseBaseObject.SendRefMsg(RM_STRUCK, UserMagic.btLevel * 2 + 5, PoseBaseObject.m_WAbil.HP, PoseBaseObject.m_WAbil.MaxHP, Integer(PlayObject), '');
        if PoseBaseObject.m_btRaceServer <> RC_PLAYOBJECT then
          PoseBaseObject.m_dwWalkTick := PoseBaseObject.m_dwWalkTick + 1000 //狮子 怪物卡位 1秒
        else // TPlayObject(PoseBaseObject).MakePosion(POISON_STONE,1,0);
          TPlayObject(PoseBaseObject).m_dwtuzhanMoveTick := GetTickCount() + g_Config.PushTEBOTime; //人物卡位 1。5



        TbaseObject(PlayObject).m_btDirection := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, PoseBaseObject.m_nCurrX, PoseBaseObject.m_nCurrY);
        Result := True;
      end;
    end;
  end;


end;

function TMagicManager.MagSaceMove(BaseObject: TBaseObject;
  nLevel: integer): Boolean; //04927D8
var
  Envir: TEnvirnoment;
  PlayObject: TPlayObject;
begin
  Result := False;
  if Random(11) < nLevel * 2 + 4 then
  begin
    BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE2, 0, 0, 0, 0, '');
    if BaseObject is TPlayObject then
    begin
      Envir := BaseObject.m_PEnvir;
      BaseObject.MapRandomMove(BaseObject.m_sHomeMap, 1);
      if (Envir <> BaseObject.m_PEnvir) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then
      begin
        PlayObject := TPlayObject(BaseObject);
        PlayObject.m_boTimeRecall := False;
      end;
    end;
    Result := True;
  end; //00492899
end;

function TMagicManager.MagMonMove(playObject: TplayObject; TargeTBaseObject: Tbaseobject; btlevel: integer): Boolean;

var
  nx, ny: integer;
begin
  result := false;
  if TargeTBaseObject = nil then
    exit;
  if PlayObject.IsProperTarget(TargeTBaseObject) and (PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level) then
  begin
    if (Random(11) <= btLevel * 2 + 5) then
    begin
      if (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) then
      begin //弓箭手 and (TargeTBaseObject.m_btRaceServer < 100)
        playObject.GetFrontPosition(nX, nY);
        if playObject.m_PEnvir.CanWalk(nX, nY, false) then
        begin

          if TargeTBaseObject.m_PEnvir.DeleteFromMap(TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY, OS_MOVINGOBJECT, TargeTBaseObject) = 1 then
          begin
            TargeTBaseObject.SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
            TargeTBaseObject.m_nCurrX := nx;
            TargeTBaseObject.m_nCurrY := ny;
            TargeTBaseObject.m_PEnvir.AddToMap(TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY, OS_MOVINGOBJECT, TargeTBaseObject); //  ,500
                 //   TargeTBaseObject.TurnTo( GetNextDirection(TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY,playObject.m_nCurrX,playObject.m_nCurrY) );
            TargeTBaseObject.SendRefMsg(RM_TURN, GetNextDirection(TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY, playObject.m_nCurrX, playObject.m_nCurrY), TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY, 0, TargeTBaseObject.GetShowName);

                 // TargeTBaseObject.SpaceMove(TargeTBaseObject.m_sMapName,nx,ny,1);
            result := true;
          end;
        end;
            //   TargeTBaseObject.m_PEnvir.DeleteFromMap(TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY,OS_MOVINGOBJECT,TargeTBaseObject);
            //   TargeTBaseObject.m_nCurrX:=playObject.m_nCurrX+1;
            //   TargeTBaseObject.m_nCurrY:=playObject.m_nCurrY+1;
           //    TargeTBaseObject.m_PEnvir.AddToMap(TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY,OS_MOVINGOBJECT,TargeTBaseObject);   //  ,500


      end;
    end
    else
      PlayObject.SysMsg('抓取能力不足', c_Red, t_Hint);


  end;


end;

function TMagicManager.MagbaobaoMove(playObject: TplayObject; TargeTBaseObject: Tbaseobject; btlevel: integer): Boolean;
var
  nx, ny: integer;
  i: integer;
  mon: TBaseObject;
  p28: Pointer;
begin
  p28 := nil;
  result := false;
  if TargeTBaseObject = nil then
  begin
    playObject.GetFrontPosition(nX, nY);
    if not playObject.m_PEnvir.CanWalk(nX, nY, false) then
      exit;
    for i := playObject.m_SlaveList.Count - 1 downto 0 do
    begin
      mon := TBaseObject(playObject.m_SlaveList.Items[i]);

      if (not mon.m_bohorse)and(not mon.m_boPetOnSell) then
      begin
             //   if playObject.m_PEnvir.CanWalk(nX, nY,false) then begin

        if mon.m_PEnvir.DeleteFromMap(mon.m_nCurrX, mon.m_nCurrY, OS_MOVINGOBJECT, mon) = 1 then
        begin
          mon.SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
          mon.m_nCurrX := nx;
          mon.m_nCurrY := ny;
          mon.m_PEnvir := playObject.m_PEnvir;
          mon.SetTargetCreat(nil);

          p28 := playObject.m_PEnvir.AddToMap(mon.m_nCurrX, mon.m_nCurrY, OS_MOVINGOBJECT, mon); //  ,500
          if p28 <> nil then
          begin
            case btlevel of
              0:
                if mon.m_WAbil.HP * 3 < mon.m_WAbil.MaxHP then
                  mon.m_WAbil.HP := mon.m_WAbil.MaxHP div 3;
              1:
                if mon.m_WAbil.HP * 2 < mon.m_WAbil.MaxHP then
                  mon.m_WAbil.HP := mon.m_WAbil.MaxHP div 2;
              2:
                if mon.m_WAbil.HP < mon.m_WAbil.MaxHP * 3 div 4 then
                  mon.m_WAbil.HP := mon.m_WAbil.MaxHP * 3 div 4;
              3:
                if mon.m_WAbil.HP < mon.m_WAbil.MaxHP then
                  mon.m_WAbil.HP := mon.m_WAbil.MaxHP;
            end;

            mon.SendRefMsg(RM_TURN, GetNextDirection(mon.m_nCurrX, mon.m_nCurrY, playObject.m_nCurrX, playObject.m_nCurrY), mon.m_nCurrX, mon.m_nCurrY, 0, mon.GetShowName);
          end;
                //  mon.SpaceMove(playObject.m_sMapName,nx,ny,1);

          result := true;
        end;

                //  end; //if  canwalk
      end; // if not bohorse
    end; //for
    exit;
  end;


  if PlayObject.IsProperTarget(TargeTBaseObject) then
  begin
    for i := playObject.m_SlaveList.Count - 1 downto 0 do
    begin
      mon := TBaseObject(playObject.m_SlaveList.Items[i]);
      if not mon.m_bohorse then
      begin
                 //  mon.Attack(TargeTBaseObject,btDir);
        PlayObject.m_TargetCret := TargeTBaseObject;
        if PlayObject.m_TargetCret.m_PEnvir = PlayObject.m_PEnvir then
        begin
                   //   mon.SetTargetXY(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY); {0FFF0h}
                   //   mon.m_TargetCret:= TargeTBaseObject;
          mon.SetTargetCreat(TargeTBaseObject);
                     //  mon.m_nTargetX:=TargeTBaseObject.m_nCurrX;
                     //  mon.m_nTargetY:=TargeTBaseObject.m_nCurrY;
          result := true;
        end;
      end;
    end;



            //   TargeTBaseObject.m_PEnvir.DeleteFromMap(TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY,OS_MOVINGOBJECT,TargeTBaseObject);
            //   TargeTBaseObject.m_nCurrX:=playObject.m_nCurrX+1;
            //   TargeTBaseObject.m_nCurrY:=playObject.m_nCurrY+1;
           //    TargeTBaseObject.m_PEnvir.AddToMap(TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY,OS_MOVINGOBJECT,TargeTBaseObject);   //  ,500


  end;
  //      end else PlayObject.SysMsg('抓取能力不足',c_Red,t_Hint);


  //      end;


end;

function TMagicManager.MagYSzhskill78(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean; //04927D8  怒斩天下
var
  hum: TplayObject;
  skilltype: integer;
  power,mcpower: integer;
 //    BaseObjectList:Tlist;
  Targe: TBaseObject;
  I: integer;
  FireBurnEvent: TFireBurnEvent;
  m_btDirection: byte;
  nx, ny: integer;
begin
  // hum:=nil;
 //  hum:=UserEngine.GetPlayObjectEx(PlayObject.sYsname);
  hum := playObject.Ysplayer;
  if hum <> nil then
  begin

    skilltype := 0; //怒斩天下  0
    playObject.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');

    hum.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');
    if TargeTBaseObject <> nil then
    begin
        //Result:=True;
      Power := nPower + playObject.GetAttackPower(LoWord(playObject.m_WAbil.DC), SmallInt((HiWord(playObject.m_WAbil.DC) - LoWord(playObject.m_WAbil.DC))));
      Power := Power*g_config.nSkill78PowerRate div 100;
   //   Power := Power + ROUND(Power / 100 * (playObject.m_nHitDouble * 10)); // m_nHitDouble;
      if playObject.IsProperTarget(TargeTBaseObject) then
      begin
        TargeTBaseObject.SendMsg(playObject, RM_MAGSTRUCK, 0, power, 0, 0, '');
        playObject.SetTargetCreat(Targe);
      end;
      Result := True;
      m_btDirection := GetNextDirection(playObject.m_nCurrX, playObject.m_nCurrY, nTargetX, nTargetY);
      for i := 1 to 6 do
      begin
        if playObject.m_PEnvir.GetNextPosition(playObject.m_nCurrX, playObject.m_nCurrY, m_btDirection, i, nX, nY) then
        begin
          Targe := playObject.m_PEnvir.GetMovingObject(nX, nY, True);
          if (Targe <> nil) and playObject.IsProperTarget(Targe) then
          begin
            Targe.SendMsg(playObject, RM_MAGSTRUCK, 0, _max(50 + random(5) * 10, power), 0, 0, '');
            playObject.SetTargetCreat(Targe);
            Result := True;
          end;
        end;
      end; //for
   {   Power := nPower + hum.GetAttackPower(LoWord(hum.m_WAbil.DC), SmallInt((HiWord(hum.m_WAbil.DC) - LoWord(hum.m_WAbil.DC))));

      Power := Power + ROUND(Power / 100 * (hum.m_nHitDouble * 10)); // m_nHitDouble;

      m_btDirection := GetNextDirection(hum.m_nCurrX, hum.m_nCurrY, nTargetX, nTargetY);

      for i := 1 to 6 do
      begin
        if hum.m_PEnvir.GetNextPosition(hum.m_nCurrX, hum.m_nCurrY, m_btDirection, i, nX, nY) then
        begin
          Targe := hum.m_PEnvir.GetMovingObject(nX, nY, True);
          if (Targe <> nil) and hum.IsProperTarget(Targe) then
          begin
            Targe.SendMsg(hum, RM_MAGSTRUCK, 0, _max(50 + random(5) * 10, power), 0, 0, '');
            hum.SetTargetCreat(Targe);
          end;
        end;
      end; //for
      }





     //////
      //  power:= btlevel*50+5 ;
      //  TargeTBaseObject.StruckDamage(power);
     //   TargeTBaseObject.SendRefMsg(RM_STRUCK,power, TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP,Integer(PlayObject),'');
    end; //<>nil
  end;
end;

function TMagicManager.MagYSzhskill79(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean; //04927D8  怒斩天下
var
  hum: TplayObject;
  skilltype: integer;
  power, mcpower: integer;
  BaseObjectList: Tlist;
  Targe: TBaseObject;
  I: integer;
  FireBurnEvent: TFireBurnEvent;
begin
  // hum:=nil;
 //  hum:=UserEngine.GetPlayObjectEx(PlayObject.sYsname);
  hum := playObject.Ysplayer;
  if hum <> nil then
  begin
    skilltype := 0; //天怒惊雷  0
    playObject.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');

    hum.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');
    if TargeTBaseObject <> nil then
    begin
      power := nPower;
       Power := Power*g_config.nSkill79PowerRate div 100;
      BaseObjectList := Tlist.Create;
      playObject.GetMapBaseObjects(TargeTBaseObject.m_PEnvir, nTargetX, nTargetY, 2, BaseObjectList);
      for I := 0 to BaseObjectList.Count - 1 do
      begin
        Targe := TBaseObject(BaseObjectList.Items[i]);
        if Targe = nil then
          continue;
        if playObject.IsProperTarget(Targe) then
        begin
          playObject.SetTargetCreat(Targe);
          Targe.SendMsg(playObject, RM_MAGSTRUCK, 0, _max(50 + random(5) * 10, power), 0, 0, '');
          Result := True;
        end;
      end;
      BaseObjectList.Free;
      //   mcpower:= loword( hum.m_WAbil.mC)+  HiWord(hum.m_WAbil.mC)-LoWord(hum.m_WAbil.mC);
      mcpower := hum.GetAttackPower(LoWord(hum.m_WAbil.MC), SmallInt(HiWord(hum.m_WAbil.MC) - LoWord(hum.m_WAbil.MC)) + 1);


      if playObject.IsProperTarget(TargeTBaseObject) then
      begin
        TargeTBaseObject.StruckDamage(_max(50 + random(5) * 10, mcpower));
        TargeTBaseObject.SendRefMsg(RM_STRUCK, mcpower, TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, Integer(PlayObject), '');
      end;
    end;
  end;
end;
//纵雷诀
function TMagicManager.MagYSzhskill93(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean; //04927D8  怒斩天下
var
  hum: TplayObject;
  skilltype: integer;
  power, mcpower: integer;
  BaseObjectList: Tlist;
  Targe: TBaseObject;
  I: integer;
  FireBurnEvent: TFireBurnEvent;
begin




  //  if TargeTBaseObject <> nil then
    begin
      power := nPower;
       Power := Power*2;
      BaseObjectList := Tlist.Create;
      playObject.GetMapBaseObjects(playObject.m_PEnvir, nTargetX, nTargetY, 2, BaseObjectList);
      for I := 0 to BaseObjectList.Count - 1 do
      begin
        Targe := TBaseObject(BaseObjectList.Items[i]);
        if Targe = nil then
          continue;
        if playObject.IsProperTarget(Targe) then
        begin
          playObject.SetTargetCreat(Targe);
          Targe.SendMsg(playObject, RM_MAGSTRUCK, 0, _max(50 + random(5) * 10, power), 0, 0, '');
          Result := True;
        end;
      end;
      BaseObjectList.Free;

    end;

end;
function TMagicManager.MagYSzhskill80(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean; //04927D8  怒斩天下
var
  hum: TplayObject;
  skilltype: integer;
  power, scpower: integer;
  BaseObjectList: Tlist;
  Targe: TBaseObject;
  I: integer;
  FireBurnEvent: TFireBurnEvent;
begin
  // hum:=nil;
 //  hum:=UserEngine.GetPlayObjectEx(PlayObject.sYsname);
  hum := playObject.Ysplayer;
  if hum <> nil then
  begin
    skilltype := 0; //天女散花 0
    playObject.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');

    hum.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');
    if TargeTBaseObject <> nil then
    begin
      power := nPower;

      scpower := hum.GetAttackPower(LoWord(hum.m_WAbil.sC), SmallInt(HiWord(hum.m_WAbil.sC) - LoWord(hum.m_WAbil.sC)) + 1);
       Power := Power*g_config.nSkill80PowerRate div 100;

      BaseObjectList := Tlist.Create;
      playObject.GetMapBaseObjects(TargeTBaseObject.m_PEnvir, nTargetX, nTargetY, 2, BaseObjectList);
      for I := 0 to BaseObjectList.Count - 1 do
      begin
        Targe := TBaseObject(BaseObjectList.Items[i]);
        if Targe = nil then
          continue;
        if playObject.IsProperTarget(Targe) then
        begin
          playObject.SetTargetCreat(Targe);
          Targe.SendMsg(playObject, RM_MAGSTRUCK, 0, _max(50 + random(5) * 10, power), 0, 0, '');

          Targe.MakePosion(POISON_DECHEALTH, _max(5, loword(hum.m_WAbil.sC)), _max(5, scpower));
          Result := True;
        end;
      end;
      BaseObjectList.Free;
      if playObject.IsProperTarget(TargeTBaseObject) then
      begin
        scpower := _max(50 + random(5) * 10, scpower);
         SCPower := ScPower*g_config.nSkill79PowerRate div 100;
        TargeTBaseObject.StruckDamage(scpower);
        TargeTBaseObject.SendRefMsg(RM_STRUCK, scpower, TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, Integer(PlayObject), '');
      end;
    end;
  end;
end;

function TMagicManager.MagYSzhskill81(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean; //04927D8  怒斩天下
var
  hum: TplayObject;
  skilltype: integer;
  power, mcpower: integer;
  BaseObjectList: Tlist;
  Targe: TBaseObject;
  I: integer;
  FireBurnEvent: TFireBurnEvent;
begin
  // hum:=nil;
 //  hum:=UserEngine.GetPlayObjectEx(PlayObject.sYsname);
  hum := playObject.Ysplayer;
  if hum <> nil then
  begin
    skilltype := 0; //迷光烈焰 0
    playObject.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');

    hum.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');
    if TargeTBaseObject <> nil then
    begin
      if hum.m_btJob = 1 then
        mcpower := nPower + hum.GetAttackPower(LoWord(hum.m_WAbil.DC), SmallInt((HiWord(hum.m_WAbil.DC) - LoWord(hum.m_WAbil.DC))))
      else
        mcpower := nPower + hum.GetAttackPower(LoWord(hum.m_WAbil.MC), SmallInt(HiWord(hum.m_WAbil.MC) - LoWord(hum.m_WAbil.MC)) + 1);

      if playObject.m_btJob = 2 then
        Power := nPower + hum.GetAttackPower(LoWord(hum.m_WAbil.MC), SmallInt(HiWord(hum.m_WAbil.MC) - LoWord(hum.m_WAbil.MC)) + 1)
      else
        Power := nPower + playObject.GetAttackPower(LoWord(playObject.m_WAbil.DC), SmallInt((HiWord(playObject.m_WAbil.DC) - LoWord(playObject.m_WAbil.DC))));

       Power := Power*g_config.nSkill81PowerRate div 100;
      BaseObjectList := Tlist.Create;
      playObject.GetMapBaseObjects(TargeTBaseObject.m_PEnvir, nTargetX, nTargetY, 2, BaseObjectList);
      for I := 0 to BaseObjectList.Count - 1 do
      begin
        Targe := TBaseObject(BaseObjectList.Items[i]);
        if Targe = nil then
          continue;
        if playObject.IsProperTarget(Targe) then
        begin
          playObject.SetTargetCreat(Targe);
          Targe.SendMsg(playObject, RM_MAGSTRUCK, 0, _max(50 + random(5) * 10, power), 0, 0, '');
          Result := True;
        end;
      end;
      BaseObjectList.Free;





     //////
      //  power:= btlevel*50+5 ;
      if playObject.IsProperTarget(TargeTBaseObject) then
      begin
        mcpower := _max(50 + random(5) * 10, mcpower);
        TargeTBaseObject.StruckDamage(mcpower);
        TargeTBaseObject.SendRefMsg(RM_STRUCK, mcpower, TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, Integer(PlayObject), '');
      end;
    end;
  end;
end;

function TMagicManager.MagYSzhskill83(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean; //04927D8  怒斩天下
var
  hum: TplayObject;
  skilltype: integer;
  power, mcpower: integer;
  BaseObjectList: Tlist;
  Targe: TBaseObject;
  I: integer;
  FireBurnEvent: TFireBurnEvent;
begin
  // hum:=nil;
 //  hum:=UserEngine.GetPlayObjectEx(PlayObject.sYsname);
  hum := playObject.Ysplayer;
  if hum <> nil then
  begin
    skilltype := 0; //火毒攻心剑  //战道
    playObject.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');

    hum.SendRefMsg(RM_YSSKILL, Integer(playObject), integer(TargeTBaseObject), makelong(nTargetX, nTargetY), integer(hum), '');
    if TargeTBaseObject <> nil then
    begin
      if hum.m_btJob = 1 then
        mcpower := nPower + hum.GetAttackPower(LoWord(hum.m_WAbil.DC), SmallInt((HiWord(hum.m_WAbil.DC) - LoWord(hum.m_WAbil.DC))))
      else
        mcpower := nPower + hum.GetAttackPower(LoWord(hum.m_WAbil.sC), SmallInt(HiWord(hum.m_WAbil.sC) - LoWord(hum.m_WAbil.sC)) + 1);

      if playObject.m_btJob = 3 then
        Power := nPower + hum.GetAttackPower(LoWord(hum.m_WAbil.sC), SmallInt(HiWord(hum.m_WAbil.sC) - LoWord(hum.m_WAbil.sC)) + 1)
      else
        Power := nPower + playObject.GetAttackPower(LoWord(playObject.m_WAbil.DC), SmallInt((HiWord(playObject.m_WAbil.DC) - LoWord(playObject.m_WAbil.DC))));

      McPower := MCPower*g_config.nSkill83PowerRate div 100;

      BaseObjectList := Tlist.Create;
      playObject.GetMapBaseObjects(TargeTBaseObject.m_PEnvir, nTargetX, nTargetY, 2, BaseObjectList);
      for I := 0 to BaseObjectList.Count - 1 do
      begin
        Targe := TBaseObject(BaseObjectList.Items[i]);
        if Targe = nil then
          continue;
        if playObject.IsProperTarget(Targe) then
        begin
          playObject.SetTargetCreat(Targe);
          Targe.SendMsg(playObject, RM_MAGSTRUCK, 0, _max(50 + random(5) * 10, mcpower), 0, 0, '');
          Result := True;
             //中毒效果
             btlevel:=Random(2)+1;
             case btlevel of
                  1:
                    begin


                      Targe.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, 10, Integer(PlayObject), 10 {UserMagic.btLevel}, '', 1000);
                    end;
                  2:
                    begin //00493FE9
//

                      Targe.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {中毒类型 - 红毒}, 10, Integer(PlayObject),10 {UserMagic.btLevel}, '', 1000);
                    end;
                end; //0049403C

        end;
      end;
      BaseObjectList.Free;
           //  if ntype=73 then begin     //如果是流星火雨
               // nHTime:= (BaseObject.m_WAbil.Level div 10)*4+random(5);





     //////
      //  power:= btlevel*50+5 ;
      if playObject.IsProperTarget(TargeTBaseObject) then
      begin
        power := _max(50 + random(5) * 10, power);
        TargeTBaseObject.StruckDamage(power);
        TargeTBaseObject.SendRefMsg(RM_STRUCK, power, TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, Integer(PlayObject), '');
      end
    end;
      if playObject.m_PEnvir.GetEvent(nTargetX, nTargetY) = nil then
      begin
        FireBurnEvent := TFireBurnEvent.Create(playObject, nTargetX, nTargetY, 23, _max(5, loword(hum.m_WAbil.sC)) * 1000, Power);
        g_EventManager.AddEvent(FireBurnEvent);
      end; //0492CFC   x
    
  end;
end;
//毒凌波
function TMagicManager.MagYSzhskill94(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel, nPower: integer): Boolean; //04927D8  怒斩天下
var

  skilltype: integer;
  power: integer;
//  BaseObjectList: Tlist;
//  Targe: TBaseObject;
  I: integer;
  FireBurnEvent: TFireBurnEvent;
begin
     // mcpower := nPower + playObject.GetAttackPower(LoWord(playObject.m_WAbil.sC), SmallInt(HiWord(playObject.m_WAbil.sC) - LoWord(playObject.m_WAbil.sC)) + 1);
//      BaseObjectList := Tlist.Create;
//      playObject.GetMapBaseObjects(playObject.m_PEnvir, nTargetX, nTargetY, 4, BaseObjectList);
//      for I := 0 to BaseObjectList.Count - 1 do
//      begin
//        Targe := TBaseObject(BaseObjectList.Items[i]);
//        if Targe = nil then
//          continue;
//        if playObject.IsProperTarget(Targe) then
//        begin
//             //中毒效果
//             case btlevel of
//                  1:
//                    begin
//
//                      nPower:=Round(nPower*1.5);
//                      Targe.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(PlayObject), nPower {UserMagic.btLevel}, '', 1000);
//                    end;
//                  2:
//                    begin //00493FE9
////
//                     nPower:=Round(nPower*1.5);
//                      Targe.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower, Integer(PlayObject),nPower {UserMagic.btLevel}, '', 1000);
//                    end;
//                end; //0049403C
//              //道术伤害
//             Targe.SendMsg(playObject, RM_MAGSTRUCK, 0, _max(50 + random(5) * 10, npower), 0, 0, '');
//             if (Targe <> nil) and
//      (not Targe.m_boDeath) and
//      (not Targe.m_boGhost) and
//      (PlayObject.IsProperTarget(Targe)) and
//      (not Targe.m_boStickMode) and
//      ((PlayObject.m_Abil.Level > Targe.m_Abil.Level) or (PlayObject.m_Abil.Level = Targe.m_Abil.Level) and (PlayObject.m_nfenghaolevel > Targe.m_nfenghaolevel))
//      then
//             Targe.CharPushedX(GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, Targe.m_nCurrX, Targe.m_nCurrY), Random(4)+1);
//        end;
//      end;
//      BaseObjectList.Free;

   if TargeTBaseObject <> nil then
   begin
       if playObject.IsProperTarget(TargeTBaseObject) then
        begin
             //中毒效果
             btlevel:=Random(2)+1;
             case btlevel of
                  1:
                    begin

                      nPower:=Round(nPower*1.5);
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(PlayObject), nPower {UserMagic.btLevel}, '', 1000);
                    end;
                  2:
                    begin //00493FE9
//
                     nPower:=Round(nPower*1.5);
                      TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower, Integer(PlayObject),nPower {UserMagic.btLevel}, '', 1000);
                    end;
                end; //0049403C
              //道术伤害
             TargeTBaseObject.SendMsg(playObject, RM_MAGSTRUCK, 0, _max(50 + random(5) * 10, npower), 0, 0, '');
             if (TargeTBaseObject <> nil) and
      (not TargeTBaseObject.m_boDeath) and
      (not TargeTBaseObject.m_boGhost) and
      (PlayObject.IsProperTarget(TargeTBaseObject)) and
      (not TargeTBaseObject.m_boStickMode) and
      ((PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level) or (PlayObject.m_Abil.Level = TargeTBaseObject.m_Abil.Level) and (PlayObject.m_nfenghaolevel > TargeTBaseObject.m_nfenghaolevel))
      then
             TargeTBaseObject.CharPushedX(GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY), Random(4)+1);
        end;
   end;
end;
function TMagicManager.MagYSzhskill85(playObject: TplayObject; nTargetX, nTargetY: Integer; TargeTBaseObject: Tbaseobject; btlevel: integer): Boolean; //04927D8  怒斩天下
var

  bossmon: TBaseObject;
  sMonName: string;
  nMakelevel, nExpLevel: Integer;
  dwRoyaltySec: dword;
  bebosstime: Integer;
  montype, nCount: Integer;
  scallboss1: string;
  scallboss2: string;
  scallboss3: string;
  scallboss4: string;
  scallboss5: string;

begin
  if playObject.m_hasFsBoss then
    exit;
  scallboss1 := '蛇妖王';
  scallboss2 := '禁地魔王';
  scallboss3 := '通天教主';
  scallboss4 := '铁血魔王';
  scallboss5 := '阿修罗神';
  nMakelevel := btlevel;
  nExpLevel := btlevel;
  nCount := 10;
  sMonName := '通天教主';
  bebosstime := btlevel * 5 + 10;

  montype := random(10);
  case btlevel of
    0:
      begin
        if montype < 8 then
          sMonName :=g_Config.sSkill85Mon1
        else
          sMonName := g_Config.sSkill85Mon2;
      end;
    1:
      begin
        if montype < 4 then
          sMonName := g_Config.sSkill85Mon2
        else
          if montype < 7 then
            sMonName := g_Config.sSkill85Mon3
          else
            sMonName := g_Config.sSkill85Mon4;
      end;
    2:
      begin
        if montype < 3 then
          sMonName := g_Config.sSkill85Mon2
        else
          if montype < 5 then
            sMonName := g_Config.sSkill85Mon3
          else
            sMonName :=g_Config.sSkill85Mon4;
      end;
    3:
      begin
        if montype < 4 then
          sMonName := g_Config.sSkill85Mon5
        else
          if montype < 8 then
            sMonName := g_Config.sSkill85Mon3
          else
            sMonName := g_Config.sSkill85Mon4;
      end;
  end;
  dwRoyaltySec := 24 * 24 * 60 * 60 * 1000;
  bossmon := PlayObject.MakeSlave(sMonName, nMakelevel, nExpLevel, nCount, dwRoyaltySec);
  if bossmon <> nil then
  begin
    bossmon.m_isBeFsBoss := TRUE;
    playObject.m_hasFsBoss := TRUE;
    bossmon.m_befsBossTime := bebosstime * 1000; //秒
    bossmon.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := bebosstime * 1000; //004931D2
    bossmon.m_nCharStatus := bossmon.GetCharStatus();
    bossmon.StatusChanged();
    bossmon.m_boTransparent := True;
    Result := true;
  end;
end;

function TMagicManager.MagSpyMove(playObject: TplayObject;
  nTargetX, nTargetY: integer; btLevel: integer; ntype: integer): Boolean; //04927D8
var
  nflag: integer;
 // Envir      :TEnvirnoment;
 // PlayObject :TPlayObject;
begin
  Result := False; //RM_SPACEMOVE_SHOW2     RM_SPYMOVE
  if playobject.m_PEnvir.m_boNOBATFLY then
  begin //如果地图不允许使用
    PlayObject.SysMsg('这里不能使用', c_Red, t_Hint);
    exit;
  end;
  if Random(btLevel * 2 + 9) > 1 then
  begin
    with PlayObject do
    begin
      if m_PEnvir.CanWalk(nTargetX, nTargetY, false) then
      begin
        nflag := ntype;
        if nflag = 35 then
          nflag := 0;

          //    if playObject.m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, playObject, nTargetX, nTargetY, False) > 0  then  begin



        if m_PEnvir.DeleteFromMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, PlayObject) = 1 then
        begin
          m_nCurrX := nTargetX;
          m_nCurrY := nTargetY;
          m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_MOVINGOBJECT, PlayObject); //  ,500
          SendRefMsg(RM_SPYMOVE, makeword(PlayObject.m_btDirection, nflag), nTargetX, nTargetY, makelong(m_nCurrX, m_nCurrY), '');


          Result := True;
        end
        else
         PlayObject.SysMsg('目标点不能到达1', c_Red, t_Hint);

            //  end;

      end
      else
        PlayObject.SysMsg('目标点不能到达', c_Red, t_Hint);
    end; //with

  end // if 1
  else
  begin
    PlayObject.SysMsg('技能使用失败', c_Red, t_Hint);
  end;

  if not Result then
    playObject.SendRefMsg(RM_TURN, GetNextDirection(playObject.m_nCurrX, playObject.m_nCurrY, nTargetX, nTargetY), playObject.m_nCurrX, playObject.m_nCurrY, 0, playObject.GetShowName); //''
end;


function TMagicManager.MagGroupAmyounsul(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
  StdItem: pTStdItem;
  nAmuletIdx: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do
  begin
    BaseObject := TBaseObject(BaseObjectList.Items[I]);
    if BaseObject = nil then
      continue;
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then
    begin
      if CheckAmulet(PlayObject, 1, 2, nAmuletIdx) then
      begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
        if StdItem <> nil then
        begin
          UseAmulet(PlayObject, 1, 2, nAmuletIdx);
          if Random(BaseObject.m_btAntiPoison + 7) <= 6 then
          begin
            case StdItem.Shape of
              1:
                begin
                  nPower := GetPower13(40, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                  BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                end;
              2:
                begin
                  nPower := GetPower13(30, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                  BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {中毒类型 - 红毒}, nPower, Integer(PlayObject), ROUND(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)) {UserMagic.btLevel}, '', 1000);
                end;
            end;
            if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer >= RC_ANIMAL) then
              Result := True;
            BaseObject.SetLastHiter(PlayObject);
            PlayObject.SetTargetCreat(BaseObject);
          end;
        end;
      end;
    end;
  end;
  BaseObjectList.Free;
end;


function TMagicManager.MagGroupDeDing(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do
  begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject = nil then
      continue;
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then
    begin
      nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.DC), SmallInt((HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC))));
      if (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then
      begin
        nPower := 0;
      end;
      if nPower > 0 then
      begin
        nPower := BaseObject.GetHitStruckDamage(PlayObject, nPower);
      end;
      if nPower > 0 then
      begin //004C21FC
        BaseObject.StruckDamage(nPower);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 1, Integer(BaseObject), '', 200);
      end;
      if BaseObject.m_btRaceServer >= RC_ANIMAL then
        Result := True;
    end;
    PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 1, '');
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagGroupLightening(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  Result := False;
  boSpellFire := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
    MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
    MakeLong(nTargetX, nTargetY),
    Integer(TargeTBaseObject),
    '');
  for I := 0 to BaseObjectList.Count - 1 do
  begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject = nil then
      continue;
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then
    begin
      if (Random(10) >= BaseObject.m_nAntiMagic) then
      begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        if BaseObject.m_btLifeAttrib = LA_UNDEAD then
          nPower := ROUND(nPower * 1.5);

        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 600);
        if BaseObject.m_btRaceServer >= RC_ANIMAL then
          Result := True;
      end;
      if (BaseObject.m_nCurrX <> nTargetX) or (BaseObject.m_nCurrY <> nTargetY) then
        PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 4 {type}, '');
    end;
  end;
  BaseObjectList.Free;
end;


function TMagicManager.MagGroupwind(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  Result := False;
  boSpellFire := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
    MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
    MakeLong(nTargetX, nTargetY),
    Integer(TargeTBaseObject),
    '');
  for I := 0 to BaseObjectList.Count - 1 do
  begin
    BaseObject := TBaseObject(BaseObjectList.Items[i]);
    if BaseObject = nil then
      continue;
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then
    begin
      if (Random(10) >= BaseObject.m_nAntiMagic) then
      begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        if BaseObject.m_btLifeAttrib = LA_UNDEAD then
          nPower := ROUND(nPower * 1.5);

        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 600);
        if BaseObject.m_btRaceServer >= RC_ANIMAL then
          Result := True;
      end;
      if (BaseObject.m_nCurrX <> nTargetX) or (BaseObject.m_nCurrY <> nTargetY) then
      begin
        PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 4 {type}, '');
        if PlayObject.m_Abil.Level > BaseObject.m_Abil.Level then
          BaseObject.CharPushed(GetNextDirection(BaseObject.m_nCurrX, BaseObject.m_nCurrY, nTargetX, nTargetY), _MIN(abs(nTargetX - BaseObject.m_nCurrX), abs(nTargety - BaseObject.m_nCurry)));

      end;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagHbFireBall(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargetBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  nDir: Integer;
  levelgap: Integer;
  push: Integer;
begin
  Result := False;
  if not PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargetBaseObject) then
  begin
    TargeTBaseObject := nil;
    exit;
  end;
  if not PlayObject.IsProperTarget(TargeTBaseObject) then
  begin
    TargeTBaseObject := nil;
    exit;
  end;
  if (TargeTBaseObject.m_nAntiMagic > Random(10)) or (abs(TargeTBaseObject.m_nCurrX - nTargetX) > 1) or (abs(TargeTBaseObject.m_nCurrY - nTargetY) > 1) then
  begin
    TargeTBaseObject := nil;
    exit;
  end;
  with PlayObject do
  begin
    nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.MC),
      SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
  end;
  PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
  if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
    Result := True;

  if (PlayObject.m_Abil.Level > TargetBaseObject.m_Abil.Level) and (not TargetBaseObject.m_boStickMode) then
  begin
    levelgap := PlayObject.m_Abil.Level - TargetBaseObject.m_Abil.Level;
    if (Random(20) < 6 + UserMagic.btLevel * 3 + levelgap) then
    begin
      push := Random(UserMagic.btLevel) - 1;
      if push > 0 then
      begin
        nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargetBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYPUSHED, nDir, MakeLong(nTargetX, nTargetY), push, Integer(TargeTBaseObject), '', 600);
      end;
    end;
  end;
end;

//火墙

function TMagicManager.MagMakeFireCross(PlayObject: TPlayObject; nDamage,
  nHTime, nX, nY: Integer): Integer; //00492C9C
var
  FireBurnEvent: TFireBurnEvent;
resourcestring
  sDisableInSafeZoneFireCross = '安全区不允许使用...';
begin
  Result := 0;
  if g_Config.boDisableInSafeZoneFireCross and PlayObject.InSafeZone(PlayObject.m_PEnvir, nX, nY) then
  begin
    PlayObject.SysMsg(sDisableInSafeZoneFireCross, c_Red, t_Notice);
    exit;
  end;
  if PlayObject.m_PEnvir.GetEvent(nX, nY - 1) = nil then
  begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY - 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492CFC   x
  if PlayObject.m_PEnvir.GetEvent(nX - 1, nY) = nil then
  begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492D4D
  if PlayObject.m_PEnvir.GetEvent(nX, nY) = nil then
  begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492D9C
  if PlayObject.m_PEnvir.GetEvent(nX + 1, nY) = nil then
  begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492DED
  if PlayObject.m_PEnvir.GetEvent(nX, nY + 1) = nil then
  begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY + 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492E3E
  Result := 1;
end;

function TMagicManager.MagBigExplosion(BaseObject: TBaseObject; nPower, nHTime, nX,
  nY: Integer; nRage: Integer; ntype: Integer): Boolean; //00492F4C
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  FireBurnEvent: TFireBurnEvent;
   // nHTime:integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do
  begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if TargeTBaseObject = nil then
      continue;
    if BaseObject.IsProperTarget(TargeTBaseObject) then
    begin
      BaseObject.SetTargetCreat(TargeTBaseObject);
      TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
      Result := True;
    end;
  end;
  BaseObjectList.Free;
  if ntype = 73 then
  begin //如果是流星火雨
   // nHTime:= (BaseObject.m_WAbil.Level div 10)*4+random(5);
    if BaseObject.m_PEnvir.GetEvent(nX, nY - 1) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX, nY - 1, 22, nHTime * 1000, nPower);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //0492CFC   x
    if BaseObject.m_PEnvir.GetEvent(nX - 1, nY) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX - 1, nY, 22, nHTime * 1000, nPower);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //0492D4D
    if BaseObject.m_PEnvir.GetEvent(nX, nY) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX, nY, 22, nHTime * 1000, nPower);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //00492D9C
    if BaseObject.m_PEnvir.GetEvent(nX + 1, nY) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX + 1, nY, 22, nHTime * 1000, nPower);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //00492DED
    if BaseObject.m_PEnvir.GetEvent(nX, nY + 1) = nil then
    begin
      FireBurnEvent := TFireBurnEvent.Create(BaseObject, nX, nY + 1, 22, nHTime * 1000, nPower);
      g_EventManager.AddEvent(FireBurnEvent);
    end; //00492E3E

  end;



end;

function TMagicManager.MagElecBlizzard(BaseObject: TBaseObject;
  nPower: integer): Boolean; //00493010
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  nPowerPoint: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY, g_Config.nElecBlizzardRange {2}, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do
  begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
    if TargeTBaseObject = nil then
      continue;
    if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
    begin
      nPowerPoint := nPower div 2;
    end
    else
      nPowerPoint := nPower;

    if BaseObject.IsProperTarget(TargeTBaseObject) then
    begin
      //BaseObject.SetTargetCreat(TargeTBaseObject);
      TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPowerPoint, 0, 0, '');
      Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

function TMagicManager.MagMakeHolyCurtain(BaseObject: TBaseObject; nPower: Integer; nX, nY: Integer): Integer; //004928C0
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  MagicEvent: pTMagicEvent;
  HolyCurtainEvent: THolyCurtainEvent;
begin
  Result := 0;
  if BaseObject.m_PEnvir.CanWalk(nX, nY, True) then
  begin
    BaseObjectList := TList.Create;
    MagicEvent := nil;
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, 1, BaseObjectList);
    for I := 0 to BaseObjectList.Count - 1 do
    begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
      if TargeTBaseObject = nil then
        continue;
      if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and
        ((Random(4) + (BaseObject.m_Abil.Level - 1)) > TargeTBaseObject.m_Abil.Level) and
         {(TargeTBaseObject.m_Abil.Level < 50) and}
      (TargeTBaseObject.m_Master = nil) then
      begin
        TargeTBaseObject.OpenHolySeizeMode(nPower * 1000);
        if MagicEvent = nil then
        begin
          New(MagicEvent);
          FillChar(MagicEvent^, SizeOf(TMagicEvent), #0);
          MagicEvent.BaseObjectList := TList.Create;
          MagicEvent.dwStartTick := GetTickCount();
          MagicEvent.dwTime := nPower * 1000;
        end;
        MagicEvent.BaseObjectList.Add(TargeTBaseObject);
        Inc(Result);
      end
      else
      begin //00492A02
        Result := 0;
      end;
    end;
    BaseObjectList.Free;
    if (Result > 0) and (MagicEvent <> nil) then
    begin
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 1, nY - 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[0] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 1, nY - 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[1] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 2, nY - 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[2] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 2, nY - 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[3] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 2, nY + 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[4] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 2, nY + 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[5] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 1, nY + 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[6] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 1, nY + 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[7] := HolyCurtainEvent;
      UserEngine.m_MagicEventList.Add(MagicEvent);
    end
    else
    begin
      if MagicEvent <> nil then
      begin
        MagicEvent.BaseObjectList.Free;
        Dispose(MagicEvent);
      end;
    end;
  end;
end;

function TMagicManager.MagMakeGroupTransparent(BaseObject: TBaseObject; nX, nY,
  nHTime: Integer): Boolean; //0049320C
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do
  begin
    TargeTBaseObject := TBaseObject(BaseObjectList.Items[i]);
    if TargeTBaseObject = nil then
      continue;
    if BaseObject.IsProperFriend(TargeTBaseObject) then
    begin
      if TargeTBaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] = 0 then
      begin //00493287
        TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_TRANSPARENT, 0, nHTime, 0, 0, '', 800);
        Result := True;
      end;
    end
  end;
  BaseObjectList.Free;
end;
//=====================================================================================
//名称：
//功能：
//参数：
//     BaseObject       魔法发起人
//     TargeTBaseObject 受攻击角色
//     nPower           魔法力大小
//     nLevel           技能修炼等级
//     nTargetX         目标座标X
//     nTargetY         目标座标Y
//返回值：
//=====================================================================================

function TMagicManager.MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel,
  nTargetX, nTargetY: Integer): Boolean;
var
  nLv: Integer;
begin
  Result := False;
  if BaseObject.MagCanHitTarget(BaseObject.m_nCurrX, BaseObject.m_nCurrY, TargeTBaseObject) then
  begin
    if BaseObject.IsProperTarget(TargeTBaseObject) then
    begin
      if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then
      begin
        BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower div 3, MakeLong(nTargetX, nTargetY), 2, integer(TargeTBaseObject), '', 600);
        if (Random(2) + (BaseObject.m_Abil.Level - 1)) > TargeTBaseObject.m_Abil.Level then
        begin
          nLv := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
          if (Random(g_Config.nMabMabeHitRandRate {100}) < _MAX(g_Config.nMabMabeHitMinLvLimit, (nLevel * 8) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then
          begin
         // if (Random(100) < ((nLevel shl 3) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
            if (Random(g_Config.nMabMabeHitSucessRate {21}) < nLevel * 2 + 4) then
            begin
              if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then
              begin
                BaseObject.SetPKFlag(BaseObject);
                BaseObject.SetTargetCreat(TargeTBaseObject);
              end;
              TargeTBaseObject.SetLastHiter(BaseObject);
              nPower := TargeTBaseObject.GetMagStruckDamage(BaseObject, nPower);
              BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, integer(TargeTBaseObject), '', 600);
              if not TargeTBaseObject.m_boUnParalysis then
                TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE {中毒类型 - 麻痹}, nPower div g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel), Integer(BaseObject), nLevel, '', 650);
              Result := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMagicManager.MagMakePowerSlave(PlayObject: TPlayObject;
  UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakelevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
begin
  Result := False;
  for i := PlayObject.m_SlaveList.Count - 1 downto 0 do
    if TBaseObject(PlayObject.m_SlaveList.Items[i]).m_boBoneFamm or TBaseObject(PlayObject.m_SlaveList.Items[i]).m_boDog then
    begin exit;
    end;

  if not PlayObject.sub_4DD704 then
  begin
    sMonName := g_Config.sSuperBoneFamm; //'强化骷髅';
    nMakelevel := UserMagic.btLevel+PlayObject.m_btMobSlaveLevel;
    nExpLevel := UserMagic.btLevel;
    if Checktianxuan(PlayObject) then
      nExpLevel := 5;
    nCount := g_Config.nSuperBoneFammCount; // 2;
    dwRoyaltySec := 24 * 24 * 60 * 60;
    for I := Low(g_Config.SuperBoneFammArray) to High(g_Config.SuperBoneFammArray) do
    begin
      if g_Config.SuperBoneFammArray[I].nHumLevel = 0 then
        break;
      if PlayObject.m_Abil.Level >= g_Config.SuperBoneFammArray[I].nHumLevel then
      begin
        sMonName := g_Config.SuperBoneFammArray[I].sMonName;
        nExpLevel := g_Config.SuperBoneFammArray[I].nLevel;
        nCount := g_Config.SuperBoneFammArray[I].nCount;
      end;
    end;

    if PlayObject.MakeSlave(sMonName, nMakelevel, nExpLevel, nCount, dwRoyaltySec) <> nil then
      if PlayObject.MakeSlave(sMonName, nMakelevel, nExpLevel, nCount, dwRoyaltySec) <> nil then
        Result := True;
  end;
end;


function TMagicManager.MagMakeSinSuSlave(PlayObject: TPlayObject;
  UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakelevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  mon: Tbaseobject;
begin
  Result := False;
  if not PlayObject.sub_4DD704 then
  begin
    sMonName := g_Config.sDogz;
    nMakelevel := UserMagic.btLevel+PlayObject.m_btMobSlaveLevel;
    nExpLevel := UserMagic.btLevel;
    if Checktianxuan(PlayObject) then
      nExpLevel := 5;
    nCount := g_Config.nDogzCount;
    dwRoyaltySec := 24 * 24 * 60 * 60;
    for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do
    begin
      if g_Config.DogzArray[I].nHumLevel = 0 then
        break;
      if PlayObject.m_Abil.Level >= g_Config.DogzArray[I].nHumLevel then
      begin
        sMonName := g_Config.DogzArray[I].sMonName;
        nExpLevel := g_Config.DogzArray[I].nLevel;
        nCount := g_Config.DogzArray[I].nCount;
      end;
    end;
    mon := PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec);
    if mon <> nil then
    begin
      mon.m_boDog := true;
      Result := True;
    end;

  end;

end;

function TMagicManager.MagMakeSlave(PlayObject: TPlayObject; UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  mon: tBaseobject;
begin
  Result := False;
  if not PlayObject.sub_4DD704 then
  begin
    sMonName := g_Config.sBoneFamm;
    nMakeLevel := UserMagic.btLevel+PlayObject.m_btMobSlaveLevel;
  //  if Checktianxuan(PlayObject) then nMakelevel:=5;      //天玄套装 宝宝为5级
    nExpLevel := UserMagic.btLevel;
    if Checktianxuan(PlayObject) then
      nExpLevel := 5;
    nCount := g_Config.nBoneFammCount;
    dwRoyaltySec := 24 * 24 * 60 * 60;
    for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do
    begin
      if g_Config.BoneFammArray[I].nHumLevel = 0 then
        break;
      if PlayObject.m_Abil.Level >= g_Config.BoneFammArray[I].nHumLevel then
      begin
        sMonName := g_Config.BoneFammArray[I].sMonName;
        nExpLevel := g_Config.BoneFammArray[I].nLevel;
        nCount := g_Config.BoneFammArray[I].nCount;
      end;
    end;

    mon := PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec);
    if mon <> nil then
    begin
      mon.m_boBoneFamm := true;
      Result := True;

    end;
  end;
end;

function TMagicManager.MagMakeshiling(PlayObject: TPlayObject; tx, ty: integer; TargeTBaseObject: Tbaseobject; UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  mon: tBaseobject;
  bohasshiling: boolean;
  nMaxMob: integer;
begin
  Result := False;

  nMaxMob := 1;
  for i := PlayObject.m_SlaveList.Count - 1 downto 0 do
    if TBaseObject(PlayObject.m_SlaveList.Items[i]).m_bohorse or
      TBaseObject(PlayObject.m_SlaveList.Items[i]).m_boTishen or
      (TBaseObject(PlayObject.m_SlaveList.Items[i]).m_sCharName = '丛林豹') or
      (TBaseObject(PlayObject.m_SlaveList.Items[i]).m_btRaceServer = RC_YSBJECT) then
    begin inc(nMaxMob);
    end;

  //  if nMaxMob >  m_SlaveList.Count  then begin
  if nMaxMob <= PlayObject.m_SlaveList.Count then
    exit;
  sMonName := '尸灵';
  nMakeLevel := UserMagic.btLevel;
  //  if Checktianxuan(PlayObject) then nMakelevel:=5;      //天玄套装 宝宝为5级
  nExpLevel := UserMagic.btLevel;
  if Checktianxuan(PlayObject) then
    nExpLevel := 5;
  nCount := 1;
  dwRoyaltySec := 24 * 24 * 60 * 60;

  TargeTBaseObject.MakeGhost;
  Mon := nil;


  if PlayObject.m_PEnvir.CanWalk(tX, tY, false) then
    Mon := UserEngine.RegenMonsterByName(PlayObject.m_PEnvir.sMapName, tX, tY, sMonName);
  if Mon <> nil then
  begin
    Mon.m_Master := PlayObject;
    Mon.m_dwMasterRoyaltyTick := GetTickCount + dwRoyaltySec * 1000;
    Mon.m_btSlaveMakeLevel := nMakeLevel;
    Mon.m_btSlaveExpLevel := nExpLevel;

    Mon.RecalcAbilitys;
    if Mon.m_WAbil.HP < Mon.m_WAbil.MaxHP then
    begin
      Mon.m_WAbil.HP := Mon.m_WAbil.HP + (Mon.m_WAbil.MaxHP - Mon.m_WAbil.HP) div 2;
    end;
    Mon.RefNameColor;
    PlayObject.m_SlaveList.Add(Mon);



    mon.m_boshiling := true;
    Result := True;

  end;
end;

function TMagicManager.Maglinghunqiang(PlayObject: TPlayObject; tx, ty: integer; TargeTBaseObject: Tbaseobject; UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (TargeTBaseObject <> nil) and (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and
    ((Random(5) + (PlayObject.m_Abil.Level)) > TargeTBaseObject.m_Abil.Level) then
  begin

    if random((UserMagic.btLevel + 2) * 3) >= 1 then
    begin
      TargeTBaseObject.m_bolinghunqiang := True;
      TargeTBaseObject.m_dwlinghunqiangTick := GetTickCount();
      TargeTBaseObject.m_dwlinghunqiangInterval := (UserMagic.btLevel + 1) * 10 * 1000;

      TargeTBaseObject.SendRefMsg(RM_linghunqiang, 0, 0, 0, 0, '');
      Result := True;
    end;

  end;


end;

function TMagicManager.MagMaketishen(PlayObject: TPlayObject; tx, ty: integer; UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  mon: tBaseobject;

  bohastishen: boolean;
begin
  Result := False;
  bohastishen := false;
  for i := PlayObject.m_SlaveList.Count - 1 downto 0 do
  begin
    if TBaseObject(PlayObject.m_SlaveList.Items[i]).m_boTishen then
    begin
                   //  TBaseObject(m_Master.m_SlaveList.Items[i]).MakeGhost;

      bohastishen := true;
      break;
    end;
  end; //for
  if bohastishen then
    exit;
  sMonName := '替身';
  nMakeLevel := UserMagic.btLevel;
  nExpLevel := UserMagic.btLevel;

  nCount := 1;
  dwRoyaltySec := 24 * 24 * 60 * 60;


 //  mon:=PlayObject.MakeSlave(sMonName,nMakeLevel,nExpLevel,nCount,dwRoyaltySec);
  //    GetFrontPosition(nX,nY);  // sub_004B2790
  Mon := nil;
  if PlayObject.m_PEnvir.CanWalk(tX, tY, false) then
    Mon := UserEngine.RegenMonsterByName(PlayObject.m_PEnvir.sMapName, tX, tY, sMonName);
  if Mon <> nil then
  begin
    Mon.m_Master := PlayObject;
    Mon.m_dwMasterRoyaltyTick := GetTickCount + dwRoyaltySec * 1000;
    Mon.m_btSlaveMakeLevel := nMakeLevel;
    Mon.m_btSlaveExpLevel := 0; //nExpLevel;
    Mon.m_dwtishenGhostTick := GetTickCount;
    Mon.m_nghosttime := (nExpLevel + 1) * 10 * 1000;

    Mon.RecalcAbilitys;
    if Mon.m_WAbil.HP < Mon.m_WAbil.MaxHP then
    begin
      Mon.m_WAbil.HP := Mon.m_WAbil.HP + (Mon.m_WAbil.MaxHP - Mon.m_WAbil.HP) div 2;
    end;
    Mon.RefNameColor;
    PlayObject.m_bohastishen := true;
    PlayObject.m_SlaveList.Add(Mon);



    mon.m_boTishen := true;
    Result := True;

  end;

end;

function TMagicManager.MagGroupMb(PlayObject: TPlayObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
  StdItem: pTStdItem;
  nTime: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  nTime := 5 * UserMagic.btLevel + 1;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, PlayObject.m_nCurrX, PlayObject.m_nCurrY, UserMagic.btLevel + 2, BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do
  begin
    BaseObject := TBaseObject(BaseObjectList.Items[I]);
    if BaseObject = nil then
      continue;
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and (not g_Config.boGroupMbAttackPlayObject) then
      Continue;
    if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then
      Continue;
    if PlayObject.IsProperTarget(BaseObject) then
    begin
      if not BaseObject.m_boUnParalysis and (Random(BaseObject.m_btAntiPoison) = 0) then
      begin
        if (BaseObject.m_Abil.Level < PlayObject.m_Abil.Level) or (Random(PlayObject.m_Abil.Level - BaseObject.m_Abil.Level) = 0) then
        begin
          BaseObject.MakePosion(POISON_STONE, nTime, 0);
          BaseObject.m_boFastParalysis := True;
        end;
      end;
    end;
    if (BaseObject.m_btRaceServer >= RC_ANIMAL) then
      Result := True;
  end;
  BaseObjectList.Free;
end;

end.
