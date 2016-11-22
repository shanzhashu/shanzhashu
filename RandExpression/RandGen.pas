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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGenRandom: TFormGenRandom;

implementation

uses
  CnRandomExpression;

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

end.
