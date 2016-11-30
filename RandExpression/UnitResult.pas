unit UnitResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Printers;

type
  TFormResult = class(TForm)
    StringGrid: TStringGrid;
    dlgPnt: TPrintDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGridMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGridMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  private
    procedure PrintGrid;
  public
    { Public declarations }
  end;

var
  FormResult: TFormResult;

implementation

{$R *.DFM}

procedure TFormResult.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  Top := 20;
  Left := 20;
  Width := Screen.Width - 40;
  Height := Screen.Height - 90;

  StringGrid.ColCount := 6;
  for I := 0 to StringGrid.ColCount - 1 do
    StringGrid.ColWidths[I] := (Width div 6) - 2;

  StringGrid.RowCount := 15;
  for I := 0 to StringGrid.RowCount - 1 do
    StringGrid.RowHeights[I] := (Height div 15) - 2;

  StringGrid.Font.Size := 24;
end;

procedure TFormResult.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close
  else if (Key = Ord('P')) and (ssCtrl in Shift) then
  begin
    if dlgPnt.Execute then
      PrintGrid;
  end;
end;

procedure TFormResult.StringGridMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if StringGrid.Font.Size >= 48 then
    Exit;
  StringGrid.Font.Size := StringGrid.Font.Size + 1;
end;

procedure TFormResult.StringGridMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if StringGrid.Font.Size <= 8 then
    Exit;
  StringGrid.Font.Size := StringGrid.Font.Size - 1;
end;

procedure TFormResult.PrintGrid;
var
  Ph, Pv, Ps: Integer;
  R, C, W, H, RH, CW: Integer;
begin
  Printer.Orientation := poLandscape;

  Ph := 300; // ×óÓÒ±ß¾à£¬ÏñËØ
  Pv := 300; // ÉÏÏÂ±ß¾à£¬ÏñËØ

  Ps := Trunc(GetDeviceCaps(Printer.Handle,LOGPIXELSX) / Screen.PixelsPerInch);

  Printer.Title := 'ÌâÄ¿';
  Printer.Canvas.Font.Size := 22;
  Printer.BeginDoc;
  try
    W := Printer.PageWidth - 2 * Ph;
    H := Printer.PageHeight - 2 * Pv;
    RH := H div StringGrid.RowCount;
    CW := W div StringGrid.ColCount;

    for R := 0 to StringGrid.RowCount - 1 do
    begin
      for C := 0 to StringGrid.ColCount - 1 do
        Printer.Canvas.TextOut(Ph + C * CW, Pv + R * RH, StringGrid.Cells[C, R]);
    end;
  finally
    Printer.EndDoc;
  end;
end;

end.
