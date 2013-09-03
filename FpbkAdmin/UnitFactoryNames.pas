unit UnitFactoryNames;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls;

type
  TFormFactoryNames = class(TForm)
    dbgrdFactoryNames: TDBGrid;
    dsFactoryNames: TDataSource;
    dbnvgrFactoryNames: TDBNavigator;
    lblDesc: TLabel;
    btnClose: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFactoryNames: TFormFactoryNames;

implementation

uses UnitDataModule;

{$R *.dfm}

end.
