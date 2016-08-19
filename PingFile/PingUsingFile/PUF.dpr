program PUF;

uses
  Forms,
  PUFUnit in 'PUFUnit.pas' {FormPuf};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPuf, FormPuf);
  Application.Run;
end.
