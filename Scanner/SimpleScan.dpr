program SimpleScan;

uses
  Forms,
  UnitScan in 'UnitScan.pas' {FormScan};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormScan, FormScan);
  Application.Run;
end.
