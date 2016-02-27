unit AddRandBytesUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TFormRandomBytes = class(TForm)
    lblFile: TLabel;
    edtFile: TEdit;
    btnBrowse: TButton;
    lblCount: TLabel;
    edtByteCount: TEdit;
    udCount: TUpDown;
    chkRandom: TCheckBox;
    btnSave: TButton;
    dlgOpen: TOpenDialog;
    procedure btnBrowseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRandomBytes: TFormRandomBytes;

implementation

{$R *.DFM}

procedure TFormRandomBytes.btnBrowseClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edtFile.Text := dlgOpen.FileName;
end;

procedure TFormRandomBytes.btnSaveClick(Sender: TObject);
var
  I: Integer;
  F: TFileStream;
  B: Byte;
begin
  F := TFileStream.Create(edtFile.Text, fmOpenWrite);
  try
    F.Seek(0, soFromEnd);
    if chkRandom.Checked then
      Randomize
    else
      B := 0;

    Screen.Cursor := crHourGlass;
    for I := 1 to udCount.Position do
    begin
      if chkRandom.Checked then
        B := Trunc(Random * 256);
      F.WriteBuffer(B, SizeOf(Byte));
    end;
  finally
    Screen.Cursor := crDefault;
    F.Free;
  end;

  Application.MessageBox('Save Success.', 'Hint', MB_OK + MB_ICONINFORMATION);
end;

procedure TFormRandomBytes.FormCreate(Sender: TObject);
begin
  Application.Title := Caption;
end;

end.
