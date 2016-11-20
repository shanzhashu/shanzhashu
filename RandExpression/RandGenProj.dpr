program RandGenProj;

uses
  Forms,
  RandGen in 'RandGen.pas' {Form1},
  CnRandomExpression in 'CnRandomExpression.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
