program Pixel2File;

uses
  Forms,
  UnitPixel in 'UnitPixel.pas' {FormPixel};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPixel, FormPixel);
  Application.Run;
end.
