unit RegSoft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nb30, CatDes, registry,M2Share, ExtCtrls, jpeg, ComCtrls;

type
  TFrmRegSoft = class(TForm)
    Button1: TButton;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit_HardId: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    DateTimePicker1: TDateTimePicker;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRegSoft: TFrmRegSoft;

implementation

uses svMain;

{$R *.dfm}


procedure TFrmRegSoft.Button1Click(Sender: TObject);
var
  reg: tregistry;
begin


  close;


end;

procedure TFrmRegSoft.FormCreate(Sender: TObject);
begin
   Label1.Caption:='œ¶—Ù“˝«Ê“˝«Ê≈‰Ã◊≥Ã–Ú';
end;

end.

