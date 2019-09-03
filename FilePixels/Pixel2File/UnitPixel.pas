unit UnitPixel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFormPixel = class(TForm)
    lblFile: TLabel;
    edtFile: TEdit;
    btnOpen: TButton;
    lblInfo: TLabel;
    btnExtract: TButton;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    edtBlock: TEdit;
    lblBlock: TLabel;
    udBlock: TUpDown;
    procedure btnOpenClick(Sender: TObject);
    procedure edtFileChange(Sender: TObject);
    procedure btnExtractClick(Sender: TObject);
    procedure udBlockChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
  private
    function ReadByte(Bmp: TBitmap; BRow, BCol: Integer): Byte;
    function GetRectValueFromColor(Bmp: TBitmap; ARect: TRect): Byte;
//    function GetValueFromColor(AColor: TColor): Byte;
  public
    { Public declarations }
  end;

var
  FormPixel: TFormPixel;

implementation

{$R *.dfm}

var
  BLOCK_PIXEL_SIZE: Integer = 5;

const
  PIXEL_COLORS: array[0..15] of TColor = ($000000, $800000, $008000, $000080,
    $00C000, $C00000, $0000C0, $FF0000, $00FF00, $0000FF, $8000C0, $FF0080,
    $FF00C0, $808080, $C0C0C0, $8000FF);

procedure TFormPixel.btnOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edtFile.Text := dlgOpen.FileName;
end;

procedure TFormPixel.edtFileChange(Sender: TObject);
var
  Bmp: TBitmap;
begin
  if FileExists(edtFile.Text) then
  begin
    Bmp := TBitmap.Create;
    try
      try
        Bmp.LoadFromFile(edtFile.Text);
      except
        lblInfo.Caption := 'Error Loading Bitmap.';
        Exit;
      end;
      lblInfo.Caption := Format('Bmp Width %d, Height %d', [Bmp.Width, Bmp.Height]);
    finally
      Bmp.Free;
    end;
  end
  else
    lblInfo.Caption := '';
end;

procedure TFormPixel.btnExtractClick(Sender: TObject);
var
  Bmp: TBitmap;
  BW, BH: Integer;
  Stream: TMemoryStream;
  B1, B2, B3, B4: Byte;
  Seq: Word;
  Len, C: Integer;
  BCol, BRow: Integer;
begin
  if FileExists(edtFile.Text) then
  begin
    Bmp := TBitmap.Create;
    try
      try
        Bmp.LoadFromFile(edtFile.Text);
      except
        Application.MessageBox('Error Loading Bitmap.', PChar(Application.Title), MB_OK
          + MB_ICONSTOP);
        Exit;
      end;

      if Bmp.Width < 20 then
      begin
        Application.MessageBox('Error Width of Bitmap.', PChar(Application.Title), MB_OK
          + MB_ICONSTOP);
        Exit;
      end;

      B1 := ReadByte(Bmp, 0, 0);
      B2 := ReadByte(Bmp, 0, 2);
      Seq := (B2 shl 8) or B1;

      B1 := ReadByte(Bmp, 0, 4);
      B2 := ReadByte(Bmp, 0, 6);
      B3 := ReadByte(Bmp, 0, 8);
      B4 := ReadByte(Bmp, 0, 10);
      Len := (B4 shl 24) or (B3 shl 16) or (B2 shl 8) or B1;

      B1 := ReadByte(Bmp, 0, 12);
      B2 := ReadByte(Bmp, 0, 14);
      BH := (B2 shl 8) or B1;
      B1 := ReadByte(Bmp, 0, 16);
      B2 := ReadByte(Bmp, 0, 18);
      BW := (B2 shl 8) or B1;

      Application.MessageBox(PChar(Format('Seq %d. Len %d. Width %d, Height %d.', [Seq, Len, BW, BH])), PChar(Application.Title), MB_OK);

      // 从 0 20 开始，遍历 BH BW，直到 Len 到了为止

      Stream := TMemoryStream.Create;
      BCol := 20;
      BRow := 0;
      C := 0;
      while (BCol <= BW) and (BRow <= BH) and (C < Len) do
      begin
        B1 := ReadByte(Bmp, BRow, BCol);
        Inc(BCol, 2);
        if BCol >= BW then
        begin
          BCol := 0;
          Inc(BRow);
        end;
        if BRow >= BH then
          Break;
        Inc(C);

        Stream.Write(B1, 1);
      end;
      Application.MessageBox(PChar(Format('Get %d Bytes', [Stream.Size])), PChar(Application.Title), MB_OK);
      if Stream.Size > 0 then
        if dlgSave.Execute then
          Stream.SaveToFile(dlgSave.FileName);
      Stream.Free;
    finally
      Bmp.Free;
    end;
  end
  else
  begin
    Application.MessageBox('File NOT Exists!', PChar(Application.Title), MB_OK
      + MB_ICONSTOP);
  end;
end;

function TFormPixel.ReadByte(Bmp: TBitmap; BRow, BCol: Integer): Byte;
var
  PRow, PCol: Integer;
  R: TRect;
  B1, B2: Byte;
begin
  PRow := BRow * BLOCK_PIXEL_SIZE;
  PCol := BCol * BLOCK_PIXEL_SIZE;
  R := Rect(PCol, PRow, PCol + BLOCK_PIXEL_SIZE - 1, PRow + BLOCK_PIXEL_SIZE - 1);
  B1 := GetRectValueFromColor(Bmp, R);
  Inc(PCol, BLOCK_PIXEL_SIZE);
  R := Rect(PCol, PRow, PCol + BLOCK_PIXEL_SIZE - 1, PRow + BLOCK_PIXEL_SIZE - 1);
  B2 := GetRectValueFromColor(Bmp, R);
  Result := (B1 shl 4) or (B2 and $0F);
end;

function TFormPixel.GetRectValueFromColor(Bmp: TBitmap; ARect: TRect): Byte;
var
  C: TColor;
  CD: Cardinal;
  I, J, R, G, B, DR, DG, DB: Integer;
  SR, SG, SB, SD: Integer;
begin
  // 求这个 Rect 内像素的平均值，并取整
  SR := 0;
  SG := 0;
  SB := 0;
  for I := ARect.Left to ARect.Right do
  begin
    for J := ARect.Top to ARect.Bottom do
    begin
      C := Bmp.Canvas.Pixels[I, J];
      CD := ColorToRGB(C);
      R := GetRValue(CD);
      G := GetGValue(CD);
      B := GetBValue(CD);
      SR := SR + R;
      SG := SG + G;
      SB := SB + B;
    end;
  end;
  SR := SR div ((ARect.Right - ARect.Left + 1) * (ARect.Bottom - ARect.Top + 1));
  SG := SG div ((ARect.Right - ARect.Left + 1) * (ARect.Bottom - ARect.Top + 1));
  SB := SB div ((ARect.Right - ARect.Left + 1) * (ARect.Bottom - ARect.Top + 1));

  SD := $FFFFFF;
  Result := 0;
  for I := Low(PIXEL_COLORS) to High(PIXEL_COLORS) do
  begin
    CD := ColorToRGB(PIXEL_COLORS[I]);
    R := GetRValue(CD);
    G := GetGValue(CD);
    B := GetBValue(CD);

    DR := SR - R;
    if DR < 0 then DR := -DR;
    DG := SG - G;
    if DG < 0 then DG := -DG;
    DB := SB - B;
    if DB < 0 then DB := -DB;

    if DR + DG + DB < SD then // 和固定值的各分量色差和最小的
    begin
      SD := DR + DG + DB;
      Result := I;
      if SD = 0 then
        Exit;
    end;
  end;
end;

//function TFormPixel.GetValueFromColor(AColor: TColor): Byte;
//var
//  I: Integer;
//begin
//  for I := Low(PIXEL_COLORS) to High(PIXEL_COLORS) do
//  begin
//    if AColor = PIXEL_COLORS[I] then
//    begin
//      Result := I;
//      Exit;
//    end;
//  end;
//  raise Exception.Create('Invalid Color ' + ColorToString(AColor));
//end;

procedure TFormPixel.udBlockChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  BLOCK_PIXEL_SIZE := NewValue;
end;

end.
