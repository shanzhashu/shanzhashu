unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormFile = class(TForm)
    lblMax: TLabel;
    lblFile: TLabel;
    edtFile: TEdit;
    btnOpen: TButton;
    dlgOpen: TOpenDialog;
    lblInfo: TLabel;
    btnToPixels: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure edtFileChange(Sender: TObject);
    procedure btnToPixelsClick(Sender: TObject);
  private
    function IntToColor(A: Integer): TColor;
    procedure CalcRect(Size: Integer; var outWidth: Integer; var outHeight: Integer);
  public
    { Public declarations }
  end;

var
  FormFile: TFormFile;

implementation

uses UnitPic;

{$R *.dfm}

var
  MAX_WIDTH: Integer = 0;
  MAX_HEIGHT: Integer = 0;
  MAX_FILESIZE: Cardinal = $FFFFFF;

procedure TFormFile.FormCreate(Sender: TObject);
begin
  MAX_WIDTH := Screen.DesktopWidth - 100;
  MAX_HEIGHT := Screen.DesktopHeight - 150;

  if (MAX_WIDTH * MAX_HEIGHT) * 3 < MAX_FILESIZE then
    MAX_FILESIZE := (MAX_WIDTH * MAX_HEIGHT) * 3;

  Dec(MAX_FILESIZE, 3 * 3); // 3 Pixels for size/width/height  
  lblMax.Caption := Format('Max File Size: %d Bytes. Max Width: %d. Max Height %d.',
    [MAX_FILESIZE, MAX_WIDTH, MAX_HEIGHT]);
end;

procedure TFormFile.btnOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edtFile.Text := dlgOpen.FileName;
end;

procedure TFormFile.edtFileChange(Sender: TObject);
var
  F, Size: Integer;
  W, H: Integer;
begin
  if FileExists(edtFile.Text) then
  begin
    F := FileOpen(edtFile.Text, 0);
    Size := GetFileSize(F, nil);
    CalcRect(Size, W, H);

    lblInfo.Caption := Format('File Size: %d. Width %d. Height: %d.',
      [Size, W, H]);
    FileClose(F);
  end
  else
    lblInfo.Caption := '';
end;

procedure TFormFile.CalcRect(Size: Integer; var outWidth,
  outHeight: Integer);
var
  F: Extended;
begin
  Inc(Size, 3 * 3);

  if Size > MAX_FILESIZE then
  begin
    outWidth := -1;
    outHeight := -1;
    Exit;
  end;

  if Size mod 3 <> 0 then
  begin
    Inc(Size);
    if Size mod 3 <> 0 then
      Inc(Size);
  end;
  Size := Size div 3;

  F := Sqrt(Size);
  if (F < MAX_WIDTH) and (F < MAX_HEIGHT) then
  begin
    outWidth := Trunc(F) + 1;
    outHeight := Trunc(F) + 1;
    Exit;
  end
  else
  begin
    if MAX_WIDTH > MAX_HEIGHT then
    begin
      outHeight := MAX_HEIGHT;
      outWidth := (Size div outHeight) + 1;
    end
    else
    begin
      outWidth := MAX_WIDTH;
      outHeight := (Size div outWidth) + 1;
    end;
  end;
end;

procedure TFormFile.btnToPixelsClick(Sender: TObject);
var
  F, Size: Integer;
  W, H, Row, Col: Integer;
  Bmp: TBitmap;
  Stream: TMemoryStream;
  C: AnsiChar;
  Buf: array[0..2] of Byte;
begin
  if FileExists(edtFile.Text) then
  begin
    F := FileOpen(edtFile.Text, 0);
    Size := GetFileSize(F, nil);
    CalcRect(Size, W, H);
    FileClose(F);

    if (Size > MAX_FILESIZE) or (H = -1) or (W = -1) then
    begin
      Application.MessageBox('File Size Too Large!', PChar(Application.Title),
        MB_OK + MB_ICONSTOP);

      Exit;
    end;

    if H * W * 3 < (Size + 3) then
    begin
      Application.MessageBox('Error Calc Bitmap Rect!', PChar(Application.Title),
        MB_OK + MB_ICONSTOP);
      Exit;
    end;

    // ∂¡Œƒº˛ƒ⁄»›≤¢∆¥ŒªÕº
    Bmp := TBitmap.Create;
    Bmp.PixelFormat := pf24bit;
    Bmp.Height := H;
    Bmp.Width := W;

    Stream := TMemoryStream.Create;
    Stream.LoadFromFile(edtFile.Text);

    if (Stream.Size mod 3) <> 0 then
    begin
      Stream.Seek(0, soFromEnd);
      C := #0;
      Stream.Write(C, 1);
      if (Stream.Size mod 3) <> 0 then
        Stream.Write(C, 1);
    end; // Make div 3 = 0
    Stream.Position := 0;

    for Row := 0 to Bmp.Height - 1 do
    begin
      for Col := 0 to Bmp.Width - 1 do
      begin
        if (Row = 0) and (Col = 0) then // –¥≥ﬂ¥Á
          Bmp.Canvas.Pixels[Col, Row] := IntToColor(Size)
        else if (Row = 0) and (Col = 1) then  // –¥øÌ
          Bmp.Canvas.Pixels[Col, Row] := IntToColor(W)
        else if (Row = 0) and (Col = 2) then  // –¥∏ﬂ
          Bmp.Canvas.Pixels[Col, Row] := IntToColor(H)
        else
        begin
          F := Stream.Read(Buf, SizeOf(Buf));
          if F <> SizeOf(Buf) then // ∂¡µΩŒ≤∞Õ¡À
            Break;

          Bmp.Canvas.Pixels[Col, Row] := RGB(Buf[0], Buf[1], Buf[2]);
        end;
      end;
    end;

    Stream.Free;
    with TFormPic.Create(nil) do
    begin
      SetPicRect(W, H);
      Bitmap := Bmp;
      ShowModal;
      Free;
    end;
    Bmp.Free;
  end
  else
  begin
    Application.MessageBox('Error Reading File!', PChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

function TFormFile.IntToColor(A: Integer): TColor;
begin
  Result := TColor(A);
end;

end.
