unit UnitSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Spin, FileCtrl;

type
  TFormSetting = class(TForm)
    grpSetting: TGroupBox;
    lbl1: TLabel;
    edtRoot: TEdit;
    lbl2: TLabel;
    seInterval: TSpinEdit;
    lbl3: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    btnBrowse: TSpeedButton;
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSetting: TFormSetting;

implementation

{$R *.dfm}

procedure TFormSetting.btnBrowseClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := edtRoot.Text;
  if SelectDirectory('Ñ¡ÔñÄ¿Â¼', '.', Dir) then
    edtRoot.Text := Dir;
end;

end.
