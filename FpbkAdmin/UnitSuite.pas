unit UnitSuite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask, DB, Grids, DBGrids;

type
  TFormSuite = class(TForm)
    lblDesc: TLabel;
    dbgrdPreContents: TDBGrid;
    dsPreContents: TDataSource;
    grpSuite: TGroupBox;
    dbedtPreContentName: TDBEdit;
    lblPreContentName: TLabel;
    lblPreContentPrice: TLabel;
    dbedtPreContentPrice: TDBEdit;
    lblYuan: TLabel;
    lblPreContentDescription: TLabel;
    dbmmoDescription: TDBMemo;
    dbnvgrSuite: TDBNavigator;
    btnClose: TButton;
    btnOK: TButton;
    procedure dbgrdPreContentsDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSuite: TFormSuite;

implementation

uses UnitDataModule;

{$R *.dfm}

procedure TFormSuite.dbgrdPreContentsDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
