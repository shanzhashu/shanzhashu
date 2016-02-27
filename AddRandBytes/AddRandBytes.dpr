program AddRandBytes;

uses
  Forms,
  AddRandBytesUnit in 'AddRandBytesUnit.pas' {FormRandomBytes};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormRandomBytes, FormRandomBytes);
  Application.Run;
end.
