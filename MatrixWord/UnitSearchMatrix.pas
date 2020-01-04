unit UnitSearchMatrix;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, CnMatrixWord, StdCtrls, TypInfo;

type
  TFormMatrixWord = class(TForm)
    StringGrid1: TStringGrid;
    lblSearch: TLabel;
    edtSearch: TEdit;
    btnSearch: TButton;
    btnLoad: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
  private
    FWords: TStrings;
    FMatrix: TCnMatrixWord;
  public
    { Public declarations }
  end;

var
  FormMatrixWord: TFormMatrixWord;

implementation

{$R *.DFM}

procedure TFormMatrixWord.FormCreate(Sender: TObject);
begin
  FWords := TStringList.Create;
  FWords.Add('ASKFKJEJKGFLOYKHVBMOEIOWUIE');
  FWords.Add('REXVNJMSPZJKQBJVNXCKNKJRTK');
  FWords.Add('VKNJGBJTJIWNJDBSGUSGNJK');
  FWords.Add('CJKNJKDFNJKJJVFJFQEQWWEOI');
  FWords.Add('AZBXBHXCJQMXKPCLKQUYE');
  FWords.Add('VNMCBNDBNZTYEBXCFUERHFB');
  FWords.Add('NMXCVNMSDJHWEHQBDZBBJCX');
  FWords.Add('RUHEWHJNNMCXZBVBHFQBJJNJKZ');
  FWords.Add('ZJKFRHUIRYTYZVNVZJKQJZKKA');

  FMatrix := TCnMatrixWord.Create;
  FMatrix.LoadFromStrings(FWords);
  FMatrix.DumpToGrid(StringGrid1);
end;

procedure TFormMatrixWord.FormDestroy(Sender: TObject);
begin
  FMatrix.Free;
  FWords.Free;
end;

procedure TFormMatrixWord.btnSearchClick(Sender: TObject);
var
  P: TPoint;
  Dir: TCnSearchDirection;
begin
  if FMatrix.Search(UpperCase(edtSearch.Text), P, Dir) then
  begin
    ShowMessage(IntToStr(P.x) + ' ' + IntToStr(P.y) + ' ' + GetEnumName(TypeInfo(TCnSearchDirection), Ord(Dir)));
    StringGrid1.Col := P.x - 1;
    StringGrid1.Row := P.y - 1;
    StringGrid1.SetFocus;
    edtSearch.SetFocus;
  end
  else
    ShowMessage('NOT Found');
end;

procedure TFormMatrixWord.btnLoadClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    FMatrix.LoadFromFile(OpenDialog1.FileName);
    FMatrix.DumpToGrid(StringGrid1);
  end;
end;

end.
