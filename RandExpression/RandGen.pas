unit RandGen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CnRandomExpression, ExtCtrls;

type
  TFormGenRandom = class(TForm)
    btn10AddSub2: TButton;
    btn20AddSub2: TButton;
    btn10Add2: TButton;
    btn10Sub2: TButton;
    btn20Add2: TButton;
    btn20Sub2: TButton;
    bvl1: TBevel;
    btnCompare10Add2vs1: TButton;
    btnCompare20AddSub2vs1: TButton;
    btn10AddSub2vs2: TButton;
    btn20AddSub2vs2: TButton;
    bvl2: TBevel;
    btnEqual10AddSub2vs2: TButton;
    btnEqual20AddSub2vs2: TButton;
    btnMulti10: TButton;
    bvl3: TBevel;
    btnDiv100: TButton;
    btn10MulDiv2: TButton;
    btn100AddSub2: TButton;
    btn10DivMod2: TButton;
    procedure btn10AddSub2Click(Sender: TObject);
    procedure btn20AddSub2Click(Sender: TObject);
    procedure btn10Add2Click(Sender: TObject);
    procedure btn10Sub2Click(Sender: TObject);
    procedure btn20Add2Click(Sender: TObject);
    procedure btn20Sub2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure btnCompare10Add2vs1Click(Sender: TObject);
    procedure btn10AddSub2vs2Click(Sender: TObject);
    procedure btn20AddSub2vs2Click(Sender: TObject);
    procedure btnEqual20AddSub2vs2Click(Sender: TObject);
    procedure btnEqual10AddSub2vs2Click(Sender: TObject);
    procedure btnCompare20AddSub2vs1Click(Sender: TObject);
    procedure btnMulti10Click(Sender: TObject);
    procedure btnDiv100Click(Sender: TObject);
    procedure btn10MulDiv2Click(Sender: TObject);
    procedure btn100AddSub2Click(Sender: TObject);
    procedure btn10DivMod2Click(Sender: TObject);
  private
    procedure GenExpressionPreSet(PreSet: TCnRandomExpressionPreSet; WideFormat: Boolean = False);
    procedure GenComparePreSet(PreSet: TCnRandomComparePreSet);
    procedure GenEqualPreSet(PreSet: TCnRandomEqualPreset);

    procedure ExpressionGenerated(Sender: TObject; Expr: TCnIntegerExpression);
    // 二项除法，实现是乘法，在这儿逆运算一次
  public
    { Public declarations }
  end;

var
  FormGenRandom: TFormGenRandom;

implementation

uses
  UnitResult;

{$R *.DFM}

procedure TFormGenRandom.GenExpressionPreSet(PreSet: TCnRandomExpressionPreSet;
  WideFormat: Boolean);
var
  I: Integer;
  G: TCnRandomExpressionGenerator;
begin
  with TFormResult.Create(nil) do
  begin
    G := TCnRandomExpressionGenerator.Create;
    G.PreSet := PreSet;
    G.AppendEqual := True;
    G.OnExpressionGenerated := ExpressionGenerated;
    Randomize;

    for I := 0 to StringGrid.ColCount - 1 do
    begin
      G.GenerateExpressions(StringGrid.RowCount);
      G.OutputExpressions(StringGrid.Cols[I], WideFormat);
    end;
    ShowModal;
    Free;
  end;
end;

procedure TFormGenRandom.btn10AddSub2Click(Sender: TObject);
begin
  GenExpressionPreSet(rep10AddSub2);
end;

procedure TFormGenRandom.btn20AddSub2Click(Sender: TObject);
begin
  GenExpressionPreSet(rep20AddSub2);
end;

procedure TFormGenRandom.btn10Add2Click(Sender: TObject);
begin
  GenExpressionPreSet(rep10Add2);
end;

procedure TFormGenRandom.btn10Sub2Click(Sender: TObject);
begin
  GenExpressionPreSet(rep10Sub2);
end;

procedure TFormGenRandom.btn20Add2Click(Sender: TObject);
begin
  GenExpressionPreSet(rep20Add2);
end;

procedure TFormGenRandom.btn20Sub2Click(Sender: TObject);
begin
  GenExpressionPreSet(rep20Sub2);
end;

procedure TFormGenRandom.FormCreate(Sender: TObject);
begin
  Application.Title := Caption;
end;

procedure TFormGenRandom.FormClick(Sender: TObject);
begin
  // for test
end;

procedure TFormGenRandom.GenComparePreSet(PreSet: TCnRandomComparePreSet);
var
  G: TCnCompareGenerator;
  I: Integer;
begin
  with TFormResult.Create(nil) do
  begin
    G := TCnCompareGenerator.Create;
    G.PreSet := PreSet;
    Randomize;

    for I := 0 to StringGrid.ColCount - 1 do
    begin
      G.GenerateExpressions(StringGrid.RowCount);
      G.OutputExpressions(StringGrid.Cols[I], False);
    end;
    ShowModal;
    Free;
  end;
end;

procedure TFormGenRandom.btnCompare10Add2vs1Click(Sender: TObject);
begin
  GenComparePreSet(rcp10AddSub2vs1);
end;

procedure TFormGenRandom.btn10AddSub2vs2Click(Sender: TObject);
begin
  GenComparePreSet(rcp10AddSub2vs2);
end;

procedure TFormGenRandom.btn20AddSub2vs2Click(Sender: TObject);
begin
  GenComparePreSet(rcp20AddSub2vs2);
end;

procedure TFormGenRandom.GenEqualPreSet(PreSet: TCnRandomEqualPreset);
var
  G: TCnEqualGenerator;
  I: Integer;
begin
  with TFormResult.Create(nil) do
  begin
    G := TCnEqualGenerator.Create;
    G.PreSet := PreSet;
    Randomize;

    for I := 0 to StringGrid.ColCount - 1 do
    begin
      G.GenerateExpressions(StringGrid.RowCount);
      G.TrimRandomOneFactor;
      G.OutputExpressions(StringGrid.Cols[I], False);
    end;
    ShowModal;
    Free;
  end;
end;

procedure TFormGenRandom.btnEqual20AddSub2vs2Click(Sender: TObject);
begin
  GenEqualPreSet(rqp10AddSub2vs2);
end;

procedure TFormGenRandom.btnEqual10AddSub2vs2Click(Sender: TObject);
begin
  GenEqualPreSet(rqp20AddSub2vs2);
end;

procedure TFormGenRandom.btnCompare20AddSub2vs1Click(Sender: TObject);
begin
  GenComparePreSet(rcp20AddSub2vs1);
end;

procedure TFormGenRandom.btnMulti10Click(Sender: TObject);
begin
  GenExpressionPreSet(rep10Multiple2, True);
end;

procedure TFormGenRandom.ExpressionGenerated(Sender: TObject;
  Expr: TCnIntegerExpression);
var
  S: string;
  T: Integer;
begin
  if ((Sender as TCnRandomExpressionGenerator).PreSet = rep10Div2) or
    (((Sender as TCnRandomExpressionGenerator).PreSet = rep10MulDiv2) and
     ((Sender as TCnRandomExpressionGenerator).ResultsCount mod 2 = 1)) then
  begin
    if (Expr.Length = 3) and
      (Expr.Elements[0].ElementType = etFactor) and
      ((Expr.Elements[1].ElementType = etOperator) and (Expr.Elements[1].OperatorType = otMul))
      and (Expr.Elements[2].ElementType = etFactor) then
    begin
      S := Expr.ToString;
      T := Trunc(EvalSimpleExpression(S));
      Expr.Elements[1].OperatorType := otDiv;
      Expr.Elements[0].Factor := T;
    end;
  end;
end;

procedure TFormGenRandom.btnDiv100Click(Sender: TObject);
begin
  GenExpressionPreSet(rep10Div2, True);
end;

procedure TFormGenRandom.btn10MulDiv2Click(Sender: TObject);
begin
  GenExpressionPreSet(rep10MulDiv2, True);
end;

procedure TFormGenRandom.btn100AddSub2Click(Sender: TObject);
begin
  GenExpressionPreSet(rep100AddSub2, False);
end;

procedure TFormGenRandom.btn10DivMod2Click(Sender: TObject);
begin
  GenExpressionPreSet(rep10DivMod2, False);
end;

end.
