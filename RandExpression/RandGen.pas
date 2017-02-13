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
  private
    procedure GenExpressionPreSet(PreSet: TCnRandomExpressionPreSet; WideFormat: Boolean = False);
    procedure GenComparePreSet(PreSet: TCnRandomComparePreSet);
    procedure GenEqualPreSet(PreSet: TCnRandomEqualPreset);
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

end.
