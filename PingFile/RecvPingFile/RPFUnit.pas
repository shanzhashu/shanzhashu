unit RPFUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, FileCtrl;

type
  TRPFForm = class(TForm)
    lblDir: TLabel;
    edtDir: TEdit;
    btnBrowse: TButton;
    btnRecv: TButton;
    pbRecv: TProgressBar;
    procedure btnBrowseClick(Sender: TObject);
  private
    FRecving: Boolean;
    procedure UpdateButtonState;
  public
    { Public declarations }
  end;

var
  RPFForm: TRPFForm;

implementation

{$R *.dfm}

const
  SEL_DIR_CAPTION = 'Select a Directory:';

procedure TRPFForm.btnBrowseClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := 'C:\';
  if SelectDirectory(SEL_DIR_CAPTION, 'C:\', Dir) then
    edtDir.Text := Dir;
end;

procedure TRPFForm.UpdateButtonState;
begin

end;

end.
