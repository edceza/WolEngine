unit PlugInManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TftmPlugInManage = class(TForm)
    ListBoxPlugin: TListBox;
    procedure FormCreate(Sender: TObject);
  private
    procedure RefPlugin();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  ftmPlugInManage: TftmPlugInManage;

implementation

uses M2Share, PlugIn;

{$R *.dfm}

procedure TftmPlugInManage.FormCreate(Sender: TObject);
begin
//
end;

procedure TftmPlugInManage.Open;
begin
  RefPlugin();
  Self.ShowModal;
end;

procedure TftmPlugInManage.RefPlugin;
var
  I: Integer;
begin
  ListBoxPlugin.Clear;
  for I := 0 to PlugInEngine.PlugList.Count - 1 do
  begin
    ListBoxPlugin.Items.AddObject(PlugInEngine.PlugList.Strings[I], PlugInEngine.PlugList.Objects[I]);
  end;
end;

end.
