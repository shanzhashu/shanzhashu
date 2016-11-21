program RandGenProj;

uses
  Forms,
  RandGen in 'RandGen.pas' {FormGenRandom},
  CnRandomExpression in 'CnRandomExpression.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormGenRandom, FormGenRandom);
  Application.Run;
end.
