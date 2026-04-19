program CharCount;

uses
  Forms,
  UnitCharCount in 'UnitCharCount.pas' {FormCharCount};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormCharCount, FormCharCount);
  Application.Run;
end.
