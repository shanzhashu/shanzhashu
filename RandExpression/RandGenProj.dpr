program RandGenProj;

uses
  Forms,
  RRandGen in 'RRandGen.pas' {Form1},
  CnRandomExpression in 'CnRandomExpression.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
