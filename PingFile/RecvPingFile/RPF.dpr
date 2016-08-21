program RPF;

uses
  Forms,
  RPFUnit in 'RPFUnit.pas' {RPFForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRPFForm, RPFForm);
  Application.Run;
end.
