program AMap;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitOne in 'UnitOne.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
