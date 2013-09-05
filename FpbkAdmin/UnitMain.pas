unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, DB, Grids, DBGrids, ComCtrls;

const
  MSG_OPEN_DATABASE = WM_USER + 100;

type
  TFormMain = class(TForm)
    actlstMain: TActionList;
    actNewOrder: TAction;
    actNewShot: TAction;
    actManageDesign: TAction;
    actManageFactory: TAction;
    mmMain: TMainMenu;
    N1: TMenuItem;
    M1: TMenuItem;
    Q1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    actExit: TAction;
    N6: TMenuItem;
    X1: TMenuItem;
    actQuerySentToFactory: TAction;
    actQuerySentToDesign: TAction;
    actQueryRecvFromDesign: TAction;
    actQueryOrdered: TAction;
    actQueryShot: TAction;
    actQueryRecvFromFactory: TAction;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    actBackupDatabase: TAction;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    actQueryAll: TAction;
    A1: TMenuItem;
    dbgrdOrders: TDBGrid;
    dsOrders: TDataSource;
    actManageSuite: TAction;
    N16: TMenuItem;
    statMain: TStatusBar;
    procedure actManageDesignExecute(Sender: TObject);
    procedure actManageFactoryExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actNewOrderExecute(Sender: TObject);
    procedure dbgrdOrdersDblClick(Sender: TObject);
    procedure actManageSuiteExecute(Sender: TObject);
    procedure actNewShotExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OnMsgOpenDataBase(var Msg: TMessage); message MSG_OPEN_DATABASE;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses UnitDesignNames, UnitDataModule, UnitFactoryNames, UnitOrderDetail,
  UnitSuite;

{$R *.dfm}

procedure TFormMain.actManageDesignExecute(Sender: TObject);
begin
  with TFormDesignNames.Create(Application) do
  begin
    DataModuleMain.conDatabase.Connected := True;
    DataModuleMain.tblDesignNames.Active := True;
    ShowModal;
    DataModuleMain.tblDesignNames.Active := False;
    Free;
  end;
end;

procedure TFormMain.actManageFactoryExecute(Sender: TObject);
begin
  with TFormFactoryNames.Create(Application) do
  begin
    DataModuleMain.conDatabase.Connected := True;
    DataModuleMain.tblFactoryNames.Active := True;
    ShowModal;
    DataModuleMain.tblFactoryNames.Active := False;
    Free;
  end;
end;

procedure TFormMain.actExitExecute(Sender: TObject);
begin
  DataModuleMain.conDatabase.Connected := False;
  Application.Terminate;
end;

procedure TFormMain.actNewOrderExecute(Sender: TObject);
begin
  with TFormOrderDetail.Create(Application) do
  begin
    IsNew := True;
    cbbStatus.ItemIndex := Integer(osOrdered);
    if Assigned(cbbStatus.OnChange) then
      cbbStatus.OnChange(cbbStatus);

    ShowModal;
    Free;
  end;
end;

procedure TFormMain.dbgrdOrdersDblClick(Sender: TObject);
begin
  // 根据当前记录，编辑它
  with TFormOrderDetail.Create(Application) do
  begin
    IsNew := False;
    FillValues(DataModuleMain.dsOrderForms);

    ShowModal;
    if SaveSuc then
      DataModuleMain.dsOrderForms.Requery;

    Free;
  end;
end;

procedure TFormMain.actManageSuiteExecute(Sender: TObject);
begin
  with TFormSuite.Create(Application) do
  begin
    DataModuleMain.conDatabase.Connected := True;
    DataModuleMain.tblPreContents.Active := True;
    ShowModal;
    DataModuleMain.tblPreContents.Active := False;
    Free;
  end;
end;

procedure TFormMain.actNewShotExecute(Sender: TObject);
begin
  with TFormOrderDetail.Create(Application) do
  begin
    IsNew := True;
    cbbStatus.ItemIndex := Integer(osOrdered);
    if Assigned(cbbStatus.OnChange) then
      cbbStatus.OnChange(cbbStatus);


    ShowModal;
    Free;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  PostMessage(Handle, MSG_OPEN_DATABASE, 0, 0);
end;

procedure TFormMain.OnMsgOpenDataBase(var Msg: TMessage);
begin
  DataModuleMain.conDatabase.Connected := True;
  DataModuleMain.dsOrderForms.Active := True;
end;

end.
