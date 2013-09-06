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
    actQueryAfterSentToFactory: TAction;
    actQueryAfterSentToDesign: TAction;
    actQueryAfterRecvFromDesign: TAction;
    actQueryOrdered: TAction;
    actQueryShot: TAction;
    actQueryAfterRecvFromFactory: TAction;
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
    N5: TMenuItem;
    actQueryNotTaken: TAction;
    N17: TMenuItem;
    actQueryTaken: TAction;
    N18: TMenuItem;
    procedure actManageDesignExecute(Sender: TObject);
    procedure actManageFactoryExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actNewOrderExecute(Sender: TObject);
    procedure dbgrdOrdersDblClick(Sender: TObject);
    procedure actManageSuiteExecute(Sender: TObject);
    procedure actNewShotExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actQueryAllExecute(Sender: TObject);
    procedure actQueryOrderedExecute(Sender: TObject);
    procedure actQueryShotExecute(Sender: TObject);
    procedure actQueryAfterSentToDesignExecute(Sender: TObject);
    procedure actQueryAfterRecvFromDesignExecute(Sender: TObject);
    procedure actQueryAfterSentToFactoryExecute(Sender: TObject);
    procedure actQueryAfterRecvFromFactoryExecute(Sender: TObject);
    procedure actQueryNotTakenExecute(Sender: TObject);
    procedure actQueryTakenExecute(Sender: TObject);
  private
    { Private declarations }
    procedure OnMsgOpenDataBase(var Msg: TMessage); message MSG_OPEN_DATABASE;
    procedure QueryBuild(const Where: string; const Order: string = '');
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
  if DataModuleMain.dsOrderForms.Eof then
    Exit;

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

procedure TFormMain.QueryBuild(const Where, Order: string);
var
  Sql: string;
begin
  DataModuleMain.dsOrderForms.Active := False;
  Sql := ORDER_FORM_SQL;
  if Where <> '' then
    Sql := Sql + ' WHERE ' + Where;
  if Order <> '' then
    Sql := Sql + ' ORDER BY ' + Order
  else
    Sql := Sql + ' ORDER BY ' + DEFAULT_SORT_ORDER;

  DataModuleMain.dsOrderForms.CommandText := Sql;
  DataModuleMain.dsOrderForms.Active := True;
end;

procedure TFormMain.actQueryAllExecute(Sender: TObject);
begin
  QueryBuild('');
end;

procedure TFormMain.actQueryOrderedExecute(Sender: TObject);
begin
  QueryBuild('Status = ' + IntToStr(Integer(osOrdered)));
end;

procedure TFormMain.actQueryShotExecute(Sender: TObject);
begin
  QueryBuild('Status = ' + IntToStr(Integer(osShot)));
end;

procedure TFormMain.actQueryAfterSentToDesignExecute(Sender: TObject);
begin
  QueryBuild('Status >= ' + IntToStr(Integer(osDesignSent)));
end;

procedure TFormMain.actQueryAfterRecvFromDesignExecute(Sender: TObject);
begin
  QueryBuild('Status >= ' + IntToStr(Integer(osDesignOK)));
end;

procedure TFormMain.actQueryAfterSentToFactoryExecute(Sender: TObject);
begin
  QueryBuild('Status >= ' + IntToStr(Integer(osSentToFactory)));
end;

procedure TFormMain.actQueryAfterRecvFromFactoryExecute(Sender: TObject);
begin
  QueryBuild('Status >= ' + IntToStr(Integer(osRecvFromFactory)));
end;

procedure TFormMain.actQueryNotTakenExecute(Sender: TObject);
begin
  QueryBuild('Status = ' + IntToStr(Integer(osRecvFromFactory)) +
    ' OR Status = ' + IntToStr(Integer(osCustomerNotified)));
end;

procedure TFormMain.actQueryTakenExecute(Sender: TObject);
begin
  QueryBuild('Status = ' + IntToStr(Integer(osCustomerTaken)));
end;

end.
