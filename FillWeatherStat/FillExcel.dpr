program FillExcel;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitSetting in 'UnitSetting.pas',
  UnitFrame in 'UnitFrame.pas' {FrameSetting: TFrame},
  UnitSettingForm in 'UnitSettingForm.pas' {FormSetting};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
