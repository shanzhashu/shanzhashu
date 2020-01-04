program MatrixWord;

uses
  Forms,
  UnitSearchMatrix in 'UnitSearchMatrix.pas' {FormMatrixWord},
  CnMatrixWord in 'CnMatrixWord.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormMatrixWord, FormMatrixWord);
  Application.Run;
end.
