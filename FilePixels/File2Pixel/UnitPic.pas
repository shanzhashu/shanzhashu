unit UnitPic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TFormPic = class(TForm)
    imgBitmap: TImage;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure imgBitmapDblClick(Sender: TObject);
  private
    FBitmap: TBitmap;
    procedure SetBitmap(const Value: TBitmap);
  public
    procedure SetPicRect(W, H: Integer);
    property Bitmap: TBitmap read FBitmap write SetBitmap;
  end;

var
  FormPic: TFormPic;

implementation

{$R *.dfm}

{ TFormPic }

const
  MIN_WIDTH = 120;
  MIN_HEIGHT = 100;
  MARGIN = 2;

procedure TFormPic.SetPicRect(W, H: Integer);
begin
  imgBitmap.Width := W;
  if W < MIN_WIDTH - MARGIN * 2 then
  begin
    ClientWidth := MIN_WIDTH;
    imgBitmap.Left := (ClientWidth - W) div 2;
  end
  else
  begin
    ClientWidth := W + MARGIN * 2;
    imgBitmap.Left := MARGIN;
  end;

  imgBitmap.Height := H;
  if H < MIN_HEIGHT - MARGIN * 2 then
  begin
    ClientHeight := MIN_HEIGHT;
    imgBitmap.Top := (ClientHeight - W) div 2;
  end
  else
  begin
    ClientHeight := H + MARGIN * 2;
    imgBitmap.Top := MARGIN;
  end;
end;

procedure TFormPic.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TFormPic.SetBitmap(const Value: TBitmap);
begin
  FBitmap := Value;
end;

procedure TFormPic.FormShow(Sender: TObject);
begin
  if (FBitmap <> nil) and (FBitmap.Width = imgBitmap.Width) and
    (FBitmap.Height = imgBitmap.Height) then
  begin
    imgBitmap.Canvas.Draw(0, 0, FBitmap);
  end;
end;

procedure TFormPic.FormDblClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPic.imgBitmapDblClick(Sender: TObject);
begin
  Close;
end;

end.
