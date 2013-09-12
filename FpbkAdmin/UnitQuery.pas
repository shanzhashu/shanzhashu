unit UnitQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls;

type
  TFormQuery = class(TForm)
    grpQuery: TGroupBox;
    lblStart: TLabel;
    dtpStart: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    lblEnd: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    tlbDays: TToolBar;
    btnThisMonth: TToolButton;
    btnPrevMonth: TToolButton;
    btnOneMonth: TToolButton;
    btnThreeMonth: TToolButton;
    btnSixMonth: TToolButton;
    btnOneYear: TToolButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormQuery: TFormQuery;

implementation

{$R *.dfm}

procedure TFormQuery.FormCreate(Sender: TObject);
begin
  dtpStart.Date := Date;
  dtpEnd.Date := Date;
end;

end.
