unit RandGen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFormGenRandom = class(TForm)
    btnPreset: TButton;
    btnGen: TButton;
    mmoRes: TMemo;
    procedure btnGenClick(Sender: TObject);
    procedure btnPresetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGenRandom: TFormGenRandom;

implementation

uses
  CnRandomExpression, UnitResult;

{$R *.DFM}

procedure TFormGenRandom.btnGenClick(Sender: TObject);
var
  G: TCnRandomExpressionGenerator;
begin
  G := TCnRandomExpressionGenerator.Create;
  G.PreSet := rep10AddSub2;
  G.GenerateExpressions(50);
  G.OutputExpressions(mmoRes.Lines);
  G.Free;
end;

procedure TFormGenRandom.btnPresetClick(Sender: TObject);
var
  I: Integer;
  G: TCnRandomExpressionGenerator;
begin
  with TFormResult.Create(nil) do
  begin
    G := TCnRandomExpressionGenerator.Create;
    G.PreSet := rep10AddSub2;
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

end.
