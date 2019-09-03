unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFormFile = class(TForm)
    lblMax: TLabel;
    lblFile: TLabel;
    edtFile: TEdit;
    btnOpen: TButton;
    dlgOpen: TOpenDialog;
    lblInfo: TLabel;
    btnToPixels: TButton;
    edtBlock: TEdit;
    lblBlock: TLabel;
    udBlock: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure edtFileChange(Sender: TObject);
    procedure btnToPixelsClick(Sender: TObject);
    procedure udBlockChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
  private
    procedure ByteToColors(AByte: Byte; out ColorHigh, ColorLow: TColor);
    procedure MakeBlockStream(Seq: Word; ByteSize: Integer; Stream, FileStream: TMemoryStream);
    function StreamToBitmap(Stream: TMemoryStream): TBitmap;

//    function IntToColor(A: Integer): TColor;
//    procedure CalcRect(Size: Integer; var outWidth: Integer; var outHeight: Integer);
  public
    { Public declarations }
  end;

var
  FormFile: TFormFile;

implementation

uses
  UnitPic;

{$R *.dfm}

const
  PIXEL_COLORS: array[0..15] of TColor = ($000000, $800000, $008000, $000080,
    $00C000, $C00000, $0000C0, $FF0000, $00FF00, $0000FF, $8000C0, $FF0080,
    $FF00C0, $808080, $C0C0C0, $8000FF);

var
  BLOCK_PIXEL_SIZE: Integer = 5;
  MAX_BLOCK_WIDTH: Word = 0;             // 转换的图片的宽度（像素块为单位，必然是偶数）
  MAX_BLOCK_HEIGHT: Word = 0;            // 转换的图片的高度（像素块为单位，必然是偶数）
  MAX_BLOCK_COUNT: Integer = 0;          // 转换的图片的像素块数量，上面俩的积
  MAX_FILESIZE: Integer = $FFFFFF;       // 转换的图片的像素块们能代表的最大文件长度

//4字节表示一个2字节序号，0表示第一个包，
//本包文件长度如何确定？屏幕长宽各减去一部分后各自div像素块长，乘起来是像素块数，除以2就是本图容纳的字节长度，减去2、4、2、2，得到文件包长度。
//每个包后面，8字节表示一个本包文件长度，又四字节表示一个两字节长、又四字节表示一个两字节宽，然后开始文件分块内容，每一字节分成两字节。
//不设总长度，包数量够了就行。

procedure TFormFile.FormCreate(Sender: TObject);
begin
  MAX_BLOCK_WIDTH := (Screen.DesktopWidth - 20) div BLOCK_PIXEL_SIZE;
  if (MAX_BLOCK_WIDTH and 1) <> 0 then
    Dec(MAX_BLOCK_WIDTH);

  MAX_BLOCK_HEIGHT := (Screen.DesktopHeight - 100) div BLOCK_PIXEL_SIZE;
  if (MAX_BLOCK_HEIGHT and 1) <> 0 then
    Dec(MAX_BLOCK_HEIGHT);

  // (MAX_BLOCK_WIDTH * MAX_BLOCK_HEIGHT) div 2 是本屏幕能容纳的字节数，减去块头的2 4 2 2就是文件块长度
  MAX_FILESIZE := (MAX_BLOCK_WIDTH * MAX_BLOCK_HEIGHT) div 2 - 10;
  MAX_BLOCK_COUNT := MAX_BLOCK_WIDTH * MAX_BLOCK_HEIGHT;

//  if (MAX_BLOCK_WIDTH * MAX_BLOCK_HEIGHT) * 3 < MAX_FILESIZE then
//    MAX_FILESIZE := (MAX_BLOCK_WIDTH * MAX_BLOCK_HEIGHT) * 3;
//
//  Dec(MAX_FILESIZE, 3 * 3); // 3 Pixels for size/width/height

  lblMax.Caption := Format('Max File Size: %d Bytes. Max Block Width: %d. Max Block Height %d.',
    [MAX_FILESIZE, MAX_BLOCK_WIDTH, MAX_BLOCK_HEIGHT]);
end;

procedure TFormFile.btnOpenClick(Sender: TObject);
//var
//  I: Integer;
begin
//  for I := 0 to 15 do  begin
//     Self.Color := PIXEL_COLORS[I];
//     Application.ProcessMessages;
//     Sleep(1000);
//  end;

  if dlgOpen.Execute then
    edtFile.Text := dlgOpen.FileName;
end;

procedure TFormFile.edtFileChange(Sender: TObject);
var
  F, Size: Integer;
begin
  if FileExists(edtFile.Text) then
  begin
    F := FileOpen(edtFile.Text, 0);
    Size := GetFileSize(F, nil);
    // CalcRect(Size, W, H);

    lblInfo.Caption := Format('File Size: %d. Width %d. Height: %d.',
      [Size, MAX_BLOCK_WIDTH, MAX_BLOCK_HEIGHT]);
    FileClose(F);
  end
  else
    lblInfo.Caption := '';
end;

//procedure TFormFile.CalcRect(Size: Integer; var outWidth, outHeight: Integer);
//var
//  F: Extended;
//begin
//  Inc(Size, 3 * 3);
//
//  if Size > MAX_FILESIZE then
//  begin
//    outWidth := -1;
//    outHeight := -1;
//    Exit;
//  end;
//
//  if Size mod 3 <> 0 then
//  begin
//    Inc(Size);
//    if Size mod 3 <> 0 then
//      Inc(Size);
//  end;
//  Size := Size div 3;
//
//  F := Sqrt(Size);
//  if (F < MAX_BLOCK_WIDTH) and (F < MAX_BLOCK_HEIGHT) then
//  begin
//    outWidth := Trunc(F) + 1;
//    outHeight := Trunc(F) + 1;
//    Exit;
//  end
//  else
//  begin
//    if MAX_BLOCK_WIDTH > MAX_BLOCK_HEIGHT then
//    begin
//      outHeight := MAX_BLOCK_HEIGHT;
//      outWidth := (Size div outHeight) + 1;
//    end
//    else
//    begin
//      outWidth := MAX_BLOCK_WIDTH;
//      outHeight := (Size div outWidth) + 1;
//    end;
//  end;
//end;

procedure TFormFile.btnToPixelsClick(Sender: TObject);
var
  F, Size: Integer;
  Bmp: TBitmap;
  Stream, PicStream: TMemoryStream;
begin
  if FileExists(edtFile.Text) then
  begin
    F := FileOpen(edtFile.Text, 0);
    Size := GetFileSize(F, nil);
    FileClose(F);

    if Size > MAX_FILESIZE then
    begin
      Application.MessageBox('File Size Too Large!', PChar(Application.Title),
        MB_OK + MB_ICONSTOP);

      Exit;
    end;

    Stream := TMemoryStream.Create;
    Stream.LoadFromFile(edtFile.Text);
    PicStream := TMemoryStream.Create;

    MakeBlockStream(0, Size, PicStream, Stream);
    Bmp := StreamToBitmap(PicStream);

    Stream.Free;
    PicStream.Free;

    with TFormPic.Create(nil) do
    begin
      SetPicRect(MAX_BLOCK_WIDTH * BLOCK_PIXEL_SIZE, MAX_BLOCK_HEIGHT * BLOCK_PIXEL_SIZE);
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

//function TFormFile.IntToColor(A: Integer): TColor;
//begin
//  Result := TColor(A);
//end;

procedure TFormFile.ByteToColors(AByte: Byte; out ColorHigh, ColorLow: TColor);
var
  T: Byte;
begin
  T := (AByte and $F0) shr 4;
  ColorHigh := PIXEL_COLORS[T];
  T := AByte and $0F;
  ColorLow := PIXEL_COLORS[T];
end;

procedure TFormFile.MakeBlockStream(Seq: Word; ByteSize: Integer;
  Stream, FileStream: TMemoryStream);
var
  Buf: array of Byte;
begin
  Stream.Clear;
  Stream.Write(Seq, 2);
  Stream.Write(ByteSize, 4);
  Stream.Write(MAX_BLOCK_HEIGHT, 2);
  Stream.Write(MAX_BLOCK_WIDTH, 2);
  SetLength(Buf, ByteSize);
  FileStream.Read(Buf[0], ByteSize);
  Stream.Write(Buf[0], ByteSize);
end;

function TFormFile.StreamToBitmap(Stream: TMemoryStream): TBitmap;
var
  C1, C2: TColor;
  B: Byte;
  C: Integer;
  BRow, BCol, PRow, PCol: Integer;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := pf24bit;
  Result.Height := MAX_BLOCK_HEIGHT * BLOCK_PIXEL_SIZE;
  Result.Width := MAX_BLOCK_WIDTH * BLOCK_PIXEL_SIZE;

  Result.Canvas.Brush.Color := clWhite;
  Result.Canvas.Brush.Style := bsSolid;
  Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));

  C := 0;
  BRow := 0;
  BCol := 0;
  Stream.Position := 0;
  while (C < MAX_BLOCK_COUNT) and (Stream.Read(B, 1) = 1) do
  begin
    ByteToColors(B, C1, C2);

    PRow := BLOCK_PIXEL_SIZE * BRow;
    PCol := BLOCK_PIXEL_SIZE * BCol;

    Result.Canvas.Brush.Color := C1;
    Result.Canvas.FillRect(Rect(PCol, PRow, PCol + BLOCK_PIXEL_SIZE, PRow + BLOCK_PIXEL_SIZE));

    Inc(BCol);
    if BCol >= MAX_BLOCK_WIDTH then
    begin
      BCol := 0;
      Inc(BRow);
    end;

    PRow := BLOCK_PIXEL_SIZE * BRow;
    PCol := BLOCK_PIXEL_SIZE * BCol;

    Result.Canvas.Brush.Color := C2;
    Result.Canvas.FillRect(Rect(PCol, PRow, PCol + BLOCK_PIXEL_SIZE, PRow + BLOCK_PIXEL_SIZE));

    Inc(BCol);
    if BCol >= MAX_BLOCK_WIDTH then
    begin
      BCol := 0;
      Inc(BRow);
    end;

    if BRow >= MAX_BLOCK_HEIGHT then
      Exit;
    Inc(C);
  end;
end;

procedure TFormFile.udBlockChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  BLOCK_PIXEL_SIZE := NewValue;
  FormCreate(Self);
  edtFileChange(edtFile);
end;

end.

