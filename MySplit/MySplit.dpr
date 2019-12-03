program MySplit;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitSplit in 'UnitSplit.pas' {FormSplit};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormSplit, FormSplit);
  Application.Run;
end.
