program Calc24;

uses
  Forms,
  Unit24 in 'Unit24.pas' {FormCalc};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormCalc, FormCalc);
  Application.Run;
end.
