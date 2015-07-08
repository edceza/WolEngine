unit FunctionConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin, Grids;

type
  TfrmFunctionConfig = class(TForm)
    FunctionConfigControl: TPageControl;
    Label14: TLabel;
    MonSaySheet: TTabSheet;
    TabSheet1: TTabSheet;
    PasswordSheet: TTabSheet;
    GroupBox1: TGroupBox;
    CheckBoxEnablePasswordLock: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBoxLockGetBackItem: TCheckBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    EditErrorPasswordCount: TSpinEdit;
    CheckBoxErrorCountKick: TCheckBox;
    ButtonPasswordLockSave: TButton;
    GroupBox4: TGroupBox;
    CheckBoxLockWalk: TCheckBox;
    CheckBoxLockRun: TCheckBox;
    CheckBoxLockHit: TCheckBox;
    CheckBoxLockSpell: TCheckBox;
    CheckBoxLockSendMsg: TCheckBox;
    CheckBoxLockInObMode: TCheckBox;
    CheckBoxLockLogin: TCheckBox;
    CheckBoxLockUseItem: TCheckBox;
    CheckBoxLockDropItem: TCheckBox;
    CheckBoxLockDealItem: TCheckBox;
    TabSheetGeneral: TTabSheet;
    GroupBox7: TGroupBox;
    CheckBoxHungerSystem: TCheckBox;
    ButtonGeneralSave: TButton;
    GroupBoxHunger: TGroupBox;
    CheckBoxHungerDecPower: TCheckBox;
    CheckBoxHungerDecHP: TCheckBox;
    ButtonSkillSave: TButton;
    GroupBox9: TGroupBox;
    CheckBoxLimitSwordLong: TCheckBox;
    GroupBox10: TGroupBox;
    EditSwordLongPowerRate: TSpinEdit;
    Label4: TLabel;
    Label10: TLabel;
    TabSheet32: TTabSheet;
    TabSheet33: TTabSheet;
    TabSheet34: TTabSheet;
    TabSheet35: TTabSheet;
    GroupBox17: TGroupBox;
    Label12: TLabel;
    EditMagicAttackRage: TSpinEdit;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    EditUpgradeWeaponMaxPoint: TSpinEdit;
    Label15: TLabel;
    EditUpgradeWeaponPrice: TSpinEdit;
    Label16: TLabel;
    EditUPgradeWeaponGetBackTime: TSpinEdit;
    Label17: TLabel;
    EditClearExpireUpgradeWeaponDays: TSpinEdit;
    Label18: TLabel;
    Label19: TLabel;
    GroupBox18: TGroupBox;
    ScrollBarUpgradeWeaponDCRate: TScrollBar;
    Label20: TLabel;
    EditUpgradeWeaponDCRate: TEdit;
    Label21: TLabel;
    ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar;
    EditUpgradeWeaponDCTwoPointRate: TEdit;
    Label22: TLabel;
    ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar;
    EditUpgradeWeaponDCThreePointRate: TEdit;
    GroupBox19: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    ScrollBarUpgradeWeaponSCRate: TScrollBar;
    EditUpgradeWeaponSCRate: TEdit;
    ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar;
    EditUpgradeWeaponSCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar;
    EditUpgradeWeaponSCThreePointRate: TEdit;
    GroupBox20: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    ScrollBarUpgradeWeaponMCRate: TScrollBar;
    EditUpgradeWeaponMCRate: TEdit;
    ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar;
    EditUpgradeWeaponMCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar;
    EditUpgradeWeaponMCThreePointRate: TEdit;
    ButtonUpgradeWeaponSave: TButton;
    GroupBox21: TGroupBox;
    ButtonMasterSave: TButton;
    GroupBox22: TGroupBox;
    EditMasterOKLevel: TSpinEdit;
    Label29: TLabel;
    GroupBox23: TGroupBox;
    EditMasterOKCreditPoint: TSpinEdit;
    Label30: TLabel;
    EditMasterOKBonusPoint: TSpinEdit;
    Label31: TLabel;
    GroupBox24: TGroupBox;
    ScrollBarMakeMineHitRate: TScrollBar;
    EditMakeMineHitRate: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    ScrollBarMakeMineRate: TScrollBar;
    EditMakeMineRate: TEdit;
    GroupBox25: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    ScrollBarStoneTypeRate: TScrollBar;
    EditStoneTypeRate: TEdit;
    ScrollBarGoldStoneMax: TScrollBar;
    EditGoldStoneMax: TEdit;
    Label36: TLabel;
    ScrollBarSilverStoneMax: TScrollBar;
    EditSilverStoneMax: TEdit;
    Label37: TLabel;
    ScrollBarSteelStoneMax: TScrollBar;
    EditSteelStoneMax: TEdit;
    Label38: TLabel;
    EditBlackStoneMax: TEdit;
    ScrollBarBlackStoneMax: TScrollBar;
    ButtonMakeMineSave: TButton;
    GroupBox26: TGroupBox;
    Label39: TLabel;
    EditStoneMinDura: TSpinEdit;
    Label40: TLabel;
    EditStoneGeneralDuraRate: TSpinEdit;
    Label41: TLabel;
    EditStoneAddDuraRate: TSpinEdit;
    Label42: TLabel;
    EditStoneAddDuraMax: TSpinEdit;
    TabSheet37: TTabSheet;
    GroupBox27: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    ScrollBarWinLottery1Max: TScrollBar;
    EditWinLottery1Max: TEdit;
    ScrollBarWinLottery2Max: TScrollBar;
    EditWinLottery2Max: TEdit;
    ScrollBarWinLottery3Max: TScrollBar;
    EditWinLottery3Max: TEdit;
    ScrollBarWinLottery4Max: TScrollBar;
    EditWinLottery4Max: TEdit;
    EditWinLottery5Max: TEdit;
    ScrollBarWinLottery5Max: TScrollBar;
    Label48: TLabel;
    ScrollBarWinLottery6Max: TScrollBar;
    EditWinLottery6Max: TEdit;
    EditWinLotteryRate: TEdit;
    ScrollBarWinLotteryRate: TScrollBar;
    Label49: TLabel;
    GroupBox28: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    EditWinLottery1Gold: TSpinEdit;
    EditWinLottery2Gold: TSpinEdit;
    EditWinLottery3Gold: TSpinEdit;
    EditWinLottery4Gold: TSpinEdit;
    Label54: TLabel;
    EditWinLottery5Gold: TSpinEdit;
    Label55: TLabel;
    EditWinLottery6Gold: TSpinEdit;
    ButtonWinLotterySave: TButton;
    TabSheet38: TTabSheet;
    GroupBox29: TGroupBox;
    Label56: TLabel;
    EditReNewNameColor1: TSpinEdit;
    LabelReNewNameColor1: TLabel;
    Label58: TLabel;
    EditReNewNameColor2: TSpinEdit;
    LabelReNewNameColor2: TLabel;
    Label60: TLabel;
    EditReNewNameColor3: TSpinEdit;
    LabelReNewNameColor3: TLabel;
    Label62: TLabel;
    EditReNewNameColor4: TSpinEdit;
    LabelReNewNameColor4: TLabel;
    Label64: TLabel;
    EditReNewNameColor5: TSpinEdit;
    LabelReNewNameColor5: TLabel;
    Label66: TLabel;
    EditReNewNameColor6: TSpinEdit;
    LabelReNewNameColor6: TLabel;
    Label68: TLabel;
    EditReNewNameColor7: TSpinEdit;
    LabelReNewNameColor7: TLabel;
    Label70: TLabel;
    EditReNewNameColor8: TSpinEdit;
    LabelReNewNameColor8: TLabel;
    Label72: TLabel;
    EditReNewNameColor9: TSpinEdit;
    LabelReNewNameColor9: TLabel;
    Label74: TLabel;
    EditReNewNameColor10: TSpinEdit;
    LabelReNewNameColor10: TLabel;
    ButtonReNewLevelSave: TButton;
    GroupBox30: TGroupBox;
    Label57: TLabel;
    EditReNewNameColorTime: TSpinEdit;
    Label59: TLabel;
    TabSheet39: TTabSheet;
    ButtonMonUpgradeSave: TButton;
    GroupBox32: TGroupBox;
    Label65: TLabel;
    LabelMonUpgradeColor1: TLabel;
    Label67: TLabel;
    LabelMonUpgradeColor2: TLabel;
    Label69: TLabel;
    LabelMonUpgradeColor3: TLabel;
    Label71: TLabel;
    LabelMonUpgradeColor4: TLabel;
    Label73: TLabel;
    LabelMonUpgradeColor5: TLabel;
    Label75: TLabel;
    LabelMonUpgradeColor6: TLabel;
    Label76: TLabel;
    LabelMonUpgradeColor7: TLabel;
    Label77: TLabel;
    LabelMonUpgradeColor8: TLabel;
    EditMonUpgradeColor1: TSpinEdit;
    EditMonUpgradeColor2: TSpinEdit;
    EditMonUpgradeColor3: TSpinEdit;
    EditMonUpgradeColor4: TSpinEdit;
    EditMonUpgradeColor5: TSpinEdit;
    EditMonUpgradeColor6: TSpinEdit;
    EditMonUpgradeColor7: TSpinEdit;
    EditMonUpgradeColor8: TSpinEdit;
    GroupBox31: TGroupBox;
    Label61: TLabel;
    Label63: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    EditMonUpgradeKillCount1: TSpinEdit;
    EditMonUpgradeKillCount2: TSpinEdit;
    EditMonUpgradeKillCount3: TSpinEdit;
    EditMonUpgradeKillCount4: TSpinEdit;
    EditMonUpgradeKillCount5: TSpinEdit;
    EditMonUpgradeKillCount6: TSpinEdit;
    EditMonUpgradeKillCount7: TSpinEdit;
    EditMonUpLvNeedKillBase: TSpinEdit;
    EditMonUpLvRate: TSpinEdit;
    Label84: TLabel;
    CheckBoxReNewChangeColor: TCheckBox;
    GroupBox33: TGroupBox;
    CheckBoxReNewLevelClearExp: TCheckBox;
    GroupBox34: TGroupBox;
    Label85: TLabel;
    EditPKFlagNameColor: TSpinEdit;
    LabelPKFlagNameColor: TLabel;
    Label87: TLabel;
    EditPKLevel1NameColor: TSpinEdit;
    LabelPKLevel1NameColor: TLabel;
    Label89: TLabel;
    EditPKLevel2NameColor: TSpinEdit;
    LabelPKLevel2NameColor: TLabel;
    Label91: TLabel;
    EditAllyAndGuildNameColor: TSpinEdit;
    LabelAllyAndGuildNameColor: TLabel;
    Label93: TLabel;
    EditWarGuildNameColor: TSpinEdit;
    LabelWarGuildNameColor: TLabel;
    Label95: TLabel;
    EditInFreePKAreaNameColor: TSpinEdit;
    LabelInFreePKAreaNameColor: TLabel;
    TabSheet40: TTabSheet;
    Label86: TLabel;
    EditMonUpgradeColor9: TSpinEdit;
    LabelMonUpgradeColor9: TLabel;
    GroupBox35: TGroupBox;
    CheckBoxMasterDieMutiny: TCheckBox;
    Label88: TLabel;
    EditMasterDieMutinyRate: TSpinEdit;
    Label90: TLabel;
    EditMasterDieMutinyPower: TSpinEdit;
    Label92: TLabel;
    EditMasterDieMutinySpeed: TSpinEdit;
    GroupBox36: TGroupBox;
    Label94: TLabel;
    Label96: TLabel;
    CheckBoxSpiritMutiny: TCheckBox;
    EditSpiritMutinyTime: TSpinEdit;
    EditSpiritPowerRate: TSpinEdit;
    ButtonSpiritMutinySave: TButton;
    GroupBox40: TGroupBox;
    CheckBoxMonSayMsg: TCheckBox;
    ButtonMonSayMsgSave: TButton;
    ButtonUpgradeWeaponDefaulf: TButton;
    ButtonMakeMineDefault: TButton;
    ButtonWinLotteryDefault: TButton;
    TabSheet42: TTabSheet;
    GroupBox44: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    ScrollBarWeaponMakeUnLuckRate: TScrollBar;
    EditWeaponMakeUnLuckRate: TEdit;
    ScrollBarWeaponMakeLuckPoint1: TScrollBar;
    EditWeaponMakeLuckPoint1: TEdit;
    ScrollBarWeaponMakeLuckPoint2: TScrollBar;
    EditWeaponMakeLuckPoint2: TEdit;
    ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar;
    EditWeaponMakeLuckPoint2Rate: TEdit;
    EditWeaponMakeLuckPoint3: TEdit;
    ScrollBarWeaponMakeLuckPoint3: TScrollBar;
    Label110: TLabel;
    ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar;
    EditWeaponMakeLuckPoint3Rate: TEdit;
    ButtonWeaponMakeLuckDefault: TButton;
    ButtonWeaponMakeLuckSave: TButton;
    GroupBox47: TGroupBox;
    Label112: TLabel;
    CheckBoxBBMonAutoChangeColor: TCheckBox;
    EditBBMonAutoChangeColorTime: TSpinEdit;
    CheckBoxMasterRunScript: TCheckBox;
    TabSheet44: TTabSheet;
    PageControl1: TPageControl;
    TabSheet45: TTabSheet;
    TabSheet46: TTabSheet;
    GroupBox49: TGroupBox;
    CheckBoxEvilAddItemVal: TCheckBox;
    GroupBox50: TGroupBox;
    Label113: TLabel;
    SpinEdit1: TSpinEdit;
    Label114: TLabel;
    SpinEdit2: TSpinEdit;
    GroupBox51: TGroupBox;
    Label115: TLabel;
    SpinEdit3: TSpinEdit;
    Label116: TLabel;
    GroupBox52: TGroupBox;
    Label117: TLabel;
    TrackBar1: TTrackBar;
    Label118: TLabel;
    EditKillMonAddZMZRate: TSpinEdit;
    Label119: TLabel;
    EditKillMonAddZMZMAX: TSpinEdit;
    Label120: TLabel;
    SpinEdit6: TSpinEdit;
    Label121: TLabel;
    EditAddDarkZMZ: TSpinEdit;
    Label122: TLabel;
    EditAddDarkofValue: TSpinEdit;
    EditAddDarkofRandValue: TSpinEdit;
    Label123: TLabel;
    PageControl2: TPageControl;
    TabSheet47: TTabSheet;
    TabSheet48: TTabSheet;
    TabSheet49: TTabSheet;
    TabSheet50: TTabSheet;
    TabSheet51: TTabSheet;
    GroupBox53: TGroupBox;
    GroupBox54: TGroupBox;
    Label124: TLabel;
    Label125: TLabel;
    EditDc11: TSpinEdit;
    SpinEdit11: TSpinEdit;
    GroupBox55: TGroupBox;
    Label126: TLabel;
    Label127: TLabel;
    EditDc21: TSpinEdit;
    EditDc21Rate: TSpinEdit;
    GroupBox56: TGroupBox;
    GroupBox57: TGroupBox;
    Label128: TLabel;
    Label129: TLabel;
    EditMc11: TSpinEdit;
    EditMc11Rate: TSpinEdit;
    GroupBox58: TGroupBox;
    Label130: TLabel;
    Label131: TLabel;
    EditMc21: TSpinEdit;
    EditMc21Rate: TSpinEdit;
    GroupBox59: TGroupBox;
    GroupBox60: TGroupBox;
    Label132: TLabel;
    Label133: TLabel;
    EditSc11: TSpinEdit;
    EditSc11Rate: TSpinEdit;
    GroupBox61: TGroupBox;
    Label134: TLabel;
    Label135: TLabel;
    EditSc21: TSpinEdit;
    EditSc21Rate: TSpinEdit;
    Label136: TLabel;
    GroupBox62: TGroupBox;
    GroupBox63: TGroupBox;
    Label137: TLabel;
    Label138: TLabel;
    EditDc12: TSpinEdit;
    EditDc12Rate: TSpinEdit;
    GroupBox64: TGroupBox;
    Label139: TLabel;
    Label140: TLabel;
    EditDc22: TSpinEdit;
    EditDc22Rate: TSpinEdit;
    GroupBox65: TGroupBox;
    GroupBox66: TGroupBox;
    Label141: TLabel;
    Label142: TLabel;
    EditMc12: TSpinEdit;
    EditMc12Rate: TSpinEdit;
    GroupBox67: TGroupBox;
    Label143: TLabel;
    Label144: TLabel;
    EditMc22: TSpinEdit;
    EditMc22Rate: TSpinEdit;
    GroupBox68: TGroupBox;
    GroupBox69: TGroupBox;
    Label145: TLabel;
    Label146: TLabel;
    Editsc12: TSpinEdit;
    Editsc12Rate: TSpinEdit;
    GroupBox70: TGroupBox;
    Label147: TLabel;
    Label148: TLabel;
    Editsc22: TSpinEdit;
    Editsc22Rate: TSpinEdit;
    Label149: TLabel;
    GroupBox71: TGroupBox;
    GroupBox72: TGroupBox;
    Label150: TLabel;
    Label151: TLabel;
    Editdc13: TSpinEdit;
    Editdc13Rate: TSpinEdit;
    GroupBox73: TGroupBox;
    Label152: TLabel;
    Label153: TLabel;
    editdc23: TSpinEdit;
    EditDc23Rate: TSpinEdit;
    GroupBox74: TGroupBox;
    GroupBox75: TGroupBox;
    Label154: TLabel;
    Label155: TLabel;
    EditMc13: TSpinEdit;
    EditMc13Rate: TSpinEdit;
    GroupBox76: TGroupBox;
    Label156: TLabel;
    Label157: TLabel;
    EditMc23: TSpinEdit;
    EditMc23Rate: TSpinEdit;
    GroupBox77: TGroupBox;
    GroupBox78: TGroupBox;
    Label158: TLabel;
    Label159: TLabel;
    Editsc13: TSpinEdit;
    Editsc13Rate: TSpinEdit;
    GroupBox79: TGroupBox;
    Label160: TLabel;
    Label161: TLabel;
    Editsc23: TSpinEdit;
    EditSc23Rate: TSpinEdit;
    Label162: TLabel;
    GroupBox80: TGroupBox;
    GroupBox81: TGroupBox;
    Label163: TLabel;
    Label164: TLabel;
    EditDc14: TSpinEdit;
    EditDc14Rate: TSpinEdit;
    GroupBox82: TGroupBox;
    Label165: TLabel;
    Label166: TLabel;
    EditDc24: TSpinEdit;
    EditDc24Rate: TSpinEdit;
    GroupBox83: TGroupBox;
    GroupBox84: TGroupBox;
    Label167: TLabel;
    Label168: TLabel;
    EditMc14: TSpinEdit;
    EditMc14Rate: TSpinEdit;
    GroupBox85: TGroupBox;
    Label169: TLabel;
    Label170: TLabel;
    Editmc24: TSpinEdit;
    EditMc24Rate: TSpinEdit;
    GroupBox86: TGroupBox;
    GroupBox87: TGroupBox;
    Label171: TLabel;
    Label172: TLabel;
    Editsc14: TSpinEdit;
    Editsc14Rate: TSpinEdit;
    GroupBox88: TGroupBox;
    Label173: TLabel;
    Label174: TLabel;
    Editsc24: TSpinEdit;
    Editsc24Rate: TSpinEdit;
    Label175: TLabel;
    GroupBox89: TGroupBox;
    GroupBox90: TGroupBox;
    Label176: TLabel;
    Label177: TLabel;
    EditDC15: TSpinEdit;
    EditDc15Rate: TSpinEdit;
    GroupBox91: TGroupBox;
    Label178: TLabel;
    Label179: TLabel;
    EditDc25: TSpinEdit;
    EditDc25Rate: TSpinEdit;
    GroupBox92: TGroupBox;
    GroupBox93: TGroupBox;
    Label180: TLabel;
    Label181: TLabel;
    EditMc15: TSpinEdit;
    EditMc15Rate: TSpinEdit;
    GroupBox94: TGroupBox;
    Label182: TLabel;
    Label183: TLabel;
    EditMc25: TSpinEdit;
    EditMc25Rate: TSpinEdit;
    GroupBox95: TGroupBox;
    GroupBox96: TGroupBox;
    Label184: TLabel;
    Label185: TLabel;
    EditSc15: TSpinEdit;
    EditSc15Rate: TSpinEdit;
    GroupBox97: TGroupBox;
    Label186: TLabel;
    Label187: TLabel;
    EditSc25: TSpinEdit;
    EditSc25Rate: TSpinEdit;
    Label188: TLabel;
    LabelMagicValue: TLabel;
    BtnEvilSave: TButton;
    EditDc11Rate: TSpinEdit;
    PageControl3: TPageControl;
    TabSheet53: TTabSheet;
    TabSheet36: TTabSheet;
    TabSheet18: TTabSheet;
    GroupBox38: TGroupBox;
    Label98: TLabel;
    EditMagTammingLevel: TSpinEdit;
    GroupBox39: TGroupBox;
    Label99: TLabel;
    Label100: TLabel;
    EditMagTammingTargetLevel: TSpinEdit;
    EditMagTammingHPRate: TSpinEdit;
    GroupBox45: TGroupBox;
    Label111: TLabel;
    EditTammingCount: TSpinEdit;
    TabSheet20: TTabSheet;
    GroupBox46: TGroupBox;
    CheckBoxFireCrossInSafeZone: TCheckBox;
    TabSheet28: TTabSheet;
    GroupBox37: TGroupBox;
    Label97: TLabel;
    EditMagTurnUndeadLevel: TSpinEdit;
    TabSheet22: TTabSheet;
    GroupBox15: TGroupBox;
    Label9: TLabel;
    EditElecBlizzardRange: TSpinEdit;
    TabSheet21: TTabSheet;
    GroupBox13: TGroupBox;
    Label7: TLabel;
    EditFireBoomRage: TSpinEdit;
    TabSheet29: TTabSheet;
    GroupBox14: TGroupBox;
    Label8: TLabel;
    EditSnowWindRange: TSpinEdit;
    TabSheet6: TTabSheet;
    GroupBox16: TGroupBox;
    Label11: TLabel;
    EditAmyOunsulPoint: TSpinEdit;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EditBoneFammName: TEdit;
    EditBoneFammCount: TSpinEdit;
    GroupBox6: TGroupBox;
    GridBoneFamm: TStringGrid;
    TabSheet4: TTabSheet;
    GroupBox11: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EditDogzName: TEdit;
    EditDogzCount: TSpinEdit;
    GroupBox12: TGroupBox;
    GridDogz: TStringGrid;
    TabSheet41: TTabSheet;
    GroupBox41: TGroupBox;
    Label101: TLabel;
    Label102: TLabel;
    EditMabMabeHitRandRate: TSpinEdit;
    EditMabMabeHitMinLvLimit: TSpinEdit;
    GroupBox42: TGroupBox;
    Label103: TLabel;
    EditMabMabeHitSucessRate: TSpinEdit;
    GroupBox43: TGroupBox;
    Label104: TLabel;
    EditMabMabeHitMabeTimeRate: TSpinEdit;
    TabSheet43: TTabSheet;
    GroupBox48: TGroupBox;
    CheckBoxGroupMbAttackPlayObject: TCheckBox;
    TabSheet5: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet11: TTabSheet;
    PageControl4: TPageControl;
    PageControl5: TPageControl;
    PageControl6: TPageControl;
    PageControl7: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    GroupBox98: TGroupBox;
    Label189: TLabel;
    Label190: TLabel;
    EditSkill78PowerRate: TSpinEdit;
    GroupBox99: TGroupBox;
    CbxSkill78SpecialPower: TCheckBox;
    EditSkill78SpecialPower: TSpinEdit;
    Label191: TLabel;
    Label192: TLabel;
    GroupBox100: TGroupBox;
    Label193: TLabel;
    Label194: TLabel;
    EditSkill79PowerRate: TSpinEdit;
    GroupBox101: TGroupBox;
    Label195: TLabel;
    EditSkill79SpecialPower: TSpinEdit;
    Label196: TLabel;
    GroupBox102: TGroupBox;
    Label197: TLabel;
    Label198: TLabel;
    EditSkill80PowerRate: TSpinEdit;
    GroupBox103: TGroupBox;
    Label199: TLabel;
    EditSkill80SpecialPower: TSpinEdit;
    Label200: TLabel;
    GroupBox104: TGroupBox;
    Label201: TLabel;
    Label202: TLabel;
    EditSkill81PowerRate: TSpinEdit;
    GroupBox105: TGroupBox;
    Label203: TLabel;
    EditSkill81SpecialPower: TSpinEdit;
    Label204: TLabel;
    GroupBox106: TGroupBox;
    Label205: TLabel;
    Label206: TLabel;
    EditSkill83PowerRate: TSpinEdit;
    GroupBox107: TGroupBox;
    Label207: TLabel;
    EditSkill83SpecialPower: TSpinEdit;
    Label208: TLabel;
    GroupBox108: TGroupBox;
    Label209: TLabel;
    Label210: TLabel;
    EditSkill85PowerRate: TSpinEdit;
    GroupBox109: TGroupBox;
    Label211: TLabel;
    EditSkill85SpecialPower: TSpinEdit;
    Label212: TLabel;
    CbxSkill79SpecialPower: TCheckBox;
    CbxSkill80SpecialPower: TCheckBox;
    CbxSkill81SpecialPower: TCheckBox;
    CbxSkill83SpecialPower: TCheckBox;
    CbxSkill85SpecialPower: TCheckBox;
    GroupBox110: TGroupBox;
    Label213: TLabel;
    EditSkill85Mon1: TEdit;
    Label214: TLabel;
    EditSkill85Mon2: TEdit;
    Label215: TLabel;
    EditSkill85Mon4: TEdit;
    Label216: TLabel;
    EditSkill85Mon3: TEdit;
    Label218: TLabel;
    EditSkill85Mon5: TEdit;
    TabSheet15: TTabSheet;
    GroupBox111: TGroupBox;
    CheckBox_CanRecallEvil: TCheckBox;
    Label217: TLabel;
    Label219: TLabel;
    Label220: TLabel;
    Edit_MaxRecallEvilCount: TSpinEdit;
    Edit_RecallEvilRate: TSpinEdit;
    Edit_AntiEvilDontMoveTime: TSpinEdit;
    GroupBox112: TGroupBox;
    Label221: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    Edit_EvilCtrlMaxPower: TSpinEdit;
    Edit_EvilCtrl10SecDecPower: TSpinEdit;
    Edit_EvilHellGifMaxValue: TSpinEdit;
    GroupBox113: TGroupBox;
    Label224: TLabel;
    Label225: TLabel;
    Label226: TLabel;
    Edit_EvilUniQueSkillDecPower: TSpinEdit;
    Edit_EvilUniQueSkillRate: TSpinEdit;
    Edit_EvilUniQueSkillDontMoveTime: TSpinEdit;
    Label227: TLabel;
    Edit_UseEvilUniQueSkillTick: TSpinEdit;
    GroupBox114: TGroupBox;
    Label228: TLabel;
    EditShieldRate: TSpinEdit;
    CheckBox1: TCheckBox;
    TabSheet16: TTabSheet;
    PageControl8: TPageControl;
    TabSheet26: TTabSheet;
    GroupBox125: TGroupBox;
    Label250: TLabel;
    EditSkill91MonLevel: TSpinEdit;
    GroupBox126: TGroupBox;
    Label252: TLabel;
    EditSkill91HumLevel: TSpinEdit;
    GroupBox115: TGroupBox;
    Label229: TLabel;
    EditSkill91Rate: TSpinEdit;
    GroupBox116: TGroupBox;
    Label230: TLabel;
    EditSkill91Power: TSpinEdit;
    CheckBoxSKill91Hum: TCheckBox;
    Label231: TLabel;
    SpinEdit4: TSpinEdit;
    GroupBox117: TGroupBox;
    Label232: TLabel;
    SpinEdit5: TSpinEdit;
    GroupBox118: TGroupBox;
    Label233: TLabel;
    SpinEdit7: TSpinEdit;
    GroupBox119: TGroupBox;
    CheckBoxYSskillTree: TCheckBox;
    CheckBoxSkillTree: TCheckBox;
    CheckBoxComSkillNoDecVitaLity: TCheckBox;
    TrackBar2: TTrackBar;
    Label234: TLabel;
    TabSheet17: TTabSheet;
    GroupBox120: TGroupBox;
    Label235: TLabel;
    Label236: TLabel;
    SpinEditFireHitPowerRate: TSpinEdit;
    CheckBoxNoDoubleFireHit: TCheckBox;
    TabSheet19: TTabSheet;
    GroupBox121: TGroupBox;
    Label237: TLabel;
    Label238: TLabel;
    SpinEditPJPowerRate: TSpinEdit;
    TabSheet23: TTabSheet;
    GroupBox122: TGroupBox;
    Label239: TLabel;
    Label240: TLabel;
    SpinEditPDPowerRate: TSpinEdit;
    TabSheet24: TTabSheet;
    GroupBox123: TGroupBox;
    Label241: TLabel;
    SpinEditMagDefenceUpPerdureEx: TSpinEdit;
    TabSheet25: TTabSheet;
    GroupBox124: TGroupBox;
    Label242: TLabel;
    Label243: TLabel;
    SpinEditSkill88PowerRate: TSpinEdit;
    GroupBox127: TGroupBox;
    Label244: TLabel;
    Label245: TLabel;
    SpinEdit14: TSpinEdit;
    TabSheet27: TTabSheet;
    GroupBox128: TGroupBox;
    Label246: TLabel;
    Label247: TLabel;
    SpinEditDiDingPowerRate: TSpinEdit;
    GroupBox129: TGroupBox;
    CheckBoxDiDingAllowPK: TCheckBox;
    GroupBox130: TGroupBox;
    Label248: TLabel;
    Label249: TLabel;
    SpinEditDiDingUseTime: TSpinEdit;
    TabSheet30: TTabSheet;
    GroupBox131: TGroupBox;
    Label251: TLabel;
    Label253: TLabel;
    SpinEditDoMotaeboDelay: TSpinEdit;
    Label254: TLabel;
    TabSheet31: TTabSheet;
    GroupBox132: TGroupBox;
    Label255: TLabel;
    SpinEditBatflyMaxRage: TSpinEdit;
    GroupBox133: TGroupBox;
    Label256: TLabel;
    SpinEditBatflyRate: TSpinEdit;
    Label257: TLabel;
    TabSheet52: TTabSheet;
    TabSheet54: TTabSheet;
    TabSheet55: TTabSheet;
    TabSheet56: TTabSheet;
    TabSheet57: TTabSheet;
    procedure CheckBoxEnablePasswordLockClick(Sender: TObject);
    procedure CheckBoxLockGetBackItemClick(Sender: TObject);
    procedure CheckBoxLockDealItemClick(Sender: TObject);
    procedure CheckBoxLockDropItemClick(Sender: TObject);
    procedure CheckBoxLockWalkClick(Sender: TObject);
    procedure CheckBoxLockRunClick(Sender: TObject);
    procedure CheckBoxLockHitClick(Sender: TObject);
    procedure CheckBoxLockSpellClick(Sender: TObject);
    procedure CheckBoxLockSendMsgClick(Sender: TObject);
    procedure CheckBoxLockInObModeClick(Sender: TObject);
    procedure EditErrorPasswordCountChange(Sender: TObject);
    procedure ButtonPasswordLockSaveClick(Sender: TObject);
    procedure CheckBoxErrorCountKickClick(Sender: TObject);
    procedure CheckBoxLockLoginClick(Sender: TObject);
    procedure CheckBoxLockUseItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxHungerSystemClick(Sender: TObject);
    procedure CheckBoxHungerDecHPClick(Sender: TObject);
    procedure CheckBoxHungerDecPowerClick(Sender: TObject);
    procedure ButtonGeneralSaveClick(Sender: TObject);
    procedure CheckBoxLimitSwordLongClick(Sender: TObject);
    procedure ButtonSkillSaveClick(Sender: TObject);
    procedure EditBoneFammNameChange(Sender: TObject);
    procedure EditBoneFammCountChange(Sender: TObject);
    procedure EditSwordLongPowerRateChange(Sender: TObject);
    procedure EditFireBoomRageChange(Sender: TObject);
    procedure EditSnowWindRangeChange(Sender: TObject);
    procedure EditElecBlizzardRangeChange(Sender: TObject);
    procedure EditDogzCountChange(Sender: TObject);
    procedure EditDogzNameChange(Sender: TObject);
    procedure GridBoneFammSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure EditAmyOunsulPointChange(Sender: TObject);
    procedure EditMagicAttackRageChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCThreePointRateChange(
      Sender: TObject);
    procedure EditUpgradeWeaponMaxPointChange(Sender: TObject);
    procedure EditUpgradeWeaponPriceChange(Sender: TObject);
    procedure EditUPgradeWeaponGetBackTimeChange(Sender: TObject);
    procedure EditClearExpireUpgradeWeaponDaysChange(Sender: TObject);
    procedure ButtonUpgradeWeaponSaveClick(Sender: TObject);
    procedure EditMasterOKLevelChange(Sender: TObject);
    procedure ButtonMasterSaveClick(Sender: TObject);
    procedure EditMasterOKCreditPointChange(Sender: TObject);
    procedure EditMasterOKBonusPointChange(Sender: TObject);
    procedure ScrollBarMakeMineHitRateChange(Sender: TObject);
    procedure ScrollBarMakeMineRateChange(Sender: TObject);
    procedure ScrollBarStoneTypeRateChange(Sender: TObject);
    procedure ScrollBarGoldStoneMaxChange(Sender: TObject);
    procedure ScrollBarSilverStoneMaxChange(Sender: TObject);
    procedure ScrollBarSteelStoneMaxChange(Sender: TObject);
    procedure ScrollBarBlackStoneMaxChange(Sender: TObject);
    procedure ButtonMakeMineSaveClick(Sender: TObject);
    procedure EditStoneMinDuraChange(Sender: TObject);
    procedure EditStoneGeneralDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraMaxChange(Sender: TObject);
    procedure ButtonWinLotterySaveClick(Sender: TObject);
    procedure EditWinLottery1GoldChange(Sender: TObject);
    procedure EditWinLottery2GoldChange(Sender: TObject);
    procedure EditWinLottery3GoldChange(Sender: TObject);
    procedure EditWinLottery4GoldChange(Sender: TObject);
    procedure EditWinLottery5GoldChange(Sender: TObject);
    procedure EditWinLottery6GoldChange(Sender: TObject);
    procedure ScrollBarWinLottery1MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery2MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery3MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery4MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery5MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery6MaxChange(Sender: TObject);
    procedure ScrollBarWinLotteryRateChange(Sender: TObject);
    procedure ButtonReNewLevelSaveClick(Sender: TObject);
    procedure EditReNewNameColor1Change(Sender: TObject);
    procedure EditReNewNameColor2Change(Sender: TObject);
    procedure EditReNewNameColor3Change(Sender: TObject);
    procedure EditReNewNameColor4Change(Sender: TObject);
    procedure EditReNewNameColor5Change(Sender: TObject);
    procedure EditReNewNameColor6Change(Sender: TObject);
    procedure EditReNewNameColor7Change(Sender: TObject);
    procedure EditReNewNameColor8Change(Sender: TObject);
    procedure EditReNewNameColor9Change(Sender: TObject);
    procedure EditReNewNameColor10Change(Sender: TObject);
    procedure EditReNewNameColorTimeChange(Sender: TObject);
    procedure FunctionConfigControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ButtonMonUpgradeSaveClick(Sender: TObject);
    procedure EditMonUpgradeColor1Change(Sender: TObject);
    procedure EditMonUpgradeColor2Change(Sender: TObject);
    procedure EditMonUpgradeColor3Change(Sender: TObject);
    procedure EditMonUpgradeColor4Change(Sender: TObject);
    procedure EditMonUpgradeColor5Change(Sender: TObject);
    procedure EditMonUpgradeColor6Change(Sender: TObject);
    procedure EditMonUpgradeColor7Change(Sender: TObject);
    procedure EditMonUpgradeColor8Change(Sender: TObject);
    procedure EditMonUpgradeColor9Change(Sender: TObject);
    procedure CheckBoxReNewChangeColorClick(Sender: TObject);
    procedure CheckBoxReNewLevelClearExpClick(Sender: TObject);
    procedure EditPKFlagNameColorChange(Sender: TObject);
    procedure EditPKLevel1NameColorChange(Sender: TObject);
    procedure EditPKLevel2NameColorChange(Sender: TObject);
    procedure EditAllyAndGuildNameColorChange(Sender: TObject);
    procedure EditWarGuildNameColorChange(Sender: TObject);
    procedure EditInFreePKAreaNameColorChange(Sender: TObject);
    procedure EditMonUpgradeKillCount1Change(Sender: TObject);
    procedure EditMonUpgradeKillCount2Change(Sender: TObject);
    procedure EditMonUpgradeKillCount3Change(Sender: TObject);
    procedure EditMonUpgradeKillCount4Change(Sender: TObject);
    procedure EditMonUpgradeKillCount5Change(Sender: TObject);
    procedure EditMonUpgradeKillCount6Change(Sender: TObject);
    procedure EditMonUpgradeKillCount7Change(Sender: TObject);
    procedure EditMonUpLvNeedKillBaseChange(Sender: TObject);
    procedure EditMonUpLvRateChange(Sender: TObject);
    procedure CheckBoxMasterDieMutinyClick(Sender: TObject);
    procedure EditMasterDieMutinyRateChange(Sender: TObject);
    procedure EditMasterDieMutinyPowerChange(Sender: TObject);
    procedure EditMasterDieMutinySpeedChange(Sender: TObject);
    procedure ButtonSpiritMutinySaveClick(Sender: TObject);
    procedure CheckBoxSpiritMutinyClick(Sender: TObject);
    procedure EditSpiritMutinyTimeChange(Sender: TObject);
    procedure EditSpiritPowerRateChange(Sender: TObject);
    procedure EditMagTurnUndeadLevelChange(Sender: TObject);
    procedure EditMagTammingLevelChange(Sender: TObject);
    procedure EditMagTammingTargetLevelChange(Sender: TObject);
    procedure EditMagTammingHPRateChange(Sender: TObject);
    procedure ButtonMonSayMsgSaveClick(Sender: TObject);
    procedure CheckBoxMonSayMsgClick(Sender: TObject);
    procedure ButtonUpgradeWeaponDefaulfClick(Sender: TObject);
    procedure ButtonMakeMineDefaultClick(Sender: TObject);
    procedure ButtonWinLotteryDefaultClick(Sender: TObject);
    procedure EditMabMabeHitRandRateChange(Sender: TObject);
    procedure EditMabMabeHitMinLvLimitChange(Sender: TObject);
    procedure EditMabMabeHitSucessRateChange(Sender: TObject);
    procedure EditMabMabeHitMabeTimeRateChange(Sender: TObject);
    procedure ButtonWeaponMakeLuckDefaultClick(Sender: TObject);
    procedure ButtonWeaponMakeLuckSaveClick(Sender: TObject);
    procedure ScrollBarWeaponMakeUnLuckRateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint1Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2RateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3RateChange(Sender: TObject);
    procedure EditTammingCountChange(Sender: TObject);
    procedure CheckBoxFireCrossInSafeZoneClick(Sender: TObject);
    procedure CheckBoxBBMonAutoChangeColorClick(Sender: TObject);
    procedure EditBBMonAutoChangeColorTimeChange(Sender: TObject);
    procedure CheckBoxGroupMbAttackPlayObjectClick(Sender: TObject);
    procedure CheckBoxMasterRunScriptClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBoxEvilAddItemValClick(Sender: TObject);
    procedure BtnEvilSaveClick(Sender: TObject);
    procedure EditKillMonAddZMZRateChange(Sender: TObject);
    procedure EditKillMonAddZMZMAXChange(Sender: TObject);
    procedure EditAddDarkZMZChange(Sender: TObject);
    procedure EditAddDarkofValueChange(Sender: TObject);
    procedure EditAddDarkofRandValueChange(Sender: TObject);
    procedure EditDc11Change(Sender: TObject);
    procedure EditDc11RateChange(Sender: TObject);
    procedure EditDc21Change(Sender: TObject);
    procedure EditDc21RateChange(Sender: TObject);
    procedure EditMc11Change(Sender: TObject);
    procedure EditMc11RateChange(Sender: TObject);
    procedure EditMc21Change(Sender: TObject);
    procedure EditMc21RateChange(Sender: TObject);
    procedure EditSc11Change(Sender: TObject);
    procedure EditSc11RateChange(Sender: TObject);
    procedure EditSc21Change(Sender: TObject);
    procedure EditSc21RateChange(Sender: TObject);
    procedure Editsc22RateChange(Sender: TObject);
    procedure Editsc22Change(Sender: TObject);
    procedure Editsc12Change(Sender: TObject);
    procedure Editsc12RateChange(Sender: TObject);
    procedure EditMc12Change(Sender: TObject);
    procedure EditMc12RateChange(Sender: TObject);
    procedure EditMc22Change(Sender: TObject);
    procedure EditMc22RateChange(Sender: TObject);
    procedure EditDc12Change(Sender: TObject);
    procedure EditDc12RateChange(Sender: TObject);
    procedure EditDc22RateChange(Sender: TObject);
    procedure EditDc22Change(Sender: TObject);
    procedure Editdc13Change(Sender: TObject);
    procedure Editdc13RateChange(Sender: TObject);
    procedure editdc23Change(Sender: TObject);
    procedure EditDc23RateChange(Sender: TObject);
    procedure EditMc13Change(Sender: TObject);
    procedure Editsc13Change(Sender: TObject);
    procedure EditMc13RateChange(Sender: TObject);
    procedure Editsc13RateChange(Sender: TObject);
    procedure EditSc23RateChange(Sender: TObject);
    procedure EditMc23RateChange(Sender: TObject);
    procedure EditMc23Change(Sender: TObject);
    procedure Editsc23Change(Sender: TObject);
    procedure EditDc14Change(Sender: TObject);
    procedure EditMc14Change(Sender: TObject);
    procedure Editsc14Change(Sender: TObject);
    procedure EditDc24Change(Sender: TObject);
    procedure Editmc24Change(Sender: TObject);
    procedure Editsc24Change(Sender: TObject);
    procedure EditDc14RateChange(Sender: TObject);
    procedure EditMc14RateChange(Sender: TObject);
    procedure Editsc14RateChange(Sender: TObject);
    procedure EditDc24RateChange(Sender: TObject);
    procedure EditMc24RateChange(Sender: TObject);
    procedure Editsc24RateChange(Sender: TObject);
    procedure EditDc25RateChange(Sender: TObject);
    procedure EditMc25RateChange(Sender: TObject);
    procedure EditSc25RateChange(Sender: TObject);
    procedure EditSc15RateChange(Sender: TObject);
    procedure EditMc15RateChange(Sender: TObject);
    procedure EditDc15RateChange(Sender: TObject);
    procedure EditDC15Change(Sender: TObject);
    procedure EditMc15Change(Sender: TObject);
    procedure EditSc15Change(Sender: TObject);
    procedure EditDc25Change(Sender: TObject);
    procedure EditMc25Change(Sender: TObject);
    procedure EditSc25Change(Sender: TObject);
    procedure EditSkill85PowerRateChange(Sender: TObject);
    procedure EditSkill85SpecialPowerChange(Sender: TObject);
    procedure CbxSkill85SpecialPowerClick(Sender: TObject);
    procedure EditSkill85Mon1Change(Sender: TObject);
    procedure EditSkill85Mon2Change(Sender: TObject);
    procedure EditSkill85Mon3Change(Sender: TObject);
    procedure EditSkill85Mon4Change(Sender: TObject);
    procedure EditSkill85Mon5Change(Sender: TObject);
    procedure EditSkill83PowerRateChange(Sender: TObject);
    procedure EditSkill81PowerRateChange(Sender: TObject);
    procedure EditSkill80PowerRateChange(Sender: TObject);
    procedure EditSkill79PowerRateChange(Sender: TObject);
    procedure EditSkill78PowerRateChange(Sender: TObject);
    procedure CbxSkill83SpecialPowerClick(Sender: TObject);
    procedure CbxSkill81SpecialPowerClick(Sender: TObject);
    procedure CbxSkill80SpecialPowerClick(Sender: TObject);
    procedure CbxSkill79SpecialPowerClick(Sender: TObject);
    procedure CbxSkill78SpecialPowerClick(Sender: TObject);
    procedure EditSkill83SpecialPowerChange(Sender: TObject);
    procedure EditSkill81SpecialPowerChange(Sender: TObject);
    procedure EditSkill80SpecialPowerChange(Sender: TObject);
    procedure EditSkill79SpecialPowerChange(Sender: TObject);
    procedure EditSkill78SpecialPowerChange(Sender: TObject);
    procedure Edit_MaxRecallEvilCountChange(Sender: TObject);
    procedure CheckBox_CanRecallEvilClick(Sender: TObject);
    procedure EditShieldRateChange(Sender: TObject);
    procedure EditSkill91MonLevelChange(Sender: TObject);
    procedure CheckBoxSkillTreeClick(Sender: TObject);
    procedure CheckBoxYSskillTreeClick(Sender: TObject);
    procedure CheckBoxComSkillNoDecVitaLityClick(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure SpinEditBatflyMaxRageChange(Sender: TObject);
    procedure SpinEditBatflyRateChange(Sender: TObject);
    procedure SpinEditDoMotaeboDelayChange(Sender: TObject);
    procedure SpinEditDiDingPowerRateChange(Sender: TObject);
    procedure SpinEditDiDingUseTimeChange(Sender: TObject);
    procedure CheckBoxDiDingAllowPKClick(Sender: TObject);
    procedure SpinEditSkill88PowerRateChange(Sender: TObject);
    procedure SpinEditMagDefenceUpPerdureExChange(Sender: TObject);
    procedure SpinEditPDPowerRateChange(Sender: TObject);
    procedure SpinEditPJPowerRateChange(Sender: TObject);
    procedure SpinEditFireHitPowerRateChange(Sender: TObject);
    procedure CheckBoxNoDoubleFireHitClick(Sender: TObject);

  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefReNewLevelConf;
    procedure RefUpgradeWeapon;
    procedure RefMakeMine;
    procedure RefWinLottery;
    procedure RefMonUpgrade;
    procedure RefGeneral;
    procedure RefSpiritMutiny;
    procedure RefMagicSkill;
    procedure RefMonSayMsg;
    procedure RefWeaponMakeLuck();
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;

var
  frmFunctionConfig: TfrmFunctionConfig;

implementation

uses M2Share, HUtil32;

{$R *.dfm}

{ TfrmFunctionConfig }

procedure TfrmFunctionConfig.ModValue;
begin
  boModValued := True;
  ButtonPasswordLockSave.Enabled := True;
  ButtonGeneralSave.Enabled := True;
  ButtonSkillSave.Enabled := True;
  ButtonUpgradeWeaponSave.Enabled := True;
  ButtonMasterSave.Enabled := True;
  ButtonMakeMineSave.Enabled := True;
  ButtonWinLotterySave.Enabled := True;
  ButtonReNewLevelSave.Enabled := True;
  ButtonMonUpgradeSave.Enabled := True;
  ButtonSpiritMutinySave.Enabled := True;
  ButtonMonSayMsgSave.Enabled := True;
  BtnEvilSave.Enabled:=True;
end;

procedure TfrmFunctionConfig.uModValue;
begin
  boModValued := False;
  ButtonPasswordLockSave.Enabled := False;
  ButtonGeneralSave.Enabled := False;
  ButtonSkillSave.Enabled := False;
  ButtonUpgradeWeaponSave.Enabled := False;
  ButtonMasterSave.Enabled := False;
  ButtonMakeMineSave.Enabled := False;
  ButtonWinLotterySave.Enabled := False;
  ButtonReNewLevelSave.Enabled := False;
  ButtonMonUpgradeSave.Enabled := False;
  ButtonSpiritMutinySave.Enabled := False;
  ButtonMonSayMsgSave.Enabled := False;
  BtnEvilSave.Enabled:=False;
end;

procedure TfrmFunctionConfig.FunctionConfigControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if boModValued then
  begin
    if Application.MessageBox('参数设置已经被修改，是否确认不保存修改的设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      uModValue
    end
    else
      AllowChange := False;
  end;
end;

procedure TfrmFunctionConfig.Open;
var
  I: Integer;
begin
  boOpened := False;
  uModValue();

  RefGeneral();

  SpinEditBatflyMaxRage.Value:=g_Config.BatflyMaxRage;
  SpinEditBatflyRate.Value:=g_Config.BatflyRate;
  SpinEditDoMotaeboDelay.Value:=g_Config.DoMotaeboDelay;
  SpinEditDiDingPowerRate.Value:=g_config.DiDingPowerRate;
  CheckBoxDiDingAllowPK.Checked:=g_Config.DiDingAllowPK;
  SpinEditDiDingUseTime.Value:=g_Config.DiDingUseTime;
  SpinEditSkill88PowerRate.Value:=g_Config.Skill88PowerRate;
  SpinEditMagDefenceUpPerdureEx.Value:=g_Config.MagDefenceUpPerdureEx;
  SpinEditPDPowerRate.Value:=g_Config.PDPowerRate;

  SpinEditFireHitPowerRate.Value:=g_Config.FireHitPowerRate;
  CheckBoxFireCrossInSafeZone.Checked:=g_Config.NoDoubleFireHit;

  CheckBoxHungerSystem.Checked := g_Config.boHungerSystem;
  CheckBoxHungerDecHP.Checked := g_Config.boHungerDecHP;
  CheckBoxHungerDecPower.Checked := g_Config.boHungerDecPower;
  EditShieldRate.Value:=g_Config.btShieldRate;
  CheckBoxHungerSystemClick(CheckBoxHungerSystem);


  CheckBoxEnablePasswordLock.Checked := g_Config.boPasswordLockSystem;
  CheckBoxLockGetBackItem.Checked := g_Config.boLockGetBackItemAction;
  CheckBoxLockDealItem.Checked := g_Config.boLockDealAction;
  CheckBoxLockDropItem.Checked := g_Config.boLockDropAction;
  CheckBoxLockWalk.Checked := g_Config.boLockWalkAction;
  CheckBoxLockRun.Checked := g_Config.boLockRunAction;
  CheckBoxLockHit.Checked := g_Config.boLockHitAction;
  CheckBoxLockSpell.Checked := g_Config.boLockSpellAction;
  CheckBoxLockSendMsg.Checked := g_Config.boLockSendMsgAction;
  CheckBoxLockInObMode.Checked := g_Config.boLockInObModeAction;

  CheckBoxLockLogin.Checked := g_Config.boLockHumanLogin;
  CheckBoxLockUseItem.Checked := g_Config.boLockUserItemAction;

  CheckBoxEnablePasswordLockClick(CheckBoxEnablePasswordLock);
  CheckBoxLockLoginClick(CheckBoxLockLogin);

  EditErrorPasswordCount.Value := g_Config.nPasswordErrorCountLock;

  CheckBoxSkillTree.Checked := g_Config.PlayerSkillTree;
  CheckBoxYSskillTree.Checked := g_Config.YSSkillTree;
  CheckBoxComSkillNoDecVitaLity.Checked :=g_Config.ComSkillNoDecVitaLity;
  TrackBar2.Position:=g_Config.VitaLityAddSpeed;

  EditBoneFammName.Text := g_Config.sBoneFamm;
  EditBoneFammCount.Value := g_Config.nBoneFammCount;

  for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do
  begin
    if g_Config.BoneFammArray[I].nHumLevel <= 0 then
      break;

    GridBoneFamm.Cells[0, I + 1] := IntToStr(g_Config.BoneFammArray[I].nHumLevel);
    GridBoneFamm.Cells[1, I + 1] := g_Config.BoneFammArray[I].sMonName;
    GridBoneFamm.Cells[2, I + 1] := IntToStr(g_Config.BoneFammArray[I].nCount);
    GridBoneFamm.Cells[3, I + 1] := IntToStr(g_Config.BoneFammArray[I].nLevel);
  end;

  EditDogzName.Text := g_Config.sDogz;
  EditDogzCount.Value := g_Config.nDogzCount;
  for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do
  begin
    if g_Config.DogzArray[I].nHumLevel <= 0 then
      break;
    GridDogz.Cells[0, I + 1] := IntToStr(g_Config.DogzArray[I].nHumLevel);
    GridDogz.Cells[1, I + 1] := g_Config.DogzArray[I].sMonName;
    GridDogz.Cells[2, I + 1] := IntToStr(g_Config.DogzArray[I].nCount);
    GridDogz.Cells[3, I + 1] := IntToStr(g_Config.DogzArray[I].nLevel);
  end;

  RefMagicSkill();

  RefUpgradeWeapon();
  RefMakeMine();
  RefWinLottery();
  EditMasterOKLevel.Value := g_Config.nMasterOKLevel;
  EditMasterOKCreditPoint.Value := g_Config.nMasterOKCreditPoint;
  EditMasterOKBonusPoint.Value := g_Config.nMasterOKBonusPoint;
  CheckBoxMasterRunScript.Checked := g_Config.nMasterRunScript;



  CheckBoxEvilAddItemVal.Checked:=g_Config.boEvilAddItemVal;
  EditAddDarkZMZ.Value:=g_Config.nAddDarkofZMZ;
  EditAddDarkofValue.Value:=g_Config.nAddDarkofValue;
  EditAddDarkofRandValue.Value:=g_Config.nAddDarkofRandValue;
  EditKillMonAddZMZRate.Value:=g_Config.nKillMonAddZMZRate;
  EditKillMonAddZMZMAX.Value:=g_Config.nKillMonAddZMZMax;
  TrackBar1.Position:=g_Config.nDecZMZSpeed;

  EditDc11.Value:=g_Config.nEvilDc1[0];
  EditDc11Rate.Value:=g_Config.nEvilDcRate1[0];
  EditDc21.Value:=g_Config.nEvilDc2[0];
  EditDc21Rate.Value:=g_Config.nEvilDcRate2[0];

  EditMc11.Value:=g_Config.nEvilMc1[0];
  EditMc11Rate.Value:=g_Config.nEvilMcRate1[0];
  EditMc21.Value:=g_Config.nEvilMc2[0];
  EditMc21Rate.Value:=g_Config.nEvilMcRate2[0];

  EditSc11.Value:=g_Config.nEvilSc1[0];
  EditSc11Rate.Value:=g_Config.nEvilScRate1[0];
  EditSc21.Value:=g_Config.nEvilSc2[0];
  EditSc21Rate.Value:=g_Config.nEvilScRate2[0];

  EditDc12.Value:=g_Config.nEvilDc1[1];
  EditDc12Rate.Value:=g_Config.nEvilDcRate1[1];
  EditDc22.Value:=g_Config.nEvilDc2[1];
  EditDc22Rate.Value:=g_Config.nEvilDcRate2[1];

  EditMc12.Value:=g_Config.nEvilMc1[1];
  EditMc12Rate.Value:=g_Config.nEvilMcRate1[1];
  EditMc22.Value:=g_Config.nEvilMc2[1];
  EditMc22Rate.Value:=g_Config.nEvilMcRate2[1];

  EditSc12.Value:=g_Config.nEvilSc1[1];
  EditSc12Rate.Value:=g_Config.nEvilScRate1[1];
  EditSc22.Value:=g_Config.nEvilSc2[1];
  EditSc22Rate.Value:=g_Config.nEvilScRate2[1];


  EditDc13.Value:=g_Config.nEvilDc1[2];
  EditDc13Rate.Value:=g_Config.nEvilDcRate1[2];
  EditDc23.Value:=g_Config.nEvilDc2[2];
  EditDc23Rate.Value:=g_Config.nEvilDcRate2[2];

  EditMc13.Value:=g_Config.nEvilMc1[2];
  EditMc13Rate.Value:=g_Config.nEvilMcRate1[2];
  EditMc23.Value:=g_Config.nEvilMc2[2];
  EditMc23Rate.Value:=g_Config.nEvilMcRate2[2];

  EditSc13.Value:=g_Config.nEvilSc1[2];
  EditSc13Rate.Value:=g_Config.nEvilScRate1[2];
  EditSc23.Value:=g_Config.nEvilSc2[2];
  EditSc23Rate.Value:=g_Config.nEvilScRate2[2];

  EditDc14.Value:=g_Config.nEvilDc1[3];
  EditDc14Rate.Value:=g_Config.nEvilDcRate1[3];
  EditDc24.Value:=g_Config.nEvilDc2[3];
  EditDc24Rate.Value:=g_Config.nEvilDcRate2[3];

  EditMc14.Value:=g_Config.nEvilMc1[3];
  EditMc14Rate.Value:=g_Config.nEvilMcRate1[3];
  EditMc24.Value:=g_Config.nEvilMc2[3];
  EditMc24Rate.Value:=g_Config.nEvilMcRate2[3];

  EditSc14.Value:=g_Config.nEvilSc1[3];
  EditSc14Rate.Value:=g_Config.nEvilScRate1[3];
  EditSc24.Value:=g_Config.nEvilSc2[3];
  EditSc24Rate.Value:=g_Config.nEvilScRate2[3];

  EditDc15.Value:=g_Config.nEvilDc1[4];
  EditDc15Rate.Value:=g_Config.nEvilDcRate1[4];
  EditDc25.Value:=g_Config.nEvilDc2[4];
  EditDc25Rate.Value:=g_Config.nEvilDcRate2[4];

  EditMc15.Value:=g_Config.nEvilMc1[4];
  EditMc15Rate.Value:=g_Config.nEvilMcRate1[4];
  EditMc25.Value:=g_Config.nEvilMc2[4];
  EditMc25Rate.Value:=g_Config.nEvilMcRate2[4];

  EditSc15.Value:=g_Config.nEvilSc1[4];
  EditSc15Rate.Value:=g_Config.nEvilScRate1[4];
  EditSc25.Value:=g_Config.nEvilSc2[4];
  EditSc25Rate.Value:=g_Config.nEvilScRate2[4];

  CheckBox_CanRecallEvil.Checked :=g_Config.CallEvilConf.boCanRecallEvil ;
  Edit_MaxRecallEvilCount.Value:=g_Config.CallEvilConf.nMaxRecallEvilCount;
  Edit_RecallEvilRate.Value:=g_Config.CallEvilConf.nRecallEvilRate;
  Edit_AntiEvilDontMoveTime.Value:=g_Config.CallEvilConf.nAntiEvilDontMoveTime;
  Edit_EvilCtrlMaxPower.Value:=g_Config.CallEvilConf.nEvilCtrlMaxPower;
  Edit_EvilCtrl10SecDecPower.Value:=g_Config.CallEvilConf.nEvilCtrl10SecDecPower;
  Edit_EvilHellGifMaxValue.Value:=g_Config.CallEvilConf.nEvilHellGifMaxValue;
  Edit_EvilUniQueSkillDecPower.Value:=g_Config.CallEvilConf.nEvilUniQueSkillDecPower;
  Edit_EvilUniQueSkillRate.Value:=g_Config.CallEvilConf.nEvilUniQueSkillRate;
  Edit_EvilUniQueSkillDontMoveTime.Value:=g_Config.CallEvilConf.nEvilUniQueSkillDontMoveTime;
  Edit_UseEvilUniQueSkillTick.Value:=g_Config.CallEvilConf.nUseEvilUniQueSkillTick;

  RefReNewLevelConf();
  RefMonUpgrade();
  RefSpiritMutiny();
  RefMonSayMsg();
  RefWeaponMakeLuck();
  boOpened := True;
  FunctionConfigControl.ActivePageIndex := 0;
  ShowModal;
end;

procedure TfrmFunctionConfig.FormCreate(Sender: TObject);
begin
  GridBoneFamm.Cells[0, 0] := '人物等级';
  GridBoneFamm.Cells[1, 0] := '怪物名称';
  GridBoneFamm.Cells[2, 0] := '数量';
  GridBoneFamm.Cells[3, 0] := '等级';

  GridDogz.Cells[0, 0] := '人物等级';
  GridDogz.Cells[1, 0] := '怪物名称';
  GridDogz.Cells[2, 0] := '数量';
  GridDogz.Cells[3, 0] := '等级';
  FunctionConfigControl.ActivePageIndex := 0;
  //MagicPageControl.ActivePageIndex := 0;
{$IF (SoftVersion = VERPRO) or (SoftVersion = VERENT)}
  CheckBoxHungerDecPower.Visible := True;
{$ELSE}
  CheckBoxHungerDecPower.Visible := False;
{$IFEND}

{$IF SoftVersion = VERDEMO}
  Caption := '功能设置[演示版本，所有设置调整有效，但不能保存]'
{$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxEnablePasswordLockClick(
  Sender: TObject);
begin
  case CheckBoxEnablePasswordLock.Checked of
    True:
      begin
        CheckBoxLockGetBackItem.Enabled := True;
        CheckBoxLockLogin.Enabled := True;
      end;
    False:
      begin
        CheckBoxLockGetBackItem.Checked := False;
        CheckBoxLockLogin.Checked := False;

        CheckBoxLockGetBackItem.Enabled := False;
        CheckBoxLockLogin.Enabled := False;
      end;
  end;
  if not boOpened then
    exit;
  g_Config.boPasswordLockSystem := CheckBoxEnablePasswordLock.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockGetBackItemClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockGetBackItemAction := CheckBoxLockGetBackItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockDealItemClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockDealAction := CheckBoxLockDealItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockDropItemClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockDropAction := CheckBoxLockDropItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockUseItemClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockUserItemAction := CheckBoxLockUseItem.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxLockLoginClick(Sender: TObject);
begin
  case CheckBoxLockLogin.Checked of //
    True:
      begin
        CheckBoxLockWalk.Enabled := True;
        CheckBoxLockRun.Enabled := True;
        CheckBoxLockHit.Enabled := True;
        CheckBoxLockSpell.Enabled := True;
        CheckBoxLockInObMode.Enabled := True;
        CheckBoxLockSendMsg.Enabled := True;
        CheckBoxLockDealItem.Enabled := True;
        CheckBoxLockDropItem.Enabled := True;
        CheckBoxLockUseItem.Enabled := True;
      end;
    False:
      begin
        CheckBoxLockWalk.Checked := False;
        CheckBoxLockRun.Checked := False;
        CheckBoxLockHit.Checked := False;
        CheckBoxLockSpell.Checked := False;
        CheckBoxLockInObMode.Checked := False;
        CheckBoxLockSendMsg.Checked := False;
        CheckBoxLockDealItem.Checked := False;
        CheckBoxLockDropItem.Checked := False;
        CheckBoxLockUseItem.Checked := False;

        CheckBoxLockWalk.Enabled := False;
        CheckBoxLockRun.Enabled := False;
        CheckBoxLockHit.Enabled := False;
        CheckBoxLockSpell.Enabled := False;
        CheckBoxLockInObMode.Enabled := False;
        CheckBoxLockSendMsg.Enabled := False;
        CheckBoxLockDealItem.Enabled := False;
        CheckBoxLockDropItem.Enabled := False;
        CheckBoxLockUseItem.Enabled := False;
      end;
  end;
  if not boOpened then
    exit;
  g_Config.boLockHumanLogin := CheckBoxLockLogin.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxLockWalkClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockWalkAction := CheckBoxLockWalk.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockRunClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockRunAction := CheckBoxLockRun.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockHitClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockHitAction := CheckBoxLockHit.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockSpellClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockSpellAction := CheckBoxLockSpell.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockSendMsgClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockSendMsgAction := CheckBoxLockSendMsg.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockInObModeClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLockInObModeAction := CheckBoxLockInObMode.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditErrorPasswordCountChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxErrorCountKickClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxEvilAddItemValClick(Sender: TObject);
begin

  if not boOpened then
    exit;
  g_Config.boEvilAddItemVal := CheckBoxEvilAddItemVal.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonPasswordLockSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'PasswordLockSystem', g_Config.boPasswordLockSystem);
  Config.WriteBool('Setup', 'PasswordLockDealAction', g_Config.boLockDealAction);
  Config.WriteBool('Setup', 'PasswordLockDropAction', g_Config.boLockDropAction);
  Config.WriteBool('Setup', 'PasswordLockGetBackItemAction', g_Config.boLockGetBackItemAction);
  Config.WriteBool('Setup', 'PasswordLockWalkAction', g_Config.boLockWalkAction);
  Config.WriteBool('Setup', 'PasswordLockRunAction', g_Config.boLockRunAction);
  Config.WriteBool('Setup', 'PasswordLockHitAction', g_Config.boLockHitAction);
  Config.WriteBool('Setup', 'PasswordLockSpellAction', g_Config.boLockSpellAction);
  Config.WriteBool('Setup', 'PasswordLockSendMsgAction', g_Config.boLockSendMsgAction);
  Config.WriteBool('Setup', 'PasswordLockInObModeAction', g_Config.boLockInObModeAction);
  Config.WriteBool('Setup', 'PasswordLockUserItemAction', g_Config.boLockUserItemAction);

  Config.WriteBool('Setup', 'PasswordLockHumanLogin', g_Config.boLockHumanLogin);
  Config.WriteInteger('Setup', 'PasswordErrorCountLock', g_Config.nPasswordErrorCountLock);

{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.RefGeneral();
begin
  EditPKFlagNameColor.Value := g_Config.btPKFlagNameColor;
  EditPKLevel1NameColor.Value := g_Config.btPKLevel1NameColor;
  EditPKLevel2NameColor.Value := g_Config.btPKLevel2NameColor;
  EditAllyAndGuildNameColor.Value := g_Config.btAllyAndGuildNameColor;
  EditWarGuildNameColor.Value := g_Config.btWarGuildNameColor;
  EditInFreePKAreaNameColor.Value := g_Config.btInFreePKAreaNameColor;
end;

procedure TfrmFunctionConfig.CheckBoxHungerSystemClick(Sender: TObject);
begin
  if CheckBoxHungerSystem.Checked then
  begin
    CheckBoxHungerDecHP.Enabled := True;
    CheckBoxHungerDecPower.Enabled := True;
  end
  else
  begin
    CheckBoxHungerDecHP.Checked := False;
    CheckBoxHungerDecPower.Checked := False;
    CheckBoxHungerDecHP.Enabled := False;
    CheckBoxHungerDecPower.Enabled := False;
  end;

  if not boOpened then
    exit;
  g_Config.boHungerSystem := CheckBoxHungerSystem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxHungerDecHPClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boHungerDecHP := CheckBoxHungerDecHP.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxHungerDecPowerClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boHungerDecPower := CheckBoxHungerDecPower.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.BtnEvilSaveClick(Sender: TObject);
var
  i  : Integer;
begin

  Config.WriteBool('EVIL', 'EvilAddItemVal', g_Config.boEvilAddItemVal);
  Config.WriteInteger('EVIL', 'KillMonAddZMZRate', g_Config.nKillMonAddZMZRate);
  Config.WriteInteger('EVIL', 'KillMonAddZMZMax', g_Config.nKillMonAddZMZRate);
  Config.WriteInteger('EVIL', 'AddDarkofZMZ', g_Config.nAddDarkofZMZ);
  Config.WriteInteger('EVIL', 'nAddDarkofValue', g_Config.nAddDarkofValue);
  Config.WriteInteger('EVIL', 'AddDarkofRandValue', g_Config.nAddDarkofRandValue);

  g_Config.CallEvilConf.boCanRecallEvil := CheckBox_CanRecallEvil.Checked ;
  g_Config.CallEvilConf.nMaxRecallEvilCount := Edit_MaxRecallEvilCount.Value;
  g_Config.CallEvilConf.nRecallEvilRate := Edit_RecallEvilRate.Value;
  g_Config.CallEvilConf.nAntiEvilDontMoveTime := Edit_AntiEvilDontMoveTime.Value;
  g_Config.CallEvilConf.nEvilCtrlMaxPower := Edit_EvilCtrlMaxPower.Value;
  g_Config.CallEvilConf.nEvilCtrl10SecDecPower := Edit_EvilCtrl10SecDecPower.Value;
  g_Config.CallEvilConf.nEvilHellGifMaxValue := Edit_EvilHellGifMaxValue.Value;
  g_Config.CallEvilConf.nEvilUniQueSkillDecPower := Edit_EvilUniQueSkillDecPower.Value;
  g_Config.CallEvilConf.nEvilUniQueSkillRate := Edit_EvilUniQueSkillRate.Value;
  g_Config.CallEvilConf.nEvilUniQueSkillDontMoveTime := Edit_EvilUniQueSkillDontMoveTime.Value;
  g_Config.CallEvilConf.nUseEvilUniQueSkillTick := Edit_UseEvilUniQueSkillTick.Value;

    Config.WriteBool('RecallEvil', 'CanRecallEvil', g_Config.CallEvilConf.boCanRecallEvil);
    Config.WriteInteger('RecallEvil', 'MaxRecallEvilCount', g_Config.CallEvilConf.nMaxRecallEvilCount);
    Config.WriteInteger('RecallEvil', 'RecallEvilRate', g_Config.CallEvilConf.nRecallEvilRate);
    Config.WriteInteger('RecallEvil', 'AntiEvilDontMoveTime', g_Config.CallEvilConf.nAntiEvilDontMoveTime);
    Config.WriteInteger('RecallEvil', 'EvilCtrlMaxPower', g_Config.CallEvilConf.nEvilCtrlMaxPower);

    Config.WriteInteger('RecallEvil', 'EvilCtrl10SecDecPower', g_Config.CallEvilConf.nEvilCtrl10SecDecPower);
    Config.WriteInteger('RecallEvil', 'EvilHellGifMaxValue', g_Config.CallEvilConf.nEvilHellGifMaxValue );
    Config.WriteInteger('RecallEvil', 'EvilUniQueSkillDecPower', g_Config.CallEvilConf.nEvilUniQueSkillDecPower);
    Config.WriteInteger('RecallEvil', 'EvilUniQueSkillRate',g_Config.CallEvilConf.nEvilUniQueSkillRate);
    Config.WriteInteger('RecallEvil', 'EvilUniQueSkillDontMoveTime', g_Config.CallEvilConf.nEvilUniQueSkillDontMoveTime);
    Config.WriteInteger('RecallEvil', 'UseEvilUniQueSkillTick',  g_Config.CallEvilConf.nUseEvilUniQueSkillTick);

  
  for I := 0 to 4 do
  Begin
    Config.WriteInteger('EVIL', 'EvilDc1'+inttostr(i), g_Config.nEvilDc1[i]);

    Config.WriteInteger('EVIL', 'EvilDc2'+inttostr(i), g_Config.nEvilDc2[i]);


    Config.WriteInteger('EVIL', 'EvilMc1'+inttostr(i), g_Config.nEvilMc1[i]);

    Config.WriteInteger('EVIL', 'EvilMc2'+inttostr(i), g_Config.nEvilMc2[i]);


    Config.WriteInteger('EVIL', 'EvilSc1'+inttostr(i), g_Config.nEvilSc1[i]);

    Config.WriteInteger('EVIL', 'EvilSc2'+inttostr(i), g_Config.nEvilSc2[i]);


     Config.WriteInteger('EVIL', 'EvilDcRate1'+inttostr(i), g_Config.nEvilDcRate1[i]);

    Config.WriteInteger('EVIL', 'EvilDcRate2'+inttostr(i), g_Config.nEvilDcRate2[i]);


    Config.WriteInteger('EVIL', 'EvilMcRate1'+inttostr(i), g_Config.nEvilMcRate1[i]);

    Config.WriteInteger('EVIL', 'EvilMcRate2'+inttostr(i), g_Config.nEvilMcRate2[i]);


    Config.WriteInteger('EVIL', 'EvilScRate1'+inttostr(i), g_Config.nEvilScRate1[i]);

    Config.WriteInteger('EVIL', 'EvilScRate2'+inttostr(i), g_Config.nEvilScRate2[i]);





  End;

  uModValue();
end;

procedure TfrmFunctionConfig.ButtonGeneralSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'HungerSystem', g_Config.boHungerSystem);
  Config.WriteBool('Setup', 'HungerDecHP', g_Config.boHungerDecHP);
  Config.WriteBool('Setup', 'HungerDecPower', g_Config.boHungerDecPower);
  Config.WriteInteger('Setup', 'ShieldRate', g_Config.btShieldRate);
  Config.WriteInteger('Setup', 'PKFlagNameColor', g_Config.btPKFlagNameColor);
  Config.WriteInteger('Setup', 'AllyAndGuildNameColor', g_Config.btAllyAndGuildNameColor);
  Config.WriteInteger('Setup', 'WarGuildNameColor', g_Config.btWarGuildNameColor);
  Config.WriteInteger('Setup', 'InFreePKAreaNameColor', g_Config.btInFreePKAreaNameColor);
  Config.WriteInteger('Setup', 'PKLevel1NameColor', g_Config.btPKLevel1NameColor);
  Config.WriteInteger('Setup', 'PKLevel2NameColor', g_Config.btPKLevel2NameColor);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditMagicAttackRageChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMagicAttackRage := EditMagicAttackRage.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.RefMagicSkill;
begin
  EditSkill78PowerRate.Value:=g_Config.nSkill78PowerRate;
  EditSkill78SpecialPower.Value:=g_Config.nSkill78SpecialPower;
  CbxSkill78SpecialPower.Checked:=g_Config.boSkill78SpecialPower;

  EditSkill79PowerRate.Value:=g_Config.nSkill79PowerRate;
  EditSkill79SpecialPower.Value:=g_Config.nSkill79SpecialPower;
  CbxSkill79SpecialPower.Checked:=g_Config.boSkill79SpecialPower;

  EditSkill91MonLevel.Value:=g_Config.nSkill91MonLevel;
  EditSkill91Rate.Value:=g_Config.nSkill91Rate;
  EditSkill91Power.Value:=g_Config.nSkill91Power;
  EditSkill91HumLevel.Value:=g_Config.nSkill91HumLevel;
  CheckBoxSKill91Hum.Checked :=g_Config.boSkill91HumLevel;

  EditSkill80PowerRate.Value:=g_Config.nSkill80PowerRate;
  EditSkill80SpecialPower.Value:=g_Config.nSkill80SpecialPower;
  CbxSkill80SpecialPower.Checked:=g_Config.boSkill80SpecialPower;

  EditSkill81PowerRate.Value:=g_Config.nSkill81PowerRate;
  EditSkill81SpecialPower.Value:=g_Config.nSkill81SpecialPower;
  CbxSkill81SpecialPower.Checked:=g_Config.boSkill81SpecialPower;

  EditSkill83PowerRate.Value:=g_Config.nSkill83PowerRate;
  EditSkill83SpecialPower.Value:=g_Config.nSkill83SpecialPower;
  CbxSkill83SpecialPower.Checked:=g_Config.boSkill83SpecialPower;

  EditSkill85PowerRate.Value:=g_Config.nSkill85PowerRate;
  EditSkill85SpecialPower.Value:=g_Config.nSkill85SpecialPower;
  CbxSkill85SpecialPower.Checked:=g_Config.boSkill85SpecialPower;
  EditSkill85Mon1.Text:=g_Config.sSkill85Mon1;
  EditSkill85Mon2.Text:=g_Config.sSkill85Mon2;
  EditSkill85Mon3.Text:=g_Config.sSkill85Mon3;
  EditSkill85Mon4.Text:=g_Config.sSkill85Mon4;
  EditSkill85Mon5.Text:=g_Config.sSkill85Mon5;
  EditSwordLongPowerRate.Value := g_Config.nSwordLongPowerRate;
  CheckBoxLimitSwordLong.Checked := g_Config.boLimitSwordLong;
  EditFireBoomRage.Value := g_Config.nFireBoomRage;
  EditSnowWindRange.Value := g_Config.nSnowWindRange;
  EditElecBlizzardRange.Value := g_Config.nElecBlizzardRange;
  EditMagicAttackRage.Value := g_Config.nMagicAttackRage;
  EditAmyOunsulPoint.Value := g_Config.nAmyOunsulPoint;
  EditMagTurnUndeadLevel.Value := g_Config.nMagTurnUndeadLevel;
  EditMagTammingLevel.Value := g_Config.nMagTammingLevel;
  EditMagTammingTargetLevel.Value := g_Config.nMagTammingTargetLevel;
  EditMagTammingHPRate.Value := g_Config.nMagTammingHPRate;
  EditTammingCount.Value := g_Config.nMagTammingCount;
  EditMabMabeHitRandRate.Value := g_Config.nMabMabeHitRandRate;
  EditMabMabeHitMinLvLimit.Value := g_Config.nMabMabeHitMinLvLimit;
  EditMabMabeHitSucessRate.Value := g_Config.nMabMabeHitSucessRate;
  EditMabMabeHitMabeTimeRate.Value := g_Config.nMabMabeHitMabeTimeRate;
  CheckBoxFireCrossInSafeZone.Checked := g_Config.boDisableInSafeZoneFireCross;
  CheckBoxGroupMbAttackPlayObject.Checked := g_Config.boGroupMbAttackPlayObject;
end;

procedure TfrmFunctionConfig.EditBoneFammCountChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nBoneFammCount := EditBoneFammCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc11Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc1[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc11RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate1[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc12Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc1[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc12RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate1[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editdc13Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc1[2] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editdc13RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate1[2] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc14Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc1[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc14RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate1[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDC15Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc1[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc15RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate1[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc21Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc2[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc21RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate2[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc22Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc2[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc22RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate2[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.editdc23Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc2[2] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc23RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate2[2] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc24Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc2[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc24RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate2[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc25Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDc2[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDc25RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilDcRate2[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDogzCountChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nDogzCount := EditDogzCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLimitSwordLongClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boLimitSwordLong := CheckBoxLimitSwordLong.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSwordLongPowerRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSwordLongPowerRate := EditSwordLongPowerRate.Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditBoneFammNameChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDogzNameChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditFireBoomRageChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nFireBoomRage := EditFireBoomRage.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSc11Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc1[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSc11RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate1[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editsc12Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc1[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editsc12RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate1[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editsc13Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc1[2] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editsc13RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate1[2] := TSpinEdit(Sender).Value;
  ModValue();

end;

procedure TfrmFunctionConfig.Editsc14Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc1[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editsc14RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate1[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSc15Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc1[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSc15RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate1[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSc21Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc1[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSc21RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate1[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editsc22Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc2[1] := TSpinEdit(Sender).Value;
  ModValue();

end;

procedure TfrmFunctionConfig.Editsc22RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate2[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editsc23Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc2[2] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSc23RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate2[2] := TSpinEdit(Sender).Value;
  ModValue();

end;

procedure TfrmFunctionConfig.Editsc24Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc2[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Editsc24RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate2[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSc25Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilSc2[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSc25RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilScRate2[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditShieldRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
g_Config.btShieldRate:=EditShieldRate.Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill81SpecialPowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill81SpecialPower :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill78PowerRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill78PowerRate :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill78SpecialPowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill78SpecialPower :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill79PowerRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill79PowerRate :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill79SpecialPowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill79SpecialPower :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill80PowerRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill80PowerRate :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill80SpecialPowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill80SpecialPower :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill81PowerRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill81PowerRate :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill83PowerRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill83PowerRate :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill83SpecialPowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill83SpecialPower :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill85Mon1Change(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.sSkill85Mon1:=TEdit(Sender).text;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill85Mon2Change(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.sSkill85Mon2:=TEdit(Sender).text;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill85Mon3Change(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.sSkill85Mon3:=TEdit(Sender).text;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill85Mon4Change(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.sSkill85Mon4:=TEdit(Sender).text;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill85Mon5Change(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.sSkill85Mon5:=TEdit(Sender).text;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill85PowerRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill85PowerRate :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill85SpecialPowerChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill85SpecialPower :=TSpinEdit(Sender).Value;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSkill91MonLevelChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSkill91MonLevel := EditSkill91MonLevel.Value;
  g_Config.nSkill91Rate := EditSkill91Rate.Value;
  g_Config.nSkill91Power := EditSkill91Power.Value;
  g_Config.nSkill91HumLevel := EditSkill91HumLevel.Value;
  g_Config.boSkill91HumLevel := CheckBoxSKill91Hum.Checked;
  ModValue()
end;

procedure TfrmFunctionConfig.EditSnowWindRangeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSnowWindRange := EditSnowWindRange.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditElecBlizzardRangeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nElecBlizzardRange := EditElecBlizzardRange.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTurnUndeadLevelChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMagTurnUndeadLevel := EditMagTurnUndeadLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.GridBoneFammSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  if not boOpened then
    exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditAmyOunsulPointChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nAmyOunsulPoint := EditAmyOunsulPoint.Value;
  ModValue();
end;


procedure TfrmFunctionConfig.CheckBoxFireCrossInSafeZoneClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boDisableInSafeZoneFireCross := CheckBoxFireCrossInSafeZone.Checked;
  ModValue();
end;


procedure TfrmFunctionConfig.CheckBoxGroupMbAttackPlayObjectClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boGroupMbAttackPlayObject := CheckBoxGroupMbAttackPlayObject.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSkillSaveClick(Sender: TObject);
var
  I: Integer;
  RecallArray: array[0..9] of TRecallMigic;
  Rect: TGridRect;
begin
  FillChar(RecallArray, SizeOf(RecallArray), #0);

  g_Config.sBoneFamm := Trim(EditBoneFammName.Text);

  for I := Low(RecallArray) to High(RecallArray) do
  begin
    RecallArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I + 1], -1);
    RecallArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
    RecallArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1], -1);
    RecallArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1], -1);
    if GridBoneFamm.Cells[0, I + 1] = '' then
      break;
    if (RecallArray[I].nHumLevel <= 0) then
    begin
      Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 0;
      Rect.Top := I + 1;
      Rect.Right := 0;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      exit;
    end;






    if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then
    begin
      Application.MessageBox('怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 1;
      Rect.Top := I + 1;
      Rect.Right := 1;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      exit;
    end;
    if RecallArray[I].nCount <= 0 then
    begin
      Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 2;
      Rect.Top := I + 1;
      Rect.Right := 2;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      exit;
    end;
    if RecallArray[I].nLevel < 0 then
    begin
      Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 3;
      Rect.Top := I + 1;
      Rect.Right := 3;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      exit;
    end;
  end;

  for I := Low(RecallArray) to High(RecallArray) do
  begin
    RecallArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1], -1);
    RecallArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
    RecallArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
    RecallArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);
    if GridDogz.Cells[0, I + 1] = '' then
      break;
    if (RecallArray[I].nHumLevel <= 0) then
    begin
      Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 0;
      Rect.Top := I + 1;
      Rect.Right := 0;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      exit;
    end;
    if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then
    begin
      Application.MessageBox('怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 1;
      Rect.Top := I + 1;
      Rect.Right := 1;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      exit;
    end;
    if RecallArray[I].nCount <= 0 then
    begin
      Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 2;
      Rect.Top := I + 1;
      Rect.Right := 2;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      exit;
    end;
    if RecallArray[I].nLevel < 0 then
    begin
      Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 3;
      Rect.Top := I + 1;
      Rect.Right := 3;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      exit;
    end;
  end;
  FillChar(g_Config.BoneFammArray, SizeOf(g_Config.BoneFammArray), #0);
  for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do
  begin
    Config.WriteInteger('Setup', 'BoneFammHumLevel' + IntToStr(I), 0);
    Config.WriteString('Names', 'BoneFamm' + IntToStr(I), '');
    Config.WriteInteger('Setup', 'BoneFammCount' + IntToStr(I), 0);
    Config.WriteInteger('Setup', 'BoneFammLevel' + IntToStr(I), 0);
  end;
  for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do
  begin
    if GridBoneFamm.Cells[0, I + 1] = '' then
      break;
    g_Config.BoneFammArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I + 1], -1);
    g_Config.BoneFammArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
    g_Config.BoneFammArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1], -1);
    g_Config.BoneFammArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1], -1);

    Config.WriteInteger('Setup', 'BoneFammHumLevel' + IntToStr(I), g_Config.BoneFammArray[I].nHumLevel);
    Config.WriteString('Names', 'BoneFamm' + IntToStr(I), g_Config.BoneFammArray[I].sMonName);
    Config.WriteInteger('Setup', 'BoneFammCount' + IntToStr(I), g_Config.BoneFammArray[I].nCount);
    Config.WriteInteger('Setup', 'BoneFammLevel' + IntToStr(I), g_Config.BoneFammArray[I].nLevel);
  end;

  FillChar(g_Config.DogzArray, SizeOf(g_Config.DogzArray), #0);
  for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do
  begin
    Config.WriteInteger('Setup', 'DogzHumLevel' + IntToStr(I), 0);
    Config.WriteString('Names', 'Dogz' + IntToStr(I), '');
    Config.WriteInteger('Setup', 'DogzCount' + IntToStr(I), 0);
    Config.WriteInteger('Setup', 'DogzLevel' + IntToStr(I), 0);
  end;
  for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do
  begin
    if GridDogz.Cells[0, I + 1] = '' then
      break;

    g_Config.DogzArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1], -1);
    g_Config.DogzArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
    g_Config.DogzArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
    g_Config.DogzArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);

    Config.WriteInteger('Setup', 'DogzHumLevel' + IntToStr(I), g_Config.DogzArray[I].nHumLevel);
    Config.WriteString('Names', 'Dogz' + IntToStr(I), g_Config.DogzArray[I].sMonName);
    Config.WriteInteger('Setup', 'DogzCount' + IntToStr(I), g_Config.DogzArray[I].nCount);
    Config.WriteInteger('Setup', 'DogzLevel' + IntToStr(I), g_Config.DogzArray[I].nLevel);
  end;




    Config.WriteInteger('Setup', 'Skill78PowerRate', g_Config.nSkill78PowerRate);

    Config.WriteInteger('Setup', 'Skill78SpecialPower', g_Config.nSkill78SpecialPower);

    Config.WriteBool('Setup', 'boSkill78SpecialPower', g_Config.boSkill78SpecialPower);

    Config.WriteInteger('Setup', 'Skill79PowerRate', g_Config.nSkill79PowerRate);


    Config.WriteInteger('Setup', 'Skill91MonLevel', g_Config.nSkill91MonLevel);



    Config.WriteInteger('Setup', 'Skill91Rate', g_Config.nSkill91Rate);



    Config.WriteInteger('Setup', 'Skill91Power', g_Config.nSkill91Power);



    Config.WriteInteger('Setup', 'Skill91HumLevel', g_Config.nSkill91HumLevel);



    Config.WriteBool('Setup', 'Skill91Hum', g_Config.boSkill91HumLevel);


    Config.WriteInteger('Setup', 'Skill79SpecialPower', g_Config.nSkill79SpecialPower);

    Config.WriteBool('Setup', 'boSkill79SpecialPower', g_Config.boSkill79SpecialPower);

    Config.WriteInteger('Setup', 'Skill80PowerRate', g_Config.nSkill80PowerRate);

    Config.WriteInteger('Setup', 'Skill80SpecialPower', g_Config.nSkill80SpecialPower);

    Config.WriteBool('Setup', 'boSkill80SpecialPower', g_Config.boSkill80SpecialPower);

    Config.WriteInteger('Setup', 'Skill81PowerRate', g_Config.nSkill81PowerRate);

    Config.WriteInteger('Setup', 'Skill81SpecialPower', g_Config.nSkill81SpecialPower);

    Config.WriteBool('Setup', 'boSkill81SpecialPower', g_Config.boSkill81SpecialPower);

    Config.WriteInteger('Setup', 'Skill83PowerRate', g_Config.nSkill83PowerRate);

    Config.WriteInteger('Setup', 'Skill83SpecialPower', g_Config.nSkill83SpecialPower);

    Config.WriteBool('Setup', 'boSkill83SpecialPower', g_Config.boSkill83SpecialPower);

    Config.WriteInteger('Setup', 'Skill85PowerRate', g_Config.nSkill85PowerRate);

    Config.WriteInteger('Setup', 'Skill85SpecialPower', g_Config.nSkill85SpecialPower);

    Config.WriteBool('Setup', 'boSkill85SpecialPower', g_Config.boSkill85SpecialPower);

    Config.WriteString('Setup', 'Skill85Mon1', g_Config.sSkill85Mon1);

    Config.WriteString('Setup', 'Skill85Mon2', g_Config.sSkill85Mon2);

    Config.WriteString('Setup', 'Skill85Mon3', g_Config.sSkill85Mon3);

    Config.WriteString('Setup', 'Skill85Mon4', g_Config.sSkill85Mon4);

    Config.WriteString('Setup', 'Skill85Mon5', g_Config.sSkill85Mon5);

  Config.WriteBool('Setup', 'LimitSwordLong', g_Config.boLimitSwordLong);
  Config.WriteInteger('Setup', 'SwordLongPowerRate', g_Config.nSwordLongPowerRate);
  Config.WriteInteger('Setup', 'BoneFammCount', g_Config.nBoneFammCount);
  Config.WriteString('Names', 'BoneFamm', g_Config.sBoneFamm);
  Config.WriteInteger('Setup', 'DogzCount', g_Config.nDogzCount);
  Config.WriteString('Names', 'Dogz', g_Config.sDogz);
  Config.WriteInteger('Setup', 'FireBoomRage', g_Config.nFireBoomRage);
  Config.WriteInteger('Setup', 'SnowWindRange', g_Config.nSnowWindRange);
  Config.WriteInteger('Setup', 'ElecBlizzardRange', g_Config.nElecBlizzardRange);
  Config.WriteInteger('Setup', 'AmyOunsulPoint', g_Config.nAmyOunsulPoint);

  Config.WriteInteger('Setup', 'MagicAttackRage', g_Config.nMagicAttackRage);
  Config.WriteInteger('Setup', 'MagTurnUndeadLevel', g_Config.nMagTurnUndeadLevel);
  Config.WriteInteger('Setup', 'MagTammingLevel', g_Config.nMagTammingLevel);
  Config.WriteInteger('Setup', 'MagTammingTargetLevel', g_Config.nMagTammingTargetLevel);
  Config.WriteInteger('Setup', 'MagTammingTargetHPRate', g_Config.nMagTammingHPRate);
  Config.WriteInteger('Setup', 'MagTammingCount', g_Config.nMagTammingCount);

  Config.WriteInteger('Setup', 'MabMabeHitRandRate', g_Config.nMabMabeHitRandRate);
  Config.WriteInteger('Setup', 'MabMabeHitMinLvLimit', g_Config.nMabMabeHitMinLvLimit);
  Config.WriteInteger('Setup', 'MabMabeHitSucessRate', g_Config.nMabMabeHitSucessRate);
  Config.WriteInteger('Setup', 'MabMabeHitMabeTimeRate', g_Config.nMabMabeHitMabeTimeRate);

  Config.WriteBool('Setup', 'DisableInSafeZoneFireCross', g_Config.boDisableInSafeZoneFireCross);
  Config.WriteBool('Setup', 'GroupMbAttackPlayObject', g_Config.boGroupMbAttackPlayObject);
  Config.WriteBool('Setup', 'PlayerSkillTree', g_Config.PlayerSkillTree);
  Config.WriteBool('Setup', 'YSSkillTree', g_Config.YSSkillTree);
 Config.WriteInteger('Setup', 'VitaLityAddSpeed',g_Config.VitaLityAddSpeed);
  Config.WriteBool('Setup', 'ComSkillNoDecVitaLity', g_Config.ComSkillNoDecVitaLity);

 Config.WriteInteger('Setup', 'BatflyRate',g_Config.BatflyRate);
 Config.WriteInteger('Setup', 'BatflyMaxRage',g_Config.BatflyMaxRage);
 Config.WriteInteger('Setup', 'DoMotaeboDelay', g_Config.DoMotaeboDelay);
  Config.WriteInteger('Setup', 'DiDingUseTime', g_Config.DiDingUseTime);
   Config.WriteBool('Setup', 'DiDingAllowPK', g_Config.DiDingAllowPK);
  Config.WriteInteger('Setup', 'DiDingPowerRate', g_Config.DiDingPowerRate);
      Config.WriteInteger('Setup', 'Skill88PowerRate', g_Config.Skill88PowerRate);
 Config.WriteInteger('Setup', 'MagDefenceUpPerdureEx', g_Config.MagDefenceUpPerdureEx);
 Config.WriteInteger('Setup', 'PDPowerRate', g_Config.PDPowerRate);
  Config.WriteInteger('Setup', 'PJPowerRate', g_Config.PJPowerRate);
  Config.WriteBool('Setup', 'NoDoubleFireHit', g_Config.NoDoubleFireHit) ;
   Config.WriteInteger('Setup', 'FireHitPowerRate', g_Config.FireHitPowerRate);
  uModValue();
end;

procedure TfrmFunctionConfig.RefUpgradeWeapon();
begin
  ScrollBarUpgradeWeaponDCRate.Position := g_Config.nUpgradeWeaponDCRate;
  ScrollBarUpgradeWeaponDCTwoPointRate.Position := g_Config.nUpgradeWeaponDCTwoPointRate;
  ScrollBarUpgradeWeaponDCThreePointRate.Position := g_Config.nUpgradeWeaponDCThreePointRate;

  ScrollBarUpgradeWeaponMCRate.Position := g_Config.nUpgradeWeaponMCRate;
  ScrollBarUpgradeWeaponMCTwoPointRate.Position := g_Config.nUpgradeWeaponMCTwoPointRate;
  ScrollBarUpgradeWeaponMCThreePointRate.Position := g_Config.nUpgradeWeaponMCThreePointRate;

  ScrollBarUpgradeWeaponSCRate.Position := g_Config.nUpgradeWeaponSCRate;
  ScrollBarUpgradeWeaponSCTwoPointRate.Position := g_Config.nUpgradeWeaponSCTwoPointRate;
  ScrollBarUpgradeWeaponSCThreePointRate.Position := g_Config.nUpgradeWeaponSCThreePointRate;

  EditUpgradeWeaponMaxPoint.Value := g_Config.nUpgradeWeaponMaxPoint;
  EditUpgradeWeaponPrice.Value := g_Config.nUpgradeWeaponPrice;
  EditUPgradeWeaponGetBackTime.Value := g_Config.dwUPgradeWeaponGetBackTime div 1000;
  EditClearExpireUpgradeWeaponDays.Value := g_Config.nClearExpireUpgradeWeaponDays;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCRate.Position;
  EditUpgradeWeaponDCRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponDCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCTwoPointRate.Position;
  EditUpgradeWeaponDCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponDCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCThreePointRate.Position;
  EditUpgradeWeaponDCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponDCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCRate.Position;
  EditUpgradeWeaponSCRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponSCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCTwoPointRate.Position;
  EditUpgradeWeaponSCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponSCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCThreePointRate.Position;
  EditUpgradeWeaponSCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponSCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCRate.Position;
  EditUpgradeWeaponMCRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponMCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCTwoPointRate.Position;
  EditUpgradeWeaponMCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponMCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCThreePointRate.Position;
  EditUpgradeWeaponMCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponMCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponMaxPointChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponMaxPoint := EditUpgradeWeaponMaxPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponPriceChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nUpgradeWeaponPrice := EditUpgradeWeaponPrice.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUPgradeWeaponGetBackTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.dwUPgradeWeaponGetBackTime := EditUPgradeWeaponGetBackTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditClearExpireUpgradeWeaponDaysChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nClearExpireUpgradeWeaponDays := EditClearExpireUpgradeWeaponDays.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'UpgradeWeaponMaxPoint', g_Config.nUpgradeWeaponMaxPoint);
  Config.WriteInteger('Setup', 'UpgradeWeaponPrice', g_Config.nUpgradeWeaponPrice);
  Config.WriteInteger('Setup', 'ClearExpireUpgradeWeaponDays', g_Config.nClearExpireUpgradeWeaponDays);
  Config.WriteInteger('Setup', 'UPgradeWeaponGetBackTime', g_Config.dwUPgradeWeaponGetBackTime);

  Config.WriteInteger('Setup', 'UpgradeWeaponDCRate', g_Config.nUpgradeWeaponDCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponDCTwoPointRate', g_Config.nUpgradeWeaponDCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponDCThreePointRate', g_Config.nUpgradeWeaponDCThreePointRate);

  Config.WriteInteger('Setup', 'UpgradeWeaponMCRate', g_Config.nUpgradeWeaponMCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponMCTwoPointRate', g_Config.nUpgradeWeaponMCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponMCThreePointRate', g_Config.nUpgradeWeaponMCThreePointRate);

  Config.WriteInteger('Setup', 'UpgradeWeaponSCRate', g_Config.nUpgradeWeaponSCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponSCTwoPointRate', g_Config.nUpgradeWeaponSCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponSCThreePointRate', g_Config.nUpgradeWeaponSCThreePointRate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponDefaulfClick(
  Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then
  begin
    exit;
  end;
  g_Config.nUpgradeWeaponMaxPoint := 20;
  g_Config.nUpgradeWeaponPrice := 10000;
  g_Config.nClearExpireUpgradeWeaponDays := 8;
  g_Config.dwUPgradeWeaponGetBackTime := 60 * 60 * 1000;

  g_Config.nUpgradeWeaponDCRate := 100;
  g_Config.nUpgradeWeaponDCTwoPointRate := 30;
  g_Config.nUpgradeWeaponDCThreePointRate := 200;

  g_Config.nUpgradeWeaponMCRate := 100;
  g_Config.nUpgradeWeaponMCTwoPointRate := 30;
  g_Config.nUpgradeWeaponMCThreePointRate := 200;

  g_Config.nUpgradeWeaponSCRate := 100;
  g_Config.nUpgradeWeaponSCTwoPointRate := 30;
  g_Config.nUpgradeWeaponSCThreePointRate := 200;
  RefUpgradeWeapon();
end;

procedure TfrmFunctionConfig.EditMasterOKLevelChange(Sender: TObject);
begin
  if EditMasterOKLevel.Text = '' then
  begin
    EditMasterOKLevel.Text := '0';
    exit;
  end;
  if not boOpened then
    exit;
  g_Config.nMasterOKLevel := EditMasterOKLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc11Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc1[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc11RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate1[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc12Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc1[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc12RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate1[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc13Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc1[2] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc13RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate1[2] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc14Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc1[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc14RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate1[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc15Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc1[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc15RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate1[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc21Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc2[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc21RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate2[0] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc22Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc2[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc22RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate2[1] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc23Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc2[2] := TSpinEdit(Sender).Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditMc23RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate2[2] := TSpinEdit(Sender).Value;
  ModValue();

end;

procedure TfrmFunctionConfig.Editmc24Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc2[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterOKCreditPointChange(
  Sender: TObject);
begin
  if EditMasterOKCreditPoint.Text = '' then
  begin
    EditMasterOKCreditPoint.Text := '0';
    exit;
  end;
  if not boOpened then
    exit;
  g_Config.nMasterOKCreditPoint := EditMasterOKCreditPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterOKBonusPointChange(Sender: TObject);
begin
  if EditMasterOKBonusPoint.Text = '' then
  begin
    EditMasterOKBonusPoint.Text := '0';
    exit;
  end;
  if not boOpened then
    exit;
  g_Config.nMasterOKBonusPoint := EditMasterOKBonusPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonMasterSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MasterOKLevel', g_Config.nMasterOKLevel);
  Config.WriteInteger('Setup', 'MasterOKCreditPoint', g_Config.nMasterOKCreditPoint);
  Config.WriteInteger('Setup', 'MasterOKBonusPoint', g_Config.nMasterOKBonusPoint);
  g_Config.nMasterRunScript := CheckBoxMasterRunScript.Checked;
  Config.WriteBool('Setup', 'MasterRunScript', g_Config.nMasterRunScript);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonMakeMineSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MakeMineHitRate', g_Config.nMakeMineHitRate);
  Config.WriteInteger('Setup', 'MakeMineRate', g_Config.nMakeMineRate);
  Config.WriteInteger('Setup', 'StoneTypeRate', g_Config.nStoneTypeRate);
  Config.WriteInteger('Setup', 'StoneTypeRateMin', g_Config.nStoneTypeRateMin);
  Config.WriteInteger('Setup', 'GoldStoneMin', g_Config.nGoldStoneMin);
  Config.WriteInteger('Setup', 'GoldStoneMax', g_Config.nGoldStoneMax);
  Config.WriteInteger('Setup', 'SilverStoneMin', g_Config.nSilverStoneMin);
  Config.WriteInteger('Setup', 'SilverStoneMax', g_Config.nSilverStoneMax);
  Config.WriteInteger('Setup', 'SteelStoneMin', g_Config.nSteelStoneMin);
  Config.WriteInteger('Setup', 'SteelStoneMax', g_Config.nSteelStoneMax);
  Config.WriteInteger('Setup', 'BlackStoneMin', g_Config.nBlackStoneMin);
  Config.WriteInteger('Setup', 'BlackStoneMax', g_Config.nBlackStoneMax);
  Config.WriteInteger('Setup', 'StoneMinDura', g_Config.nStoneMinDura);
  Config.WriteInteger('Setup', 'StoneGeneralDuraRate', g_Config.nStoneGeneralDuraRate);
  Config.WriteInteger('Setup', 'StoneAddDuraRate', g_Config.nStoneAddDuraRate);
  Config.WriteInteger('Setup', 'StoneAddDuraMax', g_Config.nStoneAddDuraMax);
{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.ButtonMakeMineDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then
  begin
    exit;
  end;
  g_Config.nMakeMineHitRate := 4;
  g_Config.nMakeMineRate := 12;
  g_Config.nStoneTypeRate := 120;
  g_Config.nStoneTypeRateMin := 56;
  g_Config.nGoldStoneMin := 1;
  g_Config.nGoldStoneMax := 2;
  g_Config.nSilverStoneMin := 3;
  g_Config.nSilverStoneMax := 20;
  g_Config.nSteelStoneMin := 21;
  g_Config.nSteelStoneMax := 45;
  g_Config.nBlackStoneMin := 46;
  g_Config.nBlackStoneMax := 56;
  g_Config.nStoneMinDura := 3000;
  g_Config.nStoneGeneralDuraRate := 13000;
  g_Config.nStoneAddDuraRate := 20;
  g_Config.nStoneAddDuraMax := 10000;
  RefMakeMine();
end;

procedure TfrmFunctionConfig.RefMakeMine();
begin
  ScrollBarMakeMineHitRate.Position := g_Config.nMakeMineHitRate;
  ScrollBarMakeMineHitRate.Min := 0;
  ScrollBarMakeMineHitRate.Max := 10;

  ScrollBarMakeMineRate.Position := g_Config.nMakeMineRate;
  ScrollBarMakeMineRate.Min := 0;
  ScrollBarMakeMineRate.Max := 50;

  ScrollBarStoneTypeRate.Position := g_Config.nStoneTypeRate;
  ScrollBarStoneTypeRate.Min := g_Config.nStoneTypeRateMin;
  ScrollBarStoneTypeRate.Max := 500;

  ScrollBarGoldStoneMax.Min := 1;
  ScrollBarGoldStoneMax.Max := g_Config.nSilverStoneMax;

  ScrollBarSilverStoneMax.Min := g_Config.nGoldStoneMax;
  ScrollBarSilverStoneMax.Max := g_Config.nSteelStoneMax;

  ScrollBarSteelStoneMax.Min := g_Config.nSilverStoneMax;
  ScrollBarSteelStoneMax.Max := g_Config.nBlackStoneMax;

  ScrollBarBlackStoneMax.Min := g_Config.nSteelStoneMax;
  ScrollBarBlackStoneMax.Max := g_Config.nStoneTypeRate;

  ScrollBarGoldStoneMax.Position := g_Config.nGoldStoneMax;
  ScrollBarSilverStoneMax.Position := g_Config.nSilverStoneMax;
  ScrollBarSteelStoneMax.Position := g_Config.nSteelStoneMax;
  ScrollBarBlackStoneMax.Position := g_Config.nBlackStoneMax;

  EditStoneMinDura.Value := g_Config.nStoneMinDura div 1000;
  EditStoneGeneralDuraRate.Value := g_Config.nStoneGeneralDuraRate div 1000;
  EditStoneAddDuraRate.Value := g_Config.nStoneAddDuraRate;
  EditStoneAddDuraMax.Value := g_Config.nStoneAddDuraMax div 1000;
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineHitRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarMakeMineHitRate.Position;
  EditMakeMineHitRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nMakeMineHitRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarMakeMineRate.Position;
  EditMakeMineRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  g_Config.nMakeMineRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarStoneTypeRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarStoneTypeRate.Position;
  EditStoneTypeRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  ScrollBarBlackStoneMax.Max := nPostion;
  g_Config.nStoneTypeRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarGoldStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarGoldStoneMax.Position;
  EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' + IntToStr(g_Config.nGoldStoneMax);
  if not boOpened then
    exit;
  g_Config.nSilverStoneMin := nPostion + 1;
  ScrollBarSilverStoneMax.Min := nPostion + 1;
  g_Config.nGoldStoneMax := nPostion;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarSilverStoneMaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarSilverStoneMax.Position;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  if not boOpened then
    exit;
  ScrollBarGoldStoneMax.Max := nPostion - 1;
  g_Config.nSteelStoneMin := nPostion + 1;
  ScrollBarSteelStoneMax.Min := nPostion + 1;
  g_Config.nSilverStoneMax := nPostion;
  EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' + IntToStr(g_Config.nGoldStoneMax);
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarSteelStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarSteelStoneMax.Position;
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  if not boOpened then
    exit;
  ScrollBarSilverStoneMax.Max := nPostion - 1;
  g_Config.nBlackStoneMin := nPostion + 1;
  ScrollBarBlackStoneMax.Min := nPostion + 1;
  g_Config.nSteelStoneMax := nPostion;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' + IntToStr(g_Config.nBlackStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarBlackStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarBlackStoneMax.Position;
  EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' + IntToStr(g_Config.nBlackStoneMax);
  if not boOpened then
    exit;
  ScrollBarSteelStoneMax.Max := nPostion - 1;
  ScrollBarStoneTypeRate.Min := nPostion;
  g_Config.nBlackStoneMax := nPostion;
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneMinDuraChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nStoneMinDura := EditStoneMinDura.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneGeneralDuraRateChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nStoneGeneralDuraRate := EditStoneGeneralDuraRate.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneAddDuraRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nStoneAddDuraRate := EditStoneAddDuraRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneAddDuraMaxChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nStoneAddDuraMax := EditStoneAddDuraMax.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.RefWinLottery;
begin
  ScrollBarWinLotteryRate.Max := 100000;
  ScrollBarWinLotteryRate.Position := g_Config.nWinLotteryRate;
  ScrollBarWinLottery1Max.Max := g_Config.nWinLotteryRate;
  ScrollBarWinLottery1Max.Min := g_Config.nWinLottery1Min;
  ScrollBarWinLottery2Max.Max := g_Config.nWinLottery1Max;
  ScrollBarWinLottery2Max.Min := g_Config.nWinLottery2Min;
  ScrollBarWinLottery3Max.Max := g_Config.nWinLottery2Max;
  ScrollBarWinLottery3Max.Min := g_Config.nWinLottery3Min;
  ScrollBarWinLottery4Max.Max := g_Config.nWinLottery3Max;
  ScrollBarWinLottery4Max.Min := g_Config.nWinLottery4Min;
  ScrollBarWinLottery5Max.Max := g_Config.nWinLottery4Max;
  ScrollBarWinLottery5Max.Min := g_Config.nWinLottery5Min;
  ScrollBarWinLottery6Max.Max := g_Config.nWinLottery5Max;
  ScrollBarWinLottery6Max.Min := g_Config.nWinLottery6Min;
  ScrollBarWinLotteryRate.Min := g_Config.nWinLottery1Max;

  ScrollBarWinLottery1Max.Position := g_Config.nWinLottery1Max;
  ScrollBarWinLottery2Max.Position := g_Config.nWinLottery2Max;
  ScrollBarWinLottery3Max.Position := g_Config.nWinLottery3Max;
  ScrollBarWinLottery4Max.Position := g_Config.nWinLottery4Max;
  ScrollBarWinLottery5Max.Position := g_Config.nWinLottery5Max;
  ScrollBarWinLottery6Max.Position := g_Config.nWinLottery6Max;

  EditWinLottery1Gold.Value := g_Config.nWinLottery1Gold;
  EditWinLottery2Gold.Value := g_Config.nWinLottery2Gold;
  EditWinLottery3Gold.Value := g_Config.nWinLottery3Gold;
  EditWinLottery4Gold.Value := g_Config.nWinLottery4Gold;
  EditWinLottery5Gold.Value := g_Config.nWinLottery5Gold;
  EditWinLottery6Gold.Value := g_Config.nWinLottery6Gold;
end;

procedure TfrmFunctionConfig.ButtonWinLotterySaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'WinLottery1Gold', g_Config.nWinLottery1Gold);
  Config.WriteInteger('Setup', 'WinLottery2Gold', g_Config.nWinLottery2Gold);
  Config.WriteInteger('Setup', 'WinLottery3Gold', g_Config.nWinLottery3Gold);
  Config.WriteInteger('Setup', 'WinLottery4Gold', g_Config.nWinLottery4Gold);
  Config.WriteInteger('Setup', 'WinLottery5Gold', g_Config.nWinLottery5Gold);
  Config.WriteInteger('Setup', 'WinLottery6Gold', g_Config.nWinLottery6Gold);
  Config.WriteInteger('Setup', 'WinLottery1Min', g_Config.nWinLottery1Min);
  Config.WriteInteger('Setup', 'WinLottery1Max', g_Config.nWinLottery1Max);
  Config.WriteInteger('Setup', 'WinLottery2Min', g_Config.nWinLottery2Min);
  Config.WriteInteger('Setup', 'WinLottery2Max', g_Config.nWinLottery2Max);
  Config.WriteInteger('Setup', 'WinLottery3Min', g_Config.nWinLottery3Min);
  Config.WriteInteger('Setup', 'WinLottery3Max', g_Config.nWinLottery3Max);
  Config.WriteInteger('Setup', 'WinLottery4Min', g_Config.nWinLottery4Min);
  Config.WriteInteger('Setup', 'WinLottery4Max', g_Config.nWinLottery4Max);
  Config.WriteInteger('Setup', 'WinLottery5Min', g_Config.nWinLottery5Min);
  Config.WriteInteger('Setup', 'WinLottery5Max', g_Config.nWinLottery5Max);
  Config.WriteInteger('Setup', 'WinLottery6Min', g_Config.nWinLottery6Min);
  Config.WriteInteger('Setup', 'WinLottery6Max', g_Config.nWinLottery6Max);
  Config.WriteInteger('Setup', 'WinLotteryRate', g_Config.nWinLotteryRate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonWinLotteryDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then
  begin
    exit;
  end;


  g_Config.nWinLottery1Gold := 1000000;
  g_Config.nWinLottery2Gold := 200000;
  g_Config.nWinLottery3Gold := 100000;
  g_Config.nWinLottery4Gold := 10000;
  g_Config.nWinLottery5Gold := 1000;
  g_Config.nWinLottery6Gold := 500;
  g_Config.nWinLottery6Min := 1;
  g_Config.nWinLottery6Max := 4999;
  g_Config.nWinLottery5Min := 14000;
  g_Config.nWinLottery5Max := 15999;
  g_Config.nWinLottery4Min := 16000;
  g_Config.nWinLottery4Max := 16149;
  g_Config.nWinLottery3Min := 16150;
  g_Config.nWinLottery3Max := 16169;
  g_Config.nWinLottery2Min := 16170;
  g_Config.nWinLottery2Max := 16179;
  g_Config.nWinLottery1Min := 16180;
  g_Config.nWinLottery1Max := 16185;
  g_Config.nWinLotteryRate := 30000;
  RefWinLottery();
end;

procedure TfrmFunctionConfig.EditWinLottery1GoldChange(Sender: TObject);
begin
  if EditWinLottery1Gold.Text = '' then
  begin
    EditWinLottery1Gold.Text := '0';
    exit;
  end;
  if not boOpened then
    exit;
  g_Config.nWinLottery1Gold := EditWinLottery1Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWinLottery2GoldChange(Sender: TObject);
begin
  if EditWinLottery2Gold.Text = '' then
  begin
    EditWinLottery2Gold.Text := '0';
    exit;
  end;
  if not boOpened then
    exit;
  g_Config.nWinLottery2Gold := EditWinLottery2Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWinLottery3GoldChange(Sender: TObject);
begin
  if EditWinLottery3Gold.Text = '' then
  begin
    EditWinLottery3Gold.Text := '0';
    exit;
  end;
  if not boOpened then
    exit;
  g_Config.nWinLottery3Gold := EditWinLottery3Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery4GoldChange(Sender: TObject);
begin
  if EditWinLottery4Gold.Text = '' then
  begin
    EditWinLottery4Gold.Text := '0';
    exit;
  end;
  if not boOpened then
    exit;
  g_Config.nWinLottery4Gold := EditWinLottery4Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery5GoldChange(Sender: TObject);
begin
  if EditWinLottery5Gold.Text = '' then
  begin
    EditWinLottery5Gold.Text := '0';
    exit;
  end;
  if not boOpened then
    exit;
  g_Config.nWinLottery5Gold := EditWinLottery5Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery6GoldChange(Sender: TObject);
begin
  if EditWinLottery6Gold.Text = '' then
  begin
    EditWinLottery6Gold.Text := '0';
    exit;
  end;
  if not boOpened then
    exit;
  g_Config.nWinLottery6Gold := EditWinLottery6Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Edit_MaxRecallEvilCountChange(Sender: TObject);
begin
   if not boOpened then
    exit;

  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery1MaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery1Max.Position;
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  if not boOpened then
    exit;
  g_Config.nWinLottery1Max := nPostion;
  ScrollBarWinLottery2Max.Max := nPostion - 1;
  ScrollBarWinLotteryRate.Min := nPostion;
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery2MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery2Max.Position;
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  if not boOpened then
    exit;
  g_Config.nWinLottery1Min := nPostion + 1;
  ScrollBarWinLottery1Max.Min := nPostion + 1;
  g_Config.nWinLottery2Max := nPostion;
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery3MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery3Max.Position;
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  if not boOpened then
    exit;
  g_Config.nWinLottery2Min := nPostion + 1;
  ScrollBarWinLottery2Max.Min := nPostion + 1;
  g_Config.nWinLottery3Max := nPostion;
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery4MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery4Max.Position;
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  if not boOpened then
    exit;
  g_Config.nWinLottery3Min := nPostion + 1;
  ScrollBarWinLottery3Max.Min := nPostion + 1;
  g_Config.nWinLottery4Max := nPostion;
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery5MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery5Max.Position;
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  if not boOpened then
    exit;
  g_Config.nWinLottery4Min := nPostion + 1;
  ScrollBarWinLottery4Max.Min := nPostion + 1;
  g_Config.nWinLottery5Max := nPostion;
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery6MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery6Max.Position;
  EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' + IntToStr(g_Config.nWinLottery6Max);
  if not boOpened then
    exit;
  g_Config.nWinLottery5Min := nPostion + 1;
  ScrollBarWinLottery5Max.Min := nPostion + 1;
  g_Config.nWinLottery6Max := nPostion;
  EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' + IntToStr(g_Config.nWinLottery6Max);
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  ModValue();

end;

procedure TfrmFunctionConfig.ScrollBarWinLotteryRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLotteryRate.Position;
  EditWinLotteryRate.Text := IntToStr(nPostion);
  if not boOpened then
    exit;
  ScrollBarWinLottery1Max.Max := nPostion;
  g_Config.nWinLotteryRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditBatflyMaxRageChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.BatflyMaxRage:=SpinEditBatflyMaxRage.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditBatflyRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.BatflyRate:=SpinEditBatflyRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditDiDingPowerRateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.DiDingPowerRate:=SpinEditDiDingPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditDiDingUseTimeChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.DiDingUseTime:=SpinEditDiDingUseTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditDoMotaeboDelayChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.DoMotaeboDelay:=SpinEditDoMotaeboDelay.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFireHitPowerRateChange(Sender: TObject);
begin
    if not boOpened then
    exit;
  g_Config.FireHitPowerRate:=SpinEditFireHitPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditMagDefenceUpPerdureExChange(
  Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.MagDefenceUpPerdureEx:=SpinEditMagDefenceUpPerdureEx.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditPDPowerRateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.PDPowerRate:=SpinEditPDPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditPJPowerRateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.PJPowerRate:=SpinEditPJPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill88PowerRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.Skill88PowerRate:=SpinEditSkill88PowerRate.Value;
  ModValue();
end;


procedure TfrmFunctionConfig.EditAddDarkofRandValueChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nAddDarkofRandValue:=EditAddDarkofRandValue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.TrackBar1Change(Sender: TObject);
begin
  if not boOpened then
    exit;
 LabelMagicValue.Caption:=IntToStr(TrackBar1.Position);
 g_Config.nDecZMZSpeed:=TrackBar1.Position;
 ModValue();
end;

procedure TfrmFunctionConfig.TrackBar2Change(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.VitaLityAddSpeed:=TrackBar2.Position;
  ModValue();
end;

procedure TfrmFunctionConfig.RefReNewLevelConf();
begin
  EditReNewNameColor1.Value := g_Config.ReNewNameColor[0];
  EditReNewNameColor2.Value := g_Config.ReNewNameColor[1];
  EditReNewNameColor3.Value := g_Config.ReNewNameColor[2];
  EditReNewNameColor4.Value := g_Config.ReNewNameColor[3];
  EditReNewNameColor5.Value := g_Config.ReNewNameColor[4];
  EditReNewNameColor6.Value := g_Config.ReNewNameColor[5];
  EditReNewNameColor7.Value := g_Config.ReNewNameColor[6];
  EditReNewNameColor8.Value := g_Config.ReNewNameColor[7];
  EditReNewNameColor9.Value := g_Config.ReNewNameColor[8];
  EditReNewNameColor10.Value := g_Config.ReNewNameColor[9];
  EditReNewNameColorTime.Value := g_Config.dwReNewNameColorTime div 1000;
  CheckBoxReNewChangeColor.Checked := g_Config.boReNewChangeColor;
  CheckBoxReNewLevelClearExp.Checked := g_Config.boReNewLevelClearExp;
end;

procedure TfrmFunctionConfig.ButtonReNewLevelSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
{$IF SoftVersion <> VERDEMO}
  for I := Low(g_Config.ReNewNameColor) to High(g_Config.ReNewNameColor) do
  begin
    Config.WriteInteger('Setup', 'ReNewNameColor' + IntToStr(I), g_Config.ReNewNameColor[I]);
  end;
  Config.WriteInteger('Setup', 'ReNewNameColorTime', g_Config.dwReNewNameColorTime);
  Config.WriteBool('Setup', 'ReNewChangeColor', g_Config.boReNewChangeColor);
  Config.WriteBool('Setup', 'ReNewLevelClearExp', g_Config.boReNewLevelClearExp);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor1.Value;
  LabelReNewNameColor1.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[0] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor2.Value;
  LabelReNewNameColor2.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[1] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor3.Value;
  LabelReNewNameColor3.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[2] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor4.Value;
  LabelReNewNameColor4.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[3] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor5.Value;
  LabelReNewNameColor5.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[4] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor6.Value;
  LabelReNewNameColor6.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[5] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor7.Value;
  LabelReNewNameColor7.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[6] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor8.Value;
  LabelReNewNameColor8.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[7] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor9.Value;
  LabelReNewNameColor9.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[8] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor10Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor10.Value;
  LabelReNewNameColor10.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.ReNewNameColor[9] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColorTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.dwReNewNameColorTime := EditReNewNameColorTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.RefMonUpgrade();
begin
  EditMonUpgradeColor1.Value := g_Config.SlaveColor[0];
  EditMonUpgradeColor2.Value := g_Config.SlaveColor[1];
  EditMonUpgradeColor3.Value := g_Config.SlaveColor[2];
  EditMonUpgradeColor4.Value := g_Config.SlaveColor[3];
  EditMonUpgradeColor5.Value := g_Config.SlaveColor[4];
  EditMonUpgradeColor6.Value := g_Config.SlaveColor[5];
  EditMonUpgradeColor7.Value := g_Config.SlaveColor[6];
  EditMonUpgradeColor8.Value := g_Config.SlaveColor[7];
  EditMonUpgradeColor9.Value := g_Config.SlaveColor[8];
  EditMonUpgradeKillCount1.Value := g_Config.MonUpLvNeedKillCount[0];
  EditMonUpgradeKillCount2.Value := g_Config.MonUpLvNeedKillCount[1];
  EditMonUpgradeKillCount3.Value := g_Config.MonUpLvNeedKillCount[2];
  EditMonUpgradeKillCount4.Value := g_Config.MonUpLvNeedKillCount[3];
  EditMonUpgradeKillCount5.Value := g_Config.MonUpLvNeedKillCount[4];
  EditMonUpgradeKillCount6.Value := g_Config.MonUpLvNeedKillCount[5];
  EditMonUpgradeKillCount7.Value := g_Config.MonUpLvNeedKillCount[6];
  EditMonUpLvNeedKillBase.Value := g_Config.nMonUpLvNeedKillBase;
  EditMonUpLvRate.Value := g_Config.nMonUpLvRate;

  CheckBoxMasterDieMutiny.Checked := g_Config.boMasterDieMutiny;
  EditMasterDieMutinyRate.Value := g_Config.nMasterDieMutinyRate;
  EditMasterDieMutinyPower.Value := g_Config.nMasterDieMutinyPower;
  EditMasterDieMutinySpeed.Value := g_Config.nMasterDieMutinySpeed;

  CheckBoxMasterDieMutinyClick(CheckBoxMasterDieMutiny);

  CheckBoxBBMonAutoChangeColor.Checked := g_Config.boBBMonAutoChangeColor;
  EditBBMonAutoChangeColorTime.Value := g_Config.dwBBMonAutoChangeColorTime div 1000;
end;

procedure TfrmFunctionConfig.ButtonMonUpgradeSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MonUpLvNeedKillBase', g_Config.nMonUpLvNeedKillBase);
  Config.WriteInteger('Setup', 'MonUpLvRate', g_Config.nMonUpLvRate);
  for I := Low(g_Config.MonUpLvNeedKillCount) to High(g_Config.MonUpLvNeedKillCount) do
  begin
    Config.WriteInteger('Setup', 'MonUpLvNeedKillCount' + IntToStr(I), g_Config.MonUpLvNeedKillCount[I]);
  end;

  for I := Low(g_Config.SlaveColor) to High(g_Config.SlaveColor) do
  begin
    Config.WriteInteger('Setup', 'SlaveColor' + IntToStr(I), g_Config.SlaveColor[I]);
  end;
  Config.WriteBool('Setup', 'MasterDieMutiny', g_Config.boMasterDieMutiny);
  Config.WriteInteger('Setup', 'MasterDieMutinyRate', g_Config.nMasterDieMutinyRate);
  Config.WriteInteger('Setup', 'MasterDieMutinyPower', g_Config.nMasterDieMutinyPower);
  Config.WriteInteger('Setup', 'MasterDieMutinyPower', g_Config.nMasterDieMutinySpeed);

  Config.WriteBool('Setup', 'BBMonAutoChangeColor', g_Config.boBBMonAutoChangeColor);
  Config.WriteInteger('Setup', 'BBMonAutoChangeColorTime', g_Config.dwBBMonAutoChangeColorTime);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditMc24RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate2[3] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc25Change(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMc2[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMc25RateChange(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.nEvilMcRate2[4] := TSpinEdit(Sender).Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor1.Value;
  LabelMonUpgradeColor1.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.SlaveColor[0] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor2.Value;
  LabelMonUpgradeColor2.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.SlaveColor[1] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor3.Value;
  LabelMonUpgradeColor3.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.SlaveColor[2] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor4.Value;
  LabelMonUpgradeColor4.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.SlaveColor[3] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor5.Value;
  LabelMonUpgradeColor5.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.SlaveColor[4] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor6.Value;
  LabelMonUpgradeColor6.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.SlaveColor[5] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor7.Value;
  LabelMonUpgradeColor7.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.SlaveColor[6] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor8.Value;
  LabelMonUpgradeColor8.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.SlaveColor[7] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor9.Value;
  LabelMonUpgradeColor9.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.SlaveColor[8] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxReNewChangeColorClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boReNewChangeColor := CheckBoxReNewChangeColor.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxReNewLevelClearExpClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boReNewLevelClearExp := CheckBoxReNewLevelClearExp.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKFlagNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKFlagNameColor.Value;
  LabelPKFlagNameColor.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.btPKFlagNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKLevel1NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKLevel1NameColor.Value;
  LabelPKLevel1NameColor.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.btPKLevel1NameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKLevel2NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKLevel2NameColor.Value;
  LabelPKLevel2NameColor.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.btPKLevel2NameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditAddDarkofValueChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nAddDarkofValue:=EditAddDarkofValue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditAddDarkZMZChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nAddDarkofZMZ:=EditAddDarkZMZ.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditAllyAndGuildNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditAllyAndGuildNameColor.Value;
  LabelAllyAndGuildNameColor.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.btAllyAndGuildNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWarGuildNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditWarGuildNameColor.Value;
  LabelWarGuildNameColor.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.btWarGuildNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditInFreePKAreaNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditInFreePKAreaNameColor.Value;
  LabelInFreePKAreaNameColor.Color := GetRGB(btColor);
  if not boOpened then
    exit;
  g_Config.btInFreePKAreaNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditKillMonAddZMZMAXChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nKillMonAddZMZMax := EditKillMonAddZMZMax.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditKillMonAddZMZRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nKillMonAddZMZRate := EditKillMonAddZMZRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount1Change(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.MonUpLvNeedKillCount[0] := EditMonUpgradeKillCount1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount2Change(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.MonUpLvNeedKillCount[1] := EditMonUpgradeKillCount2.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount3Change(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.MonUpLvNeedKillCount[2] := EditMonUpgradeKillCount3.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount4Change(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.MonUpLvNeedKillCount[3] := EditMonUpgradeKillCount4.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount5Change(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.MonUpLvNeedKillCount[4] := EditMonUpgradeKillCount5.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount6Change(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.MonUpLvNeedKillCount[5] := EditMonUpgradeKillCount6.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount7Change(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.MonUpLvNeedKillCount[6] := EditMonUpgradeKillCount7.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpLvNeedKillBaseChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMonUpLvNeedKillBase := EditMonUpLvNeedKillBase.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpLvRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMonUpLvRate := EditMonUpLvRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMasterDieMutinyClick(Sender: TObject);
begin
  if CheckBoxMasterDieMutiny.Checked then
  begin
    EditMasterDieMutinyRate.Enabled := True;
    EditMasterDieMutinyPower.Enabled := True;
    EditMasterDieMutinySpeed.Enabled := True;
  end
  else
  begin
    EditMasterDieMutinyRate.Enabled := False;
    EditMasterDieMutinyPower.Enabled := False;
    EditMasterDieMutinySpeed.Enabled := False;
  end;
  if not boOpened then
    exit;
  g_Config.boMasterDieMutiny := CheckBoxMasterDieMutiny.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyRateChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMasterDieMutinyRate := EditMasterDieMutinyRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyPowerChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMasterDieMutinyPower := EditMasterDieMutinyPower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinySpeedChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMasterDieMutinySpeed := EditMasterDieMutinySpeed.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CbxSkill78SpecialPowerClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boSkill78SpecialPower :=TCheckBox(Sender).Checked;
  ModValue()
end;

procedure TfrmFunctionConfig.CbxSkill79SpecialPowerClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boSkill79SpecialPower :=TCheckBox(Sender).Checked;
  ModValue()
end;

procedure TfrmFunctionConfig.CbxSkill80SpecialPowerClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boSkill80SpecialPower :=TCheckBox(Sender).Checked;
  ModValue()
end;

procedure TfrmFunctionConfig.CbxSkill81SpecialPowerClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boSkill81SpecialPower :=TCheckBox(Sender).Checked;
  ModValue()
end;

procedure TfrmFunctionConfig.CbxSkill83SpecialPowerClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boSkill83SpecialPower :=TCheckBox(Sender).Checked;
  ModValue()
end;

procedure TfrmFunctionConfig.CbxSkill85SpecialPowerClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boSkill85SpecialPower :=TCheckBox(Sender).Checked;
  ModValue()
end;

procedure TfrmFunctionConfig.CheckBoxBBMonAutoChangeColorClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boBBMonAutoChangeColor := CheckBoxBBMonAutoChangeColor.Checked;
  ModValue();
end;


procedure TfrmFunctionConfig.CheckBoxComSkillNoDecVitaLityClick(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.ComSkillNoDecVitaLity := CheckBoxComSkillNoDecVitaLity.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxDiDingAllowPKClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.DiDingAllowPK := CheckBoxDiDingAllowPK.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditBBMonAutoChangeColorTimeChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.dwBBMonAutoChangeColorTime := EditBBMonAutoChangeColorTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.RefSpiritMutiny();
begin
  CheckBoxSpiritMutiny.Checked := g_Config.boSpiritMutiny;
  EditSpiritMutinyTime.Value := g_Config.dwSpiritMutinyTime div (60 * 1000);
  EditSpiritPowerRate.Value := g_Config.nSpiritPowerRate;
  CheckBoxSpiritMutinyClick(CheckBoxSpiritMutiny);
end;

procedure TfrmFunctionConfig.ButtonSpiritMutinySaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'SpiritMutiny', g_Config.boSpiritMutiny);
  Config.WriteInteger('Setup', 'SpiritMutinyTime', g_Config.dwSpiritMutinyTime);
  Config.WriteInteger('Setup', 'SpiritPowerRate', g_Config.nSpiritPowerRate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxSkillTreeClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.PlayerSkillTree := CheckBoxSkillTree.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxSpiritMutinyClick(Sender: TObject);
begin
  if CheckBoxSpiritMutiny.Checked then
  begin
    EditSpiritMutinyTime.Enabled := True;
//    EditSpiritPowerRate.Enabled:=True;
  end
  else
  begin
    EditSpiritMutinyTime.Enabled := False;
    EditSpiritPowerRate.Enabled := False;
  end;
  if not boOpened then
    exit;
  g_Config.boSpiritMutiny := CheckBoxSpiritMutiny.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxYSskillTreeClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.YSSkillTree := CheckBoxYSskillTree.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBox_CanRecallEvilClick(Sender: TObject);
begin
   if not boOpened then
    exit;
  
  ModValue();
end;

procedure TfrmFunctionConfig.EditSpiritMutinyTimeChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.dwSpiritMutinyTime := EditSpiritMutinyTime.Value * 60 * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSpiritPowerRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nSpiritPowerRate := EditSpiritPowerRate.Value;
  ModValue();
end;




procedure TfrmFunctionConfig.EditMagTammingLevelChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMagTammingLevel := EditMagTammingLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTammingTargetLevelChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMagTammingTargetLevel := EditMagTammingTargetLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTammingHPRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMagTammingHPRate := EditMagTammingHPRate.Value;
  ModValue();
end;


procedure TfrmFunctionConfig.EditTammingCountChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMagTammingCount := EditTammingCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitRandRateChange(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMabMabeHitRandRate := EditMabMabeHitRandRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitMinLvLimitChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMabMabeHitMinLvLimit := EditMabMabeHitMinLvLimit.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitSucessRateChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMabMabeHitSucessRate := EditMabMabeHitSucessRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitMabeTimeRateChange(
  Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.nMabMabeHitMabeTimeRate := EditMabMabeHitMabeTimeRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.RefMonSayMsg;
begin
  CheckBoxMonSayMsg.Checked := g_Config.boMonSayMsg;
end;

procedure TfrmFunctionConfig.ButtonMonSayMsgSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'MonSayMsg', g_Config.boMonSayMsg);
{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.CheckBoxMonSayMsgClick(Sender: TObject);
begin
  if not boOpened then
    exit;
  g_Config.boMonSayMsg := CheckBoxMonSayMsg.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxNoDoubleFireHitClick(Sender: TObject);
begin
   if not boOpened then
    exit;
  g_Config.NoDoubleFireHit := CheckBoxNoDoubleFireHit.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RefWeaponMakeLuck;
begin
  ScrollBarWeaponMakeUnLuckRate.Min := 1;
  ScrollBarWeaponMakeUnLuckRate.Max := 50;
  ScrollBarWeaponMakeUnLuckRate.Position := g_Config.nWeaponMakeUnLuckRate;

  ScrollBarWeaponMakeLuckPoint1.Min := 1;
  ScrollBarWeaponMakeLuckPoint1.Max := 10;
  ScrollBarWeaponMakeLuckPoint1.Position := g_Config.nWeaponMakeLuckPoint1;

  ScrollBarWeaponMakeLuckPoint2.Min := 1;
  ScrollBarWeaponMakeLuckPoint2.Max := 10;
  ScrollBarWeaponMakeLuckPoint2.Position := g_Config.nWeaponMakeLuckPoint2;

  ScrollBarWeaponMakeLuckPoint3.Min := 1;
  ScrollBarWeaponMakeLuckPoint3.Max := 10;
  ScrollBarWeaponMakeLuckPoint3.Position := g_Config.nWeaponMakeLuckPoint3;

  ScrollBarWeaponMakeLuckPoint2Rate.Min := 1;
  ScrollBarWeaponMakeLuckPoint2Rate.Max := 50;
  ScrollBarWeaponMakeLuckPoint2Rate.Position := g_Config.nWeaponMakeLuckPoint2Rate;

  ScrollBarWeaponMakeLuckPoint3Rate.Min := 1;
  ScrollBarWeaponMakeLuckPoint3Rate.Max := 50;
  ScrollBarWeaponMakeLuckPoint3Rate.Position := g_Config.nWeaponMakeLuckPoint3Rate;
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckDefaultClick(
  Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then
  begin
    exit;
  end;
  g_Config.nWeaponMakeUnLuckRate := 20;
  g_Config.nWeaponMakeLuckPoint1 := 1;
  g_Config.nWeaponMakeLuckPoint2 := 3;
  g_Config.nWeaponMakeLuckPoint3 := 7;
  g_Config.nWeaponMakeLuckPoint2Rate := 6;
  g_Config.nWeaponMakeLuckPoint3Rate := 40;
  RefWeaponMakeLuck();
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckSaveClick(
  Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'WeaponMakeUnLuckRate', g_Config.nWeaponMakeUnLuckRate);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint1', g_Config.nWeaponMakeLuckPoint1);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2', g_Config.nWeaponMakeLuckPoint2);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3', g_Config.nWeaponMakeLuckPoint3);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2Rate', g_Config.nWeaponMakeLuckPoint2Rate);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3Rate', g_Config.nWeaponMakeLuckPoint3Rate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeUnLuckRateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeUnLuckRate.Position;
  EditWeaponMakeUnLuckRate.Text := IntToStr(nInteger);
  if not boOpened then
    exit;
  g_Config.nWeaponMakeUnLuckRate := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint1Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint1.Position;
  EditWeaponMakeLuckPoint1.Text := IntToStr(nInteger);
  if not boOpened then
    exit;
  g_Config.nWeaponMakeLuckPoint1 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint2.Position;
  EditWeaponMakeLuckPoint2.Text := IntToStr(nInteger);
  if not boOpened then
    exit;
  g_Config.nWeaponMakeLuckPoint2 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint2Rate.Position;
  EditWeaponMakeLuckPoint2Rate.Text := IntToStr(nInteger);
  if not boOpened then
    exit;
  g_Config.nWeaponMakeLuckPoint2Rate := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint3.Position;
  EditWeaponMakeLuckPoint3.Text := IntToStr(nInteger);
  if not boOpened then
    exit;
  g_Config.nWeaponMakeLuckPoint3 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint3Rate.Position;
  EditWeaponMakeLuckPoint3Rate.Text := IntToStr(nInteger);
  if not boOpened then
    exit;
  g_Config.nWeaponMakeLuckPoint3Rate := nInteger;
  ModValue();
end;



procedure TfrmFunctionConfig.CheckBoxMasterRunScriptClick(Sender: TObject);
begin
  ButtonMasterSave.Enabled := true;
end;

end.
