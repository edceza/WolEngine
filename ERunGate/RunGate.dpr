program RunGate;

uses

  Forms,
  Main in 'Main.pas' {FrmMain},
  GateShare in 'GateShare.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  MessageFilterConfig in 'MessageFilterConfig.pas' {frmMessageFilterConfig},
  IPaddrFilter in 'IPaddrFilter.pas' {frmIPaddrFilter},
  EDcode in '..\Common\EDcode.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  PrefConfig in 'PrefConfig.pas' {frmPrefConfig},
  inCheatFrm in 'inCheatFrm.pas' {frmDefCheat};

//  SDK in '..\SDK\SDK.pas'

{$R *.res}

begin
  Application.Initialize;
  Application.HintHidePause:=10000;
  Application.HintPause:=100;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmGeneralConfig, frmGeneralConfig);
  Application.CreateForm(TfrmMessageFilterConfig, frmMessageFilterConfig);
  Application.CreateForm(TfrmIPaddrFilter, frmIPaddrFilter);
  Application.CreateForm(TfrmPrefConfig, frmPrefConfig);
  Application.CreateForm(TfrmDefCheat, frmDefCheat);
  Application.Run;
end.
