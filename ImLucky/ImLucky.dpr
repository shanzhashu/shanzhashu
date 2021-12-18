program ImLucky;

uses
  Forms,
  UnitImLucky in 'UnitImLucky.pas' {FormLucky},
  CnRandom in 'CnRandom.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormLucky, FormLucky);
  Application.Run;
end.
