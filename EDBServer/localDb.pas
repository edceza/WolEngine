unit localDb;
interface
 uses DBTables,Grobal2, Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls,ActiveX,DBShare;

   function LoadItemsDB():Integer;
   function LoadMagicDB():Integer;
   function  FindMagicName(nMagIdx:Integer):string;
   function  GetStdItemName(nItemIdx:Integer):string;
   function  magkeytostr(key:integer):string;
   procedure freelist ;
var Query: TQuery;
    StdItemList,m_MagicList:  Tlist;
implementation                

function  magkeytostr(key:integer):string;
begin
  if key=0 then begin result:='空' ; exit end;
  if key in [49..56] then begin
     result:='F'+inttostr(key-48);
  end;
end;

function  GetStdItemName(nItemIdx: Integer): string; //004AC2F8
begin
  Result:='';
    Dec(nItemIdx);
    if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
      Result:=PTStdItem(StdItemList.Items[nItemIdx]).Name;
      if Result = '' then Result:='空';
    end;
end;

function FindMagicName(nMagIdx: Integer): string;//pTMagic;
var
  I: Integer;
  Magic:pTMagic;
begin
  Result:='';
    for I := 0 to m_MagicList.Count - 1 do begin
      Magic:=m_MagicList.Items[i];
      if Magic.wMagicId = nMagIdx then begin
        Result:=Magic.sMagicName;
        break;
      end;
    end;
end;

function LoadItemsDB: Integer;
var
  i,Idx:Integer;
  StdItem:pTStdItem;
ResourceString
  sSQLString = 'select * from StdItems';
begin


  try
    for I := 0 to StdItemList.Count - 1 do begin
      Dispose(pTStdItem(StdItemList.Items[I]));
    end;
    StdItemList.Clear;
    Result := -1;
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result:= -2;
    end;
    for i:=0 to Query.RecordCount -1 do begin
      New(StdItem);
      Idx            := Query.FieldByName('Idx').AsInteger;
      StdItem.Name      := Query.FieldByName('Name').AsString;
      StdItem.StdMode   := Query.FieldByName('StdMode').AsInteger;
      StdItem.Shape     := Query.FieldByName('Shape').AsInteger;
      StdItem.Weight    := Query.FieldByName('Weight').AsInteger;
      StdItem.AniCount  := Query.FieldByName('AniCount').AsInteger;
      StdItem.Source    := Query.FieldByName('Source').AsInteger;
      StdItem.Reserved  := Query.FieldByName('Reserved').AsInteger;
      StdItem.Looks     := Query.FieldByName('Looks').AsInteger;
      StdItem.DuraMax   := Word(Query.FieldByName('DuraMax').AsInteger);
      StdItem.AC        := MakeLong(ROUND(Query.FieldByName('Ac').AsInteger ),ROUND(Query.FieldByName('Ac2').AsInteger ));
      StdItem.MAC       := MakeLong(ROUND(Query.FieldByName('Mac').AsInteger ),ROUND(Query.FieldByName('MAc2').AsInteger));
      StdItem.DC        := MakeLong(ROUND(Query.FieldByName('Dc').AsInteger ),ROUND(Query.FieldByName('Dc2').AsInteger ));
      StdItem.MC        := MakeLong(ROUND(Query.FieldByName('Mc').AsInteger ),ROUND(Query.FieldByName('Mc2').AsInteger ));
      StdItem.SC        := MakeLong(ROUND(Query.FieldByName('Sc').AsInteger),ROUND(Query.FieldByName('Sc2').AsInteger ));
      StdItem.Need      := Query.FieldByName('Need').AsInteger;
      StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;
      StdItem.Price     := Query.FieldByName('Price').AsInteger;
      StdItem.NeedIdentify:=1;//GetGameLogItemNameList(StdItem.Name);
      if StdItemList.Count = Idx then begin
        StdItemList.Add(StdItem);
        Result := 1;
      end else begin
        OutMainMessage(format('加载物品(Idx:%d Name:%s)数据失败！！！',[Idx,StdItem.Name]));
        Result := -100;
        exit;
      end;
      Query.Next;
    end;
  {  g_boGameLogGold:=GetGameLogItemNameList(sSTRING_GOLDNAME) = 1;
    g_boGameLogHumanDie:=GetGameLogItemNameList(g_sHumanDieEvent) = 1;
    g_boGameLogGameGold:=GetGameLogItemNameList(g_Config.sGameGoldName) = 1;
    g_boGameLogGamePoint:=GetGameLogItemNameList(g_Config.sGamePointName) = 1;  }
  finally
    Query.Close;
  end;

end;

function LoadMagicDB():Integer;
var
  i:Integer;
  Magic:pTMagic;
ResourceString
  sSQLString = 'select * from Magic';
begin
  Result:= -1;




    for I := 0 to  m_MagicList.Count - 1 do begin
      Dispose(pTMagic(m_MagicList.Items[I]));
    end;
     m_MagicList.Clear;


    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result:= -2;
    end;
    for i:=0 to Query.RecordCount -1 do begin
      New(Magic);
      Magic.wMagicId      := Query.FieldByName('MagId').AsInteger;
      Magic.sMagicName    := Query.FieldByName('MagName').AsString;
      Magic.btEffectType  := Query.FieldByName('EffectType').AsInteger;
      Magic.btEffect      := Query.FieldByName('Effect').AsInteger;
      Magic.wSpell        := Query.FieldByName('Spell').AsInteger;
      Magic.wPower        := Query.FieldByName('Power').AsInteger;
      Magic.wMaxPower     := Query.FieldByName('MaxPower').AsInteger;
      Magic.btJob         := Query.FieldByName('Job').AsInteger;
      Magic.TrainLevel[0] := Query.FieldByName('NeedL1').AsInteger;
      Magic.TrainLevel[1] := Query.FieldByName('NeedL2').AsInteger;
      Magic.TrainLevel[2] := Query.FieldByName('NeedL3').AsInteger;
      Magic.TrainLevel[3] := Query.FieldByName('NeedL3').AsInteger;
      Magic.MaxTrain[0]   := Query.FieldByName('L1Train').AsInteger;
      Magic.MaxTrain[1]   := Query.FieldByName('L2Train').AsInteger;
      Magic.MaxTrain[2]   := Query.FieldByName('L3Train').AsInteger;
      Magic.MaxTrain[3]   := Magic.MaxTrain[2];
      Magic.btTrainLv     := 3;
      Magic.dwDelayTime   := Query.FieldByName('Delay').AsInteger;
      Magic.btDefSpell    := Query.FieldByName('DefSpell').AsInteger;
      Magic.btDefPower    := Query.FieldByName('DefPower').AsInteger;
      Magic.btDefMaxPower := Query.FieldByName('DefMaxPower').AsInteger;
   //   Magic.sDescr        := Query.FieldByName('Descr').AsString;
      if Magic.wMagicId > 0 then begin
        m_MagicList.Add(Magic);
      end else begin
        Dispose(Magic);
      end;
      Result := 1;
      Query.Next;
    end;
    Query.Close;

end;
procedure freelist ;
var I:Integer;
begin
    for I := 0 to StdItemList.Count - 1 do begin
      Dispose(pTStdItem(StdItemList.Items[I]));
    end;
    StdItemList.Clear;
    StdItemList.Free;
    for I := 0 to  m_MagicList.Count - 1 do begin
      Dispose(pTMagic(m_MagicList.Items[I]));
      end;
   m_MagicList.Clear;
   m_MagicList.Free;
end;

initialization
begin
      CoInitialize(nil);
      Query:=TQuery.Create(nil);
      Query.DatabaseName:=sDBName ;
      StdItemList:=Tlist.Create;
      m_MagicList:=Tlist.Create;

end;
finalization

      Query.Free;
      CoUnInitialize;
      freelist  ;
begin

end;

end.
