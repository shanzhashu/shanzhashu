program File2Pixel;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormFile},
  UnitPic in 'UnitPic.pas' {FormPic};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormFile, FormFile);
  Application.CreateForm(TFormPic, FormPic);
  Application.Run;
end.
