unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus;

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
    N5: TMenuItem;
    actExit: TAction;
    N6: TMenuItem;
    X1: TMenuItem;
    procedure actManageDesignExecute(Sender: TObject);
    procedure actManageFactoryExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actNewOrderExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses UnitDesignNames, UnitDataModule, UnitFactoryNames, UnitOrderDetail;

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
    ShowModal;
    Free;
  end;
end;

end.
