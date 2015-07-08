unit ObjNpc;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Math,ObjBase,DateUtils, Grobal2, IniFiles;
type
  TUpgradeInfo = record //0x40
    sUserName: string[14]; //0x00
    UserItem: TUserItem; //0x10
    btDc: Byte; //0x28
    btSc: Byte; //0x29
    btMc: Byte; //0x2A
    btDura: Byte; //0x2B
    n2C: Integer;
    dtTime: TDateTime; //0x30
    dwGetBackTick: LongWord; //0x38
    n3C: Integer;
  end;
  pTUpgradeInfo = ^TUpgradeInfo;
  TItemPrice = record
    wIndex: Word;
    nPrice: Integer;
  end;
  pTItemPrice = ^TItemPrice;
  TGoods = record //0x1C

    sItemName: string[14];
    nCount: Integer;
    dwRefillTime: LongWord;
    dwRefillTick: LongWord;
  end;
  pTGoods = ^TGoods;
  TQuestActionInfo = record //0x1C
    nCmdCode: Integer; //0x00
    sParam1: string; //0x04
    nParam1: Integer; //0x08
    sParam2: string; //0x0C
    nParam2: Integer; //0x10
    sParam3: string; //0x14
    nParam3: Integer; //0x18
    sParam4: string;
    nParam4: Integer;
    sParam5: string;
    nParam5: Integer;
    sParam6: string;
    nParam6: Integer;
    sBaseObject:String;
  end;
  pTQuestActionInfo = ^TQuestActionInfo;
  TQuestConditionInfo = record //0x14
    nCmdCode: Integer; //0x00
    sParam1: string; //0x04
    nParam1: Integer; //0x08
    sParam2: string; //0x0C
    nParam2: Integer; //0x10
    sParam3: string;
    nParam3: Integer;
    sParam4: string;
    nParam4: Integer;
    sParam5: string;
    nParam5: Integer;
    sParam6: string;
    nParam6: Integer;
    boNot  : Boolean;
    sBaseObject:String;
  end;
  pTQuestConditionInfo = ^TQuestConditionInfo;
  TSayingProcedure = record //0x14
    ConditionList: TList; //0x00
    ActionList: TList; //0x04
    sSayMsg: string; //0x08
    ElseActionList: TList; //0x0C
    sElseSayMsg: string; //0x10
  end;
  pTSayingProcedure = ^TSayingProcedure;
  TSayingRecord = record //0x08
    sLabel: string;
    ProcedureList: TList; //0x04
    boExtJmp: boolean; //是否允许外部跳转
    boPNEUMA:Boolean;
    nFlash:Integer;
  end;
  pTSayingRecord = ^TSayingRecord;
  TNormNpc = class(TAnimalObject) //0x564

    m_nCastle: Integer; //0x575

    n54C: Integer; //0x54C
    m_nFlag: ShortInt; //0x550 //用于标识此NPC是否有效，用于重新加载NPC列表(-1 为无效)
    m_ScriptList: TList; //0x554
    m_sFilePath: string[100]; //0x558 脚本文件所在目录
    m_boIsHide: Boolean; //0x55C 此NPC是否是隐藏的，不显示在地图中
    m_boIsQuest: Boolean; //0x55D NPC类型为地图任务型的，加载脚本时的脚本文件名为 角色名-地图号.txt
    m_sPath: string; //0x560
    mirrorname: string; //被镜像NPC 地图编号  名字

    m_nDelayTime:LongWord;
    m_nDelayTick:LongWord ;
    m_boopenBless : Boolean;
    m_sLableParam : array[0..19] of string;
    m_sComments:string;
    m_BBsList:TStringList;
    m_boGuildTower:Boolean;
    m_bodoshop:Boolean;
    m_nFlashValue:Integer;
  //  byistopnpc: byte;
  private
    procedure ScriptActionError(PlayObject: TPlayObject; sErrMsg: string; QuestActionInfo: pTQuestActionInfo; sCmd: string);
    procedure ScriptConditionError(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; sCmd: string);

    procedure ExeAction(PlayObject: TPlayObject; sParam1, sParam2, sParam3: string; nParam1, nParam2, nParam3: Integer);
    procedure ActionOfChangeLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGiveItem(PlayObject: TPlayObject; sItemName:String;nItemCount: Integer;boDrop:Boolean=False);
    procedure ActionofSetNpcName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionofSetNpcAPPR(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionofPlayDefence(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfoffline(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfReadRandomStr(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfGetMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGetMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelNoJobSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfADDYSSKILL(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);


    procedure ActionOfSkillLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangePkPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeExp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeCreditPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeJob(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRecallGroupMembers(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearNameList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMapTing(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobPlace(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo; nX, nY, nCount, nRange: Integer);
    procedure ActionOfMobPlaceX(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfSetMemberType(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetMemberLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGamePoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfYSPOINT(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfJPPOINT(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfADDTASK(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfUpdateTask(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfEndTask(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfYSFENGHAO(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfADDYQ(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfBOOSFS(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfTAKEB(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGROUPMOVE(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);


    procedure ActionOfHasTask(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetAdditionalAbil(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);


    procedure ActionOfAutoAddGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo; nPoint, nTime: integer);
    procedure ActionOfAutoSubGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo; nPoint, nTime: integer);
    procedure ActionOfWearColor(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeHairStyle(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLineMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeNameColor(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearPassword(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfReNewLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeGender(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKillSlave(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKillMonExpRate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfStatusRate(PlayObject: TPlayObject; QuestActionInfo:
      pTQuestActionInfo);
    procedure ActionOfPowerRate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeMode(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangePerMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKick(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRestReNewLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearNeedItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearMakeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpgradeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpgradeItemsEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMonGenEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearMapMon(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfSetMapMode(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGemCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPkZone(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRestBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfuseBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfUpdateTop(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCLEARCURMAPMON(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMONSTORAGE(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfFEEDMON(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPetZS(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPetLEvel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPetEXp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPetProperty(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobNpc(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfcheckitembox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfdelay(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfhcall(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfrecpos(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionSetArrow(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionClearArrow(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionFENGHAO(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionSETUSEITEMNAME(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionCLONESELF(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionUSESKILL(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionSETOFFLINE(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionSETTIMER(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionFUSHEN(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionCreateYS(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionclearYS(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionDECUSESTIME(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);


    procedure ActionREPAIRALL(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionGameOfWoool(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionCreateGroupLight(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionBODYEFFECT(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionDELCOMMENT(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionMAPMOVEHUM(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionRandomGive(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionRANDOMX(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ChangePetName(PlayObject: TPlayObject; sItemName: string);

    procedure ActionOfTakeCastleGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfHumanHP(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfHumanMP(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildBuildPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildAuraePoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildstabilityPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildFlourishPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenMagicBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetRankLevelName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGmExecute(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildChiefItemCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddNameDateList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelNameDateList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobFireBurn(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMessageBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetScriptFlag(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAutoGetExp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRecallmob(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLoadVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLoadExVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSaveVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSaveEXVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCalcVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfQueryvalue(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfQueryNAME(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfChangeArp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfbigbag(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeweather(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeflag(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfmagicfont(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfmagicfontcolor(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfADDITEMDARKPROPERTY(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSendComment(PlayObject: TPlayObject);
    procedure ActionOfSetErniePrize(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfSetTimerA(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpGradeITEMDARKPROPERTY(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpGradeITEMBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpGradeUserITEMDARKPROPERTY(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGoBackeMap(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpGradeUserITEMEX(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfJoinGuild(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildMemberMaxLimit(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGUILDGRADE(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGUILDEXP(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfQUITGUILD(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddCastleWar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCLEARCASTLEWAR(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    function ConditionOfCheckGroupCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseDir(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseGender(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseMarry(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckLevelEx(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCHECKSLAVENAME(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckBonusPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckAccountIPList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameIPList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMarry(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMarryCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfHaveMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfPoseHaveMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckIsMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHaveGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMemberType(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMemBerLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGameGold(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCHECKYEAR(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCHECKMONTH(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCHECKDAY(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCHECKMAPNAME(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckGamePoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCHECKYSPOINT(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCHECKJPPOINT(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckUserGap(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;


    function ConditionOfCheckNameListPostion(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckReNewLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;


    function ConditionOfCheckCreditPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOfGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPayMent(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckUseItem(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckBagSize(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckListCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckDC(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMC(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSC(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHP(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMP(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemType(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckExp(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleGold(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIsLockPassword(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIsLockStorage(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckStabilityPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckFlourishPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckContribution(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckRangeMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemAddValue(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckInMapRange(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsAttackAllyGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsDefenseAllyGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleChageDay(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleWarDay(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckChiefItemCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameDateList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapHumanCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckVar(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckServerName(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckys(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckITEMDARKPROPERTY(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function GetDynamicVarList(PlayObject: TPlayObject; sType: string; var sName: string): TList;
    function ConditionOfCHECKUPGRADECOUNT(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapMonNameCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapMonNameCountex(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfPosEX(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function conditionofCheckGuildExp(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function conditionofCheckGuildGrade(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function conditionofCheckGuildMemberCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function conditionofCheckGuildMemberMaxLimit(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function conditionofCHECKITEMDURE(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function conditionofCHECKMONPOS(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

  public
   m_boQiZuo:Boolean;
       m_bocallboard: boolean;
    m_boCallHero:Boolean;
    m_bofengyuanguard  : Boolean;//  封元守卫
    m_nFlash:Integer;
    m_nType:Integer;
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override; //FFFB
    procedure Click(PlayObject: TPlayObject); virtual; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); virtual; //FFEA
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); virtual; //FFE9
    function GetLineVariableText(PlayObject: TPlayObject; sMsg: string): string;
    function GotoLable(PlayObject: TPlayObject; sLabel: string; boExtJmp: Boolean):Boolean;
    procedure setValValue(playobject:TPlayObject; sVarName:string;nValue:Integer;sValue:string );
    function GetValValue(playobject:TPlayObject;var  sVarName:string;var nValue:Integer;var sValue:string ):integer;
    function sub_49ADB8(sMsg, sStr, sText: string): string;
    procedure LoadNPCScript();
    procedure ClearScript(); virtual;
    procedure SendMsgToUser(PlayObject: TPlayObject; sMsg: string);
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); virtual;
       function ReQuestGuildWar(PlayObject: TPlayObject;
      sGuildName: string): Integer;
    function ReQuestBuildGuild(PlayObject: TPlayObject;
      sGuildName: string): Integer;
  end;
  TMerchant = class(TNormNpc) //0x594
    m_sScript: string; //0x568
    n56C: Integer;
    m_nPriceRate: Integer; //0x570   物品价格倍率 默认为 100%
    bo574: Boolean;
    m_ItemTypeList: TList; //0x580  NPC买卖物品类型列表，脚本中前面的 +1 +30 之类的
    m_RefillGoodsList: TList; //0x584
    m_GoodsList: TList; //0x588
    m_boCastle: Boolean; //0x575


    dwRefillGoodsTick: LongWord; //0x578
    dwClearExpreUpgradeTick: LongWord; //0x57C

    m_FastGoodList : TList;
    m_RefillFastGoodList : TList;
    m_ItemPriceList: TList; //0x58C
    m_UpgradeWeaponList: TList;
    m_boCanMove: Boolean;
    m_dwMoveTime: LongWord;
    m_dwMoveTick: LongWord;
    m_boBuy: Boolean;

    m_boSell: Boolean;
    m_boMakeDrug: Boolean;
    m_boPrices: Boolean;
    m_boStorage: Boolean;
    m_boGetback: Boolean;
    m_boUpgradenow: Boolean;
    m_boGetBackupgnow: Boolean;
    m_boRepair: Boolean;
    m_boS_repair: Boolean;
    m_boSendmsg: Boolean;
    m_boGetMarry: Boolean;
    m_boGetMaster: Boolean;
    m_boUseItemName: Boolean;

  private
    procedure ClearExpreUpgradeListData();
    function GetItemPrice(nIndex: Integer): Integer;
    function GetUserPrice(PlayObject: TPlayObject; nPrice: Integer): Integer;
    function CheckItemType(nStdMode: Integer): Boolean;
    procedure CheckItemPrice(nIndex: Integer);
    function GetRefillList(nIndex: Integer): TList;
    procedure AddItemPrice(nIndex, nPrice: Integer);
    function GetUserItemPrice(UserItem: pTUserItem): Integer;
    function GetSellItemPrice(nPrice: integer): Integer;
    function AddItemToGoodsList(UserItem: pTUserItem): Boolean;
    procedure GetBackupgWeapon(User: TPlayObject);
    procedure UpgradeWapon(User: TPlayObject);
    procedure ChangeUseItemName(PlayObject: TPlayObject; sLabel, sItemName: string);

    procedure SaveUpgradingList;
    procedure GetMarry(PlayObject: TPlayObject; sDearName: string);
    procedure GetMaster(PlayObject: TPlayObject; sMasterName: string);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    procedure LoadNPCData();
    procedure SaveNPCData();
    procedure LoadUpgradeList();
    procedure RefillGoods();
    procedure LoadNPCScript(sFileName:string='');
    procedure Click(PlayObject: TPlayObject); override;
    procedure ClearScript(); override;
    procedure ClearData();
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); override; //FFE9
    procedure ClientBuyItem(PlayObject: TPlayObject; sItemName: string; nInt: Integer);
    procedure ClientFastBuyItem(PlayObject: TPlayObject; sItemName: string; nInt: Integer;nMakeIndex:Integer=-1);
    procedure ClientGetDetailGoodsList(PlayObject: TPlayObject; sItemName: string; nInt: Integer);
    procedure ClientQuerySellPrice(PlayObject: TPlayObject; UserItem: pTUserItem);
    function ClientSellItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
    procedure ClientMakeDrugItem(PlayObject: TPlayObject; sItemName: string);
    procedure ClientQueryRepairCost(PlayObject: TPlayObject; UserItem: pTUserItem);
    function ClientRepairItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
    procedure SendQueryMsg(PlayObject: TPlayObject; sMsg: string);
    procedure SaveComment;
    
  end;
  TMapQuestInfo = record
    sMapName: string[14];
    nFlags: Integer;
    boFlag: Boolean;
    sMonName: string[14];
    sNeedItem: string[14];
    sScriptName: string[14];
    boGroup: Boolean;
    nFlag: integer;
    nValue: integer;
    s08: string[14];
    s0C: string[14];
    NPC: TMerchant;
    bo10: boolean;
  end;
  pTMapQuestInfo = ^TMapQuestInfo;


  TGuildOfficial = class(TNormNpc) //0x568
  private


    procedure DoNate(PlayObject: TPlayObject);
    procedure ReQuestCastleWar(PlayObject: TPlayObject; sIndex: string);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); override; //FFE9
    procedure Run; override; //FFFB
    procedure Click(PlayObject: TPlayObject); override; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override; //FFEA
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
  TTrainer = class(TNormNpc) //0x574
    n564: Integer;
    m_dw568: LongWord;
    n56C: Integer;
    n570: Integer;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
//  TCastleManager = class(TMerchant)
  TCastleOfficial = class(TMerchant)
  private
    procedure HireArcher(sIndex: string; PlayObject: TPlayObject);
    procedure HireGuard(sIndex: string; PlayObject: TPlayObject);
    procedure RepairDoor(PlayObject: TPlayObject);
    procedure RepairWallNow(nWallIndex: Integer; PlayObject: TPlayObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Click(PlayObject: TPlayObject); override; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override; //FFEA
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); override; //FFE9
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
implementation

uses Castle, M2Share, HUtil32, LocalDB, Envir, Guild, EDcode, ObjMon2,
  Event,Objys;

procedure TCastleOfficial.Click(PlayObject: TPlayObject); //004A4588
begin
  if m_Castle = nil then
  begin
    PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
    exit;
  end;
  if TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) or (PlayObject.m_btPermission >= 3) then
    inherited;
end;

procedure TCastleOfficial.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);
var
//  I: Integer;
  sText: string;
  CastleDoor: TCastleDoor;
//  List:TStringList;
begin
  inherited;
  if m_Castle = nil then
  begin
    sMsg := '????';
    exit;
  end;
  if sVariable = '$CASTLEGOLD' then
  begin
    sText := IntToStr(TUserCastle(m_Castle).m_nTotalGold);
    sMsg := sub_49ADB8(sMsg, '<$CASTLEGOLD>', sText);
  end
  else
    if sVariable = '$TODAYINCOME' then
    begin
      sText := IntToStr(TUserCastle(m_Castle).m_nTodayIncome);
      sMsg := sub_49ADB8(sMsg, '<$TODAYINCOME>', sText);
    end
    else
      if sVariable = '$CASTLEDOORSTATE' then
      begin
        CastleDoor := TCastleDoor(TUserCastle(m_Castle).m_MainDoor.BaseObject);
        if CastleDoor.m_boDeath then
          sText := '损坏'
        else
          if CastleDoor.m_boOpened then
            sText := '开启'
          else
            sText := '关闭';
        sMsg := sub_49ADB8(sMsg, '<$CASTLEDOORSTATE>', sText);
      end
      else
        if sVariable = '$REPAIRDOORGOLD' then
        begin
          sText := IntToStr(g_Config.nRepairDoorPrice);
          sMsg := sub_49ADB8(sMsg, '<$REPAIRDOORGOLD>', sText);
        end
        else
          if sVariable = '$REPAIRWALLGOLD' then
          begin
            sText := IntToStr(g_Config.nRepairWallPrice);
            sMsg := sub_49ADB8(sMsg, '<$REPAIRWALLGOLD>', sText);
          end
          else
            if sVariable = '$GUARDFEE' then
            begin
              sText := IntToStr(g_Config.nHireGuardPrice);
              sMsg := sub_49ADB8(sMsg, '<$GUARDFEE>', sText);
            end
            else
              if sVariable = '$ARCHERFEE' then
              begin
                sText := IntToStr(g_Config.nHireArcherPrice);
                sMsg := sub_49ADB8(sMsg, '<$ARCHERFEE>', sText);
              end
              else
                if sVariable = '$GUARDRULE' then
                begin
                  sText := '无效';
                  sMsg := sub_49ADB8(sMsg, '<$GUARDRULE>', sText);
                end;

end;

procedure TCastleOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  s18, s20, sMsg, sLabel: string;
  boCanJmp: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TCastleManager::UserSelect... ';
begin
  inherited;
  try
    PlayObject.m_nScriptGotoCount:=0;
    if m_Castle = nil then
    begin
      PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
      exit;
    end;
    if (sData <> '') and (sData[1] = '@') then
    begin
      sMsg := GetValidStr3(sData, sLabel, [#13]);
      s18 := '';
      PlayObject.m_sScriptLable := sData;
      if TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) and (PlayObject.IsGuildMaster) then
      begin
        boCanJmp := PlayObject.LableIsCanJmp(sLabel, m_bocallboard);
        if CompareText(sLabel, sSL_SENDMSG) = 0 then
        begin
          if sMsg = '' then
            exit;
        end;
        GotoLable(PlayObject, sLabel, not boCanJmp);
        //GotoLable(PlayObject,sLabel,not PlayObject.LableIsCanJmp(sLabel));
        if not boCanJmp then
          exit;
        if CompareText(sLabel, sSL_SENDMSG) = 0 then
        begin
          SendCustemMsg(PlayObject, sMsg);
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
        end
        else
          if CompareText(sLabel, sCASTLENAME) = 0 then
          begin
            sMsg := Trim(sMsg);
            if sMsg <> '' then
            begin
              TUserCastle(m_Castle).m_sName := sMsg;
              TUserCastle(m_Castle).Save;
              TUserCastle(m_Castle).m_MasterGuild.RefMemberName;
              s18 := '城堡名称更改成功...';
            end
            else
            begin
              s18 := '城堡名称更改失败！！！';
            end;
            PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
          end
          else
            if CompareText(sLabel, sWITHDRAWAL) = 0 then
            begin
                playobject.m_nsendtype := 0;
                playobject.m_nsendid :=sWITHDRAWAL;
                PlayObject.SendDefMessage(4627, 0, $0f01, 0, 0, '请输入要取出金额'); //弹出输入名字窗口

            end
            else
              if CompareText(sLabel, sRECEIPTS) = 0 then
              begin

                playobject.m_nsendtype := 0;
                playobject.m_nsendid :=sRECEIPTs;
                PlayObject.SendDefMessage(4627, 0, $0f01, 0, 0, '请要输入的存储金额'); //弹出输入名字窗口



//                case TUserCastle(m_Castle).ReceiptGolds(PlayObject, Str_ToInt(sMsg, 0)) of
//                  -4: s18 := '输入的金币数不正确！！！';
//                  -3: s18 := '你已经达到在城内存放货物的限制了。';
//                  -2: s18 := '你没有那么多金币.';
//                  -1: s18 := '只有行会 ' + TUserCastle(m_Castle).m_sOwnGuild + ' 的掌门人才能使用！！！';
//                  1: GotoLable(PlayObject, sMAIN, False);
//                end;
//


                //PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
              end
              else
                if CompareText(sLabel, sOPENMAINDOOR) = 0 then
                begin
                  TUserCastle(m_Castle).MainDoorControl(False);
                end
                else
                  if CompareText(sLabel, sCLOSEMAINDOOR) = 0 then
                  begin
                    TUserCastle(m_Castle).MainDoorControl(True);
                  end
                  else
                    if CompareText(sLabel, sREPAIRDOORNOW) = 0 then
                    begin
                      RepairDoor(PlayObject);
                      GotoLable(PlayObject, sMAIN, False);
                    end
                    else
                      if CompareText(sLabel, sREPAIRWALLNOW1) = 0 then
                      begin
                        RepairWallNow(1, PlayObject);
                        GotoLable(PlayObject, sMAIN, False);
                      end
                      else
                        if CompareText(sLabel, sREPAIRWALLNOW2) = 0 then
                        begin
                          RepairWallNow(2, PlayObject);
                          GotoLable(PlayObject, sMAIN, False);
                        end
                        else
                          if CompareText(sLabel, sREPAIRWALLNOW3) = 0 then
                          begin
                            RepairWallNow(3, PlayObject);
                            GotoLable(PlayObject, sMAIN, False);
                          end
                          else
                            if CompareLStr(sLabel, sHIREGUARDNOW, length(sHIREGUARDNOW)) then
                            begin
                              s20 := Copy(sLabel, length(sHIREGUARDNOW) + 1, length(sLabel));
                              HireGuard(s20, PlayObject);
                              PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, '雇佣成功');
          //GotoLable(PlayObject,sHIREGUARDOK,False);
                            end
                            else
                              if CompareLStr(sLabel, sHIREARCHERNOW, length(sHIREARCHERNOW)) then
                              begin
                                s20 := Copy(sLabel, length(sHIREARCHERNOW) + 1, length(sLabel));
                                HireArcher(s20, PlayObject);
                                PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, '雇佣成功');
                              end
                              else
                                if CompareText(sLabel, sEXIT) = 0 then
                                begin
                                  PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
                                end
                                else
                                  if CompareText(sLabel, sBACK) = 0 then
                                  begin
                                    if PlayObject.m_sScriptGoBackLable = '' then
                                      PlayObject.m_sScriptGoBackLable := sMAIN;
                                    GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
                                  end;
      end
      else
      begin
        s18 := '你没有权利使用';
        PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
//  inherited;

end;

procedure TCastleOfficial.HireGuard(sIndex: string; PlayObject: TPlayObject); //004A413C
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
  if m_Castle = nil then
  begin
    PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
    exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireGuardPrice then
  begin
    n10 := Str_ToInt(sIndex, 0) - 1;
    if n10 <= MAXCALSTEGUARD then
    begin
      if TUserCastle(m_Castle).m_Guard[n10].BaseObject = nil then
      begin
        if not TUserCastle(m_Castle).m_boUnderWar then
        begin
          ObjUnit := @TUserCastle(m_Castle).m_Guard[n10];
          ObjUnit.BaseObject := UserEngine.RegenMonsterByName(TUserCastle(m_Castle).m_sMapName,
            ObjUnit.nX,
            ObjUnit.nY,
            ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then
          begin
            Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nHireGuardPrice);
            ObjUnit.BaseObject.m_Castle := TUserCastle(m_Castle);
            TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
            PlayObject.SysMsg('雇佣成功.', c_Green, t_Hint);
          end;

        end
        else
        begin
          PlayObject.SysMsg('现在无法雇佣！！！', c_Red, t_Hint);
        end;
      end
    end
    else
    begin
      PlayObject.SysMsg('指令错误！！！', c_Red, t_Hint);
    end;
  end
  else
  begin
    PlayObject.SysMsg('城内资金不足！！！', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nHireGuardPrice then begin
    n10:=Str_ToInt(sIndex,0) - 1;
    if n10 <= MAXCALSTEGUARD then begin
      if UserCastle.m_Guard[n10].BaseObject = nil then begin
        if not UserCastle.m_boUnderWar then begin
          ObjUnit:=@UserCastle.m_Guard[n10];
          ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                          ObjUnit.nX,
                                                          ObjUnit.nY,
                                                          ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(UserCastle.m_nTotalGold,g_Config.nHireGuardPrice);
            ObjUnit.BaseObject.m_Castle:=UserCastle;
            TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
            PlayObject.SysMsg('雇佣成功.',c_Green,t_Hint);
          end;

        end else begin
          PlayObject.SysMsg('现在无法雇佣！！！',c_Red,t_Hint);
        end;
      end
    end else begin
      PlayObject.SysMsg('指令错误！！！',c_Red,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
  end;
  }
end;

procedure TCastleOfficial.HireArcher(sIndex: string; PlayObject: TPlayObject); //004A433C
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
  if m_Castle = nil then
  begin
    PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
    exit;
  end;

  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireArcherPrice then
  begin
    n10 := Str_ToInt(sIndex, 0) - 1;
    if n10 <= MAXCASTLEARCHER then
    begin
      if TUserCastle(m_Castle).m_Archer[n10].BaseObject = nil then
      begin
        if not TUserCastle(m_Castle).m_boUnderWar then
        begin
          ObjUnit := @TUserCastle(m_Castle).m_Archer[n10];
          ObjUnit.BaseObject := UserEngine.RegenMonsterByName(TUserCastle(m_Castle).m_sMapName,
            ObjUnit.nX,
            ObjUnit.nY,
            ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then
          begin
            Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nHireArcherPrice);
            ObjUnit.BaseObject.m_Castle := TUserCastle(m_Castle);
            TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
            PlayObject.SysMsg('雇佣成功.', c_Green, t_Hint);
          end;

        end
        else
        begin
          PlayObject.SysMsg('现在无法雇佣！！！', c_Red, t_Hint);
        end;
      end
      else
      begin
        PlayObject.SysMsg('早已雇佣！！！', c_Red, t_Hint);
      end;
    end
    else
    begin
      PlayObject.SysMsg('指令错误！！！', c_Red, t_Hint);
    end;
  end
  else
  begin
    PlayObject.SysMsg('城内资金不足！！！', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nHireArcherPrice then begin
    n10:=Str_ToInt(sIndex,0) - 1;
    if n10 <= MAXCASTLEARCHER then begin
      if UserCastle.m_Archer[n10].BaseObject = nil then begin
        if not UserCastle.m_boUnderWar then begin
          ObjUnit:=@UserCastle.m_Archer[n10];
          ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                          ObjUnit.nX,
                                                          ObjUnit.nY,
                                                          ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(UserCastle.m_nTotalGold,g_Config.nHireArcherPrice);
            ObjUnit.BaseObject.m_Castle:=UserCastle;
            TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
            PlayObject.SysMsg('雇佣成功.',c_Green,t_Hint);
          end;

        end else begin
          PlayObject.SysMsg('现在无法雇佣！！！',c_Red,t_Hint);
        end;
      end else begin
        PlayObject.SysMsg('早已雇佣！！！',c_Red,t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('指令错误！！！',c_Red,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('城内资金不足！！！',c_Red,t_Hint);
  end;
  }
end;
{ TMerchant }

procedure TMerchant.AddItemPrice(nIndex: Integer; nPrice: Integer); //0049F2AC
var
  ItemPrice: pTItemPrice;
begin
  New(ItemPrice);
  ItemPrice.wIndex := nIndex;
  ItemPrice.nPrice := nPrice;
  m_ItemPriceList.Add(ItemPrice);
  FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
end;

procedure TMerchant.CheckItemPrice(nIndex: Integer); //0049F1BC
var
  I: Integer;
  ItemPrice: pTItemPrice;

  StdItem: pTStdItem;
begin
  for I := 0 to m_ItemPriceList.Count - 1 do
  begin
    ItemPrice := m_ItemPriceList.Items[i];
    if ItemPrice.wIndex = nIndex then
    begin

      exit;
    end;
  end;
  StdItem := UserEngine.GetStdItem(nIndex);
  if StdItem <> nil then
  begin
    AddItemPrice(nIndex, ROUND(StdItem.Price * 1.1));
  end;
end;

function TMerchant.GetRefillList(nIndex: Integer): TList; //0049F118
var
  I: Integer;
  List: TList;
  UserItem: pTUserItem;
begin
  Result := nil;
  if nIndex <= 0 then
    exit;
  for I := 0 to m_GoodsList.Count - 1 do
  begin
    List := TList(m_GoodsList.Items[i]);
    if List.Count > 0 then
    begin


      UserItem := List.Items[0];
      if UserItem = nil then
      begin //==2006,8,3  B7抱错
        List.Delete(0); //
        continue; //
      end; //

      if pTUserItem(List.Items[0]).wIndex = nIndex then
      begin
        Result := List;
        Break;
      end;
    end;
  end;
end;

procedure TMerchant.RefillGoods; //0049F950
  procedure RefillItems(var List: TList; sItemName: string; nInt: Integer); //0049F824
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    if List = nil then
    begin
      List := TList.Create;
      m_GoodsList.Add(List);
    end;
    for I := 0 to nInt - 1 do
    begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
      begin
        List.Insert(0, UserItem);
      end
      else
        Dispose(UserItem);
    end;
  end;
  procedure DelReFillItem(var List: TList; nInt: Integer); //0049F8F8
  var
    I: Integer;
  begin
    for I := List.Count - 1 downto 0 do
    begin
      if nInt <= 0 then
        break;
      Dispose(pTUserItem(List.Items[i]));
      List.Delete(i);
      Dec(nInt);
    end;
  end;

var
  I, II: Integer;
  Goods: pTGoods;
  nIndex, nRefillCount: Integer;
  RefillList, RefillList20: TList;
  bo21: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::RefillGoods %s/%d:%d [%s] Code:%d';
begin //0049F950
  if m_RefillGoodsList.Count>1000 then Exit;
  if m_GoodsList.Count>1000 then Exit;
  

  try
    for I := 0 to m_RefillGoodsList.Count - 1 do
    begin
      Goods := m_RefillGoodsList.Items[i];
      if (GetTickCount - Goods.dwRefillTick) > Goods.dwRefillTime * 60 * 1000 then
      begin
        Goods.dwRefillTick := GetTickCount();
        nIndex := UserEngine.GetStdItemIdx(Goods.sItemName);
        if nIndex >= 0 then
        begin
          RefillList := GetRefillList(nIndex);
          nRefillCount := 0;
          if RefillList <> nil then
            nRefillCount := RefillList.Count;
          if Goods.nCount > nRefillCount then
          begin
            CheckItemPrice(nIndex);
            RefillItems(RefillList, Goods.sItemName, Goods.nCount - nRefillCount);
            FrmDB.SaveGoodRecord(Self, m_sScript + '-' + m_sMapName);
            FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
          end;
          if Goods.nCount < nRefillCount then
          begin
            DelReFillItem(RefillList, nRefillCount - Goods.nCount);
            FrmDB.SaveGoodRecord(Self, m_sScript + '-' + m_sMapName);
            FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
          end;
        end; //0049FB83
      end;
    end;
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      RefillList20 := TList(m_GoodsList.Items[I]);
      if RefillList20.Count > 1000 then
      begin
        bo21 := False;
        for II := 0 to m_RefillGoodsList.Count - 1 do
        begin
          Goods := m_RefillGoodsList.Items[II];
          nIndex := UserEngine.GetStdItemIdx(Goods.sItemName);
          if pTItemPrice(RefillList20.Items[0]).wIndex = nIndex then
          begin
            bo21 := True;
            break;
          end;
        end;
        if not bo21 then
        begin
          DelReFillItem(RefillList20, RefillList20.Count - 1000);
        end
        else
        begin
          DelReFillItem(RefillList20, RefillList20.Count - 5000);
        end;
      end; //0049FC79
    end;
  except
    on e: Exception do
      MainOutMessage(format(sExceptionMsg, [m_sCharName, m_nCurrX, m_nCurrY, e.Message, nCheck]));
  end;
end;

function TMerchant.CheckItemType(nStdMode: Integer): Boolean; //0049F374
var
  I: Integer;
begin
  Result := False;
  for I := 0 to m_ItemTypeList.Count - 1 do
  begin
    if Integer(m_ItemTypeList.Items[i]) = nStdMode then
    begin
      Result := True;
      break;
    end;
  end;
end;

function TMerchant.GetItemPrice(nIndex: Integer): Integer; //0049F374
var
  I: Integer;
  ItemPrice: pTItemPrice;
  StdItem: pTStdItem;
begin
  Result := -1;
  for I := 0 to m_ItemPriceList.Count - 1 do
  begin
    ItemPrice := m_ItemPriceList.Items[i];
    if ItemPrice.wIndex = nIndex then
    begin
      Result := ItemPrice.nPrice;
      break;
    end;
  end; // for
  if Result < 0 then
  begin
    StdItem := UserEngine.GetStdItem(nIndex);
    if StdItem <> nil then
    begin
      if CheckItemType(StdItem.StdMode) then
        Result := StdItem.Price;
    end;
  end;
end;

procedure TMerchant.SaveUpgradingList(); //0049FF84
begin
  try
    //FrmDB.SaveUpgradeWeaponRecord(m_sCharName,m_UpgradeWeaponList);
    FrmDB.SaveUpgradeWeaponRecord(m_sScript + '-' + m_sMapName, m_UpgradeWeaponList);
  except
    MainOutMessage('Failure in saving upgradinglist - ' + m_sCharName);
  end;
end;

procedure TMerchant.UpgradeWapon(User: TPlayObject); //004A0920
  procedure sub_4A0218(ItemList: TList; var btDc: Byte; var btSc: Byte; var btMc: Byte; var btDura: Byte);
  var
    I, II: Integer;
    DuraList: TList;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    StdItem80: TStdItem;
    DelItemList: TStringList;
    nDc, nSc, nMc, nDcMin, nDcMax, nScMin, nScMax, nMcMin, nMcMax, nDura, nItemCount: Integer;
  begin
    nDcMin := 0;
    nDcMax := 0;
    nScMin := 0;
    nScMax := 0;
    nMcMin := 0;
    nMcMax := 0;
    nDura := 0;
    nItemCount := 0;
    DelItemList := nil;
    DuraList := TList.Create;
    for I := ItemList.Count - 1 downto 0 do
    begin
      UserItem := ItemList.Items[I];
      if UserEngine.GetStdItemName(UserItem.wIndex) = g_Config.sBlackStone then
      begin
        DuraList.Add(Pointer(ROUND(UserItem.Dura / 1.0E3)));
        if DelItemList = nil then
          DelItemList := TStringList.Create;
        DelItemList.AddObject(g_Config.sBlackStone, TObject(UserItem.MakeIndex));
        DisPose(UserItem);
        ItemList.Delete(I);
      end
      else
      begin
        if IsUseItem(UserItem.wIndex) then
        begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem <> nil then
          begin
            StdItem80 := StdItem^;
            ItemUnit.GetItemAddValue(UserItem, StdItem80);
            nDc := 0;
            nSc := 0;
            nMc := 0;
            case StdItem80.StdMode of
              19, 20, 21:
                begin //004A0421
                  nDc := HiByte(StdItem80.DC) + LoByte(StdItem80.DC);
                  nSc := HiByte(StdItem80.SC) + LoByte(StdItem80.SC);
                  nMc := HiByte(StdItem80.MC) + LoByte(StdItem80.MC);
                end;
              22, 23:
                begin //004A046E
                  nDc := HiByte(StdItem80.DC) + LoByte(StdItem80.DC);
                  nSc := HiByte(StdItem80.SC) + LoByte(StdItem80.SC);
                  nMc := HiByte(StdItem80.MC) + LoByte(StdItem80.MC);
                end;
              24, 26:
                begin
                  nDc := HiByte(StdItem80.DC) + LoByte(StdItem80.DC) + 1;
                  nSc := HiByte(StdItem80.SC) + LoByte(StdItem80.SC) + 1;
                  nMc := HiByte(StdItem80.MC) + LoByte(StdItem80.MC) + 1;
                end;
            end;
            if nDcMin < nDc then
            begin
              nDcMax := nDcMin;
              nDcMin := nDc;
            end
            else
            begin
              if nDcMax < nDc then
                nDcMax := nDc;
            end;
            if nScMin < nSc then
            begin
              nScMax := nScMin;
              nScMin := nSc;
            end
            else
            begin
              if nScMax < nSc then
                nScMax := nSc;
            end;
            if nMcMin < nMc then
            begin
              nMcMax := nMcMin;
              nMcMin := nMc;
            end
            else
            begin
              if nMcMax < nMc then
                nMcMax := nMc;
            end;
            if DelItemList = nil then
              DelItemList := TStringList.Create;
            DelItemList.AddObject(StdItem.Name, TObject(UserItem.MakeIndex));
            //004A06DB
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('26' + #9 +
                User.m_sMapName + #9 +
                IntToStr(User.m_nCurrX) + #9 +
                IntToStr(User.m_nCurrY) + #9 +
                User.m_sCharName + #9 +
                           //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                StdItem.Name + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                '0');
            DisPose(UserItem);
            ItemList.Delete(I);
          end;
        end;
      end;
    end; // for
    for I := 0 to DuraList.Count - 1 do
    begin
      for II := DuraList.Count - 1 downto i + 1 do
      begin
        if Integer(DuraList.Items[II]) > Integer(DuraList.Items[II - 1]) then
          DuraList.Exchange(II, II - 1);
      end; // for
    end; // for
    for I := 0 to DuraList.Count - 1 do
    begin
      nDura := nDura + Integer(DuraList.Items[I]);
      Inc(nItemCount);
      if nItemCount >= 5 then
        break;
    end;
    btDura := ROUND(_MIN(5, nItemCount) + _MIN(5, nItemCount) * ((nDura / nItemCount) / 5.0));
    btDc := nDcMin div 5 + nDcMax div 3;
    btSc := nScMin div 5 + nScMax div 3;
    btMc := nMcMin div 5 + nMcMax div 3;
    if DelItemList <> nil then
      User.SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(DelItemList), 0, 0, '');

    if DuraList <> nil then
      DuraList.Free;

  end;
var
  I: Integer;
  bo0D: Boolean;
  UpgradeInfo: pTUpgradeInfo;
  StdItem: pTStdItem;
begin
  bo0D := False;
  for I := 0 to m_UpgradeWeaponList.Count - 1 do
  begin
    UpgradeInfo := m_UpgradeWeaponList.Items[I];
    if UpgradeInfo.sUserName = User.m_sCharName then
    begin
      GotoLable(User, sUPGRADEING, False);
      exit;
    end;
  end;
  if (User.m_UseItems[U_WEAPON].wIndex <> 0) and (User.m_nGold >= g_Config.nUpgradeWeaponPrice) and
    (User.CheckItems(g_Config.sBlackStone) <> nil) then
  begin
    User.DecGold(g_Config.nUpgradeWeaponPrice);
//    if m_boCastle or g_Config.boGetAllNpcTax then UserCastle.IncRateGold(g_Config.nUpgradeWeaponPrice);
    if m_boCastle or g_Config.boGetAllNpcTax then
    begin
      if m_Castle <> nil then
      begin
        TUserCastle(m_Castle).IncRateGold(g_Config.nUpgradeWeaponPrice);
      end
      else
        if g_Config.boGetAllNpcTax then
        begin
          g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
        end;
    end;
    User.GoldChanged();
    New(UpgradeInfo);
    UpgradeInfo.sUserName := User.m_sCharName;
    UpgradeInfo.UserItem := User.m_UseItems[U_WEAPON];
    StdItem := UserEngine.GetStdItem(User.m_UseItems[U_WEAPON].wIndex);

    //004A0B2F
    if StdItem.NeedIdentify = 1 then
      AddGameDataLog('25' + #9 +
        User.m_sMapName + #9 +
        IntToStr(User.m_nCurrX) + #9 +
        IntToStr(User.m_nCurrY) + #9 +
        User.m_sCharName + #9 +
                   //UserEngine.GetStdItemName(User.m_UseItems[U_WEAPON].wIndex) + #9 +
        StdItem.Name + #9 +
        IntToStr(User.m_UseItems[U_WEAPON].MakeIndex) + #9 +
        '1' + #9 +
        '0');
    User.SendDelItems(@User.m_UseItems[U_WEAPON]);
    User.m_UseItems[U_WEAPON].wIndex := 0;
    User.RecalcAbilitys();
    User.FeatureChanged();
    User.SendMsg(User, RM_ABILITY, 0, 0, 0, 0, '');
    sub_4A0218(User.m_ItemList, UpgradeInfo.btDc, UpgradeInfo.btSc, UpgradeInfo.btMc, UpgradeInfo.btDura);
    UpgradeInfo.dtTime := Now();
    UpgradeInfo.dwGetBackTick := GetTickCount();
    m_UpgradeWeaponList.Add(UpgradeInfo);
    SaveUpgradingList();
    bo0D := True;
  end;
  if bo0D then
    GotoLable(User, sUPGRADEOK, False)
  else
    GotoLable(User, sUPGRADEFAIL, False);
end;

procedure TMerchant.GetBackupgWeapon(User: TPlayObject); //004A0CB8
var
  I: Integer;
  UpgradeInfo: pTUpgradeInfo;
  n10, n18, n1C, n90: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  n18 := 0;
  UpgradeInfo := nil;
  if not User.IsEnoughBag then
  begin
//    User.SysMsg('你的背包已经满了，无法再携带任何物品了！！！',0);
    GotoLable(User, sGETBACKUPGFULL, False);
    exit;
  end;
  for I := 0 to m_UpgradeWeaponList.Count - 1 do
  begin
    if pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).sUserName = User.m_sCharName then
    begin
      n18 := 1;
      if ((GetTickCount - pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).dwGetBackTick) > g_Config.dwUPgradeWeaponGetBackTime) or (User.m_btPermission >= 4) then
      begin
        UpgradeInfo := m_UpgradeWeaponList.Items[I];
        m_UpgradeWeaponList.Delete(I);
        SaveUpgradingList();
        n18 := 2;
        break;
      end;
    end;
  end;
  //004A0DC2
  if UpgradeInfo <> nil then
  begin
    case UpgradeInfo.btDura of //
      0..8:
        begin //004A0DE5
//       n14:=_MAX(3000,UpgradeInfo.UserItem.DuraMax shr 1);
          if UpgradeInfo.UserItem.DuraMax > 3000 then
          begin
            Dec(UpgradeInfo.UserItem.DuraMax, 3000);
          end
          else
          begin
            UpgradeInfo.UserItem.DuraMax := UpgradeInfo.UserItem.DuraMax shr 1;
          end;
          if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
            UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
        end;
      9..15:
        begin //004A0E41
          if Random(UpgradeInfo.btDura) < 6 then
          begin
            if UpgradeInfo.UserItem.DuraMax > 1000 then
              Dec(UpgradeInfo.UserItem.DuraMax, 1000);
            if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
              UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
          end;

        end;
      18..255:
        begin
          case Random(UpgradeInfo.btDura - 18) of
            1..4: Inc(UpgradeInfo.UserItem.DuraMax, 1000);
            5..7: Inc(UpgradeInfo.UserItem.DuraMax, 2000);
            8..255: Inc(UpgradeInfo.UserItem.DuraMax, 4000)
          end;
        end;
    end; // case
    if (UpgradeInfo.btDc = UpgradeInfo.btMc) and (UpgradeInfo.btMc = UpgradeInfo.btSc) then
    begin
      n1C := Random(3);
    end
    else
    begin
      n1C := -1;
    end;
    if ((UpgradeInfo.btDc >= UpgradeInfo.btMc) and (UpgradeInfo.btDc >= UpgradeInfo.btSc)) or
      (n1C = 0) then
    begin
      n90 := _MIN(11, UpgradeInfo.btDc);
      n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);
//      n10:=_MIN(85,n90 * 8 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

      if Random(g_Config.nUpgradeWeaponDCRate) < n10 then
      begin //if Random(100) < n10 then begin
        UpgradeInfo.UserItem.btValue[10] := 10;

        if (n10 > 63) and (Random(g_Config.nUpgradeWeaponDCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 11;

        if (n10 > 79) and (Random(g_Config.nUpgradeWeaponDCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 12;
      end
      else
        UpgradeInfo.UserItem.btValue[10] := 1; //004A0F89
    end;

    if ((UpgradeInfo.btMc >= UpgradeInfo.btDc) and (UpgradeInfo.btMc >= UpgradeInfo.btSc)) or
      (n1C = 1) then
    begin
      n90 := _MIN(11, UpgradeInfo.btMc);
      n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

      if Random(g_Config.nUpgradeWeaponMCRate) < n10 then
      begin //if Random(100) < n10 then begin
        UpgradeInfo.UserItem.btValue[10] := 20;

        if (n10 > 63) and (Random(g_Config.nUpgradeWeaponMCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 21;

        if (n10 > 79) and (Random(g_Config.nUpgradeWeaponMCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 22;
      end
      else
        UpgradeInfo.UserItem.btValue[10] := 1;
    end;

    if ((UpgradeInfo.btSc >= UpgradeInfo.btMc) and (UpgradeInfo.btSc >= UpgradeInfo.btDc)) or
      (n1C = 2) then
    begin
      n90 := _MIN(11, UpgradeInfo.btMc);
      n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

      if Random(g_Config.nUpgradeWeaponSCRate) < n10 then
      begin //if Random(100) < n10 then begin
        UpgradeInfo.UserItem.btValue[10] := 30;

        if (n10 > 63) and (Random(g_Config.nUpgradeWeaponSCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 31;

        if (n10 > 79) and (Random(g_Config.nUpgradeWeaponSCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
          UpgradeInfo.UserItem.btValue[10] := 32;
      end
      else
        UpgradeInfo.UserItem.btValue[10] := 1;
    end;
    New(UserItem);
    UserItem^ := UpgradeInfo.UserItem;
    DisPose(UpgradeInfo);
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    //004A120E
    if StdItem.NeedIdentify = 1 then
      AddGameDataLog('24' + #9 +
        User.m_sMapName + #9 +
        IntToStr(User.m_nCurrX) + #9 +
        IntToStr(User.m_nCurrY) + #9 +
        User.m_sCharName + #9 +
                   //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
        StdItem.Name + #9 +
        IntToStr(UserItem.MakeIndex) + #9 +
        '1' + #9 +
        '0');
    User.AddItemToBag(UserItem);
    User.SendAddItem(UserItem);
  end;
  case n18 of //
    0: GotoLable(User, sGETBACKUPGFAIL, False);
    1: GotoLable(User, sGETBACKUPGING, False);
    2: GotoLable(User, sGETBACKUPGOK, False);
  end; // case

end;

function TMerchant.GetUserPrice(PlayObject: TPlayObject; nPrice: Integer): Integer; //0049F6E0
var
  n14: Integer;
begin
  {
  if m_boCastle then begin
    if UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then begin
      n14:=_MAX(60,ROUND(m_nPriceRate * 8.0000000000000000001e-1));//80%
      Result:=ROUND(nPrice / 1.0e2 * n14); //100
    end else begin
      Result:=ROUND(nPrice / 1.0e2 * m_nPriceRate);
    end;
  end else begin
    Result:=ROUND(nPrice / 1.0e2 * m_nPriceRate);
  end;
  }
  if m_boCastle then
  begin
//    if UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then begin
    if (m_Castle <> nil) and TUserCastle(m_Castle).IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then
    begin
      n14 := _MAX(60, ROUND(m_nPriceRate * (g_Config.nCastleMemberPriceRate / 100))); //80%
      Result := ROUND(nPrice / 100 * n14); //100
    end
    else
    begin
      Result := ROUND(nPrice / 100 * m_nPriceRate);
    end;
  end
  else
  begin
    Result := ROUND(nPrice / 100 * m_nPriceRate);
  end;
end;

procedure TMerchant.UserSelect(PlayObject: TPlayObject; sData: string); //004A1820
  procedure SuperRepairItem(User: TPlayObject); //004A159C
  begin
    User.SendMsg(Self, RM_SENDUSERSREPAIR, 0, Integer(Self), 0, 0, '');
  end;
  procedure BuyItem(User: TPlayObject; nInt: integer); //004A1378
  var
    I, n10, nStock, nPrice: Integer;
    nSubMenu: ShortInt;
    sSendMsg, sName: string;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    List14: TList;

    pClientItem:PTClientItem;
  begin
    sSendMsg := '';
    sSendMsg :='';
    n10 := 0;
    PlayObject.m_NPC1:=Self;
    for I := 0 to m_FastGoodList.Count - 1 do
    begin
      pClientItem:=pTClientItem(m_FastGoodList[i]);
       sSendMsg := sSendMsg  + IntToStr(pClientItem.MakeIndex)+  '/' +pClientItem.S.Name+ '/' +  IntToStr(pClientItem^.S.Price ) + '/';
      Inc(n10);
    end; // for
    if n10>0 then
     User.SendDefMessage(SM_CHANGELIGHT,Integer(Self),n10,0,0,sSendMsg);
//     User.SendMsg(Self, RM_SENDGOODSLIST, 0, Integer(Self), n10, 0, sSendMsg);
    n10 := 0;

   sSendMsg :='';


    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List14 := TList(m_GoodsList.Items[i]);

      if List14.count <= 0 then
        continue; //
      UserItem := List14.Items[0];
      if UserItem = nil then
      begin //==2006,8,3  B7抱错
        List14.Delete(0); //
        continue; //
      end; //
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then
      begin
        //取自定义物品名称
        sName := '';
        if UserItem.btValue[13] = 1 then
          sName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
        if sName = '' then
          sName :=FilterItemName(StdItem.Name);

        nPrice := GetUserPrice(User, GetItemPrice(UserItem.wIndex));
        nStock := List14.Count;
        if (StdItem.StdMode <= 4) or
          (StdItem.StdMode = 42) or
          (StdItem.StdMode = 31) then
          nSubMenu := 0
        else
          nSubMenu := 1;
 //        sSendMsg:=sSendMsg+'/'+Encodebuffer(@stditem,SizeOf(TStdItem));
       sSendMsg := sSendMsg + sName + '/' + IntToStr(nSubMenu) + '/' + IntToStr(nPrice) + '/' + IntToStr(nStock) + '/';
        Inc(n10);
      end;
    end; // for
    User.SendMsg(Self, RM_SENDGOODSLIST, 0, Integer(Self), n10, 0, sSendMsg);
  end;
  procedure FastBuyItem(User: TPlayObject; nInt: integer); //004A1378
  var
    I, n10: Integer;

    sSendMsg: string;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    List14: TList;

    pClientItem:PTClientItem;
    ClientItem:array of TClientItem;
  begin
    sSendMsg := '';
    n10 := 0;
    SetLength(ClientItem,m_FastGoodList.Count+m_GoodsList.Count);
    for I := 0 to m_FastGoodList.Count - 1 do
    begin
      pClientItem:=pTClientItem(m_FastGoodList[i]);
      ClientItem[i]:=pClientItem^;
      Inc(n10);
    end; // for
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List14 := TList(m_GoodsList.Items[i]);
      if n10>=Length(ClientItem) then Break;
      if List14.count <= 0 then
        continue; //
      UserItem := List14.Items[0];
      if UserItem = nil then
      begin //==2006,8,3  B7抱错
        List14.Delete(0); //
        continue; //
      end; //
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);

      if StdItem <> nil then
      begin
       ClientItem[n10].S:=StdItem^;
      ClientItem[n10].MakeIndex:=Useritem.MakeIndex;
      ClientItem[n10].Dura:=UserItem.Dura;
      ClientItem[n10].DuraMax:=Useritem.DuraMax;
      ClientItem[n10].DarkProperty:=UserItem.DarkProp;
        Inc(n10);
      end;
    end; // for


     sSendMsg :=EncodeBuffer(@ClientItem[0],SizeOf(TclientItem)*n10);

    User.SendMsg(Self, RM_SENDFASTGOODSLIST , 0, Integer(Self), n10, 0, sSendMsg);
  end;
  procedure SellItem(User: TPlayObject); //004A1544
  begin
    User.SendMsg(Self, RM_SENDUSERSELL, 0, Integer(Self), 0, 0, '');
  end;
  procedure RepairItem(User: TPlayObject); //004A1570
  begin
    User.SendMsg(Self, RM_SENDUSERREPAIR, 0, Integer(Self), 0, 0, '');
  end;
  procedure MakeDurg(User: TPlayObject); //004A16A0
  var
    I: Integer;
    List14: TList;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    sSendMsg: string;



  begin
    sSendMsg := '';
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List14 := TList(m_GoodsList.Items[i]);
     //  if List14.Count <= 0 then Continue; //0807 增加，防止在制药物品列表为空时出错
     // UserItem:=List14.Items[0];

      if List14.count <= 0 then
        continue; //
      UserItem := List14.Items[0];
      if UserItem = nil then
      begin //==2006,8,3  B7抱错
        List14.Delete(0); //
        continue; //
      end; //

      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then
      begin
        sSendMsg := sSendMsg + StdItem.Name + '/' + IntToStr(0) + '/' + IntToStr(g_Config.nMakeDurgPrice) + '/' + IntToStr(1) + '/';
      end;
    end;
    if sSendMsg <> '' then
      User.SendMsg(Self, RM_USERMAKEDRUGITEMLIST, 0, Integer(Self), 0, 0, sSendMsg);
  end;
  procedure ItemPrices(User: TPlayObject); //
  begin

  end;
  procedure Storage(User: TPlayObject); //004A1648
  begin
    if User<>nil then
    Begin
      if User.boPneumastorage then
        if User.Ysplayer=nil then
        begin
         User.SendMsg(self, RM_MENU_OK, 0, Integer(user), 0, 0, '请先将元神召唤出来'); //请稍候再交易

          Exit;
        end;
      User.SendMsg(Self, RM_USERSTORAGEITEM, 0, Integer(Self), 0, 0, '');
    End;
  end;
  procedure GetBack(User: TPlayObject); //004A1674
  begin
        if User.boPneumastorage then
        if User.Ysplayer=nil then
        begin
          User.SendMsg(self, RM_MENU_OK, 0, Integer(user), 0, 0, '请先将元神召唤出来'); //请稍候再交易
          Exit;
        end;
    User.SendMsg(Self, RM_USERGETBACKITEM, 0, Integer(Self), 0, 0, '');
  end;
var
  sLabel, s18, sMsg: string;
  boCanJmp: Boolean;
  nv:array[0..1] of integer;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::UserSelect... Data: %s';
begin //004A1820
  inherited;
  if not (ClassNameIs(TMerchant.ClassName)) then
    exit; //如果类名不是 TMerchant 则不执行以下处理函数

  try
//    PlayObject.m_nScriptGotoCount:=0;
//    if not m_boCastle or not UserCastle.m_boUnderWar then begin
    if not m_boCastle or not ((m_Castle <> nil) and TUserCastle(m_Castle).m_boUnderWar) then
    begin
      if not PlayObject.m_boDeath and (sData <> '') and (sData[1] = '@') then
      begin
        sMsg := GetValidStr3(sData, sLabel, [#13]);
        s18 := '';
        PlayObject.m_sScriptLable := sData;
        boCanJmp := PlayObject.LableIsCanJmp(sLabel, m_bocallboard);
        if CompareText(sLabel, sSL_SENDMSG) = 0 then
        begin
          if sMsg = '' then
            exit;
        end;
        GotoLable(PlayObject, sLabel, not boCanJmp);
        if not boCanJmp then
          exit;
   //////hint 添加 脚本命令
      {
         if CompareText(sLabel,'@queryvalue') = 0 then begin
          if m_boSendmsg then SendQueryMsg(PlayObject,sMsg);
        end else
       }
        PlayObject.m_npc1:=Self;
        if CompareText(sLabel, sSL_SENDMSG) = 0 then
        begin
          if m_boSendmsg then
            SendCustemMsg(PlayObject, sMsg);
        end
        else
          if CompareText(sLabel, sSUPERREPAIR) = 0 then
          begin
            if m_boS_repair then
              SuperRepairItem(PlayObject);
          end
          else
            //
            if CompareText(sLabel,'@commoncodense')=0 then
            begin
               PlayObject.SendDefMessage(SM_MAKESTONE,0,0,0,6,'');
               nv[0]:=Integer(Self);
               PlayObject.m_npc1:=Self;
            end
            else
            if CompareText(sLabel,'@openBless')=0 then

               PlayObject.m_npc1:=Self
            else
            if CompareText(sLabel,'@@gemsmelt')=0 then

               PlayObject.m_npc1:=Self

            else
            if CompareText(sLabel, '@fastbuy') = 0 then
            begin
              if m_boBuy then
                fastBuyItem(PlayObject, 0);
            end
            else
            if CompareText(sLabel, sBUY) = 0 then
            begin
              if m_boBuy then
                BuyItem(PlayObject, 0);
            end
            else
              if CompareText(sLabel, sSELL) = 0 then
              begin
                if m_boSell then
                  SellItem(PlayObject);
              end
              else
                if CompareText(sLabel, sREPAIR) = 0 then
                begin
                  if m_boRepair then
                    RepairItem(PlayObject);
                end
                else
                  if CompareText(sLabel, sMAKEDURG) = 0 then
                  begin
                    if m_boMakeDrug then
                      MakeDurg(PlayObject);
                  end
                  else
                    if CompareText(sLabel, sPRICES) = 0 then
                    begin
                      if m_boPrices then
                        ItemPrices(PlayObject);
                    end
                    else
                      if CompareText(sLabel, sSTORAGE) = 0 then
                      begin
                        if m_boStorage then
                        Begin
                         PlayObject.boPneumastorage:=False;
                          Storage(PlayObject);
                        End;
                      end
                    else
                      //元神包裹
                      if CompareText(sLabel, '@Pneumastorage') = 0 then
                      begin
                        if m_boStorage then
                        Begin
                         PlayObject.boPneumastorage:=True;
                          Storage(PlayObject);
                        End;
                      end
                      else
                        if CompareText(sLabel, sGETBACK) = 0 then
                        begin
                           PlayObject.boPneumastorage:=False;
                          if m_boGetback then
                            GetBack(PlayObject);

                        end
                      else
                        if CompareText(sLabel, '@Pneumagetback') = 0 then
                        begin
                           PlayObject.boPneumastorage:=True;
                          if m_boGetback then
                            GetBack(PlayObject);
                        end
                        else
                          if CompareText(sLabel, sUPGRADENOW) = 0 then
                          begin
                            if m_boUpgradenow then
                              UpgradeWapon(PlayObject);
                          end
                          else
                            if CompareText(sLabel, sGETBACKUPGNOW) = 0 then
                            begin
                              if m_boGetBackupgnow then
                                GetBackupgWeapon(PlayObject);
                            end
                            else
                              if CompareText(sLabel, sGETMARRY) = 0 then
                              begin
                                if m_boGetMarry then
                                  GetBackupgWeapon(PlayObject);
                              end
                              else
                                if CompareText(sLabel, sGETMASTER) = 0 then
                                begin
                                  if m_boGetMaster then
                                    GetBackupgWeapon(PlayObject);
                                end
                                else
                                  if CompareLStr(sLabel, sUSEITEMNAME, Length(sUSEITEMNAME)) then
                                  begin

                                    if m_boUseItemName then
                                      ChangeUseItemName(PlayObject, sLabel, sMsg);
                                  end
                                  else
                                    if CompareText(sLabel, sEXIT) = 0 then
                                    begin
                                      PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
                                    end
                                    else
                                      if CompareText(sLabel, sBACK) = 0 then
                                      begin
                                        if PlayObject.m_sScriptGoBackLable = '' then
                                          PlayObject.m_sScriptGoBackLable := sMAIN;
                                        GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
                                      end;
      end; //004A1A3E
    end; //004A187E
  except
    on e: Exception do
    begin
      MainOutMessage(format(sExceptionMsg, [sData]));
      MainOutMessage(E.Message);
      raise;
    end;

  end;
end;

procedure TMerchant.Run(); //004A2ECC
var
  nCheckCode: Integer;
resourcestring
  sExceptionMsg1 = '[Exception] TMerchant::Run... Code = %d';
  sExceptionMsg2 = '[Exception] TMerchant::Run -> Move Code = %d';
begin
  nCheckCode := 0;
  try

    if (GetTickCount - dwRefillGoodsTick) > 30000 then
    begin
    //if (GetTickCount - dwTick578) > 3000 then begin

      dwRefillGoodsTick := GetTickCount();
      RefillGoods();
    end;
    nCheckCode := 1;
    if (GetTickCount - dwClearExpreUpgradeTick) > 10 * 60 * 1000 then
    begin
      dwClearExpreUpgradeTick := GetTickCount();
      ClearExpreUpgradeListData();
    end;
    nCheckCode := 2;
    if Random(50) = 0 then
    begin
      TurnTo(Random(8));
    end
    else
    begin
      if Random(50) = 0 then
        SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
    nCheckCode := 3;
//    if m_boCastle and (UserCastle.m_boUnderWar)then begin
    if m_boCastle and (m_Castle <> nil) and TUserCastle(m_Castle).m_boUnderWar then
    begin
      if not m_boFixedHideMode then
      begin
        SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
        m_boFixedHideMode := True;
      end;
    end
    else
    begin
      if m_boFixedHideMode then
      begin
        m_boFixedHideMode := False;
        SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      end;
    end;
    nCheckCode := 4;
  except
    on e: Exception do
    begin
      MainOutMessage(format(sExceptionMsg1, [nCheckCode]));
      MainOutMessage(E.Message);
      raise;
    end;

  end;
  try
    if m_boCanMove and (GetTickCount - m_dwMoveTick > m_dwMoveTime * 1000) then
    begin
      m_dwMoveTick := GetTickCount();
      SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      MapRandomMove(m_sMapName, 0);
    end;
  except
    on e: Exception do
    begin
      MainOutMessage(format(sExceptionMsg2, [nCheckCode]));
      MainOutMessage(E.Message);
      raise;
    end;

  end;
  inherited;
end;

function TMerchant.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TMerchant.LoadNPCData; //0049F044
var
  sFile: string;
begin
  sFile := m_sScript + '-' + m_sMapName;
  FrmDB.LoadGoodRecord(Self, sFile);
  FrmDB.LoadGoodPriceRecord(Self, sFile);
  LoadUpgradeList();
end;

procedure TMerchant.SaveComment;
var
  IniFile:TIniFile;
begin
  IniFile:=TIniFile.Create(g_Config.sEnvirDir + 'NpcName.txt');
  IniFile.WriteString('Names',IntToStr(m_nCastle),m_scharName);
  IniFile.WriteString('Comments',IntToStr(m_nCastle),m_sComments);
  IniFile.WriteInteger('Apprs',IntToStr(m_nCastle),m_wappr);
  IniFile.Free;

end;

procedure TMerchant.SaveNPCData;
var
  sFile: string;
begin
  sFile := m_sScript + '-' + m_sMapName;
  FrmDB.SaveGoodRecord(Self, sFile);
  FrmDB.SaveGoodPriceRecord(Self, sFile);
end;

constructor TMerchant.Create; //0049EC70
begin
  inherited;
  m_btRaceImg := RCC_MERCHANT;
  m_wAppr := 0;
  m_nPriceRate := 100;
  m_boCastle := False;
  m_ItemTypeList := TList.Create;
  m_RefillGoodsList := TList.Create;
  m_GoodsList := TList.Create;
  m_FastGoodList:=TList.Create;
  m_RefillFastGoodList := TList.create;
  m_ItemPriceList := TList.Create;
  m_UpgradeWeaponList := TList.Create;
  dwRefillGoodsTick := GetTickCount();
  dwClearExpreUpgradeTick := GetTickCount();
  m_boBuy := False;
  m_boopenBless :=False;
  m_boSell := False;
  m_boMakeDrug := False;
  m_boPrices := False;
  m_boStorage := False;
  m_boGetback := False;
  m_boUpgradenow := False;
  m_boGetBackupgnow := False;
  m_boRepair := False;
  m_boS_repair := False;
  m_boGetMarry := False;
  m_boGetMaster := False;
  m_boUseItemName := False;
  m_dwMoveTick := GetTickCount();
end;

destructor TMerchant.Destroy; //0049ED70
var
  I: Integer;
  II: Integer;
  List: TList;
begin
  if (self.mirrorname = '') or m_boAddtoMapSuccess then
  begin //镜像npc 不需要释放
    m_ItemTypeList.Free;
    for I := 0 to m_RefillGoodsList.Count - 1 do
    begin
      DisPose(pTGoods(m_RefillGoodsList.Items[i]));
    end;
    m_RefillGoodsList.Free;
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List := TList(m_GoodsList.Items[I]);
      for II := 0 to List.Count - 1 do
      begin
        Dispose(pTUserItem(List.Items[II]));
      end;
      List.Free;
    end;
    m_GoodsList.Free;

    for I := 0 to m_ItemPriceList.Count - 1 do
    begin
      Dispose(pTItemPrice(m_ItemPriceList.Items[I]));
    end;
    m_ItemPriceList.Free;
    for I := 0 to m_UpgradeWeaponList.Count - 1 do
    begin
      Dispose(pTUpgradeInfo(m_UpgradeWeaponList.Items[I]));
    end;
    m_UpgradeWeaponList.Free;
  end;
  inherited;
end;

procedure TMerchant.ClearExpreUpgradeListData; //004A01A0
var
  I: Integer;
  UpgradeInfo: pTUpgradeInfo;
begin
  for I := m_UpgradeWeaponList.Count - 1 downto 0 do
  begin
    UpgradeInfo := m_UpgradeWeaponList.Items[I];
    if Integer(ROUND(Now - UpgradeInfo.dtTime)) >= g_Config.nClearExpireUpgradeWeaponDays then
    begin
      Dispose(UpgradeInfo);
      m_UpgradeWeaponList.Delete(I);
    end;
  end;
end;

procedure TMerchant.LoadNPCScript(sFileName:string=''); //0049EF7C
var
  sC: string;
begin
  m_ItemTypeList.Clear;
  m_sPath := sMarket_Def;
  if sFileName='' then
    sC := m_sScript + '-' + m_sMapName
  else
    sC:=sFileName ;
 // if m_sCharName='命运门'  then
 //    g_NPC:=Self;
  FrmDB.LoadScriptFile(Self, sMarket_Def, sC, True);
//  call    sub_49ABE0
end;

procedure TMerchant.Click(PlayObject: TPlayObject); //0049FF24
begin
//  GotoLable(PlayObject,'@main');
  if m_bocallboard then
  Begin
    GotoLable(PlayObject, '@mainleft', false);
    GotoLable(PlayObject, '@mainRight', false);
  End;
  inherited;
end;

procedure TMerchant.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string); //0049FD04
var
  sText: string;

begin
  inherited;
  if sVariable = '$PRICERATE' then
  begin
    sText := IntToStr(m_nPriceRate);
    sMsg := sub_49ADB8(sMsg, '<$PRICERATE>', sText);
  end;
  if sVariable = '$UPGRADEWEAPONFEE' then
  begin
    sText := IntToStr(g_Config.nUpgradeWeaponPrice);
    sMsg := sub_49ADB8(sMsg, '<$UPGRADEWEAPONFEE>', sText);
  end;
  if sVariable = '$USERWEAPON' then
  begin
    if PlayObject.m_UseItems[U_WEAPON].wIndex <> 0 then
    begin
      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
    end
    else
    begin
      sText := '无';
    end;
    sMsg := sub_49ADB8(sMsg, '<$USERWEAPON>', sText);
  end;

end;

function TMerchant.GetUserItemPrice(UserItem: pTUserItem): Integer; //0049F428
var
  n10: Integer;
  StdItem: pTStdItem;
  n20: real;
  nC: Integer;
  n14: Integer;
begin
  n10 := GetItemPrice(UserItem.wIndex);
  if n10 > 0 then
  begin
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and
      (StdItem.StdMode > 4) and
      (StdItem.DuraMax > 0) and
      (UserItem.DuraMax > 0) then
    begin
      if StdItem.StdMode = 40 then
      begin //肉
        if UserItem.Dura <= UserItem.DuraMax then
        begin
          n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
          n10 := _MAX(2, ROUND(n10 - n20));
        end
        else
        begin
          n10 := n10 + ROUND(n10 / UserItem.DuraMax * 2.0 * (UserItem.DuraMax - UserItem.Dura));
        end;
      end; //0049F528
      if (StdItem.StdMode = 43) then
      begin
        if UserItem.DuraMax < 10000 then
          UserItem.DuraMax := 10000;
        if UserItem.Dura <= UserItem.DuraMax then
        begin
          n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
          n10 := _MAX(2, ROUND(n10 - n20));
        end
        else
        begin
          n10 := n10 + ROUND(n10 / UserItem.DuraMax * 1.3 * (UserItem.DuraMax - UserItem.Dura));
        end;
      end; //0049F5C5
      if StdItem.StdMode > 4 then
      begin
        n14 := 0;
        nC := 0;
        while (True) do
        begin
          if (StdItem.StdMode = 5) or (StdItem.StdMode = 6) then
          begin
            if (nC <> 4) or (nC <> 9) then
            begin
              if nC = 6 then
              begin
                if UserItem.btValue[nC] > 10 then
                begin
                  n14 := n14 + (UserItem.btValue[nC] - 10) * 2;
                end;
              end
              else
              begin
                n14 := n14 + UserItem.btValue[nC];
              end;
            end;
          end
          else
          begin
            Inc(n14, UserItem.btValue[nC]);
          end;
          Inc(nC);
          if nC >= 8 then
            break;
        end; // while
        if n14 > 0 then
        begin
          n10 := n10 div 5 * n14;
        end;
        n10 := ROUND(n10 / StdItem.DuraMax * UserItem.DuraMax);
        n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
        n10 := _MAX(2, ROUND(n10 - n20));
      end; //0049F6BF
    end; //0049F6BF
  end;
  Result := n10;
end;

procedure TMerchant.ClientBuyItem(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer); //004A2334
var
  I, II: Integer;
  bo29: Boolean;
  List20: TList;

  UserItem: pTUserItem;
  StdItem: pTStdItem;
  n1C, nPrice: Integer;
  sUserItemName: string;
begin
  bo29 := False;
  n1C := 1;
  for I := 0 to m_GoodsList.Count - 1 do
  begin
    if bo29 or (bo574) then
      break;
    List20 := TList(m_GoodsList.Items[i]);
  //   if List20.Count <= 0 then Continue;
    if List20.count <= 0 then
      continue; //
    UserItem := List20.Items[0];
    if UserItem = nil then
    begin //==2006,8,3  B7抱错
      List20.Delete(0); //
      continue; //
    end; //

  //  UserItem:=List20.Items[0];
    //取自定义物品名称
    sUserItemName := '';
    if UserItem.btValue[13] = 1 then
      sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    if sUserItemName = '' then
      sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then
    begin
      if PlayObject.IsAddWeightAvailable(StdItem.Weight) then
      begin
        if sUserItemName = sItemName then
        begin
          for II := 0 to List20.Count - 1 do
          begin
            UserItem := List20.Items[II];
            if (StdItem.StdMode <= 4) or
              (StdItem.StdMode = 42) or
              (StdItem.StdMode = 31) or
              (UserItem.MakeIndex = nInt) then
            begin

              nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
              if (PlayObject.m_nGold >= nPrice) and (nPrice > 0) then
              begin
                if PlayObject.AddItemToBag(UserItem) then
                begin
                  Dec(PlayObject.m_nGold, nPrice);
                  if m_boCastle or g_Config.boGetAllNpcTax then
                  begin
                    if m_Castle <> nil then
                    begin
                      TUserCastle(m_Castle).IncRateGold(nPrice);
                    end
                    else
                      if g_Config.boGetAllNpcTax then
                      begin
                        g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
                      end;
                  end;
                  {
                  if m_boCastle or g_Config.boGetAllNpcTax then
                    UserCastle.IncRateGold(nPrice);
                  }
                  PlayObject.SendAddItem(UserItem);
                  //004A25DC
                  if StdItem.NeedIdentify = 1 then
                    AddGameDataLog('9' + #9 +
                      PlayObject.m_sMapName + #9 +
                      IntToStr(PlayObject.m_nCurrX) + #9 +
                      IntToStr(PlayObject.m_nCurrY) + #9 +
                      PlayObject.m_sCharName + #9 +
                                 //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                      StdItem.Name + #9 +
                      IntToStr(UserItem.MakeIndex) + #9 +
                      '1' + #9 +
                      m_sCharName);

                  List20.Delete(II);
                  if List20.Count <= 0 then
                  begin
                    List20.Free;
                    m_GoodsList.Delete(i);
                  end;
                  n1C := 0;
                end
                else
                  n1C := 2;
              end
              else
                n1C := 3;
              bo29 := True;
              break;
            end;
          end;
        end;
      end
      else
        n1C := 2; //004A2639
    end;
  end; // for
  if n1C = 0 then
  begin
    PlayObject.SendMsg(Self, RM_BUYITEM_SUCCESS, 0, PlayObject.m_nGold, nInt, 0, '');
  end
  else
  begin
    PlayObject.SendMsg(Self, RM_BUYITEM_FAIL, 0, n1C, 0, 0, '');
  end;

end;

procedure TMerchant.ClientFastBuyItem(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer;nMakeIndex:Integer=-1); //004A2334
var



 
  UserItem: pTUserItem;

   nPrice: Integer;
   i:Integer;
  pClientItem:pTClientItem;
begin
  if nMakeIndex<>-1 then
  begin
    for I := 0 to m_FastGoodList.Count - 1 do
    begin
       pClientItem :=pTClientItem(m_FastGoodList[i]);
       if pClientItem.MakeIndex=nMakeIndex then
       begin
         nInt:=i;
         sItemName:=pClientItem.S.Name;
         Break;
       end;
    end;
      

  end;

  if nInt<m_FastGoodList.Count then
  begin
    pClientItem :=pTClientItem(m_FastGoodList[nInt]);
    if (pClientItem.S.Name=sItemName) then
    begin
       nPrice :=pClientItem.S.Price;
        if (PlayObject.m_nGameGold >= nPrice) and (nPrice > 0) then
        Begin
           New(UserItem);
           if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
           Begin
             UserItem.MakeIndex:= GetItemNumberEx();
             if PlayObject.AddItemToBag(UserItem) then
             begin
                Dec(PlayObject.m_nGameGold, nPrice);
                PlayObject.SendAddItem(UserItem);
                PlayObject.GameGoldChanged;

             end;
           end
           else
             Dispose(UserItem);
       end;
    end;



    end;
  



end;
procedure TMerchant.ClientGetDetailGoodsList(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer); //004A26F0
var
  I, II, n18: Integer;
  List20: TList;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  ClientItem: TClientItem;

  s1C: string;
  body: array[0..10000] of char;
begin
  fillchar(body, sizeof(body), 0);

  begin
    n18 := 0;
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      List20 := TList(m_GoodsList.Items[i]);


      if List20.count <= 0 then
        continue; //
      UserItem := List20.Items[0];
      if UserItem = nil then
      begin
        List20.Delete(0); //
        continue; //
      end; //


      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (StdItem.Name = sItemName) then
      begin
        if (List20.Count - 1) < nInt then
        begin
          nInt := _MAX(0, List20.Count - 10);
        end;
        for II := List20.Count - 1 downto 0 do
        begin
          UserItem := List20.Items[II];
          ClientItem.S := Stditem^;

          ClientItem.Dura := UserItem.Dura;
          ClientItem.DuraMax := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
          ClientItem.MakeIndex := UserItem.MakeIndex;
          ClientItem.DarkProperty :=UserItem.DarkProp;

          copymemory(@body[SizeOf(TClientItem) * n18], @ClientItem, SizeOf(TClientItem));


          Inc(n18);
          if n18 >= 10 then
            break;
        end;
        break;
      end;
    end;
    s1C := EncodeBuffer(@body, SizeOf(TClientItem) * n18);
    PlayObject.SendMsg(Self, RM_SENDDETAILGOODSLIST, 0, Integer(Self), n18, nInt, s1C);

  end;
end;

procedure TMerchant.ClientQuerySellPrice(PlayObject: TPlayObject;
  UserItem: pTUserItem); //004A1B84
var
  nC: Integer;
begin
  nC := GetSellItemPrice(GetUserItemPrice(UserItem));
  if (nC >= 0) then
  begin
    PlayObject.SendMsg(Self, RM_SENDBUYPRICE, 0, nC, 0, 0, '');
  end
  else
  begin
    PlayObject.SendMsg(Self, RM_SENDBUYPRICE, 0, 0, 0, 0, '');
  end;
end;

function TMerchant.GetSellItemPrice(nPrice: integer): Integer; //0049F7A4
begin
  Result := ROUND(nPrice / 2.0);
end;

function TMerchant.ClientSellItem(PlayObject: TPlayObject;
  UserItem: pTUserItem): Boolean; //004A1CD8
  function sub_4A1C84(UserItem: pTUserItem): Boolean;
  var
    StdItem: pTStdItem;
  begin
    Result := True;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and ((StdItem.StdMode = 25) or (StdItem.StdMode = 30)) then
    begin
      if UserItem.Dura < 4000 then
        Result := False;
    end;
  end;
var
  nPrice: integer;
  StdItem: pTStdItem;
begin //004A1CD8
  Result := False;
  nPrice := GetSellItemPrice(GetUserItemPrice(UserItem));
  if (nPrice > 0) and (not bo574) and
    sub_4A1C84(UserItem) then
  begin
    if PlayObject.IncGold(nPrice) then
    begin
      {
      if m_boCastle or g_Config.boGetAllNpcTax then
        UserCastle.IncRateGold(nPrice);
      }
      if m_boCastle or g_Config.boGetAllNpcTax then
      begin
        if m_Castle <> nil then
        begin
          TUserCastle(m_Castle).IncRateGold(nPrice);
        end
        else
          if g_Config.boGetAllNpcTax then
          begin
            g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
          end;
      end;
      PlayObject.SendMsg(Self, RM_USERSELLITEM_OK, 0, PlayObject.m_nGold, 0, 0, '');
      AddItemToGoodsList(UserItem);
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      //004A1E95
      if StdItem.NeedIdentify = 1 then
        AddGameDataLog('10' + #9 +
          PlayObject.m_sMapName + #9 +
          IntToStr(PlayObject.m_nCurrX) + #9 +
          IntToStr(PlayObject.m_nCurrY) + #9 +
          PlayObject.m_sCharName + #9 +
                     //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
          StdItem.Name + #9 +
          IntToStr(UserItem.MakeIndex) + #9 +
          '1' + #9 +
          m_sCharName);
      Result := True;
    end
    else
    begin //004A1EA0
      PlayObject.SendMsg(Self, RM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
    end;
  end
  else
  begin
    PlayObject.SendMsg(Self, RM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
  end;

end;

function TMerchant.AddItemToGoodsList(UserItem: pTUserItem): Boolean; //004A1BF8
var

  ItemList: TList;
begin
  Result := False;
  if UserItem.Dura <= 0 then
    exit;
  ItemList := GetRefillList(UserItem.wIndex);
  if ItemList = nil then
  begin
    ItemList := TList.Create;
    m_GoodsList.Add(ItemList);
  end;
  ItemList.Insert(0, UserItem);
  Result := True;
end;

procedure TMerchant.ClientMakeDrugItem(PlayObject: TPlayObject;
  sItemName: string); //004A2B6C
  function sub_4A28FC(PlayObject: TPlayObject; sItemName: string): Boolean; //004A28FC
  var
    I, II, n1C: Integer;
    List10: TStringList;
    s20: string;
    List28: TStringList;
    UserItem: pTUserItem;
  begin
    Result := False;
    List10 := GetMakeItemInfo(sItemName);
    if List10 = nil then
      exit;
    Result := True;
    for I := 0 to List10.Count - 1 do
    begin
      s20 := List10.Strings[I];
      n1C := Integer(List10.Objects[I]);
      for II := 0 to PlayObject.m_ItemList.Count - 1 do
      begin
        if UserEngine.GetStdItemName(pTUserItem(PlayObject.m_ItemList.Items[II]).wIndex) = s20 then
          Dec(n1C);
      end;
      if n1C > 0 then
      begin
        Result := False;
        break;
      end;
    end; // for
    if Result then
    begin
      List28 := nil;
      for I := 0 to List10.Count - 1 do
      begin
        s20 := List10.Strings[I];
        n1C := Integer(List10.Objects[I]);
        for II := PlayObject.m_ItemList.Count - 1 downto 0 do
        begin
          if n1C <= 0 then
            break;
          UserItem := PlayObject.m_ItemList.Items[II];
          if UserEngine.GetStdItemName(UserItem.wIndex) = s20 then
          begin
            if List28 = nil then
              List28 := TStringList.Create;
            List28.AddObject(s20, TObject(UserItem.MakeIndex));
            Dispose(UserItem);
            PlayObject.m_ItemList.Delete(II);
            Dec(n1C);
          end;
        end;
      end;
      if List28 <> nil then
      begin
        PlayObject.SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(List28), 0, 0, '');
      end;
    end;
  end;
var
  I: Integer;
  List1C: TList;
  MakeItem, UserItem: pTUserItem;
  StdItem: pTStdItem;
  n14: Integer;
begin
  n14 := 1;
  for I := 0 to m_GoodsList.Count - 1 do
  begin
    List1C := TList(m_GoodsList.Items[I]);
 //    if List1C.Count <= 0 then Continue;
 //   MakeItem:=List1C.Items[0];
    if List1C.count <= 0 then
      continue; //
    MakeItem := List1C.Items[0];
    if MakeItem = nil then
    begin //==2006,8,3  B7抱错
      List1C.Delete(0); //
      continue; //
    end; //


    StdItem := UserEngine.GetStdItem(MakeItem.wIndex);
    if (StdItem <> nil) and (StdItem.Name = sItemName) then
    begin
      if PlayObject.m_nGold >= g_Config.nMakeDurgPrice then
      begin
        if sub_4A28FC(PlayObject, sItemName) then
        begin
          New(UserItem);
          UserEngine.CopyToUserItemFromName(sItemName, UserItem);
          if PlayObject.AddItemToBag(UserItem) then
          begin
            Dec(PlayObject.m_nGold, g_Config.nMakeDurgPrice);
            PlayObject.SendAddItem(UserItem);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //004A2D89
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('2' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                     //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                StdItem.Name + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
            n14 := 0;
            break;
          end
          else
          begin
            DisPose(UserItem);
            n14 := 2;
          end;
        end
        else
          n14 := 4;
      end
      else
        n14 := 3; //004A2DB4
    end;
  end; // for
  if n14 = 0 then
  begin
    PlayObject.SendMsg(Self, RM_MAKEDRUG_SUCCESS, 0, PlayObject.m_nGold, 0, 0, '');
  end
  else
  begin
    PlayObject.SendMsg(Self, RM_MAKEDRUG_FAIL, 0, n14, 0, 0, '');
  end;

end;

procedure TMerchant.ClientQueryRepairCost(PlayObject: TPlayObject;
  UserItem: pTUserItem); //004A1F30
var
  nPrice, nRepairPrice: Integer;
begin
  nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
  if (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) then
  begin
    if UserItem.DuraMax > 0 then
    begin
      nRepairPrice := ROUND(nPrice div 3 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
    end
    else
    begin
      nRepairPrice := nPrice;
    end;
    if (PlayObject.m_sScriptLable = sSUPERREPAIR) then
    begin
      if m_boS_repair then
        nRepairPrice := nRepairPrice * g_Config.nSuperRepairPriceRate {3}
      else
        nRepairPrice := -1;
    end
    else
    begin
      if not m_boRepair then
        nRepairPrice := -1;
    end;
    PlayObject.SendMsg(Self, RM_SENDREPAIRCOST, 0, nRepairPrice, 0, 0, '');
  end
  else
  begin
    PlayObject.SendMsg(Self, RM_SENDREPAIRCOST, 0, -1, 0, 0, '');
  end;
end;

function TMerchant.ClientRepairItem(PlayObject: TPlayObject;
  UserItem: pTUserItem): Boolean; //004A2024
var
  nPrice, nRepairPrice: Integer;
  StdItem: pTStditem;
  boCanRepair: Boolean;
begin
  Result := False;
  boCanRepair := True;
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (PlayObject.m_sScriptLable = sSUPERREPAIR)  then
  begin
    boCanRepair :=  m_boS_repair and (not GetBoValue(UserItem,UserItem.wIndex,8));

  end
  else
  begin
    boCanRepair := m_boRepair and (not GetBoValue(UserItem,UserItem.wIndex,7));
  end;

  if PlayObject.m_sScriptLable = '@fail_s_repair' then
  begin
    SendMsgToUser(PlayObject, 'Sorry, I cant special repair this item\ \ \<Main/@main>');
    PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
    exit;
  end;
  nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
  if PlayObject.m_sScriptLable = sSUPERREPAIR then
  begin
    nPrice := nPrice * g_Config.nSuperRepairPriceRate {3};
  end;
  
  if StdItem <> nil then
  begin


    if boCanRepair and (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) and (StdItem.StdMode <> 43) then
    begin
      if UserItem.DuraMax > 0 then
      begin
        nRepairPrice := ROUND(nPrice div 3 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
      end
      else
      begin
        nRepairPrice := nPrice;
      end;
      if PlayObject.DecGold(nRepairPrice) then
      begin
//        if m_boCastle or g_Config.boGetAllNpcTax then UserCastle.IncRateGold(nRepairPrice);
        if m_boCastle or g_Config.boGetAllNpcTax then
        begin
          if m_Castle <> nil then
          begin
            TUserCastle(m_Castle).IncRateGold(nRepairPrice);
          end
          else
            if g_Config.boGetAllNpcTax then
            begin
              g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
            end;
        end;
        if PlayObject.m_sScriptLable = sSUPERREPAIR then
        begin
          UserItem.Dura := UserItem.DuraMax;
          PlayObject.SendMsg(Self, RM_USERREPAIRITEM_OK, 0, PlayObject.m_nGold, UserItem.Dura, UserItem.DuraMax, '');
          GotoLable(PlayObject, sSUPERREPAIROK, False);
        end
        else
        begin
          Dec(UserItem.DuraMax, (UserItem.DuraMax - UserItem.Dura) div g_Config.nRepairItemDecDura {30});
          UserItem.Dura := UserItem.DuraMax;
          PlayObject.SendMsg(Self, RM_USERREPAIRITEM_OK, 0, PlayObject.m_nGold, UserItem.Dura, UserItem.DuraMax, '');
          GotoLable(PlayObject, sREPAIROK, False);
        end;
        Result := True;
      end
      else
        PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, ''); //004A2238
    end
    else
      PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, ''); //004A2253
  end;

end;

procedure TMerchant.ClearScript;
begin
  m_boBuy := False;
  m_boSell := False;
  m_boMakeDrug := False;
  m_boPrices := False;
  m_boStorage := False;
  m_boGetback := False;
  m_boUpgradenow := False;
  m_boGetBackupgnow := False;
  m_boRepair := False;
  m_boS_repair := False;
  m_boGetMarry := False;
  m_boGetMaster := False;
  m_boUseItemName := False;
  inherited;
end;

procedure TMerchant.LoadUpgradeList; //004A006C
var
  I: Integer;
begin
  for I := 0 to m_UpgradeWeaponList.Count - 1 do
  begin
    Dispose(pTUpgradeInfo(m_UpgradeWeaponList.Items[I]));
  end; // for
  m_UpgradeWeaponList.Clear;
  try
    //FrmDB.LoadUpgradeWeaponRecord(m_sCharName,m_UpgradeWeaponList);
    FrmDB.LoadUpgradeWeaponRecord(m_sScript + '-' + m_sMapName, m_UpgradeWeaponList);
  except
    MainOutMessage('Failure in loading upgradinglist - ' + m_sCharName);
  end;
end;

procedure TMerchant.GetMarry(PlayObject: TPlayObject; sDearName: string);
var
  MarryHuman: TPlayObject;
begin
  MarryHuman := UserEngine.GeTPlayObject(sDearName);
  if (MarryHuman <> nil) and
    (MarryHuman.m_PEnvir = PlayObject.m_PEnvir) and
    (abs(PlayObject.m_nCurrX - MarryHuman.m_nCurrX) < 5) and
    (abs(PlayObject.m_nCurrY - MarryHuman.m_nCurrY) < 5) then
  begin
    SendMsgToUser(MarryHuman, PlayObject.m_sCharName + ' 向你求婚，你是否愿意嫁给他为妻？');
  end
  else
  begin
    Self.SendMsgToUser(PlayObject, sDearName + ' 没有在你身边，你的请求无效！！！');
  end;

end;

procedure TMerchant.GetMaster(PlayObject: TPlayObject; sMasterName: string);
begin

end;

procedure TMerchant.SendqueryMsg(PlayObject: TPlayObject; sMsg: string);
begin
  // PlayObject.SendDefMessage(4627,0,769, 0,0, sMsg);//输入数据

end;


procedure TMerchant.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
  inherited;

end;
//清除临时文件，包括交易库存，价格表

procedure TMerchant.ClearData;
var
  I, II: Integer;
  UserItem: pTUserItem;
  ItemList: TList;
  ItemPrice: pTItemPrice;
resourcestring
  sExceptionMsg = '[Exception] TMerchant::ClearData';
begin
  try
    for I := 0 to m_GoodsList.Count - 1 do
    begin
      ItemList := TList(m_GoodsList.Items[I]);
      for II := 0 to ItemList.Count - 1 do
      begin
        UserItem := ItemList.Items[II];
        Dispose(UserItem);
      end;
      ItemList.Free;
    end;
    m_GoodsList.Clear;
    for I := 0 to m_ItemPriceList.Count - 1 do
    begin
      ItemPrice := m_ItemPriceList.Items[I];
      Dispose(ItemPrice);
    end;
    m_ItemPriceList.Clear;
    SaveNPCData();
  except
    on e: Exception do
    begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
      raise;
    end;

  end;
end;


procedure TNormNpc.ChangePetName(PlayObject: TPlayObject; sItemName: string);
var


  UserItem: pTUserItem;




begin
//兽名

  if  PlayObject.M_monitemmake = 0 then
  begin
    exit;
  end;
  UserItem:=PlayObject.GetItems(PlayObject.M_monitemmake);
  if UserItem=nil then exit;
  if UserItem.btValue[13] >0 then
  begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
  end;
  if sItemName <> '' then
  begin
      ItemUnit.AddCustomItemName(UserItem.MakeIndex, UserItem.wIndex, sItemName);
      UserItem.btValue[13] := 2;
  end
  else
  begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      UserItem.btValue[13] := 0;
  end;
  ItemUnit.SaveCustomItemName();
  PlayObject.SendMsg(PlayObject, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
  PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, '');
 if  PlayObject.m_PetBaseObject<>nil then
     PlayObject.m_PetBaseObject.RefShowName;

end;

procedure TMerchant.ChangeUseItemName(PlayObject: TPlayObject;
  sLabel, sItemName: string);
var
  sWhere: string;
  btWhere: Byte;
  UserItem: pTUserItem;

  sMsg: string;


begin
  if not PlayObject.m_boChangeItemNameFlag then
  begin
    exit;
  end;
  PlayObject.m_boChangeItemNameFlag := False;

  sWhere := Copy(sLabel, length(sUSEITEMNAME) + 1, length(sLabel) - length(sUSEITEMNAME));
  btWhere := Str_ToInt(sWhere, -1);
  if btWhere in [Low(THumanUseItems)..High(THumanUseItems)] then
  begin
    UserItem := @PlayObject.m_UseItems[btWhere];
    if UserItem.wIndex = 0 then
    begin
      sMsg := format(g_sYourUseItemIsNul, [GetUseItemName(btWhere)]);
      PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      exit;
    end;

    if UserItem.btValue[13] = 1 then
    begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    end;

    if sItemName <> '' then
    begin
      ItemUnit.AddCustomItemName(UserItem.MakeIndex, UserItem.wIndex, sItemName);
      UserItem.btValue[13] := 1;
    end
    else
    begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      UserItem.btValue[13] := 0;
    end;
    ItemUnit.SaveCustomItemName();
    PlayObject.SendMsg(PlayObject, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
    PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, '');
  end;

end;

{ TTrainer }

constructor TTrainer.Create; //004A385C
begin
  inherited;
  m_dw568 := GetTickCount();
  n56C := 0;
  n570 := 0;
end;

destructor TTrainer.Destroy;
begin

  inherited;
end;

function TTrainer.Operate(ProcessMsg: pTProcessMessage): Boolean; //004A38C4
begin
  Result := False;
  if (ProcessMsg.wIdent = RM_STRUCK) or (ProcessMsg.wIdent = RM_MAGSTRUCK) then
  begin
//  if (ProcessMsg.wIdent = RM_10101) or (ProcessMsg.wIdent = RM_MAGSTRUCK) then begin

    if (ProcessMsg.BaseObject = Self) { and (ProcessMsg.nParam3 <> 0)} then
    begin
      Inc(n56C, ProcessMsg.wParam);
      m_dw568 := GetTickCount();
      Inc(n570);
      if n570>0 then
      ProcessSayMsg('破坏力为 ' + IntToStr(ProcessMsg.wParam) + ',平均值为 ' + IntToStr(n56C div n570));
    end;
  end;
  if ProcessMsg.wIdent = RM_MAGSTRUCK then
    Result := inherited Operate(ProcessMsg);
end;

procedure TTrainer.Run; //004A3A18
begin
  if n570 > 0 then
  begin
    if (GetTickCount - m_dw568) > 3 * 1000 then
    begin
     if n570>0 then
         ProcessSayMsg('总破坏力为  ' + IntToStr(n56C) + ',平均值为 ' + IntToStr(n56C div n570));
      n570 := 0;
      n56C := 0;
    end;
  end;
  inherited;
end;


{ TNormNpc }
procedure TNormNpc.ActionOfUpGradeUserITEMEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nItemPos: Integer;
  nDarkPos: Integer;
  nDarkValue: Word;
  nItemDarkValue: Word;
  DarkProperty: TDarkProperty;
  UserItem:pTUserItem;
  pAttachMagicRCD : TAttachMagicRCD;
  procedure setDark(npos, nvalue: Word);

  begin
    nvalue := nvalue and $F;
    case npos of
      0..12:
      begin
       UserItem.btValue[npos]:=nItemDarkValue;
      end;
         13:
     UserItem.Dura := nItemDarkValue;
   14:
     UserItem.DuraMax := nItemDarkValue;
      19: DarkProperty.DMagic := nvalue;
      20: DarkProperty.DDC := (DarkProperty.DDC and $F0) + nvalue;
      21: DarkProperty.DDC := (DarkProperty.DDC and $0F) + nValue shl 4;
      22: DarkProperty.DMC := (DarkProperty.DMC and $F0) + nvalue;
      23: DarkProperty.DMC := (DarkProperty.DMC and $0F) + nValue shl 4;
      24: DarkProperty.DSC := (DarkProperty.DSC and $F0) + nvalue;
      25: DarkProperty.DSC := (DarkProperty.DSC and $0F) + nValue shl 4;
      26: DarkProperty.DAC := (DarkProperty.DAC and $F0) + nvalue;
      27: DarkProperty.DAC := (DarkProperty.DAC and $0F) + nValue shl 4;
      28: DarkProperty.DMAC := (DarkProperty.DMAC and $F0) + nvalue;
      29: DarkProperty.DMAC := (DarkProperty.DMAC and $0F) + nValue shl 4;
      30: DarkProperty.DNEEDLEVEL:=nvalue;
      45:
      Begin
         DarkProperty.btMagicID:=nvalue;
         DarkProperty.btid:=2;
      End;
      46: DarkProperty.btMagicPower:=nvalue;
      31..44:
      begin


             case nDarkPos of

                32:
                  UserItem.AttachMagic.MercenaryJob := nItemDarkValue;
                33:
                  UserItem.AttachMagic.MercenaryState := nItemDarkValue;
                34:
                  UserItem.AttachMagic.DC :=(UserItem.AttachMagic.DC and $F0)+ nItemDarkValue ;
                35:
                  UserItem.AttachMagic.DC :=(UserItem.AttachMagic.DC and $F)+ nItemDarkValue shl 4;
                36:
                  UserItem.AttachMagic.MC := (UserItem.AttachMagic.MC and $F0)+ nItemDarkValue ;
                37:
                  UserItem.AttachMagic.MC := (UserItem.AttachMagic.MC and $F)+ nItemDarkValue shl 4;
                38:
                  UserItem.AttachMagic.SC := (UserItem.AttachMagic.SC and $F0)+ nItemDarkValue ;
                39:
                  UserItem.AttachMagic.SC := (UserItem.AttachMagic.SC and $F)+ nItemDarkValue shl 4;
                40:
                  UserItem.AttachMagic.AC := (UserItem.AttachMagic.AC and $F0)+ nItemDarkValue ;
                41:
                  UserItem.AttachMagic.AC := (UserItem.AttachMagic.AC and $F)+ nItemDarkValue shl 4;
                42:
                  UserItem.AttachMagic.MAC := (UserItem.AttachMagic.MAC and $F0)+ nItemDarkValue ;
                43:
                  UserItem.AttachMagic.MAC := (UserItem.AttachMagic.MAC and $F)+ nItemDarkValue shl 4;
                44:
                  UserItem.AttachMagic.ZMValue := nItemDarkValue;
             end;
      end;
    end;
  end;

begin

  if QuestActionInfo.sParam1='$PARAM(0)' then
    nItemPos:=PlayObject.m_nGiveItemIdx
  else
    nItemPos := QuestActionInfo^.nParam1;
  nDarkPos := QuestActionInfo^.nParam2;
  nDarkValue := QuestActionInfo^.nParam4;
  if not nDarkPos in [0..46] then
    exit;

   UserItem:=PlayObject.GetItems(nItemPos);
   if UserItem=nil then exit;


  if QuestActionInfo.sParam3 = '' then
    exit;
  DarkProperty :=UserItem.DarkProp;// ItemUnit.GetItemDarkProperty(UserItem.MakeIndex, UserItem.wIndex);

   case nDarkPos of
   0..12:
   begin
     nItemDarkValue:=UserItem.btValue[nDarkPos];
   end;
   13:
     nItemDarkValue:=UserItem.Dura;
   14:
     nItemDarkValue:=UserItem.DuraMax;
    19: nItemDarkValue := DarkProPerty.DMagic;
    20: nItemDarkValue := DarkProPerty.DDC and $0F;
    21: nItemDarkValue := (DarkProPerty.DDC and$F0) shr 4;
    22: nItemDarkValue := DarkProPerty.DMC and $0F;
    23: nItemDarkValue := (DarkProPerty.DMC and$F0) shr 4;
    24: nItemDarkValue := DarkProPerty.DSC and $0F;
    25: nItemDarkValue := (DarkProPerty.DSC and$F0) shr 4;
    26: nItemDarkValue := DarkProPerty.DAC and $0F;
    27: nItemDarkValue := (DarkProPerty.DAC and$F0) shr 4;
    28: nItemDarkValue := DarkProPerty.DMAC and $0F;
    29: nItemDarkValue := (DarkProPerty.DMAC and$F0) shr 4;
    30: nItemDarkValue:= DarkProperty.DNEEDLEVEL;
    45: nItemDarkValue:=DarkProperty.btMagicID;
    46: nItemDarkValue:=DarkProperty.btMagicPower;
    31..44:
    begin
      pAttachMagicRCD:=UserItem.AttachMagic;// ItemUnit.GetItemAttachMagic(UserItem.MakeIndex);
      begin
         case nDarkPos of
          31:
          begin

          end;
          32:
            nItemDarkValue:=pAttachMagicRCD.MercenaryJob;
          33:
            nItemDarkValue:=pAttachMagicRCD.MercenaryState;
          34:
            nItemDarkValue:=LoByte(pAttachMagicRCD.DC);
          35:
            nItemDarkValue:=HiByte(pAttachMagicRCD.DC);
          36:
            nItemDarkValue:=LoByte(pAttachMagicRCD.MC);
          37:
            nItemDarkValue:=HiByte(pAttachMagicRCD.MC);
          38:
            nItemDarkValue:=LoByte(pAttachMagicRCD.SC);
          39:
            nItemDarkValue:=HiByte(pAttachMagicRCD.SC);
          40:
            nItemDarkValue:=LoByte(pAttachMagicRCD.AC);
          41:
            nItemDarkValue:=HiByte(pAttachMagicRCD.AC);
          42:
            nItemDarkValue:=LoByte(pAttachMagicRCD.MAC);
          43:
            nItemDarkValue:=HiByte(pAttachMagicRCD.MAC);
          44:
            nItemDarkValue:= pAttachMagicRCD.ZMValue;
         end;
      end;
    end;
  end;



  case QuestActionInfo.sParam3[1] of
    '+': nItemDarkValue := nItemDarkValue + ndarkValue;
    '-':
      begin
        if nItemDarkValue > nDarkValue then
          nItemDarkValue := nItemDarkValue - ndarkValue
        else
          nItemDarkValue := 0;
      end;
    '=': nItemDarkValue := ndarkValue;
  end;
  setDark(nDarkPos, nItemDarkValue);

  UserItem.DarkProp:=DarkProperty;
  PlayObject.SendUpdateItem(UserItem);

end;

procedure TNormNpc.ActionOfUpGradeITEMBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var

  nDarkPos: Integer;
  nDarkValue: Word;
  nItemDarkValue: Word;
  DarkProperty: TDarkProperty;
  UserItem:pTUserItem;
  pAttachMagicRCD : TAttachMagicRCD;
  procedure setDark(npos, nvalue: Word);

  begin
    nvalue := nvalue and $F;
    case npos of
     0..12:
     begin
      UserItem.btValue[npos]:=nItemDarkValue;
     end;
      19: DarkProperty.DMagic := nvalue;
      20: DarkProperty.DDC := (DarkProperty.DDC and $F0) + nvalue;
      21: DarkProperty.DDC := (DarkProperty.DDC and $0F) + nValue shl 4;
      22: DarkProperty.DMC := (DarkProperty.DMC and $F0) + nvalue;
      23: DarkProperty.DMC := (DarkProperty.DMC and $0F) + nValue shl 4;
      24: DarkProperty.DSC := (DarkProperty.DSC and $F0) + nvalue;
      25: DarkProperty.DSC := (DarkProperty.DSC and $0F) + nValue shl 4;
      26: DarkProperty.DAC := (DarkProperty.DAC and $F0) + nvalue;
      27: DarkProperty.DAC := (DarkProperty.DAC and $0F) + nValue shl 4;
      28: DarkProperty.DMAC := (DarkProperty.DMAC and $F0) + nvalue;
      29: DarkProperty.DMAC := (DarkProperty.DMAC and $0F) + nValue shl 4;
    end;
  end;

begin


  nDarkPos := QuestActionInfo^.nParam1;
  nDarkValue := QuestActionInfo^.nParam3;
  if not nDarkPos in [0..44] then
    exit;
   UserItem:=PlayObject.GetItems(PlayObject.m_bocheckboxitem);
   if UserItem=nil then exit;


  if QuestActionInfo.sParam2 = '' then
    exit;
  DarkProperty :=UserItem.DarkProp;// ItemUnit.GetItemDarkProperty(UserItem.MakeIndex, UserItem.wIndex);

   case nDarkPos of
   0..12:
   begin
     nItemDarkValue:=UserItem.btValue[nDarkPos];
   end;
   13:
     nItemDarkValue:=UserItem.Dura;
   14:
     nItemDarkValue:=UserItem.DuraMax;
    19: nItemDarkValue := DarkProPerty.DMagic;
    20: nItemDarkValue := DarkProPerty.DDC and $0F;
    21: nItemDarkValue := (DarkProPerty.DDC and$F0) shr 4;
    22: nItemDarkValue := DarkProPerty.DMC and $0F;
    23: nItemDarkValue := (DarkProPerty.DMC and$F0) shr 4;
    24: nItemDarkValue := DarkProPerty.DSC and $0F;
    25: nItemDarkValue := (DarkProPerty.DSC and$F0) shr 4;
    26: nItemDarkValue := DarkProPerty.DAC and $0F;
    27: nItemDarkValue := (DarkProPerty.DAC and$F0) shr 4;
    28: nItemDarkValue := DarkProPerty.DMAC and $0F;
    29: nItemDarkValue := (DarkProPerty.DMAC and$F0) shr 4;
    30: nItemDarkValue:= DarkProperty.DNEEDLEVEL;
    31..44:
    begin
      pAttachMagicRCD:=Useritem.AttachMagic;// temUnit.GetItemAttachMagic(UserItem.MakeIndex);

      begin
         case nDarkPos of
          31:
          begin

          end;
          32:
            nItemDarkValue:=pAttachMagicRCD.MercenaryJob;
          33:
            nItemDarkValue:=pAttachMagicRCD.MercenaryState;
          34:
            nItemDarkValue:=LoByte(pAttachMagicRCD.DC);
          35:
            nItemDarkValue:=HiByte(pAttachMagicRCD.DC);
          36:
            nItemDarkValue:=LoByte(pAttachMagicRCD.MC);
          37:
            nItemDarkValue:=HiByte(pAttachMagicRCD.MC);
          38:
            nItemDarkValue:=LoByte(pAttachMagicRCD.SC);
          39:
            nItemDarkValue:=HiByte(pAttachMagicRCD.SC);
          40:
            nItemDarkValue:=LoByte(pAttachMagicRCD.AC);
          41:
            nItemDarkValue:=HiByte(pAttachMagicRCD.AC);
          42:
            nItemDarkValue:=LoByte(pAttachMagicRCD.MAC);
          43:
            nItemDarkValue:=HiByte(pAttachMagicRCD.MAC);
          44:
            nItemDarkValue:= pAttachMagicRCD.ZMValue;
         end;
      end;
    end;
  end;



  case QuestActionInfo.sParam3[1] of
    '+': nItemDarkValue := nItemDarkValue + ndarkValue;
    '-':
      begin
        if nItemDarkValue > nDarkValue then
          nItemDarkValue := nItemDarkValue - ndarkValue
        else
          nItemDarkValue := 0;
      end;
    '=': nItemDarkValue := ndarkValue;
  end;
  setDark(nDarkPos, nItemDarkValue);

  UserItem.DarkProp:=DarkProperty;
  PlayObject.SendUpdateItem(UserItem);

end;

procedure TNormNpc.ActionOfSetTimerA(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  BaseObject  : TPlayObject;

begin
 // BaseObject:=UserEngine.GetPlayObject(QuestActionInfo.sParam1);
//  if BaseObject=nil then exit;
  PlayObject.m_nTimerA:=QuestActionInfo.nParam1*1000;
   PlayObject.m_nTimerTick:=GetTickCount;
  PlayObject.m_stimerLable:=QuestActionInfo.sParam2;
  PlayObject.SendDefMessage(1833,Integer(BaseObject),QuestActionInfo.nParam1,300,0,'');


end;
procedure TNormNpc.ActionOfUpGradeITEMDARKPROPERTY(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var

  nDarkPos: Integer;
  nDarkValue: Word;
  nItemDarkValue: Word;
  DarkProperty: TDarkProperty;
  UserItem:pTUserItem;
  pAttachMagicRCD : TAttachMagicRCD;
  procedure setDark(npos, nvalue: Word);

  begin
    nvalue := nvalue and $F;
    case npos of
     0..12:
     begin
      UserItem.btValue[npos]:=nItemDarkValue;
     end;
      19: DarkProperty.DMagic := nvalue;
      20: DarkProperty.DDC := (DarkProperty.DDC and $F0) + nvalue;
      21: DarkProperty.DDC := (DarkProperty.DDC and $0F) + nValue shl 4;
      22: DarkProperty.DMC := (DarkProperty.DMC and $F0) + nvalue;
      23: DarkProperty.DMC := (DarkProperty.DMC and $0F) + nValue shl 4;
      24: DarkProperty.DSC := (DarkProperty.DSC and $F0) + nvalue;
      25: DarkProperty.DSC := (DarkProperty.DSC and $0F) + nValue shl 4;
      26: DarkProperty.DAC := (DarkProperty.DAC and $F0) + nvalue;
      27: DarkProperty.DAC := (DarkProperty.DAC and $0F) + nValue shl 4;
      28: DarkProperty.DMAC := (DarkProperty.DMAC and $F0) + nvalue;
      29: DarkProperty.DMAC := (DarkProperty.DMAC and $0F) + nValue shl 4;
    end;
  end;

begin


  nDarkPos := QuestActionInfo^.nParam1;
  nDarkValue := QuestActionInfo^.nParam3;
  if not nDarkPos in [0..44] then
    exit;
   UserItem:=PlayObject.GetItems(PlayObject.m_UpDateItem[0].MakeIndex);
   if UserItem=nil then exit;


  if QuestActionInfo.sParam2 = '' then
    exit;
  DarkProperty :=UserItem.DarkProp;// ItemUnit.GetItemDarkProperty(UserItem.MakeIndex, UserItem.wIndex);

   case nDarkPos of
   0..12:
   begin
     nItemDarkValue:=UserItem.btValue[nDarkPos];
   end;
   13:
     nItemDarkValue:=UserItem.Dura;
   14:
     nItemDarkValue:=UserItem.DuraMax;
    19: nItemDarkValue := DarkProPerty.DMagic;
    20: nItemDarkValue := DarkProPerty.DDC and $0F;
    21: nItemDarkValue := (DarkProPerty.DDC and$F0) shr 4;
    22: nItemDarkValue := DarkProPerty.DMC and $0F;
    23: nItemDarkValue := (DarkProPerty.DMC and$F0) shr 4;
    24: nItemDarkValue := DarkProPerty.DSC and $0F;
    25: nItemDarkValue := (DarkProPerty.DSC and$F0) shr 4;
    26: nItemDarkValue := DarkProPerty.DAC and $0F;
    27: nItemDarkValue := (DarkProPerty.DAC and$F0) shr 4;
    28: nItemDarkValue := DarkProPerty.DMAC and $0F;
    29: nItemDarkValue := (DarkProPerty.DMAC and$F0) shr 4;
    30: nItemDarkValue:= DarkProperty.DNEEDLEVEL;
    31..44:
    begin
      pAttachMagicRCD:=UserItem.AttachMagic;// ItemUnit.GetItemAttachMagic(UserItem.MakeIndex);

      begin
         case nDarkPos of
          31:
          begin

          end;
          32:
            nItemDarkValue:=UserItem.AttachMagic.MercenaryJob;
          33:
            nItemDarkValue:=UserItem.AttachMagic.MercenaryState;
          34:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.DC);
          35:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.DC);
          36:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.MC);
          37:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.MC);
          38:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.SC);
          39:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.SC);
          40:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.AC);
          41:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.AC);
          42:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.MAC);
          43:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.MAC);
          44:
            nItemDarkValue:= UserItem.AttachMagic.ZMValue;
         end;
      end;
    end;
  end;



  case QuestActionInfo.sParam2[1] of
    '+': nItemDarkValue := nItemDarkValue + ndarkValue;
    '-':
      begin
        if nItemDarkValue > nDarkValue then
          nItemDarkValue := nItemDarkValue - ndarkValue
        else
          nItemDarkValue := 0;
      end;
    '=': nItemDarkValue := ndarkValue;
  end;
  setDark(nDarkPos, nItemDarkValue);
  UserItem.DarkProp:=DarkProperty;
  PlayObject.SendUpdateItem(UserItem);

end;
procedure TNormNpc.ActionOfGoBackeMap(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

Begin
   Playobject.MakeGoBackeMap(QuestActionInfo.nParam1,QuestActionInfo.nParam2,QuestActionInfo.nParam3);
End;
procedure TNormNpc.ActionOfUpGradeUserITEMDARKPROPERTY(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nItemPos: Integer;
  nDarkPos: Integer;
  nDarkValue: Word;
  nItemDarkValue: Word;
  DarkProperty: TDarkProperty;
  UserItem:pTUserItem;



begin

  nItempos := QuestActionInfo^.nParam1;
  nDarkPos := QuestActionInfo^.nParam2;
  nDarkValue := QuestActionInfo^.nParam4;
  if (nItempos >12)or(nItemPos<0) then
    UserItem:=PlayObject.GetItems(nItemPos)
  else
   UserItem:=@PlayObject.m_UseItems[nItemPos];

  if (UserItem=nil) or(UserItem.MakeIndex=0) then Exit;

  if QuestActionInfo.sParam3 = '' then
    exit;
  DarkProperty :=UserItem.DarkProp;// ItemUnit.GetItemDarkProperty(UserItem.MakeIndex, UserItem.wIndex);

  nItemDarkValue:=PlayObject.GetItemInfo(UserItem,nDarkPos);


  case QuestActionInfo.sParam3[1] of
    '+': nItemDarkValue := nItemDarkValue + ndarkValue;
    '-':
      begin
        if nItemDarkValue > nDarkValue then
          nItemDarkValue := nItemDarkValue - ndarkValue
        else
          nItemDarkValue := 0;
      end;
    '=': nItemDarkValue := ndarkValue;
  end;
  PlayObject.SetItemInfo(UserItem,nDarkPos,nItemDarkValue);
  //  PlayObject.m_UseItems[nItemPos]:=UserItem;

//  PlayObject.m_UseItems[nItemPos].DarkProp:=DarkProperty;
//  ItemUnit.AddItemDarkProperty(UserItem.MakeIndex, UserItem.wIndex, DarkProperty);
    PlayObject.SendUpdateItem(UserItem);

end;
procedure TNormNpc.ActionOfAddCastleWar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
  var
  CurCastle: TUserCastle;
  guild:TGuild;
  i:Integer;
begin
  CurCastle:=g_CastleManager.GetCastle(QuestActionInfo.nParam1) ;
  if CurCastle<>nil then
  Begin
   for I := 0 to g_GuildManager.GuildList.Count - 1 do
   begin
    Guild := TGUild(g_GuildManager.GuildList.Items[I]);
    if (Guild<>nil) and (Guild<>CurCastle.m_MasterGuild) then
    CurCastle.AddAttackerInfo(Guild,QuestActionInfo.nParam2) ;
   end;
  End;
end;
procedure TNormNpc.ActionOfSetErniePrize(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
 Buf:array[0..1000] of char;
 i,Index,count,n:Integer;
 s18,s19,sName,sc:String;
 btType,btLevel:Byte;
begin
  Index:=0;
  Count:=0;
  if QuestActionInfo.sParam1<>'' then
  begin
    s18:=GetValidStr3(QuestActionInfo.sParam1,sName,['|']);
    s18:=GetValidStr3(s18,s19,['|']);
    btType:=Str_ToInt(s19,0);
    btLevel:=Str_ToInt(s18,0);
    Buf[Index]:=Chr(btType);
    Inc(Index);
    Buf[Index]:=Chr(btLevel);
    Inc(Index);
    for I := 1 to Length(sName) do
    begin
      Buf[Index]:=sName[i];
      Inc(index);
    end;
    Inc(count);
    n:=MakeWord(btType,btLevel);
  end;
  if QuestActionInfo.sParam2<>'' then
  begin
    s18:=GetValidStr3(QuestActionInfo.sParam2,sName,['|']);
    s18:=GetValidStr3(s18,s19,['|']);
    btType:=Str_ToInt(s19,0);
    btLevel:=Str_ToInt(s18,0);
    Buf[Index]:=Chr(btType);
    Inc(Index);
    Buf[Index]:=Chr(btLevel);
    Inc(Index);
    for I := 1 to Length(sName) do
    begin
      Buf[Index]:=sName[i];
      Inc(index);
    end;
     Inc(count);


  end;
  if QuestActionInfo.sParam3<>'' then
  begin
    s18:=GetValidStr3(QuestActionInfo.sParam3,sName,['|']);
    s18:=GetValidStr3(s18,s19,['|']);
    btType:=Str_ToInt(s19,0);
    btLevel:=Str_ToInt(s18,0);
    Buf[Index]:=Chr(btType);
    Inc(Index);
    Buf[Index]:=Chr(btLevel);
    Inc(Index);
    for I := 1 to Length(sName) do
    begin
      Buf[Index]:=sName[i];
      Inc(index);
    end;
     Inc(count);


  end;
  if QuestActionInfo.sParam4<>'' then
  begin
    s18:=GetValidStr3(QuestActionInfo.sParam4,sName,['|']);
    s18:=GetValidStr3(s18,s19,['|']);
    btType:=Str_ToInt(s19,0);
    btLevel:=Str_ToInt(s18,0);
    Buf[Index]:=Chr(btType);
    Inc(Index);
    Buf[Index]:=Chr(btLevel);
    Inc(Index);
    for I := 1 to Length(sName) do
    begin
      Buf[Index]:=sName[i];
      Inc(index);
    end;
    Inc(count);


  end;
  if QuestActionInfo.sParam5<>'' then
  begin
    s18:=GetValidStr3(QuestActionInfo.sParam5,sName,['|']);
    s18:=GetValidStr3(s18,s19,['|']);
    btType:=Str_ToInt(s19,0);
    btLevel:=Str_ToInt(s18,0);
    Buf[Index]:=Chr(btType);
    Inc(Index);
    Buf[Index]:=Chr(btLevel);
    Inc(Index);
    for I := 1 to Length(sName) do
    begin
      Buf[Index]:=sName[i];
      Inc(index);
    end;
    Inc(count);


  end;
  if QuestActionInfo.sParam6<>'' then
  begin
    s18:=GetValidStr3(QuestActionInfo.sParam6,sName,['|']);
    s18:=GetValidStr3(s18,s19,['|']);
    btType:=Str_ToInt(s19,0);
    btLevel:=Str_ToInt(s18,0);
    Buf[Index]:=Chr(btType);
    Inc(Index);
    Buf[Index]:=Chr(btLevel);
    Inc(Index);
    for I := 1 to Length(sName) do
    begin
      Buf[Index]:=sName[i];
      Inc(index);
    end;
     Inc(count);


  end;
  sc:=EncodeBuffer(Buf,Index);
 PlayObject.SendDefMessage(34973,0,n,count,0,sC,true);
end;

procedure TNormNpc.ActionOfADDITEMDARKPROPERTY(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nItemPos: Integer;
  nDarkPos: Integer;
  nDarkValue: Word;
  nItemDarkValue: Word;
  DarkProperty: TDarkProperty;
  procedure setDark(npos, nvalue: Word);

  begin
    nvalue := nvalue and $F;
    case npos of
      0: DarkProperty.DMagic := nvalue;
      1: DarkProperty.DDC := (DarkProperty.DDC and $F0) + nvalue;
      2: DarkProperty.DDC := (DarkProperty.DDC and $0F) + nValue shl 4;
      3: DarkProperty.DMC := (DarkProperty.DMC and $F0) + nvalue;
      4: DarkProperty.DMC := (DarkProperty.DMC and $0F) + nValue shl 4;
      5: DarkProperty.DSC := (DarkProperty.DSC and $F0) + nvalue;
      6: DarkProperty.DSC := (DarkProperty.DSC and $0F) + nValue shl 4;
      7: DarkProperty.DAC := (DarkProperty.DAC and $F0) + nvalue;
      8: DarkProperty.DAC := (DarkProperty.DAC and $0F) + nValue shl 4;
      9: DarkProperty.DMAC := (DarkProperty.DMAC and $F0) + nvalue;
      10:DarkProperty.DMAC := (DarkProperty.DMAC and $0F) + nValue shl 4;

    end;
  end;

begin

  nItempos := QuestActionInfo^.nParam1;
  nDarkPos := QuestActionInfo^.nParam2;
  nDarkValue := QuestActionInfo^.nParam4;
  if not nItemPos in [0..12] then
    exit;
  if not nDarkPos in [0..9] then
    exit;
  if PlayObject.m_UseItems[nItemPos].wIndex = 0 then
    Exit;

  if QuestActionInfo.sParam3 = '' then
    exit;
  DarkProperty := PlayObject.m_UseItems[nItemPos].DarkProp;//ItemUnit.GetItemDarkProperty(PlayObject.m_UseItems[nItemPos].MakeIndex, PlayObject.m_UseItems[nItemPos].wIndex);
  case nDarkPos of
    0: nItemDarkValue := DarkProPerty.DMagic;
    1: nItemDarkValue := DarkProPerty.DDC and $0F;
    2: nItemDarkValue := (DarkProPerty.DDC and$F0) shr 4;
    3: nItemDarkValue := DarkProPerty.DMC and $0F;
    4: nItemDarkValue := (DarkProPerty.DMC and$F0) shr 4;
    5: nItemDarkValue := DarkProPerty.DSC and $0F;
    6: nItemDarkValue := (DarkProPerty.DSC and$F0) shr 4;
    7: nItemDarkValue := DarkProPerty.DAC and $0F;
    8: nItemDarkValue := (DarkProPerty.DAC and$F0) shr 4;
    9: nItemDarkValue := DarkProPerty.DMAC and $0F;
    10: nItemDarkValue := (DarkProPerty.DMAC and$F0) shr 4;

  end;

  case QuestActionInfo.sParam3[1] of
    '+': nItemDarkValue := nItemDarkValue + ndarkValue;
    '-':
      begin
        if nItemDarkValue > nDarkValue then
          nItemDarkValue := nItemDarkValue - ndarkValue
        else
          nItemDarkValue := 0;
      end;
    '=': nItemDarkValue := ndarkValue;
  end;
  setDark(nDarkPos, nItemDarkValue);
  PlayObject.m_UseItems[nItemPos].DarkProp:=DarkProperty;

  PlayObject.SendUpdateItem(@PlayObject.m_UseItems[nItemPos]);

end;

procedure TNormNpc.ActionOfAddNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  boFound: Boolean;
  sListFileName, sLineText, sHumName, sDate: string;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then
  begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;
  boFound := False;
  for I := 0 to LoadList.Count - 1 do
  begin
    sLineText := Trim(LoadList.Strings[i]);
    sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
    sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
    if CompareText(sHumName, PlayObject.m_sCharName) = 0 then
    begin
      LoadList.Strings[I] := PlayObject.m_sCharName + #9 + DateToStr(Date);
      boFound := True;
      break;
    end;
  end;
  if not boFound then
    LoadList.Add(PlayObject.m_sCharName + #9 + DateToStr(Date));

  try
    LoadList.SaveToFile(sListFileName);
  except
    MainOutMessage('saving fail.... => ' + sListFileName);
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfDelNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sListFileName, sHumName, sDate: string;
  boFound: Boolean;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then
  begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;
  boFound := False;
  for I := 0 to LoadList.Count - 1 do
  begin
    sLineText := Trim(LoadList.Strings[i]);
    sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
    sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
    if CompareText(sHumName, PlayObject.m_sCharName) = 0 then
    begin
      LoadList.Delete(i);
      boFound := True;
      break;
    end;
  end;
  if boFound then
  begin
    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('saving fail.... => ' + sListFileName);
    end;
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfADDYSSKILL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var

  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
  hum: TPlayObject;
begin
  if PlayObject.sYsname = '' then
    exit;
 // hum:=nil ;
//  hum:=UserEngine.GetPlayObjectEx(PlayObject.sYsname);
  hum := PlayObject.Ysplayer;
  if hum = nil then
    exit;
  nLevel:=0;

  Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  if Magic <> nil then
  begin
    if (not hum.IsTrainingSkill(Magic.wMagicId)) and (Magic.btJob = hum.m_btJob) then
    begin
      New(UserMagic);
      UserMagic.MagicInfo := Magic;
      UserMagic.wMagIdx := Magic.wMagicId;
       if not Magic.wMagicId in [87..89] then
         nLevel := _MIN(3, Str_ToInt(QuestActionInfo.sParam2, 0));
      UserMagic.btKey := 0;
      UserMagic.btLevel := nLevel;
      UserMagic.nTranPoint := 0;
      hum.m_MagicList.Add(UserMagic);
      hum.SendAddMagic(UserMagic);
      hum.RecalcAbilitys();
      if g_Config.boShowScriptActionMsg then
      begin
        hum.SysMsg(Magic.sMagicName + '练习成功。', c_Green, t_Hint);
      end;

    end;
  end
  else
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDYSSKILL);
  end;


end;

procedure TNormNpc.ActionOfAddSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var

  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
begin
  nLevel := _MIN(3, Str_ToInt(QuestActionInfo.sParam2, 0));
  Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  if Magic <> nil then
  begin
    if not PlayObject.IsTrainingSkill(Magic.wMagicId) then
    begin
      New(UserMagic);
      UserMagic.MagicInfo := Magic;
      UserMagic.wMagIdx := Magic.wMagicId;
      UserMagic.btKey := 0;
      UserMagic.btLevel := nLevel;
      UserMagic.nTranPoint := 0;
      PlayObject.m_MagicList.Add(UserMagic);
      PlayObject.SendAddMagic(UserMagic);
      PlayObject.RecalcAbilitys();
      if g_Config.boShowScriptActionMsg then
      begin
        PlayObject.SysMsg(Magic.sMagicName + '练习成功。', c_Green, t_Hint);
      end;

    end;
  end
  else
  begin
    ScriptActionError(PlayObject, '魔法数据库里没有该魔法；'+QuestActionInfo.sParam1, QuestActionInfo, sSC_ADDSKILL);
  end;


end;

procedure TNormNpc.ActionOfAutoAddGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
begin
  if CompareText(QuestActionInfo.sParam1, 'START') = 0 then
  begin
    if (nPoint > 0) and (nTime > 0) then
    begin
      PlayObject.m_nIncGameGold := nPoint;
      PlayObject.m_dwIncGameGoldTime := LongWord(nTime * 1000);
      PlayObject.m_dwIncGameGoldTick := GetTickCount();
      PlayObject.m_boIncGameGold := True;
      exit;
    end;
  end;
  if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then
  begin
    PlayObject.m_boIncGameGold := False;
    exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOADDGAMEGOLD);
end;

//SETAUTOGETEXP 时间 点数 是否安全区 地图号

procedure TNormNpc.ActionOfAutoGetExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTime, nPoint: Integer;
  boIsSafeZone: Boolean;
  sMap: string;
  Envir: TEnvirnoment;
begin
  Envir := nil;
  nTime := Str_ToInt(QuestActionInfo.sParam1, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  boIsSafeZone := QuestActionInfo.sParam3[1] = '1';
  sMap := QuestActionInfo.sParam4;
  if sMap <> '' then
  begin
    Envir := g_MapManager.FindMap(sMap);
  end;


  if (nTime <= 0) or (nPoint <= 0) or ((sMap <> '') and (Envir = nil)) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETAUTOGETEXP);
    exit;
  end;
  PlayObject.m_boAutoGetExpInSafeZone := boIsSafeZone;
  PlayObject.m_AutoGetExpEnvir := Envir;
  PlayObject.m_nAutoGetExpTime := nTime * 1000;
  PlayObject.m_nAutoGetExpPoint := nPoint;
end;

procedure TNormNpc.ActionOfAutoSubGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nPoint, nTime: integer);

begin
  if CompareText(QuestActionInfo.sParam1, 'START') = 0 then
  begin
    if (nPoint > 0) and (nTime > 0) then
    begin
      PlayObject.m_nDecGameGold := nPoint;
      PlayObject.m_dwDecGameGoldTime := LongWord(nTime * 1000);
      PlayObject.m_dwDecGameGoldTick := 0;
      PlayObject.m_boDecGameGold := True;
      exit;
    end;
  end;
  if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then
  begin
    PlayObject.m_boDecGameGold := False;
    exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOSUBGAMEGOLD);

end;

procedure TNormNpc.ActionOfChangeCreditPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var

  nCreditPoint: Integer;


  cMethod: Char;

begin

  nCreditPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nCreditPoint < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
    exit;
  end;
  if QuestActionInfo.sParam1='' then exit;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        if nCreditPoint >= 0 then
        begin
          if nCreditPoint > High(Byte) then
          begin
            PlayObject.m_btCreditPoint := High(Byte);
          end
          else
          begin
            PlayObject.m_btCreditPoint := nCreditPoint;
          end;
        end;
      end;
    '-':
      begin
        if PlayObject.m_btCreditPoint > Byte(nCreditPoint) then
        begin
          Dec(PlayObject.m_btCreditPoint, Byte(nCreditPoint));
        end
        else
        begin
          PlayObject.m_btCreditPoint := 0;
        end;
      end;
    '+':
      begin
        if PlayObject.m_btCreditPoint + Byte(nCreditPoint) > High(Byte) then
        begin
          PlayObject.m_btCreditPoint := High(Byte);
        end
        else
        begin
          Inc(PlayObject.m_btCreditPoint, Byte(nCreditPoint));
        end;
      end;
  else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
      exit;
    end;
  end;
  PlayObject.SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, ''); //更新声望值
end;

procedure TNormNpc.ActionOfChangeExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var

  nExp: Integer;


  cMethod: Char;
  dwInt: LongWord;
begin

  nExp := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nExp < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEEXP);
    exit;
  end;
   if QuestActionInfo.sParam1='' then exit;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        if nExp >= 0 then
        begin
          PlayObject.m_Abil.Exp := LongWord(nExp);
          dwInt := LongWord(nExp);
        end;
      end;
    '-':
      begin
        if PlayObject.m_Abil.Exp > LongWord(nExp) then
        begin
          Dec(PlayObject.m_Abil.Exp, LongWord(nExp));
        end
        else
        begin
          PlayObject.m_Abil.Exp := 0;
        end;
      end;
    '+':
      begin
        if PlayObject.m_Abil.Exp >= LongWord(nExp) then
        begin
          if (PlayObject.m_Abil.Exp - LongWord(nExp)) > (High(LongWord) - PlayObject.m_Abil.Exp) then
          begin
            dwInt := High(LongWord) - PlayObject.m_Abil.Exp;
          end
          else
          begin
            dwInt := LongWord(nExp);
          end;
        end
        else
        begin
          if (LongWord(nExp) - PlayObject.m_Abil.Exp) > (High(LongWord) - LongWord(nExp)) then
          begin
            dwInt := High(LongWord) - LongWord(nExp);
          end
          else
          begin
            dwInt := LongWord(nExp);
          end;
        end;
    //  Inc(PlayObject.m_Abil.Exp,dwInt);
    // 2008-11-22 9:49:20  主体放出元神秒杀怪后自动划分经验，主体2/3元神1/3
        if (PlayObject.m_bouself) and(PlayObject.Ysplayer<>nil) then
        begin
            dwint:=dwInt div 3;
            PlayObject.Ysplayer.GetExp(dwint);
            PlayObject.GetExp(dwInt*2);
            PlayObject.m_bouself:=False;
        end
        else
          PlayObject.GetExp(dwInt);
      //  PlayObject.SendMsg(PlayObject,RM_WINEXP,0,dwInt,0,0,'');
      end;
  end;

end;

procedure TNormNpc.ActionOfWearColor(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  nWear: Integer;
begin
  nWear := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (QuestActionInfo.sParam1 <> '') and (nWear >= 0) then
  begin
   // PlayObject.m_btHair:=nHair;
    if PlayObject.m_UseItems[U_DRESS].MakeIndex > 0 then
    begin
      PlayObject.m_UseItems[U_DRESS].btValue[11] := nWear;
      PlayObject.FeatureChanged;
    end;
  end
  else
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_WEARCOLOR);
  end;
end;

procedure TNormNpc.ActionOfChangeHairStyle(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHair: Integer;
begin
  nHair := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (QuestActionInfo.sParam1 <> '') and (nHair >= 0) then
  begin
    PlayObject.m_btHair := nHair;
    PlayObject.FeatureChanged;
  end
  else
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HAIRSTYLE);
  end;
end;

procedure TNormNpc.ActionOfChangeJob(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nJob: Integer;
begin
  nJob := -1;
  if CompareLStr(QuestActionInfo.sParam1, sWARRIOR, 3) then
    nJob := 0;
  if CompareLStr(QuestActionInfo.sParam1, sWIZARD, 3) then
    nJob := 1;
  if CompareLStr(QuestActionInfo.sParam1, sTAOS, 3) then
    nJob := 2;

  if nJob < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEJOB);
    exit;
  end;

  if PlayObject.m_btJob <> nJob then
  begin
    PlayObject.m_btJob := nJob;
    {
    PlayObject.RecalcLevelAbilitys();
    PlayObject.RecalcAbilitys();
    }
    PlayObject.HasLevelUp(0);
  end;
end;

procedure TNormNpc.ActionOfChangeLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boChgOK: Boolean;
  nLevel: Integer;
  nLv: Integer;
  nOldLevel: Integer;
  cMethod: Char;
begin
  boChgOK := False;
  nOldLevel := PlayObject.m_Abil.Level;
  nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nLevel < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGELEVEL);
    exit;
  end;
  if QuestActionInfo.sParam1='' then exit;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        if (nLevel > 0) and (nLevel <= MAXUPLEVEL) then
        begin
          PlayObject.m_Abil.Level := nLevel;
          boChgOK := True;
        end;
      end;
    '-':
      begin
        nLv := _MAX(0, PlayObject.m_Abil.Level - nLevel);
        nLv := _MIN(MAXUpLEVEL, nLv);
        PlayObject.m_Abil.Level := nLv;
        boChgOK := True;
      end;
    '+':
      begin
        nLv := _MAX(0, PlayObject.m_Abil.Level + nLevel);
        nLv := _MIN(MAXUpLEVEL, nLv);
        PlayObject.m_Abil.Level := nLv;
        boChgOK := True;
      end;
  end;
  if boChgOK then
    PlayObject.HasLevelUp(nOldLevel);

end;

procedure TNormNpc.ActionOfChangePkPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPKPoint: Integer;
  nPoint: Integer;
  nOldPKLevel: Integer;
  cMethod: Char;
begin
  nOldPKLevel := PlayObject.PKLevel;
  nPKPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nPKPoint < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEPKPOINT);
    exit;
  end;
  if QuestActionInfo.sParam1='' then exit;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        if (nPKPoint >= 0) then
        begin
          PlayObject.m_nPkPoint := nPKPoint;
        end;
      end;
    '-':
      begin
        nPoint := _MAX(0, PlayObject.m_nPkPoint - nPKPoint);
        PlayObject.m_nPkPoint := nPoint;
      end;
    '+':
      begin
        nPoint := _MAX(0, PlayObject.m_nPkPoint + nPKPoint);
        PlayObject.m_nPkPoint := nPoint;
      end;
  end;
  if nOldPKLevel <> PlayObject.PKLevel then
    PlayObject.RefNameColor;
end;

procedure TNormNpc.ActionOfClearMapMon(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  MonList: TList;
  Mon: TBaseObject;
  II: Integer;
begin
  MonList := TList.Create;
  UserEngine.GetMapMonster(g_MapManager.FindMap(QuestActionInfo.sParam1), MonList);
  for II := 0 to MonList.Count - 1 do
  begin
    Mon := TBaseObject(MonList.Items[II]);
    if Mon.m_Master <> nil then
      Continue;
    if GetNoClearMonList(Mon.m_sCharName) then
      Continue;

    Mon.m_boNoItem := True;
    Mon.MakeGhost;
  end;
  MonList.Free;
end;

procedure TNormNpc.ActionOfClearNameList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName: string;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  {
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
  end;
  }
  LoadList.Clear;
  try
    LoadList.SaveToFile(sListFileName);
  except
    MainOutMessage('saving fail.... => ' + sListFileName);
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfClearSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  for I := PlayObject.m_MagicList.Count - 1 downto 0 do
  begin
    UserMagic := PlayObject.m_MagicList.Items[I];
    PlayObject.SendDelMagic(UserMagic);
    Dispose(UserMagic);
    PlayObject.m_MagicList.Delete(I);
  end;
  PlayObject.RecalcAbilitys();
end;

procedure TNormNpc.ActionOfDelNoJobSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  for I := PlayObject.m_MagicList.Count - 1 downto 0 do
  begin
    UserMagic := PlayObject.m_MagicList.Items[I];
    if UserMagic.MagicInfo.btJob <> PlayObject.m_btJob then
    begin
      PlayObject.SendDelMagic(UserMagic);
      Dispose(UserMagic);
      PlayObject.m_MagicList.Delete(I);
    end;
  end;
end;

procedure TNormNpc.ActionOfDelSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMagicName: string;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
begin
  sMagicName := QuestActionInfo.sParam1;
  Magic := UserEngine.FindMagic(sMagicName);
  if Magic = nil then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELSKILL);
    exit;
  end;
  for I := 0 to PlayObject.m_MagicList.Count - 1 do
  begin
    UserMagic := PlayObject.m_MagicList.Items[I];
    if UserMagic.MagicInfo = Magic then
    begin
      PlayObject.m_MagicList.Delete(I);
      PlayObject.SendDelMagic(UserMagic);
      Dispose(UserMagic);
      PlayObject.RecalcAbilitys();
      break;
    end;
  end;

end;

procedure TNormNpc.ActionOfGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGameGold: Integer;
  nOldGameGold: Integer;
  cMethod: Char;
begin
  nOldGameGold := PlayObject.m_nGameGold;
  nGameGold := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nGameGold < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEGOLD);
    exit;
  end;
   if QuestActionInfo.sParam1='' then exit;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        if (nGameGold >= 0) then
        begin
          PlayObject.m_nGameGold := nGameGold;
        end;
      end;
    '-':
      begin
        nGameGold := _MAX(0, PlayObject.m_nGameGold - nGameGold);
        PlayObject.m_nGameGold := nGameGold;
      end;
    '+':
      begin
        nGameGold := _MAX(0, PlayObject.m_nGameGold + nGameGold);
        PlayObject.m_nGameGold := nGameGold;
      end;
  end;
  //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
  if g_boGameLogGameGold then
  begin
    AddGameDataLog(format(g_sGameLogMsg1, [LOG_GAMEGOLD,
      PlayObject.m_sMapName,
        PlayObject.m_nCurrX,
        PlayObject.m_nCurrY,
        PlayObject.m_sCharName,
        g_Config.sGameGoldName,
        nGameGold,
        cMethod,
        m_sCharName]));
  end;
  if nOldGameGold <> PlayObject.m_nGameGold then
    PlayObject.GameGoldChanged;
end;


procedure TNormNpc.ActionOfHasTask(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Storagefile: TIniFile;
  i: integer;
   myTasktitle: string;
begin
  if (QuestActionInfo.sParam1 <> '') then
  begin
    Storagefile := Tinifile.create(g_Config.sEnvirDir + 'Storage\' + PlayObject.m_sCharName);
    if Storagefile = nil then
      exit;
    PlayObject.nTaskStep := -1;
    for i := 1 to 10 do
    begin
      myTasktitle := Storagefile.Readstring('Task' + inttostr(i), 'Title', '');
      if myTasktitle = '' then
        continue;
            //  Storagefile.Writeinteger('Task','TaskCount',TaskCount);
            //  Storagefile.Writeinteger('Task','MaxTaskCount',10);
            //  Storagefile.Writestring('Task'+inttostr(i),'Title',QuestActionInfo.sParam1);
      if myTasktitle = QuestActionInfo.sParam1 then
      begin
        PlayObject.nTaskStep := Storagefile.readinteger('Task' + inttostr(i), 'TaskStep', -1);
        break;
      end;
            // stepDESC:=Storagefile.Writeinteger('Task'+inttostr(TaskId),'TaskStep',0);
    end; //for

    Storagefile.free;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sUpdateTask);

end;


procedure TNormNpc.ActionOfYSFENGHAO(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);


begin
  if (QuestActionInfo.sParam1 <> '') then
  begin
    PlayObject.M_YSfenghao := QuestActionInfo.nParam1;
    if PlayObject.Ysplayer <> nil then
    begin
      PlayObject.Ysplayer.M_YSfenghao := PlayObject.M_YSfenghao;
      PlayObject.SendDefMessage(21292,
        Integer(PlayObject.Ysplayer),
        8,
        PlayObject.GetYSfenghao(PlayObject.M_YSfenghao),
        0,
        '');
      PlayObject.Ysplayer.SendDefMessage(21292,
        Integer(PlayObject.Ysplayer),
        8,
        PlayObject.GetYSfenghao(PlayObject.M_YSfenghao),
        0,
        '');
    end;

  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sYSFENGHAO);

end;

procedure TNormNpc.ActionOfGROUPMOVE(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  I: Integer;
  smapName: string;
  hum: TPlayObject;

begin
  if (QuestActionInfo.sParam1 <> '') then
  begin
    smapName := QuestActionInfo.sParam1;
    if PlayObject.m_GroupOwner = PlayObject then
    begin
      if (GetTickCount - PlayObject.m_dwGroupRcallTick) > 10 * 1000 then
      begin
        for I := 1 to PlayObject.m_GroupMembers.Count - 1 do
        begin
          hum := TPlayObject(m_GroupMembers.Objects[I]);
          PlayObject.RecallHumanmap(hum.m_sCharName, smapName);
        end; //for
        PlayObject.m_dwGroupRcallTick := GetTickCount();

      end
      else
      begin
        PlayObject.SysMsg('现在不能使用，10秒之内只能使用一次！！！', c_Red, t_Hint);
      end;
    end
    else
    begin
      PlayObject.SysMsg('只有队长才能使用！！！', c_Red, t_Hint);

    end;




  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sADDYQ);
end;




procedure TNormNpc.ActionOfTAKEB(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  btWhere: Integer;
  UserItem: pTUserItem;
  sUserItemName, sItemName: string;
  TakeBagAll: boolean;
begin
  if (QuestActionInfo.sParam1 <> '') then
  begin
    TakeBagAll := false;
    sItemName := QuestActionInfo.sParam1;
    if CompareText('all', sItemName) = 0 then
      TakeBagAll := true;
    for btWhere := 0 to 12 do
    begin
      sUserItemName := UserEngine.GetStdItemName(PlayObject.m_UseItems[btWhere].wIndex);
      if (CompareText(sUserItemName, sItemName) = 0) or TakeBagAll then
      begin
        New(UserItem);
        UserItem^ := PlayObject.m_UseItems[btWhere];
        if PlayObject.AddItemToBag(UserItem) then
        begin
          PlayObject.SendDelItems(@PlayObject.m_UseItems[btWhere]);
          PlayObject.m_UseItems[btWhere].wIndex := 0;
          PlayObject.SendAddItem(UserItem);
          PlayObject.RecalcAbilitys();
          PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
          PlayObject.SendMsg(PlayObject, RM_SUBABILITY, 0, 0, 0, 0, '');
          PlayObject.SendDefMessage(SM_TAKEOFF_OK, PlayObject.GetFeatureToLong, PlayObject.GetDress, 0, 0, ''); //GetFeatureEx
          PlayObject.FeatureChanged();
        end
        else
        begin
          Dispose(UserItem);

        end;
      end;
    end; //for

  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sADDYQ);
end;

procedure TNormNpc.ActionOfBOOSFS(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  dwRoyaltySec: dword;
  nMakelevel, nExpLevel, nCount: Integer;
  sMonName: string;
  bossmon: Tbaseobject;
begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') and (QuestActionInfo.sParam2 <> '') then
  begin
    nMakelevel := QuestActionInfo.nParam2;
    nExpLevel := QuestActionInfo.nParam2;
    nCount := 10;
    sMonName := QuestActionInfo.sParam1;
    dwRoyaltySec := 24 * 24 * 60 * 60;
    bossmon := PlayObject.MakeSlave(sMonName, nMakelevel, nExpLevel, nCount, dwRoyaltySec);
    if bossmon <> nil then
    begin
      bossmon.m_isBeFsBoss := TRUE;
      bossmon.m_befsBossTime := QuestActionInfo.nParam3 * 1000;
      bossmon.m_wStatusTimeArr[STATE_TRANSPARENT {0x70}] := QuestActionInfo.nParam3 * 1000; //004931D2
      bossmon.m_nCharStatus := bossmon.GetCharStatus();
      bossmon.StatusChanged();
     //   bossmon.m_boHideMode:=True;
      bossmon.m_boTransparent := True;
      PlayObject.m_hasFsBoss := True;
      //  bossmon.m_nCurrX:= PlayObject.m_nCurrX;
      //  bossmon.m_nCurry:= PlayObject.m_nCurry;
    end;

  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sADDYQ);
end;


procedure TNormNpc.ActionOfADDYQ(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);


begin
  if (QuestActionInfo.sParam1 <> '') then
  begin
    if QuestActionInfo.sParam1 = '1' then
    begin
        PlayObject.nyuanqi := 100;
        PlayObject.SendDefMessage(38417, 0, 100, 100, 0, '');
      if PlayObject.Ysplayer <> nil then
      begin
        PlayObject.Ysplayer.nyuanqi := 100;
        PlayObject.Ysplayer.SendDefMessage(38417, 0, 100, 100, 0, '');
      end;
      if PlayObject.ysmasterplayer <> nil then
      begin //如果是元神
        PlayObject.nyuanqi := 100;
        PlayObject.SendDefMessage(38417, 0, 100, 100, 0, '');
      end;
    end;

    if QuestActionInfo.sParam1 = '0' then
    begin
      PlayObject.m_boAddYQMode := true;
      if PlayObject.Ysplayer <> nil then
      begin
        PlayObject.Ysplayer.m_boAddYQMode := true;
           // PlayObject.Ysplayer.SendDefMessage(38417,0,100,100,0,'');
      end;
      if PlayObject.ysmasterplayer <> nil then
      begin //如果是元神
        PlayObject.m_boAddYQMode := true;

      end;
    end;


  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sADDYQ);

end;



procedure TNormNpc.ActionOfEndTask(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Storagefile: TIniFile;
  i, TotalTaskCount, MaxTaskCount: integer;
   myTasktitle: string;
begin
  if (QuestActionInfo.sParam1 <> '') then
  begin
    Storagefile := Tinifile.create(g_Config.sEnvirDir + 'Storage\' + PlayObject.m_sCharName);
    if Storagefile = nil then
      exit;

    for i := 1 to 10 do
    begin
      myTasktitle := Storagefile.Readstring('Task' + inttostr(i), 'Title', '');
      if myTasktitle = '' then
        continue;
            //  Storagefile.Writeinteger('Task','TaskCount',TaskCount);
            //  Storagefile.Writeinteger('Task','MaxTaskCount',10);
            //  Storagefile.Writestring('Task'+inttostr(i),'Title',QuestActionInfo.sParam1);
      if myTasktitle = QuestActionInfo.sParam1 then
      begin
             // Storagefile.Writeinteger('Task'+inttostr(i),'TaskStep',QuestActionInfo.nParam2);
        Storagefile.Writestring('Task' + inttostr(i), 'Title', '');
        Storagefile.Writeinteger('Task' + inttostr(i), 'TaskStep', 0);
        PlayObject.SendDefMessage(38294, i, 0, 0, 2, '');
             // PlayObject.SendDefMessage(38294,i,0,0,1,format('<Task title=%s> %s </Task>',[Tasktitle,stepDESC]));
        TotalTaskCount := Storagefile.readinteger('Task', 'TotalTaskCount', 0);
        inc(TotalTaskCount, 1);
        PlayObject.nTaskCount:=TotalTaskCount;
        Storagefile.Writeinteger('Task', 'TotalTaskCount', TotalTaskCount);
        MaxTaskCount := Storagefile.readinteger('Task', 'MaxTaskCount', 10);
        PlayObject.SendDefMessage(38294, 0, 0, 0, 0, format('<TaskInfo MaxTaskCount=%d Achievement=%d TotalTaskCount=%d/>', [MaxTaskCount, 0, TotalTaskCount]));

        break;
      end;
            // stepDESC:=Storagefile.Writeinteger('Task'+inttostr(TaskId),'TaskStep',0);
    end; //for

    Storagefile.free;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sUpdateTask);

end;

procedure TNormNpc.ActionOfUpdateTask(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Storagefile, TaskContext: TIniFile;
  i,  TotalTaskCount, MaxTaskCount: integer;
  Tasktitle, myTasktitle, stepDESC: string;
begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') then
  begin
    Storagefile := Tinifile.create(g_Config.sEnvirDir + 'Storage\' + PlayObject.m_sCharName);
    if Storagefile = nil then
      exit;
    //   TotalTaskCount:=Storagefile.readinteger('Task','TotalTaskCount',0);
    TaskContext := Tinifile.create(g_Config.sEnvirDir + 'Task\' + QuestActionInfo.sParam1 + '.txt');
    if TaskContext = nil then
      exit;
    if TaskContext <> nil then
    begin
      Tasktitle := TaskContext.ReadString('setup', 'title', '');
      stepDESC := TaskContext.ReadString('setup', 'stepDESC' + QuestActionInfo.sParam2, '');
      TaskContext.Free;
      if stepDESC = '' then
      begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sUpdateTask);
        Storagefile.free;
        exit;
      end;
    end;
    for i := 1 to 10 do
    begin
      myTasktitle := Storagefile.Readstring('Task' + inttostr(i), 'Title', '');
      if myTasktitle = '' then
        continue;
            //  Storagefile.Writeinteger('Task','TaskCount',TaskCount);
            //  Storagefile.Writeinteger('Task','MaxTaskCount',10);
            //  Storagefile.Writestring('Task'+inttostr(i),'Title',QuestActionInfo.sParam1);
      if myTasktitle = QuestActionInfo.sParam1 then
      begin

        TotalTaskCount := Storagefile.readinteger('Task', 'TotalTaskCount', 0);
              //inc(TotalTaskCount,1);
        Storagefile.Writeinteger('Task', 'TotalTaskCount', TotalTaskCount);
        MaxTaskCount := Storagefile.readinteger('Task', 'MaxTaskCount', 10);
        PlayObject.SendDefMessage(38294, 0, 0, 0, 0, format('<TaskInfo MaxTaskCount=%d Achievement=%d TotalTaskCount=%d/>', [MaxTaskCount, 0, TotalTaskCount]));

        Storagefile.Writeinteger('Task' + inttostr(i), 'TaskStep', QuestActionInfo.nParam2);
        PlayObject.SendDefMessage(38294, i, 0, 0, 1, format('<Task title=%s> %s </Task>', [Tasktitle, stepDESC]));

        break;
      end;
            // stepDESC:=Storagefile.Writeinteger('Task'+inttostr(TaskId),'TaskStep',0);
    end; //for

    Storagefile.free;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sUpdateTask);

end;

procedure TNormNpc.ActionOfADDTASK(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Storagefile, TaskContext: TIniFile;
  i: integer;
  Tasktitle, myTasktitle, stepDESC: string;
begin
  if (QuestActionInfo.sParam1 <> '') then
  begin
    Storagefile := Tinifile.create(g_Config.sEnvirDir + 'Storage\' + PlayObject.m_sCharName);
    if Storagefile = nil then
      exit;
    //   TotalTaskCount:=Storagefile.readinteger('Task','TotalTaskCount',0);
    //   TaskCount:=Storagefile.readinteger('Task','TaskCount',0);
    //   if  TaskCount<10 then begin
    //       inc( TaskCount,1 );
    TaskContext := Tinifile.create(g_Config.sEnvirDir + 'Task\' + QuestActionInfo.sParam1 + '.txt');
    if TaskContext = nil then
      exit;
    if TaskContext <> nil then
    begin
      Tasktitle := TaskContext.ReadString('setup', 'title', '');
      stepDESC := TaskContext.ReadString('setup', 'stepDESC1', '');
      TaskContext.Free;
    end;
    for i := 1 to 10 do
    begin
      myTasktitle := Storagefile.Readstring('Task' + inttostr(i), 'Title', '');
      if myTasktitle = '' then
      begin
         //     Storagefile.Writeinteger('Task','TaskCount',TaskCount);
        Storagefile.Writeinteger('Task', 'MaxTaskCount', 10);
        Storagefile.Writestring('Task' + inttostr(i), 'Title', QuestActionInfo.sParam1);
        Storagefile.Writeinteger('Task' + inttostr(i), 'TaskStep', 1);
        PlayObject.SendDefMessage(38294, i, 0, 0, 1, format('<Task title=%s> %s </Task>', [Tasktitle, stepDESC]));

        break;
      end;
            // stepDESC:=Storagefile.Writeinteger('Task'+inttostr(TaskId),'TaskStep',0);
    end;
      // end; //if <10 ;

    Storagefile.free;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sADDTASK);

end;

procedure TNormNpc.ActionOfYSPOINT(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nYSPoint: Integer;
  nOldYSPoint: Integer;
  cMethod: Char;
  hum: Tplayobject;
begin
  nOldYSPoint := PlayObject.m_YSPoint;
  nYSPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nYSPoint < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, SYSPoint);
    exit;
  end;
  if QuestActionInfo.sParam1='' then exit;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        if (nYSPoint >= 0) then
        begin
          PlayObject.m_YSPoint := nYSPoint;
        end;
      end;
    '-':
      begin
        nYSPoint := _MAX(0, PlayObject.m_YSPoint - nYSPoint);
        PlayObject.m_YSPoint := nYSPoint;
      end;
    '+':
      begin
        nYSPoint := _MAX(0, PlayObject.m_YSPoint + nYSPoint);
        PlayObject.m_YSPoint := nYSPoint;
      end;
  end;
  //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
 { if g_boGameLogGamePoint then begin
    AddGameDataLog(format(g_sGameLogMsg1,[LOG_GAMEPOINT,
                                        PlayObject.m_sMapName,
                                        PlayObject.m_nCurrX,
                                        PlayObject.m_nCurrY,
                                        PlayObject.m_sCharName,
                                        g_Config.sGamePointName,
                                        nGamePoint,
                                        cMethod,
                                        m_sCharName]));
  end;  }
  if nOldYSPoint <> PlayObject.m_YSPoint then
  begin
  //  PlayObject.GameGoldChanged;
    if PlayObject.m_YSPoint>60000 then PlayObject.m_YSPoint:=60000;
    PlayObject.SendMsg(PlayObject,RM_ABILITY,0,0,0,0,'');

 //  hum:=nil;
 //  hum:=UserEngine.GetPlayObjectEx(PlayObject.sysname);
    hum := playobject.Ysplayer;
    if hum <> nil then
    begin

      hum.SendMsg(hum, RM_ABILITY, 0, 0, 0, 0, '');
           // hum.SendMsg(hum,RM_SUBABILITY,0,0,0,0,'');
    end;
  end;
end;

procedure TNormNpc.ActionOfJoinGuild(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Guild:TGuild;
  baseobject:TPlayObject;
begin
   baseobject:=UserEngine.GetPlayObject(QuestActionInfo.sParam1) ;
   if baseobject=nil  then
   begin
      PlayObject.SysMsg(QuestActionInfo.sParam1+'不在线',c_Red,t_Hint);
   end;
  Guild:=g_GuildManager.FindGuild(QuestActionInfo.sParam2);
  if Guild<>nil then
  Begin
    Guild.AddMember(baseobject);
    baseobject.m_MyGuild:=Guild;
  End;
end;

procedure TNormNpc.ActionOfJPPOINT(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nJPPoint: Integer;
  nOldJPPoint: Integer;
  cMethod: Char;
begin
  nOldJPPoint := PlayObject.m_nJpPoint;
  nJPPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nJPPoint < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, SJPPoint);
    exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        if (nJPPoint >= 0) then
        begin
          PlayObject.m_nJpPoint := nJPPoint;
        end;
      end;
    '-':
      begin
        nJPPoint := _MAX(0, PlayObject.m_nJpPoint - nJPPoint);
        PlayObject.m_nJpPoint := nJPPoint;
      end;
    '+':
      begin
        nJPPoint := _MAX(0, PlayObject.m_nJpPoint + nJPPoint);
        PlayObject.m_nJpPoint := nJPPoint;
      end;
  end;
  //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
 { if g_boGameLogGamePoint then begin
    AddGameDataLog(format(g_sGameLogMsg1,[LOG_GAMEPOINT,
                                        PlayObject.m_sMapName,
                                        PlayObject.m_nCurrX,
                                        PlayObject.m_nCurrY,
                                        PlayObject.m_sCharName,
                                        g_Config.sGamePointName,
                                        nGamePoint,
                                        cMethod,
                                        m_sCharName]));
  end;  }
  if nOldJPPoint <> PlayObject.m_nJpPoint then
  //  PlayObject.GameGoldChanged;
  //  if PlayObject.m_nJpPoint>60000 then PlayObject.m_nGamePoint:=60000;
    PlayObject.SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
end;


procedure TNormNpc.ActionOfGamePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGamePoint: Integer;
  nOldGamePoint: Integer;
  cMethod: Char;
begin
  nOldGamePoint := PlayObject.m_nGamePoint;
  nGamePoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nGamePoint < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEPOINT);
    exit;
  end;
    if QuestActionInfo.sParam1='' then exit;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        if (nGamePoint >= 0) then
        begin
          PlayObject.m_nGamePoint := nGamePoint;
        end;
      end;
    '-':
      begin
        nGamePoint := _MAX(0, PlayObject.m_nGamePoint - nGamePoint);
        PlayObject.m_nGamePoint := nGamePoint;
      end;
    '+':
      begin
        nGamePoint := _MAX(0, PlayObject.m_nGamePoint + nGamePoint);
        PlayObject.m_nGamePoint := nGamePoint;
      end;
  end;
  //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
  if g_boGameLogGamePoint then
  begin
    AddGameDataLog(format(g_sGameLogMsg1, [LOG_GAMEPOINT,
      PlayObject.m_sMapName,
        PlayObject.m_nCurrX,
        PlayObject.m_nCurrY,
        PlayObject.m_sCharName,
        g_Config.sGamePointName,
        nGamePoint,
        cMethod,
        m_sCharName]));
  end;
  if nOldGamePoint <> PlayObject.m_nGamePoint then
  //  PlayObject.GameGoldChanged;
    if PlayObject.m_nGamePoint > 60000 then
      PlayObject.m_nGamePoint := 60000;
  PlayObject.SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
end;


procedure TNormNpc.ActionOfGetMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseBaseObject: TBaseObject;
begin
  PoseBaseObject := PlayObject.GetPoseCreate();
  if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender) then
  begin
    PlayObject.m_sDearName := PoseBaseObject.m_sCharName;
   TPlayObject(PoseBaseObject).m_sDearName:=PlayObject.m_sCharName;
    PlayObject.RefShowName;
    PoseBaseObject.RefShowName;
  end
  else
  begin
    GotoLable(PlayObject, '@MarryError', False);
  end;
end;

procedure TNormNpc.ActionOfGetMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseBaseObject: TBaseObject;
begin
  PoseBaseObject := PlayObject.GetPoseCreate();
  if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender) then
  begin
    PlayObject.m_sMasterName := PoseBaseObject.m_sCharName;
    PlayObject.RefShowName;
    PoseBaseObject.RefShowName;
  end
  else
  begin
    GotoLable(PlayObject, '@MasterError', False);
  end;
end;

procedure TNormNpc.ActionOfLineMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg : string;
  I    : Integer;
  BaseObject:TPlayObject;
begin
  sMsg := GetLineVariableText(PlayObject, QuestActionInfo.sParam2);
  sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
  if PlayObject.m_PEnvir <> nil then
    sMsg := AnsiReplaceText(sMsg, '%m', PlayObject.m_PEnvir.sMapDesc);
  sMsg := AnsiReplaceText(sMsg, '%x', inttostr(PlayObject.m_nCurrX));
  sMsg := AnsiReplaceText(sMsg, '%y', inttostr(PlayObject.m_nCurrY));
  sMsg := AnsiReplaceText(sMsg, '%d', m_sCharName);

  sMsg := AnsiReplaceText(sMsg, '<$s0>', PlayObject.m_DySval[0]);
  sMsg := AnsiReplaceText(sMsg, '<$s1>', PlayObject.m_DySval[1]);
  sMsg := AnsiReplaceText(sMsg, '<$s2>', PlayObject.m_DySval[2]);
  sMsg := AnsiReplaceText(sMsg, '<$s3>', PlayObject.m_DySval[3]);
  sMsg := AnsiReplaceText(sMsg, '<$s4>', PlayObject.m_DySval[4]);
  sMsg := AnsiReplaceText(sMsg, '<$s5>', PlayObject.m_DySval[5]);
  sMsg := AnsiReplaceText(sMsg, '<$s6>', PlayObject.m_DySval[6]);
  sMsg := AnsiReplaceText(sMsg, '<$s7>', PlayObject.m_DySval[7]);
  sMsg := AnsiReplaceText(sMsg, '<$s8>', PlayObject.m_DySval[8]);
  sMsg := AnsiReplaceText(sMsg, '<$s9>', PlayObject.m_DySval[9]);

  sMsg:=AnsiReplaceText(sMsg, '{', '<');
  sMsg:=AnsiReplaceText(sMsg, '}', '>');
  case QuestActionInfo.nParam1 of
    0: UserEngine.SendBroadCastMsg(sMsg, t_System);
    1: UserEngine.SendBroadCastMsg('(*) ' + sMsg, t_System);
    2: UserEngine.SendBroadCastMsg('[' + m_sCharName + ']' + sMsg, t_System);
    3: UserEngine.SendBroadCastMsg('[' + PlayObject.m_sCharName + ']' + sMsg, t_System);
    4: ProcessSayMsg(sMsg);
    5: PlayObject.SysMsg(sMsg, c_Red, t_Say);
    6: PlayObject.SysMsg(sMsg, c_Green, t_Say);
    7: PlayObject.SysMsg(sMsg, c_Blue, t_Say);
    8: UserEngine.SendBroadCastMsg(sMsg, t_hSystem);
    9: PlayObject.SysMsg(sMsg, c_Red, t_hSystem);
    10: UserEngine.SendBroadCastMsg(sMsg, t_rSystem);
    11: PlayObject.SysMsg(sMsg, c_Red, t_rSystem);
    12: UserEngine.SendBroadCastMsg(sMsg, t_tSystem);
    13: PlayObject.SysMsg(sMsg, c_Red, t_topSystem);
    14: UserEngine.SendBroadCastMsg(sMsg, t_topSystem);
    15: PlayObject.SysMsg(sMsg,c_Yellow, t_topSystem);
    16:
     begin
       for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do
        begin
          BaseObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[i]);
          if (not BaseObject.m_boGhost) and (BaseObject.sYsnameMaster = '') then //如果不是元神
            BaseObject.SendMsg(PlayObject,RM_ColorMsg,0,QuestActionInfo.nParam3,QuestActionInfo.nParam4,0,sMsg);
        end;
    end ;
    17: PlayObject.SendMsg(PlayObject,RM_ColorMsg,0,QuestActionInfo.nParam3,QuestActionInfo.nParam4,0,sMsg);
    19: PlayObject.SendMsg(PlayObject,Rm_768,0,0,0,0,sMsg);
    20:
    begin
       for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do
        begin
          BaseObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[i]);
          if (not BaseObject.m_boGhost) and (BaseObject.sYsnameMaster = '') then //如果不是元神
            BaseObject.SendMsg(PlayObject,Rm_768,0,0,0,0,sMsg);
        end;
    end
  else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSENDMSG);
    end;
  end;
end;

procedure TNormNpc.ActionOfMapTing(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin

end;

procedure TNormNpc.ActionOfMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  Baseobject:TBaseObject;
  sSayMsg: string;
begin
  if PlayObject.m_sDearName <> '' then
    exit;
    Baseobject:= PlayObject.GetPoseCreate();


  if (Baseobject = nil) or(Baseobject.m_btRaceServer <> RC_PLAYOBJECT)then
  begin
    GotoLable(PlayObject, '@MarryCheckDir', False);
    exit;
  end;
  PoseHuman := TPlayObject(Baseobject);
  if QuestActionInfo.sParam1 = '' then
  begin
    if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then
    begin
      GotoLable(PlayObject, '@HumanTypeErr', False);
      exit;
    end;
    if PoseHuman.GetPoseCreate = PlayObject then
    begin
      if PlayObject.m_btGender <> PoseHuman.m_btGender then
      begin
        GotoLable(PlayObject, '@StartMarry', False);
        GotoLable(PoseHuman, '@StartMarry', False);
        if (PlayObject.m_btGender = 0) and (PoseHuman.m_btGender = 1) then
        begin
          sSayMsg := AnsiReplaceText(g_sStartMarryManMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sStartMarryManAskQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        end
        else
          if (PlayObject.m_btGender = 1) and (PoseHuman.m_btGender = 0) then
          begin
            sSayMsg := AnsiReplaceText(g_sStartMarryWoManMsg, '%n', m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
            sSayMsg := AnsiReplaceText(g_sStartMarryWoManAskQuestionMsg, '%n', m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
            sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
            UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          end;
        PlayObject.m_boStartMarry := True;
        PoseHuman.m_boStartMarry := True;
      end
      else
      begin
        GotoLable(PoseHuman, '@MarrySexErr', False);
        GotoLable(PlayObject, '@MarrySexErr', False);
      end;
    end
    else
    begin
      GotoLable(PlayObject, '@MarryDirErr', False);
      GotoLable(PoseHuman, '@MarryCheckDir', False);
    end;
    exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'REQUESTMARRY' {sREQUESTMARRY}) = 0 then
  begin
    if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then
    begin
      if (PlayObject.m_btGender = 0) and (PoseHuman.m_btGender = 1) then
      begin
        sSayMsg := AnsiReplaceText(g_sMarryManAnswerQuestionMsg, '%n', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
        UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        sSayMsg := AnsiReplaceText(g_sMarryManAskQuestionMsg, '%n', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
        UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        GotoLable(PlayObject, '@WateMarry', False);
        GotoLable(PoseHuman, '@RevMarry', False);
      end;
    end;
    exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'RESPONSEMARRY' {sRESPONSEMARRY}) = 0 then
  begin
    if (PlayObject.m_btGender = 1) and (PoseHuman.m_btGender = 0) then
    begin
      if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then
      begin
        if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then
        begin
          sSayMsg := AnsiReplaceText(g_sMarryWoManAnswerQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sMarryWoManGetMarryMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          GotoLable(PlayObject, '@EndMarry', False);
          GotoLable(PoseHuman, '@EndMarry', False);
          PlayObject.m_boStartMarry := False;
          PoseHuman.m_boStartMarry := False;
          PlayObject.m_sDearName := PoseHuman.m_sCharName;
          PlayObject.m_DearHuman := PoseHuman;
          PoseHuman.m_sDearName := PlayObject.m_sCharName;
          PoseHuman.m_DearHuman := PlayObject;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
        end;
      end
      else
      begin
        if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then
        begin
          GotoLable(PlayObject, '@EndMarryFail', False);
          GotoLable(PoseHuman, '@EndMarryFail', False);
          PlayObject.m_boStartMarry := False;
          PoseHuman.m_boStartMarry := False;
          sSayMsg := AnsiReplaceText(g_sMarryWoManDenyMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sMarryWoManCancelMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        end;
      end;
    end;
    exit;
  end;
end;

procedure TNormNpc.ActionOfMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
    Baseobject:TBaseObject;

begin
  if PlayObject.m_sMasterName <> '' then
    exit;
     Baseobject:= PlayObject.GetPoseCreate();


  if (Baseobject = nil) or(Baseobject.m_btRaceServer <> RC_PLAYOBJECT)then
  begin
    GotoLable(PlayObject, '@MasterCheckDir', False);
    exit;
  end;
   PoseHuman := TPlayObject(Baseobject);
  if QuestActionInfo.sParam1 = '' then
  begin
    if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then
    begin
      GotoLable(PlayObject, '@HumanTypeErr', False);
      exit;
    end;
    if PoseHuman.GetPoseCreate = PlayObject then
    begin
      GotoLable(PlayObject, '@StartGetMaster', False);
      GotoLable(PoseHuman, '@StartMaster', False);
      PlayObject.m_boStartMaster := True;
      PoseHuman.m_boStartMaster := True;
    end
    else
    begin
      GotoLable(PlayObject, '@MasterDirErr', False);
      GotoLable(PoseHuman, '@MasterCheckDir', False);
    end;
    exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'REQUESTMASTER') = 0 then
  begin
    if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then
    begin
      PlayObject.m_PoseBaseObject := PoseHuman;
      PoseHuman.m_PoseBaseObject := PlayObject;
      GotoLable(PlayObject, '@WateMaster', False);
      GotoLable(PoseHuman, '@RevMaster', False);
    end;
    exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'RESPONSEMASTER') = 0 then
  begin
    if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then
    begin
      if (PlayObject.m_PoseBaseObject = PoseHuman) and (PoseHuman.m_PoseBaseObject = PlayObject) then
      begin
        if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then
        begin
          GotoLable(PlayObject, '@EndMaster', False);
          GotoLable(PoseHuman, '@EndMaster', False);
          PlayObject.m_boStartMaster := False;
          PoseHuman.m_boStartMaster := False;
          if PlayObject.m_sMasterName = '' then
          begin
            PlayObject.m_sMasterName := PoseHuman.m_sCharName;
            PlayObject.m_boMaster := True;
          end;
          PlayObject.m_MasterList.Add(PoseHuman);
          PoseHuman.m_sMasterName := PlayObject.m_sCharName;
          PoseHuman.m_boMaster := False;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
        end;
      end;
    end
    else
    begin
      if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then
      begin
        GotoLable(PlayObject, '@EndMasterFail', False);
        GotoLable(PoseHuman, '@EndMasterFail', False);
        PlayObject.m_boStartMaster := False;
        PoseHuman.m_boStartMaster := False;
      end;
    end;
    exit;
  end;

end;

procedure TNormNpc.ActionOfMessageBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, GetLineVariableText(PlayObject, QuestActionInfo.sParam1));
end;

procedure TNormNpc.ActionOfMission(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.nParam2 > 0) and (QuestActionInfo.nParam3 > 0) then
  begin
    g_sMissionMap := QuestActionInfo.sParam1;
    g_nMissionX := QuestActionInfo.nParam2;
    g_nMissionY := QuestActionInfo.nParam3;
  end
  else
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MISSION);
  end;
end;

//MOBFIREBURN MAP X Y TYPE TIME POINT

procedure TNormNpc.ActionOfMobFireBurn(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMap: string;
  nX, nY, nType, nTime, nPoint: Integer;
  FireBurnEvent: TFireBurnEvent;
  Envir: TEnvirnoment;
  OldEnvir: TEnvirnoment;
begin
  sMap := QuestActionInfo.sParam1;
  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);
  nType := Str_ToInt(QuestActionInfo.sParam4, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam5, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam6, -1);
  if (sMap = '') or (nX < 0) or (nY < 0) or (nType < 0) or (nTime < 0) or (nPoint < 0) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBFIREBURN);
    exit;
  end;
  Envir := g_MapManager.FindMap(sMap);
  if Envir <> nil then
  begin
    OldEnvir := PlayObject.m_PEnvir;
    PlayObject.m_PEnvir := Envir;
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, nType, nTime * 1000, nPoint);
    g_EventManager.AddEvent(FireBurnEvent);
    PlayObject.m_PEnvir := OldEnvir;
    exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBFIREBURN);

end;

procedure TNormNpc.ActionOfMobNpc(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
   sMap:string;
   nx,ny:Integer;
   sFileName:string;
   ndelayTime:LongWord ;
   nAppr:Integer;
   sName:String;
   sLineText,sX,sY :string ;
   TmpNpc : TMerchant ;
begin
 //  A NPC名称
//B 脚本文件名
//C 外形(Appr)
//D 地图(x,y)
//E 延迟时间
    sName:= QuestActionInfo.sParam1;
    sFileName:=QuestActionInfo.sParam2;
    nAppr:=QuestActionInfo.nParam3;
    sLineText:=QuestActionInfo.sParam4;
     sLineText := GetValidStr3(sLineText, sMap, ['(']);
    sLineText := GetValidStr3(sLineText, sX, [',']);
    sLineText := GetValidStr3(sLineText, sY, [')']);
    nx:=Str_ToInt(sX,-1);
    nY:=Str_ToInt(sY,-1);
    ndelayTime:=QuestActionInfo.nParam5*1000;
    if (sName='')or(sFileName='') or(sMap='') or (nx=-1)or(ny=-1) then
    begin
       ScriptActionError(PlayObject, '', QuestActionInfo, sMobNpc);
       Exit;
    end;
    try
      TmpNpc := TMerchant.Create;
      TmpNpc.m_sMapName := sMap;
      TmpNpc.m_nCurrX := nx;
      TmpNpc.m_nCurrY := ny;
      TmpNpc.m_sCharName :=sName;
      TmpNpc.m_nFlag := 0;
      TmpNpc.m_wAppr := nAppr;
      TmpNpc.m_sFilePath := sMarket_Def;
      TmpNpc.m_sScript := sFileName;
      TmpNpc.m_PEnvir := g_MapManager.FindMap(TmpNpc.m_sMapName);
      TmpNpc.LoadNPCScript('');
      TmpNpc.m_boIsHide :=false;
      TmpNpc.m_boIsQuest := False;
      TmpNpc.m_nDelayTick:=GetTickCount ;
      TmpNpc.m_ndelayTime:=ndelayTime;
      TmpNpc.Initialize;
      TmpNpc.SearchViewRange;
      TmpNpc.TurnTo(Random(8));
      UserEngine.AddMerchant(TmpNpc);
    finally

    end;
end;

procedure TNormNpc.ActionOfMobPlaceX(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: integer;
  nRandX, nRandY, p1, p2, p3: Integer;
  Mon: TBaseObject;
  smap: string;
begin
  smap := PLayobject.m_sMapName;
  if smap = '' then
    exit;
  p1 := str_toint(QuestActionInfo.sParam1, 0);
  p2 := str_toint(QuestActionInfo.sParam2, 0);
  p3 := str_toint(QuestActionInfo.sParam3, 0);
  for I := 0 to str_toint(QuestActionInfo.sParam5, 0) - 1 do
  begin
    nRandX := Random(p3 * 2 + 1) + (p1 - p3);
    nRandY := Random(p3 * 2 + 1) + (p2 - p3);

    Mon := UserEngine.RegenMonsterByName(sMap, nRandX, nRandY, QuestActionInfo.sParam4);
    if Mon <> nil then
    begin
      Mon.m_boMission := True;
      Mon.m_nMissionX := p1;
      Mon.m_nMissionY := p2;
    end
    else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBPLACEx);
      break;
    end;
  end;
end;


procedure TNormNpc.ActionOfMobPlace(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nX, nY, nCount, nRange: Integer);
var
  I: integer;
  nRandX, nRandY: Integer;
  Mon: TBaseObject;
begin
  for I := 0 to nCount - 1 do
  begin
    nRandX := Random(nRange * 2 + 1) + (nX - nRange);
    nRandY := Random(nRange * 2 + 1) + (nY - nRange);
    Mon := UserEngine.RegenMonsterByName(g_sMissionMap, nRandX, nRandY, QuestActionInfo.sParam1);
    if Mon <> nil then
    begin
      Mon.m_boMission := True;
      Mon.m_nMissionX := g_nMissionX;
      Mon.m_nMissionY := g_nMissionY;
    end
    else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBPLACE);
      break;
    end;
  end;
end;

procedure TNormNpc.ActionOfReadRandomStr(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  n14,n18:Integer;

  sList:TStringList ;
  sName,sTemp:String;
begin
    sName:=g_Config.sEnvirDir+m_spath+ QuestActionInfo.sParam1 ;
    if FileExists(sName)then
    Begin
      sList :=TStringList.Create;
      try
           sList.LoadFromFile(sName);
           n18:=QuestActionInfo.nParam3;
            //如果参数三为空则随机读取
           if QuestActionInfo.sParam3='' then
              n18:=Random(sList.Count);
            sTemp:='';

            if (sList.Count>0) and(n18<sList.Count)and(n18>=0) then
              sTemp:=sList[n18];


               setValValue(PlayObject,QuestActionInfo.sParam2,0,sTemp);

      finally
        sList.Free;
      end;

    End;
end;

procedure TNormNpc.ActionOfRecallGroupMembers(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin

end;


procedure TNormNpc.ActionOfSetRankLevelName(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sRankLevelName: string;
begin
  sRankLevelName := QuestActionInfo.sParam1;
  if sRankLevelName = '' then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SKILLLEVEL);
    exit;
  end;
  if QuestActionInfo.sParam2='' then
    PlayObject.m_sRankLevelName :=sRankLevelName
  else
    PlayObject.m_sRankLevelName :=sRankLevelName+QuestActionInfo.sParam2;
  PlayObject.RefShowName;
end;

procedure TNormNpc.ActionOfSetScriptFlag(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boFlag: Boolean;
  nWhere: Integer;
begin
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  boFlag := Str_ToInt(QuestActionInfo.sParam2, -1) = 1;
  case nWhere of //
    0:
      begin
        PlayObject.m_boSendMsgFlag := boFlag;
      end;
    1:
      begin
        PlayObject.m_boChangeItemNameFlag := boFlag;
      end;
  else
    begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETSCRIPTFLAG);
    end;
  end;
end;

procedure TNormNpc.ActionOfSkillLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
  cMethod: Char;
begin
  nLevel := Str_ToInt(QuestActionInfo.sParam3, 0);
  if nLevel < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SKILLLEVEL);
    exit;
  end;
    if QuestActionInfo.sParam2='' then exit;
  cMethod := QuestActionInfo.sParam2[1];
  Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  if Magic <> nil then
  begin
    for I := 0 to PlayObject.m_MagicList.Count - 1 do
    begin
      UserMagic := PlayObject.m_MagicList.Items[I];
      if UserMagic.MagicInfo = Magic then
      begin
        case cMethod of
          '=':
            begin
              if nLevel >= 0 then
              begin
                nLevel := _MAX(3, nLevel);
                UserMagic.btLevel := nLevel;
              end;
            end;
          '-':
            begin
              if UserMagic.btLevel >= nLevel then
              begin
                Dec(UserMagic.btLevel, nLevel);
              end
              else
              begin
                UserMagic.btLevel := 0;
              end;
            end;
          '+':
            begin
              if UserMagic.btLevel + nLevel <= 3 then
              begin
                Inc(UserMagic.btLevel, nLevel);
              end
              else
              begin
                UserMagic.btLevel := 3;
              end;
            end;
        end;
        PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 100);
        break;
      end;
    end;
  end;
end;


procedure TNormNpc.ActionOfTakeCastleGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGold: Integer;
begin
  nGold := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (nGold < 0) or (m_Castle = nil) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAKECASTLEGOLD);
    exit;
  end;

  if nGold <= TUserCastle(m_Castle).m_nTotalGold then
  begin
    Dec(TUserCastle(m_Castle).m_nTotalGold, nGold);
  end
  else
  begin
    TUserCastle(m_Castle).m_nTotalGold := 0;
  end;
end;

procedure TNormNpc.ActionOfUnMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
    Baseobject:TBaseObject;
  LoadList: TStringList;
  sUnMarryFileName: string;
begin
  if PlayObject.m_sDearName = '' then
  begin
    GotoLable(PlayObject, '@ExeMarryFail', False);
    exit;
  end;
   Baseobject:= PlayObject.GetPoseCreate();
   if(Baseobject<>nil)and( Baseobject.m_btRaceServer = RC_PLAYOBJECT) then
       PoseHuman:=TPlayObject(Baseobject)
   else
       PoseHuman:=nil;
  if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMARRY' {sREQUESTUNMARRY}) = 0) then
  begin
    if (QuestActionInfo.sParam2 = '') then
    begin
      if PoseHuman <> nil then
      begin
        PlayObject.m_boStartUnMarry := True;
        if PlayObject.m_boStartUnMarry and PoseHuman.m_boStartUnMarry then
        begin
          UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '我宣布' {sUnMarryMsg8} + PoseHuman.m_sCharName + ' ' + '与' {sMarryMsg0} + PlayObject.m_sCharName + ' ' + ' ' + '正式脱离夫妻关系。' {sUnMarryMsg9}, t_Say);
          PlayObject.m_sDearName := '';
          PoseHuman.m_sDearName := '';
          Inc(PlayObject.m_btMarryCount);
          Inc(PoseHuman.m_btMarryCount);
          PlayObject.m_boStartUnMarry := False;
          PoseHuman.m_boStartUnMarry := False;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
          GotoLable(PlayObject, '@UnMarryEnd', False);
          GotoLable(PoseHuman, '@UnMarryEnd', False);
        end
        else
        begin
          GotoLable(PlayObject, '@WateUnMarry', False);
//          GotoLable(PoseHuman,'@RevUnMarry',False);
        end;
      end;
      exit;
    end
    else
    begin
      //强行离婚
      if (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then
      begin
        UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '我宣布' {sUnMarryMsg8} + PlayObject.m_sCharName + ' ' + '与' {sMarryMsg0} + PlayObject.m_sDearName + ' ' + ' ' + '已经正式脱离夫妻关系！！！' {sUnMarryMsg9}, t_Say);
        PoseHuman := UserEngine.GeTPlayObject(PlayObject.m_sDearName);
        if PoseHuman <> nil then
        begin
          PoseHuman.m_sDearName := '';
          Inc(PoseHuman.m_btMarryCount);
          PoseHuman.RefShowName;
        end
        else
        begin
          sUnMarryFileName := g_Config.sEnvirDir + 'UnMarry.txt';
          LoadList := TStringList.Create;
          if FileExists(sUnMarryFileName) then
          begin
            LoadList.LoadFromFile(sUnMarryFileName);
          end;
          LoadList.Add(PlayObject.m_sDearName);
          LoadList.SaveToFile(sUnMarryFileName);
          LoadList.Free;
        end;
        PlayObject.m_sDearName := '';
        Inc(PlayObject.m_btMarryCount);
        GotoLable(PlayObject, '@UnMarryEnd', False);
        PlayObject.RefShowName;
      end;
      exit;
    end;
  end;
  if (Baseobject = nil) or(Baseobject.m_btRaceServer <> RC_PLAYOBJECT)then
  begin
    GotoLable(PlayObject, '@UnMarryCheckDir', False);
    Exit;
  end;
    PoseHuman := TPlayObject(Baseobject);
  if PoseHuman <> nil then
  begin
    if QuestActionInfo.sParam1 = '' then
    begin
      if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then
      begin
        GotoLable(PlayObject, '@UnMarryTypeErr', False);
        exit;
      end;
      if PoseHuman.GetPoseCreate = PlayObject then
      begin
        if (PlayObject.m_sDearName = PoseHuman.m_sCharName) {and (PosHum.AddInfo.sDearName = Hum.sName)} then
        begin
          GotoLable(PlayObject, '@StartUnMarry', False);
          GotoLable(PoseHuman, '@StartUnMarry', False);
          exit;
        end;
      end;
    end;
  end;

end;

procedure TNormNpc.ClearScript; //0049E914
var
  III, IIII: Integer;
  I, II: Integer;
  Script: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
begin
  if m_ScriptList.Count>10000 then Exit;
  
  for I := 0 to m_ScriptList.Count - 1 do
  begin
    Script := m_ScriptList.Items[i];
    for II := 0 to Script.RecordList.Count - 1 do
    begin
      SayingRecord := Script.RecordList.Items[II];
      for III := 0 to SayingRecord.ProcedureList.Count - 1 do
      begin
        SayingProcedure := SayingRecord.ProcedureList.Items[III];
        for IIII := 0 to SayingProcedure.ConditionList.Count - 1 do
        begin
          Dispose(pTQuestConditionInfo(SayingProcedure.ConditionList.Items[IIII]));
        end;
        for IIII := 0 to SayingProcedure.ActionList.Count - 1 do
        begin
          Dispose(pTQuestActionInfo(SayingProcedure.ActionList.Items[IIII]));
        end;
        for IIII := 0 to SayingProcedure.ElseActionList.Count - 1 do
        begin
          Dispose(pTQuestActionInfo(SayingProcedure.ElseActionList.Items[IIII]));
        end;
        SayingProcedure.ConditionList.Free;
        SayingProcedure.ActionList.Free;
        SayingProcedure.ElseActionList.Free;
        Dispose(SayingProcedure);
      end; // for
      SayingRecord.ProcedureList.Free;
      Dispose(SayingRecord);
    end; // for
    Script.RecordList.Free;
    Dispose(Script);
  end; // for
  m_ScriptList.Clear;
end;

procedure TNormNpc.Click(PlayObject: TPlayObject); //0049EC18
begin
  PlayObject.m_nScriptGotoCount := 0;
  PlayObject.m_sScriptGoBackLable := '';
  PlayObject.m_sScriptCurrLable := '';
  GotoLable(PlayObject, '@main', False);

end;

function TNormNpc.ConditionOfCheckAccountIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
  Result := False;
  try
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;
    LoadList := TStringList.Create;
    if FileExists(g_Config.sEnvirDir + QuestConditionInfo.sParam1) then
    begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + QuestConditionInfo.sParam1);
      for I := 0 to LoadList.Count - 1 do
      begin
        sLine := LoadList.Strings[i];
        if sLine[1] = ';' then
          Continue;
        sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
        sIPaddr := Trim(sIPaddr);
        if (sName = sCharAccount) and (sIPaddr = sCharIPaddr) then
        begin
          Result := True;
          break;
        end;
      end;
    end
    else
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKACCOUNTIPLIST);
    end;
  finally
    LoadList.Free
  end;
end;

function TNormNpc.ConditionOfCheckBagSize(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nSize: Integer;
begin
  Result := False;
  nSize := QuestConditionInfo.nParam1;
  if (nSize <= 0) or (nSize > PlayObject.m_bMaxBagitem) then
  begin //MAXBAGITEM
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBAGSIZE);
    exit;
  end;
  if PlayObject.m_ItemList.Count + nSize <= PlayObject.m_bMaxBagitem then //MAXBAGITEM
    Result := True;
end;

function TNormNpc.ConditionOfCheckBonusPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nTotlePoint: Integer;
  cMethod: Char;
begin
  Result := False;
  nTotlePoint := m_BonusAbil.DC +
    m_BonusAbil.MC +
    m_BonusAbil.SC +
    m_BonusAbil.AC +
    m_BonusAbil.MAC +
    m_BonusAbil.HP +
    m_BonusAbil.MP +
    m_BonusAbil.Hit +
    m_BonusAbil.Speed +
    m_BonusAbil.X2;

  nTotlePoint := nTotlePoint + m_nBonusPoint;
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if nTotlePoint = QuestConditionInfo.nParam2 then
        Result := True;
    '>':
      if nTotlePoint > QuestConditionInfo.nParam2 then
        Result := True;
    '<':
      if nTotlePoint < QuestConditionInfo.nParam2 then
        Result := True;
  else
    if nTotlePoint >= QuestConditionInfo.nParam2 then
      Result := True;
  end;
end;


function TNormNpc.ConditionOfCheckHP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if PlayObject.m_WAbil.MaxHP = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if PlayObject.m_WAbil.MaxHP > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if PlayObject.m_WAbil.MaxHP < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if PlayObject.m_WAbil.MaxHP >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  if QuestConditionInfo.sParam1='' then exit;
    if QuestConditionInfo.sParam3='' then exit;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMin < 0) or (nMax < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHP);
    exit;
  end;

  case cMethodMin of
    '=':
      begin
        if (m_WAbil.HP = nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '>':
      begin
        if (PlayObject.m_WAbil.HP > nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '<':
      begin
        if (PlayObject.m_WAbil.HP < nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
  else
    begin
      if (PlayObject.m_WAbil.HP >= nMin) then
      begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckMP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if PlayObject.m_WAbil.MaxMP = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if PlayObject.m_WAbil.MaxMP > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if PlayObject.m_WAbil.MaxMP < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if PlayObject.m_WAbil.MaxMP >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
    if QuestConditionInfo.sParam1='' then exit;
      if QuestConditionInfo.sParam3='' then exit;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMin < 0) or (nMax < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMP);
    exit;
  end;

  case cMethodMin of
    '=':
      begin
        if (m_WAbil.MP = nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '>':
      begin
        if (PlayObject.m_WAbil.MP > nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '<':
      begin
        if (PlayObject.m_WAbil.MP < nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
  else
    begin
      if (PlayObject.m_WAbil.MP >= nMin) then
      begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckDC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if HiWord(PlayObject.m_WAbil.DC) = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if HiWord(PlayObject.m_WAbil.DC) > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if HiWord(PlayObject.m_WAbil.DC) < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if HiWord(PlayObject.m_WAbil.DC) >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
    if QuestConditionInfo.sParam1='' then exit;
  if QuestConditionInfo.sParam3='' then exit;    
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMin < 0) or (nMax < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKDC);
    exit;
  end;

  case cMethodMin of
    '=':
      begin
        if (LoWord(PlayObject.m_WAbil.DC) = nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '>':
      begin
        if (LoWord(PlayObject.m_WAbil.DC) > nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '<':
      begin
        if (LoWord(PlayObject.m_WAbil.DC) < nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
  else
    begin
      if (LoWord(PlayObject.m_WAbil.DC) >= nMin) then
      begin
        Result := CheckHigh;
      end;
    end;
  end;

  Result := False;
end;

function TNormNpc.ConditionOfCheckMC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if HiWord(PlayObject.m_WAbil.MC) = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if HiWord(PlayObject.m_WAbil.MC) > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if HiWord(PlayObject.m_WAbil.MC) < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if HiWord(PlayObject.m_WAbil.MC) >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  if QuestConditionInfo.sParam1='' then exit;
  if QuestConditionInfo.sParam3='' then exit;    
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMin < 0) or (nMax < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMC);
    exit;
  end;

  case cMethodMin of
    '=':
      begin
        if (LoWord(PlayObject.m_WAbil.MC) = nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '>':
      begin
        if (LoWord(PlayObject.m_WAbil.MC) > nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '<':
      begin
        if (LoWord(PlayObject.m_WAbil.MC) < nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
  else
    begin
      if (LoWord(PlayObject.m_WAbil.MC) >= nMin) then
      begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckSC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMin, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=':
        begin
          if HiWord(PlayObject.m_WAbil.SC) = nMax then
          begin
            Result := True;
          end;
        end;
      '>':
        begin
          if HiWord(PlayObject.m_WAbil.SC) > nMax then
          begin
            Result := True;
          end;
        end;
      '<':
        begin
          if HiWord(PlayObject.m_WAbil.SC) < nMax then
          begin
            Result := True;
          end;
        end;
    else
      begin
        if HiWord(PlayObject.m_WAbil.SC) >= nMax then
        begin
          Result := True;
        end;
      end;
    end;
  end;
begin
  Result := False;
  if QuestConditionInfo.sParam1='' then exit;
  if QuestConditionInfo.sParam3='' then exit;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam3[1];
  nMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMin < 0) or (nMax < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSC);
    exit;
  end;

  case cMethodMin of
    '=':
      begin
        if (LoWord(PlayObject.m_WAbil.SC) = nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '>':
      begin
        if (LoWord(PlayObject.m_WAbil.SC) > nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
    '<':
      begin
        if (LoWord(PlayObject.m_WAbil.SC) < nMin) then
        begin
          Result := CheckHigh;
        end;
      end;
  else
    begin
      if (LoWord(PlayObject.m_WAbil.SC) >= nMin) then
      begin
        Result := CheckHigh;
      end;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckExp(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  dwExp: LongWord;
begin
  Result := False;
  dwExp := Str_ToInt(QuestConditionInfo.sParam2, 0);
  if dwExp = 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKEXP);
    exit;
  end;
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_Abil.Exp = dwExp then
        Result := True;
    '>':
      if PlayObject.m_Abil.Exp > dwExp then
        Result := True;
    '<':
      if PlayObject.m_Abil.Exp < dwExp then
        Result := True;
  else
    if PlayObject.m_Abil.Exp >= dwExp then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckFlourishPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKFLOURISHPOINT);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if Guild.nFlourishing = nPoint then
        Result := True;
    '>':
      if Guild.nFlourishing > nPoint then
        Result := True;
    '<':
      if Guild.nFlourishing < nPoint then
        Result := True;
  else
    if Guild.nFlourishing >= nPoint then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckChiefItemCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
  Guild: TGuild;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKFLOURISHPOINT);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if Guild.nChiefItemCount = nCount then
        Result := True;
    '>':
      if Guild.nChiefItemCount > nCount then
        Result := True;
    '<':
      if Guild.nChiefItemCount < nCount then
        Result := True;
  else
    if Guild.nChiefItemCount >= nCount then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKAURAEPOINT);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
  if QuestConditionInfo.sParam1='' then exit;  
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if Guild.nAurae = nPoint then
        Result := True;
    '>':
      if Guild.nAurae > nPoint then
        Result := True;
    '<':
      if Guild.nAurae < nPoint then
        Result := True;
  else
    if Guild.nAurae >= nPoint then
      Result := True;
  end;

end;

function TNormNpc.ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBUILDPOINT);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if Guild.nBuildPoint = nPoint then
        Result := True;
    '>':
      if Guild.nBuildPoint > nPoint then
        Result := True;
    '<':
      if Guild.nBuildPoint < nPoint then
        Result := True;
  else
    if Guild.nBuildPoint >= nPoint then
      Result := True;
  end;

end;

function TNormNpc.conditionofCheckGuildExp(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Guild : TGuild;
  cMethod : Char;
begin
  Result:=False;
  Guild:=g_GuildManager.FindGuild(QuestConditionInfo.sParam1);
  if Guild=nil then
    exit;
  if QuestConditionInfo.sParam2='' then Exit;

  cMethod:=QuestConditionInfo.sParam2[1];

  case cMethod of
  '>' : Result:=Guild.nEXP> QuestConditionInfo.nParam3;
  '<' : Result:=Guild.nEXP< QuestConditionInfo.nParam3;
  '=' : Result:=Guild.nEXP= QuestConditionInfo.nParam3;
  '\' : Result:=Guild.nEXP>= QuestConditionInfo.nParam3;

  end;




end;
function TNormNpc.conditionofCheckGuildGrade(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Guild : TGuild;
  cMethod : Char;
begin
  Result:=False;
  Guild:=g_GuildManager.FindGuild(QuestConditionInfo.sParam1);
  if Guild=nil then
    exit;
  if QuestConditionInfo.sParam2='' then Exit;

  cMethod:=QuestConditionInfo.sParam2[1];

  case cMethod of
  '>' : Result:=Guild.nLevel> QuestConditionInfo.nParam3;
  '<' : Result:=Guild.nLevel< QuestConditionInfo.nParam3;
  '=' : Result:=Guild.nLevel= QuestConditionInfo.nParam3;
  '\' : Result:=Guild.nLevel>= QuestConditionInfo.nParam3;

  end;




end;
function TNormNpc.ConditionOfCheckStabilityPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGuild;
begin
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSTABILITYPOINT);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if Guild.nStability = nPoint then
        Result := True;
    '>':
      if Guild.nStability > nPoint then
        Result := True;
    '<':
      if Guild.nStability < nPoint then
        Result := True;
  else
    if Guild.nStability >= nPoint then
      Result := True;
  end;

end;


function TNormNpc.ConditionOfCHECKYEAR(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  Year, Month, Day: word;
   year1:Integer;
begin
  Result := False;
  DecodeDate(Date, Year, Month, Day);
  year1 := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if year1 < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKYEAR);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if Year = year1 then
        Result := True;
    '>':
      if Year > year1 then
        Result := True;
    '<':
      if Year < year1 then
        Result := True;
  else
    if Year >= year1 then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCHECKMonth(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  Year, Month, Day: word;
  Month1 :Integer;
begin
  Result := False;
  DecodeDate(Date, Year, Month, Day);
  Month1 := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if Month1 < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMonth);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if Month = Month1 then
        Result := True;
    '>':
      if Month > Month1 then
        Result := True;
    '<':
      if Month < Month1 then
        Result := True;
  else
    if Month >= Month1 then
      Result := True;
  end;
end;



function TNormNpc.ConditionOfCHECKMAPNAME(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMap: string;
  Envir: TEnvirnoment;
begin
  Result := False;
  sMap := QuestConditionInfo.sParam1;
  if sMap <> '' then
  begin
    Envir := g_MapManager.FindMap(sMap);
  end;
  if PlayObject.m_PEnvir = Envir then
    Result := True;
end;

function TNormNpc.ConditionOfCHECKDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  Year, Month, Day: word;
  Day1:Integer;
begin
  Result := False;
  DecodeDate(Date, Year, Month, Day);
  Day1 := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if Day1 < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKDay);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if Day = Day1 then
        Result := True;
    '>':
      if Day > Day1 then
        Result := True;
    '<':
      if Day < Day1 then
        Result := True;
  else
    if Day >= Day1 then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckGameGold(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGameGold: Integer;
begin
  Result := False;
  nGameGold := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nGameGold < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEGOLD);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;  
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_nGameGold = nGameGold then
        Result := True;
    '>':
      if PlayObject.m_nGameGold > nGameGold then
        Result := True;
    '<':
      if PlayObject.m_nGameGold < nGameGold then
        Result := True;
    '~':
       if PlayObject.m_nGameGold >= nGameGold then
        Result := True;
  else
    if PlayObject.m_nGameGold >= nGameGold then
      Result := True;
  end;
end;
function TNormNpc.ConditionOfCheckUserGap(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result:=False;
  if QuestConditionInfo.sParam1='' then Exit;
  case QuestConditionInfo.sParam1[1] of
  '>':
  begin
     if (Abs(Playobject.m_nCurrX-m_nCurrX)>QuestConditionInfo.nParam2) and(Abs(Playobject.m_nCurrY-m_nCurrY)>QuestConditionInfo.nParam2) then
         Result:=True;
  end;
  '<':
  begin
     if (Abs(Playobject.m_nCurrX-m_nCurrX)<QuestConditionInfo.nParam2) and(Abs(Playobject.m_nCurrY-m_nCurrY)<QuestConditionInfo.nParam2) then
         Result:=True;
  end;
  '=':
  begin
     if (Abs(Playobject.m_nCurrX-m_nCurrX)=QuestConditionInfo.nParam2) and(Abs(Playobject.m_nCurrY-m_nCurrY)=QuestConditionInfo.nParam2) then
         Result:=True;
  end;
  '\':
  begin
     if (Abs(Playobject.m_nCurrX-m_nCurrX)<>QuestConditionInfo.nParam2) and(Abs(Playobject.m_nCurrY-m_nCurrY)<>QuestConditionInfo.nParam2) then
         Result:=True;
  end;
  end;
end;


function TNormNpc.ConditionOfCHECKJPPOINT(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  njpPoint: Integer;
begin
  Result := False;
  njpPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if njpPoint < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKJPPOINT);
    exit;
  end;
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_nJpPoint = njpPoint then
        Result := True;
    '>':
      if PlayObject.m_nJpPoint > njpPoint then
        Result := True;
    '<':
      if PlayObject.m_nJpPoint < njpPoint then
        Result := True;
  else
    if PlayObject.m_nJpPoint >= njpPoint then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCHECKYSPOINT(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nysPoint: Integer;
begin
  Result := False;
  nysPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nysPoint < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKYSPOINT);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_YSPoint = nysPoint then
        Result := True;
    '>':
      if PlayObject.m_YSPoint > nysPoint then
        Result := True;
    '<':
      if PlayObject.m_YSPoint < nysPoint then
        Result := True;
  else
    if PlayObject.m_YSPoint >= nysPoint then
      Result := True;
  end;
end;


function TNormNpc.ConditionOfCheckGamePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGamePoint: Integer;
begin
  Result := False;
  nGamePoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nGamePoint < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEPOINT);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_nGamePoint = nGamePoint then
        Result := True;
    '>':
      if PlayObject.m_nGamePoint > nGamePoint then
        Result := True;
    '<':
      if PlayObject.m_nGamePoint < nGamePoint then
        Result := True;
  else
    if PlayObject.m_nGamePoint >= nGamePoint then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckGroupCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
begin
  Result := False;
  if PlayObject.m_GroupOwner = nil then
    exit;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGROUPCOUNT);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_GroupOwner.m_GroupMembers.Count = nCount then
        Result := True;
    '>':
      if PlayObject.m_GroupOwner.m_GroupMembers.Count > nCount then
        Result := True;
    '<':
      if PlayObject.m_GroupOwner.m_GroupMembers.Count < nCount then
        Result := True;
  else
    if PlayObject.m_GroupOwner.m_GroupMembers.Count >= nCount then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckHaveGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
//  Result:=PlayObject.m_MyGuild = nil;
  Result := PlayObject.m_MyGuild <> nil; // 01-16 更正检查结果反了
end;

function TNormNpc.ConditionOfCheckInMapRange(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMapName: string;
  nX, nY, nRange: Integer;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (sMapName = '') or (nX < 0) or (nY < 0) or (nRange < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKINMAPRANGE);
    exit;
  end;
  if CompareText(PlayObject.m_sMapName, sMapName) <> 0 then
    exit;
  if (abs(PlayObject.m_nCurrX - nX) <= nRange) and (abs(PlayObject.m_nCurrY - nY) <= nRange) then
    Result := True;
end;

function TNormNpc.ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if m_Castle = nil then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISATTACKGUILD);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
    exit;
  Result := TUserCastle(m_Castle).IsAttackGuild(TGuild(PlayObject.m_MyGuild));
end;

function TNormNpc.ConditionOfCheckCastleChageDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  cMethod: Char;
  nChangeDay: Integer;
begin
  Result := False;
  nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if (nDay < 0) or (m_Castle = nil) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLECHANGEDAY);
    exit;
  end;
  nChangeDay := GetDayCount(Now, TUserCastle(m_Castle).m_ChangeDate);
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if nChangeDay = nDay then
        Result := True;
    '>':
      if nChangeDay > nDay then
        Result := True;
    '<':
      if nChangeDay < nDay then
        Result := True;
  else
    if nChangeDay >= nDay then
      Result := True;
  end;

end;

function TNormNpc.ConditionOfCheckCastleWarDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  cMethod: Char;
  nWarDay: Integer;
begin
  Result := False;
  nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if (nDay < 0) or (m_Castle = nil) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLEWARDAY);
    exit;
  end;
  nWarDay := GetDayCount(Now, TUserCastle(m_Castle).m_WarDate);
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if nWarDay = nDay then
        Result := True;
    '>':
      if nWarDay > nDay then
        Result := True;
    '<':
      if nWarDay < nDay then
        Result := True;
  else
    if nWarDay >= nDay then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;

  nDoorStatus: Integer;
  CastleDoor: TCastleDoor;
begin
  Result := False;
  nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nDoorStatus := -1;
  if CompareText(QuestConditionInfo.sParam1, '损坏') = 0 then
    nDoorStatus := 0;
  if CompareText(QuestConditionInfo.sParam1, '开启') = 0 then
    nDoorStatus := 1;
  if CompareText(QuestConditionInfo.sParam1, '关闭') = 0 then
    nDoorStatus := 2;

  if (nDay < 0) or (m_Castle = nil) or (nDoorStatus < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEDOOR);
    exit;
  end;
  CastleDoor := TCastleDoor(TUserCastle(m_Castle).m_MainDoor.BaseObject);

  case nDoorStatus of
    0:
      if CastleDoor.m_boDeath then
        Result := True;
    1:
      if CastleDoor.m_boOpened then
        Result := True;
    2:
      if not CastleDoor.m_boOpened then
        Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckIsAttackAllyGuild(
  PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if m_Castle = nil then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISATTACKALLYGUILD);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
    exit;
  Result := TUserCastle(m_Castle).IsAttackAllyGuild(TGuild(PlayObject.m_MyGuild));
end;

function TNormNpc.ConditionOfCheckIsDefenseAllyGuild(
  PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if m_Castle = nil then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISDEFENSEALLYGUILD);
    exit;
  end;

  if PlayObject.m_MyGuild = nil then
    exit;
  Result := TUserCastle(m_Castle).IsDefenseAllyGuild(TGuild(PlayObject.m_MyGuild));
end;

function TNormNpc.ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if m_Castle = nil then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISDEFENSEGUILD);
    exit;
  end;

  if PlayObject.m_MyGuild = nil then
    exit;
  Result := TUserCastle(m_Castle).IsDefenseGuild(TGuild(PlayObject.m_MyGuild));
end;

function TNormNpc.ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
//  if (PlayObject.m_MyGuild <> nil) and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
  if g_CastleManager.IsCastleMember(PlayObject) <> nil then
    Result := True;
end;

function TNormNpc.ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  //if PlayObject.IsGuildMaster and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
  if PlayObject.IsGuildMaster and (g_CastleManager.IsCastleMember(PlayObject) <> nil) then
    Result := True;
end;

function TNormNpc.ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := PlayObject.IsGuildMaster;
end;

function TNormNpc.ConditionOfCheckIsMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if (PlayObject.m_sMasterName <> '') and (PlayObject.m_boMaster) then
    Result := True;
end;

function TNormNpc.ConditionOfCheckListCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
   Result:=True;
end;



function TNormNpc.ConditionOfCheckItemAddValue(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  nWhere: Integer;
  nAddAllValue, nAddValue: Integer;
  UserItem: pTUserItem;
  cMethod: Char;
begin
  Result := False;
  nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
    if QuestConditionInfo.sParam2='' then exit;
  cMethod := QuestConditionInfo.sParam2[1];
  nAddValue := Str_ToInt(QuestConditionInfo.sParam3, -1);
  if not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)]) or (nAddValue < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMADDVALUE);
    exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  if UserItem.wIndex = 0 then
  begin
    exit;
  end;
  nAddAllValue := 0;
  for I := Low(UserItem.btValue) to High(UserItem.btValue) do
  begin
    Inc(nAddAllValue, UserItem.btValue[I]);
  end;
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if nAddAllValue = nAddValue then
        Result := True;
    '>':
      if nAddAllValue > nAddValue then
        Result := True;
    '<':
      if nAddAllValue < nAddValue then
        Result := True;
  else
    if nAddAllValue >= nAddValue then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckITEMDARKPROPERTY(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nItemPos: Integer;
  nDarkPos: Integer;
  nDarkValue: Integer;
  nItemDarkValue: Integer;
  DarkProperty: TDarkProperty;
begin
  Result := False;
  nItempos := QuestConditionInfo^.nParam1;
  nDarkPos := QuestConditionInfo^.nParam2;
  nDarkValue := QuestConditionInfo^.nParam4;
  if not nItemPos in [0..12] then
    exit;
  if not nDarkPos in [0..9] then
    exit;
  if PlayObject.m_UseItems[nItemPos].wIndex = 0 then
    Exit;

  if QuestConditionInfo.sParam3 = '' then
    exit;
  DarkProperty :=PlayObject.m_UseItems[nItemPos].DarkProp;// ItemUnit.GetItemDarkProperty(PlayObject.m_UseItems[nItemPos].MakeIndex, PlayObject.m_UseItems[nItemPos].wIndex);
  case nDarkPos of
    0: nItemDarkValue := DarkProPerty.DMagic;
    1: nItemDarkValue := DarkProPerty.DDC and $0F;
    2: nItemDarkValue := (DarkProPerty.DDC and$F0) shr 4;
    3: nItemDarkValue := DarkProPerty.DMC and $0F;
    4: nItemDarkValue := (DarkProPerty.DMC and$F0) shr 4;
    5: nItemDarkValue := DarkProPerty.DSC and $0F;
    6: nItemDarkValue := (DarkProPerty.DSC and$F0) shr 4;
    7: nItemDarkValue := DarkProPerty.DAC and $0F;
    8: nItemDarkValue := (DarkProPerty.DAC and$F0) shr 4;
    9: nItemDarkValue := DarkProPerty.DMAC and $0F;
    10: nItemDarkValue := (DarkProPerty.DMAC and$F0) shr 4;

  end;
   if QuestConditionInfo.sParam3='' then exit;
  case QuestConditionInfo.sParam3[1] of
    '>':
      if nItemDarkValue > ndarkValue then
        result := True;
    '<':
      if nItemDarkValue < ndarkValue then
        result := True;
    '=':
      if nItemDarkValue = ndarkValue then
        result := True;
  end;


end;
 function TNormNpc.conditionofCHECKITEMDURE(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  nCount:Integer;
  UserItem: pTUserItem;
  s1C,sItemName: string;
begin
  Result := False ;
  nCount := 0;
  sItemName:=QuestConditionInfo.sParam1;
  try
  for I := PlayObject.m_ItemList.Count - 1 downto 0  do
  begin
    UserItem := PlayObject.m_ItemList.Items[i];
    s1C := UserEngine.GetStdItemName(UserItem.wIndex);
    if CompareText(s1C, sItemName) = 0 then
    begin
      if UserItem.Dura >= QuestConditionInfo.nParam2 then
      begin
        Inc(nCount);
        if nCount>=QuestConditionInfo.nParam3 then
        begin
          Result:=True;
          Break;
        end;
      end;
    end; //004C4C97
  end;
  except
      MainOutMessage('CheckItem Error!');
  end;
end;
 function TNormNpc.conditionofCHECKMONPOS(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sMapName: string;
  Envir: TEnvirnoment ;
  MonList:TList;
  Mon:TBaseObject;
begin
  Result := False ;
  sMapName:=QuestConditionInfo.sParam2;
  Envir:=g_MapManager.FindMap(sMapName);
  if Envir=nil then Exit;
  MonList:=TList.Create;
  try
     UserEngine.GetMapMonster(Envir,MonList);
     for I := 0 to MonList.Count - 1 do
     begin
        Mon:=TBaseObject(MonList[i]);
        if mon.m_sCharName=QuestConditionInfo.sParam1 then
        begin
          Result:=True;
          Playobject.m_sParam[31]:=IntToStr(Mon.m_ncurrx);
          Playobject.m_sParam[32]:=IntToStr(Mon.m_ncurrY);
          Exit;
        end;
     end;
       
  finally
      MonList.Free;
  end;
 

end;

function TNormNpc.ConditionOfCHECKUPGRADECOUNT(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nItemPos: Integer;
  nDarkPos: Integer;
  nDarkValue: Integer;
  nItemDarkValue: Integer;
  DarkProperty: TDarkProperty;
  UserItem:pTUserItem;

begin
  Result := False;
  nItempos := QuestConditionInfo^.nParam1;
  nDarkPos := QuestConditionInfo^.nParam2;
  nDarkValue := QuestConditionInfo^.nParam4;
  if not nItemPos in [0..12] then
    exit;
  if not nDarkPos in [0..46] then
    exit;
  if PlayObject.m_UseItems[nItemPos].wIndex = 0 then
    Exit;

  if QuestConditionInfo.sParam3 = '' then
    exit;

  DarkProperty :=PlayObject.m_UseItems[nItemPos].DarkProp;// ItemUnit.GetItemDarkProperty(PlayObject.m_UseItems[nItemPos].MakeIndex, PlayObject.m_UseItems[nItemPos].wIndex);
   UserItem:=@PlayObject.m_UseItems[nItemPos];
  case nDarkPos of
   0..12:
   begin
     nItemDarkValue:=UserItem.btValue[nDarkPos];
   end;
   13:
     nItemDarkValue:=UserItem.Dura;
   14:
     nItemDarkValue:=UserItem.DuraMax;
    19: nItemDarkValue := DarkProPerty.DMagic;
    20: nItemDarkValue := DarkProPerty.DDC and $0F;
    21: nItemDarkValue := (DarkProPerty.DDC and$F0) shr 4;
    22: nItemDarkValue := DarkProPerty.DMC and $0F;
    23: nItemDarkValue := (DarkProPerty.DMC and$F0) shr 4;
    24: nItemDarkValue := DarkProPerty.DSC and $0F;
    25: nItemDarkValue := (DarkProPerty.DSC and$F0) shr 4;
    26: nItemDarkValue := DarkProPerty.DAC and $0F;
    27: nItemDarkValue := (DarkProPerty.DAC and$F0) shr 4;
    28: nItemDarkValue := DarkProPerty.DMAC and $0F;
    29: nItemDarkValue := (DarkProPerty.DMAC and$F0) shr 4;
    30: nItemDarkValue:= DarkProperty.DNEEDLEVEL;
    45: nItemDarkValue:=DarkProperty.btMagicID;
    46: nItemDarkValue:=DarkProperty.btMagicPower;
    31..44:
    begin

      begin
         case nDarkPos of
          31:
          begin
             if UserItem.AttachMagic.MercenaryName=QuestConditionInfo^.sParam4 then
             begin
               Result:=True;
               Exit;
             end;
          end;
          32:
            nItemDarkValue:=UserItem.AttachMagic.MercenaryJob;
          33:
            nItemDarkValue:=UserItem.AttachMagic.MercenaryState;
          34:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.DC);
          35:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.DC);
          36:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.MC);
          37:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.MC);
          38:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.SC);
          39:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.SC);
          40:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.AC);
          41:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.AC);
          42:
            nItemDarkValue:=LoByte(UserItem.AttachMagic.MAC);
          43:
            nItemDarkValue:=HiByte(UserItem.AttachMagic.MAC);
          44:
            nItemDarkValue:= UserItem.AttachMagic.ZMValue;
         end;
      end;
    end;
  end;
    if QuestConditionInfo.sParam3='' then exit;
  case QuestConditionInfo.sParam3[1] of
    '>':
      if nItemDarkValue > ndarkValue then
        result := True;
    '<':
      if nItemDarkValue < ndarkValue then
        result := True;
    '=':
      if nItemDarkValue = ndarkValue then
        result := True;
  end;


end;

function TNormNpc.ConditionOfCheckItemType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  nType: Integer;
  UserItem: pTUserItem;
  Stditem: pTStditem;
begin
  Result := False;
  nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  nType := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)]) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMTYPE);
    exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  if UserItem.wIndex = 0 then
    exit;
  Stditem := UserEngine.GetStdItem(UserItem.wIndex);
  if (Stditem <> nil) and (Stditem.StdMode = nType) then
  begin
    Result := True;
  end;

end;

function TNormNpc.ConditionOfCheckLevelEx(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
    exit;
  end;
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_Abil.Level = nLevel then
        Result := True;
    '>':
      if PlayObject.m_Abil.Level > nLevel then
        Result := True;
    '<':
      if PlayObject.m_Abil.Level < nLevel then
        Result := True;
  else
    if PlayObject.m_Abil.Level >= nLevel then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckNameListPostion(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  nNamePostion, nPostion: Integer;
  sLine: string;
begin
  Result := False;
  nNamePostion := -1;
  try
    sCharName := PlayObject.m_sCharName;
    LoadList := TStringList.Create;
    if FileExists(g_Config.sEnvirDir + QuestConditionInfo.sParam1) then
    begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + QuestConditionInfo.sParam1);
      for I := 0 to LoadList.Count - 1 do
      begin
        sLine := Trim(LoadList.Strings[i]);
        if sLine[1] = ';' then
          Continue;
        if CompareText(sLine, sCharName) = 0 then
        begin
          nNamePostion := I;
          break;
        end;
      end;
    end
    else
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMELISTPOSITION);
    end;
  finally
    LoadList.Free
  end;
  nPostion := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPostion < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMELISTPOSITION);
    exit;
  end;
  
  if nNamePostion >= nPostion then
    Result := True;
end;

function TNormNpc.ConditionOfCheckMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if PlayObject.m_sDearName <> '' then
    Result := True;
end;

function TNormNpc.ConditionOfCheckMarryCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMARRYCOUNT);
    exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_btMarryCount = nCount then
        Result := True;
    '>':
      if PlayObject.m_btMarryCount > nCount then
        Result := True;
    '<':
      if PlayObject.m_btMarryCount < nCount then
        Result := True;
  else
    if PlayObject.m_btMarryCount >= nCount then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if (PlayObject.m_sMasterName <> '') and (not PlayObject.m_boMaster) then
    Result := True;
end;

function TNormNpc.ConditionOfCheckMemBerLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMEMBERLEVEL);
    exit;
  end;
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_nMemberLevel = nLevel then
        Result := True;
    '>':
      if PlayObject.m_nMemberLevel > nLevel then
        Result := True;
    '<':
      if PlayObject.m_nMemberLevel < nLevel then
        Result := True;
  else
    if PlayObject.m_nMemberLevel >= nLevel then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckMemberType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nType: Integer;
  cMethod: Char;
begin
  Result := False;
  nType := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nType < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMEMBERTYPE);
    exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_nMemberType = nType then
        Result := True;
    '>':
      if PlayObject.m_nMemberType > nType then
        Result := True;
    '<':
      if PlayObject.m_nMemberType < nType then
        Result := True;
  else
    if PlayObject.m_nMemberType >= nType then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckNameIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
  Result := False;
  try
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;
    LoadList := TStringList.Create;
    if FileExists(g_Config.sEnvirDir + QuestConditionInfo.sParam1) then
    begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + QuestConditionInfo.sParam1);
      for I := 0 to LoadList.Count - 1 do
      begin
        sLine := LoadList.Strings[i];
        if sLine[1] = ';' then
          Continue;
        sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
        sIPaddr := Trim(sIPaddr);
        if (sName = sCharName) and (sIPaddr = sCharIPaddr) then
        begin
          Result := True;
          break;
        end;
      end;
    end
    else
    begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEIPLIST);
    end;
  finally
    LoadList.Free
  end;
end;

function TNormNpc.ConditionOfCheckPoseDir(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.GetPoseCreate = PlayObject) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
  begin
    case QuestConditionInfo.nParam1 of
      1:
        if PoseHuman.m_btGender = PlayObject.m_btGender then
          Result := True; //要求相同性别
      2:
        if PoseHuman.m_btGender <> PlayObject.m_btGender then
          Result := True; //要求不同性别
    else
      Result := True; //无参数时不判别性别
    end;
  end;
end;

function TNormNpc.ConditionOfCheckPoseGender(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
  btSex: Byte;
begin
  Result := False;
  btSex := 0;
  if CompareText(QuestConditionInfo.sParam1, 'MAN') = 0 then
  begin
    btSex := 0;
  end
  else
    if CompareText(QuestConditionInfo.sParam1, '男') = 0 then
    begin
      btSex := 0;
    end
    else
      if CompareText(QuestConditionInfo.sParam1, 'WOMAN') = 0 then
      begin
        btSex := 1;
      end
      else
        if CompareText(QuestConditionInfo.sParam1, '女') = 0 then
        begin
          btSex := 1;
        end;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
  begin
    if PoseHuman.m_btGender = btSex then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
  begin
    if (TPlayObject(PoseHuman).m_sMasterName <> '') and (TPlayObject(PoseHuman).m_boMaster) then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckPoseLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  PoseHuman: TBaseObject;
  cMethod: Char;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPOSELEVEL);
    exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
  begin
    case cMethod of
      '=':
        if PoseHuman.m_Abil.Level = nLevel then
          Result := True;
      '>':
        if PoseHuman.m_Abil.Level > nLevel then
          Result := True;
      '<':
        if PoseHuman.m_Abil.Level < nLevel then
          Result := True;
    else
      if PoseHuman.m_Abil.Level >= nLevel then
        Result := True;
    end;
  end;

end;

function TNormNpc.ConditionOfCheckPoseMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
  begin
    if TPlayObject(PoseHuman).m_sDearName <> '' then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckPoseMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
  begin
    if (TPlayObject(PoseHuman).m_sMasterName <> '') and not (TPlayObject(PoseHuman).m_boMaster) then
      Result := True;
  end;
end;


function TNormNpc.ConditionOfCheckServerName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;

begin
  Result := False;
  if QuestConditionInfo.sParam1 = g_Config.sServerName then
    Result := True;
end;

function TNormNpc.ConditionOfCheckys(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;

begin
  Result := False;
  case QuestConditionInfo.nParam1 of
   2:
  Begin
    Result:=PlayObject.btHasYS2>0;
  End;
  else
  Begin
  if playobject.sysname <> '' then
    Result := True;
  End;
  end;
end;


function TNormNpc.ConditionOfCheckSlaveCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSLAVECOUNT);
    exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_SlaveList.Count = nCount then
        Result := True;
    '>':
      if PlayObject.m_SlaveList.Count > nCount then
        Result := True;
    '<':
      if PlayObject.m_SlaveList.Count < nCount then
        Result := True;
  else
    if PlayObject.m_SlaveList.Count >= nCount then
      Result := True;
  end;
end;

constructor TNormNpc.Create; //0049AA38
begin
  inherited;
     m_nFlash:=0;
    m_nType:=0;

  m_boGuildTower:=False;
  m_boSuperMan := True;
  m_btRaceServer := RC_NPC;
  m_nLight := 2;
  m_btAntiPoison := 99;
  m_ScriptList := TList.Create;
  m_boStickMode := True;
  m_sFilePath := '';
  m_boIsHide := False;
  m_boIsQuest := True;
  m_nDelayTime:=0;
  m_BBsList:=TStringList.Create ;
end;

destructor TNormNpc.Destroy; //0049AAE4

begin
  if (self.mirrorname = '') or m_boAddtoMapSuccess then
  begin //如果是镜像NPC不用清除
    ClearScript();
  {
  for I := 0 to ScriptList.Count - 1 do begin
    Dispose(pTScript(ScriptList.Items[I]));
  end;
  }
    m_ScriptList.Free;
  end;
  inherited;
end;

procedure TNormNpc.ExeAction(PlayObject: TPlayObject; sParam1, sParam2,
  sParam3: string; nParam1, nParam2, nParam3: Integer);
var
  nInt1: Integer;
  dwInt: LongWord;

begin
  //================================================
  //更改人物当前经验值
  //EXEACTION CHANGEEXP 0 经验数  设置为指定经验值
  //EXEACTION CHANGEEXP 1 经验数  增加指定经验
  //EXEACTION CHANGEEXP 2 经验数  减少指定经验
  //================================================
  if CompareText(sParam1, 'CHANGEEXP') = 0 then
  begin
    nInt1 := Str_ToInt(sParam2, -1);
    case nInt1 of //
      0:
        begin
          if nParam3 >= 0 then
          begin
            PlayObject.m_Abil.Exp := LongWord(nParam3);
            PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          end;
        end;
      1:
        begin
          if PlayObject.m_Abil.Exp >= LongWord(nParam3) then
          begin
            if (PlayObject.m_Abil.Exp - LongWord(nParam3)) > (High(LongWord) - PlayObject.m_Abil.Exp) then
            begin
              dwInt := High(LongWord) - PlayObject.m_Abil.Exp;
            end
            else
            begin
              dwInt := LongWord(nParam3);
            end;
          end
          else
          begin
            if (LongWord(nParam3) - PlayObject.m_Abil.Exp) > (High(LongWord) - LongWord(nParam3)) then
            begin
              dwInt := High(LongWord) - LongWord(nParam3);
            end
            else
            begin
              dwInt := LongWord(nParam3);
            end;
          end;
          Inc(PlayObject.m_Abil.Exp, dwInt);
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
      2:
        begin
          if PlayObject.m_Abil.Exp > LongWord(nParam3) then
          begin
            Dec(PlayObject.m_Abil.Exp, LongWord(nParam3));
          end
          else
          begin
            PlayObject.m_Abil.Exp := 0;
          end;
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
    end;
    PlayObject.SysMsg('您当前经验点数为: ' + IntToStr(PlayObject.m_Abil.Exp) + '/' + IntToStr(PlayObject.m_Abil.MaxExp), c_Green, t_Hint);
    exit;
  end;

  //================================================
  //更改人物当前等级
  //EXEACTION CHANGELEVEL 0 等级数  设置为指定等级
  //EXEACTION CHANGELEVEL 1 等级数  增加指定等级
  //EXEACTION CHANGELEVEL 2 等级数  减少指定等级
  //================================================
  if CompareText(sParam1, 'CHANGELEVEL') = 0 then
  begin
    nInt1 := Str_ToInt(sParam2, -1);
    case nInt1 of //
      0:
        begin
          if nParam3 >= 0 then
          begin
            PlayObject.m_Abil.Level := LongWord(nParam3);
            PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          end;
        end;
      1:
        begin
          if PlayObject.m_Abil.Level >= LongWord(nParam3) then
          begin
            if (PlayObject.m_Abil.Level - LongWord(nParam3)) > (High(Word) - PlayObject.m_Abil.Level) then
            begin
              dwInt := High(Word) - PlayObject.m_Abil.Level;
            end
            else
            begin
              dwInt := LongWord(nParam3);
            end;
          end
          else
          begin
            if (LongWord(nParam3) - PlayObject.m_Abil.Level) > (High(Word) - LongWord(nParam3)) then
            begin
              dwInt := High(LongWord) - LongWord(nParam3);
            end
            else
            begin
              dwInt := LongWord(nParam3);
            end;
          end;
          Inc(PlayObject.m_Abil.Level, dwInt);
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
      2:
        begin
          if PlayObject.m_Abil.Level > LongWord(nParam3) then
          begin
            Dec(PlayObject.m_Abil.Level, LongWord(nParam3));
          end
          else
          begin
            PlayObject.m_Abil.Level := 0;
          end;
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
    end;
    PlayObject.SysMsg('您当前等级为: ' + IntToStr(PlayObject.m_Abil.Level), c_Green, t_Hint);
    exit;
  end;

  //================================================
  //杀死人物
  //EXEACTION KILL 0 人物死亡,不显示凶手信息
  //EXEACTION KILL 1 人物死亡不掉物品,不显示凶手信息
  //EXEACTION KILL 2 人物死亡,显示凶手信息为NPC
  //EXEACTION KILL 3 人物死亡不掉物品,显示凶手信息为NPC
  //================================================
  if CompareText(sParam1, 'KILL') = 0 then
  begin
    nInt1 := Str_ToInt(sParam2, -1);
    case nInt1 of //
      1:
        begin
          PlayObject.m_boNoItem := True;
          PlayObject.Die;
        end;
      2:
        begin
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
      3:
        begin
          PlayObject.m_boNoItem := True;
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
    else
      begin
        PlayObject.Die;
      end;
    end;
    exit;
  end;

  //================================================
  //踢人物下线
  //EXEACTION KICK
  //================================================
  if CompareText(sParam1, 'KICK') = 0 then
  begin
    PlayObject.m_boKickFlag := True;
    exit;
  end;


  //==============================================================================
end;

function TNormNpc.GetLineVariableText(PlayObject: TPlayObject;
  sMsg: string): string;
var
  nC: Integer;
  s10: string;
begin
  nC := 0;
  while (True) do
  begin
    if TagCount(sMsg, '>') < 1 then
      break;
    ArrestStringEx(sMsg, '<', '>', s10);
    if (s10 <> '') and (s10[1] = '$') then
      GetVariableText(PlayObject, sMsg, s10);
    Inc(nC);
    if nC >= 101 then
      break;
  end;
  Result := sMsg;
end;

procedure TNormNpc.GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); //0049AEA4
var
  sText, s14,s18: string;
  I,n14,n24: Integer;
  Intrec:TIntRec ;
  n18: Integer;
  wHour: Word;
  wMinute: Word;
  wSecond: Word;
  nSecond: Integer;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  hum: TplayObject;
  StdItem : TClientItem;
  Item: pTStdItem;
  UserItem : PTUserItem;
  BaseObject:TPlayObject ;
  UserMagic: pTUserMagic;
  pquestion :pTquestion;
begin
//全局信息
//  sVariable:=UpperCase(sVariable);

  if sVariable = '$SERVERNAME' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$SERVERNAME>', g_Config.sServerName);
    exit;
  end;
  if sVariable = '$SERVERIP' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$SERVERIP>', g_Config.sServerIPaddr);
    exit;
  end;
  if sVariable = '$WEBSITE' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$WEBSITE>', g_Config.sWebSite);
    exit;
  end;
  if sVariable = '$BBSSITE' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BBSSITE>', g_Config.sBbsSite);
    exit;
  end;
  if sVariable = '$CLIENTDOWNLOAD' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CLIENTDOWNLOAD>', g_Config.sClientDownload);
    exit;
  end;
  if sVariable = '$QQ' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$QQ>', g_Config.sQQ);
    exit;
  end;
  if sVariable = '$PHONE' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$PHONE>', g_Config.sPhone);
    exit;
  end;
  if sVariable = '$BANKACCOUNT0' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT0>', g_Config.sBankAccount0);
    exit;
  end;
  if sVariable = '$BANKACCOUNT1' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT1>', g_Config.sBankAccount1);
    exit;
  end;
  if sVariable = '$BANKACCOUNT2' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT2>', g_Config.sBankAccount2);
    exit;
  end;
  if sVariable = '$BANKACCOUNT3' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT3>', g_Config.sBankAccount3);
    exit;
  end;
  if sVariable = '$BANKACCOUNT4' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT4>', g_Config.sBankAccount4);
    exit;
  end;
  if sVariable = '$BANKACCOUNT5' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT5>', g_Config.sBankAccount5);
    exit;
  end;
  if sVariable = '$BANKACCOUNT6' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT6>', g_Config.sBankAccount6);
    exit;
  end;
  if sVariable = '$BANKACCOUNT7' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT7>', g_Config.sBankAccount7);
    exit;
  end;
  if sVariable = '$BANKACCOUNT8' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT8>', g_Config.sBankAccount8);
    exit;
  end;
  if sVariable = '$BANKACCOUNT9' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT9>', g_Config.sBankAccount9);
    exit;
  end;
  if sVariable = '$GAMEGOLDNAME' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$GAMEGOLDNAME>', g_Config.sGameGoldName);
    exit;
  end;
  if sVariable = '$GAMEPOINTNAME' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$GAMEPOINTNAME>', g_Config.sGamePointName);
    exit;
  end;
  if sVariable = '$USERCOUNT' then
  begin
    sText := IntToStr(UserEngine.PlayObjectCount);
    sMsg := sub_49ADB8(sMsg, '<$USERCOUNT>', sText);
    exit;
  end;
  if sVariable = '$MACRUNTIME' then
  begin
    sText := CurrToStr(GetTickCount / (24 * 60 * 60 * 1000));
    sMsg := sub_49ADB8(sMsg, '<$MACRUNTIME>', sText);
    exit;
  end;
  if sVariable = '$SERVERRUNTIME' then
  begin
    nSecond := (GetTickCount() - g_dwStartTick) div 1000;
    wHour := nSecond div 3600;
    wMinute := (nSecond div 60) mod 60;
    wSecond := nSecond mod 60;
    sText := format('%d:%d:%d', [wHour, wMinute, wSecond]);
    sMsg := sub_49ADB8(sMsg, '<$SERVERRUNTIME>', sText);
    exit;
  end;
  if sVariable = '$DATAS' then
  begin

    wHour := DayOfTheMonth(Now);

    sMsg := sub_49ADB8(sMsg, '<$DATAS>', IntToStr(wHour));
    exit;
  end;
  if sVariable = '$WEEK' then
  begin

    wHour := DayOfTheWeek(Now);

    sMsg := sub_49ADB8(sMsg, '<$WEEK>', IntToStr(wHour));
    exit;
  end;
  if sVariable = '$HOUR' then
  begin

    wHour := HourOfTheDay(Now);

    sMsg := sub_49ADB8(sMsg, '<$HOUR>', IntToStr(wHour));
    exit;
  end;
  if sVariable = '$MIN' then
  begin

    wHour := MinuteOfTheHour(Now);

    sMsg := sub_49ADB8(sMsg, '<$MIN>', IntToStr(wHour));
    exit;
  end;
  if sVariable = '$SEC' then
  begin

    wHour := SecondOfTheHour(Now);

    sMsg := sub_49ADB8(sMsg, '<$SEC>', IntToStr(wHour));
    exit;
  end;
  if sVariable = '$DATETIME' then
  begin
//    sText:=DateTimeToStr(Now);
    sText := FormatDateTime('dddddd,dddd,hh:mm:nn', Now);
    sMsg := sub_49ADB8(sMsg, '<$DATETIME>', sText);
    exit;
  end;

  if sVariable = '$HIGHLEVELINFO' then
  begin
    if g_HighLevelHuman <> nil then
    begin
      sText := TPlayObject(g_HighLevelHuman).GetMyInfo;
    end
    else
      sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHLEVELINFO>', sText);
    exit;
  end;
  if sVariable = '$HIGHPKINFO' then
  begin
    if g_HighPKPointHuman <> nil then
    begin
      sText := TPlayObject(g_HighPKPointHuman).GetMyInfo;
    end
    else
      sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHPKINFO>', sText);
    exit;
  end;
  if sVariable = '$HIGHDCINFO' then
  begin
    if g_HighDCHuman <> nil then
    begin
      sText := TPlayObject(g_HighDCHuman).GetMyInfo;
    end
    else
      sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHDCINFO>', sText);
    exit;
  end;
  if sVariable = '$HIGHMCINFO' then
  begin
    if g_HighMCHuman <> nil then
    begin
      sText := TPlayObject(g_HighMCHuman).GetMyInfo;
    end
    else
      sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHMCINFO>', sText);
    exit;
  end;
  if sVariable = '$HIGHSCINFO' then
  begin
    if g_HighSCHuman <> nil then
    begin
      sText := TPlayObject(g_HighSCHuman).GetMyInfo;
    end
    else
      sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHSCINFO>', sText);
    exit;
  end;
  if sVariable = '$HIGHONLINEINFO' then
  begin
    if g_HighOnlineHuman <> nil then
    begin
      sText := TPlayObject(g_HighOnlineHuman).GetMyInfo;
    end
    else
      sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHONLINEINFO>', sText);
    exit;
  end;



//个人信息
  if sVariable = '$USERNAME' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$USERNAME>', PlayObject.m_sCharName);
    exit;
  end;

  if sVariable = '$GENDER' then
  begin
    if PlayObject.m_btGender=1 then s14:='女' else s14:='男';
    sMsg := sub_49ADB8(sMsg, '<$GENDER>',  s14);
    exit;
  end;
  if sVariable = '$JOB' then
  begin
    case PlayObject.m_btJob of
    0 : s14:='战士' ;
    1:  s14:='法师' ;
    2:  s14:='道士' ;
    3:  s14:='妖士' ;
    end;
    sMsg := sub_49ADB8(sMsg, '<$JOB>',  s14);
    exit;
  end;
  if sVariable = '$TASKSTEP' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$TASKSTEP>', inttostr(PlayObject.nTaskStep));
    exit;
  end;
  if sVariable = '$TASKCOUNT' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$TASKCOUNT>', inttostr(PlayObject.nTASKCOUNT));
    exit;
  end;
  if sVariable = '$ENDTASKCOUNT' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$ENDTASKCOUNT>', inttostr(PlayObject.nENDTASKCOUNT));
    exit;
  end;
  if sVariable = '$YSNAME' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$YSNAME>', PlayObject.sYsname);
    exit;
  end;

  if sVariable = '$SFNAME' then
  begin
    if (PlayObject.m_sMasterName <> '') and (not PlayObject.m_boMaster) then
      sMsg := sub_49ADB8(sMsg, '<$SFNAME>', PlayObject.m_sMasterName)
    else
      sMsg := sub_49ADB8(sMsg, '<$SFNAME>', '');

    exit;
  end;
  if sVariable = '$TDNAME' then
  begin
    if (PlayObject.m_sMasterName <> '') and (PlayObject.m_boMaster) then
      sMsg := sub_49ADB8(sMsg, '<$TDNAME>', PlayObject.m_sMasterName)
    else
      sMsg := sub_49ADB8(sMsg, '<$TDNAME>', '');

    exit;
  end;
  if sVariable = '$FQNAME' then
  begin
    if (PlayObject.m_sDearName <> '') then
      sMsg := sub_49ADB8(sMsg, '<$FQNAME>', PlayObject.m_sDearName)
    else
      sMsg := sub_49ADB8(sMsg, '<$FQNAME>', '');

    exit;
  end;
  if sVariable = '$SWNAME' then
  begin
    if (PlayObject.m_LastHiter <> nil) then
      sMsg := sub_49ADB8(sMsg, '<$SWNAME>', PlayObject.m_LastHiter.m_sCharName)
    else
      sMsg := sub_49ADB8(sMsg, '<$SWNAME>', '');

    exit;
  end;

  if sVariable = '$BSNAME' then
  begin
    if (PlayObject.m_LastHiter <> nil) then
      sMsg := sub_49ADB8(sMsg, '<$BSNAME>', PlayObject.m_LastHiter.m_sCharName)
    else
      sMsg := sub_49ADB8(sMsg, '<$BSNAME>', '');

    exit;
  end;

  if sVariable = '$PNEUMALEVEL' then
  begin


    sMsg := sub_49ADB8(sMsg, '<$PNEUMALEVEL>', inttostr(PlayObject.wyslevel));

    exit;
  end;

  if sVariable = '$PNEUMAJOB' then
  begin
    case PlayObject.nysjob of
    0:sText:='战士';
    1:sText:='法师';
    2:sText:='道士';
    end;
    sMsg := sub_49ADB8(sMsg, '<$PNEUMAJOB>', inttojob(PlayObject.nysjob));
    exit;
  end;
  if sVariable = '$PNEUMASEX' then
  begin

    sMsg := sub_49ADB8(sMsg, '<$PNEUMASEX>', inttosex(PlayObject.nyssex));

    exit;
  end;

  if sVariable = '$PNEUMANAME' then
  begin

    if PlayObject.sYsname<>'' then
     sMsg := sub_49ADB8(sMsg, '<$PNEUMANAME>', PlayObject.sYsname)
    else
     sMsg := sub_49ADB8(sMsg, '<$PNEUMANAME>', PlayObject.sYsnameMaster);


    exit;
  end;
 if sVariable = '$PNEUMALEVEL' then
  begin


    sMsg := sub_49ADB8(sMsg, '<$PNEUMALEVEL>', inttostr(PlayObject.wyslevel));

    exit;
  end;

  if sVariable = '$PNEUMAJOB' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$PNEUMAJOB>', inttojob(PlayObject.nysjob));
    exit;
  end;
  if sVariable = '$PNEUMASEX' then
  begin

    sMsg := sub_49ADB8(sMsg, '<$PNEUMASEX>', inttosex(PlayObject.nyssex));

    exit;
  end;
 if sVariable = '$INTROVERTLEVEL' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$INTROVERTLEVEL>', inttostr(PlayObject.wyslevel_1));

    exit;
  end;

  if sVariable = '$INTROVERTJOB' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$INTROVERTJOB>', inttojob(PlayObject.nysjob_1));
    exit;
  end;
  if sVariable = '$INTROVERTSEX' then
  begin

    sMsg := sub_49ADB8(sMsg, '<$INTROVERTSEX>', inttosex(PlayObject.nyssex_1));

    exit;
  end;

  if sVariable = '$BZD0' then
  begin //队长
    if PlayObject.m_GroupOwner <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD0>', TPlayObject(PlayObject.m_GroupOwner).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD0>', '');

    exit;
  end;

  if sVariable = '$BZD1' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD1>', TPlayObject(PlayObject.m_GroupMembers.Objects[0]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD1>', '');
    exit;
  end;

  if sVariable = '$BZD2' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD2>', TPlayObject(PlayObject.m_GroupMembers.Objects[1]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD2>', '');
    exit;
  end;
  if sVariable = '$BZD3' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD3>', TPlayObject(PlayObject.m_GroupMembers.Objects[2]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD3>', '');
    exit;
  end;
  if sVariable = '$BZD4' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD4>', TPlayObject(PlayObject.m_GroupMembers.Objects[3]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD4>', '');
    exit;
  end;
  if sVariable = '$BZD5' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD5>', TPlayObject(PlayObject.m_GroupMembers.Objects[4]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD5>', '');
    exit;
  end;

  if sVariable = '$BZD6' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD6>', TPlayObject(PlayObject.m_GroupMembers.Objects[5]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD6>', '');
    exit;
  end;
  if sVariable = '$BZD7' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD7>', TPlayObject(PlayObject.m_GroupMembers.Objects[6]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD7>', '');
    exit;
  end;
  if sVariable = '$BZD8' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD8>', TPlayObject(PlayObject.m_GroupMembers.Objects[7]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD8>', '');
    exit;
  end;
  if sVariable = '$BZD9' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD9>', TPlayObject(PlayObject.m_GroupMembers.Objects[8]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD9>', '');
    exit;
  end;
  if sVariable = '$BZD10' then
  begin
    if PlayObject.m_GroupMembers <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$BZD10>', TPlayObject(PlayObject.m_GroupMembers.Objects[9]).m_sCharName);
    end
    else
      sMsg := sub_49ADB8(sMsg, '<$BZD10>', '');
    exit;
  end;



  if sVariable = '$X' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$X>', inttostr(PlayObject.m_nCurrX));
    exit;
  end;

  if sVariable = '$Y' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$Y>', inttostr(PlayObject.m_nCurrY));
    exit;
  end;

  if sVariable = '$M' then
  begin
    if PlayObject.m_PEnvir <> nil then
      sMsg := sub_49ADB8(sMsg, '<$M>', PLayobject.m_sMapName);
    exit;
  end;

  if sVariable = '$BUYITEMNUMBER' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BUYITEMNUMBER>', inttostr(PlayObject.m_nBuyItemnum));
    exit;
  end;

  if sVariable = '$GUILDNAME' then
  begin
    if PlayObject.m_MyGuild <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$GUILDNAME>', TGuild(PlayObject.m_MyGuild).sGuildName);
    end
    else
    begin
      sMsg :=  sub_49ADB8(sMsg, '<$GUILDNAME>', '无');
    end;
    exit;
  end;
  if CompareLStr(sVariable, '$GUILD.', Length('$GUILD.')) then
  begin
      s18:=svariable;
      Delete(s18,1,7);
      s18:=UpperCase(s18);
      sText:='没有行会';
      if s18='MEMBERCOUNT' then
      Begin
        if PlayObject.m_MyGuild <> nil then
          sText:=Inttostr(TGuild(PlayObject.m_MyGuild).count);
      End;
      if s18='NAME' then
      Begin
        if PlayObject.m_MyGuild <> nil then
          sText:=TGuild(PlayObject.m_MyGuild).sGuildName;
      End;
      if s18='EXP' then
      Begin
        if PlayObject.m_MyGuild <> nil then
          sText:=Inttostr(TGuild(PlayObject.m_MyGuild).nEXP);
      End;
      if s18='GRADE' then
      Begin
        if PlayObject.m_MyGuild <> nil then
          sText:=Inttostr(TGuild(PlayObject.m_MyGuild).nLevel);
      End;
      if s18='MEMBERMAX' then
      Begin
        if PlayObject.m_MyGuild <> nil then
          sText:=Inttostr(TGuild(PlayObject.m_MyGuild).nMemberMaxCount);
      End;
       sMsg := sub_49ADB8(sMsg,  '<' + sVariable + '>', sText);
  end;
  if sVariable = '$GUILDCOUNT' then
  begin
    if PlayObject.m_MyGuild <> nil then
    begin
      sMsg := sub_49ADB8(sMsg, '<$GUILDCOUNT>',IntToStr(g_GuildManager.GuildList.Count));
    end
    else
    begin
      sMsg := sub_49ADB8(sMsg, '<$GUILDCOUNT>','0');
    end;
    exit;
  end;
  if sVariable = '$RANKNAME' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$RANKNAME>', PlayObject.m_sGuildRankName);
    exit;
  end;

  if sVariable = '$LEVEL' then
  begin
    sText := IntToStr(PlayObject.m_Abil.Level);
    sMsg := sub_49ADB8(sMsg, '<$LEVEL>', sText);
    exit;
  end;

  if sVariable = '$HP' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.HP);
    sMsg := sub_49ADB8(sMsg, '<$HP>', sText);
    exit;
  end;
  if sVariable = '$MAXHP' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.MaxHP);
    sMsg := sub_49ADB8(sMsg, '<$MAXHP>', sText);
    exit;
  end;

  if sVariable = '$MP' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.MP);
    sMsg := sub_49ADB8(sMsg, '<$MP>', sText);
    exit;
  end;
  if sVariable = '$MAXMP' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.MaxMP);
    sMsg := sub_49ADB8(sMsg, '<$MAXMP>', sText);
    exit;
  end;

  if sVariable = '$AC' then
  begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.AC));
    sMsg := sub_49ADB8(sMsg, '<$AC>', sText);
    exit;
  end;
  if sVariable = '$MAXAC' then
  begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.AC));
    sMsg := sub_49ADB8(sMsg, '<$MAXAC>', sText);
    exit;
  end;
  if sVariable = '$MAC' then
  begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.MAC));
    sMsg := sub_49ADB8(sMsg, '<$MAC>', sText);
    exit;
  end;
  if sVariable = '$MAXMAC' then
  begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.MAC));
    sMsg := sub_49ADB8(sMsg, '<$MAXMAC>', sText);
    exit;
  end;

  if sVariable = '$DC' then
  begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.DC));
    sMsg := sub_49ADB8(sMsg, '<$DC>', sText);
    exit;
  end;
  if CompareText(sVariable,'$HIT')=0 then
  begin
    sText := IntToStr(PlayObject.m_btHitPoint);
    sMsg := sub_49ADB8(sMsg, '<'+svariable+'>', sText);
    exit;
  end;
  if CompareText(sVariable,'$NIMBUSPOINT')=0 then
  begin
    sText := IntToStr(PlayObject.m_YSPoint);
    sMsg := sub_49ADB8(sMsg, '<'+svariable+'>', sText);
    exit;
  end;

  if CompareText(sVariable,'$SPD')=0 then
  begin
    sText := IntToStr(PlayObject.m_btSpeedPoint);
    sMsg := sub_49ADB8(sMsg, '<'+svariable+'>', sText);
    exit;
  end;
  if sVariable = '$MAXDC' then
  begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.DC));
    sMsg := sub_49ADB8(sMsg, '<$MAXDC>', sText);
    exit;
  end;

  if sVariable = '$MC' then
  begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.MC));
    sMsg := sub_49ADB8(sMsg, '<$MC>', sText);
    exit;
  end;
  if sVariable = '$MAXMC' then
  begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.MC));
    sMsg := sub_49ADB8(sMsg, '<$MAXMC>', sText);
    exit;
  end;

  if sVariable = '$SC' then
  begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.SC));
    sMsg := sub_49ADB8(sMsg, '<$SC>', sText);
    exit;
  end;
  if sVariable = '$MAXSC' then
  begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.SC));
    sMsg := sub_49ADB8(sMsg, '<$MAXSC>', sText);
    exit;
  end;

  if sVariable = '$EXP' then
  begin
    sText := IntToStr(PlayObject.m_Abil.Exp);
    sMsg := sub_49ADB8(sMsg, '<$EXP>', sText);
    exit;
  end;
  if sVariable = '$MAXEXP' then
  begin
    sText := IntToStr(PlayObject.m_Abil.MaxExp);
    sMsg := sub_49ADB8(sMsg, '<$MAXEXP>', sText);
    exit;
  end;

  if sVariable = '$PKPOINT' then
  begin
    sText := IntToStr(PlayObject.m_nPkPoint);
    sMsg := sub_49ADB8(sMsg, '<$PKPOINT>', sText);
    exit;
  end;
  if sVariable = '$CREDITPOINT' then
  begin
    sText := IntToStr(PlayObject.m_btCreditPoint);
    sMsg := sub_49ADB8(sMsg, '<$CREDITPOINT>', sText);
    exit;
  end;

  if sVariable = '$HW' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.HandWeight);
    sMsg := sub_49ADB8(sMsg, '<$HW>', sText);
    exit;
  end;
  if sVariable = '$MAXHW' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.MaxHandWeight);
    sMsg := sub_49ADB8(sMsg, '<$MAXHW>', sText);
    exit;
  end;

  if sVariable = '$BW' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.Weight);
    sMsg := sub_49ADB8(sMsg, '<$BW>', sText);
    exit;
  end;
  if sVariable = '$MAXBW' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.MaxWeight);
    sMsg := sub_49ADB8(sMsg, '<$MAXBW>', sText);
    exit;
  end;

  if sVariable = '$WW' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.WearWeight);
    sMsg := sub_49ADB8(sMsg, '<$WW>', sText);
    exit;
  end;
  if sVariable = '$MAXWW' then
  begin
    sText := IntToStr(PlayObject.m_WAbil.MaxWearWeight);
    sMsg := sub_49ADB8(sMsg, '<$MAXWW>', sText);
    exit;
  end;

  if sVariable = '$GOLDCOUNT' then
  begin
    sText := IntToStr(PlayObject.m_nGold) + '/' + IntToStr(PlayObject.m_nGoldMax);
    sMsg := sub_49ADB8(sMsg, '<$GOLDCOUNT>', sText);
    exit;
  end;
  if sVariable = '$GAMEGOLD' then
  begin
    sText := IntToStr(PlayObject.m_nGameGold);
    sMsg := sub_49ADB8(sMsg, '<$GAMEGOLD>', sText);
    exit;
  end;
  if sVariable = '$GAMEPOINT' then
  begin
    sText := IntToStr(PlayObject.m_nGamePoint);
    sMsg := sub_49ADB8(sMsg, '<$GAMEPOINT>', sText);
    exit;
  end;
  //极品修炼值
  if sVariable = '$REFINEPOINT' then
  begin
    sText := IntToStr(PlayObject.m_nJpPoint);
    sMsg := sub_49ADB8(sMsg, '<$REFINEPOINT>', sText);
    exit;
  end;
  //武官积分 ATTACHEPOINT
  if sVariable = '$ATTACHEPOINT' then
  begin
    sText := IntToStr(PlayObject.wATTACHEPOINT);
    sMsg := sub_49ADB8(sMsg, '<$ATTACHEPOINT>', sText);
    exit;
  end;
  //武官排名
  if sVariable = '$ATTACHERANK' then
  begin
    sText :='';// IntToStr(PlayObject.wATTACHEPOINT);
    sMsg := sub_49ADB8(sMsg, '<$ATTACHERANK>', sText);
    exit;
  end;
  //ATTACHENAME
  if sVariable = '$ATTACHENAME' then
  begin
    sText :='';// IntToStr(PlayObject.wATTACHEPOINT);
    sMsg := sub_49ADB8(sMsg, '<$ATTACHENAME>', sText);
    exit;
  end;
  //宝石数量   红 绿 蓝
  if CompareLStr(sVariable, '$GEMCOUNT(', Length('$GEMCOUNT(')) then
  Begin
     ArrestStringEx(sVariable, '(', ')', s14);
     n14:=StrToIntDef(s14,0);

    sText := IntToStr(PlayObject.wGEMCOUNT[n14 mod 3]);
    sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
    exit;
  end;
  if sVariable = '$LINGLIPOINT' then
  begin
    sText := IntToStr(PlayObject.m_YSPoint);
    sMsg := sub_49ADB8(sMsg, '<$LINGLIPOINT>', sText);
    exit;
  end;

  if sVariable = '$VITALITYPOINT' then
  begin
    sText := IntToStr(PlayObject.nyuanqi);
    sMsg := sub_49ADB8(sMsg, '<$VITALITYPOINT>', sText);
    exit;
  end;
   if sVariable = '$KILLMONNAME' then
  begin
    sText :=PlayObject.m_sKILLMONNAME;
    sMsg := sub_49ADB8(sMsg, '<$KILLMONNAME>', sText);
    exit;
  end;
   if sVariable = '$KILLHUMNAME' then
  begin
    sText :=PlayObject.m_sKILLHUMNAME;
    sMsg := sub_49ADB8(sMsg, '<$KILLHUMNAME>', sText);
    exit;
  end;
  if sVariable = '$KILLMONMAP' then
  begin
    sText :=PlayObject.m_sKILLMONMAP;
    sMsg := sub_49ADB8(sMsg, '<$KILLMONMAP>', sText);
    exit;
  end;
  if sVariable = '$KILLERNAME' then
  begin
    sText :=PlayObject.m_sKILLERNAME;
    sMsg := sub_49ADB8(sMsg, '<$KILLERNAME>', sText);
    exit;
  end;



  if sVariable = '$KILLHUMMAN' then
  begin
    sText :=PlayObject.m_sLastKillMon;
    sMsg := sub_49ADB8(sMsg, '<$KILLHUMMAN>', sText);
    exit;
  end;
  if sVariable = '$KILLHUMDATE' then
  begin
    sText := PlayObject.m_sLastKillDate;
    sMsg := sub_49ADB8(sMsg, '<$KILLHUMDATE>', sText);
    exit;
  end;
  if sVariable = '$KILLHUMMAP' then
  begin
    sText := PlayObject.m_sLastKillMap ;
    sMsg := sub_49ADB8(sMsg, '<$KILLHUMMAP>', sText);
    exit;
  end;



  if sVariable = '$HUNGER' then
  begin
    sText := IntToStr(PlayObject.GetMyStatus);
    sMsg := sub_49ADB8(sMsg, '<$HUNGER>', sText);
    exit;
  end;
  if sVariable = '$LOGINTIME' then
  begin
    sText := DateTimeToStr(PlayObject.m_dLogonTime);
    sMsg := sub_49ADB8(sMsg, '<$LOGINTIME>', sText);
    exit;
  end;

  if sVariable = '$LOGINLONG' then
  begin
    sText := IntToStr((GetTickCount - PlayObject.m_dwLogonTick) div 60000) + '分钟';
    sMsg := sub_49ADB8(sMsg, '<$LOGINLONG>', sText);
    exit;
  end;
/////
///
///
///
  if CompareLStr(sVariable,'USEITEMMAKEINDEX(',Length('USEITEMMAKEINDEX(')) then
  begin
      s18:=ArrestStringEx(sVariable, '(', ')', s14);
      n14:=Str_ToInt(s14,-1);
      sText:='0';
      if (n14>=0)and(n14<14) then
      Begin
        sText:=Inttostr(PlayObject.m_UseItems[n14].MakeIndex);
      End;
     sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
     exit;
  end;
  if sVariable = '$DRESS_ID' then
  begin
    sText := IntToStr(PlayObject.m_UseItems[U_DRESS].MakeIndex);
    sMsg := sub_49ADB8(sMsg, '<$DRESS_ID>', sText);
    exit;
  end
  else
    if sVariable = '$WEAPON_ID' then
    begin
      sText := IntToStr(PlayObject.m_UseItems[U_WEAPON].MakeIndex);
      sMsg := sub_49ADB8(sMsg, '<$WEAPON_ID>', sText);
      exit;
    end
    else
      if sVariable = '$RIGHTHAND_ID' then
      begin
        sText := IntToStr(PlayObject.m_UseItems[U_RIGHTHAND].MakeIndex);
        sMsg := sub_49ADB8(sMsg, '<$RIGHTHAND_ID>', sText);
        exit;
      end
      else
        if sVariable = '$HELMET_ID' then
        begin
          sText := IntToStr(PlayObject.m_UseItems[U_HELMET].MakeIndex);
          sMsg := sub_49ADB8(sMsg, '<$HELMET_ID>', sText);
          exit;
        end
        else
          if sVariable = '$NECKLACE_ID' then
          begin
            sText := IntToStr(PlayObject.m_UseItems[U_NECKLACE].MakeIndex);
            sMsg := sub_49ADB8(sMsg, '<$NECKLACE_ID>', sText);
            exit;
          end
          else
            if sVariable = '$RINGR_ID' then
            begin
              sText := IntToStr(PlayObject.m_UseItems[U_RINGR].MakeIndex);
              sMsg := sub_49ADB8(sMsg, '<$RINGR_ID>', sText);
              exit;
            end
            else
              if sVariable = '$RINGL_ID' then
              begin
                sText := IntToStr(PlayObject.m_UseItems[U_RINGL].MakeIndex);
                sMsg := sub_49ADB8(sMsg, '<$RINGL_ID>', sText);
                exit;
              end
              else
                if sVariable = '$ARMRINGR_ID' then
                begin
                  sText := IntToStr(PlayObject.m_UseItems[U_ARMRINGR].MakeIndex);
                  sMsg := sub_49ADB8(sMsg, '<$ARMRINGR_ID>', sText);
                  exit;
                end
                else
                  if sVariable = '$ARMRINGL_ID' then
                  begin
                    sText := IntToStr(PlayObject.m_UseItems[U_ARMRINGL].MakeIndex);
                    sMsg := sub_49ADB8(sMsg, '<$ARMRINGL_ID>', sText);
                    exit;
                  end
                  else
                    if sVariable = '$BUJUK_ID' then
                    begin
                      sText := IntToStr(PlayObject.m_UseItems[U_BUJUK].MakeIndex);
                      sMsg := sub_49ADB8(sMsg, '<$BUJUK_ID>', sText);
                      exit;
                    end
                    else
                      if sVariable = '$BELT_ID' then
                      begin
                        sText := IntToStr(PlayObject.m_UseItems[U_BELT].MakeIndex);
                        sMsg := sub_49ADB8(sMsg, '<$BELT_ID>', sText);
                        exit;
                      end
                      else
                        if sVariable = '$BOOTS_ID' then
                        begin
                          sText := IntToStr(PlayObject.m_UseItems[U_BOOTS].MakeIndex);
                          sMsg := sub_49ADB8(sMsg, '<$BOOTS_ID>', sText);
                          exit;
                        end
                        else
                          if sVariable = '$CHARM_ID' then
                          begin
                            sText := IntToStr(PlayObject.m_UseItems[U_CHARM].MakeIndex);
                            sMsg := sub_49ADB8(sMsg, '<$CHARM_ID>', sText);
                            exit;
                          end
                          else
  /////////
                            if sVariable = '$DRESS' then
                            begin
                              sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
                              sMsg := sub_49ADB8(sMsg, '<$DRESS>', sText);
                              exit;
                            end
                            else
                              if sVariable = '$WEAPON' then
                              begin
                                sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
                                sMsg := sub_49ADB8(sMsg, '<$WEAPON>', sText);
                                exit;
                              end
                              else
                                if sVariable = '$RIGHTHAND' then
                                begin
                                  sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RIGHTHAND].wIndex);
                                  sMsg := sub_49ADB8(sMsg, '<$RIGHTHAND>', sText);
                                  exit;
                                end
                                else
                                  if sVariable = '$HELMET' then
                                  begin
                                    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
                                    sMsg := sub_49ADB8(sMsg, '<$HELMET>', sText);
                                    exit;
                                  end
                                  else
                                    if sVariable = '$NECKLACE' then
                                    begin
                                      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
                                      sMsg := sub_49ADB8(sMsg, '<$NECKLACE>', sText);
                                      exit;
                                    end
                                    else
                                      if sVariable = '$RING_R' then
                                      begin
                                        sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
                                        sMsg := sub_49ADB8(sMsg, '<$RING_R>', sText);
                                        exit;
                                      end
                                      else
                                        if sVariable = '$RING_L' then
                                        begin
                                          sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
                                          sMsg := sub_49ADB8(sMsg, '<$RING_L>', sText);
                                          exit;
                                        end
                                        else
                                          if sVariable = '$ARMRING_R' then
                                          begin
                                            sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
                                            sMsg := sub_49ADB8(sMsg, '<$ARMRING_R>', sText);
                                            exit;
                                          end
                                          else
                                            if sVariable = '$ARMRING_L' then
                                            begin
                                              sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
                                              sMsg := sub_49ADB8(sMsg, '<$ARMRING_L>', sText);
                                              exit;
                                            end
                                            else
                                              if sVariable = '$BUJUK' then
                                              begin
                                                sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
                                                sMsg := sub_49ADB8(sMsg, '<$BUJUK>', sText);
                                                exit;
                                              end
                                              else
                                                if sVariable = '$BELT' then
                                                begin
                                                  sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
                                                  sMsg := sub_49ADB8(sMsg, '<$BELT>', sText);
                                                  exit;
                                                end
                                                else
                                                  if sVariable = '$BOOTS' then
                                                  begin
                                                    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
                                                    sMsg := sub_49ADB8(sMsg, '<$BOOTS>', sText);
                                                    exit;
                                                  end
                                                  else
                                                    if sVariable = '$CHARM' then
                                                    begin
                                                      sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
                                                      sMsg := sub_49ADB8(sMsg, '<$CHARM>', sText);
                                                      exit;
                                                    end
                                                    else
                                                      if sVariable = '$IPADDR' then
                                                      begin
                                                        sText := PlayObject.m_sIPaddr;
                                                        sMsg := sub_49ADB8(sMsg, '<$IPADDR>', sText);
                                                        exit;
                                                      end
                                                      else
                                                        if sVariable = '$IPLOCAL' then
                                                        begin
                                                          sText := PlayObject.m_sIPLocal; // GetIPLocal(PlayObject.m_sIPaddr);
                                                          sMsg := sub_49ADB8(sMsg, '<$IPLOCAL>', sText);
                                                          exit;
                                                        end
                                                        else
                                                          if sVariable = '$GUILDBUILDPOINT' then
                                                          begin
                                                            if PlayObject.m_MyGuild = nil then
                                                            begin
                                                              sText := '无';
                                                            end
                                                            else
                                                            begin
                                                              sText := IntToStr(TGuild(PlayObject.m_MyGuild).nBuildPoint);
                                                            end;
                                                            sMsg := sub_49ADB8(sMsg, '<$GUILDBUILDPOINT>', sText);
                                                            exit;
                                                          end
                                                          else
                                                            if sVariable = '$GUILDAURAEPOINT' then
                                                            begin
                                                              if PlayObject.m_MyGuild = nil then
                                                              begin
                                                                sText := '无';
                                                              end
                                                              else
                                                              begin
                                                                sText := IntToStr(TGuild(PlayObject.m_MyGuild).nAurae);
                                                              end;
                                                              sMsg := sub_49ADB8(sMsg, '<$GUILDAURAEPOINT>', sText);
                                                              exit;
                                                            end
                                                            else
                                                              if sVariable = '$GUILDSTABILITYPOINT' then
                                                              begin
                                                                if PlayObject.m_MyGuild = nil then
                                                                begin
                                                                  sText := '无';
                                                                end
                                                                else
                                                                begin
                                                                  sText := IntToStr(TGuild(PlayObject.m_MyGuild).nStability);
                                                                end;
                                                                sMsg := sub_49ADB8(sMsg, '<$GUILDSTABILITYPOINT>', sText);
                                                                exit;
                                                              end;
  if sVariable = '$GUILDFLOURISHPOINT' then
  begin
    if PlayObject.m_MyGuild = nil then
    begin
      sText := '无';
    end
    else
    begin
      sText := IntToStr(TGuild(PlayObject.m_MyGuild).nFlourishing);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDFLOURISHPOINT>', sText);
    exit;
  end;

//其它信息
  if sVariable = '$REQUESTCASTLEWARITEM' then
  begin
    sText := g_Config.sZumaPiece;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLEWARITEM>', sText);
    exit;
  end;
  if sVariable = '$REQUESTCASTLEWARDAY' then
  begin
    sText := g_Config.sZumaPiece;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLEWARDAY>', sText);
    exit;
  end;
  if sVariable = '$REQUESTBUILDGUILDITEM' then
  begin
    sText := g_Config.sWomaHorn;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTBUILDGUILDITEM>', sText);
    exit;
  end;
  if sVariable = '$OWNERGUILD' then
  begin
    if m_Castle <> nil then
    begin
      sText := TUserCastle(m_Castle).m_sOwnGuild;
      if sText = '' then
        sText := '游戏管理';
    end
    else
    begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$OWNERGUILD>', sText);
    exit;
  end; //0049AF32

  if sVariable = '$CASTLENAME' then
  begin
    if m_Castle <> nil then
    begin
      sText := TUserCastle(m_Castle).m_sName;
    end
    else
    begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLENAME>', sText);
    exit;
  end;
  if sVariable = '$LORD' then
  begin
    if m_Castle <> nil then
    begin
      if TUserCastle(m_Castle).m_MasterGuild <> nil then
      begin
        sText := TUserCastle(m_Castle).m_MasterGuild.GetChiefName();
      end
      else
        sText := '管理员';
    end
    else
    begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$LORD>', sText);
    exit;
  end; //0049AF32

  if sVariable = '$GUILDWARFEE' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$GUILDWARFEE>', IntToStr(g_Config.nGuildWarPrice));
    exit;
  end;
  if sVariable = '$BUILDGUILDFEE' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$BUILDGUILDFEE>', IntToStr(g_Config.nBuildGuildPrice));
    exit;
  end;

  if sVariable = '$CASTLEWARDATE' then
  begin
    if m_Castle = nil then
    begin
      m_Castle := g_CastleManager.GetCastle(0);
    end;
    if m_Castle <> nil then
    begin
      if not TUserCastle(m_Castle).m_boUnderWar then
      begin
        sText := TUserCastle(m_Castle).GetWarDate();
        if sText <> '' then
        begin
          sMsg := sub_49ADB8(sMsg, '<$CASTLEWARDATE>', sText);
        end
        else
          sMsg := '暂时没有行会攻城！！！\ \<返回/@main>';
      end
      else
        sMsg := '现正在攻城中！！！\ \<返回/@main>';
    end
    else
    begin
      sText := '????';
    end;
    exit;
  end;

  if sVariable = '$LISTOFWAR' then
  begin
    if m_Castle <> nil then
    begin
      sText := TUserCastle(m_Castle).GetAttackWarList();
    end
    else
    begin
      sText := '????';
    end;
    if sText <> '' then
    begin
      sMsg := sub_49ADB8(sMsg, '<$LISTOFWAR>', sText);
    end
    else
      sMsg := '现在没有行会申请攻城战\ \<返回/@main>';
    exit;
  end;

  if sVariable = '$CASTLECHANGEDATE' then
  begin
    if m_Castle <> nil then
    begin
      sText := DateTimeToStr(TUserCastle(m_Castle).m_ChangeDate);
    end
    else
    begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLECHANGEDATE>', sText);
    exit;
  end;

  if sVariable = '$CASTLEWARLASTDATE' then
  begin
    if m_Castle <> nil then
    begin
      sText := DateTimeToStr(TUserCastle(m_Castle).m_WarDate);
    end
    else
    begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLEWARLASTDATE>', sText);
    exit;
  end;
  if sVariable = '$CASTLEGETDAYS' then
  begin
    if m_Castle <> nil then
    begin
      sText := IntToStr(GetDayCount(Now, TUserCastle(m_Castle).m_ChangeDate));
    end
    else
    begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLEGETDAYS>', sText);
    exit;
  end;

  if sVariable = '$CMD_DATE' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_DATE>', g_GameCommand.DATA.sCmd);
    exit;
  end;
  if sVariable = '$CMD_ALLOWMSG' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ALLOWMSG>', g_GameCommand.ALLOWMSG.sCmd);
    exit;
  end;

  if sVariable = '$CMD_LETSHOUT' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_LETSHOUT>', g_GameCommand.LETSHOUT.sCmd);
    exit;
  end;
  if sVariable = '$CMD_LETTRADE' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_LETTRADE>', g_GameCommand.LETTRADE.sCmd);
    exit;
  end;

  if sVariable = '$CMD_LETGUILD' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_LETGUILD>', g_GameCommand.LETGUILD.sCmd);
    exit;
  end;

  if sVariable = '$CMD_ENDGUILD' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ENDGUILD>', g_GameCommand.ENDGUILD.sCmd);
    exit;
  end;

  if sVariable = '$CMD_BANGUILDCHAT' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_BANGUILDCHAT>', g_GameCommand.BANGUILDCHAT.sCmd);
    exit;
  end;

  if sVariable = '$CMD_AUTHALLY' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_AUTHALLY>', g_GameCommand.AUTHALLY.sCmd);
    exit;
  end;

  if sVariable = '$CMD_AUTH' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_AUTH>', g_GameCommand.AUTH.sCmd);
    exit;
  end;

  if sVariable = '$CMD_AUTHCANCEL' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_AUTHCANCEL>', g_GameCommand.AUTHCANCEL.sCmd);
    exit;
  end;

  if sVariable = '$CMD_USERMOVE' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_USERMOVE>', g_GameCommand.USERMOVE.sCmd);
    exit;
  end;

  if sVariable = '$CMD_SEARCHING' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_SEARCHING>', g_GameCommand.SEARCHING.sCmd);
    exit;
  end;

  if sVariable = '$CMD_ALLOWGROUPCALL' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ALLOWGROUPCALL>', g_GameCommand.ALLOWGROUPCALL.sCmd);
    exit;
  end;

  if sVariable = '$CMD_GROUPRECALLL' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_GROUPRECALLL>', g_GameCommand.GROUPRECALLL.sCmd);
    exit;
  end;

  if sVariable = '$CMD_ATTACKMODE' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ATTACKMODE>', g_GameCommand.ATTACKMODE.sCmd);
    exit;
  end;

  if sVariable = '$CMD_REST' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_REST>', g_GameCommand.REST.sCmd);
    exit;
  end;

  if sVariable = '$CMD_STORAGESETPASSWORD' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGESETPASSWORD>', g_GameCommand.SETPASSWORD.sCmd);
    exit;
  end;
  if sVariable = '$CMD_STORAGECHGPASSWORD' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGECHGPASSWORD>', g_GameCommand.CHGPASSWORD.sCmd);
    exit;
  end;
  if sVariable = '$CMD_STORAGELOCK' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGELOCK>', g_GameCommand.LOCK.sCmd);
    exit;
  end;
  if sVariable = '$CMD_STORAGEUNLOCK' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGEUNLOCK>', g_GameCommand.UNLOCKSTORAGE.sCmd);
    exit;
  end;
  if sVariable = '$CMD_UNLOCK' then
  begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_UNLOCK>', g_GameCommand.UNLOCK.sCmd);
    exit;
  end;
  if CompareLStr(sVariable, '$HUMAN(', Length('$HUMAN(')) then
  begin
    ArrestStringEx(sVariable, '(', ')', s14);
    boFoundVar := False;
    for I := 0 to PlayObject.m_DynamicVarList.Count - 1 do
    begin
      DynamicVar := PlayObject.m_DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, s14) = 0 then
      begin
        case DynamicVar.VarType of
          vInteger:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
              boFoundVar := True;
            end;
          vString:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
              boFoundVar := True;
            end;
        end;
        break;
      end;
    end;
    if not boFoundVar then
      sMsg := '??1';

    exit;
  end;
//
  if CompareLStr(sVariable, '$GROUP(', Length('$GROUP(')) then
  begin
    sText:='';
    if PlayObject.m_GroupOwner = nil then
      sText:=''
    else
    Begin
        ArrestStringEx(sVariable, '(', ')', s14);
        n14:=Str_toint(s14,-1);
        if n14>=0 then
        Begin
           case n14 of
            0:sText:=PlayObject.m_GroupOwner.m_sCharName;
            1..11:
            Begin
              if n14<PlayObject.m_GroupMembers.count then
                sText:=TBaseObject(PlayObject.m_GroupMembers.Objects[n14]).m_sCharName;
            
            End;
           end;

        End;
    End;
     sMsg := sub_49ADB8(sMsg,  '<' + sVariable + '>', sText);
  End;

  if CompareLStr(sVariable, '$GUILD(', Length('$GUILD(')) then
  begin
    if PlayObject.m_MyGuild = nil then
      exit;
    ArrestStringEx(sVariable, '(', ')', s14);
    boFoundVar := False;
    for I := 0 to TGuild(PlayObject.m_MyGuild).m_DynamicVarList.Count - 1 do
    begin
      DynamicVar := TGuild(PlayObject.m_MyGuild).m_DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, s14) = 0 then
      begin
        case DynamicVar.VarType of
          vInteger:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
              boFoundVar := True;
            end;
          vString:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
              boFoundVar := True;
            end;
        end;
        break;
      end;
    end;
    if not boFoundVar then
      sMsg := '??2';
    exit;
  end;
  if CompareLStr(sVariable, '$GLOBAL(', Length('$GLOBAL(')) then
  begin
    ArrestStringEx(sVariable, '(', ')', s14);
    boFoundVar := False;
    for I := 0 to g_DynamicVarList.Count - 1 do
    begin
      DynamicVar := g_DynamicVarList.Items[I];
      if CompareText(DynamicVar.sName, s14) = 0 then
      begin
        case DynamicVar.VarType of
          vInteger:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
              boFoundVar := True;
            end;
          vString:
            begin
              sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
              boFoundVar := True;
            end;
        end;
        break;
      end;
    end;
    if not boFoundVar then
      sMsg := '??3';
    exit;
  end;

  if CompareLStr(sVariable, '$COLLECTPOINT', Length('$COLLECTPOINT')) then
  begin

          sText:=Inttostr((Playobject.m_nGameCode));
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);


  end;

  if CompareLStr(sVariable, '$KILLMONEXPRATETIME', Length('$KILLMONEXPRATETIME')) then
  begin

          sText:=Inttostr((PlayObject.m_dwKillMonExpRateTime));
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);


  end;

  if CompareLStr(sVariable, '$KILLMONEXPRATE', Length('$KILLMONEXPRATE')) then
  begin

          sText:=Inttostr((PlayObject.m_nKillMonExpRate));
          sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);


  end;

  if CompareLStr(sVariable, '$SIGNMAP.', Length('$SIGNMAP.')) then
  begin
      s14:=sVariable;
      Delete(s14,1,9);
      s14:=UpperCase(s14);
      if s14='NAME' then
        sText:=PlayObject.sdieMap;
      if s14='M' then
        sText:=PlayObject.sdieMap;
      if s14='X' then
        sText:=Inttostr(PlayObject.wDieX);
      if s14='Y' then
        sText:=Inttostr(PlayObject.wDieY);
       sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
  End;

   if CompareLStr(sVariable, '$MAGIC(', Length('$MAGIC(')) then
   Begin
     s18:=ArrestStringEx(sVariable, '(', ')', s14);
     n18 := Str_ToInt(s14,-1);
     if Length(s18)<2 then exit;
     if s18[1]<>'.' then exit;
     Delete(s18,1,1);
     s18:=Uppercase(s18);
     sText:='';
     if (n18 <Playobject.m_MagicList.Count )then
     Begin
        UserMagic:= pTUserMagic(Playobject.m_MagicList[n18]);

        if s18='NAME' then
          sText:=UserMagic.MagicInfo.sMagicName;
        if s18='LEVEL' then
          sText:=Inttostr(UserMagic.btLevel);
        if s18='EXP' then
          sText:=Inttostr(UserMagic.nTranPoint);
        sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
     End;
   End;
  if CompareLStr(sVariable, '$PET.', Length('$PET.')) then
  begin
      s18:=svariable;
      Delete(s18,1,5);
      s18:=UpperCase(s18);
      if s18='TYPE' then
      Begin
          sText:=Inttostr(PlayObject.GetpetLevel(PlayObject.M_MonItemMake).montype);


      End;
      if s18='LEVEL' then
      Begin
          sText:=Inttostr(PlayObject.GetpetLevel(PlayObject.M_MonItemMake).MonLevel);
      End;
      if s18='EATTIME' then
        sText:=(PlayObject.GetpetLevel(PlayObject.M_MonItemMake).FendTime);
      if s18='EXP' then
      Begin
       UserItem:=Playobject.GetItems(Playobject.m_monitemmake);
       if UserItem<>nil then
          sText:=Inttostr(makeword(UserItem.btvalue[6], UserItem.btvalue[7]));
      End;
      if s18='MAXEXP' then
      Begin
         stext:='100';
         
      End;
      if s18='VIT' then
      Begin
         sText:=Inttostr(Playobject.M_monstoragehuoli);
      End;
      if s18='RELIVE' then
      Begin
         n18:=(PlayObject.GetpetLevel(PlayObject.M_MonItemMake).ZSD);
         
         sText:=Inttostr(n18);
      End;

      if s18='MAKEINDEX' then
      Begin
        sText:=Inttostr(playobject.M_monitemmake);
      End;

      if s18='MAINPETINDEX' then
      Begin
        sText:=Inttostr(playobject.m_nmainPetId);
      End;
      Useritem:=Playobject.GetItems(playobject.M_monitemmake);
      if Useritem<>nil then
      Begin
          if s18='EVOLUTION' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,1));
          End;
          if s18='APTITUDE' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,2));
          End;
          if s18='HP' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,3));
          End;
          if s18='MP' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,4));
          End;
          if s18='ANTIPOISON' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,5));
          End;
          if s18='MAC1' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,6));
          End;
          if s18='MAC2' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,7));
          End;
          if s18='MAGICNICETY' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,8));
          End;
          if s18='EVADET' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,9));
          End;
          if s18='AC1' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,10));
          End;
          if s18='AC2' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,11));
          End;
          if s18='ANTIMAGIC' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,12));
          End;
          if s18='POISONNICETY' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,13));
          End;
          if s18='SAVVY' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,14));
          End;
          if s18='FELEMENT1' then
          Begin
            n14:=playobject.GetPetAddInfo(UserItem,28);
            case n14 of
             0:stext:='金';
             1:stext:='木';
             2:stext:='土';
             3:stext:='水';
            end;

          End;
          if s18='FELEMENT2' then
          Begin
            n14:=playobject.GetPetAddInfo(UserItem,29);
            case n14 of
             0:stext:='金';
             1:stext:='木';
             2:stext:='土';
             3:stext:='水';
            end;
          End;
          if s18='FELEMENTPOINT1' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,15));
          End;
          if s18='FELEMENTPOINT2' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,16));
          End;
          if s18='PILEEXP' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,17));
          End;
          if s18='MC1' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,19));
          End;
          if s18='MC2' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,20));
          End;
          if s18='SC1' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,21));
          End;
          if s18='SC2' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,22));
          End;
          if s18='DC1' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,23));
          End;
          if s18='DC2' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,24));
          End;
          if s18='NICETY' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,25));
          End;
          if s18='LUCK' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,26));
          End;
          if s18='SPEED' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,27));
          End;
          if s18='EVOLUTION' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,1));
          End;
          if s18='EVOLUTION' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,1));
          End;
          if s18='EVOLUTION' then
          Begin
            sText:=Inttostr(playobject.GetPetAddInfo(UserItem,1));
          End;                                                  
      End ;

       sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
  end;


 //脚本变量
  if CompareLStr(sVariable, '$SUPERBOXITEM(', Length('$SUPERBOXITEM(')) then
  begin
     s18:=ArrestStringEx(sVariable, '(', ')', s14);
     n18 := Str_ToInt(s14,-1);
     if Length(s18)<2 then exit;
     if s18[1]<>'.' then exit;
     Delete(s18,1,1);
     if n18 in [0..7] then
     Begin
        Stditem:=Playobject.m_UpDateItem[n18];
        if Stditem.S.Name='' then exit;
        s18:=UpperCase(s18);
        if s18='NAME' then
          sText:=Stditem.s.Name
        else
          if s18='STDMODE' then
            sText:=Inttostr(Stditem.S.StdMode)
          else
            if s18='SHAPE' then
              sText:=Inttostr(Stditem.S.Shape)
            else
              if s18='WEIGHT' then
                sText:=Inttostr(Stditem.S.Weight)
              else
                if s18='ANICOUNT' then
                  sText:=Inttostr(Stditem.S.AniCount)
                else
                if s18='SOURCE' then
                  sText:=Inttostr(Stditem.S.Source)
                else
                if s18='RESERVED' then
                  sText:=Inttostr(Stditem.S.Reserved)
                else
                if s18='LOOKS' then
                  sText:=Inttostr(Stditem.S.Looks)
                else
                if s18='AC1' then
                  sText:=Inttostr(LoByte(Stditem.S.AC))
                else
                if s18='AC2' then
                  sText:=Inttostr(HiByte(Stditem.S.AC))
                else
                  if s18='MAC2' then
                  sText:=Inttostr(HiByte(Stditem.S.MAC))
                else
                if s18='MAC1' then
                  sText:=Inttostr(LoByte(Stditem.S.MAC))
                else
                  if s18='DC1' then
                  sText:=Inttostr(LoByte(Stditem.S.DC))
                else
                  if s18='DC2' then
                  sText:=Inttostr(HiByte(Stditem.S.DC))
                else
                  if s18='MC1' then
                  sText:=Inttostr(LoByte(Stditem.S.MC))
                else
                  if s18='MC2' then
                  sText:=Inttostr(HiByte(Stditem.S.MC))
                else
                  if s18='SC1' then
                  sText:=Inttostr(LoByte(Stditem.S.SC))
                else
                  if s18='SC2' then
                  sText:=Inttostr(HiByte(Stditem.S.SC))
                else
                if s18='NEED' then
                  sText:=Inttostr(Stditem.S.Need)
                else
                if s18='NEEDLEVEL' then
                  sText:=Inttostr(Stditem.S.NeedLevel)
                else
                if s18='DURA' then
                  sText:=Inttostr(Stditem.Dura)
                else
                if s18='DURAMAX' then
                  sText:=Inttostr(Stditem.DuraMax)
                else
                  if CompareLStr(s18, 'DARKPOINT[', Length('DARKPOINT[')) then
                  Begin
                     ArrestStringEx(s18, '[', ']', s14);
                     n18 := Str_ToInt(s14,-1);
                     case n18 of
                      0: sText:=Inttostr(StdItem.DarkProperty.DMagic);
                      1: sText:=Inttostr(GetLow(StdItem.DarkProperty.DDC));
                      2: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DDC));
                      3: sText:=Inttostr(GetLow(StdItem.DarkProperty.DMC));
                      4: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DMC));
                      5: sText:=Inttostr(GetLow(StdItem.DarkProperty.DSC));
                      6: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DSC));
                      7: sText:=Inttostr(GetLow(StdItem.DarkProperty.DAC));
                      8: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DAC));
                      9: sText:=Inttostr(GetLow(StdItem.DarkProperty.DMAC));
                      10: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DMAC));
                      11: sText:=Inttostr(StdItem.DarkProperty.DNEEDLEVEL);
                    end;
                  end
                  else
                  if CompareLStr(s18, 'EVIL', Length('EVIL')) then
                  Begin


                      if s18='EVILNAME' then
                         sText:=UserItem.AttachMagic.MercenaryName
                      else
                        if s18='EVILJOB' then
                          sText:=Inttostr(UserItem.AttachMagic.MercenaryJob)
                        else
                        if s18='EVILREALM' then
                          sText:=Inttostr(UserItem.AttachMagic.MercenaryState)
                        else
                        if s18='EVILDC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.DC))
                        else
                        if s18='EVILDC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.DC))
                        else
                        if s18='EVILMC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.MC))
                        else
                        if s18='EVILMC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.MC))
                        else
                        if s18='EVILSC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.SC))
                        else
                        if s18='EVILSC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.SC))
                        else
                        if s18='EVILAC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.AC))
                        else
                        if s18='EVILAC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.AC))
                        else
                        if s18='EVILMAC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.MAC))
                        else
                        if s18='EVILMAC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.MAC))
                        else
                        if s18='EVILPOINT' then
                          sText:=Inttostr(UserItem.AttachMagic.ZMValue)
                  end;
     End;
     sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
     Exit;
  end;
 if CompareLStr(sVariable, '$ItemEx.', 8) then
  begin
     s18:=sVariable;//ArrestStringEx(sVariable, '(', ')', s14);
     Delete(s18,1,8);
     s18:= GetValidStr3(s18, s14, ['.']);
     if (s14<>'') and (s14[1]='$') then
     Begin
       sText:='<'+s14+'>';
       GetVariableText(playobject,sText,s14);
       s14:=sText;
     End ;


     n14:=Str_ToInt(s14,-1);
     n24:=Str_ToInt(S18,-1);
     IF (N14=-1)or(n24=-1) then
        exit;
     Useritem:=Playobject.GetItems(n14);
     if Useritem<>nil then
     Begin
       sText:=Inttostr(Playobject.GetItemInfo(Useritem,n24));
     
     End;
     sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
     Exit;
  end;
 if CompareLStr(sVariable, '$CHECKBOXITEM.', 14) then
  begin
     s18:=sVariable;//ArrestStringEx(sVariable, '(', ')', s14);
     Delete(s18,1,14);

     Begin
       UserItem:=playobject.GetItems(PlayObject.m_bocheckboxitem);
       if Useritem=nil  then exit;
        Item := UserEngine.GetStdItem(UserItem.wIndex);
         Stditem.S:=Item^;
         ItemUnit.GetItemAddValue(UserItem, StdItem.s);
        Stditem.DarkProperty:=UserItem.DarkProp;//ItemUnit.GetItemDarkProperty(UserItem.MakeIndex, UserItem.wIndex);
       
        StdItem.MakeIndex:=Useritem.MakeIndex;
        Stditem.Dura:=Useritem.Dura;
        Stditem.DuraMax:=UserItem.DuraMax;
        
        if Stditem.S.Name='' then exit;
        s18:=UpperCase(s18);
        if s18='ITEMEXD' then
          sText:=Inttostr(PlayObject.m_bocheckboxitem)
        else
        if s18='NAME' then
          sText:=Stditem.s.Name
        else
          if s18='STDMODE' then
            sText:=Inttostr(Stditem.S.StdMode)
          else
            if s18='SHAPE' then
              sText:=Inttostr(Stditem.S.Shape)
            else
              if s18='WEIGHT' then
                sText:=Inttostr(Stditem.S.Weight)
              else
                if s18='ANICOUNT' then
                  sText:=Inttostr(Stditem.S.AniCount)
                else
                if s18='SOURCE' then
                  sText:=Inttostr(Stditem.S.Source)
                else
                if s18='RESERVED' then
                  sText:=Inttostr(Stditem.S.Reserved)
                else
                if s18='LOOKS' then
                  sText:=Inttostr(Stditem.S.Looks)
                else
                if s18='AC1' then
                  sText:=Inttostr(LoByte(Stditem.S.AC))
                else
                if s18='AC2' then
                  sText:=Inttostr(HiByte(Stditem.S.AC))
                else
                  if s18='MAC2' then
                  sText:=Inttostr(HiByte(Stditem.S.MAC))
                else
                if s18='MAC1' then
                  sText:=Inttostr(LoByte(Stditem.S.MAC))
                else
                  if s18='DC1' then
                  sText:=Inttostr(LoByte(Stditem.S.DC))
                else
                  if s18='DC2' then
                  sText:=Inttostr(HiByte(Stditem.S.DC))
                else
                  if s18='MC1' then
                  sText:=Inttostr(LoByte(Stditem.S.MC))
                else
                  if s18='MC2' then
                  sText:=Inttostr(HiByte(Stditem.S.MC))
                else
                  if s18='SC1' then
                  sText:=Inttostr(LoByte(Stditem.S.SC))
                else
                  if s18='SC2' then
                  sText:=Inttostr(HiByte(Stditem.S.SC))
                else
                if s18='NEED' then
                  sText:=Inttostr(Stditem.S.Need)
                else
                if s18='NEEDLEVEL' then
                  sText:=Inttostr(Stditem.S.NeedLevel)
                else
                if s18='DURA' then
                  sText:=Inttostr(Stditem.Dura)
                else
                if s18='DURAMAX' then
                  sText:=Inttostr(Stditem.DuraMax)
                else
                  if CompareLStr(s18, 'DARKPOINT[', Length('DARKPOINT[')) then
                  Begin
                     ArrestStringEx(s18, '[', ']', s14);
                     n18 := Str_ToInt(s14,-1);
                     case n18 of
                      0: sText:=Inttostr(StdItem.DarkProperty.DMagic);
                      1: sText:=Inttostr(GetLow(StdItem.DarkProperty.DDC));
                      2: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DDC));
                      3: sText:=Inttostr(GetLow(StdItem.DarkProperty.DMC));
                      4: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DMC));
                      5: sText:=Inttostr(GetLow(StdItem.DarkProperty.DSC));
                      6: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DSC));
                      7: sText:=Inttostr(GetLow(StdItem.DarkProperty.DAC));
                      8: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DAC));
                      9: sText:=Inttostr(GetLow(StdItem.DarkProperty.DMAC));
                      10: sText:=Inttostr(GetHigh(StdItem.DarkProperty.DMAC));
                      11: sText:=Inttostr(StdItem.DarkProperty.DNEEDLEVEL);
                    end;
                  end
                  else
                  if CompareLStr(s18, 'EVIL', Length('EVIL')) then
                  Begin
                      if s18='EVILNAME' then
                         sText:=UserItem.AttachMagic.MercenaryName
                      else
                        if s18='EVILJOB' then
                          sText:=Inttostr(UserItem.AttachMagic.MercenaryJob)
                        else
                        if s18='EVILREALM' then
                          sText:=Inttostr(UserItem.AttachMagic.MercenaryState)
                        else
                        if s18='EVILDC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.DC))
                        else
                        if s18='EVILDC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.DC))
                        else
                        if s18='EVILMC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.MC))
                        else
                        if s18='EVILMC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.MC))
                        else
                        if s18='EVILSC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.SC))
                        else
                        if s18='EVILSC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.SC))
                        else
                        if s18='EVILAC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.AC))
                        else
                        if s18='EVILAC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.AC))
                        else
                        if s18='EVILMAC' then
                          sText:=Inttostr(LoByte(UserItem.AttachMagic.MAC))
                        else
                        if s18='EVILMAC2' then
                          sText:=Inttostr(HiByte(UserItem.AttachMagic.MAC))
                        else
                        if s18='EVILPOINT' then
                          sText:=Inttostr(UserItem.AttachMagic.ZMValue)
                  end;
     End;
     sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
     Exit;
  end;
   //$ITEMMAKEINDE[神威狱金币]
   if CompareLStr(sVariable, '$ITEMMAKEINDEX(', Length('$ITEMMAKEINDEX(')) then
  begin
     s18:=ArrestStringEx(sVariable, '(', ')', s14);
     Useritem:=Playobject.GetItemByName(s14);
     if UserItem<>nil then
       sText:=Inttostr(Useritem.MakeIndex);
     sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
     exit;
  end;
    if CompareLStr(sVariable, '$ITEMCOUNT(', Length('$ITEMCOUNT(')) then
  begin
     s18:=ArrestStringEx(sVariable, '(', ')', s14);
       sText:=Inttostr(PlayObject.GetItemCount(s14) );
     sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
     exit;
  end;
  if CompareLStr(sVariable, '$ITEMINFO', Length('$ITEMINFO')) then
  begin
     s18:=ArrestStringEx(sVariable, '[', ']', s14);
     if (s14<>'') and (s14[1]='$') then
     Begin
       sText:='<'+s14+'>';
       GetVariableText(playobject,sText,s14);
     End
     else
       sText:=s14;
    n18:= Str_ToInt(sText,-1);
    Delete(s18,1,1);
    s18:=Uppercase(s18);
    Useritem:=Playobject.GetItems(n18);

    if Useritem<>nil then
    Begin
        sText:=Playobject.GetItemInfoStr(UserItem,s18);
         sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
    End;

  end;
  if CompareLStr(sVariable, '$NPCAPPR', Length('$NPCAPPR')) then
  Begin
    stext:=Inttostr(m_wAppr);
    sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
  End;
  if CompareLStr(sVariable, '$ITEMEXP[', Length('$ITEMEXP[')) then
  Begin
     s18:=ArrestStringEx(sVariable, '[', ']', s14);
     UserItem:=Playobject.GetItemByName(s14);
     if UserItem<>nil then
     Begin
          IntRec.btValue[3]:=UserItem.btValue[0];
          IntRec.btValue[2]:=UserItem.btValue[1];
          IntRec.btValue[1]:=UserItem.btValue[2];
          IntRec.btValue[0]:=UserItem.btValue[3];
     End
     else
        IntRec.Value:=0;
     sText:=Inttostr(IntRec.Value);
    sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
  End;
  if CompareLStr(sVariable, '$ITEMEXPTIME[', Length('$ITEMEXPTIME[')) then
  Begin
     s18:=ArrestStringEx(sVariable, '[', ']', s14);
     UserItem:=Playobject.GetItemByName(s14);
     if UserItem<>nil then
     Begin

          IntRec.btValue[3] := UserItem.btValue[4];
          IntRec.btValue[2] := UserItem.btValue[5];
          IntRec.btValue[1] := UserItem.btValue[6];
          IntRec.btValue[0] := UserItem.btValue[7];
     End

     else
        IntRec.Value:=0;
     n18:=HoursBetween(Now, EncodeTime(8, 00, 00, 0)+encodedate(2009, 01, 01));
     if Intrec.Value=0 then
       sText:='65536'
     else
       sText:=Inttostr(n18-IntRec.Value);
    sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
  End;
 
if CompareLStr(sVariable, '$SCRIPTPARAM(', Length('$SCRIPTPARAM(')) then
  begin
    s18:=ArrestStringEx(sVariable, '(', ')', s14);
    n18 := Str_ToInt(s14,-1);
    if (n18>0)and(n18<20) then
    Begin
      if (m_sLableParam[n18-1]<>'')and(m_sLableParam[n18-1][1]='<') then
        GetVariableText(playobject,stext,m_sLableParam[n18-1])
      else
        sText:=m_sLableParam[n18-1];
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
    End;
  end;
  if CompareLStr(sVariable, '$HUMANINFO', Length('$HUMANINFO')) then
  begin
    s18:=ArrestStringEx(sVariable, 'O', '.', s14);
    Delete(s14,1,1);
    Delete(s14,Length(s14),1);
    if (S14<>'')and(S14[1]='$') then
    Begin
      s14:='<'+s14+'>';
      sText:=GetLineVariableText(PlayObject,s14);
    End
    else
      stext:=s14;
    baseobject:=UserEngine.GetPlayObject(stext);
    if Baseobject<>nil then
    Begin
      s14:=GetValidStr3(s18,stext,['.']);
      s14:='<'+sText+'>';

      sText:=GetLineVariableText(baseobject,s14);
    End
    else
      sText:=s18+' 不在线';
    sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
  end;
  if CompareLStr(sVariable, '$ADDITIONALABIL(', Length('$ADDITIONALABIL(')) then
  begin
    s18:=ArrestStringEx(sVariable, '(', ')', s14);
    n18 := Str_ToInt(s14,-1);
    sText:=Inttostr(Playobject.GetADDITIONALABIL(n18));
   sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
   Exit;
  end;
  if CompareLStr(sVariable, '$RANDOM(', Length('$RANDOM(')) then
  begin
    s18:=ArrestStringEx(sVariable, '(', ')', s14);
    n18 := Str_ToInt(s14,-1);
    sText:=Inttostr(Random(n18));
   sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
   Exit;
  end;
  if CompareLStr(sVariable,'$ItemExALL.13.神威狱金币',length('$ItemExALL.13.神威狱金币'))then
  Begin
    sText:=Inttostr(PlayObject.GetItemCount('神威狱金币'));
     sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
   Exit;
  End;
  if CompareLStr(sVariable, '$NPCNAME(', Length('$NPCNAME(')) then
   begin
     s18:=ArrestStringEx(sVariable, '(', ')', s14);
      n18 := Str_ToInt(s14,-1);
      sText:=UserEngine.GetMerchantName(n18);
       sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
   Exit;
   end;
  if compareText(sVariable,'$QUESTION')=0 then
  Begin
      sText:='';
      n14:=random(g_QusetionList.Count);
      if g_QusetionList.Count>0 then
      Begin
         pquestion :=pTquestion(g_QusetionList[n14]);
         PlayObject.question:=pQuestion^;
         sText:=PlayObject.question.sQuestion+'\';
      End;
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;
  End;
  if CompareLStr(sVariable, '$ANSWERTEXT(', Length('$ANSWERTEXT(')) then
  begin
    s18:=ArrestStringEx(sVariable, '(', ')', s14);
    n18 := Str_ToInt(s14,-1);
    sText:='';
    if (n18>0) and(n18<=6) then
      sText:=PlayObject.question.sAnswer[n18-1];
    sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;
  end;
  if compareText(sVariable,'$ANSWER')=0 then
  Begin
      sText:='';

       sText:=PlayObject.m_sStoragePwd;
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;
  End;
  if CompareText(sVariable,'$STORAGEPASS')=0 then
  Begin
      sText:='';
      n14:=random(g_QusetionList.Count);
       sText:=PlayObject.question.sAnswerOK;
      sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
      exit;


  End;
  if CompareLstr(sVariable,'$MAPMONCOUNT(',length('$MAPMONCOUNT(')) then
  Begin
    s18:=ArrestStringEx(sVariable, '(', ')', s14);
    if s14<>'' then
    Begin
      if s14[1]='$' then
      Begin
       sText:=s14 ;
       s14:='<' +s14+'>' ;
       GetVariableText(PlayObject, s14, sText);
      end;
      if s18<>'' then
      Begin
        Delete(s18,1,1);
        s18:=Inttostr(UserEngine.GetMapMonster(g_MapManager.FindMap(s14),nil,str_toint(s18,0)));


         sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', s18);
      End;
    End;
  
  End;
  if CompareLStr(sVariable, '$PARAM(', Length('$PARAM(')) then
  begin
    s18:=ArrestStringEx(sVariable, '(', ')', s14);
    n18 := Str_ToInt(s14,-1);
    case n18 of


 //    8: stext:=Playobject.m_sEatName;
  //   9: stext:=Inttostr(Playobject.m_neatLevel);
  //   10:sText:=Inttostr(PlayObject.m_nGiveItemIdx);

     0..119:
        sText:=Playobject.m_sParam[n18];
    end;
   sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
   Exit;

  end;
//  $ADDLXBH   灵犀宝盒格子数
 if CompareLStr(sVariable, '$ADDLXBH', Length('$ADDLXBH')) then
  begin
       sText:=Inttostr(PlayObject.btLXBHCount);
       sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', sText);
       Exit;

  end;
  if CompareLStr(sVariable, '$STR(', Length('$STR(')) then
  begin
    ArrestStringEx(sVariable, '(', ')', s14);
    GetValValue(PlayObject,s14,n18,s18);
     sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', s18);
  end;
end;
  procedure TNormNpc.setValValue(playobject:TPlayObject; sVarName:string;nValue:Integer;sValue:string );
  var
     n14 : Integer;
  begin
            n14 := GetValNameNo(sVarName);

            if n14 >= 0 then
            begin
              case n14 of //
                0..9:
                  begin
                    PlayObject.m_nVal[n14] := nValue;
                  end;
                100..199:
                  begin
                    g_Config.GlobalVal[n14 - 100] := nValue;
                  end;
                200..209:
                  begin
                    PlayObject.m_DyVal[n14 - 200] :=nValue;
                  end;
                300..399:
                  begin
                    PlayObject.m_nMval[n14 - 300] :=nValue;
                  end;
                400..499:
                  begin
                    g_Config.GlobaDyMval[n14 - 400] :=nValue;
                  end;
                500..599:
                  begin
                   // QuestActionInfo.sParam2 := AnsiReplaceText(QuestActionInfo.sParam2, '[]', ' ');
                    PlayObject.m_DySval[n14 - 500] := sValue;
                  end;
                  3000..3299: g_Config.GlobalstrA[n14-3000]:= sValue;
                  5100..5199:


                    Begin
                       PlayObject.m_DySval[n14 - 5000] := sValue;
                    End;

                600..699:
                  begin
                  //  QuestActionInfo.sParam2 := AnsiReplaceText(QuestActionInfo.sParam2, '[]', ' ');
                    g_Config.Globalstr[n14 - 600] := sValue;
                  end;



              end;
            end;

  end;
 function  TNormNpc.GetValValue(playobject:TPlayObject;var sVarName:string;var nValue:Integer;var sValue:string ):Integer;
  var
     n14 : Integer;
  begin
            n14 := GetValNameNo(sVarName);
          Result:=0;
            if n14 >= 0 then
            begin
              case n14 of //
                0..9:
                  begin
                    nValue := PlayObject.m_nVal[n14];
                    sValue:=IntToStr(nValue);
                  end;
                100..199:
                  begin
                    nValue := g_Config.GlobalVal[n14 - 100];
                    sValue:=IntToStr(nValue);
                  end;
                200..209:
                  begin
                    nValue := PlayObject.m_DyVal[n14 - 200];
                    sValue:=IntToStr(nValue);
                  end;
                300..399:
                  begin
                    nValue := PlayObject.m_nMval[n14 - 300];
                    sValue:=IntToStr(nValue);
                  end;
                400..499:
                  begin
                    nValue := g_Config.GlobaDyMval[n14 - 400];
                    sValue:=IntToStr(nValue);
                  end;
                500..599:
                  begin
                   // QuestActionInfo.sParam2 := AnsiReplaceText(QuestActionInfo.sParam2, '[]', ' ');
                    sValue := PlayObject.m_DySval[n14 - 500];
                     Result:=1;
                  end;
                3000..3299:
                  begin
                  //  QuestActionInfo.sParam2 := AnsiReplaceText(QuestActionInfo.sParam2, '[]', ' ');
                    sValue := g_Config.GlobalstrA[n14 - 3000];
                      Result:=1;
                  end;
                  5100..5199:
                  Begin
                    sValue := PlayObject.m_DySval[n14 - 5000];
                      Result:=1;
                  End;
                600..699:
                  begin
                  //  QuestActionInfo.sParam2 := AnsiReplaceText(QuestActionInfo.sParam2, '[]', ' ');
                    sValue := g_Config.Globalstr[n14 - 600];
                      Result:=1;
                  end;
                 1000:
                 begin
                    sValue:=sVarName;
                    nValue:=Str_ToInt(sValue,0);
                 end;
                 2000:
                 begin
                    sValue:=sVarName;
                    Result:=1;
                 end;

              end;
            end;

  end;


function TNormNpc.GotoLable(PlayObject: TPlayObject; sLabel: string; boExtJmp: Boolean):Boolean; //0049E584
var
  nCheckcode: integer;
  I, II, III: Integer;
  List1C: TStringList;
  bo11: Boolean;
  n18: Integer;
  n20,nx,ny: Integer;
  sSendMsg: string;
  Script: pTScript;
  Script3C: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  UserItem: pTUserItem;
  sC,s1,sx,sy,srand: string;

  SSS:sTRING;
  OldPlayObject:TPlayObject;
  function CheckQuestStatus(ScriptInfo: pTScript): Boolean; //0049BA00
  var
    I: Integer;
  begin
    Result := True;
    if not ScriptInfo.boQuest then
      exit;
    I := 0;
    while (True) do
    begin
      if (ScriptInfo.QuestInfo[I].nRandRage > 0) and (Random(ScriptInfo.QuestInfo[I].nRandRage) <> 0) then
      begin
        Result := False;
        break;
      end;
      if PlayObject.GetQuestFalgStatus(ScriptInfo.QuestInfo[I].wFlag) <> ScriptInfo.QuestInfo[I].btValue then
      begin
        Result := False;
        break;
      end;
      Inc(I);
      if I >= 10 then
        break;
    end; // while
  end;
  function CheckItemW(sItemType: string; nParam: Integer): pTUserItem; //0049BA7C
  var
    nCount: Integer;
  begin
    Result := nil;
    if CompareLStr(sItemType, '[NECKLACE]', 4) then
    begin
      if PlayObject.m_UseItems[U_NECKLACE].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_NECKLACE];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[RING]', 4) then
    begin
      if PlayObject.m_UseItems[U_RINGL].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_RINGL];
      end;
      if PlayObject.m_UseItems[U_RINGR].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_RINGR];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[ARMRING]', 4) then
    begin
      if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_ARMRINGL];
      end;
      if PlayObject.m_UseItems[U_ARMRINGR].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_ARMRINGR];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[WEAPON]', 4) then
    begin
      if PlayObject.m_UseItems[U_WEAPON].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_WEAPON];
      end;
      exit;
    end;
    if CompareLStr(sItemType, '[HELMET]', 4) then
    begin
      if PlayObject.m_UseItems[U_HELMET].wIndex > 0 then
      begin
        Result := @PlayObject.m_UseItems[U_HELMET];
      end;
      exit;
    end;
    Result := PlayObject.sub_4C4CD4(sItemType, nCount);
    if nCount < nParam then
      Result := nil;
  end;
  function CheckStringList(sHumName, sListFileName: string): Boolean; //0049B47C
  var
    I: Integer;
    LoadList: TStringList;
  begin
    Result := False;
    sListFileName := g_Config.sEnvirDir + sListFileName;
    if FileExists(sListFileName) then
    begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
      for I := 0 to LoadList.Count - 1 do
      begin
        if CompareText(Trim(LoadList.Strings[I]), sHumName) = 0 then
        begin
          Result := True;
          break;
        end;
      end;
      LoadList.Free;
    end
    else
    begin
      MainOutMessage('file not found => ' + sListFileName);
    end;
  end;
  function QuestCheckCondition(ConditionList: TList): Boolean; //0049BCA8
  var
    I: Integer;

       pQuestConditionInfo: pTQuestConditionInfo;
    QuestConditionInfo: pTQuestConditionInfo;
  //   tempQuestConditionInfo:TQuestConditionInfo;
    n10, n14, n18, n1C, nMaxDura, nDura: Integer;
    Hour, Min, Sec, MSec: Word;
    Envir: TEnvirnoment;
    StdItem: pTStdItem;
    s1, s2: string;
    hum: TplayObject;
  begin
    Result := True;
     OldPlayObject:=PlayObject;
    for I := 0 to ConditionList.Count - 1 do
    begin
       PlayObject := OldPlayObject;
       pQuestConditionInfo := ConditionList.Items[i];
    //  fillchar(tempQuestConditionInfo,sizeof(tQuestConditionInfo),#0);
    //  tempQuestConditionInfo:= pQuestConditionInfo^  ;
    //  QuestConditionInfo:=@tempQuestConditionInfo;
      new(QuestConditionInfo);
      QuestConditionInfo^ := pQuestConditionInfo^;

    //  QuestConditionInfo^ := pQuestConditionInfo^;
      ////
          //先处理 脚本参数
      if (QuestConditionInfo.sParam1 <> '') and (QuestConditionInfo.sParam1[1] = '$') then
      begin
        s1 := QuestConditionInfo.sParam1;
        QuestConditionInfo.sParam1 := '<' + QuestConditionInfo.sParam1 + '>';
        GetVariableText(PlayObject, QuestConditionInfo.sParam1, s1);
      end;

      if (QuestConditionInfo.sParam2 <> '') and (QuestConditionInfo.sParam2[1] = '$') then
      begin
        s1 := QuestConditionInfo.sParam2;
        QuestConditionInfo.sParam2 := '<' + QuestConditionInfo.sParam2 + '>';
        GetVariableText(PlayObject, QuestConditionInfo.sParam2, s1);
      end;
      if (QuestConditionInfo.sParam3 <> '') and (QuestConditionInfo.sParam3[1] = '$') then
      begin
        s1 := QuestConditionInfo.sParam3;
        QuestConditionInfo.sParam3 := '<' + QuestConditionInfo.sParam3 + '>';
        GetVariableText(PlayObject, QuestConditionInfo.sParam3, s1);
      end;
      if (QuestConditionInfo.sParam4 <> '') and (QuestConditionInfo.sParam4[1] = '$') then
      begin
        s1 := QuestConditionInfo.sParam4;
        QuestConditionInfo.sParam4 := '<' + QuestConditionInfo.sParam4 + '>';
        GetVariableText(PlayObject, QuestConditionInfo.sParam4, s1);
      end;
      if (QuestConditionInfo.sParam5 <> '') and (QuestConditionInfo.sParam5[1] = '$') then
      begin
        s1 := QuestConditionInfo.sParam5;
        QuestConditionInfo.sParam5 := '<' + QuestConditionInfo.sParam5 + '>';
        GetVariableText(PlayObject, QuestConditionInfo.sParam5, s1);
      end;
      if (QuestConditionInfo.sParam6 <> '') and (QuestConditionInfo.sParam6[1] = '$') then
      begin
        s1 := QuestConditionInfo.sParam6;
        QuestConditionInfo.sParam6 := '<' + QuestConditionInfo.sParam6 + '>';
        GetVariableText(PlayObject, QuestConditionInfo.sParam6, s1);
      end;

      if IsStringNumber(QuestConditionInfo.sParam1) then
        QuestConditionInfo.nParam1 := Str_ToInt(QuestConditionInfo.sParam1, 0);
      if IsStringNumber(QuestConditionInfo.sParam2) then
        QuestConditionInfo.nParam2 := Str_ToInt(QuestConditionInfo.sParam2, 1);
      if IsStringNumber(QuestConditionInfo.sParam3) then
        QuestConditionInfo.nParam3 := Str_ToInt(QuestConditionInfo.sParam3, 1);
      if IsStringNumber(QuestConditionInfo.sParam4) then
        QuestConditionInfo.nParam4 := Str_ToInt(QuestConditionInfo.sParam4, 0);
      if IsStringNumber(QuestConditionInfo.sParam5) then
        QuestConditionInfo.nParam5 := Str_ToInt(QuestConditionInfo.sParam5, 0);
      if IsStringNumber(QuestConditionInfo.sParam6) then
        QuestConditionInfo.nParam6 := Str_ToInt(QuestConditionInfo.sParam6, 0);

      if QuestConditionInfo.sBaseObject<>'' then
      begin
        if QuestConditionInfo.sBaseObject[1]='$' then
        begin
          s1 := QuestConditionInfo.sBaseObject;
          QuestConditionInfo.sBaseObject := '<' + QuestConditionInfo.sBaseObject + '>';
          GetVariableText(PlayObject, QuestConditionInfo.sBaseObject, s1);
          QuestConditionInfo.sBaseObject:=GetLineVariableText(PlayObject,QuestConditionInfo.sBaseObject);
          if QuestConditionInfo.sBaseObject<>'' then
          begin
            PlayObject:=UserEngine.GetPlayObject(QuestConditionInfo.sBaseObject);
            if PlayObject=nil then
            Begin
              PlayObject:=OldPlayObject;
              Result:=False;
              Continue;
            End;
          end;
        end;
      end;


     ///////////
   try
   TRY
      ////
      case QuestConditionInfo.nCmdCode of //
        nCHECK:
          begin
            ArrestStringEx(QuestConditionInfo.sParam1,'[',']',s1);
            if s1='' then s1:=QuestConditionInfo.sParam1;
            n14 := Str_ToInt(s1, 0);
            n18 := Str_ToInt(QuestConditionInfo.sParam2, 0);
            n10 := PlayObject.GetQuestFalgStatus(n14);
            Result:=n10=n18;
          end;
        nRANDOM:
          begin
            if Random(QuestConditionInfo.nParam1) <> 0 then
              Result := False;
          end;
        nGENDER:
          begin
            if CompareText(QuestConditionInfo.sParam1, sMAN) = 0 then
            begin
              if PlayObject.m_btGender <> 0 then
                Result := False;
            end
            else
            begin
              if PlayObject.m_btGender <> 1 then
                Result := False;
            end;
          end;
        nDAYTIME:
          begin
            if CompareText(QuestConditionInfo.sParam1, sSUNRAISE) = 0 then
            begin
              if g_nGameTime <> 0 then
                Result := False;
            end;
            if CompareText(QuestConditionInfo.sParam1, sDAY) = 0 then
            begin
              if g_nGameTime <> 1 then
                Result := False;
            end;
            if CompareText(QuestConditionInfo.sParam1, sSUNSET) = 0 then
            begin
              if g_nGameTime <> 2 then
                Result := False;
            end;
            if CompareText(QuestConditionInfo.sParam1, sNIGHT) = 0 then
            begin
              if g_nGameTime <> 3 then
                Result := False;
            end;
          end;
        nCHECKOPEN:
          begin
            n14 := Str_ToInt(QuestConditionInfo.sParam1, 0);
            n18 := Str_ToInt(QuestConditionInfo.sParam2, 0);
            n10 := PlayObject.GetQuestUnitOpenStatus(n14);
            if n10 = 0 then
            begin
              if n18 <> 0 then
                Result := False;
            end
            else
            begin
              if n18 = 0 then
                Result := False;
            end;
          end;
        nCHECKUNIT:
          begin
            n14 := Str_ToInt(QuestConditionInfo.sParam1, 0);
            n18 := Str_ToInt(QuestConditionInfo.sParam2, 0);
            n10 := PlayObject.GetQuestUnitStatus(n14);
            if n10 = 0 then
            begin
              if n18 <> 0 then
                Result := False;
            end
            else
            begin
              if n18 = 0 then
                Result := False;
            end;
          end;
        nCHECKLEVEL:
          if PlayObject.m_Abil.Level < QuestConditionInfo.nParam1 then
            Result := False;
        nCHECKJOB:
          begin
            if CompareLStr(QuestConditionInfo.sParam1, sWARRIOR, 3) then
            begin
              if PlayObject.m_btJob <> 0 then
                Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sWIZARD, 3) then
            begin
              if PlayObject.m_btJob <> 1 then
                Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sTAOS, 3) then
            begin
              if PlayObject.m_btJob <> 2 then
                Result := False;
            end;
          end;
        nCHECKBBCOUNT:
          if PlayObject.m_SlaveList.Count < QuestConditionInfo.nParam1 then
            Result := False;
        nCHECKCREDITPOINT: ;
        nCHECKITEM:
          begin
            if QuestConditionInfo.sParam3 = '' then
            begin
              UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
              if n1C < QuestConditionInfo.nParam2 then
                Result := False;
            end
            else
            begin
              hum := nil;
              hum := UserEngine.GetPlayObjectEx(QuestConditionInfo.sParam3);
              if hum <> nil then
              begin
                UserItem := hum.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
                if n1C < QuestConditionInfo.nParam2 then
                  Result := False;
              end;
            end; //3-''
          end;
        nCHECKITEMx:
          begin
            Result := PlayObject.CheckItemboxr(QuestConditionInfo.sParam1, QuestConditionInfo.sParam2);

          end;

        ncheckclb:
          begin
            if PlayObject.M_monitemmake <> 0 then
              result := true
            else
              result := false;
          end;

        nCHECKBT:
          begin
            if PlayObject.m_boOnSellItem then
              result := true
            else
              result := false;
          end;

        nCHECKONLINE:
          begin
            if UserEngine.GetPlayObject(QuestConditionInfo.sParam1) = nil then
              result := false;
          end;

        nCHECKITEMW:
          begin
            UserItem := CheckItemW(QuestConditionInfo.sParam1, QuestConditionInfo.nParam2);
            if UserItem = nil then
              Result := False;
          end;
        nCHECKGOLD:
          if PlayObject.m_nGold < QuestConditionInfo.nParam1 then
            Result := False;
        nISTAKEITEM:
          if PlayObject.m_sParam[30] <> QuestConditionInfo.sParam1 then
            Result := False;
        nCHECKDURA:
          begin
            UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
            if ROUND(nDura / 1000) < QuestConditionInfo.nParam2 then
              Result := False;
          end;
        nCHECKDURAEVA:
          begin
            UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
            if n1C > 0 then
            begin
              if ROUND(nMaxDura / n1C / 1000) < QuestConditionInfo.nParam2 then
                Result := False;
            end
            else
              Result := False;
          end;
        nDAYOFWEEK:
          begin
            if CompareLStr(QuestConditionInfo.sParam1, sSUN, Length(sSUN)) then
            begin
              if DayOfWeek(Now) <> 1 then
                Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sMON, Length(sMON)) then
            begin
              if DayOfWeek(Now) <> 2 then
                Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sTUE, Length(sTUE)) then
            begin
              if DayOfWeek(Now) <> 3 then
                Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sWED, Length(sWED)) then
            begin
              if DayOfWeek(Now) <> 4 then
                Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sTHU, Length(sTHU)) then
            begin
              if DayOfWeek(Now) <> 5 then
                Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sFRI, Length(sFRI)) then
            begin
              if DayOfWeek(Now) <> 6 then
                Result := False;
            end;
            if CompareLStr(QuestConditionInfo.sParam1, sSAT, Length(sSAT)) then
            begin
              if DayOfWeek(Now) <> 7 then
                Result := False;
            end;
          end;
        nHOUR:
          begin
            if (QuestConditionInfo.nParam1 <> 0) and (QuestConditionInfo.nParam2 = 0) then
              QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
            DecodeTime(Time, Hour, Min, Sec, MSec);
            if (Hour < QuestConditionInfo.nParam1) or (Hour > QuestConditionInfo.nParam2) then
              Result := False;
          end;
        nMIN:
          begin
            if (QuestConditionInfo.nParam1 <> 0) and (QuestConditionInfo.nParam2 = 0) then
              QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
            DecodeTime(Time, Hour, Min, Sec, MSec);
            if (Min < QuestConditionInfo.nParam1) or (Min > QuestConditionInfo.nParam2) then
              Result := False;
          end;
        nCHECKPKPOINT:
          if PlayObject.PKLevel < QuestConditionInfo.nParam1 then
            Result := False;

        nCHECKLUCKYPOINT:
          if PlayObject.m_nBodyLuckLevel < QuestConditionInfo.nParam1 then
            Result := False;
        nCHECKMONMAP:
          begin
            Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);
            if Envir <> nil then
            begin
              if UserEngine.GetMapMonster(Envir, nil) < QuestConditionInfo.nParam2 then
                Result := False;
            end;
          end;
        nCHECKMON:
          begin
            Envir := PlayObject.m_PEnvir;
            if Envir <> nil then
            begin
              if UserEngine.GetMapMonsterx(Envir, nil) < QuestConditionInfo.nParam1 then
                Result := False;
            end;

          end;
        nCHECKMONAREA: ;
        nCHECKHUM:
          begin //0049C4CB
            if UserEngine.GetMapHuman(QuestConditionInfo.sParam1) < QuestConditionInfo.nParam2 then
              Result := False;
          end;

        nCHECKBAGGAGE:
          begin
            if PlayObject.IsEnoughBag then
            begin
              if QuestConditionInfo.sParam1 <> '' then
              begin
                Result := False;
                StdItem := UserEngine.GetStdItem(QuestConditionInfo.sParam1);
                if StdItem <> nil then
                begin
                  if PlayObject.IsAddWeightAvailable(StdItem.Weight) then
                    Result := True;
                end;
              end;
            end
            else
              Result := False;
          end;
        nCHECKVARLIST:
          if not CheckStringList(QuestConditionInfo.sParam1, m_sPath + QuestConditionInfo.sParam2) then
            Result := False;
        nCHECKNAMELIST:
          if not CheckStringList(PlayObject.m_sCharName, m_sPath + QuestConditionInfo.sParam1) then
            Result := False;
        nCHECKACCOUNTLIST:
          if not CheckStringList(PlayObject.m_sUserID, m_sPath + QuestConditionInfo.sParam1) then
            Result := False;
        nCHECKIPLIST:
          if not CheckStringList(PlayObject.m_sIPaddr, m_sPath + QuestConditionInfo.sParam1) then
            Result := False;
        nEQUAL:
          begin //0049C5AC
           n10:=GetValValue(PlayObject,QuestConditionInfo.sParam1,n14,s1);
           if n10=0 then
              Result:=n14=QuestConditionInfo.nParam2
           else
              Result:=s1=QuestConditionInfo.sParam2;
           
          end;
        nLARGE:
          begin //0049C658
           n10:=GetValValue(PlayObject,QuestConditionInfo.sParam1,n14,s1);
           if n10=0 then
              Result:=n14>=QuestConditionInfo.nParam2
           else
           begin

                      Result := False;
           end;
          end;

        nSMALL:
          begin //0049C704
                     n10:=GetValValue(PlayObject,QuestConditionInfo.sParam1,n14,s1);
           if n10=0 then
              Result:=n14<QuestConditionInfo.nParam2
           else
           begin
             s2 := uppercase(QuestConditionInfo.sParam2);
             s1:=UpperCase(s1);
                    if pos(s2, s1) > 0 then
                      Result := False;
           end;
          end;
        nSC_ISSYSOP:
          if not (PlayObject.m_btPermission >= 4) then
            Result := False;
        nSC_ISADMIN:
          if not (PlayObject.m_btPermission >= 6) then
            Result := False;
        nSC_CHECKGROUPCOUNT:
          if not ConditionOfCheckGroupCount(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKPOSEDIR:
          if not ConditionOfCheckPoseDir(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKPOSELEVEL:
          if not ConditionOfCheckPoseLevel(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKPOSEGENDER:
          if not ConditionOfCheckPoseGender(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKLEVELEX:
          if not ConditionOfCheckLevelEx(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKBONUSPOINT:
          if not ConditionOfCheckBonusPoint(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKMARRY:
          if not ConditionOfCheckMarry(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKPOSEMARRY:
          if not ConditionOfCheckPoseMarry(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKMARRYCOUNT:
          if not ConditionOfCheckMarryCount(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKMASTER:
          if not ConditionOfCheckMaster(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_HAVEMASTER:
          if not ConditionOfHaveMaster(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKPOSEMASTER:
          if not ConditionOfCheckPoseMaster(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_POSEHAVEMASTER:
          if not ConditionOfPoseHaveMaster(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKISMASTER:
          if not ConditionOfCheckIsMaster(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_HASGUILD:
          if not ConditionOfCheckHaveGuild(PlayObject, QuestConditionInfo) then
            Result := False;

        nSC_ISGUILDMASTER:
          if not ConditionOfCheckIsGuildMaster(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKCASTLEMASTER:
          if not ConditionOfCheckIsCastleMaster(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_ISCASTLEGUILD:
          if not ConditionOfCheckIsCastleaGuild(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_ISATTACKGUILD:
          if not ConditionOfCheckIsAttackGuild(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_ISDEFENSEGUILD:
          if not ConditionOfCheckIsDefenseGuild(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKCASTLEDOOR:
          if not ConditionOfCheckCastleDoorStatus(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_ISATTACKALLYGUILD:
          if not ConditionOfCheckIsAttackAllyGuild(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_ISDEFENSEALLYGUILD:
          if not ConditionOfCheckIsDefenseAllyGuild(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKPOSEISMASTER:
          if not ConditionOfCheckPoseIsMaster(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKNAMEIPLIST:
          if not ConditionOfCheckNameIPList(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKACCOUNTIPLIST:
          if not ConditionOfCheckAccountIPList(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKSLAVECOUNT:
          if not ConditionOfCheckSlaveCount(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKSLAVENAME:
          if not ConditionOfCHECKSLAVENAME(PlayObject, QuestConditionInfo) then
            Result := False;

        nSC_ISNEWHUMAN:
          if not PlayObject.m_boNewHuman then
            Result := False;
        nSC_CHECKMEMBERTYPE:
          if not ConditionOfCheckMemberType(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKMEMBERLEVEL:
          if not ConditionOfCheckMemBerLevel(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKGAMEGOLD:
          if not ConditionOfCheckGameGold(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKGAMEPOINT:
          if not ConditionOfCheckGamePoint(PlayObject, QuestConditionInfo) then
            Result := False;
        nCheckCollectPoint:
        begin
           if QuestConditionInfo.sParam1='=' then
             result:=PlayObject.m_ngameCode=QuestConditionInfo.nParam2;
           if QuestConditionInfo.sParam1='>' then
             result:=PlayObject.m_ngameCode>QuestConditionInfo.nParam2;
           if QuestConditionInfo.sParam1='<' then
             result:=PlayObject.m_ngameCode<QuestConditionInfo.nParam2;
        end;
        nCheckUserGap:
           if not ConditionOfCheckUserGap(PlayObject, QuestConditionInfo) then
              Result := False;
        nCHECKJPPOINT:
          if not ConditionOfCHECKJPPOINT(PlayObject, QuestConditionInfo) then
            Result := False;
        nCHECKYSPOINT:
          if not ConditionOfCHECKYSPOINT(PlayObject, QuestConditionInfo) then
            Result := False;
        nTrue: Result := True;
        nSC_CHECKNAMELISTPOSITION:
          if not ConditionOfCheckNameListPostion(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKYEAR:
          if not ConditionOfCHECKYEAR(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKMONTH:
          if not ConditionOfCHECKMONTH(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKDAY:
          if not ConditionOfCHECKDAY(PlayObject, QuestConditionInfo) then
            Result := False;
        nCHECKMAPNAME:
          if not ConditionOfCHECKMAPNAME(PlayObject, QuestConditionInfo) then
            Result := False;
        //nSC_CHECKGUILDLIST:     if not ConditionOfCheckGuildList(PlayObject,QuestConditionInfo) then Result:=False;
        nSC_CHECKGUILDLIST:
          begin
            if PlayObject.m_MyGuild <> nil then
            begin
              if not CheckStringList(TGuild(PlayObject.m_MyGuild).sGuildName, m_sPath + QuestConditionInfo.sParam1) then
                Result := False;
            end
            else
              Result := False;
          end;
        nSC_CHECKRENEWLEVEL:
          if not ConditionOfCheckReNewLevel(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKSLAVELEVEL:
          if not ConditionOfCheckSlaveLevel(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKCREDITPOINT:
          if not ConditionOfCheckCreditPoint(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKOFGUILD:
          if not ConditionOfCheckOfGuild(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKPAYMENT:
          if not ConditionOfCheckPayMent(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKUSEITEM:
          if not ConditionOfCheckUseItem(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKBAGSIZE:
          if not ConditionOfCheckBagSize(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKLISTCOUNT:
          if not ConditionOfCheckListCount(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKDC:
          if not ConditionOfCheckDC(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKMC:
          if not ConditionOfCheckMC(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKSC:
          if not ConditionOfCheckSC(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKHP:
          if not ConditionOfCheckHP(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKMP:
          if not ConditionOfCheckMP(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKITEMTYPE:
          if not ConditionOfCheckItemType(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKEXP:
          if not ConditionOfCheckExp(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKCASTLEGOLD:
          if not ConditionOfCheckCastleGold(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_PASSWORDERRORCOUNT:
          if not ConditionOfCheckPasswordErrorCount(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_ISLOCKPASSWORD:
          if not ConditionOfIsLockPassword(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_ISLOCKSTORAGE:
          if not ConditionOfIsLockStorage(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKBUILDPOINT:
          if not ConditionOfCheckGuildBuildPoint(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKAURAEPOINT:
          if not ConditionOfCheckGuildAuraePoint(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKSTABILITYPOINT:
          if not ConditionOfCheckStabilityPoint(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKFLOURISHPOINT:
          if not ConditionOfCheckFlourishPoint(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKCONTRIBUTION:
          if not ConditionOfCheckContribution(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKRANGEMONCOUNT:
          if not ConditionOfCheckRangeMonCount(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKITEMADDVALUE:
          if not ConditionOfCheckItemAddValue(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKINMAPRANGE:
          if not ConditionOfCheckInMapRange(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CASTLECHANGEDAY:
          if not ConditionOfCheckCastleChageDay(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CASTLEWARDAY:
          if not ConditionOfCheckCastleWarDay(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_ONLINELONGMIN:
          if not ConditionOfCheckOnlineLongMin(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKGUILDCHIEFITEMCOUNT:
          if not ConditionOfCheckChiefItemCount(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKNAMEDATELIST:
          if not ConditionOfCheckNameDateList(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKMAPHUMANCOUNT:
          if not ConditionOfCheckMapHumanCount(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKMAPMONCOUNT:
          if not ConditionOfCheckMapMonCount(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKVAR:
          if not ConditionOfCheckVar(PlayObject, QuestConditionInfo) then
            Result := False;
        nSC_CHECKSERVERNAME:
          if not ConditionOfCheckServerName(PlayObject, QuestConditionInfo) then
            Result := False;
        nCheckys:
          if not ConditionOfCheckys(PlayObject, QuestConditionInfo) then
            Result := False;
        nCHECKITEMDARKPROPERTY:
          begin
            if not ConditionOfCheckITEMDARKPROPERTY(PlayObject, QuestConditionInfo) then
              Result := False;
          end;
        nCHECKUPGRADECOUNT:
        begin
            if not ConditionOfCHECKUPGRADECOUNT(PlayObject, QuestConditionInfo) then
              Result := False;
        end;
        nISSHADOW:
        begin
          Result:=PlayObject.sYsnameMaster<>'';
        end;

        nCheckMapMonNameCount:
        begin
           Result:=ConditionOfCheckMapMonNameCount(PlayObject, QuestConditionInfo);
        end;
        nCheckMapMonNameCountex:
        begin
           Result:=ConditionOfCheckMapMonNameCountex(PlayObject, QuestConditionInfo);
        end;
        nCheckSignMap: Result:=PlayObject.sDieMap <>'';
        nPosEx:
        begin
          result:=ConditionOfPosex(PlayObject, QuestConditionInfo);
        end;
        nPos:Result:=Pos(QuestConditionInfo.sParam2,QuestConditionInfo.sParam1)>0;
        nISPNEUMA:Result:=PlayObject.sYsnameMaster<>'';
        nHasTask:
        begin

        end;
        nCHECKMONPOS:
        begin
           Result:=conditionofCHECKMONPOS(PlayObject, QuestConditionInfo);
        end;
        nCHECKISFRIEND:Result:=PlayObject.IsFriend(QuestConditionInfo.sParam1);
        nIsInSafeZone:Result:=PlayObject.InSafeZone;
        nPNEUMARELEASED:Result:=PlayObject.Ysplayer<>nil;
        nCHECKGEMCOUNT://检测宝石数量
        Begin
           Result:=PlayObject.wGEMCOUNT[QuestConditionInfo.nParam1 mod 3]>=QuestConditionInfo.nParam3;
        End;
        nCHECKITEMID:
        begin
            Result:=PlayObject.CheckItemsByIndex(QuestConditionInfo.nParam1)<>nil;
        end;
        nCompareText :
        begin
            GetValValue(PlayObject,QuestConditionInfo.sParam1,n10,s1);
            GetValValue(PlayObject,QuestConditionInfo.sParam1,n10,s2);
          
            if QuestConditionInfo.nParam3=1 then
               result:=s1=s2
            else
               result:=AnsiCompareText(s1,s2)=0;
        end;
        nCHECKITEMDURE: Result:=conditionofCHECKITEMDURE(PlayObject, QuestConditionInfo);
        nCheckGuildExp:
        begin
            Result:=conditionofCheckGuildExp(PlayObject, QuestConditionInfo);
        end;
        nCheckGuildGrade:
        begin
         Result:=conditionofCheckGuildGrade(PlayObject, QuestConditionInfo);
        end;
        nCheckGuildMemberCount:
        begin
            Result:=conditionofCheckGuildMemberCount(PlayObject, QuestConditionInfo);
        end;
        nCheckGuildMemberMaxLimit:
        begin
            Result:=conditionofCheckGuildMemberMaxLimit(PlayObject, QuestConditionInfo);
        end;


        nCheckTaskStep:
        begin

        end;
        nCHECKSKILL:
        begin
           Result:=PlayObject.CheckMagic(QuestConditionInfo.sParam1,QuestConditionInfo.sParam2,QuestConditionInfo.nParam3);
        end;
      end; //case

      if QuestConditionInfo.boNot then
        Result:=not Result;
    except
       MainOutMessage('Npc CheckLable Error '+Inttostr(QuestConditionInfo.nCmdCode));
    END;
   finally
     PlayObject:=OldPlayObject;
     Dispose(QuestConditionInfo);
   end;

      if not Result then
        break;
    end; //for
  end;
  function JmpToLable(sLabel: string): Boolean;
  begin
    Result := False;
    Inc(PlayObject.m_nScriptGotoCount);

    if PlayObject.m_nScriptGotoCount > g_Config.nScriptGotoCountLimit {10} then
    begin
     //  PlayObject.m_nScriptGotoCount:=0;
      exit;
    end;
    GotoLable(PlayObject, sLabel, False);
    Result := True;
  end;
  procedure GoToQuest(nQuest: Integer); //0049C898
  var
    I: Integer;
    Script: pTScript;
  begin
    for I := 0 to m_ScriptList.Count - 1 do
    begin
      Script := m_ScriptList.Items[I];
      if Script.nQuest = nQuest then
      begin
        PlayObject.m_Script := Script;
        PlayObject.m_NPC := Self;
        GotoLable(PlayObject, sMAIN, False);
        break;
      end;
    end;
  end;

  procedure AddList(sHumName, sListFileName: string); //0049B620
  var
    I: Integer;
    LoadList: TStringList;
    s10: string;
    bo15: Boolean;
  begin
    sListFileName := g_Config.sEnvirDir + sListFileName;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then
    begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    bo15 := False;
    for I := 0 to LoadList.Count - 1 do
    begin
      s10 := Trim(LoadList.Strings[i]);
      if CompareText(sHumName, s10) = 0 then
      begin
        bo15 := True;
        break;
      end;
    end;
    if not bo15 then
    begin
      LoadList.Add(sHumName);
      try
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('saving fail.... => ' + sListFileName);
      end;
    end;

    LoadList.Free;
  end;
    procedure InsertList(sHumName, sListFileName: string;nPos:Integer); //0049B620
  var

    LoadList: TStringList;


  begin
    sListFileName := g_Config.sEnvirDir + sListFileName;
    LoadList := TStringList.Create;
    if nPos<0  then npos:=0;
    
    if FileExists(sListFileName) then
    begin
      try
        LoadList.LoadFromFile(sListFileName);
        if nPos>LoadList.Count then npos:=LoadList.Count;
        LoadList.Insert(nPos,sHumName);
        LoadList.SaveToFile(sListFileName); 
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;



    LoadList.Free;
  end;
  procedure DelList(sHumName, sListFileName: string); //0049B7F8
  var
    I: Integer;
    LoadList: TStringList;
    s10: string;
    bo15: Boolean;
  begin
    sListFileName := g_Config.sEnvirDir + sListFileName;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then
    begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('loading fail.... => ' + sListFileName);
      end;
    end;
    bo15 := False;
    for I := 0 to LoadList.Count - 1 do
    begin
      s10 := Trim(LoadList.Strings[i]);
      if CompareText(sHumName, s10) = 0 then
      begin
        LoadList.Delete(i);
        bo15 := True;
        break;
      end;
    end;
    if bo15 then
    begin
      try
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('saving fail.... => ' + sListFileName);
      end;
    end;
    LoadList.Free;
  end;
  procedure TAKEDUREITEM(sItemName:String;nDura:Integer ;nItemCount:Integer);
 var
    I: Integer;
    UserItem: pTUserItem;

  begin

    PlayObject.m_ItemList.lock;
    try
      for I := PlayObject.m_ItemList.Count - 1 downto 0 do
      begin
        if nItemCount <= 0 then
          break;
        UserItem := PlayObject.m_ItemList.Items[i];
        if CompareText(UserEngine.GetStdItemName(UserItem.wIndex), sItemName) = 0 then
        begin
        //0049CC24
          if UserItem.Dura>=nDura then
          begin
            PlayObject.SendDelItems(UserItem);
            Dispose(UserItem);
            PlayObject.m_ItemList.Delete(I);
            Dec(nItemCount);
          end;
        end;
      end;
    finally
      PlayObject.m_ItemList.unlock;
    end;

  end;
  procedure AddItemExp(sItemName:String;nExp:Integer );
 var
    I: Integer;
    IntRec:TIntRec ;
    UserItem: pTUserItem;

   
  begin
     IntRec.Value:=nExp;
    PlayObject.m_ItemList.lock;
    try
      for I := 0 to PlayObject.m_ItemList.Count - 1  do
      begin
        UserItem := PlayObject.m_ItemList.Items[i];
        if CompareText(UserEngine.GetStdItemName(UserItem.wIndex), sItemName) = 0 then
        begin
          IntRec.btValue[3]:=UserItem.btValue[0];
          IntRec.btValue[2]:=UserItem.btValue[1];
          IntRec.btValue[1]:=UserItem.btValue[2];
          IntRec.btValue[0]:=UserItem.btValue[3];
          IntRec.Value:=IntRec.Value+nExp;
          UserItem.btValue[0] := IntRec.btValue[3];
          UserItem.btValue[1] := IntRec.btValue[2];
          UserItem.btValue[2] := IntRec.btValue[1];
          UserItem.btValue[3] := IntRec.btValue[0];
           IntRec.Value:= HoursBetween(Now, EncodeTime(8, 00, 00, 0)+encodedate(2009, 01, 01));

          UserItem.btValue[4] := IntRec.btValue[3];
          UserItem.btValue[5] := IntRec.btValue[2];
          UserItem.btValue[6] := IntRec.btValue[1];
          UserItem.btValue[7] := IntRec.btValue[0];
          PlayObject.SendUpdateItem(UserItem); 
          Break;
        end;
      end;
    finally
      PlayObject.m_ItemList.unlock;
    end;

  end;
  procedure TakeItem(sItemName: string; nItemCount: Integer); //0049C998
  var
    I,ii: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
  begin
    ii:=0;
    if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then
    begin
      PlayObject.DecGold(nItemCount);
      PlayObject.GoldChanged();
      //0049CADB
      if g_boGameLogGold then
        AddGameDataLog('10' + #9 +
          PlayObject.m_sMapName + #9 +
          IntToStr(PlayObject.m_nCurrX) + #9 +
          IntToStr(PlayObject.m_nCurrY) + #9 +
          PlayObject.m_sCharName + #9 +
          sSTRING_GOLDNAME + #9 +
          IntToStr(nItemCount) + #9 +
          '1' + #9 +
          m_sCharName);
      exit;
    end;

 if CompareText(sItemName,'武官积分')=0 then
  begin
   Inc(PlayObject.wATTACHEPOINT,nItemCount);
   Exit;
  end;
  //极品值
  if CompareText(sItemName,'极品值')=0 then
  begin
   Dec(PlayObject.m_nJpPoint,nItemCount);
   PlayObject.SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
   Exit;
  end;
    //声望
  if CompareText(sItemName,'声望')=0 then
  begin
   Dec(PlayObject.m_btCreditPoint,nItemCount);
    PlayObject.SendMsg(Self, RM_SUBABILITY, 0, 0, 0, 0, '');
   Exit;
  end;
  //元宝
  if CompareText(sItemName,g_Config.sGameGoldName)=0 then
  begin
   Dec(PlayObject.m_nGameGold,nItemCount);
    PlayObject.GoldChanged();
   Exit;
  end;


    PlayObject.m_ItemList.lock;
    try
      for I := PlayObject.m_ItemList.Count - 1 downto 0 do
      begin
        if nItemCount <= 0 then
          break;
        UserItem := PlayObject.m_ItemList.Items[i];
        if CompareText(UserEngine.GetStdItemName(UserItem.wIndex,False), sItemName) = 0 then
        begin
        //0049CC24
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem.NeedIdentify = 1 then
            AddGameDataLog('10' + #9 +
              PlayObject.m_sMapName + #9 +
              IntToStr(PlayObject.m_nCurrX) + #9 +
              IntToStr(PlayObject.m_nCurrY) + #9 +
              PlayObject.m_sCharName + #9 +
              sItemName + #9 +
              IntToStr(UserItem.MakeIndex) + #9 +
              '1' + #9 +
              m_sCharName);
          PlayObject.SendDelItems(UserItem);
          sC := UserEngine.GetStdItemName(UserItem.wIndex);
          Dispose(UserItem);
          UserItem:=nil;
          PlayObject.m_ItemList.Delete(I);
          Dec(nItemCount);
          Inc(ii);
        end;
      end;
    finally
      PlayObject.m_ItemList.unlock;
      PlayObject.m_sParam[12]:=IntToStr(ii);
    end;

  end;
  procedure TakeItemM(nItemIndex: Integer); //0049C998
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
  begin

    PlayObject.m_ItemList.lock;
    try
      for I := PlayObject.m_ItemList.Count - 1 downto 0 do
      begin

        UserItem := PlayObject.m_ItemList.Items[i];
        if UserItem.MakeIndex=nItemIndex then
        begin
        //0049CC24
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem.NeedIdentify = 1 then
            AddGameDataLog('10' + #9 +
              PlayObject.m_sMapName + #9 +
              IntToStr(PlayObject.m_nCurrX) + #9 +
              IntToStr(PlayObject.m_nCurrY) + #9 +
              PlayObject.m_sCharName + #9 +
              StdItem.Name + #9 +
              IntToStr(UserItem.MakeIndex) + #9 +
              '1' + #9 +
              m_sCharName);
          PlayObject.SendDelItems(UserItem);
          Dispose(UserItem);
          PlayObject.m_ItemList.Delete(I);
          Break;
        end;
      end;
    finally
      PlayObject.m_ItemList.unlock;
    end;

  end;
  procedure GiveItem(sItemName: string; nItemCount: Integer); //0049D1D0
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
  begin

    if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then
    begin
      PlayObject.IncGold(nItemCount);
      PlayObject.GoldChanged();
      //0049D2FE
      if g_boGameLogGold then
        AddGameDataLog('9' + #9 +
          PlayObject.m_sMapName + #9 +
          IntToStr(PlayObject.m_nCurrX) + #9 +
          IntToStr(PlayObject.m_nCurrY) + #9 +
          PlayObject.m_sCharName + #9 +
          sSTRING_GOLDNAME + #9 +
          IntToStr(nItemCount) + #9 +
          '1' + #9 +
          m_sCharName);
      exit;
    end;
    if UserEngine.GetStdItemIdx(sItemName) > 0 then
    begin
//      if nItemCount > 50 then nItemCount:=50;//11.22 限制数量大小
      if not (nItemCount in [1..50]) then
        nItemCount := 1; //12.28 改上一条

      PlayObject.m_ItemList.lock;
      try
        for I := 0 to nItemCount - 1 do
        begin //nItemCount 为0时出死循环
          if PlayObject.IsEnoughBag then
          begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
            begin
              PlayObject.m_ItemList.Add((UserItem));
              PlayObject.SendAddItem(UserItem);
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D46B
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('9' + #9 +
                  PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 +
                  IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_sCharName + #9 +
                  sItemName + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '1' + #9 +
                  m_sCharName);
            end
            else
              Dispose(UserItem);
          end
          else
          begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
            begin
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            //0049D5A5
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('9' + #9 +
                  PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 +
                  IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_sCharName + #9 +
                  sItemName + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '1' + #9 +
                  m_sCharName);
              PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
            end;
            Dispose(UserItem);
          end;

        end; //for
      finally
        PlayObject.m_ItemList.unlock;
      end;


    end;

  end;
  procedure TakeWItem(sItemName: string; nItemCount: Integer); //0049CCF8
  var
    I: Integer;
    sName: string;
  begin
    if CompareLStr(sItemName, '[NECKLACE]', 4) then
    begin
      if PlayObject.m_UseItems[U_NECKLACE].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_NECKLACE]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
        PlayObject.m_UseItems[U_NECKLACE].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[RING]', 4) then
    begin
      if PlayObject.m_UseItems[U_RINGL].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_RINGL]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
        PlayObject.m_UseItems[U_RINGL].wIndex := 0;
        exit;
      end;
      if PlayObject.m_UseItems[U_RINGR].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_RINGR]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
        PlayObject.m_UseItems[U_RINGR].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[ARMRING]', 4) then
    begin
      if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
        PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
        exit;
      end;
      if PlayObject.m_UseItems[U_ARMRINGR].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGR]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
        PlayObject.m_UseItems[U_ARMRINGR].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[WEAPON]', 4) then
    begin
      if PlayObject.m_UseItems[U_WEAPON].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_WEAPON]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
        PlayObject.m_UseItems[U_WEAPON].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[HELMET]', 4) then
    begin
      if PlayObject.m_UseItems[U_HELMET].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_HELMET]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
        PlayObject.m_UseItems[U_HELMET].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[DRESS]', 4) then
    begin
      if PlayObject.m_UseItems[U_DRESS].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_DRESS]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
        PlayObject.m_UseItems[U_DRESS].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BUJUK]', 4) then
    begin
      if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BUJUK]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
        PlayObject.m_UseItems[U_BUJUK].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BELT]', 4) then
    begin
      if PlayObject.m_UseItems[U_BELT].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BELT]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
        PlayObject.m_UseItems[U_BELT].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BOOTS]', 4) then
    begin
      if PlayObject.m_UseItems[U_BOOTS].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BOOTS]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
        PlayObject.m_UseItems[U_BOOTS].wIndex := 0;
        exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_CHARM]', 4) then
    begin
      if PlayObject.m_UseItems[U_CHARM].wIndex > 0 then
      begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_CHARM]);
        sC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
        PlayObject.m_UseItems[U_CHARM].wIndex := 0;
        exit;
      end;
    end;
    for I := Low(THumanUseItems) to High(THumanUseItems) do
    begin
      if nItemCount <= 0 then
        exit;
      if PlayObject.m_UseItems[i].wIndex > 0 then
      begin
        sName := UserEngine.GetStdItemName(PlayObject.m_UseItems[i].wIndex);
        if CompareText(sName, sItemName) = 0 then
        begin
          PlayObject.SendDelItems(@PlayObject.m_UseItems[i]);
          PlayObject.m_UseItems[i].wIndex := 0;
          Dec(nItemCount);
        end;
      end;
    end;
  end;
  function QuestActionProcess(ActionList: TList): Boolean; //0049D660
  var
    I, II: Integer;
       pQuestActionInfo: pTQuestActionInfo;
    QuestActionInfo: pTQuestActionInfo;
      MonGen: pTMonGenInfo;
   // tempQuestActionInfo : TQuestActionInfo ;
    n14,n24, n18, n1C, n28, n2C: Integer;
    n20X, n24Y, n34, n38, n3C, n40: Integer;
    s4C, s50: string;
    s34, s44, s48: string;
    Envir: TEnvirnoment;
    List58: TList;
    User: TPlayObject;
    BaseObject:TBaseObject;
    s1: string;
    StdItem: PTStdItem;
  begin
    Result := True;

    n18 := 0;
    n34 := 0;
    n38 := 0;
    n3C := 0;
    n40 := 0;
      OldPlayObject:=PlayObject;
    for I := 0 to ActionList.Count - 1 do
    begin
      PlayObject := OldPlayObject;
     pQuestActionInfo := ActionList.Items[i];
    //  fillchar(tempQuestActionInfo,sizeof(tQuestActionInfo),#0);
    //  tempQuestActionInfo:=pQuestActionInfo^;

    //  QuestActionInfo:= @tempQuestActionInfo  ;
      new(QuestActionInfo);
      QuestActionInfo^ := pQuestActionInfo^;


     //先处理 脚本参数
      if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam1[1] = '$') then
      begin
        s1 := QuestActionInfo.sParam1;
        QuestActionInfo.sParam1 := '<' + QuestActionInfo.sParam1 + '>';
        GetVariableText(PlayObject, QuestActionInfo.sParam1, s1);

      end;

      if (QuestActionInfo.sParam2 <> '') and (QuestActionInfo.sParam2[1] = '$') then
      begin
        s1 := QuestActionInfo.sParam2;
        QuestActionInfo.sParam2 := '<' + QuestActionInfo.sParam2 + '>';
        GetVariableText(PlayObject, QuestActionInfo.sParam2, s1);

      end;
      if (QuestActionInfo.sParam3 <> '') and (QuestActionInfo.sParam3[1] = '$') then
      begin
        s1 := QuestActionInfo.sParam3;
        QuestActionInfo.sParam3 := '<' + QuestActionInfo.sParam3 + '>';
        GetVariableText(PlayObject, QuestActionInfo.sParam3, s1);

      end;
      if (QuestActionInfo.sParam4 <> '') and (QuestActionInfo.sParam4[1] = '$') then
      begin
        s1 := QuestActionInfo.sParam4;
        QuestActionInfo.sParam4 := '<' + QuestActionInfo.sParam4 + '>';
        GetVariableText(PlayObject, QuestActionInfo.sParam4, s1);

      end;
      if (QuestActionInfo.sParam5 <> '') and (QuestActionInfo.sParam5[1] = '$') then
      begin
        s1 := QuestActionInfo.sParam5;
        QuestActionInfo.sParam5 := '<' + QuestActionInfo.sParam5 + '>';
        GetVariableText(PlayObject, QuestActionInfo.sParam5, s1);

      end;
      if (QuestActionInfo.sParam6 <> '') and (QuestActionInfo.sParam6[1] = '$') then
      begin
        s1 := QuestActionInfo.sParam6;
        QuestActionInfo.sParam6 := '<' + QuestActionInfo.sParam6 + '>';
        GetVariableText(PlayObject, QuestActionInfo.sParam6, s1);

      end;
      if QuestActionInfo.sBaseObject<>'' then
      begin
        if QuestActionInfo.sBaseObject[1]='$' then
        begin
          s1 := QuestActionInfo.sBaseObject;
          QuestActionInfo.sBaseObject := '<' + QuestActionInfo.sBaseObject + '>';
          GetVariableText(PlayObject, QuestActionInfo.sBaseObject, s1);
          QuestActionInfo.sBaseObject:=GetLineVariableText(PlayObject,QuestActionInfo.sBaseObject);
          if QuestActionInfo.sBaseObject<>'' then
          begin
            PlayObject:=UserEngine.GetPlayObject(QuestActionInfo.sBaseObject);
            if PlayObject=nil then
            begin
              PlayObject:=OldPlayObject;
              Continue;
            end;
          end;
        end;
      end;
      QuestActionInfo.sParam1:=GetLineVariableText(PlayObject,QuestActionInfo.sParam1);
      QuestActionInfo.sParam2:=GetLineVariableText(PlayObject,QuestActionInfo.sParam2);
      QuestActionInfo.sParam3:=GetLineVariableText(PlayObject,QuestActionInfo.sParam3);
      QuestActionInfo.sParam4:=GetLineVariableText(PlayObject,QuestActionInfo.sParam4);
      QuestActionInfo.sParam5:=GetLineVariableText(PlayObject,QuestActionInfo.sParam5);
      QuestActionInfo.sParam6:=GetLineVariableText(PlayObject,QuestActionInfo.sParam6);

      QuestActionInfo.sParam1:=AnsiReplaceText(QuestActionInfo.sParam1,'#32',' ');
      QuestActionInfo.sParam2:=AnsiReplaceText(QuestActionInfo.sParam2,'#32',' ');
      QuestActionInfo.sParam3:=AnsiReplaceText(QuestActionInfo.sParam3,'#32',' ');
      QuestActionInfo.sParam4:=AnsiReplaceText(QuestActionInfo.sParam4,'#32',' ');
      QuestActionInfo.sParam5:=AnsiReplaceText(QuestActionInfo.sParam5,'#32',' ');
      QuestActionInfo.sParam6:=AnsiReplaceText(QuestActionInfo.sParam6,'#32',' ');

      if IsStringNumber(QuestActionInfo.sParam1) then
        QuestActionInfo.nParam1 := Str_ToInt(QuestActionInfo.sParam1, 0);
      if IsStringNumber(QuestActionInfo.sParam2) then
        QuestActionInfo.nParam2 := Str_ToInt(QuestActionInfo.sParam2, 0);
      if IsStringNumber(QuestActionInfo.sParam3) then
        QuestActionInfo.nParam3 := Str_ToInt(QuestActionInfo.sParam3, 0);
      if IsStringNumber(QuestActionInfo.sParam4) then
        QuestActionInfo.nParam4 := Str_ToInt(QuestActionInfo.sParam4, 0);
      if IsStringNumber(QuestActionInfo.sParam5) then
        QuestActionInfo.nParam5 := Str_ToInt(QuestActionInfo.sParam5, 0);
      if IsStringNumber(QuestActionInfo.sParam6) then
        QuestActionInfo.nParam6 := Str_ToInt(QuestActionInfo.sParam6, 0);
     ///////////
   try
    try
      case QuestActionInfo.nCmdCode of //
        nSET:
          begin
            n28 := Str_ToInt(QuestActionInfo.sParam1, 0);
            n2C := Str_ToInt(QuestActionInfo.sParam2, 0);
            PlayObject.SetQuestFlagStatus(n28, n2C);
          end;
        nTAKE: TakeItem(QuestActionInfo.sParam1, QuestActionInfo.nParam2);
        nTakem: TakeItemM(QuestActionInfo.nParam1);
        //nGIVE: GiveItem(QuestActionInfo.sParam1,QuestActionInfo.nParam2);
        nStartTimer:Playobject.nTimeTick[QuestActionInfo.nParam1 mod 10]:=GetTickCount ;
        nTAKEDUREITEM:TAKEDUREITEM(QuestActionInfo.sParam1,QuestActionInfo.nParam2,QuestActionInfo.nParam3);
        nAddItemExp:AddItemExp(QuestActionInfo.sParam1,QuestActionInfo.nParam2);
        nTrim:
        begin

            GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s1);
              s4c:=Replaceallstr(s1,' ','');
              setValValue(PlayObject,QuestActionInfo.sParam1,n14,s4c);


        end;
        nGETVALIDSTR:
        begin
          if QuestActionInfo.sParam2<>'' then
            s4c:=GetValidStr3(QuestActionInfo.sParam1,s34,[QuestActionInfo.sParam2[1]]);

             setValValue(PlayObject,QuestActionInfo.sParam3,0,s34);
             setValValue(PlayObject,QuestActionInfo.sParam4,0,s4c);




        end;
        nInsert:
        begin

            s4c:=QuestActionInfo.sParam3;
            if s4C='' then s4c:=' ';

            GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s1);
            Insert(s4C,s1,QuestActionInfo.nParam2);
            SetValValue(PlayObject,QuestActionInfo.sParam1,n14,s1);

        end;

        nFormatStr:
        begin
          s4c:=QuestActionInfo.sParam3;

          s4c:=Formatstr(QuestActionInfo.sParam2,s4C);
          SetValValue(PlayObject,QuestActionInfo.sParam1,0,s4c);

        end;
        nPNEUMAcall:
        begin
          if PlayObject.Ysplayer<>nil then
          Begin
             PlayObject.Ysplayer.bocanhcall:=True;
             GotoLable(PlayObject.Ysplayer,QuestActionInfo.sParam1,false);
             PlayObject.Ysplayer.bocanhcall:=False;
          End;
        end;
        nFillText:
        begin
            GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s4c);
             n18:=QuestActionInfo.nParam2;
              n18:=n18-Length(s4c);
            if n18>0 then
            Begin
              s4c:=s4c+StringOfChar(' ',n18);
               SetValValue(PlayObject,QuestActionInfo.sParam1,n14,s4c);
            End;

         
        end;
        nReadRandomStr:
        begin
            ActionOfReadRandomStr(PlayObject,  QuestActionInfo );
        end;
        nStopTimer:
        begin
        
           n18:=GetTickCount -Playobject.nTimeTick[QuestActionInfo.nParam1 mod 10];
            SetValValue(PlayObject,QuestActionInfo.sParam2,n18,'');
        end;
        nSC_GIVE: ActionOfGiveItem(PlayObject, QuestActionInfo.sParam1,QuestActionInfo.nParam2);
        noffline: ActionOfoffline(PlayObject, QuestActionInfo);

        nTAKEW: TakeWItem(QuestActionInfo.sParam1, QuestActionInfo.nParam2);
        nCLOSE: PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
        nRESET:
          begin
            for II := 0 to QuestActionInfo.nParam2 - 1 do
            begin
              PlayObject.SetQuestFlagStatus(QuestActionInfo.nParam1 + II, 0);
            end;
          end;
        nSETOPEN:
          begin
            n28 := Str_ToInt(QuestActionInfo.sParam1, 0);
            n2C := Str_ToInt(QuestActionInfo.sParam2, 0);
            PlayObject.SetQuestUnitOpenStatus(n28, n2C);
          end;
        nSETUNIT:
          begin
            n28 := Str_ToInt(QuestActionInfo.sParam1, 0);
            n2C := Str_ToInt(QuestActionInfo.sParam2, 0);
            PlayObject.SetQuestUnitStatus(n28, n2C);
          end;
        nRESETUNIT:
          begin
            for II := 0 to QuestActionInfo.nParam2 - 1 do
            begin
              PlayObject.SetQuestUnitStatus(QuestActionInfo.nParam1 + II, 0);
            end;
          end;
        nBREAK: Result := False;
        nTIMERECALL:
          begin
            PlayObject.m_boTimeRecall := True;
            PlayObject.m_sMoveMap := PlayObject.m_sMapName;
            PlayObject.m_nMoveX := PlayObject.m_nCurrX;
            PlayObject.m_nMoveY := PlayObject.m_nCurrY;
            PlayObject.m_dwTimeRecallTick := GetTickCount + LongWord(QuestActionInfo.nParam1 * 60 * 1000);
          end;
        nSC_PARAM1:
          begin
            n34 := QuestActionInfo.nParam1;
            s44 := QuestActionInfo.sParam1;
          end;
        nSC_PARAM2:
          begin
            n38 := QuestActionInfo.nParam1;
            s48 := QuestActionInfo.sParam1;
          end;
        nSC_PARAM3:
          begin
            n3C := QuestActionInfo.nParam1;
            s4C := QuestActionInfo.sParam1;
          end;
        nSC_PARAM4:
          begin
            n40 := QuestActionInfo.nParam1;
            s50 := QuestActionInfo.sParam1;
          end;
        nSC_EXEACTION:
          begin
            n40 := QuestActionInfo.nParam1;
            s50 := QuestActionInfo.sParam1;
            ExeAction(PlayObject, QuestActionInfo.sParam1, QuestActionInfo.sParam2, QuestActionInfo.sParam3, QuestActionInfo.nParam1, QuestActionInfo.nParam2, QuestActionInfo.nParam3);
          end;
        nMAPMOVE:
          begin
            PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
            PlayObject.SpaceMove(QuestActionInfo.sParam1, QuestActionInfo.nParam2, QuestActionInfo.nParam3, 0);
            bo11 := True;
          end;
        nMAP:
          begin
            PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
            PlayObject.MapRandomMove(QuestActionInfo.sParam1, 0);
            bo11 := True;
          end;
        nTAKECHECKITEM:
          begin
            if UserItem <> nil then
            begin
              PlayObject.QuestTakeCheckItem(UserItem);
            end
            else
            begin
              ScriptActionError(PlayObject, '', QuestActionInfo, sTAKECHECKITEM);
            end;
          end;
        nMONGEN:
          begin
            for II := 0 to QuestActionInfo.nParam2 - 1 do
            begin
              n20X := Random(QuestActionInfo.nParam3 * 2 + 1) + (n38 - QuestActionInfo.nParam3);
              n24Y := Random(QuestActionInfo.nParam3 * 2 + 1) + (n3C - QuestActionInfo.nParam3);
              UserEngine.RegenMonsterByName(s44, n20X, n24Y, QuestActionInfo.sParam1);
            end;
          end;
        nMONCLEAR:
          begin
            List58 := TList.Create;
            UserEngine.GetMapMonster(g_MapManager.FindMap(QuestActionInfo.sParam1), List58);
            for II := 0 to List58.Count - 1 do
            begin
              TBaseObject(List58.Items[II]).m_boNoItem := True;
              TBaseObject(List58.Items[II]).m_WAbil.HP := 0;
            end; // for
            List58.Free;
          end;
        nGetValue:
          begin
            setValValue(PlayObject,QuestActionInfo.sParam1,PlayObject.m_nSendValue,'');
          end;

        nGetstring:
          begin
            setValValue(PlayObject,QuestActionInfo.sParam1,0, PlayObject.m_nSendstring);
           
          end;



        nMOV:
          begin

              setValValue(PlayObject,QuestActionInfo.sParam1,QuestActionInfo.nParam2,QuestActionInfo.sParam2);

          end;
        nDiv:
        begin

            GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
            if QuestActionInfo.nParam2=0 then
              n18:=1
            else
              n18:=QuestActionInfo.nParam2;
            n14:=n14 div n18;
            s34:='';
            setValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);

        end;
        nPERCENT:
        begin

            GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
            if QuestActionInfo.nParam2=0 then
              n18:=1
            else
              n18:=QuestActionInfo.nParam2;
            n14:=Round(n14/n18*100);
            s34:='';
            setValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);

        end;
        nMULT :
        begin

            GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
            if QuestActionInfo.nParam2=0 then
              n18:=1
            else
              n18:=QuestActionInfo.nParam2;
            n14:=n14*n18;
            s34:='';
            setValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);

        end;
       nINC:
          begin
            GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
            QuestActionInfo.sParam2 := AnsiReplaceText(QuestActionInfo.sParam2, '[]', ' ');
            n14:=n14+QuestActionInfo.nParam2;
            s34:=s34+QuestActionInfo.sParam2;
            setValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
          end;
        nDEC:
          begin
            GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
            QuestActionInfo.sParam2 := AnsiReplaceText(QuestActionInfo.sParam2, '[]', ' ');
            n14:=n14-QuestActionInfo.nParam2;
            Delete(s34,QuestActionInfo.nParam2,QuestActionInfo.nParam3);
            setValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
          end;
        nSUM:
          begin
            GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
            GetValValue(PlayObject,QuestActionInfo.sParam2,n18,s44);
            n14:=n14+n18;
            s34:=s34+s44;
            setValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
          end;
        nBREAKTIMERECALL: PlayObject.m_boTimeRecall := False;

        nCHANGEMODE:
          begin
            case QuestActionInfo.nParam1 of
              1: PlayObject.CmdChangeAdminMode('', 10, '', Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
              2: PlayObject.CmdChangeSuperManMode('', 10, '', Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
              3: PlayObject.CmdChangeObMode('', 10, '', Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
              4: PlayObject.m_boAttackMode:=Str_ToInt(QuestActionInfo.sParam2, 0) = 1;
            else
              begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sCHANGEMODE);
              end;
            end;
          end;
        nPKPOINT:
          begin
            if QuestActionInfo.nParam1 = 0 then
            begin
              PlayObject.m_nPkPoint := 0;
            end
            else
            begin
              if QuestActionInfo.nParam1 < 0 then
              begin
                if (PlayObject.m_nPkPoint + QuestActionInfo.nParam1) >= 0 then
                begin
                  Inc(PlayObject.m_nPkPoint, QuestActionInfo.nParam1);
                end
                else
                  PlayObject.m_nPkPoint := 0;
              end
              else
              begin
                if (PlayObject.m_nPkPoint + QuestActionInfo.nParam1) > 10000 then
                begin
                  PlayObject.m_nPkPoint := 10000;
                end
                else
                begin
                  Inc(PlayObject.m_nPkPoint, QuestActionInfo.nParam1);
                end;
              end;
            end;
            PlayObject.RefNameColor();
          end;
        nCHANGEXP:
          begin

          end;
        nSC_RECALLMOB: ActionOfRecallmob(PlayObject, QuestActionInfo);
        {
        nSC_RECALLMOB: begin
          if QuestActionInfo.nParam3 <= 1 then begin
            PlayObject.MakeSlave(QuestActionInfo.sParam1,3,Str_ToInt(QuestActionInfo.sParam2,0),100,10 * 24 * 60 * 60);
          end else begin
            PlayObject.MakeSlave(QuestActionInfo.sParam1,3,Str_ToInt(QuestActionInfo.sParam2,0),100,QuestActionInfo.nParam3 * 60)
          end;
        end;
        }
        nKICK:
          begin
            PlayObject.m_boReconnection := True;
            PlayObject.m_boSoftClose := True;
          end;
        nMOVR:
          begin

            n14:=Random(QuestActionInfo.nParam2);
            s34:='';
            setValValue(PlayObject,QuestActionInfo.sParam1,n14,s34);
          end;
        nEXCHANGEMAP:
          begin
            Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
            if Envir <> nil then
            begin
              List58 := TList.Create;
              UserEngine.GetMapRageHuman(Envir, 0, 0, 1000, List58);
              if List58.Count > 0 then
              begin
                User := TPlayObject(List58.Items[0]);
                User.MapRandomMove(Self.m_sMapName, 0);
              end;
              List58.Free;
              PlayObject.MapRandomMove(QuestActionInfo.sParam1, 0);
            end
            else
            begin
              ScriptActionError(PlayObject, '', QuestActionInfo, sEXCHANGEMAP);
            end;

          end;
        nRECALLMAP:
          begin
            Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
            if Envir <> nil then
            begin
              List58 := TList.Create;
              UserEngine.GetMapRageHuman(Envir, 0, 0, 1000, List58);
              for II := 0 to List58.Count - 1 do
              begin
                User := TPlayObject(List58.Items[II]);
                User.MapRandomMove(Self.m_sMapName, 0);
                if II > 20 then
                  break;
              end;
              List58.Free;
            end
            else
            begin
              ScriptActionError(PlayObject, '', QuestActionInfo, sRECALLMAP);
            end;
          end;
        nADDBATCH: List1C.AddObject(QuestActionInfo.sParam1, TObject(n18));
        nBATCHDELAY: n18 := QuestActionInfo.nParam1 * 1000;
        nBATCHMOVE:
          begin
            for II := 0 to List1C.Count - 1 do
            begin
              PlayObject.SendDelayMsg(Self, RM_10155, 0, 0, 0, 0, List1C.Strings[II], Integer(List1C.Objects[II]) + n20);
              Inc(n20, Integer(List1C.Objects[II]));
            end;
          end;
        nPLAYDICE:
          begin //0049E209
            PlayObject.m_sPlayDiceLabel := QuestActionInfo.sParam2;
            PlayObject.SendMsg(Self,
              RM_PLAYDICE,
              QuestActionInfo.nParam1,
              MakeLong(MakeWord(PlayObject.m_DyVal[0], PlayObject.m_DyVal[1]), MakeWord(PlayObject.m_DyVal[2], PlayObject.m_DyVal[3])),
              MakeLong(MakeWord(PlayObject.m_DyVal[4], PlayObject.m_DyVal[5]), MakeWord(PlayObject.m_DyVal[6], PlayObject.m_DyVal[7])),
              MakeLong(MakeWord(PlayObject.m_DyVal[8], PlayObject.m_DyVal[9]), 0),
              QuestActionInfo.sParam2);
            bo11 := True;
          end;
        nADDVARLIST: AddList(QuestActionInfo.sParam1, m_sPath + QuestActionInfo.sParam2);
        nDELVARLIST: DelList(QuestActionInfo.sParam1, m_sPath + QuestActionInfo.sParam2);
        nINSERTVARLIST:InsertList(QuestActionInfo.sParam2, m_sPath + QuestActionInfo.sParam3,QuestActionInfo.nParam1);
        nCHECKITEMBOXCF:
        begin
           PlayObject.m_sParam[12]:=QuestActionInfo.sParam1;
           PlayObject.SendDefMessage(198,0,2,0,0,'') ;
        end;
        nDropItemDown:
        Begin
            sc:=QuestActionInfo.sParam3;
            sc:=GetValidStr3(sC,SSS,['(']);
            sc:=GetValidStr3(sC,sx,[',']);
            sc:=GetValidStr3(sC,sy,[',']);
            sc :=GetValidStr3(sC,sRand,[')']);
            nx:=Str_ToInt(sx,-1);
            nY:=Str_ToInt(sy,-1);
            n14:=Str_ToInt(srand,-1);
            Envir:=g_MapManager.FindMap(sss);
            if Envir<>nil then
            Begin
              PlayObject.MakeDropItemDown(Envir,QuestActionInfo.sParam1,QuestActionInfo.nParam2,nx,ny,n14);

            End;
        End;
        nShowAdditionalInfo:
        Begin
          case QuestActionInfo.nParam1 of
            0://显示凝聚元婴界面
               PlayObject.SendDefMessage(SM_SENDUSERREPAIR,Integer(PlayObject),0,0,4,'');
            1://组队
              ;
            2:;
            3://幻化提示
            begin
              PlayObject.SendDefMessage(3052,Integer(PlayObject),QuestActionInfo.nParam2,QuestActionInfo.nParam3,QuestActionInfo.nParam4,QuestActionInfo.sParam5);
            end;
            4: PlayObject.SendDefMessage(627,QuestActionInfo.nParam1,13,20,0,QuestActionInfo.sParam5);
          end;
          //   PlayObject.SendDefMessage(SM_SENDUSERREPAIR,Integer(PlayObject),0,0,4,'');
        End;
        nSETADDITIONALABIL:
        begin
           ActionOfSetAdditionalAbil(PlayObject, QuestActionInfo);
        end;
        //显示神龙献宝界面
        nSENDBOXSL:
        Begin
           PlayObject.SendDefMessage(34973,0,4,0,0,'');
           PlayObject.m_npc1:=Self ;
           PlayObject.m_sparam[1]:='0';
        End;
        ////设置最终中奖结果
        nSETMAGICBOXSL:
        begin
            PlayObject.SWYINFO.btType:=QuestActionInfo.nParam1;
            PlayObject.SWYINFO.btLevel:=QuestActionInfo.nParam2;
            PlayObject.SWYINFO.str:=QuestActionInfo.sParam3;
        end;
        //表示设置中奖个数，为0表示没有中奖！
        nOPENBOXSL:
        begin
          if QuestActionInfo.nParam1>0 then
          Begin
            sc:=EncodeBuffer(@PlayObject.SWYInfo,Length(PlayObject.SWYINFO.str)+3);
            PlayObject.SendDefMessage(34973,0,5,1,0,sC,true);
          End
          else
            PlayObject.SendDefMessage(34973,0,5,0,0,'');
          PlayObject.m_sParam[1]:='1';
        end;
        nSwitchPneuma:
        begin
           if PlayObject.Ysplayer<>nil then
           Begin
              PlayObject.Ysplayer.SendDefMessage(SM_OUTOFCONNECTION, 0, 0, 0, 0, '');
           End;
           if  PlayObject.btHasYS2>0 then
           Begin
              PlayObject.btHasYS2:=PlayObject.btHasYS2+1;
              if PlayObject.btHasYS2>2 then PlayObject.btHasYS2:=1;
                 PlayObject.SendYuanYingInfo;
           End;
        end;
        nShowSoulDig:
        begin
          PlayObject.SendDefMessage(3042,Integer(PlayObject),makeword(QuestActionInfo.nParam2,QuestActionInfo.nParam2),0,0,'');
        end;
        nTAKEON:
        begin
          UserItem:=PlayObject.GetItemByName(QuestActionInfo.sParam2);
          if UserItem<>nil then
          Begin
             PlayObject.ClientTakeOnItems(QuestActionInfo.nparam1,UserItem.MakeIndex,QuestActionInfo.sParam2,true);
             PlayObject.SendUseitems;
             PlayObject.ClientQueryBagItems;
          End;
        end;
        nADDNAMELIST: AddList(PlayObject.m_sCharName, m_sPath + QuestActionInfo.sParam1);
        nDELNAMELIST: DelList(PlayObject.m_sCharName, m_sPath + QuestActionInfo.sParam1);
        nADDGUILDLIST:
          if PlayObject.m_MyGuild <> nil then
            AddList(TGuild(PlayObject.m_MyGuild).sGuildName, m_sPath + QuestActionInfo.sParam1);
        nDELGUILDLIST:
          if PlayObject.m_MyGuild <> nil then
            DelList(TGuild(PlayObject.m_MyGuild).sGuildName, m_sPath + QuestActionInfo.sParam1);
        nSC_LINEMSG, nSENDMSG: ActionOfLineMsg(PlayObject, QuestActionInfo);

        nADDACCOUNTLIST: AddList(PlayObject.m_sUserID, m_sPath + QuestActionInfo.sParam1);
        nDELACCOUNTLIST: DelList(PlayObject.m_sUserID, m_sPath + QuestActionInfo.sParam1);
        nADDIPLIST: AddList(PlayObject.m_sIPaddr, m_sPath + QuestActionInfo.sParam1);
        nDELIPLIST: DelList(PlayObject.m_sIPaddr, m_sPath + QuestActionInfo.sParam1);
        nGOQUEST: GoToQuest(QuestActionInfo.nParam1);
        nENDQUEST: PlayObject.m_Script := nil;
        nGOTO:
          begin
            if not JmpToLable(QuestActionInfo.sParam1) then
            begin
            //ScriptActionError(PlayObject,'',QuestActionInfo,sGOTO);
              MainOutMessage('[脚本死循环] NPC:' + m_sCharName +
                ' 位置:' + m_sMapName + '(' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) + ')' +
                ' 命令:' + sGOTO + ' ' + QuestActionInfo.sParam1);
              Result := False;
              exit;
            end;
          end;

        nSC_HAIRCOLOR: ;
        nSC_WEARCOLOR: ActionOfWearColor(PlayObject, QuestActionInfo);
        nSC_HAIRSTYLE: ActionOfChangeHairStyle(PlayObject, QuestActionInfo);
      //  nSC_MONRECALL: ;
      //  nSC_HORSECALL: ;
      //  nSC_HAIRRNDCOL: ;
      //  nSC_KILLHORSE: ;
      //  nSC_RANDSETDAILYQUEST: ;

        nSC_RECALLGROUPMEMBERS: ActionOfRecallGroupMembers(PlayObject, QuestActionInfo);
        nSC_CLEARNAMELIST: ActionOfClearNameList(PlayObject, QuestActionInfo);
       
        nSC_CHANGELEVEL: ActionOfChangeLevel(PlayObject, QuestActionInfo);
        nSC_MARRY: ActionOfMarry(PlayObject, QuestActionInfo);
        nSC_MASTER: ActionOfMaster(PlayObject, QuestActionInfo);
        nSC_UNMASTER: ActionOfUnMaster(PlayObject, QuestActionInfo);
        nSC_UNMARRY: ActionOfUnMarry(PlayObject, QuestActionInfo);
        nSC_GETMARRY: ActionOfGetMarry(PlayObject, QuestActionInfo);
        nSC_GETMASTER: ActionOfGetMaster(PlayObject, QuestActionInfo);
        nSC_CLEARSKILL: ActionOfClearSkill(PlayObject, QuestActionInfo);
        nSC_DELNOJOBSKILL: ActionOfDelNoJobSkill(PlayObject, QuestActionInfo);
        nSC_DELSKILL: ActionOfDelSkill(PlayObject, QuestActionInfo);
        nSC_ADDSKILL: ActionOfAddSkill(PlayObject, QuestActionInfo);
        nSC_ADDYSSKILL: ActionOfADDYSSKILL(PlayObject, QuestActionInfo);

        nSC_SKILLLEVEL: ActionOfSkillLevel(PlayObject, QuestActionInfo);
        nSC_CHANGEPKPOINT: ActionOfChangePkPoint(PlayObject, QuestActionInfo);
        nSC_CHANGEEXP: ActionOfChangeExp(PlayObject, QuestActionInfo);
        nSC_CHANGEJOB: ActionOfChangeJob(PlayObject, QuestActionInfo);
        nSC_MISSION: ActionOfMission(PlayObject, QuestActionInfo);
        nSC_MOBPLACE: ActionOfMobPlace(PlayObject, QuestActionInfo, n34, n38, n3C, n40);
        nSC_MOBPLACEX: ActionOfMobPlaceX(PlayObject, QuestActionInfo);
        nSC_SETMEMBERTYPE: ActionOfSetMemberType(PlayObject, QuestActionInfo);
        nSC_SETMEMBERLEVEL: ActionOfSetMemberLevel(PlayObject, QuestActionInfo);
//        nSC_SETMEMBERTYPE:   PlayObject.m_nMemberType:=Str_ToInt(QuestActionInfo.sParam1,0);
//        nSC_SETMEMBERLEVEL:  PlayObject.m_nMemberType:=Str_ToInt(QuestActionInfo.sParam1,0);
        nSC_GAMEGOLD: ActionOfGameGold(PlayObject, QuestActionInfo);
        nSC_GAMEPOINT: ActionOfGamePoint(PlayObject, QuestActionInfo);
        nJPPOINT: ActionOfJPPOINT(PlayObject, QuestActionInfo);
        nYSPOINT: ActionOfYSPOINT(PlayObject, QuestActionInfo);
        nADDTASK: ActionOfADDTASK(PlayObject, QuestActionInfo);
        nUpdateTask: ActionOfUpdateTask(PlayObject, QuestActionInfo);
        nEndTask: ActionOfEndTask(PlayObject, QuestActionInfo);
        nYSFENGHAO: ActionOfYSFENGHAO(PlayObject, QuestActionInfo);
        nADDYQ: ActionOfADDYQ(PlayObject, QuestActionInfo);
        nBOOSFS: ActionOfBOOSFS(PlayObject, QuestActionInfo);
        nTAKEB: ActionOfTAKEB(PlayObject, QuestActionInfo);
        nGROUPMOVE: ActionOfGROUPMOVE(PlayObject, QuestActionInfo);

        nHasTask: ActionOfHasTask(PlayObject, QuestActionInfo);
        nSC_AUTOADDGAMEGOLD: ActionOfAutoAddGameGold(PlayObject, QuestActionInfo, n34, n38);
        nSC_AUTOSUBGAMEGOLD: ActionOfAutoSubGameGold(PlayObject, QuestActionInfo, n34, n38);
        nSC_CHANGENAMECOLOR: ActionOfChangeNameColor(PlayObject, QuestActionInfo);
        nSC_CLEARPASSWORD: ActionOfClearPassword(PlayObject, QuestActionInfo);
        nSC_RENEWLEVEL: ActionOfReNewLevel(PlayObject, QuestActionInfo);
        nSC_KILLSLAVE: ActionOfKillSlave(PlayObject, QuestActionInfo);
        nSC_CHANGEGENDER: ActionOfChangeGender(PlayObject, QuestActionInfo);
        nSC_KILLMONEXPRATE: ActionOfKillMonExpRate(PlayObject, QuestActionInfo);
        nSC_POWERRATE: ActionOfPowerRate(PlayObject, QuestActionInfo);
        nSC_STATUSRATE: ActionOfStatusRate(PlayObject, QuestActionInfo);
        nUPGRADECHECKITEMBOX:
        begin
           ActionOfUpGradeITEMBox(PlayObject, QuestActionInfo);
        end;
        nSetTimerA:
        begin
          ActionOfSetTimerA(PlayObject, QuestActionInfo);
        end;
        //取消天山血莲和深海灵礁的特殊效果
        nChangeFlagMode:
        begin
          if QuestActionInfo.nParam1=1 then
            PlayObject.m_dwAddhpmodetick:=GetTickCount;
          if QuestActionInfo.nParam1=2 then
            PlayObject.m_dwAddmpmodetick:=GetTickCount;

        end;
        nGUILDEXP:
        begin
           ActionOfGUILDEXP(PlayObject, QuestActionInfo);
        end;
        nGuildGrade:
        begin
          ActionOfGUILDGRADE(PlayObject, QuestActionInfo);
        end;
        nGuildMemberMaxLimit:
        begin
          ActionOfGuildMemberMaxLimit(PlayObject, QuestActionInfo);
        end;
        nQuitGuild:

        begin
          ActionOfQUITGUILD(PlayObject, QuestActionInfo);
        end;
        nGetExp:PlayObject.GainExp(QuestActionInfo.nParam1);
        nUPGRADEMONZSD:ActionOfPetZS(PlayObject, QuestActionInfo);
        nUPGRADEMONLEVEL:ActionOfPetLevel(PlayObject, QuestActionInfo);
        nUPDATEMONSTONE:PlayObject.UPDATEMONSTONE;
        //调整全服怪物经验倍数 2008-11-21
        nKillMonExpMultiple:
        begin
          if QuestActionInfo.nParam1>0 then
            g_Config.dwKillMonExpMultiple:=QuestActionInfo.nParam1;
        end;
        // 2008-11-22 16:05:37  调整灵兽的属性;
        nSETPETATTRIBUTE:
        begin
          ActionOfPetProperty(PlayObject, QuestActionInfo);
        end;
        nSETPETRATE:
        begin
          PlayObject.m_nPetRate:=QuestActionInfo.nParam1;
        end;
        nMobNpc:
        begin
          ActionOfMobNpc(PlayObject, QuestActionInfo);
        end;
        nUPGRADEMONEXP:ActionOfPetExp(PlayObject, QuestActionInfo);
        nAddCastleWar: ActionOfAddCastleWar(PlayObject, QuestActionInfo);
        nCLEARCASTLEWAR: ActionOfCLEARCASTLEWAR(PlayObject, QuestActionInfo);
        nSC_CHANGEMODE: ActionOfChangeMode(PlayObject, QuestActionInfo);
        nSC_CHANGEPERMISSION: ActionOfChangePerMission(PlayObject, QuestActionInfo);
        nSC_KILL: ActionOfKill(PlayObject, QuestActionInfo);
        nSC_KICK: ActionOfKick(PlayObject, QuestActionInfo);
        nSC_BONUSPOINT: ActionOfBonusPoint(PlayObject, QuestActionInfo);
        nSC_RESTRENEWLEVEL: ActionOfRestReNewLevel(PlayObject, QuestActionInfo);
        nSC_DELMARRY: ActionOfDelMarry(PlayObject, QuestActionInfo);
        nSC_DELMASTER: ActionOfDelMaster(PlayObject, QuestActionInfo);
        nSC_CREDITPOINT: ActionOfChangeCreditPoint(PlayObject, QuestActionInfo);
        nSC_CLEARNEEDITEMS: ActionOfClearNeedItems(PlayObject, QuestActionInfo);
        nSC_CLEARMAEKITEMS: ActionOfClearMakeItems(PlayObject, QuestActionInfo);
        nSC_SETSENDMSGFLAG: PlayObject.m_boSendMsgFlag := True;
        nSC_UPGRADEITEMS: ActionOfUpgradeItems(PlayObject, QuestActionInfo);
        nSC_UPGRADEITEMSEX: ActionOfUpgradeItemsEx(PlayObject, QuestActionInfo);
        nSC_MONGENEX: ActionOfMonGenEx(PlayObject, QuestActionInfo);
        nSC_CLEARMAPMON: ActionOfClearMapMon(PlayObject, QuestActionInfo);
        nSC_CLEARITEMMAP: //清理地图物品
        Begin
           Envir:=g_MapManager.FindMap(QuestActionInfo.sParam1);
           if Envir<>nil then envir.clearMapItem;

        End;
        nCLEARMAPBODY :  //清理地图尸体
        Begin
           Envir:=g_MapManager.FindMap(QuestActionInfo.sParam1);
           if Envir<>nil then envir.clearMapBody;

        End;
        nGEMCOUNT:
        begin
           ActionOfGemCount(PlayObject, QuestActionInfo);
        end;
        nSC_SETMAPMODE: ActionOfSetMapMode(PlayObject, QuestActionInfo);
        nSC_PKZONE: ActionOfPkZone(PlayObject, QuestActionInfo);
        nSC_RESTBONUSPOINT: ActionOfRestBonusPoint(PlayObject, QuestActionInfo);
        nSC_USEBONUSPOINT: ActionOfuseBonusPoint(PlayObject, QuestActionInfo);
        nSC_UpdateTop: ActionOfUpdateTop(PlayObject, QuestActionInfo);
        nSC_CLEARCURMAPMON: ActionOfCLEARCURMAPMON(PlayObject, QuestActionInfo);
        nSC_MONSTORAGE: ActionOfMONSTORAGE(PlayObject, QuestActionInfo);
        nSC_FEEDMON: ActionOfFEEDMON(PlayObject, QuestActionInfo);
        nSC_UPGRADEMON: PlayObject.UPGRADEPet(QuestActionInfo.nParam1); //豹子升级
        nSC_CHECKITEMBOX: ActionOfcheckitembox(PlayObject, QuestActionInfo);
        nrelive: PlayObject.relivemon(1); //豹子复活
        nrecpos: ActionOfrecpos(PlayObject, QuestActionInfo);
        ndelay,nSC_DELAYGOTO: ActionOfdelay(PlayObject, QuestActionInfo);

        nhcall: ActionOfhcall(PlayObject, QuestActionInfo);

        nSetArrow: ActionSetArrow(PlayObject, QuestActionInfo);
        nClearArrow: ActionClearArrow(PlayObject, QuestActionInfo);
        nFENGHAO: ActionFENGHAO(PlayObject, QuestActionInfo);

        nSETUSEITEMNAME: ActionSETUSEITEMNAME(PlayObject, QuestActionInfo);
        nCLONESELF: ActionCLONESELF(PlayObject, QuestActionInfo);
        nUSESKILL: ActionUSESKILL(PlayObject, QuestActionInfo);
        nSETOFFLINE: ActionSETOFFLINE(PlayObject, QuestActionInfo);
        nSETTIMER: ActionSETTIMER(PlayObject, QuestActionInfo);
        nFUSHEN: ActionFUSHEN(PlayObject, QuestActionInfo);
        nCreateYS: ActionCreateYS(PlayObject, QuestActionInfo);
        nCLEARYS: ActionclearYS(PlayObject, QuestActionInfo);
        nDECUSESTIME: ActionDECUSESTIME(PlayObject, QuestActionInfo);
        nREPAIRALL: ActionREPAIRALL(PlayObject, QuestActionInfo);
        nGameOfWoool: ActionGameOfWoool(PlayObject, QuestActionInfo);
        nCreateGroupLight: ActionCreateGroupLight(PlayObject, QuestActionInfo);
        nSC_RANDOMX: ActionRANDOMX(PlayObject, QuestActionInfo);
        nSC_BODYEFFECT: ActionBODYEFFECT(PlayObject, QuestActionInfo);
        nDELCOMMENT://删除指定玩家在本NPC的留言
        Begin
          ActionDELCOMMENT(PlayObject, QuestActionInfo);
        End;
        nReplaceText:
        begin
           GetValValue(PlayObject,QuestActionInfo.sParam1,n14,s1);
           Replaceallstr(s1,QuestActionInfo.sParam2,QuestActionInfo.sParam3);
           setValValue(PlayObject,QuestActionInfo.sParam1,0,s1);
        end;
        nSKYROCKET:
        begin

        end;
        nMAPMOVEHUM://MAPMOVEHUM 源地图 目的地图
        Begin
          ActionMAPMOVEHUM(PlayObject, QuestActionInfo);
        End;
        nRANDOMGIVE:
        begin
          ActionRandomGive(PlayObject, QuestActionInfo);
        end;
        nSC_TAKECASTLEGOLD: ActionOfTakeCastleGold(PlayObject, QuestActionInfo);
        nSC_HUMANHP: ActionOfHumanHP(PlayObject, QuestActionInfo);
        nSC_HUMANMP: ActionOfHumanMP(PlayObject, QuestActionInfo);
        nSC_BUILDPOINT: ActionOfGuildBuildPoint(PlayObject, QuestActionInfo);
        nSC_AURAEPOINT: ActionOfGuildAuraePoint(PlayObject, QuestActionInfo);
        nSC_STABILITYPOINT: ActionOfGuildstabilityPoint(PlayObject, QuestActionInfo);
        nSC_FLOURISHPOINT: ActionOfGuildflourishPoint(PlayObject, QuestActionInfo);
        nSC_OPENMAGICBOX: ActionOfOpenMagicBox(PlayObject, QuestActionInfo);
        nSC_SETRANKLEVELNAME: ActionOfSetRankLevelName(PlayObject, QuestActionInfo);
        nSC_GMEXECUTE: ActionOfGmExecute(PlayObject, QuestActionInfo);
        nSC_GUILDCHIEFITEMCOUNT: ActionOfGuildChiefItemCount(PlayObject, QuestActionInfo);
        nSC_ADDNAMEDATELIST: ActionOfAddNameDateList(PlayObject, QuestActionInfo);
        nSC_DELNAMEDATELIST: ActionOfDelNameDateList(PlayObject, QuestActionInfo);
        nSC_MOBFIREBURN: ActionOfMobFireBurn(PlayObject, QuestActionInfo);
        nSC_MESSAGEBOX: ActionOfMessageBox(PlayObject, QuestActionInfo);
        nSC_SETSCRIPTFLAG: ActionOfSetScriptFlag(PlayObject, QuestActionInfo);
        nSC_SETAUTOGETEXP: ActionOfAutoGetExp(PlayObject, QuestActionInfo);
        nSC_VAR: ActionOfVar(PlayObject, QuestActionInfo);
        nSC_LOADVAR: ActionOfLoadVar(PlayObject, QuestActionInfo);
        nLoadExVar: ActionOfLoadEXVar(PlayObject, QuestActionInfo);
        nSC_SAVEVAR: ActionOfSaveVar(PlayObject, QuestActionInfo);
        nSaveExVar:ActionOfSaveEXVar(PlayObject, QuestActionInfo);
        nSC_CALCVAR: ActionOfCalcVar(PlayObject, QuestActionInfo);
        nSC_QUERYVALUE: ActionOfQueryvalue(PlayObject, QuestActionInfo);
        nSC_QUERYname: ActionOfQueryNAME(PlayObject, QuestActionInfo);
        nChangeArp: ActionOfChangeArp(PlayObject, QuestActionInfo);
        nSC_BIGBAG: ActionOfbigbag(PlayObject, QuestActionInfo);
        nChangeweather: ActionOfChangeweather(PlayObject, QuestActionInfo);
        nChangeFlag: ActionOfChangeflag(PlayObject, QuestActionInfo);
        nmagicfont: ActionOfmagicfont(PlayObject, QuestActionInfo);
        nmagicfontcolor: ActionOfmagicfontcolor(PlayObject, QuestActionInfo);
        nSENDCOMMENT:
        Begin
           ActionOfSendComment(PlayObject);
          //PlayObject.SendDefMessage(SM_LAMPCHANGEDURA,integer(self),length(m_sComments),0,1,m_sComments);
        End;
        nmagiccolor:
          begin
            PlayObject.m_bomagiccolorchange := true;
            PlayObject.m_nmagiccolor := str_toint(QuestActionInfo.sParam1, 0);
          end;
        nfireflower: SendRefMsg(rm_21295, 0, 0, 0, strtoint(QuestActionInfo.sParam1), '');
        nADDITEMDARKPROPERTY:
          begin
            ActionOfADDITEMDARKPROPERTY(PlayObject, QuestActionInfo);
          end;
        nCLEARITEMEVIL://释放心魔
        begin
            PlayObject.ClearItemEvil;
        end;
        nADDITEMEVIL:
        begin
          PlayObject.ClientAddMagicTOItem;
        end;
        nTAKESUPERBOXITEM:
        begin
           n20x:=QuestActionInfo.nParam1;

           PlayObject.DelBagItem(PlayObject.m_UpDateItem[n20X mod 8].MakeIndex,PlayObject.m_UpDateItem[n20X mod 8].s.Name,True);
        end;
        nSMELTBOXRESULT:
        begin
           PlayObject.m_wSmelBoxResult:=QuestActionInfo.nParam1;
           PlayObject.SendDefMessage(SM_MAKESTONE,0,QuestActionInfo.nParam1,1,QuestActionInfo.nParam2,'');                                                                                      PlayObject.SendDefMessage(SM_MAKESTONE,0,1,1,PlayObject.m_nSuperBoxType,'');
        end;
        nSetErniePrize:
        begin
              ActionOfSetErniePrize(PlayObject, QuestActionInfo);
        end;
        nSETSUPERBOXRESULT:
        begin
          Playobject.m_wSmelBoxResult:=QuestActionInfo.nParam1;
          PlayObject.SendDefMessage(SM_MAKESTONE,0,1,1,PlayObject.m_nSuperBoxType,'');
        end;
        nShowSmeltBox:
        Begin
            PlayObject.SendDefMessage(SM_MAKESTONE,0,0,0,QuestActionInfo.nParam1,'');
        End;
        nUPGRADESUPERITEMBOX:
        begin
          ActionOfUpGradeITEMDARKPROPERTY(PlayObject, QuestActionInfo);
        end;
        nUPGRADEUSERITEM:
        begin
          ActionOfUpGradeUserITEMDARKPROPERTY(PlayObject, QuestActionInfo);
        end;
        nGoBackMap:
        Begin
          ActionOfGoBackeMap(PlayObject, QuestActionInfo);

        End;
        nJoinGuild:ActionOfJoinGuild(PlayObject, QuestActionInfo);
        nUpgradeUserItemEx: ActionOfUpGradeUserITEMEX(PlayObject, QuestActionInfo);
        nGiveb:
        Begin
            ActionOfGiveItem(PlayObject, QuestActionInfo.sParam1,QuestActionInfo.nParam2,True);

        End;
        nSETNPCNAME:
        begin
           ActionofSetNpcName(playobject, QuestActionInfo);
        end;
        nSETNPCAPPR:
        begin
           ActionofSetNpcAPPR(playobject, QuestActionInfo);
        end;
        nPlayDefence: //离火封魔阵
        Begin
          ActionofPlayDefence(playobject, QuestActionInfo);
        End;
        nPLAYERCALL:
        Begin
          if playObject.ysmasterplayer<>nil then
             Self.GotoLable(playObject.ysmasterplayer,QuestActionInfo.sParam1,false);
        End;
        nCollectPoint:
        begin
           if QuestActionInfo.sParam1='=' then
             PlayObject.m_ngameCode:=QuestActionInfo.nParam2;
           if QuestActionInfo.sParam1='+' then
             Inc(PlayObject.m_ngameCode,QuestActionInfo.nParam2);
           if QuestActionInfo.sParam1='-' then
            Dec(PlayObject.m_ngameCode,QuestActionInfo.nParam2);
           if PlayObject.m_ngameCode<0 then
             PlayObject.m_ngameCode:=0;
           PlayObject.SendDefMessage(59002,PlayObject.m_ngameCode,0,0,0,'');
           
        end;
        nSETPETRANKNAME://豹子支持自定义名字，实现兽名魔咒
        begin
          ChangePetName(PlayObject,QuestActionInfo.sParam1);
        end;
        nMESSAGEBOXA:
        begin
           PlayObject.messageA(Integer(Self),QuestActionInfo.sParam1,QuestActionInfo.sParam2,QuestActionInfo.sParam3);
        
        end;
        nQUERYMSG:
          PlayObject.messageA(Integer(Self),QuestActionInfo.sParam1,QuestActionInfo.sParam2,QuestActionInfo.sParam2);
        nGIVEBOXITEM:
        begin
        
        end;
        nGoBackHome://回城
           PlayObject.moveToHome();
        nSETMAGICBOXITEM:
        begin
          if QuestActionInfo.nParam1 in [1..11] then
          Begin
              StdItem:=UserEngine.GetStdItem(QuestActionInfo.sParam2);
              if StdItem<>nil then
              Begin
                 PlayObject.m_BoxItem[QuestActionInfo.nParam1-1].SName:=StdItem.Name;
                 PlayObject.m_BoxItem[QuestActionInfo.nParam1-1].wLooks:=StdItem.Looks;
              End
              else
                 ScriptActionError(PlayObject, '数据库里没有物品：'+QuestActionInfo.sParam2, QuestActionInfo, sSETMAGICBOXITEM);
          End;
        end;
        nRANDOMGIVEITEMS://真正开宝箱
        Begin
           PlayObject.OPENMAGICBOX(QuestActionInfo.nParam1,QuestActionInfo.sParam2,QuestActionInfo.sParam3);

        End;
        nSETMAGICBOX:
        begin
           PlayObject.SETMagicBox(QuestActionInfo.sParam1);
        end;
        nSetBlessPower: PlayObject.SetBlessPower(QuestActionInfo.nParam1) ;
        nSendBlessItemList:PlayObject.SendQiYuanTreeItem( m_sPath + QuestActionInfo.sParam1);
      //  nOPENBLESS: PlayObject.SendQiYuanTreeItem(QuestActionInfo.sParam1);
        nMOBEVIL://刷心魔
          begin
            s44:=UpperCase(QuestActionInfo.sParam1);

            if s44='SELF' then
            begin
               if PlayObject.Ysplayer=nil then
                  exit;
               s44:='('+PlayObject.Ysplayer.m_sCharName+')'+'心魔';
            end;
            User:=UserEngine.GetPlayObject(QuestActionInfo.sParam1) ;
            if User=nil then exit;
            S48:=GetValidStr3(QuestActionInfo.sParam2,s34,['(']);
            S48:=GetValidStr3(s48,s4c,[',']);//x
            S48:=GetValidStr3(s48,s50,[',']); //y
            GetValidStr3(s48,s48,[')']); //范围
            n14:=Str_toInt(s4c,0);
            n18:=Str_toInt(s50,0);
            n1c:=Str_toInt(s48,0);
            n14:=n14+3-Random(6);
            n18:=n18+3-Random(6);
            for II := 0 to QuestActionInfo.nParam3 - 1 do
            begin
            //  s44:=Userengine.GetMonNameByRace(254);
           //   BaseObject:= UserEngine.RegenMonsterByName(s34, n14, n18,s44);
           //   if Baseobject=nil then continue;
          //   BaseObject:=UserEngine.AddBaseObject(s34,n14,n18,255,QuestActionInfo.sParam4);
              BaseObject:=TEvilMonSter.Create;
              BaseObject.m_PEnvir:= g_MapManager.FindMap(s34);
             if  BaseObject.m_PEnvir=nil then continue;
              TEvilMonster(BaseObject).clone(User);
              BaseObject.m_btGender:=User.m_btGender;
              BaseObject.m_btRaceServer:=254;
              BaseObject.m_btRaceImg:=255;
              BaseObject.m_sMapName := s34;
              BaseObject.m_btHair:=User.m_btHair;
              BaseObject.m_nCurrX := n14;
              BaseObject.m_nCurrY := n18;
              BaseObject.m_btDirection := Random(8);
              BaseObject.m_sCharName :=QuestActionInfo.sParam4;
              BaseObject.m_WAbil := User.m_Abil;
              BaseObject.m_wAbil.HP:=BaseObject.m_WAbil.MaxHP;
       if (BaseObject.m_PEnvir.m_nHeight < 250) then
      begin
        if (BaseObject.m_PEnvir.m_nHeight < 30) then
          n24 := 2
        else
          n24 := 20;
      end
      else
        n24 := 50;
          n20 := 3;
      while (True) do
      begin
        if not BaseObject.m_PEnvir.CanWalk(BaseObject.m_nCurrX, BaseObject.m_nCurrY, False) then
        begin
          if (BaseObject.m_PEnvir.m_nWidth - n24 - 1) > BaseObject.m_nCurrX then
          begin
            Inc(BaseObject.m_nCurrX, n20);
          end
          else
          begin //004ADD9D
            BaseObject.m_nCurrX := Random(BaseObject.m_PEnvir.m_nWidth div 2) + n24;
            if BaseObject.m_PEnvir.m_nHeight - n24 - 1 > BaseObject.m_nCurrY then
            begin
              Inc(BaseObject.m_nCurrY, n20);
            end
            else
            begin //004ADDBE
              BaseObject.m_nCurrY := Random(BaseObject.m_PEnvir.m_nHeight div 2) + n24;
            end;
          end;
        end
        else
        begin //004ADDC0
           BaseObject.m_PEnvir.AddToMap(BaseObject.m_nCurrX, BaseObject.m_nCurrY, OS_MOVINGOBJECT, BaseObject);
          break;
        end;
        Inc(n1C);
        if n1C >= 31 then
          break;
      end;   
//           BaseObject.m_PEnvir.AddToMap(BaseObject.m_nCurrX, BaseObject.m_nCurrY, OS_MOVINGOBJECT, BaseObject);
           n18 :=UserEngine.m_MonGenList.Count - 1;
    if n18 < 0 then
      n18 := 0;
    MonGen := UserEngine.m_MonGenList.Items[n18];
    MonGen.CertList.Add(BaseObject);
    BaseObject.m_PEnvir.AddObject(1);
    BaseObject.m_boAddToMaped := True;

             
            end;


          

          end;
      end; //case
      except
            MainOutMessage('Npc ActionLable Error '+Inttostr(QuestActionInfo.nCmdCode));
      end;
   finally
      PlayObject:=OldPlayObject;
     dispose(QuestActionInfo);
   end;
    end; //for
  end; //procedure
  function FormatNPCSay(sMsg:string):String;
  begin
    Result:='';
    
  end;
  procedure SendMerChantSayMsg(sMsg: string; boFlag, m_bocallboard: Boolean; npctype: integer); //0049E3E0
  var
    s10, s14: string;
    nC: Integer;
    ntype: integer;
    s1, s2, s3, s4, s5: string;
    nCheckcode: integer;
  begin
    try
      s14 := sMsg;
      nC := 0;
      ntype := 0;
      nCheckcode := 0;
      while (True) do
      begin
        if TagCount(s14, '>') < 1 then
          break;
        s14 := ArrestStringEx(s14, '<$', '>', s10);
        if (s10 <> '')  then
        Begin
         // s10:='$'+s10;
          GetVariableText(PlayObject, sMsg, s10); // #say 信息中替换变量值
        end;
        Inc(nC);
        if nC >= 101 then
          break;
      end;
      //变量变色
     sMsg:=AnsiReplaceText(sMsg, '{', '<');
     sMsg:=AnsiReplaceText(sMsg, '}', '>');
     if Pos(#13,sMsg)>0 then
          sMsg:=StringReplace( sMsg, Chr(13) + Chr(10), '\', [rfReplaceAll]);


      nCheckcode := 1;
      //发送公告
      if not PlayObject.m_boLoginNoticeOK then
      begin
        PlayObject.SendDefMessage(SM_SENDNOTICE, Integer(PlayObject),257 , 38, 0, sMsg);
        Exit;
      end;


      PlayObject.GetScriptLabel(sMsg);
      if (npctype = 1) and m_bocallboard then
      begin //公告NPC的左边信息
        PlayObject.GetScriptLabelleft(sMsg); //把左边跳转LABEL 加入
      end;
      nCheckcode := 2;
      if self.byistopnpc in [1..7] then
      begin
        s1 := topnpcarr[self.byistopnpc].sname;
        s2 := topnpcarr[self.byistopnpc].sguildname;
        s3 := topnpcarr[self.byistopnpc].slevel;
        s4 := topnpcarr[self.byistopnpc].sdate;
        s5 := topnpcarr[self.byistopnpc].job;
        if s1 = '' then
          s1 := '无';
        if s2 = '' then
          s2 := '无';
        if s3 = '' then
          s3 := '无';
        if s4 = '' then
          s4 := '未知';
        if s5 = '' then
          s5 := '未知';

        sMsg := AnsiReplaceText(sMsg, '<$TOPNAME>', s1);
        sMsg := AnsiReplaceText(sMsg, '<$TOPGUILDNAME>', s2);
        sMsg := AnsiReplaceText(sMsg, '<$TOPLEVEL>', s3);
        sMsg := AnsiReplaceText(sMsg, '<$TOPDATE>', s4);
        sMsg := AnsiReplaceText(sMsg, '<$TOPJOB>', s5);
      end;
      if m_boGuildTower then
      begin
         PlayObject.SendDefMessage(SM_MERCHANTSAY, Integer(Self), 80, m_nFlashValue, 1, '/'+ sMsg); //0   1
         exit;
      end;
      //如果是旗座
      if m_boQiZuo  then
      Begin
       PlayObject.SendDefMessage(SM_LAMPCHANGEDURA,integer(self),length(sMsg),0,1,sMsg);
       exit;
      End;

      nCheckcode := 3;
      if (m_nType=80)or(m_nType=34) then //封元守卫
      ntype:=m_nType;
      nCheckcode := 4;
      if m_boCallHero then
      begin
        PlayObject.SendFirstMsg(Self, RM_MERCHANTSAY, 0, 80, 0,m_nFlashValue,  m_sCharName + '/' + sMsg); //0   1
      end;
     // if npctype = 1 then
      begin //普通NPC 只有左边
        if m_bocallboard then
        begin

          ntype := 15+npcType; //如果是盛大公告类型  左边内容
        end
        else
        Begin
           if  CompareLStr(sLabel, '@mainright',10) then ntype:=m_ntype;
             
           if  CompareLStr(sLabel, '@mainleft',9) then ntype:=m_ntype+1;

        End;
        if boFlag then
        begin
          nCheckcode := 5;
          PlayObject.SendFirstMsg(Self, RM_MERCHANTSAY, 0, ntype, 0,m_nFlashValue+m_nFlag,  m_sCharName + '/' + sMsg); //0   1
          nCheckcode := 6;
        end
        else
        begin

          PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, ntype,0, m_nFlashValue+m_nFlag,  m_sCharName + '/' + sMsg);
        end;
      end; //npctype=1

    except
      on e: Exception do
      begin
        MainOutMessage(format('NPC.SendMerChantSayMsg %s %s  Check=%d', [m_sCharName, sMsg, nCheckcode]));
        MainOutMessage(E.Message);
        raise;

      end;

    end;



  end;
begin //0049E584
  Result:=False;
  if PlayObject = nil then
    exit;
  if PlayObject.m_btRaceServer <> RC_PLAYOBJECT then
    exit;

  if (PlayObject.sYsnameMaster <> '') then
  begin
    if (CompareText(sLabel,'@Initialize')=0)or (CompareText(sLabel, '@yslogin') = 0) or (pos('@STDMODEFUNC', UpperCase(sLabel)) > 0) then
    else
    begin
      if not PlayObject.bocanhcall then
        exit; //如果是元神就不执行脚本
    end;
  end;

  try
    Script := nil;
    List1C := TStringList.Create;
    n18 := 1000;
    n20 := 0;
    if PlayObject.m_NPC <> Self then
    begin
      PlayObject.m_NPC := nil;
      PlayObject.m_Script := nil;
      FillChar(PlayObject.m_nVal, SizeOf(PlayObject.m_nVal), #0);
    end;
    nCheckcode := 0;
    slabel := uppercase(slabel);
    s1 := GetValidStr3(sLabel, sc , ['&']);
    n20:=0;
    sLabel :=sC;
    while s1<>'' do
    begin
      if n20>19 then Break;
      s1 := GetValidStr3(s1,  m_sLableParam[n20] , ['&']);
      Inc(n20);

    end;
    n20:=0;
    if CompareText(sLabel, '@main') = 0 then
    begin
      for I := 0 to m_ScriptList.Count - 1 do
      begin
        Script3C := m_ScriptList.Items[i];
        for II := 0 to Script3C.RecordList.Count - 1 do
        begin
          SayingRecord := Script3C.RecordList.Items[II];
          if CompareText(sLabel, SayingRecord.sLabel) = 0 then
          begin
            Script := Script3C;
            PlayObject.m_Script := Script;
            PlayObject.m_NPC := Self;
            break;
          end;
          if Script <> nil then
            break;
        end;
      end;
    end; //0049E6CB
 ///2006.10.22
    if CompareText(sLabel, '@mainleft') = 0 then
    begin
      for I := 0 to m_ScriptList.Count - 1 do
      begin
        Script3C := m_ScriptList.Items[i];
        for II := 0 to Script3C.RecordList.Count - 1 do
        begin
          SayingRecord :=pTSayingRecord(Script3C.RecordList.Items[II]);
          if CompareText(sLabel, SayingRecord.sLabel) = 0 then
          begin
            Script := Script3C;
            PlayObject.m_Script := Script;
            PlayObject.m_NPC := Self;
            break;
          end;
          if Script <> nil then
            break;
        end;
      end;
    end;
///////////
    nCheckcode := 1;
    if (Script = nil) then
    begin
      if (PlayObject.m_Script <> nil) then
      begin
        for I := m_ScriptList.Count - 1 downto 0 do
        begin
          if m_ScriptList.Items[i] = PlayObject.m_Script then
          begin
            Script := m_ScriptList.Items[i];
          end;
        end;
      end; //0049E72F
      if (Script = nil) then
      begin
        for I := m_ScriptList.Count - 1 downto 0 do
        begin
          if CheckQuestStatus(pTScript(m_ScriptList.Items[i])) then
          begin
            Script := m_ScriptList.Items[i];
            PlayObject.m_Script := Script;
            PlayObject.m_NPC := Self;

          end;
        end;
      end;
    end; //0049E79B
    nCheckcode := 2;
  //跳转到指定示签，执行
    if (Script <> nil) then
    begin
      for II := 0 to Script.RecordList.Count - 1 do
      begin
        SayingRecord := Script.RecordList.Items[II];
        if CompareText(sLabel, SayingRecord.sLabel) = 0 then
        begin
         //跳转
        //  if boExtJmp and not SayingRecord.boExtJmp then
        //    break;
        //  if (PlayObject.sYsnameMaster<>'')and (not SayingRecord.boPNEUMA)and(not PlayObject.bocanhcall) then
        //     Break;
          m_nFlashValue:=SayingRecord.nFlash;
          Result:=True;
          sSendMsg := '';
          for III := 0 to SayingRecord.ProcedureList.Count - 1 do
          begin
            SayingProcedure := SayingRecord.ProcedureList.Items[III];
            bo11 := False;
            nCheckcode := 21;
            if QuestCheckCondition(SayingProcedure.ConditionList) then
            begin
             nCheckcode := 22;
              sSendMsg := sSendMsg + SayingProcedure.sSayMsg;
              if not QuestActionProcess(SayingProcedure.ActionList) then
                break;
              if bo11 then
              begin
                if pos('@MAINLEFT', sLabel) > 0 then
                begin
                  SendMerChantSayMsg(sSendMsg, True, m_bocallboard, 1);
                end
                else
                  SendMerChantSayMsg(sSendMsg, True, m_bocallboard, 2);
              end;
            end
            else
            begin //0049E865
              sSendMsg := sSendMsg + SayingProcedure.sElseSayMsg;
              if not QuestActionProcess(SayingProcedure.ElseActionList) then
                break;
              if bo11 then
              begin
                if pos('@MAINLEFT', sLabel) > 0 then
                begin
                  SendMerChantSayMsg(sSendMsg, True, m_bocallboard, 1);
                end
                else
                  SendMerChantSayMsg(sSendMsg, True, m_bocallboard, 2);
              end;
            end; //0049E8A2
          end; //for III := 0 to SayingRecord.List04.Count - 1 do begin
          nCheckcode := 3;
          if sSendMsg <> '' then
          begin
            if pos('@MAINLEFT', sLabel) > 0 then
            begin
              SendMerChantSayMsg(sSendMsg, True, m_bocallboard, 1);
            end
            else
              SendMerChantSayMsg(sSendMsg, True, m_bocallboard, 2);
          end;
          break;
        end; //if CompareText(sLabel,SayingRecord.s00) = 0 then begin
      end; //for II := 0 to XXXInfo.List58.Count - 1 do begin
    end; //if (XXXInfo <> nil) then begin
    List1C.Free;

  except
    on e: Exception do
    begin
      MainOutMessage(format('NPC.GotoLabel %s %S Check=%d', [m_sCharName, sLabel, nCheckcode]));
      MainOutMessage(E.Message);
      raise;
      List1C.Free;
    end;

  end;


end;

procedure TNormNpc.LoadNPCScript; //0049EAF0
var
  s08: string;
begin
  if m_boIsQuest then
  begin
    m_sPath := sNpc_def;
    s08 := m_sCharName + '-' + m_sMapName;
    FrmDB.LoadNpcScript(Self, m_sFilePath, s08);
  end
  else
  begin //0049EB8E
    m_sPath := m_sFilePath;
    FrmDB.LoadNpcScript(Self, m_sFilePath, m_sCharName);
  end;
end;

function TNormNpc.Operate(ProcessMsg: pTProcessMessage): Boolean; //0049AB64
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TNormNpc.Run; //0049ABCC
begin
  if m_Master <> nil then
    m_Master := nil; //不允许召唤为宝宝
  if m_nDelayTime>0 then
  begin
    if (GetTickCount-m_nDelayTick)>m_nDelayTime then
        MakeGhost;
  end;
  inherited;
end;

procedure TNormNpc.ScriptActionError(PlayObject: TPlayObject; sErrMsg: string;
  QuestActionInfo: pTQuestActionInfo; sCmd: string);
var
  sMsg: string;
resourcestring
  sOutMessage = '[脚本错误] %s 脚本命令:%s NPC名称:%s 地图:%s(%d:%d) 参数1:%s 参数2:%s 参数3:%s 参数4:%s 参数5:%s 参数6:%s';
begin
  sMsg := format(sOutMessage, [sErrMsg,
    sCmd,
      m_sCharName,
      m_sMapName,
      m_nCurrX,
      m_nCurrY,
      QuestActionInfo.sParam1,
      QuestActionInfo.sParam2,
      QuestActionInfo.sParam3,
      QuestActionInfo.sParam4,
      QuestActionInfo.sParam5,
      QuestActionInfo.sParam6]);
  {
  sMsg:='脚本命令:' + sCmd +
        ' NPC名称:' + m_sCharName +
        ' 地图:' + m_sMapName +
        ' 座标:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
        ' 参数1:' + QuestActionInfo.sParam1 +
        ' 参数2:' + QuestActionInfo.sParam2 +
        ' 参数3:' + QuestActionInfo.sParam3 +
        ' 参数4:' + QuestActionInfo.sParam4 +
        ' 参数5:' + QuestActionInfo.sParam5 +
        ' 参数6:' + QuestActionInfo.sParam6;
  }
  //MainOutMessage(sMsg);
end;

procedure TNormNpc.ScriptConditionError(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; sCmd: string);
var
  sMsg: string;
begin
  sMsg := 'Cmd:' + sCmd +
    ' NPC名称:' + m_sCharName +
    ' 地图:' + m_sMapName +
    ' 座标:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
    ' 参数1:' + QuestConditionInfo.sParam1 +
    ' 参数2:' + QuestConditionInfo.sParam2 +
    ' 参数3:' + QuestConditionInfo.sParam3 +
    ' 参数4:' + QuestConditionInfo.sParam4 +
    ' 参数5:' + QuestConditionInfo.sParam5;
  MainOutMessage('[脚本参数不正确] ' + sMsg);
end;

procedure TNormNpc.SendMsgToUser(PlayObject: TPlayObject; sMsg: string); //0049AD14
begin
  PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' + sMsg);
end;


function TNormNpc.sub_49ADB8(sMsg, sStr, sText: string): string; //0049ADB8
var
  n10: Integer;
  s14, s18: string;
begin
  n10 := Pos(sStr, sMsg);
  if n10 > 0 then
  begin
    s14 := Copy(sMsg, 1, n10 - 1);
    s18 := Copy(sMsg, Length(sStr) + n10, Length(sMsg));
    Result := s14 + sText + s18;
  end
  else
    Result := sMsg;
end;

procedure TNormNpc.UserSelect(PlayObject: TPlayObject; sData: string); //0049EC28
var
  sMsg, sLabel: string;
begin
  PlayObject.m_nScriptGotoCount := 0;

//==============================================
//处理脚本命令 @back 返回上级标签内容
  if (sData <> '') and (sData[1] = '@') then
  begin
    sMsg := GetValidStr3(sData, sLabel, [#13]);
    if (PlayObject.m_sScriptCurrLable <> sLabel) then
    begin
      if (sLabel <> sBACK) then
      begin
        PlayObject.m_sScriptGoBackLable := PlayObject.m_sScriptCurrLable;
        PlayObject.m_sScriptCurrLable := sLabel;
      end
      else
      begin
        if PlayObject.m_sScriptCurrLable <> '' then
        begin
          PlayObject.m_sScriptCurrLable := '';
        end
        else
        begin
          PlayObject.m_sScriptGoBackLable := '';
        end;
      end;
    end;
  end;
//==============================================
end;

procedure TNormNpc.ActionOfChangeNameColor(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nColor: Integer;
begin
  nColor := QuestActionInfo.nParam1;
  if (nColor < 0) or (nColor > 255) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGENAMECOLOR);
    exit;
  end;
  PlayObject.m_btNameColor := nColor;
  PlayObject.RefNameColor();
end;

procedure TNormNpc.ActionOfClearPassword(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sStoragePwd := '';
  PlayObject.m_boPasswordLocked := False;
end;
//RECALLMOB 怪物名称 等级 叛变时间 变色(0,1) 固定颜色(1 - 7)
//变色为0 时固定颜色才起作用

procedure TNormNpc.ActionOfRecallmob(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var

  Mon: TBaseObject;
begin
  if QuestActionInfo.nParam3 <= 1 then
  begin
    Mon := PlayObject.MakeSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, 10 * 24 * 60 * 60);
  end
  else
  begin
    Mon := PlayObject.MakeSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, QuestActionInfo.nParam3 * 60)
  end;
  if Mon <> nil then
  begin
    if (QuestActionInfo.sParam4 <> '') and (QuestActionInfo.sParam4[1] = '1') then
    begin
      Mon.m_boAutoChangeColor := True;
    end
    else
      if QuestActionInfo.nParam5 > 0 then
      begin
        Mon.m_boFixColor := True;
        Mon.m_nFixColorIdx := QuestActionInfo.nParam5 - 1;
      end;
      if QuestActionInfo.sParam5<>'' then
        Mon.m_sCharName:=QuestActionInfo.sParam5;
      //判断是否为心魔
    if Mon.m_btRaceServer>=254 then
    begin
      if QuestActionInfo.nParam3>0 then
      Begin
       Inc(PlayObject.m_nCallEvilCount);
       PlayObject.m_nZMValue:=QuestActionInfo.nParam3*1000;
      End;
    end;
  end;
end;

procedure TNormNpc.ActionOfReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nReLevel, nLevel: Integer;
  nBounsuPoint: Integer;
begin
  nReLevel := Str_ToInt(QuestActionInfo.sParam1, -1);
  nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
  nBounsuPoint := Str_ToInt(QuestActionInfo.sParam3, -1);
  if (nReLevel < 0) or (nLevel < 0) or (nBounsuPoint < 0) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RENEWLEVEL);
    exit;
  end;

  if (PlayObject.m_btReLevel + nReLevel) <= 255 then
  begin
    Inc(PlayObject.m_btReLevel, nReLevel);
    if nLevel > 0 then
      PlayObject.m_Abil.Level := nLevel;
    if g_Config.boReNewLevelClearExp then
      PlayObject.m_Abil.Exp := 0;
  //  Inc(PlayObject.m_nBonusPoint, nBounsuPoint);
    PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
    PlayObject.HasLevelUp(0);
    PlayObject.RefShowName();
  end;
end;

procedure TNormNpc.ActionOfChangeGender(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGender: Integer;
begin
  nGender := Str_ToInt(QuestActionInfo.sParam1, -1);
  if not (nGender in [0, 1]) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGENDER);
    exit;
  end;

  PlayObject.m_btGender := nGender;
  PlayObject.FeatureChanged;
end;

procedure TNormNpc.ActionOfKillSlave(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Slave: TBaseObject;
begin
  for I := 0 to PlayObject.m_SlaveList.Count - 1 do
  begin
    Slave := TBaseObject(PlayObject.m_SlaveList.Items[I]);
    Slave.m_WAbil.HP := 0;
  end;
end;

procedure TNormNpc.ActionOfKillMonExpRate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
begin
  nRate := Str_ToInt(QuestActionInfo.sParam1, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nRate < 0) or (nTime < 0) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_KILLMONEXPRATE);
    exit;
  end;

  PlayObject.m_nKillMonExpRate := nRate;
  //PlayObject.m_dwKillMonExpRateTime:=_MIN(High(Word),nTime);
  PlayObject.m_dwKillMonExpRateTime := LongWord(nTime);
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sChangeKillMonExpRateMsg, [PlayObject.m_nKillMonExpRate / 100, PlayObject.m_dwKillMonExpRateTime]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfMonGenEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMapName, sMonName: string;
  nMapX, nMapY, nRange, nCount: Integer;
  nRandX, nRandY: Integer;
begin
  sMapName := QuestActionInfo.sParam1;
  nMapX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nMapY := Str_ToInt(QuestActionInfo.sParam3, -1);
  sMonName := QuestActionInfo.sParam4;
  nRange := QuestActionInfo.nParam5;
  nCount := QuestActionInfo.nParam6;
  if (sMapName = '') or (nMapX <= 0) or (nMapY <= 0) or (sMapName = '') or (nRange <= 0) or (nCount <= 0) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MONGENEX);
    exit;
  end;
  for I := 0 to nCount - 1 do
  begin
    nRandX := Random(nRange * 2 + 1) + (nMapX - nRange);
    nRandY := Random(nRange * 2 + 1) + (nMapY - nRange);
    if UserEngine.RegenMonsterByName(sMapName, nRandX, nRandY, sMonName) = nil then
    begin
      //ScriptActionError(PlayObject,'',QuestActionInfo,sSC_MONGENEX);
      break;
    end;
  end;
end;



procedure TNormNpc.ActionOfOpenMagicBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Monster: TBaseObject;
  sMonName: string;
  nX, nY: Integer;
begin
  sMonName := QuestActionInfo.sParam1;
  if sMonName = '' then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENMAGICBOX);
    exit;
  end;
  PlayObject.GetFrontPosition(nX, nY);
  Monster := UserEngine.RegenMonsterByName(PlayObject.m_PEnvir.sMapName, nX, nY, sMonName);
  if Monster = nil then
  begin
    exit;
  end;
  Monster.Die;

end;

procedure TNormNpc.ActionOfPetZS(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
    cMethod : Char;
    nLevel  : Integer;

begin
    if QuestActionInfo.sParam1='' then  Exit;
    cMethod :=QuestActionInfo.sParam1[1];
    nLevel:=QuestActionInfo.nParam2;
    case cMethod  of
     '=':nLevel :=nLevel ;
     '+':nLevel :=nLevel +PlayObject.M_monsterZSD;
     '-':nLevel:=PlayObject.M_monsterZSD-nlevel;
    end;
    PlayObject.UPGRADEPetZS(nlevel);

end;
procedure TNormNpc.ActionOfPetLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
    cMethod : Char;
    nLevel  : Integer;
    oldLevel :Integer;
begin
    if QuestActionInfo.sParam1='' then  Exit;
    cMethod :=QuestActionInfo.sParam1[1];
    nLevel:=QuestActionInfo.nParam2;
    oldLevel :=Lobyte(PlayObject.M_monstoragelevel);
    case cMethod  of
     '=':nLevel :=nLevel ;
     '+':nLevel :=nLevel +oldLevel;
     '-':nLevel:=oldLevel-nlevel;
    end;
    PlayObject.UPGRADEPetLevel(nlevel);

end;
// 命令SETPETATTRIBUTE A B C D 调整灵兽的属性;
//  参数说明：
//  A:  灵兽石ID
//  B:  属性位置
//  C:  操作符号、五行属性类型 (+、-、=)
//  D:  操作数值
procedure TNormNpc.ActionOfPetProperty(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  UserItem : PTUserItem;
  index    : Integer;
  value   : Integer;
  Value1  : Byte;
  
  function GetValue(nPos:Integer):Integer;
  begin
    Result:=0;
    case npos of
      0:; //积累经验
      1: Result:=Useritem.AttachMagic.aaa.PetAddProperty.wCount; //幻化次数
      2: Result:=Useritem.AttachMagic.aaa.PetAddProperty.btZizhi; //资质
      3: Result:=Useritem.AttachMagic.aaa.PetAddProperty.wHp; //生命
      4: Result:=Useritem.AttachMagic.aaa.PetAddProperty.btMagic; //魔法值
      5: Result:=Useritem.AttachMagic.aaa.PetAddProperty.btANTIPOISON; //中毒躲避
      6: Result:=Useritem.AttachMagic.aaa.PetAddProperty.btMAC1 and $1f; //魔御下限
      7: Result:=Useritem.AttachMagic.aaa.PetAddProperty.btMAC2 and $1f; //魔御上限
      8: Result:=Useritem.AttachMagic.aaa.PetAddProperty.btMAGICNICETY and $1f; //魔法命中
      9: Result:=Useritem.AttachMagic.aaa.PetAddProperty.btEVADET and $1f; //躲避
      10:Result:=Useritem.AttachMagic.aaa.PetAddProperty.btAC1 and $1f; // 防御下限
      11:Result:=Useritem.AttachMagic.aaa.PetAddProperty.btAC2 and $1f; // 防御上限
      12:Result:=Useritem.AttachMagic.aaa.PetAddProperty.btANTIMAGIC and $1f ; //魔法躲避
      13:Result:=Useritem.AttachMagic.aaa.PetAddProperty.btPOISONNICETY and $1f ; //中毒命中
      14:Result:=Useritem.AttachMagic.aaa.PetAddProperty.btSAVVY; // 顿悟
      15:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btvalue1 ) and $3F; // 五行属性1(0: 金、1:木、2:土、3:水)
      16:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btvalue2 ) and $3F; // 五行属性2(0: 火、1:木、2:土、3:水)
      17:Result:=0 ; //灵兽经验
      18:; // 保留
      19:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btMAC1 shr 5) and $7; // 魔法攻击下限 最高：7
      20:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btMAC2 shr 5) and $7; // 魔法攻击上限 最高：7
      21:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btMAGICNICETY shr 5) and $7; // 道术攻击下限 最高：7
      22:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btANTIMAGIC shr 5) and $7; // 道术攻击上限 最高：7
      23:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btAC1 shr 5) and $7; // 攻击下限  最高：7
      24:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btAC2 shr 5) and $7; // 攻击上限  最高：7
      25:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btEVADET shr 5) and $7; // 命中  最高：7
      26:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btPOISONNICETY shr 5) and $3; // 幸运  最高：3
      27:Result:=(Useritem.AttachMagic.aaa.PetAddProperty.btPOISONNICETY shr 7) and $1 ; //骑战速度  最高：1
    end;
  end;
 function SetValue(nPos:Integer;nValue:Integer):Integer;
  var
    btValue:byte;
  begin
    Result:=0;
    btValue:=nValue;
    case npos of
      0:; //积累经验
      1: Useritem.AttachMagic.aaa.PetAddProperty.wCount := nValue; //幻化次数
      2:
       begin
         Useritem.AttachMagic.aaa.PetAddProperty.btZizhi := nValue; //资质
         UserItem.DuraMax:=nValue;
       end;
      3: Useritem.AttachMagic.aaa.PetAddProperty.wHp := nValue; //生命
      4: Useritem.AttachMagic.aaa.PetAddProperty.btMagic := btValue; //魔法值
      5: Useritem.AttachMagic.aaa.PetAddProperty.btANTIPOISON := btValue; //中毒躲避
      6: Useritem.AttachMagic.aaa.PetAddProperty.btMAC1  :=(Useritem.AttachMagic.aaa.PetAddProperty.btMAC1 and $E0)+ (btValue and $1f); //魔御下限
      7: Useritem.AttachMagic.aaa.PetAddProperty.btMAC2   := (Useritem.AttachMagic.aaa.PetAddProperty.btMAC2 and $E0)+ (btValue and $1f); //魔御上限
      8: Useritem.AttachMagic.aaa.PetAddProperty.btMAGICNICETY  :=(Useritem.AttachMagic.aaa.PetAddProperty.btMAGICNICETY and $E0)+ (btValue and $1f); //魔法命中
      9: Useritem.AttachMagic.aaa.PetAddProperty.btEVADET  := (Useritem.AttachMagic.aaa.PetAddProperty.btEVADET and $E0)+ (btValue and $1f); //躲避
      10:Useritem.AttachMagic.aaa.PetAddProperty.btAC1 :=(Useritem.AttachMagic.aaa.PetAddProperty.btAC1 and $E0)+ (btValue and $1f); // 防御下限
      11:Useritem.AttachMagic.aaa.PetAddProperty.btAC2  :=(Useritem.AttachMagic.aaa.PetAddProperty.btAC2 and $E0)+ (btValue and $1f); // 防御上限
      12:Useritem.AttachMagic.aaa.PetAddProperty.btANTIMAGIC  := (Useritem.AttachMagic.aaa.PetAddProperty.btANTIPOISON  and $E0)+ (btValue and $1f) ; //魔法躲避
      13:Useritem.AttachMagic.aaa.PetAddProperty.btPOISONNICETY  := (Useritem.AttachMagic.aaa.PetAddProperty.btPOISONNICETY  and $E0)+ (btValue and $1f) ; //中毒命中
      14:Useritem.AttachMagic.aaa.PetAddProperty.btSAVVY := btValue; // 顿悟
      15:Useritem.AttachMagic.aaa.PetAddProperty.btvalue1  := btValue  ; // 五行属性1(0: 金、1:木、2:土、3:水)
      16:Useritem.AttachMagic.aaa.PetAddProperty.btvalue2   := btValue ; // 五行属性2(0: 火、1:木、2:土、3:水)
      17:; //灵兽经验
      18:; // 保留
      19:Useritem.AttachMagic.aaa.PetAddProperty.btMAC1  := (Useritem.AttachMagic.aaa.PetAddProperty.btMAC1 and $1f) +((btValue and $7) shl 5); // 魔法攻击下限 最高：7
      20:Useritem.AttachMagic.aaa.PetAddProperty.btMAC2  :=  (Useritem.AttachMagic.aaa.PetAddProperty.btMAC2 and $1f) +((btValue and $7) shl 5); // 魔法攻击上限 最高：7
      21:Useritem.AttachMagic.aaa.PetAddProperty.btMAGICNICETY  := (Useritem.AttachMagic.aaa.PetAddProperty.btMAGICNICETY  and $1f) +((btValue and $7) shl 5); // 道术攻击下限 最高：7
      22:Useritem.AttachMagic.aaa.PetAddProperty.btANTIMAGIC := (Useritem.AttachMagic.aaa.PetAddProperty.btANTIMAGIC and $1f) +((btValue and $7) shl 5); // 道术攻击上限 最高：7
      23:Useritem.AttachMagic.aaa.PetAddProperty.btAC1  :=  (Useritem.AttachMagic.aaa.PetAddProperty.btAC1 and $1f) +((btValue and $7) shl 5); // 攻击下限  最高：7
      24:Useritem.AttachMagic.aaa.PetAddProperty.btAC2  :=  (Useritem.AttachMagic.aaa.PetAddProperty.btAC2 and $1f) +((btValue and $7) shl 5); // 攻击上限  最高：7
      25:Useritem.AttachMagic.aaa.PetAddProperty.btEVADET  :=  (Useritem.AttachMagic.aaa.PetAddProperty.btevadet and $1f) +((btValue and $7) shl 5); // 命中  最高：7
      26:Useritem.AttachMagic.aaa.PetAddProperty.btPOISONNICETY  := (Useritem.AttachMagic.aaa.PetAddProperty.btPOISONNICETY and $9f) +((btValue and $3) shl 5); // 幸运  最高：3
      27:Useritem.AttachMagic.aaa.PetAddProperty.btPOISONNICETY  :=  (Useritem.AttachMagic.aaa.PetAddProperty.btPOISONNICETY and $7f) +((btValue and $1) shl 7) ; //骑战速度  最高：1
    end;
  end;
begin
  Index:=QuestActionInfo.nParam1;
  UserItem:=PlayObject.GetItems(index);
  if UserItem=nil then Exit;
  if QuestActionInfo.sParam3='' then exit;
  Index:=QuestActionInfo.nParam2;
  value:=GetValue(index);
  UserItem.AttachMagic.aaa.PetAddProperty.nMakeIndex :=Useritem.MakeIndex;
  if (index <>15) and(index<>16) then
  Begin
      case QuestActionInfo.sParam3[1] of
      '+':value:=Value+QuestActionInfo.nParam4;
      '-':value:=Value-QuestActionInfo.nParam4;
      '=':value:=QuestActionInfo.nParam4;
      end;
      SetValue(index,value);
  End
  else
  Begin
     if QuestActionInfo.sParam4='' then exit;
      case QuestActionInfo.sParam4[1] of
      '+':value:=Value+QuestActionInfo.nParam5;
      '-':value:=Value-QuestActionInfo.nParam5;
      '=':value:=QuestActionInfo.nParam5 ;
      end;
      value1:=QuestActionInfo.nParam3;
      Value1:=value1 shl 6;
      value:=value+Value1;
      SetValue(index,Value);



  End;

  PlayObject.SendUpdateItem(UserItem);
end;
procedure TNormNpc.ActionOfPetExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
    cMethod : Char;
    nLevel  : Integer;

begin
    if QuestActionInfo.sParam1='' then  Exit;
    cMethod :=QuestActionInfo.sParam1[1];
    nLevel:=QuestActionInfo.nParam2;

    PlayObject.UPGRADEPetExp(nlevel,cMethod );

end;
procedure TNormNpc.ActionOfPkZone(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nX, nY: Integer;
  FireBurnEvent: TFireBurnEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  nRange, nType, nTime, nPoint: Integer;
begin


  nRange := Str_ToInt(QuestActionInfo.sParam1, -1);
  nType := Str_ToInt(QuestActionInfo.sParam2, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam3, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);
  if (nRange < 0) or (nType < 0) or (nTime < 0) or (nPoint < 0) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PKZONE);
    exit;
  end;
  {
  nMinX:=PlayObject.m_nCurrX - nRange;
  nMaxX:=PlayObject.m_nCurrX + nRange;
  nMinY:=PlayObject.m_nCurrY - nRange;
  nMaxY:=PlayObject.m_nCurrY + nRange;
  }
  nMinX := m_nCurrX - nRange;
  nMaxX := m_nCurrX + nRange;
  nMinY := m_nCurrY - nRange;
  nMaxY := m_nCurrY + nRange;
  for nX := nMinX to nMaxX do
  begin
    for nY := nMinY to nMaxY do
    begin
      if ((nX < nMaxX) and (nY = nMinY)) or
        ((nY < nMaxY) and (nX = nMinX)) or
        (nX = nMaxX) or (nY = nMaxY) then
      begin
        FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, nType, nTime * 1000, nPoint);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
    end;
  end;

end;
procedure TNormNpc.ActionOfStatusRate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate                                 : Integer;
  nTime                                 : Integer;
  nIndex                                : Integer;
begin
  nIndex := Str_ToInt(QuestActionInfo.sParam1, -1);
  nRate := Str_ToInt(QuestActionInfo.sParam2, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam3, -1);
  if (nRate < 1) or (nTime < 0) or (nIndex < 0) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_POWERRATE);
    exit;
  end;

  PlayObject.m_wPowerRate[nIndex] := nRate - 1;
  PlayObject.m_wPowerRateTick[nIndex] := GetTickCount + LongWord(nTime * 1000);
  case nIndex of
    0: PlayObject.SysMsg(format('防御力倍数:%d 时长%d秒',
      [PlayObject.m_wPowerRate[nIndex] + 1, nTime]), c_Green, t_Hint);
    1: PlayObject.SysMsg(format('魔御力倍数:%d 时长%d秒',
      [PlayObject.m_wPowerRate[nIndex] + 1, nTime]), c_Green, t_Hint);
    2: PlayObject.SysMsg(format('攻击力倍数:%d 时长%d秒',
      [PlayObject.m_wPowerRate[nIndex] + 1, nTime]), c_Green, t_Hint);
    3: PlayObject.SysMsg(format('魔法力倍数:%d 时长%d秒',
      [PlayObject.m_wPowerRate[nIndex] + 1, nTime]), c_Green, t_Hint);
    4: PlayObject.SysMsg(format('道术倍数:%d 时长%d秒',
      [PlayObject.m_wPowerRate[nIndex] + 1, nTime]), c_Green, t_Hint);
    5: PlayObject.SysMsg(format('体力值倍数:%d 时长%d秒',
      [PlayObject.m_wPowerRate[nIndex] + 1, nTime]), c_Green, t_Hint);
    6: PlayObject.SysMsg(format('魔法值倍数:%d 时长%d秒',
      [PlayObject.m_wPowerRate[nIndex] + 1, nTime]), c_Green, t_Hint);
  end;

  PlayObject.RecalcAbilitys;
  PlayObject.SendMsg(self, RM_ABILITY, 0, 0, 0, 0, '');
  //PlayObject.RefShowName;
end;
procedure TNormNpc.ActionOfPowerRate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
begin
  nRate := Str_ToInt(QuestActionInfo.sParam1, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nRate < 0) or (nTime < 0) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_POWERRATE);
    exit;
  end;

  PlayObject.m_nPowerRate := nRate;
  //PlayObject.m_dwPowerRateTime:=_MIN(High(Word),nTime);
  PlayObject.m_dwPowerRateTime := LongWord(nTime);
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sChangePowerRateMsg, [PlayObject.m_nPowerRate / 100, PlayObject.m_dwPowerRateTime]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfChangeMode(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
  boOpen: Boolean;
begin
  nMode := QuestActionInfo.nParam1;
  boOpen := Str_ToInt(QuestActionInfo.sParam2, -1) = 1;
  if nMode in [1..3] then
  begin
    case nMode of //
      1:
        begin
          PlayObject.m_boAdminMode := boOpen;
          if PlayObject.m_boAdminMode then
            PlayObject.SysMsg(sGameMasterMode, c_Green, t_Hint)
          else
            PlayObject.SysMsg(sReleaseGameMasterMode, c_Green, t_Hint);
        end;
      2:
        begin
          PlayObject.m_boSuperMan := boOpen;
          if PlayObject.m_boSuperMan then
            PlayObject.SysMsg(sSupermanMode, c_Green, t_Hint)
          else
            PlayObject.SysMsg(sReleaseSupermanMode, c_Green, t_Hint);
        end;
      3:
        begin
          PlayObject.m_boObMode := boOpen;
          if PlayObject.m_boObMode then
            PlayObject.SysMsg(sObserverMode, c_Green, t_Hint)
          else
            PlayObject.SysMsg(g_sReleaseObserverMode, c_Green, t_Hint);
        end;
    end;
  end
  else
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMODE);
  end;

end;

procedure TNormNpc.ActionOfChangePerMission(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPermission: Integer;
begin
  nPermission := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nPermission in [0..10] then
  begin
    PlayObject.m_btPermission := nPermission;
  end
  else
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEPERMISSION);
    exit;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sChangePermissionMsg, [PlayObject.m_btPermission]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfoffline(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTime,
    nPoint: integer;
  sText: string;
begin
  if not PlayObject.m_booffline then
    PlayObject.m_booffline := true;
  sText := QuestActionInfo.sParam1;
  if (sText <> '') and (sText[1] = '/') then
    sText := copy(sText, 2, length(sText) - 1); //GetValidStr3(sText,sData,['/']);
  PlayObject.m_soffline := sText;

   PlayObject.ClearStatusTime;
  nTime := str_toint(QuestActionInfo.sParam2, 5);
  nPoint := str_toint(QuestActionInfo.sParam3, 500);
  PlayObject.m_boAutoGetExpInSafeZone := true; //只能在安全区才行
  PlayObject.m_AutoGetExpEnvir := PlayObject.m_pEnvir;
  PlayObject.m_nAutoGetExpTime := nTime * 1000;
  PlayObject.m_nAutoGetExpPoint := nPoint;
  if g_Config.OffLineSuper then
    PlayObject.m_boSuperMan := True; //无敌模式

  PlayObject.SendDefMessage(SM_OUTOFCONNECTION, 0, 0, 0, 0, '');
  UserEngine.SaveHumanRcd(PlayObject);
//  RunSocket.CloseUser(PlayObject.m_nGateIdx,PlayObject.m_nSocket);
 //  PlayObject.m_boEmergencyClose:=True;
 // kick()
end;

procedure TNormNpc.ActionOfGiveItem(PlayObject: TPlayObject;
  sItemName:String;nItemCount: Integer;boDrop:Boolean=False);
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;

begin

  if (sItemName = '') or (nItemCount <= 0) then
  begin

    exit;
  end;
  if CompareText(sItemName,'武官积分')=0 then
  begin
   Inc(PlayObject.wATTACHEPOINT,nItemCount);
   Exit;
  end;
  //极品值
  if CompareText(sItemName,'极品值')=0 then
  begin
   Inc(PlayObject.m_nJpPoint,nItemCount);
   Exit;
  end;
    //声望声望极品值')=0 then
  if CompareText(sItemName,'声望')=0 then
  begin
   Inc(PlayObject.m_btCreditPoint,nItemCount);
   Exit;
  end;
  //元宝
  if CompareText(sItemName,g_Config.sGameGoldName)=0 then
  begin
   Inc(PlayObject.m_nGameGold,nItemCount);
    PlayObject.GoldChanged();
   Exit;
  end;
  if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then
  begin
    PlayObject.IncGold(nItemCount);
    PlayObject.GoldChanged();
      //0049D2FE
    if g_boGameLogGold then
      AddGameDataLog('9' + #9 +
        PlayObject.m_sMapName + #9 +
        IntToStr(PlayObject.m_nCurrX) + #9 +
        IntToStr(PlayObject.m_nCurrY) + #9 +
        PlayObject.m_sCharName + #9 +
        sSTRING_GOLDNAME + #9 +
        IntToStr(nItemCount) + #9 +
        '1' + #9 +
        m_sCharName);
    exit;
  end;
  if CompareText(sItemName, '经验') = 0 then
  begin
    PlayObject.GainExp(nItemCount);

    exit;
  end;
  if UserEngine.GetStdItemIdx(sItemName) > 0 then
  begin
//    if nItemCount > 50 then nItemCount:=50;//11.22 限制数量大小
    if not (nItemCount in [1..50]) then
      nItemCount := 1; //12.28 改上一条
    PlayObject.m_ItemList.lock;
    try
      for I := 0 to nItemCount - 1 do
      begin //nItemCount 为0时出死循环
        if (PlayObject.IsEnoughBag)and(not boDrop) then
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
            
             PlayObject.m_sparam[10]:=IntToStr(Useritem.MakeIndex);
             PlayObject.m_sparam[11]:=sItemName;
            PlayObject.m_ItemList.Add(UserItem);
            PlayObject.SendAddItem(UserItem);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          //0049D46B
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
          end
          else
            Dispose(UserItem);
        end
        else
        begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then
          begin
             PlayObject.m_sparam[10]:=IntToStr(Useritem.MakeIndex);
             PlayObject.m_sparam[11]:=sItemName;
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              PlayObject.m_nGiveItemIdx:=Useritem.MakeIndex;
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('9' + #9 +
                PlayObject.m_sMapName + #9 +
                IntToStr(PlayObject.m_nCurrX) + #9 +
                IntToStr(PlayObject.m_nCurrY) + #9 +
                PlayObject.m_sCharName + #9 +
                sItemName + #9 +
                IntToStr(UserItem.MakeIndex) + #9 +
                '1' + #9 +
                m_sCharName);
            PlayObject.DropItemDown(UserItem, 3, False, PlayObject, nil);
          end;
          Dispose(UserItem);
        end;
      end; //for
    finally
      PlayObject.m_ItemList.unlock;
    end;


  end;
end;


procedure TNormNpc.ActionOfGmExecute(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sData: string;
  btOldPermission: Byte;
  sParam1, sParam2, sParam3, sParam4, sParam5, sParam6: string;
begin
  sParam1 := QuestActionInfo.sParam1;
  sParam2 := QuestActionInfo.sParam2;
  sParam3 := QuestActionInfo.sParam3;
  sParam4 := QuestActionInfo.sParam4;
  sParam5 := QuestActionInfo.sParam5;
  sParam6 := QuestActionInfo.sParam6;
  if CompareText(sParam2, 'Self') = 0 then
    sParam2 := PlayObject.m_sCharName;

  sData := format('@%s %s %s %s %s %s', [sParam1,
    sParam2,
      sParam3,
      sParam4,
      sParam5,
      sParam6]);
  btOldPermission := PlayObject.m_btPermission;
  try
    PlayObject.m_btPermission := 10;
    PlayObject.ProcessUserLineMsg(sData);
  finally
    PlayObject.m_btPermission := btOldPermission;
  end;
end;

procedure TNormNpc.ActionOfGuildAuraePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nAuraePoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  nAuraePoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nAuraePoint < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AURAEPOINT);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    PlayObject.SysMsg(g_sScriptGuildAuraePointNoGuild, c_Red, t_Hint);
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        Guild.nAurae := nAuraePoint;
      end;
    '-':
      begin
        if Guild.nAurae >= nAuraePoint then
        begin
          Guild.nAurae := Guild.nAurae - nAuraePoint;
        end
        else
        begin
          Guild.nAurae := 0;
        end;
      end;
    '+':
      begin
        if (High(Integer) - Guild.nAurae) >= nAuraePoint then
        begin
          Guild.nAurae := Guild.nAurae + nAuraePoint;
        end
        else
        begin
          Guild.nAurae := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
  //  PlayObject.SysMsg(format(g_sScriptGuildAuraePointMsg,[Guild.nAurae]),c_Green,t_Hint);//每次增加行会经验值时都提示这个。心烦。给删了
  end;
end;

procedure TNormNpc.ActionOfGuildBuildPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  nBuildPoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  nBuildPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nBuildPoint < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BuildPoint);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    PlayObject.SysMsg(g_sScriptGuildBuildPointNoGuild, c_Red, t_Hint);
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        Guild.nBuildPoint := nBuildPoint;
      end;
    '-':
      begin
        if Guild.nBuildPoint >= nBuildPoint then
        begin
          Guild.nBuildPoint := Guild.nBuildPoint - nBuildPoint;
        end
        else
        begin
          Guild.nBuildPoint := 0;
        end;
      end;
    '+':
      begin
        if (High(Integer) - Guild.nBuildPoint) >= nBuildPoint then
        begin
          Guild.nBuildPoint := Guild.nBuildPoint + nBuildPoint;
        end
        else
        begin
          Guild.nBuildPoint := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sScriptGuildBuildPointMsg, [Guild.nBuildPoint]), c_Green, t_Hint);
  end;

end;

procedure TNormNpc.ActionOfGuildChiefItemCount(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nItemCount: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  nItemCount := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nItemCount < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GUILDCHIEFITEMCOUNT);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        Guild.nChiefItemCount := nItemCount;
      end;
    '-':
      begin
        if Guild.nChiefItemCount >= nItemCount then
        begin
          Guild.nChiefItemCount := Guild.nChiefItemCount - nItemCount;
        end
        else
        begin
          Guild.nChiefItemCount := 0;
        end;
      end;
    '+':
      begin
        if (High(Integer) - Guild.nChiefItemCount) >= nItemCount then
        begin
          Guild.nChiefItemCount := Guild.nChiefItemCount + nItemCount;
        end
        else
        begin
          Guild.nChiefItemCount := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sScriptChiefItemCountMsg, [Guild.nChiefItemCount]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfGUILDEXP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Guild:TGuild;
  cMethod:Char;

begin

  Guild:=g_GuildManager.FindGuild(QuestActionInfo.sParam1);
  if QUestActionInfo.sparam2='' then exit;
  cMethod:=QUestActionInfo.sparam2[1];
  if Guild<>nil then
  Begin
   case cMethod of
   '+':Guild.nExp:=Guild.nExp+QuestActionInfo.nParam3;
   '-':Guild.nExp:=Guild.nExp-QuestActionInfo.nParam3;
   '=':Guild.nExp:=QuestActionInfo.nParam3;
   end;
  End;
end;

procedure TNormNpc.ActionOfGuildFlourishPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  nFlourishPoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  nFlourishPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nFlourishPoint < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_FlourishPoint);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        Guild.nFlourishing := nFlourishPoint;
      end;
    '-':
      begin
        if Guild.nFlourishing >= nFlourishPoint then
        begin
          Guild.nFlourishing := Guild.nFlourishing - nFlourishPoint;
        end
        else
        begin
          Guild.nFlourishing := 0;
        end;
      end;
    '+':
      begin
        if (High(Integer) - Guild.nFlourishing) >= nFlourishPoint then
        begin
          Guild.nFlourishing := Guild.nFlourishing + nFlourishPoint;
        end
        else
        begin
          Guild.nFlourishing := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sScriptGuildFlourishPointMsg, [Guild.nFlourishing]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfGUILDGRADE(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Guild:TGuild;
  cMethod:Char;

begin

  Guild:=g_GuildManager.FindGuild(QuestActionInfo.sParam1);
  if QUestActionInfo.sparam2='' then exit;
  cMethod:=QUestActionInfo.sparam2[1];
  if Guild<>nil then
  Begin
   case cMethod of
   '+':Guild.nLevel:=Guild.nLevel+QuestActionInfo.nParam3;
   '-':Guild.nLevel:=Guild.nLevel-QuestActionInfo.nParam3;
   '=':Guild.nLevel:=QuestActionInfo.nParam3;
   end;
  End;
end;
procedure TNormNpc.ActionOfGuildMemberMaxLimit(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Guild:TGuild;
  cMethod:Char;

begin

  Guild:=g_GuildManager.FindGuild(QuestActionInfo.sParam1);
  if QUestActionInfo.sparam2='' then exit;
  cMethod:=QUestActionInfo.sparam2[1];
  if Guild<>nil then
  Begin
   case cMethod of
   '+':Guild.nMemberMaxCount:=Guild.nMemberMaxCount+QuestActionInfo.nParam3;
   '-':Guild.nMemberMaxCount:=Guild.nMemberMaxCount-QuestActionInfo.nParam3;
   '=':Guild.nMemberMaxCount:=QuestActionInfo.nParam3;
   end;
  End;
end;
procedure TNormNpc.ActionOfGuildstabilityPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

var
  nStabilityPoint: Integer;
  cMethod: Char;
  Guild: TGuild;
begin
  nStabilityPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nStabilityPoint < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_StabilityPoint);
    exit;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    PlayObject.SysMsg(g_sScriptGuildStabilityPointNoGuild, c_Red, t_Hint);
    exit;
  end;
  Guild := TGuild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        Guild.nStability := nStabilityPoint;
      end;
    '-':
      begin
        if Guild.nStability >= nStabilityPoint then
        begin
          Guild.nStability := Guild.nStability - nStabilityPoint;
        end
        else
        begin
          Guild.nStability := 0;
        end;
      end;
    '+':
      begin
        if (High(Integer) - Guild.nStability) >= nStabilityPoint then
        begin
          Guild.nStability := Guild.nStability + nStabilityPoint;
        end
        else
        begin
          Guild.nStability := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sScriptGuildStabilityPointMsg, [Guild.nStability]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfHumanHP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHP: Integer;
  cMethod: Char;
begin
  nHP := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nHP < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HUMANHP);
    exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        PlayObject.m_WAbil.HP := nHP;
      end;
    '-':
      begin
        if PlayObject.m_WAbil.HP >= nHP then
        begin
          Dec(PlayObject.m_WAbil.HP, nHP);
        end
        else
        begin
          PlayObject.m_WAbil.HP := 0;
        end;
      end;
    '+':
      begin
        Inc(PlayObject.m_WAbil.HP, nHP);
        if PlayObject.m_WAbil.HP > PlayObject.m_WAbil.MaxHP then
          PlayObject.m_WAbil.HP := PlayObject.m_WAbil.MaxHP;
      end;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sScriptChangeHumanHPMsg, [PlayObject.m_WAbil.MaxHP]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfHumanMP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMP: Integer;
  cMethod: Char;
begin
  nMP := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nMP < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HUMANMP);
    exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        PlayObject.m_WAbil.MP := nMP;
      end;
    '-':
      begin
        if PlayObject.m_WAbil.MP >= nMP then
        begin
          Dec(PlayObject.m_WAbil.MP, nMP);
        end
        else
        begin
          PlayObject.m_WAbil.MP := 0;
        end;
      end;
    '+':
      begin
        Inc(PlayObject.m_WAbil.MP, nMP);
        if PlayObject.m_WAbil.MP > PlayObject.m_WAbil.MaxMP then
          PlayObject.m_WAbil.MP := PlayObject.m_WAbil.MaxMP;
      end;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sScriptChangeHumanMPMsg, [PlayObject.m_WAbil.MaxMP]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfKick(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_boKickFlag := True;
end;

procedure TNormNpc.ActionOfKill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
begin
  nMode := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nMode in [0..3] then
  begin
    case nMode of //
      1:
        begin
          PlayObject.m_boNoItem := True;
          PlayObject.Die;
        end;
      2:
        begin
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
      3:
        begin
          PlayObject.m_boNoItem := True;
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
    else
      begin
        PlayObject.Die;
      end;
    end;
  end
  else
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_KILL);
  end;

end;

procedure TNormNpc.ActionOfBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nBonusPoint: Integer;


  cMethod: Char;
begin
  nBonusPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nBonusPoint < 0) or (nBonusPoint > 10000) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BONUSPOINT);
    exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        FillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);
        PlayObject.HasLevelUp(0);
        PlayObject.m_nBonusPoint := nBonusPoint;
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
    '-':
      begin

      end;
    '+':
      begin
        Inc(PlayObject.m_nBonusPoint, nBonusPoint);
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
  end;
end;

procedure TNormNpc.ActionOfDelMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sDearName := '';
  PlayObject.RefShowName;
end;

procedure TNormNpc.ActionOfDelMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sMasterName := '';
  PlayObject.RefShowName;
end;

procedure TNormNpc.ActionOfRestBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTotleUsePoint: Integer;
begin
  nTotleUsePoint := PlayObject.m_BonusAbil.DC +
    PlayObject.m_BonusAbil.MC +
    PlayObject.m_BonusAbil.SC +
    PlayObject.m_BonusAbil.AC +
    PlayObject.m_BonusAbil.MAC +
    PlayObject.m_BonusAbil.HP +
    PlayObject.m_BonusAbil.MP +
    PlayObject.m_BonusAbil.Hit +
    PlayObject.m_BonusAbil.Speed +
    PlayObject.m_BonusAbil.X2;
  FillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);


  Inc(PlayObject.m_nBonusPoint, nTotleUsePoint);
  PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
  PlayObject.HasLevelUp(0);
  PlayObject.SysMsg('分配点数已复位！！！', c_Red, t_Hint);
end;

procedure TNormNpc.ActionOfdelay(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  pDelayCall:pTDelayCall;
begin

  New(pDelayCall);
  pDelayCall.sLabel:= QuestActionInfo.sParam2  ;
  pDelayCall.Npc:=Self;

  if  (QuestActionInfo.sParam4<>'')or( QuestActionInfo.nCmdCode=nSC_DELAYGOTO) then
      pDelayCall.m_nDelayTime := str_toint(QuestActionInfo.sParam1, 1)
  else
     pDelayCall.m_nDelayTime := str_toint(QuestActionInfo.sParam1, 1)*1000;
  pDelayCall.m_dwnnpcdelaytick := GetTickCount;
  pDelayCall.m_nDelayCallCount:=MAX(1,QuestActionInfo.nParam3);
  PlayObject.DelayCallList.Add(pDelayCall);
end;

procedure TNormNpc.ActionOfhcall(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  human: Tplayobject;
begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') then
  begin
    human := UserEngine.GetPlayObject(QuestActionInfo.sParam1);
    if (g_ManageNPC <> nil) and (human <> nil) then
    begin
      human.bocanhcall := true;
      g_ManageNPC.GotoLable(human, QuestActionInfo.sParam2, False);
      human.bocanhcall := false;
    end;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, shcall);
end;



procedure TNormNpc.ActionRANDOMX(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  n14: integer;
  ran: integer;
begin

  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') then
  begin
     ran := random(QuestActionInfo.nParam1);
     setValValue(PlayObject,QuestActionInfo.sParam2,ran,IntToStr(ran));


  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RANDOMX);
end;

procedure TNormNpc.ActionBODYEFFECT(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

begin
  if PlayObject=nil then Exit;
  if (QuestActionInfo.sParam1 <> '') then
  begin
    PlayObject.SendRefMsg(RM_510, 0, 1, 0, str_toint(QuestActionInfo.sParam1, 0), '');
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BODYEFFECT);
end;
procedure TNormNpc.ActionDELCOMMENT(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sCharName:String;
  i:Integer;
begin
  if PlayObject=nil then Exit;
  sCharName:=PlayObject.m_scharName;
  if (QuestActionInfo.sParam1 <> '') then
  begin
    sCharName:=QuestActionInfo.sParam1;
  end ;
  for I :=m_BBsList.Count - 1 downto 0 do
  begin
    if Pos(sCharName,m_BBsList[i])=Length('yyyy年mm月dd日hh点nn分玩家 ') then
      m_BBsList.Delete(i);

  end;
end;
procedure TNormNpc.ActionMAPMOVEHUM(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  SrcEnvir, DenEnvir: TEnvirnoment;
  HumanList: TList;
  I: Integer;
  MoveHuman: TPlayObject;
  sSrcMap, sDenMap: string ;
begin
  sSrcMap:=QuestActionInfo.sParam1;
  sDenMap:=QuestActionInfo.sParam2;
  if UpperCase(sSrcMap)='SELF' then sSrcMap:=PlayObject.m_PEnvir.sMapName;
  if UpperCase(sDenMap)='SELF' then sDenMap:=PlayObject.m_PEnvir.sMapName;



  SrcEnvir := g_MapManager.FindMap(sSrcMap);
  DenEnvir := g_MapManager.FindMap(sDenMap);
  if (SrcEnvir = nil) then
  begin

    exit;
  end;
  if (DenEnvir = nil) then
  begin

    exit;
  end;

  HumanList := TList.Create;
  try
  UserEngine.GetMapRageHuman(SrcEnvir, SrcEnvir.m_nWidth div 2, SrcEnvir.m_nHeight div 2, 1000, HumanList);
  for I := 0 to HumanList.Count - 1 do
  begin
    MoveHuman := TPlayObject(HumanList.Items[I]);
    if MoveHuman <> PlayObject then
      MoveHuman.MapRandomMove(sDenMap, 0);
  end;
  finally
      HumanList.Free;
  end;

end;
procedure TNormNpc.ActionRandomGive(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sParam:string ;
  sItemName,sItemCount:String;
  nCount:Integer;
begin
  sParam:=QuestActionInfo.sParam1;
  while sParam<>'' do
  begin
      sParam := GetValidStr3(sParam, sItemName, ['|']);
      sParam := GetValidStr3(sParam, sItemcount, ['|']);
      nCount:=Str_ToInt(sItemCount ,0);
      if nCount>0 then
        ActionOfGiveItem(PlayObject,sItemName,nCount);
  end;

end;


procedure TNormNpc.ActionCreateGroupLight(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
   // human:Tplayobject;
   // nValue:integer;
  anyingEvent: TanyingEvent;
var
  Envir: TEnvirnoment;
  nx, ny: integer;
begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') and (QuestActionInfo.sParam3 <> '') and (QuestActionInfo.sParam4 <> '') then
  begin

  //  PlayObject.m_bostartanying :=true;
  //  PlayObject.m_nanyinghitx:= strtoint(QuestActionInfo.sParam1);//PlayObject.m_nCurrX;
  //  PlayObject.m_nanyinghity:= strtoint(QuestActionInfo.sParam2);//PlayObject.m_nCurrY;
   // PlayObject.m_nanyinghitedelay:=strtoint(QuestActionInfo.sParam3);
   // PlayObject.m_dwcheckanyingtick:=GetTickCount;
    nx := strtoint(QuestActionInfo.sParam2);
    ny := strtoint(QuestActionInfo.sParam3);
    Envir := g_MapManager.FindMap(QuestActionInfo.sParam1);
    if Envir = nil then
      exit;
    if m_PEnvir.GetEvent(nx, ny) = nil then
    begin
      anyingEvent := TanyingEvent.Create(Envir, nx, ny, -1, strtoint(QuestActionInfo.sParam4) * 1000, 0);
      g_EventManager.AddEvent(anyingEvent);
    end;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sCreateGroupLight);
end;

procedure TNormNpc.ActionGameOfWoool(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SysMsg('倚天网游工作室，版权所有...', c_Red, t_Hint);
end;


procedure TNormNpc.ActionREPAIRALL(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserItem: pTUserItem;
begin
  if (QuestActionInfo.sParam1 = '') then
  begin
    for I := 0 to 12 do
    begin //hint I := Low(THumItems) to High(THumItems)
      UserItem := @PlayObject.m_UseItems[i];
      if UserItem.wIndex > 0 then
      begin
        UserItem.Dura := UserItem.DuraMax;
        PlayObject.SendDefMessage(509, UserItem.MakeIndex, UserItem.Dura, UserItem.DuraMax, 0, '');
      end;
    end; //for

  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sREPAIRALL);
end;

procedure TNormNpc.ActionDECUSESTIME(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  time: integer;
begin
  if (QuestActionInfo.sParam1 <> '') then
  begin

    if PlayObject.UsesTimeItem <> nil then
    begin
      if PlayObject.UsesTimeItem.Dura >= 1 then
      begin
        time := str_toint(QuestActionInfo.sParam1, 1);
        if time > 0 then
          dec(PlayObject.UsesTimeItem.Dura, time) ;
       

        PlayObject.SendUpdateItem(PlayObject.UsesTimeItem);
      end;

      PlayObject.UsesTimeItem := nil;
    end;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sDECUSESTIME);
end;

procedure TNormNpc.ActionclearYS(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  human: Tplayobject;

begin
  if (QuestActionInfo.sParam1 = '') then
  begin
    if PlayObject.sYsname <> '' then
    begin
      human := nil;
      human := UserEngine.GetPlayObjectEx(PlayObject.sYsname);
      if human <> nil then
      begin
        PlayObject.SysMsg('请先把你的元神下线，才能清除元神！', c_Red, t_Hint);
        exit;
      end;
      if human = nil then
      begin
        PlayObject.sYsname := '';
        PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
        PlayObject.SysMsg('你的元神已经魂飞魄散 ！', c_Red, t_Hint);
      end;
    end
    else
    begin
      PlayObject.SysMsg('你还没有元神 ，不能清除元神！', c_Red, t_Hint);
    end;

  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sclearYS);
end;


procedure TNormNpc.ActionCreateYS(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var

  nValue: integer;
begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') and (QuestActionInfo.sParam3 <> '') then
  begin

  //   PlayObject.SendRefMsg(RM_SPYMOVE,makeword(PlayObject.m_btDirection,214),433, 169,makelong(m_nCurrX,m_nCurrY),'');
  //   PlayObject.SendRefMsg(RM_510,0, 1 ,0,37,'');
    if PlayObject.sYsname <> '' then
    begin
      PlayObject.SysMsg('你已经拥有元神，目前只有创建一个元神！', c_Red, t_Hint);
      exit;
    end;
    if pos('/', QuestActionInfo.sParam1) > 0 then
    begin
      PlayObject.SysMsg('请不要使用“/”符号作为元神名字！', c_Red, t_Hint);
      exit;
    end;
    if QuestActionInfo.sParam3 = '0' then
      nValue := 1
    else
      nValue := 21;
    PlayObject.m_sCheckYS:=QuestActionInfo.sParam1;
   // MainOutMessage('元神 ' +QuestActionInfo.sParam1);
    UserEngine.NewHumanYS(PlayObject, PlayObject.m_sUserID, QuestActionInfo.sParam1, nValue, strtoint(QuestActionInfo.sParam2), strtoint(QuestActionInfo.sParam3), PlayObject.m_sCharName, PlayObject.m_nSessionID);

  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sCreateYS);
end;


procedure TNormNpc.ActionFUSHEN(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);

begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') and (QuestActionInfo.nParam1 >= 197) and (QuestActionInfo.nParam1 <= 200) then
  begin

     //  PlayObject.m_wStatusArrValue[8]:=QuestActionInfo.nParam1;

    case QuestActionInfo.nParam1 of
      197:
        begin PlayObject.m_wStatusArrValue[8] := 197; //	重击
          PlayObject.SysMsg('来自上古的神魔赐予了你一股神奇的力量,你获得了重击的神力', c_Red, t_Hint);
        end;
      198:
        begin PlayObject.m_wStatusArrValue[8] := 198; //  秒杀
          PlayObject.SysMsg('来自上古的神魔赐予了你一股神奇的力量,你获得了秒杀的神力', c_Red, t_Hint);
        end;
      199:
        begin PlayObject.m_wStatusArrValue[8] := 199; //  神佑
          PlayObject.SysMsg('来自上古的神魔赐予了你一股神奇的力量,你获得了神佑的神力', c_Red, t_Hint);
          PlayObject.SysMsg('神魔的眷顾可能让你获得双倍的经验,进入炼狱更有可能获得三倍…', c_Red, t_Hint);
        end;
      200:
        begin PlayObject.m_wStatusArrValue[8] := 200; //  神御
          PlayObject.SysMsg('来自上古的神魔赐予了你一股神奇的力量,你获得了神御的神力', c_Red, t_Hint);
          PlayObject.SysMsg('被激发的神魔防御结界，将帮助你抵御怪物的攻击', c_Red, t_Hint);
        end;
    end;


    PlayObject.m_dwStatusArrTimeOutTick[8] := GetTickCount + QuestActionInfo.nParam2 * 60 * 1000; //*60
    PlayObject.SysMsg('神力将持续' + QuestActionInfo.sParam2 + '分钟…', c_Red, t_Hint);
    PlayObject.SendRefMsg(RM_MAGADDABILTY, 0, 0, 0, 0, '');
    PlayObject.SendRefMsg(RM_29, 0, QuestActionInfo.nParam2, 100, 147, '');
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sFUSHEN);
end;



procedure TNormNpc.ActionSETTIMER(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  ptimergoto: pTtimergoto;
  hum: Tplayobject;
begin
  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam2 <> '') and (QuestActionInfo.sParam3 <> '') then
  begin
    EnterCriticalSection(ProcessHTimerlistSection);
    try
      new(ptimergoto);
      ptimergoto.boActive := true;
      ptimergoto.sCharname := QuestActionInfo.sParam1;
      ptimergoto.dwEndtick := GetTickCount + QuestActionInfo.nParam2 * 1000;
      ptimergoto.sgotolabel := QuestActionInfo.sParam3;
      UserEngine.m_TimerList.Add(ptimergoto);
    finally
      LeaveCriticalSection(ProcessHTimerlistSection);
    end;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sSETTIMER);
end;

procedure TNormNpc.ActionSETOFFLINE(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_sofflinegoto := QuestActionInfo.sParam1;
end;

procedure TNormNpc.ActionUSESKILL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Monsterys: TBaseObject;
  Magic: pTMagic;
  i: integer;
begin
  Monsterys := nil;
  if (QuestActionInfo.sParam1 <> '') then
  begin
    for i := PlayObject.m_SlaveList.Count - 1 downto 0 do
    begin
      if TBaseObject(PlayObject.m_SlaveList.Items[i]).m_btRaceServer = RC_YSBJECT then
      begin

        Monsterys := TBaseObject(PlayObject.m_SlaveList.Items[i]);
        if Monsterys.m_sCharName = QuestActionInfo.sParam2 then
          break;
      end;
    end;
    if Monsterys <> nil then
    begin
      Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
      if Magic <> nil then
      begin
        if PlayObject.GetMagicInfo(Magic.wMagicID) <> nil then
        begin
          Monsterys.nskill := Magic.wMagicID;
          PlayObject.SysMsg('你的元神' + Monsterys.m_sCharName + '开始使用技能：' + QuestActionInfo.sParam1, c_Red, t_Hint);
        end
        else
          PlayObject.SysMsg('你的元神' + Monsterys.m_sCharName + '没有学习该技能', c_Red, t_Hint);
      end; //Magic <> nil
    end;





  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sUSESKILL);

end;


procedure TNormNpc.ActionCLONESELF(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Monsterys: TBaseObject;
begin
  Monsterys := nil;
  if (QuestActionInfo.sParam1 <> '') then
  begin

    Monsterys := UserEngine.RegenMonsterysByName(QuestActionInfo.sParam1, PlayObject);
    if Monsterys <> nil then
    begin
      Monsterys.m_boNoItem := true; //不会暴装备
      Monsterys.m_Master := PlayObject; //是我的宝宝
      Monsterys.m_dwMasterRoyaltyTick := GetTickCount + 240 * 60 * 60 * 1000;

      Tplayobject(Monsterys).RecalcAbilitys();
      Tplayobject(Monsterys).RecalcHitSpeed();

      PlayObject.m_SlaveList.Add(Monsterys);
      PlayObject.SendRefMsg(RM_510, 0, 1, 0, 24, '');
      Monsterys.SendRefMsg(RM_510, 0, 1, 0, 25, '');
    end;
  end
  else
    ScriptActionError(PlayObject, '', QuestActionInfo, sCLONESELF);

end;




procedure TNormNpc.ActionOfrecpos(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: integer;
  UserItem: pTUserItem;
  x, y: word;
  home: byte;
begin
  x := str_toint(QuestActionInfo.sParam2, 1);
  y := str_toint(QuestActionInfo.sParam3, 1);
  home := str_toint(QuestActionInfo.sParam1, 1);

  for I := 0 to PlayObject.m_ItemList.Count - 1 do
  begin
    UserItem := PlayObject.m_ItemList.Items[I];
    if (UserItem <> nil) and (UserItem.MakeIndex = PlayObject.m_bocheckboxitem) then
    begin
      UserItem.btValue[0] := lobyte(x);
      UserItem.btValue[1] := hibyte(x);
      UserItem.btValue[2] := lobyte(y);
      UserItem.btValue[3] := hibyte(y);
      UserItem.btValue[4] := lobyte(home + 48);
      UserItem.btValue[5] := hibyte(home + 48);
     //   PlayObject.SendDefMessage(SM_EAT_FAIL,0,0,0,0,'');
      PlayObject.SendUpdateItem(UserItem);
      PlayObject.SendUpdateItem(UserItem);
      // PlayObject.SysMsg('您的丛林豹已经精神饱满，充满了活力。',c_Red,t_Hint) ;
      break;
    end;
  end;


end;

procedure TNormNpc.ActionSETUSEITEMNAME(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

var
 // sWhere:String;
  btWhere: Byte;
  UserItem: pTUserItem;
  nLabelLen: Integer;
  sMsg: string;
  sItemNewName, sItemName: string;
  StdItem: pTStdItem;
begin

  btWhere := QuestActionInfo.nParam1;
  sItemName := QuestActionInfo.sParam2;

  if btWhere in [Low(THumanUseItems)..High(THumanUseItems)] then
  begin
    UserItem := @PlayObject.m_UseItems[btWhere];
    if UserItem.wIndex = 0 then
    begin
      sMsg := format(g_sYourUseItemIsNul, [GetUseItemName(btWhere)]);
      PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
      exit;
    end;

    if UserItem.btValue[13] = 1 then
    begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    end;

    if sItemName <> '' then
    begin
      ItemUnit.AddCustomItemName(UserItem.MakeIndex, UserItem.wIndex, sItemName);
      UserItem.btValue[13] := 1;
    end
    else
    begin
      ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      UserItem.btValue[13] := 0;
    end;
    ItemUnit.SaveCustomItemName();
    PlayObject.SendMsg(PlayObject, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
    sMsg := format(g_sYourUseItemIsCHANGENAME, [GetUseItemName(btWhere)]);
    PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
  end;

end;

procedure TNormNpc.ActionFENGHAO(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

begin
  if QuestActionInfo.sParam2<>'' then
    PlayObject.m_sfenghao := QuestActionInfo.sParam2
  else
    PlayObject.m_sfenghao:='九千九百九十九界';
  PlayObject.m_nfenghaolevel := QuestActionInfo.nParam1;
end;

procedure TNormNpc.ActionClearArrow(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

begin


  PlayObject.m_boArrow := false;
  PlayObject.m_sArrowitem := '';
  PlayObject.m_wStatusTimeArr[STATE_12] := 0;
  PlayObject.m_dwStatusArrTick[STATE_12] := GetTickCount();

  PlayObject.m_nCharStatus := PlayObject.GetCharStatus();
  PlayObject.StatusChanged();

end;

procedure TNormNpc.ActionSetArrow(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

begin


  PlayObject.m_boArrow := true;
  PlayObject.m_SArrownpcgoto := QuestActionInfo.sParam2;
  PlayObject.m_sArrowitem := QuestActionInfo.sParam3;
  PlayObject.m_nArrowtime := str_toint(QuestActionInfo.sParam4, 10) * 60 * 1000; //提醒和使用随机的间隔时间
  PlayObject.m_nArrowtick := GetTickCount();
  PlayObject.m_nArrowEattick := GetTickCount();
  PlayObject.m_SarrowTimernpc := QuestActionInfo.sParam5;
  PlayObject.m_wStatusTimeArr[STATE_12] := str_toint(QuestActionInfo.sParam1, 40) * 60 * 1000;
  PlayObject.m_dwStatusArrTick[STATE_12] := GetTickCount();
  PlayObject.m_nCharStatus := PlayObject.GetCharStatus();
  PlayObject.StatusChanged();

end;



procedure TNormNpc.ActionOfcheckitembox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  smsg: string;
begin
  PlayObject.m_nboxid := QuestActionInfo.sParam3;
  PlayObject.m_nboxbacktype :=QuestActionInfo.nParam1;
  PlayObject.m_npc1:=Self;
  if QuestActionInfo.nParam1=255 then
  begin  //拆分圣灵精华
     PlayObject.SendDefMessage(198, Integer(PlayObject),QuestActionInfo.nParam2, 0, 0,''); //弹出输入名字窗口
    exit;
  end;
  smsg := QuestActionInfo.sParam2;

  if smsg = '' then
    smsg := '请输入';
  PlayObject.SendMsg(PlayObject ,34896, 0, 0, 0, 0, sMsg); //弹出输入名字窗口

end;


procedure TNormNpc.ActionOfFEEDMON(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  i: integer;
  UserItem: pTUserItem;
  MyTime, mydate, date1, date2: TDateTime;
  tint: integer;
  wint: word;
  sPetname : String;
  montype: Integer;
begin
  tint := 0;
  wint := 0;
  if playobject.M_monitemmake = 0 then
  begin
    PlayObject.SysMsg('您还没有放出宠物，不能喂食。', c_Red, t_Hint);
    exit;
  end;
    // addvalue:=Str_ToInt(QuestActionInfo.sParam1,200);
  for I := 0 to PlayObject.m_ItemList.Count - 1 do
  begin
    UserItem := PlayObject.m_ItemList.Items[I];
    if (UserItem <> nil) and (UserItem.MakeIndex = playobject.M_monitemmake) then
    begin
      MyTime := EncodeTime(8, 00, 00, 0);
      mydate := encodedate(1970, 01, 01);
      date1 := mydate + mytime;
      mydate := date();
      mytime := time();
      date2 := mydate + mytime;
      tint := round((date2 - date1) * 86400); //一天的秒数      //开始使用时间
      copymemory(@UserItem.btValue[0], @tint, 4);
       //
      copymemory(@wint, @UserItem.btValue[6], 2);
      if UserItem.btvalue[4] < 200 then
        inc(wint, g_Config.ClbADDTrains); // 不加

      UserItem.btvalue[6] := lobyte(wint); //经验值
      UserItem.btvalue[7] := hibyte(wint);

      UserItem.btvalue[4] := wint div g_Config.ClbLevelUpTrains;
      if UserItem.btvalue[4] > 200 then
        UserItem.btvalue[4] := 200; //等级

       //
      PlayObject.SendUpdateItem(UserItem);
    montype := hibyte(PlayObject.M_monstoragelevel);
      case montype of
       0: sPetname := '丛林豹';
       1:
        begin

        sPetname := '踏云豹';
        end;
       2:sPetname := '狮魔兽';
       3:sPetname := '震天狮';
       else
         sPetname := '丛林豹';
      end;
      PlayObject.SysMsg('您的'+sPetname+'已经精神饱满，充满了活力。', c_Red, t_Hint);
      break;
    end;

  end;

end;


procedure TNormNpc.ActionOfMONSTORAGE(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  baseobject: tbaseobject;
  i: integer;
  UserItem: pTUserItem;
  pStdItem: pTStdItem;
  StdItem: TStdItem;
 
  ClientItem: TClientItem;
  DefMsg: TDefaultMessage;
  body: array[0..10000] of char;
  sSendMsg: string;
  MonPetInfo:TMonPetInfo;
  smonname: string;
begin
  MonPetInfo:=PlayObject.GetPetLevel(PlayObject.M_monitemmake);

 case MonPetInfo.montype of
   0: smonname := '丛林豹';
   1:
    begin
     if (MonPetInfo.MonColor<0) or (MonPetInfo.MonColor>2) then
       MonPetInfo.MonColor:=0;
    smonname := '踏云豹'+Inttostr(MonPetInfo.MonColor+1);
    end;
   2:smonname := '狮魔兽';
   3:smonname := '震天狮';
   else
     smonname := '丛林豹';
  end;

  if not playobject.m_bohasMONSTORAGE then
  begin //如果还没有 丛林豹
    if PlayObject.M_monstoragehuoli <= 0 then
    begin
      PlayObject.SysMsg('您的' + smonname + '已经死亡。', c_Red, t_Hint);
      PlayObject.SendDefMessage(38401, integer(PlayObject), 0, 0, 0, '');
      playobject.M_monitemmake := 0;
      PlayObject.m_PetBaseObject:=nil;
      exit;
    end;
    BaseObject := PlayObject.MakeSlave(smonname, PlayObject.M_monstoragehuoli, PlayObject.M_monstoragelevel, 10, 10 * 24 * 60 * 60);
    if BaseObject <> nil then
    begin
      PlayObject.SendDefMessage(38401, integer(PlayObject), 0, 0, 0, '');
      PlayObject.SendDefMessage(38402, integer(PlayObject), 0, 0, 0, '');
      if PlayObject.M_monstoragehuoli > 2 then
        PlayObject.SysMsg('您的' + FilterShowName(smonname) + '精神饱满。红袖处有豹粮出售。', c_Red, t_Hint)
      else
        PlayObject.SysMsg('您的' + FilterShowName(smonname) + '精神不足。红袖处有豹粮出售。', c_Red, t_Hint);

      PlayObject.SendDefMessage(38401, integer(PlayObject), 0, 0, PlayObject.m_monStoragesize, '');
      fillchar(body, sizeof(body), 0);

      Begin
         for i := 0 to PlayObject.m_monStoragelist.Count - 1 do
          begin
            fillchar(ClientItem, SizeOf(TClientItem), 0);
            UserItem := PlayObject.m_monStoragelist.Items[I];
            pStdItem := UserEngine.GetStdItem(UserItem.wIndex);
            StdItem := pStdItem^;

            ItemUnit.GetItemAddValue(UserItem, StdItem);
            ClientItem.DarkProperty:=UserItem.DarkProp;//ItemUnit.GetItemDarkProperty(UserItem.MakeIndex,UserItem.wIndex);

            ClientItem.MakeIndex := UserItem.MakeIndex;
            ClientItem.Dura := UserItem.Dura;
            ClientItem.DuraMax := UserItem.DuraMax;
            copymemory(@body[SizeOf(TClientItem) * i], @ClientItem, SizeOf(TClientItem));
          end;
          if PlayObject.m_monStoragelist.Count > 0 then
          begin
            sSendMsg := EncodeBuffer(@body, SizeOf(TClientItem) * PlayObject.m_monStoragelist.Count);
            DefMsg := MakeDefaultMsg(38402, integer(PlayObject), 0, 0, PlayObject.m_monStoragelist.Count);
            PlayObject.SendSocket(@DefMsg, sSendMsg);
          end
          else
            PlayObject.SendDefMessage(38402, integer(PlayObject), 0, 0, 0, ''); //发送宠物背包数据


      End;

    end;
  end;
  if playobject.m_bohasMONSTORAGE then
  begin //如果有丛林豹
    for i := playobject.m_SlaveList.Count - 1 downto 0 do
    begin
      if TBaseObject(playobject.m_SlaveList.Items[i]).m_sCharName = smonname then
      begin
        TBaseObject(playobject.m_SlaveList.Items[i]).MakeGhost;
        playobject.m_SlaveList.Delete(i);
        playobject.M_monitemmake := 0;
        PlayObject.m_PetBaseObject:=nil;
        break;
      end;
    end;
    PlayObject.SendDefMessage(38401, integer(PlayObject), 0, 0, 0, '');
  //   PlayObject.SendDefMessage(38402,integer(PlayObject),0,0,0,'');



  end;

  playobject.m_bohasMONSTORAGE := not playobject.m_bohasMONSTORAGE;

end;


procedure TNormNpc.ActionOfCLEARCASTLEWAR(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
  var
  CurCastle: TUserCastle;
  guild:TGuild;
  i:Integer;
begin
 try
  CurCastle:=g_CastleManager.GetCastle(QuestActionInfo.nParam1) ;
  if CurCastle<>nil then
  Begin
    CurCastle.ClearAttackerInfo;
  End;
 finally

 end;
end;

procedure TNormNpc.ActionOfCLEARCURMAPMON(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  monlist: tlist;
  i, ii: integer;
  Envir: TEnvirnoment;
  BaseObject: TBaseObject;
begin

  MonList := TList.Create;

  Envir := PlayObject.m_PEnvir;
  if (Envir <> nil) then
  begin
    UserEngine.GetMapMonster(Envir, MonList);
    for II := 0 to MonList.Count - 1 do
    begin
      BaseObject := TBaseObject(MonList.Items[II]);
      if (BaseObject <> nil) and (BaseObject.m_Master = nil) then
      begin
        BaseObject.m_boNoItem := true;
        BaseObject.MakeGhost;
      end;
    end; //for

  end; //nil

  MonList.Free;

end;

procedure TNormNpc.ActionOfUpdateTop(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  ntype, npcappr, guildname, ws: string;
  ntypenum, npcapprnum, i: integer;
  Merchant: TMerchant;
  stopstring: string;
  appr, job: integer;
  Sjob: string;
begin

  if topfile = nil then
    exit;
  ntype := QuestActionInfo.sParam1; //1男战士 2 女战士 3 男法师 4女法师 5 男道士 6 女道士   7 沙城老大
  npcappr := QuestActionInfo.sParam2;
  ntypenum := str_toint(ntype, 0);
  npcapprnum := str_toint(npcappr, 0);
  if ntypenum in [1..8] then
  begin
   //   ssex := QuestActionInfo.sParam2;
    if PlayObject.m_MyGuild <> nil then
      guildname := TGuild(PlayObject.m_MyGuild).sGuildName
    else
      guildname := '暂无';

    ws := playobject.m_sCharName + '/' + guildname + '/' + inttostr(PlayObject.m_WAbil.level) + '/' + datetostr(date);
    if ntypenum = 7 then
    begin
      job := PlayObject.m_btJob;
      case job of
        0:
          begin
            appr := 100 + PlayObject.m_btGender;
            if PlayObject.m_btGender = 0 then
              Sjob := '男战士'
            else
              Sjob := '女战士';
          end;
        1:
          begin
            appr := 104 + PlayObject.m_btGender;
            if PlayObject.m_btGender = 0 then
              Sjob := '男法师'
            else
              Sjob := '女法师';
          end;
        8:
          begin
            appr := 166 + PlayObject.Ysplayer.m_btGender;
            if PlayObject.Ysplayer.m_btGender = 0 then
              Sjob := '男战士'
            else
              Sjob := '女战士';
          end;
        2:
          begin
            appr := 102 + PlayObject.m_btGender;
            if PlayObject.m_btGender = 0 then
              Sjob := '男道士'
            else
              Sjob := '女道士';
          end;
      end;
      ws := ws + '/' + inttostr(appr) + '/' + Sjob;
      topfile.writeString('top', ntype, ws);
    end;
    if ntypenum in [1..6] then
    begin
      case ntypenum of
        1: SJOB := '男战士';
        2: Sjob := '女战士';
        3: Sjob := '男法师';
        4: Sjob := '女法师';
        5: Sjob := '男道士';
        6: Sjob := '女道士';

      end;
      appr := 0;
      ws := ws + '/' + inttostr(appr) + '/' + Sjob;
      topfile.writeString('top', ntype, ws);
    end;

 //更新TOP NPC 名字
    topnpcarr[ntypenum].sname := playobject.m_sCharName;
    topnpcarr[ntypenum].sguildname := guildname;
    topnpcarr[ntypenum].slevel := inttostr(PlayObject.m_WAbil.level);
    topnpcarr[ntypenum].sdate := datetostr(date);
    topnpcarr[ntypenum].npcappr := inttostr(appr);
    topnpcarr[ntypenum].job := Sjob;
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do
    begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[i]);
      if (merchant.byistopnpc = ntypenum) then
      begin
        GetValidStrCap(Merchant.m_sCharName, stopstring, ['\']);
        if ntypenum = 8 then
        begin
          Merchant.m_sCharName := stopstring + '\' + playobject.Ysplayer.sYsname + '\';
          Merchant.RefShowName();
        end;
        if ntypenum = 7 then
        begin
          Merchant.m_sCharName := stopstring + '\' + topnpcarr[ntypenum].sguildname + '\' + topnpcarr[ntypenum].sname + '\';
          Merchant.RefShowName();
          Merchant.m_wAppr := strtoint(topnpcarr[ntypenum].npcappr);
          Merchant.FeatureChanged;
        end
        else
        begin
          Merchant.m_sCharName := stopstring + '\' + topnpcarr[ntypenum].sname + '\';
          Merchant.RefShowName();
        end;
        break;
      end; //if (merchant.byistopnpc= ntypenum)
    end; //for


  end; //if ntypenum in[1..6]

end;


procedure TNormNpc.ActionOfuseBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
 sMeth: string;
  nIdx: integer;
  nCount:Integer;
  function GetBonusPointIdx(sName:string):Integer;
  begin
    Result:=-1;
    sName:=UpperCase(sName) ;
    if sName='DC' then
       Result:=1
    else
    if sName='MC' then
       Result:=2
    else
    if sName='SC' then
       Result:=3
    else
    if sName='AC' then
       Result:=4
    else
    if sName='MAC' then
       Result:=5
    else
    if sName='HP' then
       Result:=6
    else
    if sName='MP' then
       Result:=7
    else
    if sName='HIT' then
       Result:=8
    else
    if sName='SPD' then
       Result:=9
    else
    if sName='X2' then
       Result:=10

  end;
begin

  nIdx := GetBonusPointIdx(QuestActionInfo.sParam1);
  sMeth:=QuestActionInfo.sParam2;
   if sMeth='=' then
       PlayObject.m_BonusAbil.wValue[nIdx]:=QuestActionInfo.nParam3
   else
   if sMeth='+' then
       PlayObject.m_BonusAbil.wValue[nIdx]:=PlayObject.m_BonusAbil.wValue[nIdx]+QuestActionInfo.nParam3
   else
   if sMeth='=' then
       PlayObject.m_BonusAbil.wValue[nIdx]:=PlayObject.m_BonusAbil.wValue[nIdx]-QuestActionInfo.nParam3;

    PlayObject.RecalcAbilitys();
    PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
    PlayObject.SendMsg(PlayObject, RM_SUBABILITY, 0, 0, 0, 0, '');



end;




procedure TNormNpc.ActionOfRestReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_btReLevel := 0;
  PlayObject.HasLevelUp(0);
end;

procedure TNormNpc.ActionOfSendComment(PlayObject: TPlayObject);
var
 sMsg:string;
 i   :Integer;
 nCount:Word;
begin
   sMsg:=#0;
 for I := 0 to m_BBsList.Count - 1 do
    sMsg:=sMsg+m_BbsList[i]+#0;
 nCount:=m_BBsList.Count;
 sMsg:=Chr(lobyte(nCount))+Chr(Hibyte(nCount))+sMsg;
 sMsg:=m_sComments+#0+sMsg;
 PlayObject.SendDefMessage(SM_LAMPCHANGEDURA,integer(self),length(sMsg),0,1,sMsg);

end;

procedure TNormNpc.ActionOfSetAdditionalAbil(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
   nPos    :  Integer;
   btValue :  Byte;
   cMethod :  Char;

   procedure setvalue(Value:Byte);
   begin
   case nPos of
      0..7:PlayObject.btAdditionalAbil[nPos]:=Value;
      8:PlayObject.btAdditionalAbil[8]:=(PlayObject.btAdditionalAbil[8] and $0F)+(Value and $F) shl 4;
      9:PlayObject.btAdditionalAbil[8]:=(PlayObject.btAdditionalAbil[8] and $F0)+(Value and $F);
      10:PlayObject.btAdditionalAbil[13]:=(PlayObject.btAdditionalAbil[13] and $0F)+(Value and $F) shl 4;
      11:PlayObject.btAdditionalAbil[13]:=(PlayObject.btAdditionalAbil[13] and $F0)+(Value and $F);
      12:PlayObject.btAdditionalAbil[14]:=(PlayObject.btAdditionalAbil[14] and $0F)+(Value and $F) shl 4;
      13:PlayObject.btAdditionalAbil[14]:=(PlayObject.btAdditionalAbil[14] and $F0)+(Value and $F);
      14:PlayObject.btAdditionalAbil[9]:=(PlayObject.btAdditionalAbil[9] and $0F)+(Value and $F) shl 4;
      15:PlayObject.btAdditionalAbil[9]:=(PlayObject.btAdditionalAbil[9] and $F0)+(Value and $F);
      16:PlayObject.btAdditionalAbil[10]:=(PlayObject.btAdditionalAbil[10] and $0F)+(Value and $F) shl 4;
      17:PlayObject.btAdditionalAbil[10]:=(PlayObject.btAdditionalAbil[10] and $F0)+(Value and $F);
      18:PlayObject.btAdditionalAbil[11]:=Value;
      19:PlayObject.btAdditionalAbil[12]:=(PlayObject.btAdditionalAbil[12] and $0F)+(Value and $F) shl 4;
      20:PlayObject.btAdditionalAbil[12]:=(PlayObject.btAdditionalAbil[12] and $F0)+(Value and $F);

     end;
   end;
begin
   nPos:=QuestActionInfo.nParam1;
   if (nPos<0)or(nPos>20) then
   begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSetAdditionalAbil);
    exit;

  end;
  if QuestActionInfo.sParam2='' then
   begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSetAdditionalAbil);
    exit;

  end;
  btValue:=PlayObject.GetADDITIONALABIL(nPos);
  cMethod:=QuestActionInfo.sParam2[1];
  case cMethod of
   '+':btValue:=btValue+QuestActionInfo.nParam3;
   '-':
   Begin
     if QuestActionInfo.nParam3>btValue then
        btValue:=0
     else
        btValue:=btValue-QuestActionInfo.nParam3;

   End;
   '=':btValue:=QuestActionInfo.nParam3;
  end;
  setvalue(btValue);
  PlayObject.SendYuanYingInfo;

end;
procedure TNormNpc.ActionOfGemCount(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
   UserItem:PTUserItem;
   sItemName:String;
   i,Count:Integer;
begin
          if QuestActionInfo.sParam2='+' then
             PlayObject.wGEMCOUNT[QuestActionInfo.nParam1 mod 3]:= PlayObject.wGEMCOUNT[QuestActionInfo.nParam1 mod 3]+ QuestActionInfo.nParam3;
          if QuestActionInfo.sParam2='-' then
          begin
            if PlayObject.wGEMCOUNT[QuestActionInfo.nParam1 mod 3] >=QuestActionInfo.nParam3 then
                PlayObject.wGEMCOUNT[QuestActionInfo.nParam1 mod 3]:= PlayObject.wGEMCOUNT[QuestActionInfo.nParam1 mod 3]- QuestActionInfo.nParam3
            else
            begin
               Count:= QuestActionInfo.nParam3-PlayObject.wGEMCOUNT[QuestActionInfo.nParam1 mod 3];
               PlayObject.wGEMCOUNT[QuestActionInfo.nParam1 mod 3]:=0;
               case QuestActionInfo.nParam1 of
                 0:sItemName:='红宝石';
                 1:sItemName:='蓝宝石';
                 2:sItemName:='绿宝石';
               end;

               for I := 0 to Count - 1 do
               begin
                 UserItem:=PlayObject.GetItemByName(sItemName);
                 if UserItem<>nil then
                   PlayObject.DelItem(UserItem);
               end;

            end;
          end;
          if QuestActionInfo.sParam2='=' then
             PlayObject.wGEMCOUNT[QuestActionInfo.nParam1 mod 3]:= QuestActionInfo.nParam3;

end;
procedure TNormNpc.ActionOfSetMapMode(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Envir: TEnvirnoment;
  sMapName: string;
  sMapMode, sParam1, sParam2 {,sParam3,sParam4}: string;
begin
  sMapName := QuestActionInfo.sParam1;
  sMapMode := QuestActionInfo.sParam2;
  sParam1 := QuestActionInfo.sParam3;
  sParam2 := QuestActionInfo.sParam4;
//  sParam3:=QuestActionInfo.sParam5;
//  sParam4:=QuestActionInfo.sParam6;

  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (sMapMode = '') then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMAPMODE);
    exit;
  end;
  if CompareText(sMapMode, 'SAFE') = 0 then
  begin
    if (sParam1 <> '') then
    begin
      Envir.m_boSAFE := True;
    end
    else
    begin
      Envir.m_boSAFE := False;
    end;
  end
  else
    if CompareText(sMapMode, 'DARK') = 0 then
    begin
      if (sParam1 <> '') then
      begin
        Envir.m_boDARK := True;
      end
      else
      begin
        Envir.m_boDARK := False;
      end;
    end
    else
      if CompareText(sMapMode, 'DARK') = 0 then
      begin
        if (sParam1 <> '') then
        begin
          Envir.m_boDARK := True;
        end
        else
        begin
          Envir.m_boDARK := False;
        end;
      end
      else
        if CompareText(sMapMode, 'FIGHT') = 0 then
        begin
          if (sParam1 <> '') then
          begin
            Envir.m_boFightZone := True;
          end
          else
          begin
            Envir.m_boFightZone := False;
          end;
        end
        else
          if CompareText(sMapMode, 'FIGHT3') = 0 then
          begin
            if (sParam1 <> '') then
            begin
              Envir.m_boFight3Zone := True;
            end
            else
            begin
              Envir.m_boFight3Zone := False;
            end;
          end
          else
            if CompareText(sMapMode, 'DAY') = 0 then
            begin
              if (sParam1 <> '') then
              begin
                Envir.m_boDAY := True;
              end
              else
              begin
                Envir.m_boDAY := False;
              end;
            end
            else
              if CompareText(sMapMode, 'QUIZ') = 0 then
              begin
                if (sParam1 <> '') then
                begin
                  Envir.m_boQUIZ := True;
                end
                else
                begin
                  Envir.m_boQUIZ := False;
                end;
              end
              else
                if CompareText(sMapMode, 'NORECONNECT') = 0 then
                begin
                  if (sParam1 <> '') then
                  begin
                    Envir.m_boNORECONNECT := True;
                    Envir.sNoReconnectMap := sParam1;
                  end
                  else
                  begin
                    Envir.m_boNORECONNECT := False;
                  end;
                end
                else
                  if CompareText(sMapMode, 'MUSIC') = 0 then
                  begin
                    if (sParam1 <> '') then
                    begin
                      Envir.m_boMUSIC := True;
                      Envir.m_nMUSICID := Str_ToInt(sParam1, -1);
                    end
                    else
                    begin
                      Envir.m_boMUSIC := False;
                    end;
                  end
                  else
                    if CompareText(sMapMode, 'EXPRATE') = 0 then
                    begin
                      if (sParam1 <> '') then
                      begin
                        Envir.m_boEXPRATE := True;
                        Envir.m_nEXPRATE := Str_ToInt(sParam1, -1);
                      end
                      else
                      begin
                        Envir.m_boEXPRATE := False;
                      end;
                    end
                    else
                      if CompareText(sMapMode, 'PKWINLEVEL') = 0 then
                      begin
                        if (sParam1 <> '') then
                        begin
                          Envir.m_boPKWINLEVEL := True;
                          Envir.m_nPKWINLEVEL := Str_ToInt(sParam1, -1);
                        end
                        else
                        begin
                          Envir.m_boPKWINLEVEL := False;
                        end;
                      end
                      else
                        if CompareText(sMapMode, 'PKWINEXP') = 0 then
                        begin
                          if (sParam1 <> '') then
                          begin
                            Envir.m_boPKWINEXP := True;
                            Envir.m_nPKWINEXP := Str_ToInt(sParam1, -1);
                          end
                          else
                          begin
                            Envir.m_boPKWINEXP := False;
                          end;
                        end
                        else
                          if CompareText(sMapMode, 'PKLOSTLEVEL') = 0 then
                          begin
                            if (sParam1 <> '') then
                            begin
                              Envir.m_boPKLOSTLEVEL := True;
                              Envir.m_nPKLOSTLEVEL := Str_ToInt(sParam1, -1);
                            end
                            else
                            begin
                              Envir.m_boPKLOSTLEVEL := False;
                            end;
                          end
                          else
                            if CompareText(sMapMode, 'PKLOSTEXP') = 0 then
                            begin
                              if (sParam1 <> '') then
                              begin
                                Envir.m_boPKLOSTEXP := True;
                                Envir.m_nPKLOSTEXP := Str_ToInt(sParam1, -1);
                              end
                              else
                              begin
                                Envir.m_boPKLOSTEXP := False;
                              end;
                            end
                            else
                              if CompareText(sMapMode, 'DECHP') = 0 then
                              begin
                                if (sParam1 <> '') and (sParam2 <> '') then
                                begin
                                  Envir.m_boDECHP := True;
                                  Envir.m_nDECHPTIME := Str_ToInt(sParam1, -1);
                                  Envir.m_nDECHPPOINT := Str_ToInt(sParam2, -1);
                                end
                                else
                                begin
                                  Envir.m_boDECHP := False;
                                end;
                              end
                              else
                                if CompareText(sMapMode, 'DECGAMEGOLD') = 0 then
                                begin
                                  if (sParam1 <> '') and (sParam2 <> '') then
                                  begin
                                    Envir.m_boDECGAMEGOLD := True;
                                    Envir.m_nDECGAMEGOLDTIME := Str_ToInt(sParam1, -1);
                                    Envir.m_nDECGAMEGOLD := Str_ToInt(sParam2, -1);
                                  end
                                  else
                                  begin
                                    Envir.m_boDECGAMEGOLD := False;
                                  end;
                                end
                                else
                                  if CompareText(sMapMode, 'RUNHUMAN') = 0 then
                                  begin
                                    if (sParam1 <> '') then
                                    begin
                                      Envir.m_boRUNHUMAN := True;
                                    end
                                    else
                                    begin
                                      Envir.m_boRUNHUMAN := False;
                                    end;
                                  end
                                  else
                                    if CompareText(sMapMode, 'RUNMON') = 0 then
                                    begin
                                      if (sParam1 <> '') then
                                      begin
                                        Envir.m_boRUNMON := True;
                                      end
                                      else
                                      begin
                                        Envir.m_boRUNMON := False;
                                      end;
                                    end
                                    else
                                      if CompareText(sMapMode, 'NEEDHOLE') = 0 then
                                      begin
                                        if (sParam1 <> '') then
                                        begin
                                          Envir.m_boNEEDHOLE := True;
                                        end
                                        else
                                        begin
                                          Envir.m_boNEEDHOLE := False;
                                        end;
                                      end
                                      else
                                        if CompareText(sMapMode, 'NORECALL') = 0 then
                                        begin
                                          if (sParam1 <> '') then
                                          begin
                                            Envir.m_boNORECALL := True;
                                          end
                                          else
                                          begin
                                            Envir.m_boNORECALL := False;
                                          end;
                                        end
                                        else
                                          if CompareText(sMapMode, 'NOGUILDRECALL') = 0 then
                                          begin
                                            if (sParam1 <> '') then
                                            begin
                                              Envir.m_boNOGUILDRECALL := True;
                                            end
                                            else
                                            begin
                                              Envir.m_boNOGUILDRECALL := False;
                                            end;
                                          end
                                          else
                                            if CompareText(sMapMode, 'NODEARRECALL') = 0 then
                                            begin
                                              if (sParam1 <> '') then
                                              begin
                                                Envir.m_boNODEARRECALL := True;
                                              end
                                              else
                                              begin
                                                Envir.m_boNODEARRECALL := False;
                                              end;
                                            end
                                            else
                                              if CompareText(sMapMode, 'NOMASTERRECALL') = 0 then
                                              begin
                                                if (sParam1 <> '') then
                                                begin
                                                  Envir.m_boNOMASTERRECALL := True;
                                                end
                                                else
                                                begin
                                                  Envir.m_boNOMASTERRECALL := False;
                                                end;
                                              end
                                              else
                                                if CompareText(sMapMode, 'NORANDOMMOVE') = 0 then
                                                begin
                                                  if (sParam1 <> '') then
                                                  begin
                                                    Envir.m_boNORANDOMMOVE := True;
                                                  end
                                                  else
                                                  begin
                                                    Envir.m_boNORANDOMMOVE := False;
                                                  end;
                                                end
                                                else
                                                  if CompareText(sMapMode, 'NODRUG') = 0 then
                                                  begin
                                                    if (sParam1 <> '') then
                                                    begin
                                                      Envir.m_boNODRUG := True;
                                                    end
                                                    else
                                                    begin
                                                      Envir.m_boNODRUG := False;
                                                    end;
                                                  end
                                                  else
                                                    if CompareText(sMapMode, 'MINE') = 0 then
                                                    begin
                                                      if (sParam1 <> '') then
                                                      begin
                                                        Envir.m_boMINE := True;
                                                      end
                                                      else
                                                      begin
                                                        Envir.m_boMINE := False;
                                                      end;
                                                    end
                                                    else
                                                      if CompareText(sMapMode, 'NOPOSITIONMOVE') = 0 then
                                                      begin
                                                        if (sParam1 <> '') then
                                                        begin
                                                          Envir.m_boNOPOSITIONMOVE := True;
                                                        end
                                                        else
                                                        begin
                                                          Envir.m_boNOPOSITIONMOVE := False;
                                                        end;
                                                      end;
end;

procedure TNormNpc.ActionOfSetMemberLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nLevel: Integer;
  cMethod: Char;
begin
  nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nLevel < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERLEVEL);
    exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        PlayObject.m_nMemberLevel := nLevel;
      end;
    '-':
      begin
        Dec(PlayObject.m_nMemberLevel, nLevel);
        if PlayObject.m_nMemberLevel < 0 then
          PlayObject.m_nMemberLevel := 0;
      end;
    '+':
      begin
        Inc(PlayObject.m_nMemberLevel, nLevel);
        if PlayObject.m_nMemberLevel > 65535 then
          PlayObject.m_nMemberLevel := 65535;
      end;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sChangeMemberLevelMsg, [PlayObject.m_nMemberLevel]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionOfSetMemberType(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nType: Integer;
  cMethod: Char;
begin
  nType := Str_ToInt(QuestActionInfo.sParam2, -1);
  if nType < 0 then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERTYPE);
    exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=':
      begin
        PlayObject.m_nMemberType := nType;
      end;
    '-':
      begin
        Dec(PlayObject.m_nMemberType, nType);
        if PlayObject.m_nMemberType < 0 then
          PlayObject.m_nMemberType := 0;
      end;
    '+':
      begin
        Inc(PlayObject.m_nMemberType, nType);
        if PlayObject.m_nMemberType > 65535 then
          PlayObject.m_nMemberType := 65535;
      end;
  end;
  if g_Config.boShowScriptActionMsg then
  begin
    PlayObject.SysMsg(format(g_sChangeMemberTypeMsg, [PlayObject.m_nMemberType]), c_Green, t_Hint);
  end;
end;

procedure TNormNpc.ActionofSetNpcName(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Npc : TMerchant;
begin
  Npc:=UserEngine.FindMerchant(QuestActionInfo.nParam1);
  if Npc<>nil then
  begin
    Npc.m_sCharName:=QuestActionInfo.sParam2;
    Npc.RefShowName;
  end;

end;
procedure TNormNpc.ActionofPlayDefence(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
   case QuestActionInfo.nParam1 of
    2:  PlayObject.SendDefMessage(3046,MakeLong(QuestActionInfo.nParam3,QuestActionInfo.nParam2),loword(QuestActionInfo.nParam4),HiWord(QuestActionInfo.nParam4),2,'');
    3: PlayObject.SendDefMessage(3046,QuestActionInfo.nParam3,QuestActionInfo.nParam2,0,3,'');
    4: PlayObject.SendDefMessage(3046,0,QuestActionInfo.nParam2,0,4,'');
    5: PlayObject.SendMsg(Self,RM_3046,0,QuestActionInfo.nParam2,0,5,'');
    6:
    begin
       PlayObject.MakeSlave(QuestActionInfo.sParam2, 3, 0, 100, 10 * 24 * 60 * 60,QuestActionInfo.nParam3,QuestActionInfo.nParam4);
       PlayObject.SendDefMessage(3046,Integer(PlayObject),QuestActionInfo.nParam3,QuestActionInfo.nParam4,6,'');
    end;
   end;
end;
procedure TNormNpc.ActionofSetNpcAPPR(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Merchant : TMerchant;
begin
  Merchant:=UserEngine.FindMerchant(QuestActionInfo.nParam1);
  if Merchant<>nil then
  begin
        Merchant.m_wappr:=QuestActionInfo.nParam2;

        Merchant.RefShowName;
        Merchant.FeatureChanged;
        Merchant.SearchViewRange;
  end;

end;
function TNormNpc.ConditionOfCheckGuildList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
end;


function TNormNpc.conditionofCheckGuildMemberCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Guild : TGuild;
  cMethod : Char;
begin
  Result:=False;
  Guild:=g_GuildManager.FindGuild(QuestConditionInfo.sParam1);
  if Guild=nil then
    exit;
  if QuestConditionInfo.sParam2='' then Exit;

  cMethod:=QuestConditionInfo.sParam2[1];

  case cMethod of
  '>' : Result:=Guild.Count> QuestConditionInfo.nParam3;
  '<' : Result:=Guild.Count< QuestConditionInfo.nParam3;
  '=' : Result:=Guild.Count= QuestConditionInfo.nParam3;
  '\' : Result:=Guild.Count>= QuestConditionInfo.nParam3;

  end;




end;

function TNormNpc.conditionofCheckGuildMemberMaxLimit(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Guild : TGuild;
  cMethod : Char;
begin
  Result:=False;
  Guild:=g_GuildManager.FindGuild(QuestConditionInfo.sParam1);
  if Guild=nil then
    exit;
  if QuestConditionInfo.sParam2='' then Exit;

  cMethod:=QuestConditionInfo.sParam2[1];

  case cMethod of
  '>' : Result:=Guild.nLevel> QuestConditionInfo.nParam3;
  '<' : Result:=Guild.nLevel< QuestConditionInfo.nParam3;
  '=' : Result:=Guild.nLevel= QuestConditionInfo.nParam3;
  '\' : Result:=Guild.nLevel>= QuestConditionInfo.nParam3;

  end;




end;

function TNormNpc.ConditionOfCheckRangeMonCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sMapName: string;
  nX, nY, nRange, nCount: Integer;
  cMethod: Char;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
  nRange := _min(nRange, 500);
  if QuestConditionInfo.sParam5<>'' then
  cMethod := QuestConditionInfo.sParam5[1];
  nCount := Str_ToInt(QuestConditionInfo.sParam6, -1);
  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (nX < 0) or (nY < 0) or (nRange < 0) or (nCount < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKRANGEMONCOUNT);
    exit;
  end;
  MonList := TList.Create;
  nMapRangeCount := Envir.GetRangeBaseObject(nX, nY, nRange, True, MonList);
  for I := MonList.Count - 1 downto 0 do
  begin
    BaseObject := TBaseObject(MonList.Items[I]);
    if (BaseObject.m_btRaceServer < RC_ANIMAL) or (BaseObject.m_btRaceServer = RC_ARCHERGUARD) or (BaseObject.m_Master <> nil) then
      MonList.Delete(I);
  end;
  nMapRangeCount := MonList.Count;
  case cMethod of
    '=':
      if nMapRangeCount = nCount then
        Result := True;
    '>':
      if nMapRangeCount > nCount then
        Result := True;
    '<':
      if nMapRangeCount < nCount then
        Result := True;
  else
    if nMapRangeCount >= nCount then
      Result := True;
  end;
  MonList.Free;
end;

function TNormNpc.ConditionOfCheckReNewLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
    exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_btReLevel = nLevel then
        Result := True;
    '>':
      if PlayObject.m_btReLevel > nLevel then
        Result := True;
    '<':
      if PlayObject.m_btReLevel < nLevel then
        Result := True;
  else
    if PlayObject.m_btReLevel >= nLevel then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckSlaveLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  nLevel: Integer;
  cMethod: Char;
  BaseObject: TBaseObject;
  nSlaveLevel: Integer;
begin
  Result := False;
  nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLevel < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
    exit;
  end;
  nSlaveLevel := -1;
  for I := 0 to PlayObject.m_SlaveList.Count - 1 do
  begin
    BaseObject := TBaseObject(PlayObject.m_SlaveList.Items[I]);
    if BaseObject.m_Abil.Level > nSlaveLevel then
      nSlaveLevel := BaseObject.m_Abil.Level;
  end;
  if nSlaveLevel < 0 then
    exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if nSlaveLevel = nLevel then
        Result := True;
    '>':
      if nSlaveLevel > nLevel then
        Result := True;
    '<':
      if nSlaveLevel < nLevel then
        Result := True;
  else
    if nSlaveLevel >= nLevel then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckUseItem(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  if (nWhere < 0) or (nWhere > High(THumanUseItems)) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKUSEITEM);
    exit;
  end;
  if PlayObject.m_UseItems[nWhere].wIndex > 0 then
    Result := True;

end;

function TNormNpc.ConditionOfCheckVar(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sType: string;
  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  Result := False;
  sType := QuestConditionInfo.sParam1;
  sVarName := QuestConditionInfo.sParam2;
  sMethod := QuestConditionInfo.sParam3;
  nVarValue := Str_ToInt(QuestConditionInfo.sParam4, 0);
  sVarValue := QuestConditionInfo.sParam4;

  if (sType = '') or (sVarName = '') or (sMethod = '') then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKVAR);
    exit;
  end;
    if QuestConditionInfo.sParam3='' then exit;
  cMethod := sMethod[1];
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then
  begin
    ScriptConditionError(PlayObject {,format(sVarTypeError,[sType])}, QuestConditionInfo, sSC_CHECKVAR);
    exit;
  end;
  for I := 0 to DynamicVarList.Count - 1 do
  begin
    DynamicVar := DynamicVarList.Items[I];
    if CompareText(DynamicVar.sName, sVarName) = 0 then
    begin
      case DynamicVar.VarType of
        vInteger:
          begin
            case cMethod of
              '=':
                if DynamicVar.nInternet = nVarValue then
                  Result := True;
              '>':
                if DynamicVar.nInternet > nVarValue then
                  Result := True;
              '<':
                if DynamicVar.nInternet < nVarValue then
                  Result := True;
            else
              if DynamicVar.nInternet >= nVarValue then
                Result := True;
            end;
          end;
        vString:
          begin
            case cMethod of
              '=':
                if DynamicVar.sString = sVarValue then
                  Result := True;
              '>':
                if pos(sVarValue, DynamicVar.sString) > 0 then
                  Result := True;
              '<':
                if pos(DynamicVar.sString, sVarValue) > 0 then
                  Result := True;
            else
              if pos(sVarValue, DynamicVar.sString) >= 0 then
                Result := True;
            end;

          end;
      end;

      boFoundVar := True;
      break;
    end;
  end;
 // if not boFoundVar then
//    ScriptConditionError(PlayObject, {format(sVarFound,[sVarName,sType]),} QuestConditionInfo, sSC_CHECKVAR);

end;

function TNormNpc.ConditionOfHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if PlayObject.m_sMasterName <> '' then
    Result := True;
end;

function TNormNpc.ConditionOfPoseHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then
  begin
    if (TPlayObject(PoseHuman).m_sMasterName <> '') then
      Result := True;
  end;
end;

procedure TNormNpc.ActionOfUnMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  LoadList: TStringList;
  sUnMarryFileName: string;
  sMsg: string;
begin
  if PlayObject.m_sMasterName = '' then
  begin
    GotoLable(PlayObject, '@ExeMasterFail', False);
    exit;
  end;
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate);
  if (PoseHuman = nil)or(PoseHuman.m_btRaceServer <> RC_PLAYOBJECT) then
  begin
    GotoLable(PlayObject, '@UnMasterCheckDir', False);
  end;
  if PoseHuman <> nil then
  begin
    if QuestActionInfo.sParam1 = '' then
    begin
      if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then
      begin
        GotoLable(PlayObject, '@UnMasterTypeErr', False);
        exit;
      end;
      if PoseHuman.GetPoseCreate = PlayObject then
      begin
        if (PlayObject.m_sMasterName = PoseHuman.m_sCharName) then
        begin
          if PlayObject.m_boMaster then
          begin
            GotoLable(PlayObject, '@UnIsMaster', False);
            exit;
          end;
          if PlayObject.m_sMasterName <> PoseHuman.m_sCharName then
          begin
            GotoLable(PlayObject, '@UnMasterError', False);
            exit;
          end;

          GotoLable(PlayObject, '@StartUnMaster', False);
          GotoLable(PoseHuman, '@WateUnMaster', False);
          exit;
        end;
      end;
    end;
  end;
  if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMASTER' {sREQUESTUNMARRY}) = 0) then
  begin
    if (QuestActionInfo.sParam2 = '') then
    begin
      if PoseHuman <> nil then
      begin
        PlayObject.m_boStartUnMaster := True;
        if PlayObject.m_boStartUnMaster and PoseHuman.m_boStartUnMaster then
        begin
          sMsg := AnsiReplaceText(g_sNPCSayUnMasterOKMsg, '%n', m_sCharName);
          sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
          sMsg := AnsiReplaceText(sMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sMsg, t_Say);
          PlayObject.m_sMasterName := '';
          PoseHuman.m_sMasterName := '';
          PlayObject.m_boStartUnMaster := False;
          PoseHuman.m_boStartUnMaster := False;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
          GotoLable(PlayObject, '@UnMasterEnd', False);
          GotoLable(PoseHuman, '@UnMasterEnd', False);
        end
        else
        begin
          GotoLable(PlayObject, '@WateUnMaster', False);
          GotoLable(PoseHuman, '@RevUnMaster', False);
        end;
      end;
      exit;
    end
    else
    begin
      //强行出师
      if (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then
      begin
        sMsg := AnsiReplaceText(g_sNPCSayForceUnMasterMsg, '%n', m_sCharName);
        sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
        sMsg := AnsiReplaceText(sMsg, '%d', PlayObject.m_sMasterName);
        UserEngine.SendBroadCastMsg(sMsg, t_Say);

        PoseHuman := UserEngine.GeTPlayObject(PlayObject.m_sMasterName);
        if PoseHuman <> nil then
        begin
          PoseHuman.m_sMasterName := '';
          PoseHuman.RefShowName;
        end
        else
        begin
          g_UnForceMasterList.Lock;
          try
            g_UnForceMasterList.Add(PlayObject.m_sMasterName);
            SaveUnForceMasterList();
          finally
            g_UnForceMasterList.UnLock;
          end;
        end;
        PlayObject.m_sMasterName := '';
        GotoLable(PlayObject, '@UnMasterEnd', False);
        PlayObject.RefShowName;
      end;
      exit;
    end;
  end;
end;


function TNormNpc.ConditionOfCheckCastleGold(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGold: Integer;
begin
  Result := False;
  nGold := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if (nGold < 0) or (m_Castle = nil) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEGOLD);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if TUserCastle(m_Castle).m_nTotalGold = nGold then
        Result := True;
    '>':
      if TUserCastle(m_Castle).m_nTotalGold > nGold then
        Result := True;
    '<':
      if TUserCastle(m_Castle).m_nTotalGold < nGold then
        Result := True;
  else
    if TUserCastle(m_Castle).m_nTotalGold >= nGold then
      Result := True;
  end;
  {
  Result:=False;
  nGold:=Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nGold < 0 then begin
    ScriptConditionError(PlayObject,QuestConditionInfo,sSC_CHECKCASTLEGOLD);
    exit;
  end;
  cMethod:=QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if UserCastle.m_nTotalGold = nGold then Result:=True;
    '>': if UserCastle.m_nTotalGold > nGold then Result:=True;
    '<': if UserCastle.m_nTotalGold < nGold then Result:=True;
    else if UserCastle.m_nTotalGold >= nGold then Result:=True;
  end;
  }
end;


function TNormNpc.ConditionOfCheckContribution(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nContribution: Integer;
  cMethod: Char;
begin
  Result := False;
  nContribution := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nContribution < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCONTRIBUTION);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_wContribution = nContribution then
        Result := True;
    '>':
      if PlayObject.m_wContribution > nContribution then
        Result := True;
    '<':
      if PlayObject.m_wContribution < nContribution then
        Result := True;
  else
    if PlayObject.m_wContribution >= nContribution then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckCreditPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCreditPoint: Integer;
  cMethod: Char;
begin
  Result := False;
  nCreditPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCreditPoint < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCREDITPOINT);
    exit;
  end;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_btCreditPoint = nCreditPoint then
        Result := True;
    '>':
      if PlayObject.m_btCreditPoint > nCreditPoint then
        Result := True;
    '<':
      if PlayObject.m_btCreditPoint < nCreditPoint then
        Result := True;
  else
    if PlayObject.m_btCreditPoint >= nCreditPoint then
      Result := True;
  end;
end;




procedure TNormNpc.ActionOfClearNeedItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nNeed: Integer;
  UserItem: pTUserItem;
  StdItem: pTStditem;
begin
  nNeed := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (nNeed < 0) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARNEEDITEMS);
    exit;
  end;
  for I := PlayObject.m_ItemList.Count - 1 downto 0 do
  begin
    UserItem := PlayObject.m_ItemList.Items[I];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and (StdItem.Need = nNeed) then
    begin
      PlayObject.SendDelItems(UserItem);
      Dispose(UserItem);
      PlayObject.m_ItemList.Delete(I);
    end;
  end;

  for I := PlayObject.m_StorageItemList.Count - 1 downto 0 do
  begin
    UserItem := PlayObject.m_StorageItemList.Items[I];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and (StdItem.Need = nNeed) then
    begin
      Dispose(UserItem);
      PlayObject.m_StorageItemList.Delete(I);
    end;
  end;
end;

procedure TNormNpc.ActionOfClearMakeItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nMakeIndex: Integer;
  sItemName: string;
  UserItem: pTUserItem;
  StdItem: pTStditem;
  boMatchName: Boolean;
begin
  sItemName := QuestActionInfo.sParam1;
  nMakeIndex := QuestActionInfo.nParam2;
  boMatchName := QuestActionInfo.sParam3 = '1';
  if (sItemName = '') or (nMakeIndex <= 0) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARMAKEITEMS);
    exit;
  end;
  for I := PlayObject.m_ItemList.Count - 1 downto 0 do
  begin
    UserItem := PlayObject.m_ItemList.Items[I];
    if UserItem.MakeIndex <> nMakeIndex then
      Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then
    begin
      PlayObject.SendDelItems(UserItem);
      Dispose(UserItem);
      PlayObject.m_ItemList.Delete(I);
    end;
  end;

  for I := PlayObject.m_StorageItemList.Count - 1 downto 0 do
  begin
    UserItem := PlayObject.m_StorageItemList.Items[I];
    if UserItem.MakeIndex <> nMakeIndex then
      Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then
    begin
      Dispose(UserItem);
      PlayObject.m_StorageItemList.Delete(I);
    end;
  end;

  for I := Low(PlayObject.m_UseItems) to High(PlayObject.m_UseItems) do
  begin
    UserItem := @PlayObject.m_UseItems[I];
    if UserItem.MakeIndex <> nMakeIndex then
      Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then
    begin
      UserItem.wIndex := 0;
    end;
  end;
end;

procedure TNormNpc.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
  if not g_Config.boSendCustemMsg then
  begin
    PlayObject.SysMsg(g_sSendCustMsgCanNotUseNowMsg, c_Red, t_Hint);
    exit;
  end;
  if PlayObject.m_boSendMsgFlag then
  begin
    PlayObject.m_boSendMsgFlag := False;
    UserEngine.SendBroadCastMsg(PlayObject.m_sCharName + ': ' + sMsg, t_Cust);
  end
  else
  begin

  end;
end;

procedure TNormNpc.ActionOfQueryvalue(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  smsg: string;
  ntype: integer;
  nlength: integer;
  wtype: integer;
begin
  ntype := str_toint(QuestActionInfo.sParam2, 1);
  nlength := str_toint(QuestActionInfo.sParam3, 3);
  wtype := makeword(ntype, nlength); //020f     //0103
  playobject.m_nsendtype := ntype;
  playobject.m_nsendid := QuestActionInfo.sParam4;
  smsg := QuestActionInfo.sParam5;
  PlayObject.m_npc1:=Self;
  playobject.m_nSendIdx:=QuestActionInfo.nParam1;
  if  (playobject.m_nSendIdx<0)or( playobject.m_nSendIdx>99) then
      playobject.m_nSendIdx:=0;
  if smsg = '' then
    smsg := '请输入';
  PlayObject.SendDefMessage(4627, 0, wtype, 0, 0, sMsg); //弹出输入名字窗口
end;

procedure TNormNpc.ActionOfQUITGUILD(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Guild:TGuild;
  baseobject:TPlayObject;
begin
  guild:=nil;
   baseobject:=UserEngine.GetPlayObject(QuestActionInfo.sParam1) ;
   if baseobject<>nil  then
   begin
      if baseobject.m_myGuild<>nil  then
      Guild:=TGuild(baseobject.m_myGuild);
   end
   else
      Guild:=g_GuildManager.FindGuild(QuestActionInfo.sParam2);
  if Guild<>nil then
  begin

    Guild.DelMember(QuestActionInfo.sParam1) ;
    baseobject.m_MyGuild:=nil;
  end;
end;


procedure TNormNpc.ActionOfQueryNAME(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  smsg: string;
  ntype: integer;
  nlength: integer;
  wtype: integer;
begin
  ntype := str_toint(QuestActionInfo.sParam2, 1);
  nlength := str_toint(QuestActionInfo.sParam3, 3);
  wtype := makeword(ntype, nlength); //020f     //0103
  smsg := QuestActionInfo.sParam1;
  if smsg = '' then
    smsg := '请输入对方名字';
  PlayObject.SendDefMessage(4627, 0, wtype, 0, 0, sMsg); //弹出输入名字窗口
end;

procedure TNormNpc.ActionOfbigbag(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.m_bMaxBagitem := 66;

  PlayObject.SendDefMessage(38292, Integer(PlayObject), 0, PlayObject.m_bMaxBagitem, 0, '');

end;

procedure TNormNpc.ActionOfChangeweather(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  human: Tplayobject;
  i: integer;
begin
  PlayObject.m_PEnvir.m_weatherEffect := QuestActionInfo.nParam1 ;
  PlayObject.m_PEnvir.m_WindSpeed := QuestActionInfo.nParam2 ;
  PlayObject.m_PEnvir.m_weatherEffect :=  QuestActionInfo.nParam3 ;
  for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do
  begin
    human := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
    if not human.m_boDeath and not human.m_boGhost and
      (PlayObject.m_PEnvir = human.m_PEnvir) then
    begin
      human.SendMsg(self, RM_DAYCHANGING, 0, 0, 0, 0, '');
    end;

  end;




end;

procedure TNormNpc.ActionOfChangeflag(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  ncolor: integer;
begin
  //  if not playobject.m_nflagforsell then
  playobject.m_nflagforsell := TRUE;
  ncolor := str_toint(QuestActionInfo.sParam1, 0);
  case ncolor of
    0: playobject.m_nflagforsell := false; //表示没有
    1: playobject.m_nflagforsellcolor := 0; //表示黄色
    2: playobject.m_nflagforsellcolor := 4294917162; // 4294917162红色
    3: playobject.m_nflagforsellcolor := 4284216761; //  4284216761   绿色

  end;

end;

procedure TNormNpc.ActionOfmagicfont(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  playobject.m_bohasmagicfont := true;
  playobject.m_wmagicfont := str_toint(QuestActionInfo.sParam1, 0); //makeword(str_toint(QuestActionInfo.sParam1,0),str_toint(QuestActionInfo.sParam2,0))  //makeword(color,font)
end;

procedure TNormNpc.ActionOfmagicfontcolor(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
  playobject.m_bohasmagicfont := true;
  playobject.m_wmagicfontcolor := str_toint(QuestActionInfo.sParam1, 0); //makeword(str_toint(QuestActionInfo.sParam1,0),str_toint(QuestActionInfo.sParam2,0))  //makeword(color,font)
end;

procedure TNormNpc.ActionOfChangeArp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  smsg: string;
  arp: integer;
begin
           //    SendRefMsg(RM_BUTCH,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  if playobject.m_boOnHorse or playobject.m_boOnBaozi then
  begin
    playobject.SysMsg(' 不能使用', c_Red, t_Hint);
    exit;
  end;
  smsg := QuestActionInfo.sParam2;
  arp := str_toint(smsg, 0);
  if PlayObject.m_boHavebeArp then
  begin
   // PlayObject.SendDefMessage(21292,Integer(Self),64, 0,0, ''); //恢复
    PlayObject.SendRefMsg(RM_21292, 0, 64, 0, 0, '');
    PlayObject.m_boHavebeArp := false;
  end
  else
  begin
   // PlayObject.SendDefMessage(21292,Integer(Self),64, 19,arp, ''); //变身披风
    PlayObject.SendRefMsg(RM_21292, Integer(Self), 64, 19, arp, '');
    PlayObject.m_boHavebeArp := true;
    PlayObject.m_nApprNum := arp;
  end;

//   PlayObject.SendDefMessage(4627,0,769, 0,0, sMsg);//输入数据
end;


function TNormNpc.ConditionOfCheckOfGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := False;
  if QuestConditionInfo.sParam1 = '' then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKOFGUILD);
    exit;
  end;
  if (PlayObject.m_MyGuild <> nil) then
  begin
    if CompareText(TGuild(PlayObject.m_MyGuild).sGuildName, QuestConditionInfo.sParam1) = 0 then
    begin
      Result := True;
    end;
  end;
end;

function TNormNpc.ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nOnlineMin: Integer;
  nOnlineTime: Integer;
begin
  Result := False;
  nOnlineMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nOnlineMin < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ONLINELONGMIN);
    exit;
  end;
  nOnlineTime := (GetTickCount - PlayObject.m_dwLogonTick) div 60000;
  if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if nOnlineTime = nOnlineMin then
        Result := True;
    '>':
      if nOnlineTime > nOnlineMin then
        Result := True;
    '<':
      if nOnlineTime < nOnlineMin then
        Result := True;
  else
    if nOnlineTime >= nOnlineMin then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nErrorCount: Integer;
  cMethod: Char;
begin
  Result := False;
  nErrorCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nErrorCount < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_PASSWORDERRORCOUNT);
    exit;
  end;
    if QuestConditionInfo.sParam1='' then exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=':
      if PlayObject.m_btPwdFailCount = nErrorCount then
        Result := True;
    '>':
      if PlayObject.m_btPwdFailCount > nErrorCount then
        Result := True;
    '<':
      if PlayObject.m_btPwdFailCount < nErrorCount then
        Result := True;
  else
    if PlayObject.m_btPwdFailCount >= nErrorCount then
      Result := True;
  end;
end;

function TNormNpc.ConditionOfIsLockPassword(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := PlayObject.m_boPasswordLocked;
end;




function TNormNpc.ConditionOfIsLockStorage(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
  Result := not PlayObject.m_boCanGetBackItem;
end;

function TNormNpc.ConditionOfCheckPayMent(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nPayMent: Integer;
begin
  Result := False;
  nPayMent := Str_ToInt(QuestConditionInfo.sParam1, -1);
  if nPayMent < 1 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPAYMENT);
    exit;
  end;

  if PlayObject.m_nPayMent = nPayMent then
    Result := True;

end;

function TNormNpc.ConditionOfCheckSlaveName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sSlaveName: string;
  BaseObject: TBaseObject;
begin
  Result := False;
  sSlaveName := QuestConditionInfo.sParam1;
  if sSlaveName = '' then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSLAVENAME);
    exit;
  end;

  for I := 0 to PlayObject.m_SlaveList.Count - 1 do
  begin
    BaseObject := TBaseObject(PlayObject.m_SlaveList.Items[I]);
    if CompareText(sSlaveName, BaseObject.m_sCharName) = 0 then
    begin
      Result := True;
      break;
    end;
  end;
end;

procedure TNormNpc.ActionOfUpgradeItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate, nWhere, nValType, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  nRate := Str_ToInt(QuestActionInfo.sParam2, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam3, -1);
  if (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint < 0) or (nPoint > 255) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMS);
    exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then
  begin
    PlayObject.SysMsg('你身上没有戴指定物品！！！', c_Red, t_Hint);
    exit;
  end;
  nRate := Random(nRate);
  nPoint := Random(nPoint);
  nValType := Random(14);
  if nRate <> 0 then
  begin
    PlayObject.SysMsg('装备升级失败！！！', c_Red, t_Hint);
    exit;
  end;
  if nValType = 14 then
  begin
    nAddPoint := (nPoint * 1000);
    if UserItem.DuraMax + nAddPoint > High(Word) then
    begin
      nAddPoint := High(Word) - UserItem.DuraMax;
    end;


    UserItem.DuraMax := UserItem.DuraMax + nAddPoint;
  end
  else
  begin
    nAddPoint := nPoint;
    if UserItem.btValue[nValType] + nAddPoint > High(Byte) then
    begin
      nAddPoint := High(Byte) - UserItem.btValue[nValType];
    end;

    UserItem.btValue[nValType] := UserItem.btValue[nValType] + nAddPoint;
  end;
  PlayObject.SendUpdateItem(UserItem);
  PlayObject.SysMsg('装备升级成功', c_Green, t_Hint);
  PlayObject.SysMsg(StdItem.Name + ': ' +
    IntToStr(UserItem.Dura) + '/' +
    IntToStr(UserItem.DuraMax) + '/' +
    IntToStr(UserItem.btValue[0]) + '/' +
    IntToStr(UserItem.btValue[1]) + '/' +
    IntToStr(UserItem.btValue[2]) + '/' +

    IntToStr(UserItem.btValue[3]) + '/' +
    IntToStr(UserItem.btValue[4]) + '/' +
    IntToStr(UserItem.btValue[5]) + '/' +
    IntToStr(UserItem.btValue[6]) + '/' +
    IntToStr(UserItem.btValue[7]) + '/' +
    IntToStr(UserItem.btValue[8]) + '/' +
    IntToStr(UserItem.btValue[9]) + '/' +
    IntToStr(UserItem.btValue[10]) + '/' +
    IntToStr(UserItem.btValue[11]) + '/' +
    IntToStr(UserItem.btValue[12]) + '/' +
    IntToStr(UserItem.btValue[13])
    , c_Blue, t_Hint);

end;

procedure TNormNpc.ActionOfUpgradeItemsEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate, nWhere, nValType, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  nUpgradeItemStatus: Integer;
  nRatePoint: Integer;
begin
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  nValType := Str_ToInt(QuestActionInfo.sParam2, -1);
  nRate := Str_ToInt(QuestActionInfo.sParam3, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);
  nUpgradeItemStatus := Str_ToInt(QuestActionInfo.sParam5, -1);
  if (nValType < 0) or (nValType > 14) or (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint < 0) or (nPoint > 255) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMSEX);
    exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then
  begin
    PlayObject.SysMsg('你身上没有戴指定物品！！！', c_Red, t_Hint);
    exit;
  end;
  nRatePoint := Random(nRate * 10);
  nPoint := _MAX(1, Random(nPoint));

  if not (nRatePoint in [0..10]) then
  begin
    case nUpgradeItemStatus of //
      0:
        begin
          PlayObject.SysMsg('装备升级未成功！！！', c_Red, t_Hint);
        end;
      1:
        begin
          PlayObject.SendDelItems(UserItem);
          UserItem.wIndex := 0;
          PlayObject.SysMsg('装备破碎！！！', c_Red, t_Hint);
        end;
      2:
        begin
          PlayObject.SysMsg('装备升级失败，装备属性恢复默认！！！', c_Red, t_Hint);
          if nValType <> 14 then
            UserItem.btValue[nValType] := 0;
        end;
    end;
    exit;
  end;
  if nValType = 14 then
  begin
    nAddPoint := (nPoint * 1000);
    if UserItem.DuraMax + nAddPoint > High(Word) then
    begin
      nAddPoint := High(Word) - UserItem.DuraMax;
    end;


    UserItem.DuraMax := UserItem.DuraMax + nAddPoint;
  end
  else
  begin
    nAddPoint := nPoint;
    if UserItem.btValue[nValType] + nAddPoint > High(Byte) then
    begin
      nAddPoint := High(Byte) - UserItem.btValue[nValType];
    end;

    UserItem.btValue[nValType] := UserItem.btValue[nValType] + nAddPoint;
  end;
  PlayObject.SendUpdateItem(UserItem);
  PlayObject.SysMsg('装备升级成功', c_Green, t_Hint);
  PlayObject.SysMsg(StdItem.Name + ': ' +
    IntToStr(UserItem.Dura) + '/' +
    IntToStr(UserItem.DuraMax) + '-' +
    IntToStr(UserItem.btValue[0]) + '/' +
    IntToStr(UserItem.btValue[1]) + '/' +
    IntToStr(UserItem.btValue[2]) + '/' +
    IntToStr(UserItem.btValue[3]) + '/' +
    IntToStr(UserItem.btValue[4]) + '/' +
    IntToStr(UserItem.btValue[5]) + '/' +
    IntToStr(UserItem.btValue[6]) + '/' +
    IntToStr(UserItem.btValue[7]) + '/' +
    IntToStr(UserItem.btValue[8]) + '/' +
    IntToStr(UserItem.btValue[9]) + '/' +
    IntToStr(UserItem.btValue[10]) + '/' +
    IntToStr(UserItem.btValue[11]) + '/' +
    IntToStr(UserItem.btValue[12]) + '/' +
    IntToStr(UserItem.btValue[13])
    , c_Blue, t_Hint);

end;
//声明变量
//VAR 数据类型(Integer String) 类型(HUMAN GUILD GLOBAL) 变量值

procedure TNormNpc.ActionOfVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s已存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin

  sType := QuestActionInfo.sParam2;
  sVarName := QuestActionInfo.sParam3;
  sVarValue := QuestActionInfo.sParam4;
  nVarValue := Str_ToInt(QuestActionInfo.sParam4, 0);
  VarType := vNone;
  if CompareText(QuestActionInfo.sParam1, 'Integer') = 0 then
    VarType := vInteger;
  if CompareText(QuestActionInfo.sParam1, 'String') = 0 then
    VarType := vString;

  if (sType = '') or (sVarName = '') or (VarType = vNone) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_VAR);
    exit;
  end;
  New(DynamicVar);
  DynamicVar.sName := sVarName;
  DynamicVar.VarType := VarType;
  DynamicVar.nInternet := nVarValue;
  DynamicVar.sString := sVarValue;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then
  begin
    Dispose(DynamicVar);
    ScriptActionError(PlayObject, format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    exit;
  end;
  for I := 0 to DynamicVarList.Count - 1 do
  begin
    if CompareText(pTDynamicVar(DynamicVarList.Items[I]).sName, sVarName) = 0 then
    begin
      boFoundVar := True;
      break;
    end;
  end;
  if not boFoundVar then
  begin
    DynamicVarList.Add(DynamicVar);
  end
  else
  begin
    Dispose(DynamicVar); //hint 这里内存泄露   xjs
    ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_VAR);
  end;

end;

procedure TNormNpc.ActionOfLoadEXVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  n10: Integer;

  sVarName: string;
  sFileName: string;
  sName: string;
  sValue:String;
  IniFile: TIniFile;
  savefile: Tstringlist;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin

  sName := QuestActionInfo.sParam2;
  sVarName := QuestActionInfo.sParam3;
  sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam4;
  if not DirectoryExists(ExtractFileDir(sFileName)) then
  begin
    ForceDirectories(ExtractFileDir(sFileName))
  end;


  if not FileExists(sFileName) then
  begin
    savefile := Tstringlist.Create;
    savefile.SaveToFile(sFileName);
    savefile.Free;
  end;


  IniFile := TIniFile.Create(sFileName);
  sValue := IniFile.ReadString(sName, sVarName, '');
   n10:=Str_ToInt(svalue,0);
   setValValue(PlayObject,QuestActionInfo.sParam1,n10,svalue);


  IniFile.Free;
end;
//读取变量值
//LOADVAR 变量类型 变量名 文件名

procedure TNormNpc.ActionOfLoadVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
  savefile: Tstringlist;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin

  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam3;
  if not DirectoryExists(ExtractFileDir(sFileName)) then
  begin
    ForceDirectories(ExtractFileDir(sFileName))
  end;


  if not FileExists(sFileName) then
  begin
    savefile := Tstringlist.Create;
    savefile.SaveToFile(sFileName);
    savefile.Free;
  end;
  if (sType = '') or (sVarName = '') or not FileExists(sFileName) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_LOADVAR);
    exit;
  end;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then
  begin
  //  Dispose(DynamicVar);   //hint 如果执行这里会抱错
    ScriptActionError(PlayObject, format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    exit;
  end;
  IniFile := TIniFile.Create(sFileName);
  for I := 0 to DynamicVarList.Count - 1 do
  begin
    DynamicVar := DynamicVarList.Items[I];
    if CompareText(DynamicVar.sName, sVarName) = 0 then
    begin
      case DynamicVar.VarType of
        vInteger: DynamicVar.nInternet := IniFile.ReadInteger(sName, DynamicVar.sName, 0);
        vString: DynamicVar.sString := IniFile.ReadString(sName, DynamicVar.sName, '');
      end;
      boFoundVar := True;
      break;
    end;
  end;

  if not boFoundVar then
    ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_LOADVAR);
  IniFile.Free;
end;

//保存变量值
//SAVEVAR 变量类型 变量名 文件名

procedure TNormNpc.ActionOfSaveVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam3;
  if (sType = '') or (sVarName = '') or not FileExists(sFileName) then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SAVEVAR);
    exit;
  end;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then
  begin
   // Dispose(DynamicVar);     //hint
    ScriptActionError(PlayObject, format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    exit;
  end;
  IniFile := TIniFile.Create(sFileName);
  for I := 0 to DynamicVarList.Count - 1 do
  begin
    DynamicVar := DynamicVarList.Items[I];
    if CompareText(DynamicVar.sName, sVarName) = 0 then
    begin
      case DynamicVar.VarType of
        vInteger: IniFile.WriteInteger(sName, DynamicVar.sName, DynamicVar.nInternet);
        vString: IniFile.WriteString(sName, DynamicVar.sName, DynamicVar.sString);
      end;
      boFoundVar := True;
      break;
    end;
  end;

 // if not boFoundVar then
 //   ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_SAVEVAR);
  IniFile.Free;
end;
procedure TNormNpc.ActionOfSaveEXVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var


  sVarName: string;
  sFileName: string;
  sName: string;


  DynamicVarList: TList;
  IniFile: TIniFile;
begin
  sName := QuestActionInfo.sParam2;
  sVarName := QuestActionInfo.sParam3;
  sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam4;
  IniFile := TIniFile.Create(sFileName);
  IniFile.WriteString(sName, sVarName ,QuestActionInfo.sParam1);
  IniFile.Free;
end;

//对变量进行运算(+、-、*、/)

procedure TNormNpc.ActionOfCalcVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sName: string;
  sVarValue: string;
  nVarValue: Integer;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '变量%s不存在，变量类型:%s';
  sVarTypeError = '变量类型错误，错误类型:%s 当前支持类型(HUMAN、GUILD、GLOBAL)';
begin
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  sMethod := QuestActionInfo.sParam3;
  sVarValue := QuestActionInfo.sParam4;
  nVarValue := Str_ToInt(QuestActionInfo.sParam4, 0);

  if (sType = '') or (sVarName = '') or (sMethod = '') then
  begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CALCVAR);
    exit;
  end;
  boFoundVar := False;
    if QuestActionInfo.sParam1='' then exit;
  cMethod := sMethod[1];
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then
  begin
  //  Dispose(DynamicVar);         //hint
    ScriptActionError(PlayObject, format(sVarTypeError, [sType]), QuestActionInfo, sSC_CALCVAR);
    exit;
  end;
  for I := 0 to DynamicVarList.Count - 1 do
  begin
    DynamicVar := DynamicVarList.Items[I];
    if CompareText(DynamicVar.sName, sVarName) = 0 then
    begin
      case DynamicVar.VarType of
        vInteger:
          begin
            case cMethod of
              '=': DynamicVar.nInternet := nVarValue;
              '+': DynamicVar.nInternet := DynamicVar.nInternet + nVarValue;
              '-': DynamicVar.nInternet := DynamicVar.nInternet - nVarValue;
              '*': DynamicVar.nInternet := DynamicVar.nInternet * nVarValue;
              '/': DynamicVar.nInternet := DynamicVar.nInternet div _max(nVarValue, 1);
            end;
          end;
        vString:
          begin
            case cMethod of
              '=': DynamicVar.sString := sVarValue;
              '+': DynamicVar.sString := DynamicVar.sString + sVarValue;
            end;
          end;
      end;
      boFoundVar := True;
      break;
    end;
  end;

  if not boFoundVar then
    ScriptActionError(PlayObject, format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_CALCVAR);

end;

procedure TNormNpc.Initialize;
begin
  inherited;
  m_Castle := g_CastleManager.InCastleWarArea(Self);
end;

function TNormNpc.ConditionOfCheckNameDateList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sListFileName, sLineText, sHumName, sDate: string;
  boDeleteExprie, boNoCompareHumanName: Boolean;
  dOldDate: TDateTime;
  cMethod: Char;
  nValNo, nValNoDay, nDayCount, nDay: Integer;
begin
  Result := False;
  nDayCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nValNo := GetValNameNo(QuestConditionInfo.sParam4);
  nValNoDay := GetValNameNo(QuestConditionInfo.sParam5);
  boDeleteExprie := CompareText(QuestConditionInfo.sParam6, '清理') = 0;
  boNoCompareHumanName := CompareText(QuestConditionInfo.sParam6, '1') = 0;
  if QuestConditionInfo.sParam2='' then exit;
  cMethod := QuestConditionInfo.sParam2[1];
  if nDayCount < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEDATELIST);
    exit;
  end;
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1;
  if FileExists(sListFileName) then
  begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('loading fail.... => ' + sListFileName);
    end;
    for I := 0 to LoadList.Count - 1 do
    begin
      sLineText := Trim(LoadList.Strings[I]);
      sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
      if (CompareText(sHumName, PlayObject.m_sCharName) = 0) or boNoCompareHumanName then
      begin
        nDay := High(Integer);
        if TryStrToDateTime(sDate, dOldDate) then
          nDay := GetDayCount(Now, dOldDate);
        case cMethod of
          '=':
            if nDay = nDayCount then
              Result := True;
          '>':
            if nDay > nDayCount then
              Result := True;
          '<':
            if nDay < nDayCount then
              Result := True;
        else
          if nDay >= nDayCount then
            Result := True;
        end;
        if nValNo >= 0 then
        begin
          case nValNo of
            0..9:
              begin
                PlayObject.m_nVal[nValNo] := nDay;
              end;
            100..199:
              begin
                g_Config.GlobalVal[nValNo - 100] := nDay;
              end;
            200..209:
              begin
                PlayObject.m_DyVal[nValNo - 200] := nDay;
              end;
            300..399:
              begin
                PlayObject.m_nMval[nValNo - 300] := nDay;
              end;
            400..499:
              begin
                g_Config.GlobaDyMval[nValNo - 400] := nDay;
              end;
          end;
        end;

        if nValNoDay >= 0 then
        begin
          case nValNoDay of
            0..9:
              begin
                PlayObject.m_nVal[nValNoDay] := nDayCount - nDay;
              end;
            100..199:
              begin
                g_Config.GlobalVal[nValNoDay - 100] := nDayCount - nDay;
              end;
            200..209:
              begin
                PlayObject.m_DyVal[nValNoDay - 200] := nDayCount - nDay;
              end;
            300..399:
              begin
                PlayObject.m_nMval[nValNoDay - 300] := nDayCount - nDay;
              end;
          end;
        end;
        if not Result then
        begin
          if boDeleteExprie then
          begin
            LoadList.Delete(I);
            try
              LoadList.SaveToFile(sListFileName);
            except
              MainOutMessage('Save fail.... => ' + sListFileName);
            end;
          end;
        end;
        break;
      end;
    end;
    LoadList.Free;
  end
  else
  begin
    MainOutMessage('file not found => ' + sListFileName);
  end;
end;
//CHECKMAPHUMANCOUNT MAP = COUNT

function TNormNpc.ConditionOfCheckMapHumanCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount, nHumanCount: Integer;
  cMethod: Char;

  baseList:TList;
  envir: TEnvirnoment;
begin
  Result := False;
   Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);
   if envir=nil  then exit;
   
  nCount := Str_ToInt(QuestConditionInfo.sParam6, -1);
  if nCount < 0 then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAPHUMANCOUNT);
    exit;
  end;
  baseList:=TList.Create;
  nHumanCount := UserEngine.GetMapRageHuman(envir,QuestConditionInfo.nParam2,QuestConditionInfo.nParam3,QuestConditionInfo.nParam4,baseList);
  baseList.Free;
   if QuestConditionInfo.sParam5='' then exit;
  cMethod := QuestConditionInfo.sParam5[1];
  case cMethod of
    '=':
      if nHumanCount = nCount then
        Result := True;
    '>':
      if nHumanCount > nCount then
        Result := True;
    '<':
      if nHumanCount < nCount then
        Result := True;
  else
    if nHumanCount >= nCount then
      Result := True;
  end;
end;



function TNormNpc.ConditionOfCheckMapMonCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount, nMonCount: Integer;
  cMethod: Char;
  Envir: TEnvirnoment;
begin
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
  Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);
  if (nCount < 0) or (Envir = nil) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAPMONCOUNT);
    exit;
  end;

  nMonCount := UserEngine.GetMapMonster(Envir, nil);
    if QuestConditionInfo.sParam2='' then exit;
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=':
      if nMonCount = nCount then
        Result := True;
    '>':
      if nMonCount > nCount then
        Result := True;
    '<':
      if nMonCount < nCount then
        Result := True;
  else
    if nMonCount >= nCount then
      Result := True;
  end;
end;





function TNormNpc.ConditionOfCheckMapMonNameCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sMapName,sMonName: string;
  nX, nY, nRange, nCount: Integer;
  cMethod: Char;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
  nRange := _min(nRange, 500);
    if QuestConditionInfo.sParam5='' then exit;
  sMonName:= QuestConditionInfo.sParam5;
  nCount := Str_ToInt(QuestConditionInfo.sParam6, -1);

  if nCount<0 then
  Begin
     cMethod:='<';
     nCount:=Abs(nCount);
  End
  else
     CMethod:='>';
  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (nX < 0) or (nY < 0) or (nRange < 0) or (nCount < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKRANGEMONCOUNT);
    exit;
  end;
  MonList := TList.Create;
  try
   Envir.GetRangeBaseObject(nX, nY, nRange, True, MonList);

    for I := MonList.Count - 1 downto 0 do
    begin
      BaseObject := TBaseObject(MonList.Items[I]);
      if (BaseObject.m_btRaceServer < RC_ANIMAL) or (BaseObject.m_btRaceServer = RC_ARCHERGUARD)  then
        Continue;
      if BaseObject.m_scharname=sMonName then  Inc(nMapRangeCount);
    end;

    case cMethod of
      '>':
        if nMapRangeCount >= nCount then
          Result := True;
      '<':
        if nMapRangeCount < nCount then
          Result := True;
    else
      if nMapRangeCount >= nCount then
        Result := True;
    end;
  finally
   MonList.Free;

  end;
end;
function TNormNpc.ConditionOfPosex(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  i : Integer;
  str:string;
  sList:TStringList;
begin
   Result:=False;
   str:=g_Config.sEnvirDir + m_sPath+ QuestConditionInfo.sParam2;
   if FileExists(str) then
   Begin
     sList:=TStringList.Create;
     sList.LoadFromFile(str);
     for I := 0 to sList.Count - 1 do
     begin
       str:=sList[i];
       if Pos(QuestConditionInfo.sParam1,str)>0 then
       begin
         Result:=True;
         setValValue(PlayObject,QuestConditionInfo.sParam1,0,QuestConditionInfo.sParam3);
         Break;
       end;

     end;

   End;
end;
function TNormNpc.ConditionOfCheckMapMonNameCountex(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sMapName,sMonName: string;
  nX, nY, nRange, nCount: Integer;
  cMethod: Char;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  sMapName := QuestConditionInfo.sParam1;
  nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
  nRange := _min(nRange, 500);
    if QuestConditionInfo.sParam5='' then exit;
  sMonName:= QuestConditionInfo.sParam5;
  nCount := Str_ToInt(QuestConditionInfo.sParam6, -1);

  if nCount<0 then
  Begin
     cMethod:='<';
     nCount:=Abs(nCount);
  End
  else
     CMethod:='>';
  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (nX < 0) or (nY < 0) or (nRange < 0) or (nCount < 0) then
  begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKRANGEMONCOUNT);
    exit;
  end;
  MonList := TList.Create;
  try
   Envir.GetRangeBaseObject(nX, nY, nRange, True, MonList);

    for I := MonList.Count - 1 downto 0 do
    begin
      BaseObject := TBaseObject(MonList.Items[I]);
      if (BaseObject.m_btRaceServer < RC_ANIMAL) or (BaseObject.m_btRaceServer = RC_ARCHERGUARD) or (BaseObject.m_Master <> nil) then
        Continue;
      if BaseObject.m_scharname=sMonName then  Inc(nMapRangeCount);
    end;

    case cMethod of
      '>':
        if nMapRangeCount >= nCount then
          Result := True;
      '<':
        if nMapRangeCount < nCount then
          Result := True;
    else
      if nMapRangeCount >= nCount then
        Result := True;
    end;
  finally
   MonList.Free;

  end;
end;

function TNormNpc.GetDynamicVarList(PlayObject: TPlayObject;
  sType: string; var sName: string): TList;
begin
  Result := nil;
  if CompareLStr(sType, 'HUMAN', length('HUMAN')) then
  begin
    Result := PlayObject.m_DynamicVarList;
    sName := PlayObject.m_sCharName;
  end
  else
    if CompareLStr(sType, 'GUILD', length('GUILD')) then
    begin
      if PlayObject.m_MyGuild = nil then
        exit;
      Result := TGuild(PlayObject.m_MyGuild).m_DynamicVarList;
      sName := TGuild(PlayObject.m_MyGuild).sGuildName;
    end
    else
      if CompareLStr(sType, 'GLOBAL', length('GLOBAL')) then
      begin
        Result := g_DynamicVarList;
        sName := 'GLOBAL';
      end;
end;



{ TGuildOfficial }

procedure TGuildOfficial.Click(PlayObject: TPlayObject); //004A30F4
begin
//  GotoLable(PlayObject,'@main');
  inherited;
end;

procedure TGuildOfficial.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);
var
  I, II: Integer;
  sText: string;
  List: TStringList;
  sStr: string;
begin
  inherited;
  if sVariable = '$REQUESTCASTLELIST' then
  begin
    sText := '';
    List := TStringList.Create;
    g_CastleManager.GetCastleNameList(List);
    for I := 0 to List.Count - 1 do
    begin
      II := I + 1;
      if ((II div 2) * 2 = II) then
        sStr := '\'
      else
        sStr := '';

      sText := sText + format('<%s/@requestcastlewarnow%d> %s', [List.Strings[I], I, sStr]);
    end;
    sText := sText + '\ \';
    List.Free;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLELIST>', sText);
  end;
end;

procedure TGuildOfficial.Run; //004A37F0
begin
  if Random(40) = 0 then
  begin
    TurnTo(Random(8));
  end
  else
  begin
    if Random(30) = 0 then
      SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  end;
  inherited;
end;

procedure TGuildOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  sMsg, sLabel: string;
  boCanJmp: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TGuildOfficial::UserSelect... ';
begin
  inherited;
  try
//    PlayObject.m_nScriptGotoCount:=0;
    if (sData <> '') and (sData[1] = '@') then
    begin
      sMsg := GetValidStr3(sData, sLabel, [#13]);

      boCanJmp := PlayObject.LableIsCanJmp(sLabel, m_bocallboard);

      GotoLable(PlayObject, sLabel, not boCanJmp);

      //GotoLable(PlayObject,sLabel,not PlayObject.LableIsCanJmp(sLabel));
      if not boCanJmp then
        exit;
      if CompareText(sLabel, sBUILDGUILDNOW) = 0 then
      begin
             //   playobject.m_nsendtype := 0;
              //  playobject.m_nsendid :=sBUILDGUILDNOW;
             //   PlayObject.SendDefMessage(4627, 0, $0f02, 0, 0, '请输入要创建行会的名称'); //弹出输入名字窗口
               GotoLable(PlayObject,'@开始建立中',false);
       
      end
      else
        if CompareText(sLabel, sSCL_GUILDWAR) = 0 then
        begin
                playobject.m_nsendtype := 0;
                playobject.m_nsendid :=sSCL_GUILDWAR;
                PlayObject.SendDefMessage(4627, 0, $0f02, 0, 0, '请输入敌对行会的名称'); //弹出输入名字窗口

        // ReQuestGuildWar(PlayObject, sMsg);
        end
        else
          if CompareText(sLabel, sDONATE) = 0 then
          begin
            DoNate(PlayObject);
          end
          else
      {
      if CompareText(sLabel,sREQUESTCASTLEWAR) = 0 then begin
        ReQuestCastleWar(PlayObject,sMsg);
      end else
      }
            if CompareLStr(sLabel, sREQUESTCASTLEWAR, length(sREQUESTCASTLEWAR)) then
            begin
              ReQuestCastleWar(PlayObject, Copy(sLabel, length(sREQUESTCASTLEWAR) + 1, length(sLabel) - length(sREQUESTCASTLEWAR)));
            end
            else
              if CompareText(sLabel, sEXIT) = 0 then
              begin
                PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
              end
              else
                if CompareText(sLabel, sBACK) = 0 then
                begin
                  if PlayObject.m_sScriptGoBackLable = '' then
                    PlayObject.m_sScriptGoBackLable := sMAIN;
                  GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
                end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
//  inherited;
end;

function TNormNpc.ReQuestBuildGuild(PlayObject: TPlayObject; sGuildName: string): Integer; //004A3124
var
  UserItem: pTUserItem;
  sKey: string;
begin
  Result := 0;
  sGuildName := Trim(sGuildName);
  UserItem := nil;
  if sGuildName = '' then
  begin
    Result := -4;
  end;
  if PlayObject.m_MyGuild = nil then
  begin
    if PlayObject.m_nGold >= g_Config.nBuildGuildPrice then
    begin
      UserItem := PlayObject.CheckItems(g_Config.sWomaHorn);
      if UserItem = nil then
      begin
        Result := -3; //'你没有准备好需要的全部物品。'
      end;
    end
    else
      Result := -2; //'缺少创建费用。'
  end
  else
    Result := -1; //'您已经加入其它行会。'
  if Result = 0 then
  begin
    if g_GuildManager.AddGuild(sGuildName, PlayObject.m_sCharName) then
    begin
      UserEngine.SendServerGroupMsg(SS_205, nServerIndex, sGuildName + '/' + PlayObject.m_sCharName);
      PlayObject.SendDelItems(UserItem);
      PlayObject.DelBagItem(UserItem.MakeIndex, g_Config.sWomaHorn);
      PlayObject.DecGold(g_Config.nBuildGuildPrice);
      PlayObject.GoldChanged();
      PlayObject.m_MyGuild := g_GuildManager.MemberOfGuild(PlayObject.m_sCharName);
      if PlayObject.m_MyGuild <> nil then
      begin
        PlayObject.m_sGuildRankName := TGuild(PlayObject.m_MyGuild).GetRankName(PlayObject, PlayObject.m_nGuildRankNo);
        RefShowName();
      end;
    end
    else
      Result := -4;
  end;
  if Result >= 0 then
  begin
    PlayObject.SendMsg(Self, RM_BUILDGUILD_OK, 0, 0, 0, 0, '');
  end
  else
  begin
    PlayObject.SendMsg(Self, RM_BUILDGUILD_FAIL, 0, Result, 0, 0, '');
  end;
end;

function TNormNpc.ReQuestGuildWar(PlayObject: TPlayObject; sGuildName: string): Integer; //004A3368
begin
  if g_GuildManager.FindGuild(sGuildName) <> nil then
  begin
    if PlayObject.m_nGold >= g_Config.nGuildWarPrice then
    begin
      PlayObject.DecGold(g_Config.nGuildWarPrice);
      PlayObject.GoldChanged();
      PlayObject.ReQuestGuildWar(sGuildName);
    end
    else
    begin
      PlayObject.SysMsg('你没有足够的金币！！！', c_Red, t_Hint);
    end;
  end
  else
  begin
    PlayObject.SysMsg('行会 ' + sGuildName + ' 不存在！！！', c_Red, t_Hint);
  end;
  Result := 1;
end;

procedure TGuildOfficial.DoNate(PlayObject: TPlayObject); //004A346C
begin
  PlayObject.SendMsg(Self, RM_DONATE_OK, 0, 0, 0, 0, '');
end;

procedure TGuildOfficial.ReQuestCastleWar(PlayObject: TPlayObject; sIndex: string); //004A3498
var
  UserItem: pTUserItem;
  Castle: TUserCastle;
  nIndex: Integer;
begin
//  if PlayObject.IsGuildMaster and
//     (not UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild))) then begin
  nIndex := Str_ToInt(sIndex, -1);
  if nIndex < 0 then
    nIndex := 0;

  Castle := g_CastleManager.GetCastle(nIndex);
  if PlayObject.IsGuildMaster and
    not Castle.IsMember(PlayObject) then
  begin

    UserItem := PlayObject.CheckItems(g_Config.sZumaPiece);
    if UserItem <> nil then
    begin

      if Castle.AddAttackerInfo(TGuild(PlayObject.m_MyGuild)) then
      begin
        PlayObject.SendDelItems(UserItem);
        PlayObject.DelBagItem(UserItem.MakeIndex, g_Config.sZumaPiece);
        GotoLable(PlayObject, '~@request_ok', False);
      end
      else
      begin
        PlayObject.SysMsg('你现在无法请求攻城！！！', c_Red, t_Hint);
      end;
(*{$IFEND}*)

    end
    else
    begin
      PlayObject.SysMsg('你没有' + g_Config.sZumaPiece + '！！！', c_Red, t_Hint);
    end;
  end
  else
  begin
    PlayObject.SysMsg('你的请求被取消！！！', c_Red, t_Hint);
  end;
end;


procedure TCastleOfficial.RepairDoor(PlayObject: TPlayObject); //004A3FB8
begin
  if m_Castle = nil then
  begin
    PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
    exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairDoorPrice then
  begin
    if TUserCastle(m_Castle).RepairDoor then
    begin
      Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairDoorPrice);
      PlayObject.SysMsg('修理成功。', c_Green, t_Hint);
    end
    else
    begin
      PlayObject.SysMsg('城门不需要修理！！！', c_Green, t_Hint);
    end;
  end
  else
  begin
    PlayObject.SysMsg('城内资金不足！！！', c_Red, t_Hint);
  end;

end;

procedure TCastleOfficial.RepairWallNow(nWallIndex: Integer;
  PlayObject: TPlayObject); //004A4074
begin
  if m_Castle = nil then
  begin
    PlayObject.SysMsg('NPC不属于城堡！！！', c_Red, t_Hint);
    exit;
  end;

  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairWallPrice then
  begin
    if TUserCastle(m_Castle).RepairWall(nWallIndex) then
    begin
      Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairWallPrice);
      PlayObject.SysMsg('修理成功。', c_Green, t_Hint);
    end
    else
    begin
      PlayObject.SysMsg('城门不需要修理！！！', c_Green, t_Hint);
    end;
  end
  else
  begin
    PlayObject.SysMsg('城内资金不足！！！', c_Red, t_Hint);
  end;

end;

constructor TCastleOfficial.Create;
begin
  inherited;

end;

destructor TCastleOfficial.Destroy;
begin

  inherited;
end;

constructor TGuildOfficial.Create;
begin
  inherited;
  m_btRaceImg := RCC_MERCHANT;
  m_wAppr := 8;
end;

destructor TGuildOfficial.Destroy;
begin

  inherited;
end;

procedure TGuildOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
  inherited;

end;

procedure TCastleOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
  if not g_Config.boSubkMasterSendMsg then
  begin
    PlayObject.SysMsg(g_sSubkMasterMsgCanNotUseNowMsg, c_Red, t_Hint);
    exit;
  end;
  if PlayObject.m_boSendMsgFlag then
  begin
    PlayObject.m_boSendMsgFlag := False;
    UserEngine.SendBroadCastMsg(PlayObject.m_sCharName + ': ' + sMsg, t_Castle);
  end
  else
  begin

  end;
end;

end.
