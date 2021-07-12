program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FormHit};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormHit, FormHit);
  Application.Run;
end.
