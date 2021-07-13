unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Math, StdCtrls;

type
  THitMode = (hmLine, hmCurve); // 直线版和曲线版

  TFormHit = class(TForm)
    pbHit: TPaintBox;
    rgHitMode: TRadioGroup;
    grpParam: TGroupBox;
    lblR: TLabel;
    edtR: TEdit;
    lblSita: TLabel;
    edtSita: TEdit;
    lblW: TLabel;
    lblH: TLabel;
    edtW: TEdit;
    edtH: TEdit;
    chkW: TCheckBox;
    lblDegree: TLabel;
    lblD: TLabel;
    edtD: TEdit;
    lblP: TLabel;
    edtP: TEdit;
    btnApply: TButton;
    lblB: TLabel;
    edtB: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pbHitPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pbHitClick(Sender: TObject);
    procedure pbHitMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbHitMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbHitMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure rgHitModeClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    FPaintBmp: TBitmap;
    FHitMode: THitMode;

    R, H, W, D, P, SiTa, B: Double;
    AFa, L: Double;
    DeltaX, DeltaY: Integer;
    CurPts: array of TPoint;
    OldX, OldY: Integer; // 上一个蓄力点的计算坐标，供擦除用
    FMouseLeftDown: Boolean;
    procedure ReCreateBmp;
    procedure InitConsts;
    procedure CalcConstants;
    procedure DrawAxies;

    procedure ConvertPaintXYToCalcXY(var X, Y: Integer);
    // 计算坐标系到绘制坐标系
    procedure ConvertCalcXYToPaintXY(var X, Y: Integer);
    // 绘制坐标系到计算坐标系

    procedure DrawHitLine(X, Y: Integer; Erase: Boolean);
    // 画弹道曲线或擦除弹道曲线，参数为计算坐标，画时会更新 OldX、OldY

    procedure ParamsToUI;
  public
    { Public declarations }
  end;

var
  FormHit: TFormHit;

implementation

{$R *.dfm}

const
  Pi = 3.14159265359;

procedure TFormHit.FormCreate(Sender: TObject);
begin
  ReCreateBmp;
  InitConsts;
  CalcConstants;
  DrawAxies;
  SetLength(CurPts, 3);

  FHitMode := hmCurve;
  rgHitMode.ItemIndex := Ord(FHitMode);

  ParamsToUI;
end;

procedure TFormHit.ReCreateBmp;
begin
  FreeAndNil(FPaintBmp);

  FPaintBmp := TBitmap.Create;
  FPaintBmp.PixelFormat := pf24bit;
  FPaintBmp.Height := pbHit.Height;
  FPaintBmp.Width := pbHit.Width;
end;

procedure TFormHit.FormDestroy(Sender: TObject);
begin
  SetLength(CurPts, 0);
  FPaintBmp.Free;
end;

procedure TFormHit.pbHitPaint(Sender: TObject);
begin
  if FPaintBmp <> nil then
    pbHit.Canvas.Draw(0, 0, FPaintBmp);
end;

procedure TFormHit.CalcConstants;
begin
  L := Sqrt((D + P + H) * (D + P + H) + (W * W / 4));
  AFa := Arctan2(W, (D + P) * 2);

  DeltaX := FPaintBmp.Width div 2;
  DeltaY := Trunc(FPaintBmp.Height - R - B);
  OldX := 0;
  OldY := 0;
end;

procedure TFormHit.DrawAxies;
var
  Rc: TRect;
  X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer;
begin
  Rc := Rect(0, 0, FPaintBmp.Width, FPaintBmp.Height);

  with FPaintBmp.Canvas do
  begin
    Brush.Color := clWhite;
    Brush.Style := bsSolid;
    Pen.Mode := pmCopy;
    FillRect(Rc);

    Pen.Width := 1;
    Pen.Style := psSolid;
    Pen.Color := clNavy;

    // 画蓄力区
    X1 := Trunc(-R);      // 矩形的中央是扇形圆心
    Y1 := Trunc(R);
    X2 := Trunc(R);
    Y2 := Trunc(-R);

    X3 := -Trunc(Sin(SiTa) * R);
    Y3 := -Trunc(Cos(SiTa) * R);
    X4 := Trunc(Sin(SiTa) * R);
    Y4 := -Trunc(Cos(SiTa) * R);

    ConvertCalcXYToPaintXY(X1, Y1);
    ConvertCalcXYToPaintXY(X2, Y2);
    ConvertCalcXYToPaintXY(X3, Y3);
    ConvertCalcXYToPaintXY(X4, Y4);

    Brush.Color := clYellow;
    Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4);

    // 画绿外扇
    X1 := -Trunc(L); // 矩形的中央是扇形圆心
    Y1 := Trunc(L);
    X2 := Trunc(L);
    Y2 := -Trunc(L);

    X3 := Trunc(W) div 2;
    Y3 := Trunc(D + P);
    X4 := - Trunc(W) div 2;
    Y4 := Trunc(D + P);

    ConvertCalcXYToPaintXY(X1, Y1);
    ConvertCalcXYToPaintXY(X2, Y2);
    ConvertCalcXYToPaintXY(X3, Y3);
    ConvertCalcXYToPaintXY(X4, Y4);

    Brush.Color := clMoneyGreen;
    Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4);

    // 画白内扇
    X1 := -Trunc(D); // 矩形的中央是扇形圆心
    Y1 := Trunc(D);
    X2 := Trunc(D);
    Y2 := -Trunc(D);

    X3 := Trunc(W) div 2;
    Y3 := Trunc(D + P);
    X4 := - Trunc(W) div 2;
    Y4 := Trunc(D + P);

    ConvertCalcXYToPaintXY(X1, Y1);
    ConvertCalcXYToPaintXY(X2, Y2);
    ConvertCalcXYToPaintXY(X3, Y3);
    ConvertCalcXYToPaintXY(X4, Y4);
    Brush.Color := clWhite;
    Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4);

    // 画鸡区
    X1 := - Trunc(W) div 2;
    Y1 := Trunc(D + P + H);
    X2 := Trunc(W) div 2;
    Y2 := Trunc(D + P);

    ConvertCalcXYToPaintXY(X1, Y1);
    ConvertCalcXYToPaintXY(X2, Y2);
    Rc := Rect(X1, Y1, X2, Y2);
    Brush.Color := clWhite;
    FillRect(Rc);

    // 画轴
    MoveTo(DeltaX, 0);
    LineTo(DeltaX, FPaintBmp.Height);
    MoveTo(0, DeltaY);
    LineTo(FPaintBmp.Width, DeltaY);
  end;
end;

procedure TFormHit.ConvertCalcXYToPaintXY(var X, Y: Integer);
begin
  X := X + DeltaX;
  Y := DeltaY - Y;
end;

procedure TFormHit.ConvertPaintXYToCalcXY(var X, Y: Integer);
begin
  X := X - DeltaX;
  Y := DeltaY - Y;
end;

procedure TFormHit.FormResize(Sender: TObject);
begin
  ReCreateBmp;
  InitConsts;
  CalcConstants;
  DrawAxies;
  pbHit.Invalidate;
end;

procedure TFormHit.DrawHitLine(X, Y: Integer; Erase: Boolean);
var
  St1, St2, r1, r2: Double;
  XL, YL, XK, YK: Integer;
begin
  if Y >= 0 then
    Exit;

  if not Erase then
  begin
    OldX := X;
    OldY := Y;
  end;

  // 计算蓄力点的极坐标
  St1 := ArcTan2(X, -Y);
  if St1 > SiTa then
    St1 := Sita;
  if St1 < -SiTa then
    St1 := -Sita;

  r1 := Sqrt(X * X + Y * Y);
  if r1 > R then
    r1 := R;

  // 一次线性映射至落地点的极坐标
  if FHitMode = hmCurve then
    St2 := - St1 * AFa / Sita
  else
    St2 := -St1;

  r2 := D + r1 * (L - D) / R;

  XL := Trunc(r2 * Sin(St2));
  YL := Trunc(r2 * Cos(St2));

  XK := Trunc(r2 * Sin(-St1) / 2);
  YK := Trunc(r2 * Cos(St1) / 2);

  with FPaintBmp.Canvas do
  begin
    Pen.Style := psSolid;
    Pen.Mode := pmXor;

    Pen.Color := clRed;
    ConvertCalcXYToPaintXY(X, Y);
    MoveTo(X, Y);    // 移到蓄力点

    X := 0;
    Y := 0;
    ConvertCalcXYToPaintXY(X, Y);
    LineTo(X, Y);    // 画到原点

    if FHitMode = hmCurve then
    begin
      Pen.Color := clTeal;
      ConvertCalcXYToPaintXY(XK, YK);

      LineTo(XK, YK);  // 画到控制点
      MoveTo(X, Y);    // 又回到原点
    end;

    Pen.Color := clGray;
    ConvertCalcXYToPaintXY(XL, YL);
    LineTo(XL, YL);  // 画到落地点

    if FHitMode = hmCurve then
    begin
      CurPts[0].X := XK;
      CurPts[0].Y := YK;
      CurPts[1].X := XK;
      CurPts[1].Y := YK;
      CurPts[2].X := XL;
      CurPts[2].Y := YL;

      MoveTo(X, Y);    // 又回到原点
      PolyBezierTo(CurPts); // 贝塞尔曲线这里需要至少四个点
    end;
  end;
end;

procedure TFormHit.pbHitClick(Sender: TObject);
var
  Pt: TPoint;
begin
  Pt := pbHit.ScreenToClient(Mouse.CursorPos);
  ConvertPaintXYToCalcXY(Pt.x, Pt.y);
  DrawHitLine(OldX, OldY, True);
  DrawHitLine(Pt.x, Pt.y, False);
  pbHit.Invalidate;
end;

procedure TFormHit.pbHitMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    FMouseLeftDown := True;
    ConvertPaintXYToCalcXY(X, Y);
    DrawHitLine(OldX, OldY, True);
    DrawHitLine(X, Y, False);
    pbHit.Invalidate;
  end;
end;

procedure TFormHit.pbHitMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    FMouseLeftDown := False;
end;

procedure TFormHit.pbHitMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
//  if FMouseLeftDown then
//  begin
//    if (X <> OldX) or (Y <> OldY) then
//    begin
//      DrawHitLine(OldX, OldY, True);
//      DrawHitLine(X, Y, False);
//      pbHit.Invalidate;
//    end;
//  end;
end;

procedure TFormHit.rgHitModeClick(Sender: TObject);
begin
  FHitMode := THitMode(rgHitMode.ItemIndex);
  InitConsts;
  CalcConstants;
  DrawAxies;
  pbHit.Invalidate;
end;

procedure TFormHit.ParamsToUI;
begin
  edtR.Text := FloatToStr(R);
  edtW.Text := FloatToStr(W);
  edtH.Text := FloatToStr(H);
  edtP.Text := FloatToStr(P);
  edtSita.Text := FloatToStr(Sita * 180 / Pi);
  edtD.Text := FloatToStr(D);
end;

procedure TFormHit.InitConsts;
begin
  R := StrToInt(edtR.Text); // 100;
  H := StrToInt(edtH.Text); // 150;
  if chkW.Checked then
    W := pbHit.Width
  else
    W := StrToInt(edtW.Text);

  D := StrToInt(edtD.Text); // 100;
  P := StrToInt(edtP.Text); // 50

  B := StrToInt(edtB.Text); // 50

  if FHitMode = hmCurve then
    SiTa := StrToInt(edtSita.Text) * Pi / 180  // 左右七十五度
  else
    Sita := Pi / 2;        // 左右九十度
end;

procedure TFormHit.btnApplyClick(Sender: TObject);
begin
  InitConsts;
  CalcConstants;
  DrawAxies;
  pbHit.Invalidate;
end;

end.
