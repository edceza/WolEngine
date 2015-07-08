unit HttpDown;

interface
uses
  Windows,Classes,SysUtils,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP;



type

  THttpDown = class(TThread)

  private
    IdHTTP   : TIdHTTP;
    Furl     : String;
    FHDNumber: string;
    FHandle  : Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(Url,HDNumber:String;nHandle:Integer);dynamic;
    destructor Destroy; override;
  end;
implementation

{ THttpDown }

constructor THttpDown.Create(Url,HDNumber:String;nHandle:Integer);
begin
   IdHTTP :=TIdHTTP.Create(nil);
   FUrl:=Url;
   FHDNumber:=HDNumber;
   FHandle:=nHandle;
end;

destructor THttpDown.Destroy;
begin
  IdHTTP.Free;
  inherited;
end;

procedure THttpDown.Execute;
var
  Str:string;
begin
 try
    Str:=IdHTTP.Get(Furl);

 finally
 End;

end;

end.
