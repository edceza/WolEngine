unit LocalDB;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, ActiveX,IniFiles ,
  Dialogs, M2Share, {$IF DBTYPE = BDE}DBTables{$ELSE}ADODB{$IFEND}, DB, HUtil32, Grobal2, ObjBase, ObjNpc, _Function ;


type
  TDefineInfo = record
    sName: string;
    sText: string;
  end;
  pTDefineInfo = ^TDefineInfo;
  TQDDinfo = record
    n00: Integer;
    s04: string;
    sList: TStringList;
  end;
  pTQDDinfo = ^TQDDinfo;
  TGoodFileHeader = record
    nItemCount: Integer;
    Resv: array[0..251] of Integer;
  end;



  TFrmDB = class {(TForm)}
  private
    procedure QMangeNPC;
    procedure QFunctionNPC;
    procedure QGuildTowerNPC();
    procedure QSHOPNPC;
    procedure RobotNPC();

    { Private declarations }
  public
{$IF DBTYPE = BDE}
    Query: TQuery;
{$ELSE}
    Query: TADOQuery;
{$IFEND}
    constructor Create();
    destructor Destroy; override;
    function LoadMonitems(MonName: string; var ItemList: TList): Integer;
    function LoadItemsDB(): Integer;
    function LoadMinMap(): Integer;
    function LoadMapInfo(): Integer;
    function LoadMonsterDB(): Integer;
    function LoadMagicDB(): Integer;
    function LoadEvilMonappr():Integer;
    function LoadMonGen(): Integer;
    function LoadUnbindList(): Integer;
    function LoadbindList(): Integer;

    function LoadMapQuest(): Integer;
    function LoadMapNewEvent:Integer;
    function LoadQuestDiary(): Integer;
    function LoadAdminList(): Boolean;
    function LoadMerchant(): Integer;
    function LoadGuardList(): Integer;
    function LoadMapEnvir(): Integer;
    function LoadNpcs(): Integer;
    function LoadMakeItem(): Integer;
    function LoadPetSellInfo():Integer;
    procedure SavePetSellInfo ();
    function LoadStartPoint(): Integer;
    function LoadNpcScript(NPC: TNormNpc; sPatch, sScritpName: string): Integer;
    function LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: string; boFlag: Boolean): Integer;
    function LoadGoodRecord(NPC: TMerchant; sFile: string): Integer;
    function LoadGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;

    function SaveGoodRecord(NPC: TMerchant; sFile: string): Integer;
    function SaveGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;

    function LoadUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
    function SaveUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
    procedure ReLoadMerchants();
    procedure ReLoadNpc();
    procedure DeCodeStringList(StringList: TStringList);
  end;

var
  FrmDB: TFrmDB;
  nDeCryptString: Integer = -1;
  g_aftEncodeSriptcode: string = '#;;;#';
  MapEnvirList: array of array of string;
implementation

uses Envir, edcode;


//{$R *.dfm}

{ TFrmDB }
//00487630

function TFrmDB.LoadAdminList(): Boolean;
var
  sFileName: string;
  sLineText: string;
  sIPaddr: string;
  sCharName: string;
  sData: string;
  LoadList: TStringList;
  AdminInfo: pTAdminInfo;
  I: Integer;
  nLv: Integer;
begin
  Result := False;
  ;
  sFileName := g_Config.sEnvirDir + 'AdminList.txt';
  if not FileExists(sFileName) then
    exit;
  UserEngine.m_AdminList.Lock;
  try
    UserEngine.m_AdminList.Clear;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do
    begin
      sLineText := LoadList.Strings[i];
      nLv := -1;
      if (sLineText <> '') and (sLineText[1] <> ';') then
      begin
        if sLineText[1] = '*' then
          nLv := 10
        else
          if sLineText[1] = '1' then
            nLv := 9
          else
            if sLineText[1] = '2' then
              nLv := 8
            else
              if sLineText[1] = '3' then
                nLv := 7
              else
                if sLineText[1] = '4' then
                  nLv := 6
                else
                  if sLineText[1] = '5' then
                    nLv := 5
                  else
                    if sLineText[1] = '6' then
                      nLv := 4
                    else
                      if sLineText[1] = '7' then
                        nLv := 3
                      else
                        if sLineText[1] = '8' then
                          nLv := 2
                        else
                          if sLineText[1] = '9' then
                            nLv := 1;
        if nLv > 0 then
        begin
          sLineText := GetValidStrCap(sLineText, sData, ['/', '\', ' ', #9]);
          sLineText := GetValidStrCap(sLineText, sCharName, ['/', '\', ' ', #9]);
          sLineText := GetValidStrCap(sLineText, sIPaddr, ['/', '\', ' ', #9]);

          New(AdminInfo);
          AdminInfo.nLv := nLv;
          AdminInfo.sChrName := sCharName;
          AdminInfo.sIPaddr := sIPaddr;
          UserEngine.m_AdminList.Add(AdminInfo);
        end;
      end;
    end;
    LoadList.Free;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  Result := True;
end;
//00488A68

function TFrmDB.LoadGuardList(): Integer;
var
  sFileName, s14, s1C, s20, s24, s28, s2C: string;
  tGuardList: TStringList;
  i: Integer;
  tGuard: TBaseObject;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'GuardList.txt';
  if FileExists(sFileName) then
  begin
    tGuardList := TStringList.Create;
    tGuardList.LoadFromFile(sFileName);
    for i := 0 to tGuardList.Count - 1 do
    begin
      s14 := tGuardList.Strings[i];
      if (s14 <> '') and (s14[1] <> ';') then
      begin
        s14 := GetValidStrCap(s14, s1C, [' ']);
        if (s1C <> '') and (s1C[1] = '"') then
          ArrestStringEx(s1C, '"', '"', s1C);
        s14 := GetValidStr3(s14, s20, [' ']);
        s14 := GetValidStr3(s14, s24, [' ', ',']);
        s14 := GetValidStr3(s14, s28, [' ', ',', ':']);
        s14 := GetValidStr3(s14, s2C, [' ', ':']);
        if (s1C <> '') and (s20 <> '') and (s2C <> '') then
        begin
          tGuard := UserEngine.RegenMonsterByName(s20, Str_ToInt(s24, 0), Str_ToInt(s28, 0), s1C);
              //sMapName,nX,nY,sName
          if tGuard <> nil then
            tGuard.m_btDirection := Str_ToInt(s2C, 0);
        end;
      end;
    end;
    tGuardList.Free;
    Result := 1;
  end;
end;
//004855E0

procedure WriteTxt(sFileName, sText: string); //写txt文件
var
  F: TextFile;
begin
  AssignFile(F, sFileName);
  if FileExists(sFileName) then
    Append(F)
  else
    ReWrite(F);

  WriteLn(F, sText);
  CloseFile(F);
end;

function TFrmDB.LoadMapEnvir(): Integer;
var
  sFileName, s14, s1C, s20, s24, s28, s2C: string;
  tGuardList: TStringList;
  i: Integer;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'MapEnvir.txt';
  if not FileExists(sFileName) then
  begin
    //CreateFile('');
    WriteTxt(g_Config.sEnvirDir + 'MapEnvir.txt', ';地图    X坐标    Y坐标     触发模式     执行脚本');
  end
  else
  begin
    tGuardList := TStringList.Create;
    tGuardList.LoadFromFile(sFileName);
    tGuardList.Text := StringReplace(tGuardList.Text, '	', ' ', [rfReplaceAll]);
    SetLength(MapEnvirList, tGuardList.Count, 5);
    for i := 0 to tGuardList.Count - 1 do
    begin
      s14 := tGuardList.Strings[i];
      if (s14 <> '') and (s14[1] <> ';') then
      begin
        s14 := GetValidStrCap(s14, s1C, [' ']);
        if (s1C <> '') and (s1C[1] = '"') then
          ArrestStringEx(s1C, '"', '"', s1C);
        s14 := GetValidStr3(s14, s20, [' ']);
        s14 := GetValidStr3(s14, s24, [' ', ',']);
        s14 := GetValidStr3(s14, s28, [' ', ',', ':']);
        s14 := GetValidStr3(s14, s2C, [' ', ':']);
        if (s1C <> '') and (s20 <> '') and (s2C <> '') then
        begin
          s20 := StringReplace(s20, ' ', '', [rfReplaceAll]);
          s20 := StringReplace(s20, '	', '', [rfReplaceAll]);
          s24 := StringReplace(s24, ' ', '', [rfReplaceAll]);
          s24 := StringReplace(s24, '	', '', [rfReplaceAll]);
          s28 := StringReplace(s28, ' ', '', [rfReplaceAll]);
          s28 := StringReplace(s28, '	', '', [rfReplaceAll]);
          s1C := StringReplace(s1C, ' ', '', [rfReplaceAll]);
          s1C := StringReplace(s1C, '	', '', [rfReplaceAll]);
          S2C := StringReplace(S2C, ' ', '', [rfReplaceAll]);
          S2C := StringReplace(S2C, '  ', '', [rfReplaceAll]);
          s20 := StringReplace(s20, '	', '', [rfReplaceAll]);
          s20 := StringReplace(s20, '	', '', [rfReplaceAll]);
          s24 := StringReplace(s24, '	', '', [rfReplaceAll]);
          s24 := StringReplace(s24, '	', '', [rfReplaceAll]);
          s28 := StringReplace(s28, '	', '', [rfReplaceAll]);
          s28 := StringReplace(s28, '	', '', [rfReplaceAll]);
          s1C := StringReplace(s1C, '	', '', [rfReplaceAll]);
          s1C := StringReplace(s1C, '	', '', [rfReplaceAll]);
          S2C := StringReplace(S2C, '	', '', [rfReplaceAll]);
          S2C := StringReplace(S2C, '	', '', [rfReplaceAll]);
          MapEnvirList[i, 0] := s20;
          MapEnvirList[i, 1] := IntToStr(Str_ToInt(s24, 0));
          MapEnvirList[i, 2] := IntToStr(Str_ToInt(s28, 0));
          MapEnvirList[i, 3] := IntToStr(Str_ToInt(s1C, 0));
          MapEnvirList[i, 4] := S2C;
        //  ShowMessage(MapEnvirList[i,0]+':'+MapEnvirList[i,1]+':'+MapEnvirList[i,2]+':'+MapEnvirList[i,3]+MapEnvirList[i,4]);
          //  tGuard:=UserEngine.RegenMonsterByName(s20,Str_ToInt(s24,0),Str_ToInt(s28,0),s1C);
              //sMapName,nX,nY,sName
        end;
      end;
    end;
    tGuardList.Free;
    Result := 1;
  end;
end;

function TFrmDB.LoadItemsDB: Integer;
var
  i,ii, Idx: Integer;
  StdItem: pTStdItem;
  pItemRule : pTItemRule;
  dwSPCode:dword;
resourcestring
  sSQLString = 'select * from StdItems';
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    try
      for I := 0 to UserEngine.StdItemList.Count - 1 do
      begin
        Dispose(pTStdItem(UserEngine.StdItemList.Items[I]));
      end;
      UserEngine.StdItemList.Clear;
      Result := -1;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      try
        Query.Open;
      finally
        Result := -2;
      end;
      SetLength(UserEngine.StdItemofAnnicount,Query.RecordCount);
      for i := 0 to Query.RecordCount - 1 do
      begin
        New(StdItem);
        FillChar(stdItem^,SizeOf(TStdItem),0);
        Idx := Query.FieldByName('Idx').AsInteger;
        StdItem.Name := Query.FieldByName('Name').AsString;
        StdItem.StdMode := Query.FieldByName('StdMode').AsInteger;
        StdItem.Shape := Query.FieldByName('Shape').AsInteger;
        StdItem.Weight := Query.FieldByName('Weight').AsInteger;
        StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
        StdItem.Source := Query.FieldByName('Source').AsInteger;
        StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;
        StdItem.Looks := Query.FieldByName('Looks').AsInteger;
        StdItem.DuraMax := Word(Query.FieldByName('DuraMax').AsInteger);
        if StdItem.StdMode in [0,3] then
        begin
            StdItem.AC := ROUND(Query.FieldByName('Ac').AsInteger * (g_Config.nItemsACPowerRate / 10));
            StdItem.MAC := ROUND(Query.FieldByName('Mac').AsInteger * (g_Config.nItemsACPowerRate / 10));
            StdItem.DC := ROUND(Query.FieldByName('Dc').AsInteger * (g_Config.nItemsPowerRate / 10));
            StdItem.MC := ROUND(Query.FieldByName('Mc').AsInteger * (g_Config.nItemsPowerRate / 10));
            StdItem.SC := ROUND(Query.FieldByName('Sc').AsInteger * (g_Config.nItemsPowerRate / 10));
            if (StdItem.Shape=17) and (stditem.StdMode=3) then
            begin
              StdItem.MAC:=Query.FieldByName('Mac').AsInteger+Query.FieldByName('Mac2').AsInteger*256;
              StdItem.DC:=Query.FieldByName('Dc').AsInteger+Query.FieldByName('Dc2').AsInteger*256;
            end;

        end
        else
        Begin
            StdItem.AC := MakeWord(ROUND(Query.FieldByName('Ac').AsInteger * (g_Config.nItemsACPowerRate / 10)), ROUND(Query.FieldByName('Ac2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
            StdItem.MAC := MakeWord(ROUND(Query.FieldByName('Mac').AsInteger * (g_Config.nItemsACPowerRate / 10)), ROUND(Query.FieldByName('MAc2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
            StdItem.DC := MakeWord(ROUND(Query.FieldByName('Dc').AsInteger * (g_Config.nItemsPowerRate / 10)), ROUND(Query.FieldByName('Dc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
            StdItem.MC := MakeWord(ROUND(Query.FieldByName('Mc').AsInteger * (g_Config.nItemsPowerRate / 10)), ROUND(Query.FieldByName('Mc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
            StdItem.SC := MakeWord(ROUND(Query.FieldByName('Sc').AsInteger * (g_Config.nItemsPowerRate / 10)), ROUND(Query.FieldByName('Sc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
        End;
        StdItem.Need := Query.FieldByName('Need').AsInteger;
        StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;
        StdItem.Price :=Query.FieldByName('Price').AsInteger;
        StdItem.NeedIdentify :=GetGameLogItemNameList(StdItem.Name);
        //判断是否有SPCode字段
        if Query.Fields.FindField('SPCode')<>nil then
        begin
          dwSPCode:=Query.FieldByName('SPCode').AsInteger;
          if dwSPCode>0 then
          begin
            New(pItemRule);
             pItemRule.Name:=Stditem.Name;
            for ii := 0 to 20 do
            begin
              pItemRule.bospcode[ii]:=((dwSPCode shr ii)and 1)=1;
             
            end;
            g_ItemRuleList.AddObject(Inttostr(idx),TObject(pItemRule) );
          end;
        end;
        if UserEngine.StdItemList.Count = Idx then
        begin
          UserEngine.StdItemList.Add(StdItem);
          UserEngine.StdItemofAnnicount[Idx]:=Query.FieldByName('AniCount').AsInteger;
          Result := 1;
        end
        else
        begin
         // MemoLog.Lines.Add(format('加载物品(Idx:%d Name:%s)数据失败！！！', [Idx, StdItem.Name]));
          Result := -100;
          exit;
        end;
        Query.Next;
      end;
      g_boGameLogGold := GetGameLogItemNameList(sSTRING_GOLDNAME) = 1;
      g_boGameLogHumanDie := GetGameLogItemNameList(g_sHumanDieEvent) = 1;
      g_boGameLogGameGold := GetGameLogItemNameList(g_Config.sGameGoldName) = 1;
      g_boGameLogGamePoint := GetGameLogItemNameList(g_Config.sGamePointName) = 1;
    finally
      Query.Close;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
//00486330

function TFrmDB.LoadMagicDB(): Integer;
var
  i: Integer;
  Magic: pTMagic;
resourcestring
  sSQLString = 'select * from Magic';
begin
  Result := -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    UserEngine.SwitchMagicList();
    {
    for I := 0 to UserEngine.MagicList.Count - 1 do begin
      Dispose(pTMagic(UserEngine.MagicList.Items[I]));
    end;
    UserEngine.MagicList.Clear;
    }

    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -2;
    end;
    for i := 0 to Query.RecordCount - 1 do
    begin
      New(Magic);
      Magic.wMagicId := Query.FieldByName('MagId').AsInteger;
      Magic.sMagicName := Query.FieldByName('MagName').AsString;
      Magic.btEffectType := Query.FieldByName('EffectType').AsInteger;
      Magic.btEffect := Query.FieldByName('Effect').AsInteger;
      Magic.wSpell := Query.FieldByName('Spell').AsInteger;
      Magic.wPower := Query.FieldByName('Power').AsInteger;
      Magic.wMaxPower := Query.FieldByName('MaxPower').AsInteger;
      Magic.btJob := Query.FieldByName('Job').AsInteger;
      Magic.TrainLevel[0] := Query.FieldByName('NeedL1').AsInteger;
      Magic.TrainLevel[1] := Query.FieldByName('NeedL2').AsInteger;
      Magic.TrainLevel[2] := Query.FieldByName('NeedL3').AsInteger;
      Magic.TrainLevel[3] := Query.FieldByName('NeedL3').AsInteger;
      Magic.MaxTrain[0] := Query.FieldByName('L1Train').AsInteger;
      Magic.MaxTrain[1] := Query.FieldByName('L2Train').AsInteger;
      Magic.MaxTrain[2] := Query.FieldByName('L3Train').AsInteger;
      Magic.MaxTrain[3] :=$0493e0;// E0 93 04 00;
      if Magic.wMagicId in [87..89] then
        Magic.btTrainLv:=5
      else
        Magic.btTrainLv := 3;
      Magic.dwDelayTime := Query.FieldByName('Delay').AsInteger;
      Magic.btDefSpell := Query.FieldByName('DefSpell').AsInteger;
      Magic.btDefPower := Query.FieldByName('DefPower').AsInteger;
      Magic.btDefMaxPower := Query.FieldByName('DefMaxPower').AsInteger;
     // Magic.sDescr := Query.FieldByName('Descr').AsString;
      if Magic.wMagicId > 0 then
      begin
        UserEngine.m_MagicList.Add(Magic);
      end
      else
      begin
        Dispose(Magic);
      end;
      Result := 1;
      Query.Next;
    end;
    Query.Close;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMakeItem(): Integer; //00488CDC
var
  I, n14: Integer;
  s18, s20, s24: string;
  LoadList: TStringList;
  sFileName: string;
  List28: TStringList;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'MakeItem.txt';
  if FileExists(sFileName) then
  begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    List28 := nil;
    s24 := '';
    for I := 0 to LoadList.Count - 1 do
    begin
      s18 := Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then
      begin
        if s18[1] = '[' then
        begin
          if List28 <> nil then
            g_MakeItemList.AddObject(s24, List28);
          List28 := TStringList.Create;
          ArrestStringEx(s18, '[', ']', s24);
        end
        else
        begin
          if List28 <> nil then
          begin
            s18 := GetValidStr3(s18, s20, [' ', #9]);
            n14 := Str_ToInt(Trim(s18), 1);
            List28.AddObject(s20, TObject(n14));
          end;
        end;
      end;
    end; // for
    if List28 <> nil then
      g_MakeItemList.AddObject(s24, List28);
    LoadList.Free;
    Result := 1;
  end;

end;
//00486D1C

function TFrmDB.LoadMapInfo: Integer;
  //00486C1C
  function LoadMapQuest(sName: string): TMerchant;
  var
    QuestNPC: TMerchant;
  begin
    QuestNPC := TMerchant.Create;
    QuestNPC.m_sMapName := '0';
    QuestNPC.m_nCurrX := 0;
    QuestNPC.m_nCurrY := 0;
    QuestNPC.m_sCharName := sName;
    QuestNPC.m_nFlag := 0;
    QuestNPC.m_wAppr := 0;
    QuestNPC.m_sFilePath := 'MapQuest_def\';
    QuestNPC.m_boIsHide := True;
    QuestNPC.m_boIsQuest := False;
    UserEngine.QuestNPCList.Add(QuestNPC);
    Result := QuestNPC;
  end;
  procedure LoadSubMapInfo(LoadList: TStringList; sFileName: string);
  var
    I: Integer;
    sFilePatchName, sFileDir: string;
    LoadMapList: TStringList;
  begin
    sFileDir := g_Config.sEnvirDir + 'MapInfo\';
    if not DirectoryExists(sFileDir) then
    begin
      CreateDir(sFileDir);
    end;

    sFilePatchName := sFileDir + sFileName;
    if FileExists(sFilePatchName) then
    begin
      LoadMapList := TStringList.Create;
      LoadMapList.LoadFromFile(sFilePatchName);
      for I := 0 to LoadMapList.Count - 1 do
      begin
        LoadList.Add(LoadMapList.Strings[I]);
      end;
      LoadMapList.Free;
    end;
  end;
var
  sFileName: string;

  LoadList: TStringList;
  i: Integer;
  s30, s34, s38, sMapName, s44, sMapDesc, s4C, sReConnectMap,stemp: string;
  n14, n18, n1C, n20: Integer;
  nServerIndex: Integer;
  mirrorname: string;
  MapFlag: TMapFlag;
  QuestNPC: TMerchant;
  sMapInfoFile: string;
  SweatherEffect: string;
  Smapfunction: string;
  sgotolabel: string;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'MapInfo.txt';
  if FileExists(sFileName) then
  begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    if LoadList.Count < 0 then
    begin
      LoadList.Free;
      exit;
    end;
    I := 0;
    while (True) do
    begin
      if I >= LoadList.Count then
        break;
      if CompareLStr('loadmapinfo', LoadList.Strings[I], Length('loadmapinfo')) then
      begin
        sMapInfoFile := GetValidStr3(LoadList.Strings[I], s30, [' ', #9]);
        LoadList.Delete(I);
        if sMapInfoFile <> '' then
        begin
          LoadSubMapInfo(LoadList, sMapInfoFile);
        end;
      end;
      Inc(I);
    end;
    Result := 1;
      //加载地图设置
    for i := 0 to LoadList.Count - 1 do
    begin
      s30 := LoadList.Strings[i];
      if (s30 <> '') and (s30[1] = '[') then
      begin
        sMapName := '';
        MapFlag.boSAFE := False;
        s30 := ArrestStringEx(s30, '[', ']', sMapName);
        sMapDesc := GetValidStrCap(sMapName, sMapName, [' ', ',', #9]);
        if (sMapDesc <> '') and (sMapDesc[1] = '"') then
          ArrestStringEx(sMapDesc, '"', '"', sMapDesc);
        s4C := Trim(GetValidStr3(sMapDesc, sMapDesc, [' ', ',', #9]));
        nServerIndex := Str_ToInt(s4C, 0);
        if sMapName = '' then
          Continue;
       ///////////////////

         //地图 和景象地图名称
        mirrorname := '';
        if pos('>', sMapName) > 0 then
          sMapName := ArrestStringEx(sMapName, '<', '>', mirrorname);
        if pos('|', sMapName) > 0 then
          sMapName  := GetValidStr3(sMapName, mirrorname, ['|']);
         /////////////////

        FillChar(MapFlag, SizeOf(TMapFlag), #0);

        MapFlag.nL := 1;
        QuestNPC := nil;
        MapFlag.nNEEDSETONFlag := -1;
        MapFlag.nNeedONOFF := -1;
        MapFlag.mirrorname := mirrorname;

        while (True) do
        begin
          if s30 = '' then
            break;
          s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
          //  s30:=UpperCase(s30);
          if s34 = '' then
            break;
          MapFlag.nMUSICID := -1;

          s34 := UpperCase(s34);

          if CompareText(s34, 'SAFE') = 0 then
          begin
            MapFlag.boSAFE := True;
            Continue;
          end;
          if CompareLStr(s34,'DelayGoto(',10) then
          begin
            ArrestStringEx(s34, '(', ')',  sTemp);
            MapFlag.m_sDelayCall:= GetValidStr3(stemp,s34, ['/']);
            if MapFlag.m_sDelayCall<>'' then
              MapFlag.m_nDelayCallTime:=Str_ToInt(s34,0)*1000;
            Continue;
          end;

          if CompareText(s34, 'CANHORSE') = 0 then
          begin
            MapFlag.boCANHORSE := True;
            Continue;
          end;
          if CompareText(s34, 'CANUSELF') = 0 then
          begin
            MapFlag.boCanUseLF := True;
            Continue;
          end;

          if CompareText(s34, 'NOYS') = 0 then
          begin
            MapFlag.boNOYS := True;
            Continue;
          end;
          if CompareText(s34, 'NOQB') = 0 then
          begin
            MapFlag.boNOQB := True;
            Continue;
          end;

          if CompareText(s34, 'NOBATFLY') = 0 then
          begin
            MapFlag.boNOBATFLY := True;
            Continue;
          end;
          if CompareLStr(s34,'CANUSESUPERITEM',15) then
          Begin
           ArrestStringEx(s34, '[', ']',  MapFlag.m_sCanUserItem);
          End;
          if CompareLStr(s34,'NOTALLOWUSEITEMS',16) then
          Begin
           ArrestStringEx(s34, '(', ')',  MapFlag.m_sNotAllowUseItem);
          End;
          if CompareLStr(s34,'FORBIDMAGICS(',13) then
          Begin
           ArrestStringEx(s34, '(', ')',  MapFlag.m_sNotAllowUseMagic);
          End;
          if POS('WEATHER', s34) > 0 then
          begin
            s34 := ArrestStringEx(s34, '(', ')', SweatherEffect);
            stemp:=SweatherEffect;
            stemp:=GetValidStr3(stemp,s34, ['/']);
            MapFlag.m_weatherEffect := STR_toint(s34, 0);
            stemp:=GetValidStr3(stemp,s34, ['/']);
            MapFlag.m_WindSpeed := STR_toint(s34, 0);
            MapFlag.m_WinsColor := STR_toint(stemp, 0);

            Continue;
          end;
            // m_nQfunction

          if POS('MAPFUNC', s34) =1 then
          begin
            s34 := ArrestStringEx(s34, '(', ')', Smapfunction);
            MapFlag.m_nQfunction := STR_toint(Smapfunction, 0);
            Continue;
          end;
//    m_skillbyhumlabel:string[20];
//    m_skillbymonlabel:string[20];

//    m_skillhumlabel:string[20];
//    m_skillmonlabel:string[20];
//    m_slevelupgotolabel:string[20];

          if POS('KILLBYHUM', s34) > 0 then
          begin
            s34 := ArrestStringEx(s34, '(', ')', sgotolabel);
            MapFlag.m_skillbyhumlabel := sgotolabel;
            Continue;
          end;
          if POS('KILLBYMON', s34) > 0 then
          begin
            s34 := ArrestStringEx(s34, '(', ')', sgotolabel);
            MapFlag.m_skillbymonlabel := sgotolabel;
            Continue;
          end;
          if POS('KILLHUM', s34) > 0 then
          begin
            s34 := ArrestStringEx(s34, '(', ')', sgotolabel);
            MapFlag.m_skillhumlabel := sgotolabel;
            Continue;
          end;
          if POS('KILLMON', s34) > 0 then
          begin
            s34 := ArrestStringEx(s34, '(', ')', sgotolabel);
            MapFlag.m_skillmonlabel := sgotolabel;
            Continue;
          end;


          if POS('LEVELUP', s34) > 0 then
          begin
            s34 := ArrestStringEx(s34, '(', ')', sgotolabel);
            MapFlag.m_slevelupgotolabel := sgotolabel;
            Continue;
          end;



          if CompareText(s34, 'DARK') = 0 then
          begin
            MapFlag.boDARK := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT') = 0 then
          begin
            MapFlag.boFIGHT := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT3') = 0 then
          begin
            MapFlag.boFIGHT3 := True;
            Continue;
          end;
          if CompareText(s34, 'DAY') = 0 then
          begin
            MapFlag.boDAY := True;
            Continue;
          end;
          if CompareText(s34, 'QUIZ') = 0 then
          begin
            MapFlag.boQUIZ := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORECONNECT', length('NORECONNECT')) then
          begin
            MapFlag.boNORECONNECT := True;
            ArrestStringEx(s34, '(', ')', sReConnectMap);
            MapFlag.sReConnectMap := sReConnectMap;
            if MapFlag.sReConnectMap = '' then
              Result := -11;
            Continue;
          end;
          if CompareLStr(s34, 'CHECKQUEST', length('CHECKQUEST')) then
          begin
            ArrestStringEx(s34, '(', ')', s38);
            QuestNPC := LoadMapQuest(s38);
            Continue;
          end;
          if CompareLStr(s34, 'NEEDSET_ON', length('NEEDSET_ON')) then
          begin
            MapFlag.nNeedONOFF := 1;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDSETONFlag := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'NEEDSET_OFF', length('NEEDSET_OFF')) then
          begin
            MapFlag.nNeedONOFF := 0;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDSETONFlag := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'MUSIC', length('MUSIC')) then
          begin
            MapFlag.boMUSIC := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nMUSICID := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'EXPRATE', length('EXPRATE')) then
          begin
            MapFlag.boEXPRATE := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nEXPRATE := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKWINLEVEL', length('PKWINLEVEL')) then
          begin
            MapFlag.boPKWINLEVEL := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKWINLEVEL := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKWINEXP', length('PKWINEXP')) then
          begin
            MapFlag.boPKWINEXP := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKWINEXP := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKLOSTLEVEL', length('PKLOSTLEVEL')) then
          begin
            MapFlag.boPKLOSTLEVEL := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKLOSTLEVEL := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKLOSTEXP', length('PKLOSTEXP')) then
          begin
            MapFlag.boPKLOSTEXP := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKLOSTEXP := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECHP', length('DECHP')) then
          begin
            MapFlag.boDECHP := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECHPPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECHPTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCHP', length('INCHP')) then
          begin
            MapFlag.boINCHP := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCHPPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCHPTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECGAMEGOLD', length('DECGAMEGOLD')) then
          begin
            MapFlag.boDECGAMEGOLD := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECGAMEGOLD := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECGAMEGOLDTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECGAMEPOINT', length('DECGAMEPOINT')) then
          begin
            MapFlag.boDECGAMEPOINT := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECGAMEPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECGAMEPOINTTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCGAMEGOLD', length('INCGAMEGOLD')) then
          begin
            MapFlag.boINCGAMEGOLD := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCGAMEGOLD := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCGAMEGOLDTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCGAMEPOINT', length('INCGAMEPOINT')) then
          begin
            MapFlag.boINCGAMEPOINT := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCGAMEPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCGAMEPOINTTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'RUNHUMAN', length('RUNHUMAN')) then
          begin
            MapFlag.boRUNHUMAN := True;
            Continue;
          end;
          if CompareLStr(s34, 'RUNMON', length('RUNMON')) then
          begin
            MapFlag.boRUNMON := True;
            Continue;
          end;
          if CompareLStr(s34, 'NEEDHOLE', length('NEEDHOLE')) then
          begin
            MapFlag.boNEEDHOLE := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORECALL', length('NORECALL')) then
          begin
            MapFlag.boNORECALL := True;
            Continue;
          end;
          //CANRECALLEVIL
          if CompareLStr(s34, 'CANRECALLEVIL', length('CANRECALLEVIL')) then
          begin
            MapFlag.boCANRECALLEVIL := True;
            Continue;
          end;

          if CompareLStr(s34, '@mapfunc', length('@mapfunc')) then
          begin
            MapFlag.sMapFucx := s34;
            Continue;
          end;

          if CompareLStr(s34, 'NOGUILDRECALL', length('NOGUILDRECALL')) then
          begin
            MapFlag.boNOGUILDRECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NODEARRECALL', length('NODEARRECALL')) then
          begin
            MapFlag.boNODEARRECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NOMASTERRECALL', length('NOMASTERRECALL')) then
          begin
            MapFlag.boNOMASTERRECALL := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORANDOMMOVE', length('NORANDOMMOVE')) then
          begin
            MapFlag.boNORANDOMMOVE := True;
            Continue;
          end;


          if CompareLStr(s34, 'NODOSHOP', length('NODOSHOP')) then
          begin
            MapFlag.boNODOSHOP := True;
            Continue;
          end;

          if CompareLStr(s34, 'NODRUG', length('NODRUG')) then
          begin
            MapFlag.boNODRUG := True;
            Continue;
          end;
          if CompareLStr(s34, 'MINE', length('MINE')) then
          begin
            MapFlag.boMINE := True;
            Continue;
          end;
          if CompareLStr(s34, 'NOPOSITIONMOVE', length('NOPOSITIONMOVE')) then
          begin
            MapFlag.boNOPOSITIONMOVE := True;
            Continue;
          end;
          if (s34[1] = 'L') then
          begin
            MapFlag.nL := Str_ToInt(Copy(s34, 2, Length(s34) - 1), 1);
          end;
        end;
        if g_MapManager.AddMapInfo(sMapName, sMapDesc, nServerIndex, @MapFlag, QuestNPC) = nil then
          Result := -10;
          {
          if EnvirList.AddMapInfo(s40,
                                  s48,
                                  nServerIndex,
                                  n10,
                                  boSAFE,
                                  boFIGHT,
                                  boFIGHT3,
                                  boDARK,
                                  boDAY,
                                  boQUIZ,
                                  boNORECONNECT,
                                  boNEEDHOLE,
                                  boNORECALL,
                                  boNORANDOMMOVE,
                                  boNODRUG,
                                  boMINE,
                                  boNOPOSITIONMOVE,
                                  sReConnectMap,
                                  QuestNPC,
                                  nNEEDSETONFlag,
                                  nNeedONOFF) = nil then Result:= -10;
          }
      end;
    end;
      //加载地图连接点
    for i := 0 to LoadList.Count - 1 do
    begin
      s30 := LoadList.Strings[i];
      if (s30 <> '') and (s30[1] <> '[') and (s30[1] <> ';') then
      begin
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        sMapName := s34;
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n14 := Str_ToInt(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n18 := Str_ToInt(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', '-', '>', #9]);
        s44 := s34;
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n1C := Str_ToInt(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', ';', #9]);
        n20 := Str_ToInt(s34, 0);
        g_MapManager.AddMapRoute(sMapName, n14, n18, s44, n1C, n20);
            //sSMapNO,nSMapX,nSMapY,sDMapNO,nDMapX,nDMapY
      end;
    end;
    LoadList.Free;
  end;
end;

procedure TFrmDB.QSHOPNPC;
var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;
begin
  try
    sScriptFile := g_Config.sEnvirDir + sMarket_Def + 'QWolShop-0.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir + sMarket_Def;
    if not DirectoryExists(sScritpDir) then
      mkdir(Pchar(sScritpDir));

    if not FileExists(sScriptFile) then
    begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为功能脚本，用于实现各种与商城有关的功能');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if FileExists(sScriptFile) then
    begin
      g_SHOPNPC := TMerchant.Create;
      g_SHOPNPC.m_sMapName := '0';
      g_SHOPNPC.m_nCurrX := 0;
      g_SHOPNPC.m_nCurrY := 0;
      g_SHOPNPC.m_sCharName := 'QSHOPNPC';
      g_SHOPNPC.m_nFlag := 0;
      g_SHOPNPC.m_wAppr := 0;
      g_SHOPNPC.m_sFilePath := sMarket_Def;
      g_SHOPNPC.m_sScript := 'QWolShop';
      g_SHOPNPC.m_boIsHide := True;
      g_SHOPNPC.m_boIsQuest := False;
      UserEngine.AddMerchant(g_SHOPNPC);
    end
    else
    begin
      g_SHOPNPC := nil;
    end;
  except
    g_SHOPNPC := nil;
  end;
end;
procedure TFrmDB.QGuildTowerNPC;
var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;
begin
  try
    sScriptFile := g_Config.sEnvirDir + sMarket_Def + 'TLT-0.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir + sMarket_Def;
    if not DirectoryExists(sScritpDir) then
      mkdir(Pchar(sScritpDir));

    if not FileExists(sScriptFile) then
    begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为功能脚本，用于实现各种与脚本有关的功能');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if FileExists(sScriptFile) then
    begin
      g_GuildTowerNPC := TMerchant.Create;
      g_GuildTowerNPC.m_sMapName := '0';
      g_GuildTowerNPC.m_nCurrX := 0;
      g_GuildTowerNPC.m_boGuildTower:=True;
      g_GuildTowerNPC.m_nCurrY := 0;
      g_GuildTowerNPC.m_sCharName := 'QGuildTower';
      g_GuildTowerNPC.m_nFlag := 0;
      g_GuildTowerNPC.m_wAppr := 0;
      g_GuildTowerNPC.m_sFilePath := sMarket_Def;
      g_GuildTowerNPC.m_sScript := 'QGuildTower';
      g_GuildTowerNPC.m_boIsHide := True;
      g_GuildTowerNPC.m_boIsQuest := False;
      UserEngine.AddMerchant(g_GuildTowerNPC);
    end
    else
    begin
      g_GuildTowerNPC := nil;
    end;
  except
    g_GuildTowerNPC := nil;
  end;
end;
procedure TFrmDB.QFunctionNPC;
var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;
begin
  try
    sScriptFile := g_Config.sEnvirDir + sMarket_Def + 'QFunction-0.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir + sMarket_Def;
    if not DirectoryExists(sScritpDir) then
      mkdir(Pchar(sScritpDir));

    if not FileExists(sScriptFile) then
    begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为功能脚本，用于实现各种与脚本有关的功能');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if FileExists(sScriptFile) then
    begin
      g_FunctionNPC := TMerchant.Create;
      g_FunctionNPC.m_sMapName := '0';
      g_FunctionNPC.m_nCurrX := 0;
      g_FunctionNPC.m_nCurrY := 0;
      g_FunctionNPC.m_sCharName := 'QFunction';
      g_FunctionNPC.m_nFlag := 0;
      g_FunctionNPC.m_wAppr := 0;
      g_FunctionNPC.m_sFilePath := sMarket_Def;
      g_FunctionNPC.m_sScript := 'QFunction';
      g_FunctionNPC.m_boIsHide := True;
      g_FunctionNPC.m_boIsQuest := False;
      UserEngine.AddMerchant(g_FunctionNPC);
    end
    else
    begin
      g_FunctionNPC := nil;
    end;
  except
    g_FunctionNPC := nil;
  end;
end;

procedure TFrmDB.QMangeNPC();
var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;
begin
  try
    sScriptFile := g_Config.sEnvirDir + 'MapQuest_def\' + 'QManage.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir + 'MapQuest_def\';
    if not DirectoryExists(sScritpDir) then
      mkdir(Pchar(sScritpDir));

    if not FileExists(sScriptFile) then
    begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为登录脚本，人物每次登录时都会执行此脚本，所有人物初始设置都可以放在此脚本中。');
      SaveList.Add(';修改脚本内容，可用@ReloadManage命令重新加载该脚本，不须重启程序。');
      SaveList.Add('[@Login]');
      SaveList.Add('#if');
      SaveList.Add('#act');
//    tSaveList.Add(';设置10倍杀怪经验');
//    tSaveList.Add(';CANGETEXP 1 10');
      SaveList.Add('#say');
      SaveList.Add('游戏登录脚本运行成功，欢迎进入本游戏！！！\ \');
      SaveList.Add('<关闭/@exit> \ \');
      SaveList.Add('登录脚本文件位于: \');
      SaveList.Add(sShowFile + '\');
      SaveList.Add('脚本内容请自行按自己的要求修改。');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if FileExists(sScriptFile) then
    begin
      g_ManageNPC := TMerchant.Create;
      g_ManageNPC.m_sMapName := '0';
      g_ManageNPC.m_nCurrX := 0;
      g_ManageNPC.m_nCurrY := 0;
      g_ManageNPC.m_sCharName := 'QManage';
      g_ManageNPC.m_nFlag := 0;
      g_ManageNPC.m_wAppr := 0;
      g_ManageNPC.m_sFilePath := 'MapQuest_def\';
      g_ManageNPC.m_boIsHide := True;
      g_ManageNPC.m_boIsQuest := False;
      UserEngine.QuestNPCList.Add(g_ManageNPC);
    end
    else
    begin
      g_ManageNPC := nil;
    end;
  except
    g_ManageNPC := nil;
  end;
end;

procedure TFrmDB.RobotNPC();
var
  sScriptFile: string;
  sScritpDir: string;
  tSaveList: TStringList;
begin
  try
    sScriptFile := g_Config.sEnvirDir + 'Robot_def\' + 'RobotManage.txt';
    sScritpDir := g_Config.sEnvirDir + 'Robot_def\';
    if not DirectoryExists(sScritpDir) then
      mkdir(Pchar(sScritpDir));

    if not FileExists(sScriptFile) then
    begin
      tSaveList := TStringList.Create;
      tSaveList.Add(';此脚为机器人专用脚本，用于机器人处理功能用的脚本。');
      tSaveList.SaveToFile(sScriptFile);
      tSaveList.Free;
    end;
    if FileExists(sScriptFile) then
    begin
      g_RobotNPC := TMerchant.Create;
      g_RobotNPC.m_sMapName := '0';
      g_RobotNPC.m_nCurrX := 0;
      g_RobotNPC.m_nCurrY := 0;
      g_RobotNPC.m_sCharName := 'RobotManage';
      g_RobotNPC.m_nFlag := 0;
      g_RobotNPC.m_wAppr := 0;
      g_RobotNPC.m_sFilePath := 'Robot_def\';
      g_RobotNPC.m_boIsHide := True;
      g_RobotNPC.m_boIsQuest := False;
      UserEngine.QuestNPCList.Add(g_RobotNPC);
    end
    else
    begin
      g_RobotNPC := nil;
    end;
  except
    g_RobotNPC := nil;
  end;
end;
//00489414
function TFrmDB.LoadMapNewEvent:Integer;
var
  sFileName, tStr: string;
  tMapQuestList: TStringList;
  i: Integer;
  s1, s2, s3, s4, s5, s6, s7, s8: string;
  nx, ny,n: Integer;

  pNewMapEvent :pTNewMapEvent;
  Map: TEnvirnoment;
begin
  Result := 1;
  sFileName := g_Config.sEnvirDir + 'MapEvent.txt';
  if FileExists(sFileName) then
  begin
    tMapQuestList := TStringList.Create;
    tMapQuestList.LoadFromFile(sFileName);
    for i := 0 to tMapQuestList.Count - 1 do
    begin
      tStr :=Trim(tMapQuestList.Strings[i]);
      if (tStr <> '') and (tStr[1] <> ';') then
      begin
        tStr := GetValidStr3(tStr, s1, [' ', #9]);
        tStr := GetValidStr3(tStr, s2, [' ', #9]);
        tStr := GetValidStr3(tStr, s3, [' ', #9]);
        tStr := GetValidStr3(tStr, s4, [' ', #9]);
        tStr := GetValidStr3(tStr, s5, [' ', #9]);
        tStr := GetValidStr3(tStr, s6, [' ', #9]);
        tStr := GetValidStr3(tStr, s7, [' ', #9]);
        tStr := GetValidStr3(tStr, s8, [' ', #9]);

        if (s1 <> '') and (s2 <> '') and (s3 <> '') then
        begin
          Map := g_MapManager.FindMap(s1);
          if Map <> nil then
          begin
            New(pNewMapEvent);
            nx := Str_ToInt(s2, 0);
            ny := Str_ToInt(s3, 0);
            n:=Str_ToInt(s4,0);
            s5:=GetValidStr3(s5, s2, [':']);
            pNewMapEvent.nSign:=Str_ToInt(s5,0);
            s6:=GetValidStr3(s6, s2, [':']);
            s6:=GetValidStr3(s6, s3, [':']);
            pNewMapEvent^.btcondition:=Str_ToInt(s2,0);
            pNewMapEvent^.sConditionItem:=s3;
            pNewMapEvent^.boconditionGroup:=s6='1';
            tstr:=s7;
             tStr := GetValidStr3(tStr, s1, [':']);
            tStr := GetValidStr3(tStr, s2, [':']);
            tStr := GetValidStr3(tStr, s3, [':']);
            pNewMapEvent.nRate:=Str_ToInt(s1,0);

            pNewMapEvent.sLabel:=s3;
            Map.AddToMap(nx,ny,OS_NEWMAPEVENT,TObject(pNewMapEvent));
          end
          else
            Result := -i;
        end
        else
          Result := -i;
      end;
    end;
    tMapQuestList.Free;
  end;
end;
function TFrmDB.LoadMapQuest(): Integer;
var
  sFileName, tStr: string;
  tMapQuestList: TStringList;
  i: Integer;
  s18, s1C, s20, s24, s28, s2C, s30, s34: string;
  n38, n3C: Integer;
  boGrouped: Boolean;
  Map: TEnvirnoment;
begin
  Result := 1;
  sFileName := g_Config.sEnvirDir + 'MapQuest.txt';
  if FileExists(sFileName) then
  begin
    tMapQuestList := TStringList.Create;
    tMapQuestList.LoadFromFile(sFileName);
    for i := 0 to tMapQuestList.Count - 1 do
    begin
      tStr := tMapQuestList.Strings[i];
      if (tStr <> '') and (tStr[1] <> ';') then
      begin
        tStr := GetValidStr3(tStr, s18, [' ', #9]);
        tStr := GetValidStr3(tStr, s1C, [' ', #9]);
        tStr := GetValidStr3(tStr, s20, [' ', #9]);
        tStr := GetValidStr3(tStr, s24, [' ', #9]);
        if (s24 <> '') and (s24[1] = '"') then
          ArrestStringEx(s24, '"', '"', s24);
        tStr := GetValidStr3(tStr, s28, [' ', #9]);
        if (s28 <> '') and (s28[1] = '"') then
          ArrestStringEx(s28, '"', '"', s28);
        tStr := GetValidStr3(tStr, s2C, [' ', #9]);
        tStr := GetValidStr3(tStr, s30, [' ', #9]);
        if (s18 <> '') and (s24 <> '') and (s2C <> '') then
        begin
          Map := g_MapManager.FindMap(s18);
          if Map <> nil then
          begin
            ArrestStringEx(s1C, '[', ']', s34);
            n38 := Str_ToInt(s34, 0);
            n3C := Str_ToInt(s20, 0);
            if CompareLStr(s30, 'GROUP', length('GROUP')) then
              boGrouped := True
            else
              boGrouped := False;
            if not Map.CreateQuest(n38, n3C, s24, s28, s2C, boGrouped) then
              Result := -i;
              //nFlag,boFlag,Monster,Item,Quest,boGrouped
          end
          else
            Result := -i;
        end
        else
          Result := -i;
      end;
    end;
    tMapQuestList.Free;
  end;
  QMangeNPC();
  QFunctionNPC();
  QGuildTowerNPC;
  QSHOPNPC();
  RobotNPC();
end;
//0048784C

function gettopname(sname: string; var bnpc: byte; var appr: integer): string;
var
  rs: string;
begin
  if topfile = nil then
    exit;
  bnpc := 0;
  if sname = '<top1>' then
  begin
    rs := topfile.readString('top', '1', '');
    if (rs <> '') then
    begin // (topnpcarr[1].sname='') and
      rs := GetValidStrCap(rs, topnpcarr[1].sname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[1].sguildname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[1].slevel, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[1].sdate, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[1].npcappr, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[1].job, ['/']);
      bnpc := 1;
      result := '天下第一男战士\' + topnpcarr[1].sname + '\';
    end
    else
      result := '天下第一男战士\暂无\';
  end;

  if sname = '<top2>' then
  begin
    rs := topfile.readString('top', '2', '');
    if (rs <> '') then
    begin //  (topnpcarr[2].sname='') and
      rs := GetValidStrCap(rs, topnpcarr[2].sname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[2].sguildname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[2].slevel, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[2].sdate, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[2].npcappr, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[2].job, ['/']);
      bnpc := 2;
      result := '天下第一女战士\' + topnpcarr[2].sname + '\';
    end
    else
      result := '天下第一女战士\暂无\';
  end;

  if sname = '<top3>' then
  begin
    rs := topfile.readString('top', '3', '');
    if (rs <> '') then
    begin // (topnpcarr[3].sname='') and
      rs := GetValidStrCap(rs, topnpcarr[3].sname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[3].sguildname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[3].slevel, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[3].sdate, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[3].npcappr, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[3].job, ['/']);
      bnpc := 3;
      result := '天下第一男法师\' + topnpcarr[3].sname + '\';
    end
    else
      result := '天下第一男法师\暂无\';
  end;

  if sname = '<top4>' then
  begin
    rs := topfile.readString('top', '4', '');
    if (rs <> '') then
    begin //  (topnpcarr[4].sname='') and
      rs := GetValidStrCap(rs, topnpcarr[4].sname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[4].sguildname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[4].slevel, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[4].sdate, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[4].npcappr, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[4].job, ['/']);

      bnpc := 4;
      result := '天下第一女法师\' + topnpcarr[4].sname + '\';
    end
    else
      result := '天下第一女法师\暂无\';
  end;

  if sname = '<top5>' then
  begin
    rs := topfile.readString('top', '5', '');
    if (rs <> '') then
    begin // (topnpcarr[5].sname='') and
      rs := GetValidStrCap(rs, topnpcarr[5].sname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[5].sguildname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[5].slevel, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[5].sdate, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[5].npcappr, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[5].job, ['/']);

      bnpc := 5;
      result := '天下第一男道士\' + topnpcarr[5].sname + '\';
    end
    else
      result := '天下第一男道士\暂无\';
  end;


  if sname = '<top6>' then
  begin
    rs := topfile.readString('top', '6', '');
    if (rs <> '') then
    begin //  (topnpcarr[6].sname='') and
      rs := GetValidStrCap(rs, topnpcarr[6].sname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[6].sguildname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[6].slevel, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[6].sdate, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[6].npcappr, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[6].job, ['/']);
      bnpc := 6;
      result := '天下第一女道士\' + topnpcarr[6].sname + '\';
    end
    else
      result := '天下第一女道士\暂无\';
  end;

{   if sname='<top8>' then begin
            rs:=topfile.readString('top','8','');
            if (rs<>'') then begin    //  (topnpcarr[8].sname='') and
            rs:=GetValidStrCap(rs, topnpcarr[8].sname, ['/']);
            rs:=GetValidStrCap(rs, topnpcarr[8].sguildname, ['/']);
            rs:=GetValidStrCap(rs, topnpcarr[8].slevel, ['/']);
            rs:=GetValidStrCap(rs, topnpcarr[8].sdate, ['/']);
            rs:=GetValidStrCap(rs, topnpcarr[8].npcappr, ['/']);
            rs:=GetValidStrCap(rs, topnpcarr[8].job, ['/']);
            bnpc:=6;
            result:='第一元神男战士\'+topnpcarr[8].sname+'\';
            end else
            result:='第一元神男战士\暂无\';
   end;        }

  if sname = '<master>' then
  begin
    rs := topfile.readString('top', '7', '');
    if (rs <> '') then
    begin // (topnpcarr[7].sname='') and
      rs := GetValidStrCap(rs, topnpcarr[7].sname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[7].sguildname, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[7].slevel, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[7].sdate, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[7].npcappr, ['/']);
      rs := GetValidStrCap(rs, topnpcarr[7].job, ['/']);
      bnpc := 7;
      appr := strtoint(topnpcarr[7].npcappr);
      result := '沙城霸主\' + topnpcarr[7].sguildname + '\' + topnpcarr[7].sname + '\';
    end
    else
      result := '沙城霸主\暂无\';
  end;







end;

function TFrmDB.LoadMerchant(): Integer;
var
  sFileName, sLineText, sScript, sMapName, sX, sY, sName, sFlag, sAppr, sIsCalste, sCanMove, sMoveTime: string;
  tMerchantList: TStringList;
  tMerchantNPC: TMerchant;
  i, appr: Integer;
  mirrorname: string;
  IniFile:TIniFile;
begin

  sFileName := g_Config.sEnvirDir + 'Merchant.txt';
  if FileExists(sFileName) then
  begin
    tMerchantList := TStringList.Create;
    tMerchantList.LoadFromFile(sFileName);
    for i := 0 to tMerchantList.Count - 1 do
    begin
      sLineText := Trim(tMerchantList.Strings[i]);
      if (sLineText <> '') and (sLineText[1] <> ';') then
      begin
        sLineText := GetValidStr3(sLineText, sScript, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMapName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sX, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sY, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sName, [' ', #9]);
        if (sName <> '') and (sName[1] = '"') then
          ArrestStringEx(sName, '"', '"', sName);
        sLineText := GetValidStr3(sLineText, sFlag, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAppr, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sIsCalste, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCanMove, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMoveTime, [' ', #9]);

        mirrorname := '';
        if pos('>', sMapName) > 0 then
          sMapName := ArrestStringEx(sMapName, '<', '>', mirrorname);

        if (sScript <> '') and (sMapName <> '') and (sAppr <> '') then
        begin
          tMerchantNPC := TMerchant.Create;
          tMerchantNPC.m_sScript := sScript;
          tMerchantNPC.m_sMapName := sMapName;
          tMerchantNPC.m_nCurrX := Str_ToInt(sX, 0);
          tMerchantNPC.m_nCurrY := Str_ToInt(sY, 0);
          //  tMerchantNPC.byistopnpc :=0;
          if pos('<', sname) > 0 then
          begin

            tMerchantNPC.m_sCharName := gettopname(sName, tMerchantNPC.byistopnpc, appr); //这里初识化 top npc 名字 脚本读取时的设置。

          end
          else
            tMerchantNPC.m_sCharName := sName;

          tMerchantNPC.m_nFlag := Str_ToInt(sFlag, 0);
          if tMerchantNPC.byistopnpc = 7 then
            tMerchantNPC.m_wAppr := appr
          else
            tMerchantNPC.m_wAppr := Str_ToInt(sAppr, 0);
          tMerchantNPC.m_dwMoveTime := Str_ToInt(sMoveTime, 0);
          tMerchantNPC.mirrorname := mirrorname;
           tMerchantNPC.m_nCastle:=Str_ToInt(sIsCalste, 0);
           tMerchantNPC.m_boQiZuo:=False;
          if sIsCalste='1' then tMerchantNPC.m_boCastle := True;
          if Str_ToInt(sIsCalste, 0) >1 then
          Begin
            if tMerchantNPC.m_wAppr=172 then tMerchantNPC.m_boQiZuo:=True;
            IniFile:=TIniFile.Create(g_Config.sEnvirDir + 'NpcName.txt');
            sName:=IniFile.ReadString('Names',sIsCalste,tMerchantNPC.m_scharName);
            if  sName<>tMerchantNPC.m_scharName then
            Begin
              tMerchantNPC.m_scharName:=sName;
              tMerchantNPC.m_wAppr:=IniFile.ReadInteger('Apprs',sIsCalste,tMerchantNPC.m_wAppr);
              tMerchantNPC.m_sComments:=IniFile.ReadString('Comments',sIsCalste,tMerchantNPC.m_scharName);
            End
            else
               tMerchantNPC.m_wAppr1:=IniFile.ReadInteger('Apprs',sIsCalste,tMerchantNPC.m_wAppr);
          End;
          if (Str_ToInt(sCanMove, 0) <> 0) and (tMerchantNPC.m_dwMoveTime > 0) then
            tMerchantNPC.m_boCanMove := True;
          UserEngine.AddMerchant(tMerchantNPC); //00487B4D
        end;
      end;
    end;
    tMerchantList.Free;
  end;
  Result := 1;
end;
//004890C0

function TFrmDB.LoadMinMap: Integer;
var
  sFileName, tStr, sMapNO, sMapIdx: string;
  tMapList: TStringList;
  i, nIdx: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'MiniMap.txt';
  if FileExists(sFileName) then
  begin
    MiniMapList.Clear;
    tMapList := TStringList.Create;
    tMapList.LoadFromFile(sFileName);
    for i := 0 to tMapList.Count - 1 do
    begin
      tStr := tMapList.Strings[i];
      if (tStr <> '') and (tStr[1] <> ';') then
      begin
        tStr := GetValidStr3(tStr, sMapNO, [' ', #9]);
        tStr := GetValidStr3(tStr, sMapIdx, [' ', #9]);
        nIdx := Str_ToInt(sMapIdx, 0);
        if nIdx > 0 then
          MiniMapList.AddObject(sMapNO, TObject(nIdx));
      end;
    end;
    tMapList.Free;
  end;
end;
//004867F4

function TFrmDB.LoadMonGen(): Integer;
  procedure LoadMapGen(MonGenList: TStringList; sFileName: string);
  var
    I: Integer;
    sFilePatchName: string;
    sFileDir: string;
    LoadList: TStringList;
  begin
    sFileDir := g_Config.sEnvirDir + 'MonGen\';
    if not DirectoryExists(sFileDir) then
    begin
      CreateDir(sFileDir);
    end;

    sFilePatchName := sFileDir + sFileName;
    if FileExists(sFilePatchName) then
    begin
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(sFilePatchName);
      for I := 0 to LoadList.Count - 1 do
      begin
        MonGenList.Add(LoadList.Strings[I]);
      end;
      LoadList.Free;
    end;
  end;
var
  sFileName, sLineText, sData: string;
  MonGenInfo: pTMonGenInfo;
  LoadList: TStringList;
  sMapGenFile: string;
  i: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'MonGen.txt';
  if FileExists(sFileName) then
  begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    I := 0;
    while (True) do
    begin
      if I >= LoadList.Count then
        break;
      if CompareLStr('loadgen', LoadList.Strings[I], Length('loadgen')) then
      begin
        sMapGenFile := GetValidStr3(LoadList.Strings[I], sLineText, [' ', #9]);
        LoadList.Delete(I);
        if sMapGenFile <> '' then
        begin
          LoadMapGen(LoadList, sMapGenFile);
        end;
      end;
      Inc(I);
    end;
    for i := 0 to LoadList.Count - 1 do
    begin
      sLineText := LoadList.Strings[i];
      if (sLineText <> '') and (sLineText[1] <> ';') then
      begin
        New(MonGenInfo);
        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.sMapName := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nX := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nY := Str_ToInt(sData, 0);

        sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
        if (sData <> '') and (sData[1] = '"') then
          ArrestStringEx(sData, '"', '"', sData);

        MonGenInfo.sMonName := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nRange := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nCount := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.dwZenTime := Str_ToInt(sData, 1) * 60 * 1000;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
           sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nMissionGenRate := Str_ToInt(sData, 0); //集中座标刷新机率 1 -100
        if sLineText<>'' then
        Begin
            sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
            MonGenInfo.sMonNewName:=sData;
            sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
            MonGenInfo.nLevel:=Str_ToInt(sData,0);
        End
        else
           MonGenInfo.sMonNewName:='';
        if (MonGenInfo.sMapName <> '') and
          (MonGenInfo.sMonName <> '') and
          (MonGenInfo.dwZenTime <> 0) and
          (g_MapManager.GetMapInfo(nServerIndex, MonGenInfo.sMapName) <> nil) then
        begin

          MonGenInfo.CertList := TList.Create;
          MonGenInfo.Envir := g_MapManager.FindMap(MonGenInfo.sMapName);
          if MonGenInfo.Envir <> nil then
          begin
           //   MonGenInfo.dwStartTick:=0;
            UserEngine.m_MonGenList.Add(MonGenInfo);
         //     MainOutMessage(format('序号=%d:怪物%s:数量%d',[UserEngine.m_MonGenList.count,MonGenInfo.sMonName,MonGenInfo.nCount]));

          end
          else
          begin
            Dispose(MonGenInfo);
          end;
        end
        else
          Dispose(MonGenInfo); //hint 泄露
          //tMonGenInfo.nRace:=UserEngine.GetMonRace(tMonGenInfo.sMonName);

      end; //00486B5B
    end; //00486B67
      //00486B67
    New(MonGenInfo);
    MonGenInfo.sMapName := '';
    MonGenInfo.sMonName := '';
    MonGenInfo.CertList := TList.Create;
    MonGenInfo.Envir := nil;
    UserEngine.m_MonGenList.Add(MonGenInfo);

    LoadList.Free;
    Result := 1;
  end;
end;
//00485E04

function TFrmDB.LoadMonsterDB(): Integer;
var
  i: Integer;
  Monster: pTMonInfo;
resourcestring
  sSQLString = 'select * from Monster';
begin
  Result := 0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for I := 0 to UserEngine.MonsterList.Count - 1 do
    begin
      Dispose(pTMonInfo(UserEngine.MonsterList.Items[I]));
    end;
    UserEngine.MonsterList.Clear;

    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -1;
    end;
    for i := 0 to Query.RecordCount - 1 do
    begin
      New(Monster);
      Monster.ItemList := TList.Create; //这里创建
      Monster.sName := Trim(Query.FieldByName('NAME').AsString);
      Monster.btRace := Query.FieldByName('Race').AsInteger;
      Monster.btRaceImg := Query.FieldByName('RaceImg').AsInteger;
      Monster.wAppr := Query.FieldByName('Appr').AsInteger;
      Monster.wLevel := Query.FieldByName('Lvl').AsInteger;
      Monster.btLifeAttrib := Query.FieldByName('Undead').AsInteger;
      Monster.wCoolEye := Query.FieldByName('CoolEye').AsInteger;
      Monster.dwExp := Query.FieldByName('Exp').AsInteger;

      //城门或城墙的状态跟HP值有关，如果HP异常，将导致城墙显示不了
      if Monster.btRace in [110, 111] then
      begin //如果为城墙或城门由HP不加倍
        Monster.wHP := Query.FieldByName('HP').AsInteger;
      end
      else
      begin
        Monster.wHP := ROUND(Query.FieldByName('HP').AsInteger * (g_Config.nMonsterPowerRate / 10));
      end;

      Monster.wMP := ROUND(Query.FieldByName('MP').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wAC := ROUND(Query.FieldByName('AC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMAC := ROUND(Query.FieldByName('MAC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wDC := ROUND(Query.FieldByName('DC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMaxDC := ROUND(Query.FieldByName('DCMAX').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMC := ROUND(Query.FieldByName('MC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSC := ROUND(Query.FieldByName('SC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSpeed := Query.FieldByName('SPEED').AsInteger;
      Monster.wHitPoint := Query.FieldByName('HIT').AsInteger;
      Monster.wWalkSpeed := _MAX(200, Query.FieldByName('WALK_SPD').AsInteger);
      Monster.wWalkStep := _MAX(1, Query.FieldByName('WalkStep').AsInteger);
      Monster.wWalkWait := Query.FieldByName('WalkWait').AsInteger;
      Monster.wAttackSpeed := Query.FieldByName('ATTACK_SPD').AsInteger;

      if Monster.wWalkSpeed < 200 then
        Monster.wWalkSpeed := 200;
      if Monster.wAttackSpeed < 200 then
        Monster.wAttackSpeed := 200;
   //  Monster.ItemList:=nil;     这里泄露  上面的 Monster.ItemList     := TList.Create;    //这里创建
      LoadMonitems(Monster.sName, Monster.ItemList); //读取怪物暴物数据

      UserEngine.MonsterList.Add(Monster);
      Result := 1;
      Query.Next;
    end;
    Query.Close;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMonitems(MonName: string; var ItemList: TList): Integer; //00485ABC
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItem;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
begin
  Result := 0;
  s24 := g_Config.sEnvirDir + 'MonItems\' + MonName + '.txt';
  if FileExists(s24) then
  begin
    if ItemList <> nil then
    begin
      for I := 0 to Itemlist.Count - 1 do
      begin
        DisPose(pTMonItem(ItemList.Items[I]));
      end;
      ItemList.Clear;
    end; //00485B81
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(s24);
    for I := 0 to LoadList.Count - 1 do
    begin
      s28 := LoadList.Strings[I];
      if (s28 <> '') and (s28[1] <> ';') then
      begin
        s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
        n18 := Str_ToInt(s30, -1);
        s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
        n1C := Str_ToInt(s30, -1);
        s28 := GetValidStr3(s28, s30, [' ', #9]);
        if s30 <> '' then
        begin
          if s30[1] = '"' then
            ArrestStringEx(s30, '"', '"', s30);
        end;
        s2C := s30;
        s28 := GetValidStr3(s28, s30, [' ', #9]);
        n20 := Str_ToInt(s30, 1);
        if (n18 > 0) and (n1C > 0) and (s2C <> '') then
        begin
          if ItemList = nil then
            ItemList := TList.Create;
          New(MonItem);
          MonItem.n00 := n18 - 1;
          MonItem.n04 := n1C;
          MonItem.sMonName := s2C;
          MonItem.n18 := n20;
          ItemList.Add(MonItem);
          Inc(Result);
        end;
      end;
    end;
    LoadList.Free;
  end;

end;
//00488178

function TFrmDB.LoadNpcs(): Integer;
var
  sFileName, s18,  s20, s24, s28, s2C, s30, s34, s38: string;
  LoadList: TStringList;
  NPC: TNormNpc;
  i: Integer;
begin
  sFileName := g_Config.sEnvirDir + 'Npcs.txt';
  if FileExists(sFileName) then
  begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for i := 0 to LoadList.Count - 1 do
    begin
      s18 := Trim(LoadList.Strings[i]);
      if (s18 <> '') and (s18[1] <> ';') then
      begin
        s18 := GetValidStrCap(s18, s20, [' ', #9]);
        if (s20 <> '') and (s20[1] = '"') then
          ArrestStringEx(s20, '"', '"', s20);

        s18 := GetValidStr3(s18, s24, [' ', #9]);
        s18 := GetValidStr3(s18, s28, [' ', #9]);
        s18 := GetValidStr3(s18, s2C, [' ', #9]);
        s18 := GetValidStr3(s18, s30, [' ', #9]);
        s18 := GetValidStr3(s18, s34, [' ', #9]);
        s18 := GetValidStr3(s18, s38, [' ', #9]);
        if (s20 <> '') and (s28 <> '') and (s38 <> '') then
        begin
          NPC := nil;
          case Str_ToInt(s24, 0) of
            0: NPC := TMerchant.Create;
            1: NPC := TGuildOfficial.Create;
            2: NPC := TCastleOfficial.Create;
          end;
          if NPC <> nil then
          begin
            NPC.m_sMapName := s28;
            NPC.m_nCurrX := Str_ToInt(s2C, 0);
            NPC.m_nCurrY := Str_ToInt(s30, 0);
            NPC.m_sCharName := s20;
            NPC.m_nFlag := Str_ToInt(s34, 0);
            NPC.m_wAppr := Str_ToInt(s38, 0);
            UserEngine.QuestNPCList.Add(NPC); //0048847D
          end;
        end;
      end;
    end;
    LoadList.Free;
  end;
  Result := 1;

end;
//00489840

function TFrmDB.LoadQuestDiary(): Integer;
  function sub_48978C(nIndex: Integer): string;
  begin
    if nIndex >= 1000 then
    begin
      Result := IntToStr(nIndex);
      exit;
    end;
    if nIndex >= 100 then
    begin
      Result := IntToStr(nIndex) + '0';
      exit;
    end;
    Result := IntToStr(nIndex) + '00';
  end;
var
  i, ii: Integer;
  QDDinfoList: TList;
  QDDinfo: pTQDDinfo;
  s14, s18, s1C, s20: string;
  bo2D: Boolean;
  nC: Integer;
  LoadList: TStringList;
begin
  Result := 1;
  for i := 0 to QuestDiaryList.Count - 1 do
  begin
    QDDinfoList := QuestDiaryList.Items[i];
    for ii := 0 to QDDinfoList.Count - 1 do
    begin
      QDDinfo := QDDinfoList.Items[ii];
      QDDinfo.sList.Free;
      Dispose(QDDinfo);
    end;
    QDDinfoList.Free;
  end;
  QuestDiaryList.Clear;
  bo2D := False;
  nC := 1;
  while (True) do
  begin
    QDDinfoList := nil;
    s14 := 'QuestDiary\' + sub_48978C(nC) + '.txt';
    if FileExists(s14) then
    begin
      s18 := '';
      QDDinfo := nil;
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(s14);
      for i := 0 to LoadList.Count - 1 do
      begin
        s1C := LoadList.Strings[i];
        if (s1C <> '') and (s1C[1] <> ';') then
        begin
          if (s1C[1] = '[') and (length(s1C) > 2) then
          begin
            if s18 = '' then
            begin
              ArrestStringEx(s1C, '[', ']', s18);
              QDDinfoList := TList.Create;
              New(QDDinfo);
              QDDinfo.n00 := nC;
              QDDinfo.s04 := s18;
              QDDinfo.sList := TStringList.Create;
              QDDinfoList.Add(QDDinfo);
              bo2D := True;
            end
            else
            begin
              if s1C[1] <> '@' then
              begin
                s1C := GetValidStr3(s1C, s20, [' ', #9]);
                ArrestStringEx(s20, '[', ']', s20);
                New(QDDinfo);
                QDDinfo.n00 := Str_ToInt(s20, 0);
                QDDinfo.s04 := s1C;
                QDDinfo.sList := TStringList.Create;
                QDDinfoList.Add(QDDinfo);
                bo2D := True;
              end
              else
                bo2D := False;
            end;
          end
          else
          begin //00489AFD
            if bo2D then
              QDDinfo.sList.Add(s1C);
          end;
        end; //00489B11
      end;
      LoadList.Free;
    end; //00489B25
    if QDDinfoList <> nil then
      QuestDiaryList.Add(QDDinfoList);
    //  else QuestDiaryList.Add(nil);   //hint 导致抱错。//hint
    Inc(nC);
    if nC >= 105 then
      break;
  end;

end;
//00488EF0

function TFrmDB.LoadStartPoint(): Integer;
var
  sFileName, tStr, s18, s1C, s20: string;
  LoadList: TStringList;
  i: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'StartPoint.txt';
  if FileExists(sFileName) then
  begin
    try
      g_StartPointList.Lock;
      g_StartPointList.Clear;
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      for i := 0 to LoadList.Count - 1 do
      begin
        tStr := Trim(LoadList.Strings[i]);
        if (tStr <> '') and (tStr[1] <> ';') then
        begin
          tStr := GetValidStr3(tStr, s18, [' ', #9]);
          tStr := GetValidStr3(tStr, s1C, [' ', #9]);
          tStr := GetValidStr3(tStr, s20, [' ', #9]);
       //   tStr:=GetValidStr3(tStr, s24, [' ', #9]);

          if (s18 <> '') and (s1C <> '') and (s20 <> '') then
          begin

            g_StartPointList.AddObject(s18, TObject(MakeLong(Str_ToInt(s1C, 0), Str_ToInt(s20, 0))));
            Result := 1;
          end;
        end;
      end;
      LoadList.Free;
    finally
      g_StartPointList.UnLock;
    end;
  end;
end;
//00489240

function TFrmDB.LoadUnbindList(): Integer;
var
  sFileName, tStr, sData, s20: string;

  LoadList: TStringList;
  i: Integer;
  n10: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'UnbindList.txt';
  if FileExists(sFileName) then
  begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for i := 0 to LoadList.Count - 1 do
    begin
      tStr := LoadList.Strings[i];
      if (tStr <> '') and (tStr[1] <> ';') then
      begin
          //New(tUnbind);
        tStr := GetValidStr3(tStr, sData, [' ', #9]);
        tStr := GetValidStrCap(tStr, s20, [' ', #9]);
        if (s20 <> '') and (s20[1] = '"') then
          ArrestStringEx(s20, '"', '"', s20);

        n10 := Str_ToInt(sData, 0);
        if n10 > 0 then
          g_UnbindList.AddObject(s20, TObject(n10))
        else
        begin
          Result := -i; //需要取负数
          break;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;

function TFrmDB.LoadbindList(): Integer;
var
  sFileName, tStr, sData, s20: string;

  LoadList: TStringList;
  i: Integer;
  n10: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'bindList.txt';
  if FileExists(sFileName) then
  begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for i := 0 to LoadList.Count - 1 do
    begin
      tStr := LoadList.Strings[i];
      if (tStr <> '') and (tStr[1] <> ';') then
      begin
          //New(tUnbind);
        tStr := GetValidStr3(tStr, sData, [' ', #9]);
        tStr := GetValidStrCap(tStr, s20, [' ', #9]);
        if (s20 <> '') and (s20[1] = '"') then
          ArrestStringEx(s20, '"', '"', s20);

        n10 := Str_ToInt(sData, 0);
        if n10 > 0 then
          g_bindList.AddObject(s20, TObject(n10))
        else
        begin
          Result := -i; //需要取负数
          break;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;


function TFrmDB.LoadEvilMonappr: Integer;
var
  i,Index: Integer;
  sMagic : String;
  sMagicName : String;
  pEvilMonAppr: pTEvilMonAppr;
resourcestring
  sSQLString = 'select * from Evil';
begin
  Result := -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try

    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -2;
    end;
    for i := 0 to Query.RecordCount - 1 do
    begin
      New(pEvilMonAppr);
      pEvilMonAppr.nAppr:=Query.FieldByName('Appr').AsInteger;
      pEvilMonAppr.nJob:=Query.FieldByName('Job').AsInteger;
      pEvilMonAppr.nSex:=Query.FieldByName('Sex').AsInteger;
      pEvilMonAppr.nhair:=Query.FieldByName('Hair').AsInteger;
      pEvilMonAppr.nRealm:=Query.FieldByName('ambit').AsInteger;
      pEvilMonAppr.nWings:=Query.FieldByName('Wings').AsInteger;
      pEvilMonAppr.sUserItem[0]:=Query.FieldByName('Dress').AsString;
      pEvilMonAppr.sUserItem[1]:=Query.FieldByName('Weapon').AsString;
      pEvilMonAppr.sUserItem[2]:=Query.FieldByName('Light').AsString;
      pEvilMonAppr.sUserItem[3]:=Query.FieldByName('NeckLace').AsString;
      pEvilMonAppr.sUserItem[4]:=Query.FieldByName('HelMet').AsString;
      pEvilMonAppr.sUserItem[5]:=Query.FieldByName('ArmRingL').AsString;
      pEvilMonAppr.sUserItem[6]:=Query.FieldByName('ArmRingR').AsString;
      pEvilMonAppr.sUserItem[7]:=Query.FieldByName('RingL').AsString;
      pEvilMonAppr.sUserItem[8]:=Query.FieldByName('RingR').AsString;
      pEvilMonAppr.sUserItem[U_BOOTS]:=Query.FieldByName('Boots').AsString;
      pEvilMonAppr.sUserItem[U_BELT]:=Query.FieldByName('Belt').AsString;
      pEvilMonAppr.sUserItem[U_BUJUK]:=Query.FieldByName('Charm').AsString;
      pEvilMonAppr.sUserItem[U_CHARM]:=Query.FieldByName('abujuk').AsString;
      sMagic:=Query.FieldByName('Magic').AsString;
      sMagic := GetValidStrCap(sMagic, sMagicName, [',', ' ', #9]);
      index:=0;
      while(sMagicName<>'')and(Index<20) do
      begin
         pEvilMonAppr.sMagic[Index]:=sMagicName;
         sMagic := GetValidStrCap(sMagic, sMagicName, [',', ' ', #9]);
         Inc(Index);
      end;
      g_EvilApprList.Add(pEvilMonAppr);
      Result := 1;
      Query.Next;
    end;
    Query.Close;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadNpcScript(NPC: TNormNpc; sPatch,
  sScritpName: string): Integer; //0048C4D8
begin
  if sPatch = '' then
    sPatch := sNpc_def;
  Result := LoadScriptFile(NPC, sPatch, sScritpName, False);
end;

function TFrmDB.LoadPetSellInfo: Integer;
var
  nSize    : Integer;
  sFileName  : string;
  LoadStream : TMemoryStream;
  PetSell    : TPetSellInfo;
  pPetSell   : pTPetSellInfo;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + '\Pet_SellInfo\UserPetSellInfo.dat';
  if FileExists(sFileName) then
  begin
     LoadStream:=TMemoryStream.Create;
     Result:=0;
     try
         LoadStream.LoadFromFile(sFileName);

         nsize:=LoadStream.Read(PetSell,SizeOf(TPetSellInfo));
         while nSize=SizeOf(TPetSellInfo) do
         begin
           New(pPetSell);
           Inc(Result);
           pPetSell^:=PetSell;
           g_PetSellInfo.Add(pPetSell);
           nsize:=LoadStream.Read(PetSell,SizeOf(TPetSellInfo));
         end;
     finally
        LoadStream.Free;
     end;
  end;
end;

function TFrmDB.LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: string;
  boFlag: Boolean): Integer; //0048B684
var
  nQuestIdx, I, n1C, n20, n24, nItemType, nPriceRate: Integer;
  n6C, n70: Integer;
  sScritpFileName, s30, s34, s38, s3C, s40, s44, s48, s4C, s50: string;
 
  DefineList: TList;
  s54, s58, s5C, s74: string;
  DefineInfo: pTDefineInfo;
  bo8D: Boolean;
  Script: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  QuestConditionInfo: pTQuestConditionInfo;
  QuestActionInfo: pTQuestActionInfo;
  Goods: pTGoods;
  Merchant: TMerchant;
  PClientItem : PTClientItem;
  LoadList: TGStringList;
  function LoadCallScript(sFileName, sLabel: string; List: TStringList): Boolean; //00489BD4
  var
    I: Integer;
    LoadStrList: TStringList;
     bo1D: Boolean;
    s18: string;
  begin
    Result := False;
    if FileExists(sFileName) then
    begin
      LoadStrList := TGStringList.Create;
      LoadStrList.LoadFromFile(sFileName);
      DeCodeStringList(LoadStrList);
      sLabel := '[' + sLabel + ']';
      bo1D := False;
      for I := 0 to LoadStrList.Count - 1 do
      begin
        s18 := Trim(LoadStrList.Strings[i]);
        if s18 <> '' then
        begin
          if not bo1D then
          begin
            if (s18[1] = '[') and (CompareLStr(s18, sLabel,Length(sLabel)) ) then
            begin
              bo1D := True;
              List.Add(s18);
            end;
          end
          else
          begin //00489CBF
            if s18[1] <> '{' then
            begin
              if s18[1] = '}' then
              begin
               bo1D := False;
                Result := True;
                break;
              end
              else
              begin //00489CD9
                List.Add(s18);
              end;
            end;
          end;
        end; //00489CE4 if s18 <> '' then begin
      end; // for I := 0 to LoadStrList.Count - 1 do begin
      LoadStrList.Free;
    end;

  end;
  function LoadScriptcall(LoadList: TStringList): boolean; //0048B138
  var
    I: Integer;
    s14, s18, s1C, s20, s34: string;
  begin
    result := false;
    for I := 0 to LoadList.Count - 1 do
    begin
      s14 := Trim(LoadList.Strings[i]);
      if (s14 <> '') and (s14[1] = '#') and (CompareLStr(s14, '#CALL', length('#CALL'))) then
      begin
        s14 := ArrestStringEx(s14, '[', ']', s1C);
        s20 := Trim(s1C);
        s18 := Trim(s14);
        s34 := g_Config.sEnvirDir + 'QuestDiary\' + s20;
        if LoadCallScript(s34, s18, LoadList) then
        begin
          LoadList.Strings[i] := '#ACT';
          LoadList.Insert(i + 1, 'goto ' + s18);
          result := true;
        end
        else
        begin
          MainOutMessage('script error, load fail: ' + s20 + s18);

        end;
      end;
    end;
  end;
  function LoadScriptEcall(LoadList: TStringList): boolean; //0048B138
  var
    I: Integer;
    s14, s18, s1C, s20, s34: string;
  begin
    result := false;
    for I := 0 to LoadList.Count - 1 do
    begin
      s14 := Trim(LoadList.Strings[i]);
      if (s14 <> '') and (s14[1] = '#') and (CompareLStr(s14, '#ECALL', length('#ECALL'))) then
      begin
        s14 := ArrestStringEx(s14, '[', ']', s1C);
        s20 := Trim(s1C);
        s18 := Trim(s14);
        s34 := g_Config.sEnvirDir + 'QuestDiary\' + s20;
        if LoadCallScript(s34, s18, LoadList) then
        begin
          LoadList.Strings[i] := 'goto ' + s18;
         // LoadList.Insert(i + 1, 'goto ' + s18);
          result := true;
        end
        else
        begin
          MainOutMessage('script error, load fail: ' + s20 + s18);

        end;
      end;
    end;
  end;
  function LoadDefineInfo(LoadList: TStringList; List: TList): string; //0048B35C
  var
    I: Integer;
    s14, s28, s1C, s20, s24: string;
    DefineInfo: pTDefineInfo;
    LoadStrList: TStringList;
  begin
    for I := 0 to LoadList.Count - 1 do
    begin
      s14 := Trim(LoadList.Strings[i]);
      if (s14 <> '') and (s14[1] = '#') then
      begin
        if CompareLStr(s14, '#SETHOME', length('#SETHOME')) then
        begin
          Result := Trim(GetValidStr3(s14, s1C, [' ', #9]));
          LoadList.Strings[i] := '';
        end;
        if CompareLStr(s14, '#DEFINE', length('#DEFINE')) then
        begin
          s14 := (GetValidStr3(s14, s1C, [' ', #9]));
          s14 := (GetValidStr3(s14, s20, [' ', #9]));
          s14 := (GetValidStr3(s14, s24, [' ', #9]));
          New(DefineInfo);
          DefineInfo.sName := UpperCase(s20);
          DefineInfo.sText := s24;
          List.Add(DefineInfo);
          LoadList.Strings[i] := '';
        end; //0048B505
        if CompareLStr(s14, '#INCLUDE', length('#INCLUDE')) then
        begin
          s28 := Trim(GetValidStr3(s14, s1C, [' ', #9]));
          s28 := g_Config.sEnvirDir + 'Defines\' + s28;
          if FileExists(s28) then
          begin
            LoadStrList := TStringList.Create;
            LoadStrList.LoadFromFile(s28);
            Result := LoadDefineInfo(LoadStrList, List);
            LoadStrList.Free;
          end
          else
          begin
            MainOutMessage('script error, load fail: ' + s28);
          end;
          LoadList.Strings[i] := '';
        end;
      end;
    end;
  end;
  function MakeNewScript(): pTScript; //00489D74
  var
    ScriptInfo: pTScript;
  begin
    New(ScriptInfo);
    ScriptInfo.boQuest := False;
    FillChar(ScriptInfo.QuestInfo, SizeOf(TQuestInfo) * 10, #0);
    nQuestIdx := 0;
    ScriptInfo.RecordList := TList.Create;
    NPC.m_ScriptList.Add(ScriptInfo);
    Result := ScriptInfo;
  end;
  function QuestCondition(sText: string; QuestConditionInfo: pTQuestConditionInfo): Boolean; //00489DDC
  var
    sCmd, sParam1, sParam2, sParam3, sParam4, sParam5, sParam6: string;
    nCMDCode: Integer;
  label
    L001;
  begin
    Result := False;
    sText := GetValidStrCap(sText, sCmd, [' ', #9]);
    sText := GetValidStrCap(sText, sParam1, [' ', #9]);
    sText := GetValidStrCap(sText, sParam2, [' ', #9]);
    sText := GetValidStrCap(sText, sParam3, [' ', #9]);
    sText := GetValidStrCap(sText, sParam4, [' ', #9]);
    sText := GetValidStrCap(sText, sParam5, [' ', #9]);
    sText := GetValidStrCap(sText, sParam6, [' ', #9]);
    sCmd := UpperCase(sCmd);
    if Pos('.',sCmd)>0 then// 对象
    Begin
      sCmd:=GetValidStrCap(sCmd,sText,['.']);
      QuestConditionInfo.sBaseObject:=sText;
    End;

    if sCmd='' then exit;
    if sCmd[1]='!' then
    Begin
       QuestConditionInfo.boNot:=True ;
       Delete(sCmd ,1,1);
    End
    else
      QuestConditionInfo.boNot :=False;
    nCMDCode := 0;
    if sCmd = sCHECK then
    begin
      nCMDCode := nCHECK;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
      goto L001;
    end;
    if sCmd = sCHECKOPEN then
    begin
      nCMDCode := nCHECKOPEN;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
      goto L001;
    end;

    if sCmd = sCHECKUNIT then
    begin
      nCMDCode := nCHECKUNIT;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
      goto L001;
    end;
    if sCmd = sCHECKPKPOINT then
    begin
      nCMDCode := nCHECKPKPOINT;
      goto L001;
    end;
    if sCmd = sCHECKGOLD then
    begin
      nCMDCode := nCHECKGOLD;
      goto L001;
    end;
    if sCmd = sCHECKLEVEL then
    begin
      nCMDCode := nCHECKLEVEL;
      goto L001;
    end;
    if sCmd = sCHECKJOB then
    begin
      nCMDCode := nCHECKJOB;
      goto L001;
    end;
    if sCmd = sRANDOM then
    begin //00489FB2
      nCMDCode := nRANDOM;
      goto L001;
    end;
    if sCmd = sCHECKITEM then
    begin
      nCMDCode := nCHECKITEM;
      goto L001;
    end;
    if sCmd = sCHECKITEMx then
    begin
      nCMDCode := nCHECKITEMx;
      goto L001;
    end;

    if sCmd = scheckclb then
    begin
      nCMDCode := ncheckclb;
      goto L001;
    end;
    if sCmd = sCHECKBT then
    begin
      nCMDCode := nCHECKBT;
      goto L001;
    end;


    if sCmd = SCHECKONLINE then
    begin
      nCMDCode := nCHECKONLINE;
      goto L001;
    end;


    if sCmd = sGENDER then
    begin
      nCMDCode := nGENDER;
      goto L001;
    end;
    if sCmd = sCHECKBAGGAGE then
    begin
      nCMDCode := nCHECKBAGGAGE;
      goto L001;
    end;

    if sCmd = sCHECKNAMELIST then
    begin
      nCMDCode := nCHECKNAMELIST;
      goto L001;
    end;
    if sCmd = sCHECKVARLIST then
    begin
      nCMDCode := nCHECKVARLIST;
      goto L001;
    end;

    if sCmd = sSC_HASGUILD then
    begin
      nCMDCode := nSC_HASGUILD;
      goto L001;
    end;

    if sCmd = sSC_ISGUILDMASTER then
    begin
      nCMDCode := nSC_ISGUILDMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEMASTER then
    begin
      nCMDCode := nSC_CHECKCASTLEMASTER;
      goto L001;
    end;
    if sCmd = sSC_ISNEWHUMAN then
    begin
      nCMDCode := nSC_ISNEWHUMAN;
      goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERTYPE then
    begin
      nCMDCode := nSC_CHECKMEMBERTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERLEVEL then
    begin
      nCMDCode := nSC_CHECKMEMBERLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGOLD then
    begin
      nCMDCode := nSC_CHECKGAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEPOINT then
    begin
      nCMDCode := nSC_CHECKGAMEPOINT;
      goto L001;
    end;
    if sCmd = sCheckCollectPoint then
    begin
      nCMDCode := nCheckCollectPoint;
      goto L001;
    end;
    if sCmd = sCheckUserGap then
    begin
      nCMDCode := nCheckUserGap;
      goto L001;
    end;
    if sCmd = sCHECKJPPOINT then
    begin
      nCMDCode := nCHECKJPPOINT;
      goto L001;
    end;


    if sCmd = sCHECKYSPOINT then
    begin
      nCMDCode := nCHECKYSPOINT;
      goto L001;
    end;

    if sCmd = sTrue then
    begin
      nCMDCode := nTrue;
      goto L001;
    end;
    if sCmd = sCHECKITEMDARKPROPERTY then
    begin
      nCMDCode := nCHECKITEMDARKPROPERTY;
      goto L001;
    end;

    if sCmd = sCHECKUPGRADECOUNT then
    begin
      nCMDCode := nCHECKUPGRADECOUNT;
      goto L001;
    end;
    if sCmd = sISSHADOW then
    begin
      nCMDCode := nISSHADOW;
      goto L001;
    end;
    if sCmd = sCheckTaskStep then
    begin
      nCMDCode := nCheckTaskStep;
      goto L001;
    end;
    if sCmd = sCheckMapMonNameCount then
    begin
      nCMDCode := nCheckMapMonNameCount;
      goto L001;
    end;
    if sCmd = sCheckMapMonNameCountex then
    begin
      nCMDCode := nCheckMapMonNameCountex;
      goto L001;
    end;
    if sCmd = sCheckSignMap then
    begin
      nCMDCode := nCheckSignMap;
      goto L001;
    end;
    if sCmd = sHasTask then
    begin
      nCMDCode := nHasTask;
      goto L001;
    end;
    if sCmd = sPNEUMARELEASED then
    begin
      nCMDCode := nPNEUMARELEASED;
      goto L001;
    end;
    if sCmd = sCHECKGEMCOUNT then
    begin
      nCMDCode := nCHECKGEMCOUNT;
      goto L001;
    end;
    if sCmd = sCHECKPRENTICECOUNT then
    begin
      nCMDCode := nCHECKPRENTICECOUNT;
      goto L001;
    end;
    if sCmd = sISPNEUMA then
    begin
      nCMDCode := nISPNEUMA;
      goto L001;
    end;
    if sCmd = sIsInSafeZone then
    begin
      nCMDCode := nIsInSafeZone;
      goto L001;
    end;
    if sCmd = sCHECKISFRIEND then
    begin
      nCMDCode := nCHECKISFRIEND;
      goto L001;
    end;
    if sCmd = sCHECKMONPOS then
    begin
      nCMDCode := nCHECKMONPOS;
      goto L001;
    end;
    if sCmd = sCHECKITEMID then
    begin
      nCMDCode := nCHECKITEMID;
      goto L001;
    end;
    if sCmd = sCHECKITEMDURE then
    begin
      nCMDCode := nCHECKITEMDURE;
      goto L001;
    end;
    if sCmd = sCompareText then
    begin
      nCMDCode := nCompareText;
      goto L001;
    end;
    if (sCmd = sPosEx)or(sCmd='POSEX') then
    begin
      nCMDCode := nPosEx;
      goto L001;
    end;
    if (sCmd = scPos) then
    begin
      nCMDCode := nPos;
      goto L001;
    end;
    if sCmd = sCheckGuildExp then
    begin
      nCMDCode := nCheckGuildExp;
      goto L001;
    end;
    if sCmd = sCheckGuildGrade then
    begin
      nCMDCode := nCheckGuildGrade;
      goto L001;
    end;
    if sCmd = sCheckGuildMemberCount then
    begin
      nCMDCode := nCheckGuildMemberCount;
      goto L001;
    end;
    if sCmd = sCheckGuildMemberMaxLimit then
    begin
      nCMDCode := nCheckGuildMemberMaxLimit;
      goto L001;
    end;
    if sCmd = sCHECKSKILL then
    begin
      nCMDCode := nCHECKSKILL;
      goto L001;
    end;
    if sCmd = sSC_CHECKYEAR then
    begin
      nCMDCode := nSC_CHECKYEAR;
      goto L001;
    end;
    if sCmd = sSC_CHECKMONTH then
    begin
      nCMDCode := nSC_CHECKMONTH;
      goto L001;
    end;
    if sCmd = sSC_CHECKDAY then
    begin
      nCMDCode := nSC_CHECKDAY;
      goto L001;
    end;
    if sCmd = sCHECKMAPNAME then
    begin
      nCMDCode := nCHECKMAPNAME;
      goto L001;
    end;


    if sCmd = sSC_CHECKNAMELISTPOSITION then
    begin
      nCMDCode := nSC_CHECKNAMELISTPOSITION;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDLIST then
    begin
      nCMDCode := nSC_CHECKGUILDLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKRENEWLEVEL then
    begin
      nCMDCode := nSC_CHECKRENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVELEVEL then
    begin
      nCMDCode := nSC_CHECKSLAVELEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVENAME then
    begin
      nCMDCode := nSC_CHECKSLAVENAME;
      goto L001;
    end;
    if sCmd = sSC_CHECKCREDITPOINT then
    begin
      nCMDCode := nSC_CHECKCREDITPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKOFGUILD then
    begin
      nCMDCode := nSC_CHECKOFGUILD;
      goto L001;
    end;
    if sCmd = sSC_CHECKPAYMENT then
    begin
      nCMDCode := nSC_CHECKPAYMENT;
      goto L001;
    end;

    if sCmd = sSC_CHECKUSEITEM then
    begin
      nCMDCode := nSC_CHECKUSEITEM;
      goto L001;
    end;
    if sCmd = sSC_CHECKBAGSIZE then
    begin
      nCMDCode := nSC_CHECKBAGSIZE;
      goto L001;
    end;
    if sCmd = sSC_CHECKLISTCOUNT then
    begin
      nCMDCode := nSC_CHECKLISTCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKDC then
    begin
      nCMDCode := nSC_CHECKDC;
      goto L001;
    end;
    if sCmd = sSC_CHECKMC then
    begin
      nCMDCode := nSC_CHECKMC;
      goto L001;
    end;
    if sCmd = sSC_CHECKSC then
    begin
      nCMDCode := nSC_CHECKSC;
      goto L001;
    end;
    if sCmd = sSC_CHECKHP then
    begin
      nCMDCode := nSC_CHECKHP;
      goto L001;
    end;
    if sCmd = sSC_CHECKMP then
    begin
      nCMDCode := nSC_CHECKMP;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMTYPE then
    begin
      nCMDCode := nSC_CHECKITEMTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKEXP then
    begin
      nCMDCode := nSC_CHECKEXP;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEGOLD then
    begin
      nCMDCode := nSC_CHECKCASTLEGOLD;
      goto L001;
    end;
    if sCmd = sSC_PASSWORDERRORCOUNT then
    begin
      nCMDCode := nSC_PASSWORDERRORCOUNT;
      goto L001;
    end;
    if sCmd = sSC_ISLOCKPASSWORD then
    begin
      nCMDCode := nSC_ISLOCKPASSWORD;
      goto L001;
    end;
    if sCmd = sSC_ISLOCKSTORAGE then
    begin
      nCMDCode := nSC_ISLOCKSTORAGE;
      goto L001;
    end;
    if sCmd = sSC_CHECKBUILDPOINT then
    begin
      nCMDCode := nSC_CHECKBUILDPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKAURAEPOINT then
    begin
      nCMDCode := nSC_CHECKAURAEPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKSTABILITYPOINT then
    begin
      nCMDCode := nSC_CHECKSTABILITYPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKFLOURISHPOINT then
    begin
      nCMDCode := nSC_CHECKFLOURISHPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTRIBUTION then
    begin
      nCMDCode := nSC_CHECKCONTRIBUTION;
      goto L001;
    end;
    if sCmd = sSC_CHECKRANGEMONCOUNT then
    begin
      nCMDCode := nSC_CHECKRANGEMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMADDVALUE then
    begin
      nCMDCode := nSC_CHECKITEMADDVALUE;
      goto L001;
    end;
{$IF SoftVersion = VERENT}
    if sCmd = sSC_CHECKINMAPRANGE then
    begin
      nCMDCode := nSC_CHECKINMAPRANGE;
      goto L001;
    end;
{$IFEND}
    if sCmd = sSC_CASTLECHANGEDAY then
    begin
      nCMDCode := nSC_CASTLECHANGEDAY;
      goto L001;
    end;
    if sCmd = sSC_CASTLEWARDAY then
    begin
      nCMDCode := nSC_CASTLEWARDAY;
      goto L001;
    end;
    if sCmd = sSC_ONLINELONGMIN then
    begin
      nCMDCode := nSC_ONLINELONGMIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDCHIEFITEMCOUNT then
    begin
      nCMDCode := nSC_CHECKGUILDCHIEFITEMCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMEDATELIST then
    begin
      nCMDCode := nSC_CHECKNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPHUMANCOUNT then
    begin
      nCMDCode := nSC_CHECKMAPHUMANCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPMONCOUNT then
    begin
      nCMDCode := nSC_CHECKMAPMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKVAR then
    begin
      nCMDCode := nSC_CHECKVAR;
      goto L001;
    end;
    if sCmd = sSC_CHECKSERVERNAME then
    begin
      nCMDCode := nSC_CHECKSERVERNAME;
      goto L001;
    end;

    if sCmd = sSC_ISATTACKGUILD then
    begin
      nCMDCode := nSC_ISATTACKGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISDEFENSEGUILD then
    begin
      nCMDCode := nSC_ISDEFENSEGUILD;
      goto L001;
    end;

    if sCmd = sSC_ISATTACKALLYGUILD then
    begin
      nCMDCode := nSC_ISATTACKALLYGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISDEFENSEALLYGUILD then
    begin
      nCMDCode := nSC_ISDEFENSEALLYGUILD;
      goto L001;
    end;

    if sCmd = sSC_ISCASTLEGUILD then
    begin
      nCMDCode := nSC_ISCASTLEGUILD;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEDOOR then
    begin
      nCMDCode := nSC_CHECKCASTLEDOOR;
      goto L001;
    end;

    if sCmd = sSC_ISSYSOP then
    begin
      nCMDCode := nSC_ISSYSOP;
      goto L001;
    end;
    if sCmd = sSC_ISADMIN then
    begin
      nCMDCode := nSC_ISADMIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKGROUPCOUNT then
    begin
      nCMDCode := nSC_CHECKGROUPCOUNT;
      goto L001;
    end;

    if sCmd = sCHECKACCOUNTLIST then
    begin
      nCMDCode := nCHECKACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sCHECKIPLIST then
    begin
      nCMDCode := nCHECKIPLIST;
      goto L001;
    end;
    if sCmd = sCHECKBBCOUNT then
    begin
      nCMDCode := nCHECKBBCOUNT;
      goto L001;
    end;
    if sCmd = sCHECKCREDITPOINT then
    begin
      nCMDCode := nCHECKCREDITPOINT;
      goto L001;
    end;

    if sCmd = sDAYTIME then
    begin
      nCMDCode := nDAYTIME;
      goto L001;
    end;
    if sCmd = sCHECKITEMW then
    begin
      nCMDCode := nCHECKITEMW;
      goto L001;
    end;
    if sCmd = sISTAKEITEM then
    begin
      nCMDCode := nISTAKEITEM;
      goto L001;
    end;
    if sCmd = sCHECKDURA then
    begin
      nCMDCode := nCHECKDURA;
      goto L001;
    end;
    if sCmd = sCHECKDURAEVA then
    begin
      nCMDCode := nCHECKDURAEVA;
      goto L001;
    end;
    if sCmd = sDAYOFWEEK then
    begin
      nCMDCode := nDAYOFWEEK;
      goto L001;
    end;
    if sCmd = sHOUR then
    begin
      nCMDCode := nHOUR;
      goto L001;
    end;
    if sCmd = sMIN then
    begin
      nCMDCode := nMIN;
      goto L001;
    end;
    if sCmd = sCHECKLUCKYPOINT then
    begin
      nCMDCode := nCHECKLUCKYPOINT;
      goto L001;
    end;
    if sCmd = sCHECKMONMAP then
    begin
      nCMDCode := nCHECKMONMAP;
      goto L001;
    end;
    if sCmd = sCHECKMON then
    begin
      nCMDCode := nCHECKMON;
      goto L001;
    end;

    if sCmd = sCHECKMONAREA then
    begin
      nCMDCode := nCHECKMONAREA;
      goto L001;
    end;
    if sCmd = sCHECKHUM then
    begin
      nCMDCode := nCHECKHUM;
      goto L001;
    end;
    if sCmd = sEQUAL then
    begin
      nCMDCode := nEQUAL;
      goto L001;
    end;

    if sCmd = sLARGE then
    begin
      nCMDCode := nLARGE;
      goto L001;
    end;

    if sCmd = sSMALL then
    begin
      nCMDCode := nSMALL;
      goto L001;
    end;

    if sCmd = sSC_CHECKPOSEDIR then
    begin
      nCMDCode := nSC_CHECKPOSEDIR;
      goto L001;
    end;

    if sCmd = sSC_CHECKPOSELEVEL then
    begin
      nCMDCode := nSC_CHECKPOSELEVEL;
      goto L001;
    end;

    if sCmd = sSC_CHECKPOSEGENDER then
    begin
      nCMDCode := nSC_CHECKPOSEGENDER;
      goto L001;
    end;

    if sCmd = sSC_CHECKLEVELEX then
    begin
      nCMDCode := nSC_CHECKLEVELEX;
      goto L001;
    end;

    if sCmd = sSC_CHECKBONUSPOINT then
    begin
      nCMDCode := nSC_CHECKBONUSPOINT;
      goto L001;
    end;

    if sCmd = sSC_CHECKMARRY then
    begin
      nCMDCode := nSC_CHECKMARRY;
      goto L001;
    end;
    if sCmd = sCHECKGUILDMAXMEMBER then
    begin
      nCMDCode := nCHECKGUILDMAXMEMBER;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMARRY then
    begin
      nCMDCode := nSC_CHECKPOSEMARRY;
      goto L001;
    end;
    if sCmd = sSC_CHECKMARRYCOUNT then
    begin
      nCMDCode := nSC_CHECKMARRYCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMASTER then
    begin
      nCMDCode := nSC_CHECKMASTER;
      goto L001;
    end;

    if sCmd = sCheckys then
    begin
      nCMDCode := nCheckys;
      goto L001;
    end;

    if sCmd = sSC_HAVEMASTER then
    begin
      nCMDCode := nSC_HAVEMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMASTER then
    begin
      nCMDCode := nSC_CHECKPOSEMASTER;
      goto L001;
    end;
    if sCmd = sSC_POSEHAVEMASTER then
    begin
      nCMDCode := nSC_POSEHAVEMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKISMASTER then
    begin
      nCMDCode := nSC_CHECKISMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEISMASTER then
    begin
      nCMDCode := nSC_CHECKPOSEISMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMEIPLIST then
    begin
      nCMDCode := nSC_CHECKNAMEIPLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKACCOUNTIPLIST then
    begin
      nCMDCode := nSC_CHECKACCOUNTIPLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVECOUNT then
    begin
      nCMDCode := nSC_CHECKSLAVECOUNT;
      goto L001;
    end;

    L001:
    if nCMDCode > 0 then
    begin
      QuestConditionInfo.nCmdCode := nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then
      begin
        ArrestStringEx(sParam1, '"', '"', sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then
      begin
        ArrestStringEx(sParam2, '"', '"', sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then
      begin
        ArrestStringEx(sParam3, '"', '"', sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then
      begin
        ArrestStringEx(sParam4, '"', '"', sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then
      begin
        ArrestStringEx(sParam5, '"', '"', sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then
      begin
        ArrestStringEx(sParam6, '"', '"', sParam6);
      end;
      QuestConditionInfo.sParam1 := sParam1;
      QuestConditionInfo.sParam2 := sParam2;
      QuestConditionInfo.sParam3 := sParam3;
      QuestConditionInfo.sParam4 := sParam4;
      QuestConditionInfo.sParam5 := sParam5;
      QuestConditionInfo.sParam6 := sParam6;
      if IsStringNumber(sParam1) then
        QuestConditionInfo.nParam1 := Str_ToInt(sParam1, 0);
      if IsStringNumber(sParam2) then
        QuestConditionInfo.nParam2 := Str_ToInt(sParam2, 0);
      if IsStringNumber(sParam3) then
        QuestConditionInfo.nParam3 := Str_ToInt(sParam3, 0);
      if IsStringNumber(sParam4) then
        QuestConditionInfo.nParam4 := Str_ToInt(sParam4, 0);
      if IsStringNumber(sParam5) then
        QuestConditionInfo.nParam5 := Str_ToInt(sParam5, 0);
      if IsStringNumber(sParam6) then
        QuestConditionInfo.nParam6 := Str_ToInt(sParam6, 0);
      Result := True;
    end;

  end;
  function QuestAction(sText: string; QuestActionInfo: pTQuestActionInfo): Boolean; //0048A640
  var
    sCmd, sParam1, sParam2, sParam3, sParam4, sParam5, sParam6: string;
    nCMDCode: Integer;
  label
    L001;
  begin
    Result := False;
    sText := GetValidStrCap(sText, sCmd, [' ', #9]);
    sText := GetValidStrCap(sText, sParam1, [' ', #9]);
    sText := GetValidStrCap(sText, sParam2, [' ', #9]);
    sText := GetValidStrCap(sText, sParam3, [' ', #9]);
    sText := GetValidStrCap(sText, sParam4, [' ', #9]);
    sText := GetValidStrCap(sText, sParam5, [' ', #9]);
    sText := GetValidStrCap(sText, sParam6, [' ', #9]);
    sCmd := UpperCase(sCmd);
    nCmdCode := 0;

    if Pos('.',sCmd)>0 then// 对象
    Begin
      sCmd:=GetValidStrCap(sCmd,sText,['.']);
      QuestActionInfo.sBaseObject:=sText;
    End;

    if sCmd = sSET then
    begin
      nCMDCode := nSET;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
    end;

    if sCmd = sRESET then
    begin
      nCMDCode := nRESET;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
    end;
    if sCmd = sSETOPEN then
    begin
      nCMDCode := nSETOPEN;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
    end;
    if sCmd = sSETUNIT then
    begin
      nCMDCode := nSETUNIT;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
    end;
    if sCmd = sRESETUNIT then
    begin
      nCMDCode := nRESETUNIT;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then
        nCMDCode := 0;
      if not IsStringNumber(sParam2) then
        nCMDCode := 0;
    end;
    if sCmd = sTAKE then
    begin
      nCMDCode := nTAKE;
      goto L001;
    end;
    if sCmd = sTAKEM then
    begin
      nCMDCode := nTAKEM;
      goto L001;
    end;
    if sCmd = sStartTimer then
    begin
      nCMDCode := nStartTimer;
      goto L001;
    end;
    if sCmd = sStopTimer then
    begin
      nCMDCode := nStopTimer;
      goto L001;
    end;
    if sCmd = sReadRandomStr then
    begin
      nCMDCode := nReadRandomStr;
      goto L001;
    end;
    if sCmd = sFillText then
    begin
      nCMDCode := nFillText;
      goto L001;
    end;
    if sCmd = sTAKEDUREITEM then
    begin
      nCMDCode := nTAKEDUREITEM;
      goto L001;
    end;
    if sCmd = sFormatStr then
    begin
      nCMDCode := nFormatStr;
      goto L001;
    end;
    if sCmd = sTrim then
    begin
      nCMDCode := nTrim;
      goto L001;
    end;
    if sCmd = sAddItemExp then
    begin
      nCMDCode := nAddItemExp;
      goto L001;
    end;
    if sCmd = sSC_GIVE then
    begin
      nCMDCode := nSC_GIVE;
      goto L001;
    end;
    if sCmd = soffline then
    begin
      nCMDCode := noffline;
      goto L001;
    end;

    if sCmd = sCLOSE then
    begin
      nCMDCode := nCLOSE;
      goto L001;
    end;
    if sCmd = sBREAK then
    begin
      nCMDCode := nBREAK;
      goto L001;
    end;
    if sCmd = sGOTO then
    begin
      nCMDCode := nGOTO;
      goto L001;
    end;
    if sCmd = sADDVARLIST then
    begin
      nCMDCode := nADDVARLIST;
      goto L001;
    end;
    if sCmd = sINSERTVARLIST then
    begin
      nCMDCode := nINSERTVARLIST;
      goto L001;
    end;
    if sCmd = sCHECKITEMBOXCF then
    begin
      nCMDCode := nCHECKITEMBOXCF;
      goto L001;
    end;
    if sCmd = sTAKEON then
    begin
      nCMDCode := nTAKEON;
      goto L001;
    end;
    if sCmd = sDropItemDown then
    begin
      nCMDCode := nDropItemDown;
      goto L001;
    end;
    if sCmd = sShowAdditionalInfo then
    begin
      nCMDCode := nShowAdditionalInfo;
      goto L001;
    end;
    if sCmd = sSETADDITIONALABIL then
    begin
      nCMDCode := nSETADDITIONALABIL;
      goto L001;
    end;
    if sCmd = sShowSoulDig then
    begin
      nCMDCode := nShowSoulDig;
      goto L001;
    end;
    if sCmd = sSwitchPneuma then
    begin
      nCMDCode := nSwitchPneuma;
      goto L001;
    end;
    if sCmd = sSENDBOXSL then
    begin
      nCMDCode := nSENDBOXSL;
      goto L001;
    end;
    if sCmd = sSETMAGICBOXSL then
    begin
      nCMDCode := nSETMAGICBOXSL;
      goto L001;
    end;
    if sCmd = sOPENBOXSL then
    begin
      nCMDCode := nOPENBOXSL;
      goto L001;
    end;
    if sCmd = sQUERYMSG then
    begin
      nCMDCode := nQUERYMSG;
      goto L001;
    end;
    if sCmd = sGoBackHome then
    begin
      nCMDCode := nGoBackHome;
      goto L001;
    end;
    if sCmd = sGETVALIDSTR then
    begin
      nCMDCode := nGETVALIDSTR;
      goto L001;
    end;
    if sCmd = sADDLXBH then
    begin
      nCMDCode := nADDLXBH;
      goto L001;
    end;
    if sCmd = sInsert then
    begin
      nCMDCode := nInsert;
      goto L001;
    end;
    if sCmd = sLXBHKQ then
    begin
      nCMDCode := nLXBHKQ;
      goto L001;
    end;
    if sCmd = sDELVARLIST then
    begin
      nCMDCode := nDELVARLIST;
      goto L001;
    end;

    if sCmd = sADDNAMELIST then
    begin
      nCMDCode := nADDNAMELIST;
      goto L001;
    end;


    if sCmd = sDELNAMELIST then
    begin
      nCMDCode := nDELNAMELIST;
      goto L001;
    end;
    if sCmd = sADDGUILDLIST then
    begin
      nCMDCode := nADDGUILDLIST;
      goto L001;
    end;
    if sCmd = sDELGUILDLIST then
    begin
      nCMDCode := nDELGUILDLIST;
      goto L001;
    end;
    if sCmd = sSC_LINEMSG then
    begin
      nCMDCode := nSC_LINEMSG;
      goto L001;
    end;

    if sCmd = sADDACCOUNTLIST then
    begin
      nCMDCode := nADDACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sDELACCOUNTLIST then
    begin
      nCMDCode := nDELACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sADDIPLIST then
    begin
      nCMDCode := nADDIPLIST;
      goto L001;
    end;
    if sCmd = sDELIPLIST then
    begin
      nCMDCode := nDELIPLIST;
      goto L001;
    end;
    if sCmd = sSENDMSG then
    begin
      nCMDCode := nSENDMSG;
      goto L001;
    end;
    if sCmd = sCHANGEMODE then
    begin
      nCMDCode := nCHANGEMODE;
      goto L001;
    end;
    if sCmd = sPKPOINT then
    begin
      nCMDCode := nPKPOINT;
      goto L001;
    end;
    if sCmd = sCHANGEXP then
    begin
      nCMDCode := nCHANGEXP;
      goto L001;
    end;
    if sCmd = sSC_RECALLMOB then
    begin
      nCMDCode := nSC_RECALLMOB;
      goto L001;
    end;
    if sCmd = sKICK then
    begin
      nCMDCode := nKICK;
      goto L001;
    end;
    if sCmd = sTAKEW then
    begin
      nCMDCode := nTAKEW;
      goto L001;
    end;
    if sCmd = sTIMERECALL then
    begin
      nCMDCode := nTIMERECALL;
      goto L001;
    end;
    if sCmd = sSC_PARAM1 then
    begin
      nCMDCode := nSC_PARAM1;
      goto L001;
    end;
    if sCmd = sSC_PARAM2 then
    begin
      nCMDCode := nSC_PARAM2;
      goto L001;
    end;
    if sCmd = sSC_PARAM3 then
    begin
      nCMDCode := nSC_PARAM3;
      goto L001;
    end;
    if sCmd = sSC_PARAM4 then
    begin
      nCMDCode := nSC_PARAM4;
      goto L001;
    end;
    if sCmd = sSC_EXEACTION then
    begin
      nCMDCode := nSC_EXEACTION;
      goto L001;
    end;

    if sCmd = sMAPMOVE then
    begin
      nCMDCode := nMAPMOVE;
      goto L001;
    end;
    if sCmd = sMAP then
    begin
      nCMDCode := nMAP;
      goto L001;
    end;
    if sCmd = sTAKECHECKITEM then
    begin
      nCMDCode := nTAKECHECKITEM;
      goto L001;
    end;
    if sCmd = sMONGEN then
    begin
      nCMDCode := nMONGEN;
      goto L001;
    end;
    if sCmd = sMONCLEAR then
    begin
      nCMDCode := nMONCLEAR;
      goto L001;
    end;
    if sCmd = sMOV then
    begin
      nCMDCode := nMOV;
      goto L001;
    end;
    if sCmd = sGetValue then
    begin
      nCMDCode := nGetValue;
      goto L001;
    end;
    if sCmd = sGetstring then
    begin
      nCMDCode := nGetstring;
      goto L001;
    end;

    if sCmd = sChangeArp then
    begin
      nCMDCode := nChangeArp;
      goto L001;
    end;

    if sCmd = sChangeweather then
    begin
      nCMDCode := nChangeweather;
      goto L001;
    end;
    if sCmd = sfireflower then
    begin
      nCMDCode := nfireflower;
      goto L001;
    end;
    if sCmd = smagicfont then
    begin
      nCMDCode := nmagicfont;
      goto L001;
    end;
    if sCmd = smagicfontcolor then
    begin
      nCMDCode := nmagicfontcolor;
      goto L001;
    end;
    if sCmd = smagiccolor then
    begin
      nCMDCode := nmagiccolor;
      goto L001;
    end;

    if sCmd = sChangeFlag then
    begin
      nCMDCode := nChangeFlag;
      goto L001;
    end;
    if sCmd = sINC then
    begin
      nCMDCode := nINC;
      goto L001;
    end;
    if sCmd = sDiv then
    begin
      nCMDCode := nDiv;
      goto L001;
    end;
    if sCmd = sMULT then
    begin
      nCMDCode := nMULT;
      goto L001;
    end;
    if sCmd = sPERCENT then
    begin
      nCMDCode := nPERCENT;
      goto L001;
    end;
    if sCmd = sDEC then
    begin
      nCMDCode := nDEC;
      goto L001;
    end;
    if sCmd = sSUM then
    begin
      nCMDCode := nSUM;
      goto L001;
    end;
    if sCmd = sBREAKTIMERECALL then
    begin
      nCMDCode := nBREAKTIMERECALL;
      goto L001;
    end;

    if sCmd = sMOVR then
    begin
      nCMDCode := nMOVR;
      goto L001;
    end;
    if sCmd = sEXCHANGEMAP then
    begin
      nCMDCode := nEXCHANGEMAP;
      goto L001;
    end;
    if sCmd = sRECALLMAP then
    begin
      nCMDCode := nRECALLMAP;
      goto L001;
    end;
    if sCmd = sADDBATCH then
    begin
      nCMDCode := nADDBATCH;
      goto L001;
    end;
    if sCmd = sBATCHDELAY then
    begin
      nCMDCode := nBATCHDELAY;
      goto L001;
    end;
    if sCmd = sBATCHMOVE then
    begin
      nCMDCode := nBATCHMOVE;
      goto L001;
    end;
    if sCmd = sPLAYDICE then
    begin
      nCMDCode := nPLAYDICE;
      goto L001;
    end;
    if sCmd = sGOQUEST then
    begin
      nCMDCode := nGOQUEST;
      goto L001;
    end;
    if sCmd = sENDQUEST then
    begin
      nCMDCode := nENDQUEST;
      goto L001;
    end;
    if sCmd = sSC_HAIRCOLOR then
    begin
      nCMDCode := nSC_HAIRCOLOR;
      goto L001;
    end;
    if sCmd = sSC_WEARCOLOR then
    begin
      nCMDCode := nSC_WEARCOLOR;
      goto L001;
    end;
    if sCmd = sSC_HAIRSTYLE then
    begin
      nCMDCode := nSC_HAIRSTYLE;
      goto L001;
    end;
    if sCmd = sSC_MONRECALL then
    begin
      nCMDCode := nSC_MONRECALL;
      goto L001;
    end;
    if sCmd = sSC_HORSECALL then
    begin
      nCMDCode := nSC_HORSECALL;
      goto L001;
    end;
    if sCmd = sSC_HAIRRNDCOL then
    begin
      nCMDCode := nSC_HAIRRNDCOL;
      goto L001;
    end;
//    if sCmd = sSC_KILLHORSE then
//    begin
//      nCMDCode := nSC_KILLHORSE;
//      goto L001;
//    end;
    if sCmd = sSC_RANDSETDAILYQUEST then
    begin
      nCMDCode := nSC_RANDSETDAILYQUEST;
      goto L001;
    end;


    if sCmd = sSC_CHANGELEVEL then
    begin
      nCMDCode := nSC_CHANGELEVEL;
      goto L001;
    end;
    if sCmd = sSC_MARRY then
    begin
      nCMDCode := nSC_MARRY;
      goto L001;
    end;
    if sCmd = sSC_UNMARRY then
    begin
      nCMDCode := nSC_UNMARRY;
      goto L001;
    end;
    if sCmd = sSC_GETMARRY then
    begin
      nCMDCode := nSC_GETMARRY;
      goto L001;
    end;
    if sCmd = sSC_GETMASTER then
    begin
      nCMDCode := nSC_GETMASTER;
      goto L001;
    end;
    if sCmd = sSC_CLEARSKILL then
    begin
      nCMDCode := nSC_CLEARSKILL;
      goto L001;
    end;
    if sCmd = sSC_DELNOJOBSKILL then
    begin
      nCMDCode := nSC_DELNOJOBSKILL;
      goto L001;
    end;
    if sCmd = sSC_DELSKILL then
    begin
      nCMDCode := nSC_DELSKILL;
      goto L001;
    end;
    if sCmd = sSC_ADDSKILL then
    begin
      nCMDCode := nSC_ADDSKILL;
      goto L001;
    end;

    if sCmd = sSC_ADDYSSKILL then
    begin
      nCMDCode := nSC_ADDYSSKILL;
      goto L001;
    end;
    if sCmd = sSC_SKILLLEVEL then
    begin
      nCMDCode := nSC_SKILLLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPKPOINT then
    begin
      nCMDCode := nSC_CHANGEPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEEXP then
    begin
      nCMDCode := nSC_CHANGEEXP;
      goto L001;
    end;
    if sCmd = sSC_CHANGEJOB then
    begin
      nCMDCode := nSC_CHANGEJOB;
      goto L001;
    end;
    if sCmd = sSC_MISSION then
    begin
      nCMDCode := nSC_MISSION;
      goto L001;
    end;
    if sCmd = sSC_MOBPLACE then
    begin
      nCMDCode := nSC_MOBPLACE;
      goto L001;
    end;
    if sCmd = sSC_MOBPLACEX then
    begin
      nCMDCode := nSC_MOBPLACEX;
      goto L001;
    end;
    if sCmd = sSC_SETMEMBERTYPE then
    begin
      nCMDCode := nSC_SETMEMBERTYPE;
      goto L001;
    end;
    if sCmd = sSC_SETMEMBERLEVEL then
    begin
      nCMDCode := nSC_SETMEMBERLEVEL;
      goto L001;
    end;
    if sCmd = sSC_GAMEGOLD then
    begin
      nCMDCode := nSC_GAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_GAMEPOINT then
    begin
      nCMDCode := nSC_GAMEPOINT;
      goto L001;
    end;
    if sCmd = sSC_CLEARITEMMAP then
    begin
      nCMDCode := nSC_CLEARITEMMAP;
      goto L001;
    end;
    if sCmd = SJPPOINT then
    begin
      nCMDCode := nJPPOINT;
      goto L001;
    end;

    if sCmd = SYSPOINT then
    begin
      nCMDCode := nYSPOINT;
      goto L001;
    end;

    if sCmd = SADDTASK then
    begin
      nCMDCode := nADDTASK;
      goto L001;
    end;
    if sCmd = sEndTask then
    begin
      nCMDCode := nEndTask;
      goto L001;
    end;

    if sCmd = sYSFENGHAO then
    begin
      nCMDCode := nYSFENGHAO;
      goto L001;
    end;
    if sCmd = sHasTask then
    begin
      nCMDCode := nHasTask;
      goto L001;
    end;

    if sCmd = sADDYQ then
    begin
      nCMDCode := nADDYQ;
      goto L001;
    end;
    if sCmd = sBOOSFS then
    begin
      nCMDCode := nBOOSFS;
      goto L001;
    end;
    if sCmd = sGameOfWoool then
    begin
      nCMDCode := nGameOfWoool;
      goto L001;
    end;
    if sCmd = sADDITEMDARKPROPERTY then
    begin
      nCMDCode := nADDITEMDARKPROPERTY;
      goto L001;
    end;

    if sCmd = sRefreshTask then
    begin
      nCMDCode := nRefreshTask;
      goto L001;
    end;
    if (sCmd = sADDITEMEVIL)or(sCmd='ADDEEVILTOITEM') then
    begin
      nCMDCode := nADDITEMEVIL;
      goto L001;
    end;
    if (sCmd = sShowSmeltBox) then
    begin
      nCMDCode := nShowSmeltBox;
      goto L001;
    end;
    if (sCmd = sRANDOMGIVEITEMS) then
    begin
      nCMDCode := nRANDOMGIVEITEMS;
      goto L001;
    end;
    if (sCmd = sDELCOMMENT) then
    begin
      nCMDCode := nDELCOMMENT;
      goto L001;
    end;
    if (sCmd = sReplaceText) then
    begin
      nCMDCode := nReplaceText;
      goto L001;
    end;

    if (sCmd = sDELLASTDROPITEM) then
    begin
      nCMDCode := nDELLASTDROPITEM;
      goto L001;
    end;
    if (sCmd = sSETOFFLINELABEL) then
    begin
      nCMDCode := nSETOFFLINELABEL;
      goto L001;
    end;

    if (sCmd = sSKYROCKET) then
    begin
      nCMDCode := nSKYROCKET;
      goto L001;
    end;
    if (sCmd = sRANDOMGIVE) then
    begin
      nCMDCode := nRANDOMGIVE;
      goto L001;
    end;










    if sCmd = sCLEARITEMEVIL then
    begin
      nCMDCode := nCLEARITEMEVIL;
      goto L001;
    end;
    if sCmd = sMOBEVIL then
    begin
      nCMDCode := nMOBEVIL;
      goto L001;
    end;
    if sCmd = sOPENBLESS then
    begin
      nCMDCode := nOPENBLESS;
      goto L001;
    end;
    if sCmd = sSendBlessItemList then
    begin
      nCMDCode := nSendBlessItemList;
      goto L001;
    end;
    if sCmd = sSetBlessPower then
    begin
      nCMDCode := nSetBlessPower;
      goto L001;
    end;
    if sCmd = sSC_STATUSRATE then
    begin
      nCMDCode := nSC_STATUSRATE;
      goto L001;
    end;
    if sCmd = sUPGRADECHECKITEMBOX then
    begin
      nCMDCode := nUPGRADECHECKITEMBOX;
      goto L001;
    end;
    if sCmd = sSetTimerA then
    begin
      nCMDCode := nSetTimerA;
      goto L001;
    end;
    if sCmd = sChangeFlagMode then
    begin
      nCMDCode := nChangeFlagMode;
      goto L001;
    end;
    if sCmd = sGUILDEXP then
    begin
      nCMDCode := nGUILDEXP;
      goto L001;
    end;
    if sCmd = sAddCastleWar then
    begin
      nCMDCode := nAddCastleWar;
      goto L001;
    end;
    if sCmd = sGetExp then
    begin
      nCMDCode := nGetExp;
      goto L001;
    end;
    if sCmd = sUPGRADEMONZSD then
    begin
      nCMDCode := nUPGRADEMONZSD;
      goto L001;
    end;
    if sCmd = sUPGRADEMONEXP then
    begin
      nCMDCode := nUPGRADEMONEXP;
      goto L001;
    end;
    if sCmd = sUPGRADEMONLEVEL then
    begin
      nCMDCode := nUPGRADEMONLEVEL;
      goto L001;
    end;

    if sCmd = sKillMonExpMultiple then
    begin
      nCMDCode := nKillMonExpMultiple;
      goto L001;
    end;
    if sCmd = sSETPETATTRIBUTE then
    begin
     nCMDCode := nSETPETATTRIBUTE;
      goto L001;
    end;
    if sCmd = sSETPETRATE then
    begin
     nCMDCode := nSETPETRATE;
      goto L001;
    end;
    if sCmd = sMobNpc then
    begin
      nCMDCode := nMobNpc;
      goto L001;
    end;
    if sCmd = sUPDATEMONSTONE then
    begin
      nCMDCode := nUPDATEMONSTONE;
      goto L001;
    end;
    if sCmd = sCLEARCASTLEWAR then
    begin
      nCMDCode := nCLEARCASTLEWAR;
      goto L001;
    end;
    if sCmd = sTAKESUPERBOXITEM then
    begin
      nCMDCode := nTAKESUPERBOXITEM;
      goto L001;
    end;
    if sCmd = sSETSUPERBOXRESULT then
    begin
      nCMDCode := nSETSUPERBOXRESULT;
      goto L001;
    end;
    if sCmd = sSETPETRANKNAME then
    begin
      nCMDCode := nSETPETRANKNAME;
      goto L001;
    end;
    if sCmd = sMESSAGEBOXA then
    begin
      nCMDCode := nMESSAGEBOXA;
      goto L001;
    end;
    if sCmd = sGIVEBOXITEM then
    begin
      nCMDCode := nGIVEBOXITEM;
      goto L001;
    end;

    if sCmd = sSETMAGICBOXITEM then
    begin
      nCMDCode := nSETMAGICBOXITEM;
      goto L001;
    end;
    if sCmd = sOPENMAGICBOX then
    begin
      nCMDCode := nOPENMAGICBOX;
      goto L001;
    end;
    if sCmd = sSETMAGICBOX then
    begin
      nCMDCode := nSETMAGICBOX;
      goto L001;
    end;
    if sCmd = sUPGRADESUPERITEMBOX then
    begin
      nCMDCode := nUPGRADESUPERITEMBOX;
      goto L001;
    end;
    if sCmd = sUPGRADEUSERITEM then
    begin
      nCMDCode := nUPGRADEUSERITEM;
      goto L001;
    end;
    if sCmd = sGoBackMap then
    begin
      nCMDCode := nGoBackMap;
      goto L001;
    end;
    if sCmd = sJoinGuild then
    begin
      nCMDCode :=nJoinGuild ;
      goto L001;
    end;
    if sCmd = sGuildMemberMaxLimit then
    begin
      nCMDCode :=nGuildMemberMaxLimit ;
      goto L001;
    end;

    if sCmd = sGUILDGRADE then
    begin
      nCMDCode :=nGUILDGRADE ;
      goto L001;
    end;
    if sCmd = sGUILDEXP then
    begin
      nCMDCode :=nGUILDEXP ;
      goto L001;
    end;
    if sCmd = sQUITGUILD then
    begin
      nCMDCode :=nQUITGUILD ;
      goto L001;
    end;
    if sCmd = sSETNPCNAME then
    begin
      nCMDCode := nSETNPCNAME;
      goto L001;
    end;

    if sCmd = sPLAYDEFENCE then
    begin
      nCMDCode := nPLAYDEFENCE;
      goto L001;
    end;
    if sCmd = sCHANGESKILLEXP then
    begin
      nCMDCode := nCHANGESKILLEXP;
      goto L001;
    end;
    if sCmd = sGiveb then
    begin
      nCMDCode := nGiveb;
      goto L001;
    end;
    if sCmd = sReCallTotem then
    begin
      nCMDCode := nReCallTotem;
      goto L001;
    end;
    if sCmd = sSETHONORSHAPE then
    begin
      nCMDCode := nSETHONORSHAPE;
      goto L001;
    end;
    if sCmd = sChangeEatItemDura then
    begin
      nCMDCode := nChangeEatItemDura;
      goto L001;
    end;
    if sCmd = sPLAYERCALL then
    begin
      nCMDCode := nPLAYERCALL;
      goto L001;
    end;
    if sCmd = sSETNPCAPPR then
    begin
      nCMDCode := nSETNPCAPPR;
      goto L001;
    end;
    if sCmd = sUPGRADEUSERITEMEX then
    begin
      nCMDCode := nUPGRADEUSERITEMEX;
      goto L001;
    end;
    if sCmd = sCollectPoint then
    begin
      nCMDCode := nCollectPoint;
      goto L001;
    end;
    if sCmd = sGROUPMOVE then
    begin
      nCMDCode := nGROUPMOVE;
      goto L001;
    end;


    if sCmd = sTAKEB then
    begin
      nCMDCode := nTAKEB;
      goto L001;
    end;

    if sCmd = sUpdateTask then
    begin
      nCMDCode := nUpdateTask;
      goto L001;
    end;


    if sCmd = sSC_PKZONE then
    begin
      nCMDCode := nSC_PKZONE;
      goto L001;
    end;
    if sCmd = sSC_RESTBONUSPOINT then
    begin
      nCMDCode := nSC_RESTBONUSPOINT;
      goto L001;
    end;

    if (sCmd = sSC_USEBONUSPOINT)or(sCmd='BONUSABIL') then
    begin
      nCMDCode := nSC_USEBONUSPOINT;
      goto L001;
    end;

    if sCmd = sSC_CLEARCURMAPMON then
    begin
      nCMDCode := nSC_CLEARCURMAPMON;
      goto L001;
    end;
    if sCmd = sSC_MONSTORAGE then
    begin
      nCMDCode := nSC_MONSTORAGE;
      goto L001;
    end;

    if sCmd = sSC_FEEDMON then
    begin
      nCMDCode := nSC_FEEDMON;
      goto L001;
    end;

    if sCmd = sSC_UPGRADEMON then
    begin
      nCMDCode := nSC_UPGRADEMON;
      goto L001;
    end;

    if sCmd = sSC_CHECKITEMBOX then
    begin
      nCMDCode := nSC_CHECKITEMBOX;
      goto L001;
    end;

    if sCmd = srelive then
    begin
      nCMDCode := nrelive;
      goto L001;
    end;

    if sCmd = srecpos then
    begin
      nCMDCode := nrecpos;
      goto L001;
    end;

    if  (sCmd=sSC_DELAYGOTO) then
    begin
      nCMDCode := nSC_DELAYGOTO;
      goto L001;
    end;
    if (sCmd = Sdelay) then
    begin
      nCMDCode := ndelay;
      goto L001;
    end;
    if sCmd = shcall then
    begin
      nCMDCode := nhcall;
      goto L001;
    end;


    if sCmd = sSetArrow then
    begin
      nCMDCode := nSetArrow;
      goto L001;
    end;


    if sCmd = sClearArrow then
    begin
      nCMDCode := nClearArrow;
      goto L001;
    end;


    if sCmd = sSC_UpdateTop then
    begin
      nCMDCode := nSC_UpdateTop;
      goto L001;
    end;

    if sCmd = sSC_TAKECASTLEGOLD then
    begin
      nCMDCode := nSC_TAKECASTLEGOLD;
      goto L001;
    end;
    if sCmd = sSC_HUMANHP then
    begin
      nCMDCode := nSC_HUMANHP;
      goto L001;
    end;
    if sCmd = sSC_HUMANMP then
    begin
      nCMDCode := nSC_HUMANMP;
      goto L001;
    end;
    if sCmd = sSC_BUILDPOINT then
    begin
      nCMDCode := nSC_BUILDPOINT;
      goto L001;
    end;
    if sCmd = sSC_AURAEPOINT then
    begin
      nCMDCode := nSC_AURAEPOINT;
      goto L001;
    end;
    if sCmd = sSC_STABILITYPOINT then
    begin
      nCMDCode := nSC_STABILITYPOINT;
      goto L001;
    end;
    if sCmd = sSC_FLOURISHPOINT then
    begin
      nCMDCode := nSC_FLOURISHPOINT;
      goto L001;
    end;
    if sCmd = sSC_OPENMAGICBOX then
    begin
      nCMDCode := nSC_OPENMAGICBOX;
      goto L001;
    end;
    if sCmd = sSC_SETRANKLEVELNAME then
    begin
      nCMDCode := nSC_SETRANKLEVELNAME;
      goto L001;
    end;
    if sCmd = sSC_GMEXECUTE then
    begin
      nCMDCode := nSC_GMEXECUTE;
      goto L001;
    end;
    if sCmd = sSC_GUILDCHIEFITEMCOUNT then
    begin
      nCMDCode := nSC_GUILDCHIEFITEMCOUNT;
      goto L001;
    end;
    if sCmd = sSC_ADDNAMEDATELIST then
    begin
      nCMDCode := nSC_ADDNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_DELNAMEDATELIST then
    begin
      nCMDCode := nSC_DELNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_MOBFIREBURN then
    begin
      nCMDCode := nSC_MOBFIREBURN;
      goto L001;
    end;
    if sCmd = sSC_MESSAGEBOX then
    begin
      nCMDCode := nSC_MESSAGEBOX;
      goto L001;
    end;
    if sCmd = sSC_SETSCRIPTFLAG then
    begin
      nCMDCode := nSC_SETSCRIPTFLAG;
      goto L001;
    end;
    if sCmd = sSC_SETAUTOGETEXP then
    begin
      nCMDCode := nSC_SETAUTOGETEXP;
      goto L001;
    end;
    if sCmd = sSC_VAR then
    begin
      nCMDCode := nSC_VAR;
      goto L001;
    end;
    if sCmd = sSC_LOADVAR then
    begin
      nCMDCode := nSC_LOADVAR;
      goto L001;
    end;
    if sCmd = sLoadExVar then
    begin
      nCMDCode := nLoadExVar;
      goto L001;
    end;
    if sCmd = sSC_SAVEVAR then
    begin
      nCMDCode := nSC_SAVEVAR;
      goto L001;
    end;
    if sCmd = sSaveExVar then
    begin
      nCMDCode := nSaveExVar;
      goto L001;
    end;
    if sCmd = sSENDCOMMENT then
    begin
      nCMDCode := nSENDCOMMENT;
      goto L001;
    end;
    if sCmd = sSC_CALCVAR then
    begin
      nCMDCode := nSC_CALCVAR;
      goto L001;
    end;
    if sCmd = sSC_AUTOADDGAMEGOLD then
    begin
      nCMDCode := nSC_AUTOADDGAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_AUTOSUBGAMEGOLD then
    begin
      nCMDCode := nSC_AUTOSUBGAMEGOLD;
      goto L001;
    end;

    if sCmd = sSC_RECALLGROUPMEMBERS then
    begin
      nCMDCode := nSC_RECALLGROUPMEMBERS;
      goto L001;
    end;
    if sCmd = sSC_CLEARNAMELIST then
    begin
      nCMDCode := nSC_CLEARNAMELIST;
      goto L001;
    end;
    if sCmd = sSC_CHANGENAMECOLOR then
    begin
      nCMDCode := nSC_CHANGENAMECOLOR;
      goto L001;
    end;
    if sCmd = sSC_CLEARPASSWORD then
    begin
      nCMDCode := nSC_CLEARPASSWORD;
      goto L001;
    end;
    if sCmd = sSC_RENEWLEVEL then
    begin
      nCMDCode := nSC_RENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_KILLMONEXPRATE then
    begin
      nCMDCode := nSC_KILLMONEXPRATE;
      goto L001;
    end;
    if sCmd = sSC_POWERRATE then
    begin
      nCMDCode := nSC_POWERRATE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEMODE then
    begin
      nCMDCode := nSC_CHANGEMODE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPERMISSION then
    begin
      nCMDCode := nSC_CHANGEPERMISSION;
      goto L001;
    end;
    if sCmd = sSC_KILL then
    begin
      nCMDCode := nSC_KILL;
      goto L001;
    end;
    if sCmd = sSC_KICK then
    begin
      nCMDCode := nSC_KICK;
      goto L001;
    end;

    if (sCmd = sFENGHAO) or(sCmd='FENGHAO') then
    begin
      nCMDCode := nFENGHAO;
      goto L001;
    end;
    if (sCmd = sSetPetLevel)  then
    begin
      nCMDCode := nSetPetLevel;
      goto L001;
    end;
    if (sCmd = sMAPMOVEHUM)  then
    begin
      nCMDCode := nMAPMOVEHUM;
      goto L001;
    end;

    if sCmd = sSETUSEITEMNAME then
    begin
      nCMDCode := nSETUSEITEMNAME;
      goto L001;
    end;
    if sCmd = sCLONESELF then
    begin
      nCMDCode := nCLONESELF;
      goto L001;
    end;

    if sCmd = sUSESKILL then
    begin
      nCMDCode := nUSESKILL;
      goto L001;
    end;


    if sCmd = sSETOFFLINE then
    begin
      nCMDCode := nSETOFFLINE;
      goto L001;
    end;

    if sCmd = sSETTIMER then
    begin
      nCMDCode := nSETTIMER;
      goto L001;
    end;

    if sCmd = sFUSHEN then
    begin
      nCMDCode := nFUSHEN;
      goto L001;
    end;

    if sCmd = sCreateYS then
    begin
      nCMDCode := nCreateYS;
      goto L001;
    end;

    if sCmd = sCLEARYS then
    begin
      nCMDCode := nCLEARYS;
      goto L001;
    end;
    if sCmd = sDECUSESTIME then
    begin
      nCMDCode := nDECUSESTIME;
      goto L001;
    end;

    if sCmd = sREPAIRALL then
    begin
      nCMDCode := nREPAIRALL;
      goto L001;
    end;

    if sCmd = sCreateGroupLight then
    begin
      nCMDCode := nCreateGroupLight;
      goto L001;
    end;

    if sCmd = sSC_BODYEFFECT then
    begin
      nCMDCode := nSC_BODYEFFECT;
      goto L001;
    end;

    if sCmd = sSC_RANDOMX then
    begin
      nCMDCode := nSC_RANDOMX;
      goto L001;
    end;

    if sCmd = sSC_BONUSPOINT then
    begin
      nCMDCode := nSC_BONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_RESTRENEWLEVEL then
    begin
      nCMDCode := nSC_RESTRENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_DELMARRY then
    begin
      nCMDCode := nSC_DELMARRY;
      goto L001;
    end;
    if sCmd = sSC_DELMASTER then
    begin
      nCMDCode := nSC_DELMASTER;
      goto L001;
    end;
    if sCmd = sSC_MASTER then
    begin
      nCMDCode := nSC_MASTER;
      goto L001;
    end;
    if sCmd = sSC_UNMASTER then
    begin
      nCMDCode := nSC_UNMASTER;
      goto L001;
    end;
    if sCmd = sSC_CREDITPOINT then
    begin
      nCMDCode := nSC_CREDITPOINT;
      goto L001;
    end;
    if sCmd = sSC_CLEARNEEDITEMS then
    begin
      nCMDCode := nSC_CLEARNEEDITEMS;
      goto L001;
    end;
    if sCmd = sSC_CLEARMAKEITEMS then
    begin
      nCMDCode := nSC_CLEARMAEKITEMS;
      goto L001;
    end;

    if sCmd = sSC_SETSENDMSGFLAG then
    begin
      nCMDCode := nSC_SETSENDMSGFLAG;
      goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMS then
    begin
      nCMDCode := nSC_UPGRADEITEMS;
      goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMSEX then
    begin
      nCMDCode := nSC_UPGRADEITEMSEX;
      goto L001;
    end;
    if sCmd = sSC_MONGENEX then
    begin
      nCMDCode := nSC_MONGENEX;
      goto L001;
    end;
    if sCmd = sSC_CLEARMAPMON then
    begin
      nCMDCode := nSC_CLEARMAPMON;
      goto L001;
    end;
    if sCmd = sSC_CLEARMAPMON then
    begin
      nCMDCode := nSC_CLEARMAPMON;
      goto L001;
    end;
    if sCmd = sSetRobotTimer then
    begin
      nCMDCode := nSetRobotTimer;
      goto L001;
    end;
    if sCmd = sCLEARMAPBODY then
    begin
      nCMDCode := nCLEARMAPBODY;
      goto L001;
    end;
    if sCmd = sCLEARMAPITEM then
    begin
      nCMDCode := nCLEARMAPITEM;
      goto L001;
    end;
    if sCmd = sGEMCOUNT then
    begin
      nCMDCode := nGEMCOUNT;
      goto L001;
    end;
    if sCmd = sPNEUMACALL then
    begin
      nCMDCode := nPNEUMACALL;
      goto L001;
    end;
    if sCmd = sSetErniePrize then
    begin
      nCMDCode := nSetErniePrize;
      goto L001;
    end;
    if sCmd = sSMELTBOXRESULT then
    begin
      nCMDCode := nSMELTBOXRESULT;
      goto L001;
    end;
    if sCmd = sTOPLIST then
    begin
      nCMDCode := nTOPLIST;
      goto L001;
    end;
    if sCmd = sSC_SETMAPMODE then
    begin
      nCMDCode := nSC_SETMAPMODE;
      goto L001;
    end;

    if sCmd = sSC_KILLSLAVE then
    begin
      nCMDCode := nSC_KILLSLAVE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEGENDER then
    begin
      nCMDCode := nSC_CHANGEGENDER;
      goto L001;
    end;


    if sCmd = sSC_QUERYVALUE then
    begin
      nCMDCode := nSC_QUERYVALUE;
      goto L001;
    end;

    if sCmd = sSC_QUERYname then
    begin
      nCMDCode := nSC_QUERYname;
      goto L001;
    end;


    if sCmd = SSC_BIGBAG then
    begin
      nCMDCode := nSC_BIGBAG;
      goto L001;
    end;


    L001:
    if nCMDCode > 0 then
    begin
      QuestActionInfo.nCmdCode := nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then
      begin
        ArrestStringEx(sParam1, '"', '"', sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then
      begin
        ArrestStringEx(sParam2, '"', '"', sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then
      begin
        ArrestStringEx(sParam3, '"', '"', sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then
      begin
        ArrestStringEx(sParam4, '"', '"', sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then
      begin
        ArrestStringEx(sParam5, '"', '"', sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then
      begin
        ArrestStringEx(sParam6, '"', '"', sParam6);
      end;
      QuestActionInfo.sParam1 := sParam1;
      QuestActionInfo.sParam2 := sParam2;
      QuestActionInfo.sParam3 := sParam3;
      QuestActionInfo.sParam4 := sParam4;
      QuestActionInfo.sParam5 := sParam5;
      QuestActionInfo.sParam6 := sParam6;
      if IsStringNumber(sParam1) then
        QuestActionInfo.nParam1 := Str_ToInt(sParam1, 0);
      if IsStringNumber(sParam2) then
        QuestActionInfo.nParam2 := Str_ToInt(sParam2, 0);
      if IsStringNumber(sParam3) then
        QuestActionInfo.nParam3 := Str_ToInt(sParam3, 0);
      if IsStringNumber(sParam4) then
        QuestActionInfo.nParam4 := Str_ToInt(sParam4, 0);
      if IsStringNumber(sParam5) then
        QuestActionInfo.nParam5 := Str_ToInt(sParam5, 0);
      if IsStringNumber(sParam6) then
        QuestActionInfo.nParam6 := Str_ToInt(sParam6, 0);

      Result := True;
    end;
  end;
begin //0048B684
  /// 是否为镜像NPC 如果是的就可以 不用加载直接复制被镜像NPC 脚本
  if npc.mirrorname <> '' then
  begin
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do
    begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[i]);
      if (merchant.m_sMapName = npc.mirrorname) and (merchant.m_sCharName = npc.m_sCharName) then
        break;
    end;
    if (i < UserEngine.m_MerchantList.Count)and(merchant<>nil) then
    begin //找到景象NPC
   //                                    景象的先释放
      npc.m_ScriptList.Free;
      TMerchant(npc).m_ItemTypeList.Free;
      TMerchant(npc).m_RefillGoodsList.Free;
      TMerchant(npc).m_GoodsList.Free;
      TMerchant(npc).m_ItemPriceList.Free;
      TMerchant(npc).m_UpgradeWeaponList.Free;
  //
      npc.m_ScriptList := merchant.m_ScriptList; //脚本指针指向 原始NPC ;
      TMerchant(npc).m_ItemTypeList := merchant.m_ItemTypeList; //0x580  NPC买卖物品类型列表，脚本中前面的 +1 +30 之类的
      TMerchant(npc).m_RefillGoodsList := merchant.m_RefillGoodsList;
      TMerchant(npc).m_GoodsList := merchant.m_GoodsList;
      TMerchant(npc).m_ItemPriceList := merchant.m_ItemPriceList;
      TMerchant(npc).m_UpgradeWeaponList := merchant.m_UpgradeWeaponList;
  ////////
      TMerchant(npc).m_nPriceRate := merchant.m_nPriceRate;
      TMerchant(npc).dwRefillGoodsTick := merchant.dwRefillGoodsTick;
      TMerchant(npc).dwClearExpreUpgradeTick := merchant.dwClearExpreUpgradeTick;
      TMerchant(npc).m_boCanMove := merchant.m_boCanMove;
      TMerchant(npc).m_dwMoveTime := merchant.m_dwMoveTime;
      TMerchant(npc).m_dwMoveTick := merchant.m_dwMoveTick;
      TMerchant(npc).m_boBuy := merchant.m_boBuy;
      TMerchant(npc).m_boSell := merchant.m_boSell;
      TMerchant(npc).m_boMakeDrug := merchant.m_boMakeDrug;
      TMerchant(npc).m_boPrices := merchant.m_boPrices;
      TMerchant(npc).m_boStorage := merchant.m_boStorage;
      TMerchant(npc).m_boGetback := merchant.m_boGetback;
      TMerchant(npc).m_boUpgradenow := merchant.m_boUpgradenow;
      TMerchant(npc).m_boGetBackupgnow := merchant.m_boGetBackupgnow;
      TMerchant(npc).m_boRepair := merchant.m_boRepair;
      TMerchant(npc).m_boS_repair := merchant.m_boS_repair;
      TMerchant(npc).m_boSendmsg := merchant.m_boSendmsg;
      TMerchant(npc).m_boGetMarry := merchant.m_boGetMarry;
      TMerchant(npc).m_boGetMaster := merchant.m_boGetMaster;
      TMerchant(npc).m_boUseItemName := merchant.m_boUseItemName;
      TMerchant(npc).m_bocallboard := merchant.m_bocallboard;
      TMerchant(npc).m_bofengyuanguard:=Merchant.m_bofengyuanguard;
 //   for i:=0 to merchant.m_ScriptList.Count-1 do begin
 //     npc.m_ScriptList.Add(merchant.m_ScriptList.Items[i]) ;
 //   end;
      Result := 1;
      exit;
    end;
  end;
  ///


  Result := -1;
  n6C := 0;
  n70 := 0;
  sScritpFileName := g_Config.sEnvirDir + sPatch + sScritpName + '.txt';

//  if npc.byistopnpc>0 then begin          //表示当前加载的是一个TOP NPC
//     sScritpFileName:=g_Config.sEnvirDir+'TOP\'+'TOPNPC-'+inttostr(npc.byistopnpc)+'.TXT' ;
//  end;

  if FileExists(sScritpFileName) then
  begin
   TRY
    LoadList := TgStringList.Create;
    try
      LoadList.LoadFromFile(sScritpFileName);
      DeCodeStringList(LoadList);
    except
      LoadList.Free;
      exit;
    end;
    i := 0;
    while (True) do
    begin
      if not LoadScriptcall(LoadList) then
        break;
      Inc(i);
      if i >= 101 then
        break;
    end; // while
    i:=0;
    while (True) do
    begin
      if not LoadScriptEcall(LoadList) then
        break;
      Inc(i);
      if i >= 101 then
        break;
    end; // while

   // if   TMerchant(npc).m_sCharName='QFunction' then

   //   LoadList.SaveToFile('c:\1.txt');
    DefineList := TList.Create;
    //LoadList.SaveToFile('.\check.txt');
    s54 := LoadDefineInfo(LoadList, DefineList);
    New(DefineInfo);
    DefineInfo.sName := '@HOME';
    if s54 = '' then
      s54 := '@main';
    DefineInfo.sText := s54;
    DefineList.Add(DefineInfo);
    // 常量处理
    for I := 0 to LoadList.Count - 1 do
    begin
      s34 := Trim(LoadList.Strings[i]);
      if (s34 <> '') then
      begin
        if (s34[1] = '[') then
        begin
          bo8D := False;
        end
        else
        begin //0048B83F
          if (s34[1] = '#') and
            (CompareLStr(s34, '#IF', Length('#IF')) or
            CompareLStr(s34, '#ACT', Length('#ACT')) or
            CompareLStr(s34, '#ELSEACT', Length('#ELSEACT'))) then
          begin
            bo8D := True;
          end
          else
          begin //0048B895
            if bo8D then
            begin
              // 将Define 好的常量换成指定值
              for n20 := 0 to DefineList.Count - 1 do
              begin
                DefineInfo := DefineList.Items[n20];
                n1C := 0;
                while (True) do
                begin
                  n24 := Pos(DefineInfo.sName, UpperCase(s34));
                  if n24 <= 0 then
                    break;
                  s58 := Copy(s34, 1, n24 - 1);
                  s5C := Copy(s34, length(DefineInfo.sName) + n24, 256);
                  s34 := s58 + DefineInfo.sText + s5C;
                  LoadList.Strings[i] := s34;
                  Inc(n1C);
                  if n1C >= 10 then
                    break;
                end;
              end; // 将Define 好的常量换成指定值

            end; //0048B97D
          end;
        end; //0048B97D
      end; //0048B97D if (s34 <> '') then begin
    end; //for I := 0 to LoadList.Count - 1 do begin
    // 常量处理

    //释放常量定义内容
    //0048B98C
    for I := 0 to DefineList.Count - 1 do
    begin
      Dispose(pTDefineInfo(DefineList.Items[i]));
    end; // for I := 0 to List64.Count - 1 do begin
    DefineList.Free;
    //释放常量定义内容
    //LoadList.SaveToFile('.\check.txt');

    Script := nil;
    SayingRecord := nil;
    nQuestIdx := 0;

    for I := 0 to LoadList.Count - 1 do
    begin //0048B9FC
      s34 := Trim(LoadList.Strings[i]);
      if (s34 = '') or (s34[1] = ';') or (s34[1] = '/') then
        Continue;
      if (n6C = 0) and (boFlag) then
      begin
        //物品价格倍率
        if s34[1] = '%' then
        begin //0048BA57
          s34 := Copy(s34, 2, Length(s34) - 1);
          nPriceRate := Str_ToInt(s34, -1);
          if nPriceRate >= 55 then
          begin
            TMerchant(NPC).m_nPriceRate := nPriceRate;
          end;
          Continue;
        end;
        //物品交易类型
        if s34[1] = '+' then
        begin
          s34 := Copy(s34, 2, Length(s34) - 1);
          nItemType := Str_ToInt(s34, -1);
          if nItemType >= 0 then
          begin
            TMerchant(NPC).m_ItemTypeList.Add(Pointer(nItemType));
          end;
          Continue;
        end;
        //增加处理NPC可执行命令设置
        if s34[1] = '(' then
        begin
          ArrestStringEx(s34, '(', ')', s34);
          if s34 <> '' then
          begin
            while (s34 <> '') do
            begin
              s34 := GetValidStr3(s34, s30, [' ', ',', #9]);
              if CompareText(s30, sBUY) = 0 then
              begin
                TMerchant(NPC).m_boBuy := True;
                Continue;
              end;
            
              if CompareText(s30, '@openBless') = 0 then
              begin
                TMerchant(NPC).m_boopenBless := True;
                Continue;
              end;
              if CompareText(s30, scallboard) = 0 then
              begin
                TMerchant(NPC).m_bocallboard := True;
                TMerchant(NPC).m_nType:=16;
                Continue;
              end;
              if CompareText(s30, '@callboard2') = 0 then
              begin

                TMerchant(NPC).m_nType:=48;
                Continue;
              end;
              if CompareText(s30, '@conscribeHeros') = 0 then
              begin

                TMerchant(NPC).m_boCallHero:=True;
                Continue;
              end;
              if CompareText(s30,'@doshop')=0 then
              Begin
               TMerchant(NPC).m_bodoshop:=True;
                Continue;
              End;
              if CompareText(s30, '@effigy') = 0 then
              begin

                TMerchant(NPC).m_nType:=34;
                Continue;
              end;
              if CompareText(s30, '@fengyuanguard') = 0 then
              begin
                TMerchant(NPC).m_bofengyuanguard := True;
                 TMerchant(NPC).m_nType:=80;
                Continue;
              end;

              if CompareText(s30, sSELL) = 0 then
              begin
                TMerchant(NPC).m_boSell := True;
                Continue;
              end;
              if CompareText(s30, sMAKEDURG) = 0 then
              begin
                TMerchant(NPC).m_boMakeDrug := True;
                Continue;
              end;
              if CompareText(s30, sPRICES) = 0 then
              begin
                TMerchant(NPC).m_boPrices := True;
                Continue;
              end;
              if CompareText(s30, sSTORAGE) = 0 then
              begin
                TMerchant(NPC).m_boStorage := True;
                Continue;
              end;
              if CompareText(s30, sGETBACK) = 0 then
              begin
                TMerchant(NPC).m_boGetback := True;
                Continue;
              end;
              if CompareText(s30, sUPGRADENOW) = 0 then
              begin
                TMerchant(NPC).m_boUpgradenow := True;
                Continue;
              end;
              if CompareText(s30, sGETBACKUPGNOW) = 0 then
              begin
                TMerchant(NPC).m_boGetBackupgnow := True;
                Continue;
              end;
              if CompareText(s30, sREPAIR) = 0 then
              begin
                TMerchant(NPC).m_boRepair := True;
                Continue;
              end;
              if CompareText(s30, sSUPERREPAIR) = 0 then
              begin
                TMerchant(NPC).m_boS_repair := True;
                Continue;
              end;
              if CompareText(s30, sSL_SENDMSG) = 0 then
              begin
                TMerchant(NPC).m_boSendmsg := True;
                Continue;
              end;
              if CompareText(s30, sUSEITEMNAME) = 0 then
              begin
                TMerchant(NPC).m_boUseItemName := True;
                Continue;
              end;

            end; // while
          end;
          Continue;
        end
        //增加处理NPC可执行命令设置
      end; //0048BAF0

      if s34[1] = '{' then
      begin
        if CompareLStr(s34, '{Quest', length('{Quest')) then
        begin
          s38 := GetValidStr3(s34, s3C, [' ', '}', #9]);
          GetValidStr3(s38, s3C, [' ', '}', #9]);
          n70 := Str_ToInt(s3C, 0);
          Script := MakeNewScript();
          Script.nQuest := n70;
          Inc(n70);
        end; //0048BBA4
        if CompareLStr(s34, '{~Quest', length('{~Quest')) then
          Continue;
      end; //0048BBBE

      if (n6C = 1) and (Script <> nil) and (s34[1] = '#') then
      begin
        s38 := GetValidStr3(s34, s3C, ['=', ' ', #9]);
        Script.boQuest := True;
        if CompareLStr(s34, '#IF', length('#IF')) then
        begin
          ArrestStringEx(s34, '[', ']', s40);
          Script.QuestInfo[nQuestIdx].wFlag := Str_ToInt(s40, 0);
          GetValidStr3(s38, s44, ['=', ' ', #9]);
          n24 := Str_ToInt(s44, 0);
          if n24 <> 0 then
            n24 := 1;
          Script.QuestInfo[nQuestIdx].btValue := n24;
        end; //0048BCBD


        if CompareLStr(s34, '#RAND', length('#RAND')) then
        begin
          Script.QuestInfo[nQuestIdx].nRandRage := Str_ToInt(s44, 0);
        end;
        Continue;
      end; //0048BCF0

      if s34[1] = '[' then
      begin
        n6C := 10;
        if Script = nil then
        begin
          Script := MakeNewScript();
          Script.nQuest := n70;
        end;
        if CompareText(s34, '[goods]') = 0 then
        begin
          n6C := 20;
          Continue;
        end;
        if CompareText(s34, '[InGotGoods]') = 0 then
        begin
          n6C := 50;
          Continue;
        end;
        s34 := ArrestStringEx(s34, '[', ']', s74);
        New(SayingRecord); //脚本段
        SayingRecord.nFlash:=0;
        SayingRecord.ProcedureList := TList.Create;
        SayingRecord.sLabel := s74;
        s34 := GetValidStrCap(s34, s74, [' ', #9]);
        SayingRecord.boExtJmp := False;
        SayingRecord.boPNEUMA:=False;
         if s74<>'' then    //脚本标签参数
        Begin
        if CompareText(s74, 'TRUE') = 0 then
          SayingRecord.boExtJmp := True
        else
        if CompareText(S74,'PNEUMA')=0 then
          SayingRecord.boPNEUMA:=True
        else
        if CompareLstr(s74, 'FLASH(',6)  then
        Begin
           Delete(s74,1,6);
           if s74<>'' then
           Begin
             delete(s74,length(s74),1);
              SayingRecord.nFlash:=str_toInt(s74,0);
           End;
          
        end;
        end;
        New(SayingProcedure); //一个判断结构
        SayingRecord.ProcedureList.Add(SayingProcedure);
        SayingProcedure.ConditionList := TList.Create;
        SayingProcedure.ActionList := TList.Create;
        SayingProcedure.sSayMsg := '';
        SayingProcedure.ElseActionList := TList.Create;
        SayingProcedure.sElseSayMsg := '';
        Script.RecordList.Add(SayingRecord); //增加一个脚本段
        Continue;
      end; //0048BE05
      if (Script <> nil) and (SayingRecord <> nil) then
      begin
        if (n6C >= 10) and (n6C < 20) and (s34[1] = '#') then
        begin
          if CompareText(s34, '#IF') = 0 then
          begin
            if (SayingProcedure.ConditionList.Count > 0) or (SayingProcedure.sSayMsg <> '') then
            begin //0048BE53
              New(SayingProcedure);
              SayingRecord.ProcedureList.Add(SayingProcedure);
              SayingProcedure.ConditionList := TList.Create;
              SayingProcedure.ActionList := TList.Create;
              SayingProcedure.sSayMsg := '';
              SayingProcedure.ElseActionList := TList.Create;
              SayingProcedure.sElseSayMsg := '';
            end; //0048BECE
            n6C := 11;
          end; //0048BED5
          if CompareText(s34, '#ACT') = 0 then
            n6C := 12;
          if CompareText(s34, '#SAY') = 0 then
            n6C := 10;
          if CompareText(s34, '#ELSEACT') = 0 then
            n6C := 13;
          if CompareText(s34, '#ELSESAY') = 0 then
            n6C := 14;
          Continue;
        end; //0048BF3E

        if (n6C = 10) and (SayingProcedure <> nil) then
          SayingProcedure.sSayMsg := SayingProcedure.sSayMsg + s34;

        if (n6C = 11) then
        begin

          New(QuestConditionInfo);
          FillChar(QuestConditionInfo^, SizeOf(TQuestConditionInfo), #0);
          if QuestCondition(Trim(s34), QuestConditionInfo) then
          begin
            SayingProcedure.ConditionList.Add(QuestConditionInfo);
          end
          else
          begin
            Dispose(QuestConditionInfo);
            MainOutMessage('脚本错误1: ' + s34 + ' 第:' + IntToStr(i) + ' 行: ' + sScritpFileName);
          end;
        end; //0048C004

        if (n6C = 12) then
        begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          if QuestAction(Trim(s34), QuestActionInfo) then
          begin
            SayingProcedure.ActionList.Add(QuestActionInfo);
          end
          else
          begin
             QuestAction(Trim(s34), QuestActionInfo) ;
            Dispose(QuestActionInfo);
            MainOutMessage('脚本错误2: ' + s34 + ' 第:' + IntToStr(i) + ' 行: ' + sScritpFileName);
          end;
        end; //0048C0B1

        if (n6C = 13)and(Length(s34)>1) then
        begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          if QuestAction(Trim(s34), QuestActionInfo) then
          begin
            SayingProcedure.ElseActionList.Add(QuestActionInfo);
          end
          else
          begin
            Dispose(QuestActionInfo);
          //  LoadList.SaveToFile('c:\1.txt');
            MainOutMessage('脚本错误3: ' + s34 + ' 第:' + IntToStr(i) + ' 行: ' + sScritpFileName);
          end;
        end;
        if (n6C = 14) then
          SayingProcedure.sElseSayMsg := SayingProcedure.sElseSayMsg + s34;
      end;
      if (n6C = 20) and boFlag then
      begin
        s34 := GetValidStrCap(s34, s48, [' ', #9]);
        s34 := GetValidStrCap(s34, s4C, [' ', #9]);
        s34 := GetValidStrCap(s34, s50, [' ', #9]);
        if (s48 <> '') and (s50 <> '') then
        begin
          New(Goods);
          if (s48 <> '') and (s48[1] = '"') then
          begin
            ArrestStringEx(s48, '"', '"', s48);
          end;
          Goods.sItemName := s48;
          Goods.nCount := Str_ToInt(s4C, 0);
          Goods.dwRefillTime := Str_ToInt(s50, 0);
          Goods.dwRefillTick := 0;
          TMerchant(NPC).m_RefillGoodsList.Add(Goods);
        end; //0048C2D2
      end; //0048C2D2
      //元宝购物清单
      if (n6C = 50) and boFlag then
      begin
        s34 := GetValidStrCap(s34, s48, [' ', #9]);
        s34 := GetValidStrCap(s34, s4C, [' ', #9]);
        s34 := GetValidStrCap(s34, s50, [' ', #9]);

        if (s48 <> '') and (s50 <> '') then
        begin
          New(PClientItem);
          pClientItem^:=ItemUnit.getClientItem(s4c);
          pclientItem^.MakeIndex:=Str_ToInt(s48, 0);
          pClientItem^.DarkProperty.btid:=Str_ToInt(s48, 0);
          pClientItem^.S.Price:=Str_ToInt(s50, 0);
          pclientItem^.S.NeedIdentify:=$80;
          TMerchant(NPC).m_FastGoodList.Add(PClientItem);
        end; //0048C2D2
      end; //0048C2D2
    end; // for
   FINALLY
    LoadList.Free;
   END;
  end
  else
  begin //0048C2EB
    MainOutMessage('脚本文件未找到: ' + sScritpFileName);
  end;
  Result := 1;
end;

function TFrmDB.SaveGoodRecord(NPC: TMerchant; sFile: string): Integer; //0048C748
var
  I, II: Integer;
  sFileName: string;
  FileHandle: Integer;
  UserItem: pTUserItem;
  List: TList;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then
  begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end
  else
  begin
    FileHandle := FileCreate(sFileName);
  end;
  if FileHandle > 0 then
  begin
    FillChar(Header420, SizeOf(TGoodFileHeader), #0);
    for I := 0 to NPC.m_GoodsList.Count - 1 do
    begin
      List := TList(NPC.m_GoodsList.Items[i]);
      Inc(Header420.nItemCount, List.Count);
    end;
    FileWrite(FileHandle, Header420, SizeOf(TGoodFileHeader));
    for I := 0 to NPC.m_GoodsList.Count - 1 do
    begin
      List := TList(NPC.m_GoodsList.Items[i]);
      for II := 0 to List.Count - 1 do
      begin
        UserItem := List.Items[II];
        FileWrite(FileHandle, UserItem^, SizeOf(TUserItem));
      end;
    end;
    FileClose(FileHandle);
    Result := 1;
  end;
end;

procedure TFrmDB.SavePetSellInfo;
var
  I,ii       : Integer;
  sFileName  : string;
  LoadStream : TMemoryStream;
  PetSell    : TPetSellInfo;
  pPetSell   : pTPetSellInfo;
  BaseObject : TBaseobject;
begin

  sFileName := g_Config.sEnvirDir + '\Pet_SellInfo\UserPetSellInfo.dat';
  if not DirectoryExists(g_Config.sEnvirDir + '\Pet_SellInfo') then
      CreateDir(g_Config.sEnvirDir + '\Pet_SellInfo');
  LoadStream:=TMemoryStream.Create;
  try
    for I := 0 to g_PetSellInfo.Count - 1 do
    begin
       pPetSell   := pTPetSellInfo(g_PetSellInfo[i]);
       LoadStream.Write(pPetSell^,SizeOf(TPetSellInfo)) ;
    end;
    for I := 0 to UserEngine.m_PetSellList.Count - 1 do
    Begin
       Baseobject:=TBaseobject(UserEngine.m_PetSellList[i]);
       PetSell.sMasterName:=Baseobject.m_PetSellCharName;
       PetSell.nMakeIndex:=BaseObject.M_monitemmake; //M_PetSellItemMake ;
       PetSell.nSellItemCount:=BaseObject.m_nOnsellcount;
       PetSell.nSellGold:=Baseobject.m_nGold;
       PetSell.nSellYuanBao:=Baseobject.m_nGameGold;
       for ii := 0 to BaseObject.m_nOnsellcount - 1 do
          PetSell.nSellItem[ii]:=BaseObject.m_PetSellItem[ii];

       LoadStream.Write(PetSell,SizeOf(TPetSellInfo)) ;
    End;
      
    LoadStream.SaveToFile(sFileName);
  finally
    LoadStream.Free;
  end;
end;

function TFrmDB.SaveGoodPriceRecord(NPC: TMerchant; sFile: string): Integer; //0048CA64
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  ItemPrice: pTItemPrice;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then
  begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end
  else
  begin
    FileHandle := FileCreate(sFileName);
  end;
  if FileHandle > 0 then
  begin
    FillChar(Header420, SizeOf(TGoodFileHeader), #0);
    Header420.nItemCount := NPC.m_ItemPriceList.Count;
    FileWrite(FileHandle, Header420, SizeOf(TGoodFileHeader));
    for I := 0 to NPC.m_ItemPriceList.Count - 1 do
    begin
      ItemPrice := NPC.m_ItemPriceList.Items[I];
      FileWrite(FileHandle, ItemPrice^, SizeOf(TItemPrice));
    end;
    FileClose(FileHandle);
    Result := 1;
  end;

end;

procedure TFrmDB.ReLoadNpc; //
begin

end;

procedure TFrmDB.ReLoadMerchants; //00487BD8
var
  I, II, nX, nY: Integer;
  sLineText, sFileName, sScript, sMapName, sX, sY, sCharName, sFlag, sAppr, sCastle, sCanMove, sMoveTime: string;
  Merchant: TMerchant;
  LoadList: TStringList;
  boNewNpc: Boolean;
  appr: Integer;
  mirrorname: string;
begin
  sFileName := g_Config.sEnvirDir + 'Merchant.txt';
  if not FileExists(sFileName) then
    exit;
  UserEngine.m_MerchantList.Lock;
  try
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do
    begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[i]);
      Merchant.m_nFlag := -1;
    end;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do
    begin
      sLineText := Trim(LoadList.Strings[i]);
      if (sLineText <> '') and (sLineText[1] <> ';') then
      begin
        sLineText := GetValidStr3(sLineText, sScript, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMapName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sX, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sY, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCharName, [' ', #9]);
        if (sCharName <> '') and (sCharName[1] = '"') then
          ArrestStringEx(sCharName, '"', '"', sCharName);
        sLineText := GetValidStr3(sLineText, sFlag, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAppr, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCastle, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCanMove, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMoveTime, [' ', #9]);
        nX := Str_ToInt(sX, 0);
        nY := Str_ToInt(sY, 0);

        mirrorname := '';
        if pos('>', sMapName) > 0 then
          sMapName := ArrestStringEx(sMapName, '<', '>', mirrorname);

        boNewNpc := True;
        for II := 0 to UserEngine.m_MerchantList.Count - 1 do
        begin
          Merchant := TMerchant(UserEngine.m_MerchantList.Items[II]);
          if (Merchant.m_sMapName = sMapName) and
            (Merchant.m_nCurrX = nX) and
            (Merchant.m_nCurrY = nY) then
          begin
            boNewNpc := False;
            Merchant.m_sScript := sScript;
           // Merchant.m_sCharName:=sCharName;
            if pos('<', sCharName) > 0 then
            begin
              Merchant.m_sCharName := gettopname(sCharName, Merchant.byistopnpc, appr); //这里初识化 top npc 名字 脚本读取时的设置。
            end
            else
              Merchant.m_sCharName := sCharName;
            Merchant.mirrorname := mirrorname;

            if Merchant.byistopnpc = 7 then
              Merchant.m_wAppr := appr
            else
              Merchant.m_wAppr := Str_ToInt(sAppr, 0);

             //  Merchant.m_wAppr:=Str_ToInt(sAppr,0);

            Merchant.m_nFlag := Str_ToInt(sFlag, 0);

            Merchant.m_dwMoveTime := Str_ToInt(sMoveTime, 0);
            if Str_ToInt(sCastle, 0) <> 1 then
              Merchant.m_boCastle := True
            else
              Merchant.m_boCastle := False;

            if (Str_ToInt(sCanMove, 0) <> 0) and (Merchant.m_dwMoveTime > 0) then
              Merchant.m_boCanMove := True;
            break;
          end;
        end;
        if boNewNpc then
        begin
          Merchant := TMerchant.Create;
          Merchant.m_sMapName := sMapName;
          Merchant.m_PEnvir := g_MapManager.FindMap(Merchant.m_sMapName);
          if Merchant.m_PEnvir <> nil then
          begin
            Merchant.m_sScript := sScript;
            Merchant.m_nCurrX := nX;
            Merchant.m_nCurrY := nY;
            Merchant.m_sCharName := sCharName;
            Merchant.m_nFlag := Str_ToInt(sFlag, 0);
            Merchant.m_wAppr := Str_ToInt(sAppr, 0);
            Merchant.m_dwMoveTime := Str_ToInt(sMoveTime, 0);
            if Str_ToInt(sCastle, 0) <> 1 then
              Merchant.m_boCastle := True
            else
              Merchant.m_boCastle := False;
            if (Str_ToInt(sCanMove, 0) <> 0) and (Merchant.m_dwMoveTime > 0) then
              Merchant.m_boCanMove := True;
            UserEngine.m_MerchantList.Add(Merchant);
            Merchant.Initialize;
          end
          else
            Merchant.Free;
        end;
      end;
    end; // for
    LoadList.Free;
    for I := UserEngine.m_MerchantList.Count - 1 downto 0 do
    begin
      Merchant := TMerchant(UserEngine.m_MerchantList.Items[i]);
      if Merchant.m_nFlag = -1 then
      begin
        Merchant.m_boGhost := True;
        Merchant.m_dwGhostTick := GetTickCount();
//        UserEngine.MerchantList.Delete(I);
      end;
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;

function TFrmDB.LoadUpgradeWeaponRecord(sNPCName: string;
  DataList: TList): Integer; //0048CBD0
var
  I: Integer;
  FileHandle: Integer;
  sFileName: string;
  UpgradeInfo: pTUpgradeInfo;
  UpgradeRecord: TUpgradeInfo;
  nRecordCount: Integer;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then
  begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then
    begin
      FileRead(FileHandle, nRecordCount, SizeOf(Integer));
      for I := 0 to nRecordCount - 1 do
      begin
        if FileRead(FileHandle, UpgradeRecord, SizeOf(TUpgradeInfo)) = SizeOf(TUpgradeInfo) then
        begin
          New(UpgradeInfo);
          UpgradeInfo^ := UpgradeRecord;
          UpgradeInfo.dwGetBackTick := 0;
          DataList.Add(UpgradeInfo);
        end;
      end;
      FileClose(FileHandle);
      Result := 1;
    end;
  end;
end;

function TFrmDB.SaveUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
var
  I: Integer;
  FileHandle: Integer;
  sFileName: string;
  UpgradeInfo: pTUpgradeInfo;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then
  begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end
  else
  begin
    FileHandle := FileCreate(sFileName);
  end;
  if FileHandle > 0 then
  begin
    FileWrite(FileHandle, DataList.Count, SizeOf(Integer));
    for I := 0 to DataList.Count - 1 do
    begin
      UpgradeInfo := DataList.Items[I];
      FileWrite(FileHandle, UpgradeInfo^, SizeOf(TUpgradeInfo));
    end;
    FileClose(FileHandle);
    Result := 1;
  end;
end;

function TFrmDB.LoadGoodRecord(NPC: TMerchant; sFile: string): Integer; //0048C574
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  UserItem: pTUserItem;
  List: TList;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then
  begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    List := nil;
    if FileHandle > 0 then
    begin
      if FileRead(FileHandle, Header420, SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then
      begin
        for I := 0 to Header420.nItemCount - 1 do
        begin
          New(UserItem);
          if FileRead(FileHandle, UserItem^, SizeOf(TUserItem)) = SizeOf(TUserItem) then
          begin
            if List = nil then
            begin
              List := TList.Create;
              List.Add(UserItem)
            end
            else
            begin
              if pTUserItem(List.Items[0]).wIndex = UserItem.wIndex then
              begin
                List.Add(UserItem);
              end
              else
              begin
                NPC.m_GoodsList.Add(List);
                List := TList.Create;
                List.Add(UserItem);
              end;
            end;
          end;
        end;
        if List <> nil then
          NPC.m_GoodsList.Add(List);
        FileClose(FileHandle);
        Result := 1;
      end;
    end;
  end;
end;

function TFrmDB.LoadGoodPriceRecord(NPC: TMerchant; sFile: string): Integer; //0048C918
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  ItemPrice: pTItemPrice;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then
  begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then
    begin
      if FileRead(FileHandle, Header420, SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then
      begin
        for I := 0 to Header420.nItemCount - 1 do
        begin
          New(ItemPrice);
          if FileRead(FileHandle, ItemPrice^, SizeOf(TItemPrice)) = SizeOf(TItemPrice) then
          begin
            NPC.m_ItemPriceList.Add(ItemPrice);
          end
          else
          begin
            Dispose(ItemPrice);
            break;
          end;
        end;
      end;
      FileClose(FileHandle);
      Result := 1;
    end;
  end;
end;

procedure DeCryptString(Src, Dest: PChar; nSrc: Integer; var nDest: Integer); stdcall;
var
  s: string;
begin
  s := src;
  // if not CompareLStr(s,sENCYPTSCRIPTFLAG,length(sENCYPTSCRIPTFLAG)) then
  myDecode(s, Dest, Length(s));
end;



function DeCodeString(sSrc: string): string;

begin
  Result := '';
//  if sSrc = '' then
//    exit;
// {$IF VerWD=1}
//  Result:= FUNCTION2(sSrc, 'wol2008', 2, False);
// {$IFEND}
// {$IF VerWD=0}
//  Result:= Decode(sSrc, 'wol2008', 3, False);
// {$IFEND}
  //   DeCryptString(@sSrc[1],@Dest,length(sSrc),nDest);

end;

procedure TFrmDB.DeCodeStringList(StringList: TStringList);
var
  I: Integer;
  sLine: string;
begin
  if StringList.Count <= 0 then
    exit;

  if StringList.Count > 0 then
  begin
    sLine := StringList.Strings[0];
    if not CompareLStr(sLine, sENCYPTSCRIPTFLAG, length(sENCYPTSCRIPTFLAG)) then
    begin //有问题
      exit;
    end;
  end;

{  for I := 0 to StringList.Count - 1 do begin     //
    sLine:=StringList.Strings[I];
    sLine:=DeCodeString(sLine);
    StringList.Strings[I]:=sLine;
  end;  }
  for I := 1 to StringList.Count - 1 do
  begin //
    sLine := StringList.Strings[I];
    sLine := DeCodeString(sLine);
    StringList.Strings[I] := sLine;
  end;
  StringList.Delete(0);


end;


constructor TFrmDB.Create();
begin
  CoInitialize(nil);

{$IF DBTYPE = BDE}
  Query := TQuery.Create(nil);
{$ELSE}
  Query := TADOQuery.Create(nil);
{$IFEND}
end;

destructor TFrmDB.Destroy;
begin
  Query.Free;
  CoUnInitialize;
  inherited;
end;

initialization
  begin
    nDeCryptString := AddToPulgProcTable('DeCryptString');
  end;
finalization
  begin

  end;

//  DeCryptString:TDeCryptString;
end.
