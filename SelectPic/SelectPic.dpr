program SelectPic;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  DirectDraw in 'DirectDraw.pas',
  GDIPAPI in 'GDIPAPI.pas',
  GDIPOBJ in 'GDIPOBJ.pas',
  GDIPUTIL in 'GDIPUTIL.pas',
  LXImage in 'LXImage.pas',
  UnitSlide in 'UnitSlide.pas' {FormSlide},
  UnitDisplay in 'UnitDisplay.pas' {FormDisplay},
  UnitOptions in 'UnitOptions.pas',
  UnitSetting in 'UnitSetting.pas' {FormSetting},
  CnShellUtils in 'CnShellUtils.pas',
  UnitInfo in 'UnitInfo.pas' {FormInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
