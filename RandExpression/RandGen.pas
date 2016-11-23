unit RandGen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CnRandomExpression;

type
  TFormGenRandom = class(TForm)
    btn10AddSub2: TButton;
    btn20AddSub2: TButton;
    btn10Add2: TButton;
    btn10Sub2: TButton;
    btn20Add2: TButton;
    btn20Sub2: TButton;
    procedure btn10AddSub2Click(Sender: TObject);
    procedure GenPreSet(PreSet: TCnRandomExpressionPreSet);
    procedure btn20AddSub2Click(Sender: TObject);
    procedure btn10Add2Click(Sender: TObject);
    procedure btn10Sub2Click(Sender: TObject);
    procedure btn20Add2Click(Sender: TObject);
    procedure btn20Sub2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGenRandom: TFormGenRandom;

implementation

uses
  UnitResult;

{$R *.DFM}

procedure TFormGenRandom.GenPreSet(PreSet: TCnRandomExpressionPreSet);
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
      G.OutputExpressions(StringGrid.Cols[I], True);
    end;
    ShowModal;
    Free;
  end;
end;

procedure TFormGenRandom.btn10AddSub2Click(Sender: TObject);
begin
  GenPreSet(rep10AddSub2);
end;

procedure TFormGenRandom.btn20AddSub2Click(Sender: TObject);
begin
  GenPreSet(rep20AddSub2);
end;

procedure TFormGenRandom.btn10Add2Click(Sender: TObject);
begin
  GenPreSet(rep10Add2);
end;

procedure TFormGenRandom.btn10Sub2Click(Sender: TObject);
begin
  GenPreSet(rep10Sub2);
end;

procedure TFormGenRandom.btn20Add2Click(Sender: TObject);
begin
  GenPreSet(rep20Add2);
end;

procedure TFormGenRandom.btn20Sub2Click(Sender: TObject);
begin
  GenPreSet(rep20Sub2);
end;

procedure TFormGenRandom.FormCreate(Sender: TObject);
begin
  Application.Title := Caption;
end;

end.
