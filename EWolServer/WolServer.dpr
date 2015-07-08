{$MINSTACKSIZE $00100000}
{$MAXSTACKSIZE $00100000}

program WolServer;


uses
  Forms,
  Windows,
  Graphics,
  svMain in 'svMain.pas' {FrmMain},
  LocalDB in 'LocalDB.pas' {FrmDB},
  InterServerMsg in 'InterServerMsg.pas' {FrmSrvMsg},
  InterMsgClient in 'InterMsgClient.pas' {FrmMsgClient},
  IdSrvClient in 'IdSrvClient.pas' {FrmIDSoc},
  FSrvValue in 'FSrvValue.pas' {FrmServerValue},
  UsrEngn in 'UsrEngn.pas',
  ObjNpc in 'ObjNpc.pas',
  ObjMon2 in 'ObjMon2.pas',
  ObjMon in 'ObjMon.pas',
  ObjGuard in 'ObjGuard.pas',
  ObjBase in 'ObjBase.pas',
  ObjAxeMon in 'ObjAxeMon.pas',
  NoticeM in 'NoticeM.pas',
  Mission in 'Mission.pas',
  Magic in 'Magic.pas',
  M2Share in 'M2Share.pas',
  ItmUnit in 'ItmUnit.pas',
  Guild in 'Guild.pas',
  FrnEngn in 'FrnEngn.pas',
  Event in 'Event.pas',
  Envir in 'Envir.pas',
  Castle in 'Castle.pas',
  RunDB in 'RunDB.pas',
  RunSock in 'RunSock.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  MudUtil in '..\Common\MudUtil.pas',
  PlugIn in 'PlugIn.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  GameConfig in 'GameConfig.pas' {frmGameConfig},
  FunctionConfig in 'FunctionConfig.pas' {frmFunctionConfig},
  ObjRobot in 'ObjRobot.pas',
  BnkEngn in 'BnkEngn.pas',
  ViewSession in 'ViewSession.pas' {frmViewSession},
  ViewOnlineHuman in 'ViewOnlineHuman.pas' {frmViewOnlineHuman},
  ViewLevel in 'ViewLevel.pas' {frmViewLevel},
  ViewList in 'ViewList.pas' {frmViewList},
  OnlineMsg in 'OnlineMsg.pas' {frmOnlineMsg},
  HumanInfo in 'HumanInfo.pas' {frmHumanInfo},
  ViewKernelInfo in 'ViewKernelInfo.pas' {frmViewKernelInfo},
  ConfigMerchant in 'ConfigMerchant.pas' {frmConfigMerchant},
  ItemSet in 'ItemSet.pas' {frmItemSet},
  ConfigMonGen in 'ConfigMonGen.pas' {frmConfigMonGen},
  PlugInManage in 'PlugInManage.pas' {ftmPlugInManage},
  EncryptUnit in '..\Common\EncryptUnit.pas',
  GameCommand in 'GameCommand.pas' {frmGameCmd},
  MonsterConfig in 'MonsterConfig.pas' {frmMonsterConfig},
  UnitManage in 'UnitManage.pas',
  JClasses in 'JClasses.pas',
  ActionSpeedConfig in 'ActionSpeedConfig.pas' {frmActionSpeed},
  EDcode in 'EDcode.pas',
  CastleManage in 'CastleManage.pas' {frmCastleManage},
  Objys in 'Objys.pas',
  Objmonty in 'Objmonty.pas',
  _Const in '..\Common\_Const.pas',
  _Decode in '..\Common\_Decode.pas',
  _Function in '..\Common\_Function.pas',
  CastleAttackEdit in 'CastleAttackEdit.pas' {FormCastleAttackEdit},
  DESCrypt in 'DESCrypt.pas',
  USER_MD5 in 'USER_MD5.pas',
  CatDes in 'CatDes.pas',
  RegSoft in 'RegSoft.pas' {FrmRegSoft},
  VersionId in '..\Common\Reg\VersionId.pas',
  Base64 in '..\Common\Reg\Base64.pas',
  md5 in '..\Common\Reg\md5.pas',
  Unit_Item in 'Unit_Item.pas' {Form_Unit_Item};

{$R *.res}
procedure Start();
begin
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
{$IFEND}
//  g_Config.nServerFile_CRCA:=CalcFileCRC(Application.ExeName);
  Application.Initialize;
  Application.HintPause:=100;
  Application.HintShortPause:=100;
  Application.HintHidePause:=5000;
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
{$IFEND}
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmSrvMsg, FrmSrvMsg);
  Application.CreateForm(TFormCastleAttackEdit, FormCastleAttackEdit);
  Application.CreateForm(TFrmRegSoft, FrmRegSoft);
  Application.CreateForm(TForm_Unit_Item, Form_Unit_Item);
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
  Application.CreateForm(TFrmMsgClient, FrmMsgClient);
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
{$IFEND}
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
{$IFEND}
  Application.CreateForm(TFrmServerValue, FrmServerValue);
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
{$IFEND}
  Application.CreateForm(TftmPlugInManage, ftmPlugInManage);
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
{$IFEND}
  Application.CreateForm(TfrmGameCmd, frmGameCmd);
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
{$IFEND}
  Application.CreateForm(TfrmMonsterConfig, frmMonsterConfig);
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
{$IFEND}
  Application.Run;
end;

asm
  jz @@Start
  jnz @@Start
  db 0E8h
@@Start:
  lea eax,Start
  call eax
  jz @@end
  jnz @@end
  db 0F4h
  db 0FFh
@@end:
end.
