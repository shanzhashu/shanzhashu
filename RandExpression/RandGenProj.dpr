program RandGenProj;

uses
  Forms,
  RandGen in 'RandGen.pas' {FormGenRandom},
  CnRandomExpression in 'CnRandomExpression.pas',
  UnitResult in 'UnitResult.pas' {FormResult};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormGenRandom, FormGenRandom);
  Application.Run;
end.
