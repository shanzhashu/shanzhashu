unit UnitDesignNames;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls;

type
  TFormDesignNames = class(TForm)
    dbgrdDesignNames: TDBGrid;
    dsDesignNames: TDataSource;
    dbnvgrDesignNames: TDBNavigator;
    lblDesc: TLabel;
    btnClose: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDesignNames: TFormDesignNames;

implementation

uses UnitDataModule;

{$R *.dfm}

end.
