unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Math, StdCtrls;

type
  THitMode = (hmLine, hmCurve); // ֱ�߰�����߰�

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
    PathPts: array of TPoint;
    TypePts: array of Byte;
    // OldX, OldY: Integer; // ��һ��������ļ������꣬��������
    FMouseLeftDown: Boolean;
    procedure ReCreateBmp;
    procedure InitConsts;
    procedure CalcConstants;
    procedure DrawAxies;

    procedure ConvertPaintXYToCalcXY(var X, Y: Integer);
    // ��������ϵ����������ϵ
    procedure ConvertCalcXYToPaintXY(var X, Y: Integer);
    // ��������ϵ����������ϵ

    procedure DrawHitLine(X, Y: Integer; Path: Boolean = False);
    // ���������߻�����������ߣ�����Ϊ��������

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
  SetLength(PathPts, 0);
  SetLength(TypePts, 0);
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

    // ��������
    X1 := Trunc(-R);      // ���ε�����������Բ��
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

    // ��������
    X1 := -Trunc(L); // ���ε�����������Բ��
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

    // ��������
    X1 := -Trunc(D); // ���ε�����������Բ��
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

    // ������
    X1 := - Trunc(W) div 2;
    Y1 := Trunc(D + P + H);
    X2 := Trunc(W) div 2;
    Y2 := Trunc(D + P);

    ConvertCalcXYToPaintXY(X1, Y1);
    ConvertCalcXYToPaintXY(X2, Y2);
    Rc := Rect(X1, Y1, X2, Y2);
    Brush.Color := clWhite;
    FillRect(Rc);

    // ����
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

  ParamsToUI;
end;

procedure TFormHit.DrawHitLine(X, Y: Integer; Path: Boolean);
var
  St1, St2, r1, r2: Double;
  XL, YL, XK, YK: Integer;
begin
  if Y >= 0 then
    Exit;

  // ����������ļ�����
  St1 := ArcTan2(X, -Y);
  if St1 > SiTa then
    St1 := Sita;
  if St1 < -SiTa then
    St1 := -Sita;

  r1 := Sqrt(X * X + Y * Y);
  if r1 > R then
    r1 := R;

  // һ������ӳ������ص�ļ�����
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
    // Pen.Mode := pmXor;

    Pen.Color := clRed;
    ConvertCalcXYToPaintXY(X, Y);
    MoveTo(X, Y);    // �Ƶ�������

    X := 0;
    Y := 0;
    ConvertCalcXYToPaintXY(X, Y);
    LineTo(X, Y);    // ����ԭ��

    if FHitMode = hmCurve then
    begin
      Pen.Color := clTeal;
      ConvertCalcXYToPaintXY(XK, YK);

      LineTo(XK, YK);  // �������Ƶ�
      MoveTo(X, Y);    // �ֻص�ԭ��
    end;

    if Path and (FHitMode = hmLine) then
      BeginPath(Handle);
    Pen.Color := clGray;
    ConvertCalcXYToPaintXY(XL, YL);
    LineTo(XL, YL);  // ������ص�
    if Path and (FHitMode = hmLine) then // ����ԭ�㵽��ص��ֱ�� Path
      EndPath(Handle);

    if FHitMode = hmCurve then
    begin
      if Path then
        BeginPath(Handle);
      CurPts[0].X := XK;
      CurPts[0].Y := YK;
      CurPts[1].X := XK;
      CurPts[1].Y := YK;
      CurPts[2].X := XL;
      CurPts[2].Y := YL;

      MoveTo(X, Y);    // �ֻص�ԭ��
      PolyBezierTo(CurPts); // ����������������Ҫ�����ĸ���
      if Path then
        EndPath(Handle);    // ����ԭ�㵽��ص�ı��������� Path
    end;

    if Path then
    begin
      FlattenPath(Handle);

      XK := 0;
      YK := 0;
      XL := GetPath(Handle, XK, YK, 0);

      if XL > 0 then
      begin
        SetLength(PathPts, XL);
        SetLength(TypePts, XL);
        GetPath(Handle, PathPts[0], TypePts[0], XL);
      end;
    end;
  end;
end;

procedure TFormHit.pbHitMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    FMouseLeftDown := True;
    ConvertPaintXYToCalcXY(X, Y);
    DrawAxies;

    DrawHitLine(X, Y, False);
    pbHit.Invalidate;
  end;
end;

procedure TFormHit.pbHitMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I, O, K: Integer;
  X1, Y1, X2, Y2: Integer;
begin
  if Button = mbLeft then
  begin
    FMouseLeftDown := False;

    ConvertPaintXYToCalcXY(X, Y);
    DrawAxies;
    DrawHitLine(X, Y, True);

    // DrawHitLine ���õ� Path ��
    FPaintBmp.Canvas.Brush.Style := bsSolid;
    FPaintBmp.Canvas.Brush.Color := clRed;
    FPaintBmp.Canvas.Pen.Style := psClear;

    if High(PathPts) = 1 then
    begin
      // ��ֱ�ߣ���Ҫ��ֵ�� 17 ��
      X1 := PathPts[0].X;
      Y1 := PathPts[0].Y;
      X2 := PathPts[1].X;
      Y2 := PathPts[1].Y;

      SetLength(PathPts, 17);
      PathPts[Low(PathPts)].X := X1;
      PathPts[Low(PathPts)].Y := Y1;
      PathPts[High(PathPts)].X := X2;
      PathPts[High(PathPts)].Y := Y2;

      for I := Low(PathPts) + 1 to High(PathPts) - 1 do
      begin
        PathPts[I].X := X1 + Trunc(I * (X2 - X1) / (High(PathPts) - Low(PathPts)));
        PathPts[I].Y := Y1 + Trunc(I * (Y2 - Y1) / (High(PathPts) - Low(PathPts)));
      end;
    end;

    K := High(PathPts) div 2;
    for I := Low(PathPts) to High(PathPts) do
    begin
      O := Abs(I - K); // Խ����ʼ������Խ��
      O := 3 + Abs(K - O);      // Խ����ʼ������ԽС

      FPaintBmp.Canvas.Ellipse(PathPts[I].X - O, PathPts[I].Y - O,
        PathPts[I].X + O, PathPts[I].Y + O);
    end;
    pbHit.Invalidate;
  end;
end;

procedure TFormHit.pbHitMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if FMouseLeftDown then
  begin
    ConvertPaintXYToCalcXY(X, Y);
    DrawAxies;
    DrawHitLine(X, Y, False);
    pbHit.Invalidate;
  end;
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
    SiTa := StrToInt(edtSita.Text) * Pi / 180  // ������ʮ���
  else
    Sita := Pi / 2;        // ���Ҿ�ʮ��
end;

procedure TFormHit.btnApplyClick(Sender: TObject);
begin
  InitConsts;
  CalcConstants;
  DrawAxies;
  pbHit.Invalidate;
end;

end.
