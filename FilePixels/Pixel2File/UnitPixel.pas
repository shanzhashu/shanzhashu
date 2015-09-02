unit UnitPixel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormPixel = class(TForm)
    lblFile: TLabel;
    edtFile: TEdit;
    btnOpen: TButton;
    lblInfo: TLabel;
    btnExtract: TButton;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    procedure btnOpenClick(Sender: TObject);
    procedure edtFileChange(Sender: TObject);
    procedure btnExtractClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPixel: TFormPixel;

implementation

{$R *.dfm}

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
  Size, W, H, Col, Row: Integer;
  Stream: TMemoryStream;
  R, G, B: Byte;
  C: TColor;
  Ref: TColorRef;
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

      Size := Integer(Bmp.Canvas.Pixels[0, 0]);
      W := Integer(Bmp.Canvas.Pixels[1, 0]);
      H := Integer(Bmp.Canvas.Pixels[2, 0]);

      Stream := TMemoryStream.Create;
      try
        for Row := 0 to H - 1 do
        begin
          if Stream.Size >= Size then
            Break;
          for Col := 0 to W - 1 do
          begin
            if (Row = 0) and (Col in [0..2]) then
              Continue;

            C := Bmp.Canvas.Pixels[Col, Row];
            Ref := ColorToRGB(C);
            R := GetRValue(Ref);
            G := GetGValue(Ref);
            B := GetBValue(Ref);

            Stream.Write(R, 1);
            Stream.Write(G, 1);
            Stream.Write(B, 1);

            if Stream.Size >= Size then
              Break;
          end;
        end;

        // Adjust Stream Size
        Stream.Size := Size;

        if dlgSave.Execute then
        begin
          Stream.SaveToFile(dlgSave.FileName);
          Application.MessageBox(PChar('File Saved To ' + dlgSave.FileName), PChar(Application.Title),
            MB_OK + MB_ICONINFORMATION);
        end;
      finally
        Stream.Free;
      end;
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

end.
