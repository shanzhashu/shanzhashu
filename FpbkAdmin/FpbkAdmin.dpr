program FpbkAdmin;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitDataModule in 'UnitDataModule.pas' {DataModuleMain: TDataModule},
  UnitDesignNames in 'UnitDesignNames.pas' {FormDesignNames},
  UnitFactoryNames in 'UnitFactoryNames.pas' {FormFactoryNames},
  UnitOrderDetail in 'UnitOrderDetail.pas' {FormOrderDetail},
  UnitSuite in 'UnitSuite.pas' {FormSuite};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModuleMain, DataModuleMain);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
