program DualMapper;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitDualMapper in 'UnitDualMapper.pas' {FormDualMap},
  CnThreadingTCPServer in 'CnThreadingTCPServer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormDualMap, FormDualMap);
  Application.Run;
end.
