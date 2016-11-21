unit CnRandomExpression;

interface

uses
  Classes, SysUtils, Windows, Contnrs;

type
  TCnRandomExpressionPreSet = (rep10Add2, rep20Add2, rep10Sub2, rep20Sub2);

  TCnExpressionElementType = (etFactor, etOperator, etBracket);

  TCnOperatorType = (otAdd, otSub, otMul, otDiv);

  TCnBracketType = (obLeftBracket, obRightBracket);

  TCnOperatorTypes = set of TCnOperatorType;

  TCnRangeType = (rtFactor, rtResult);

  TCnExpressionElement = class
  private
    FFactor: Integer;
    FOperatorType: TCnOperatorType;
    FElementType: TCnExpressionElementType;
    FBracketType: TCnBracketType;
  public
    function ToString: string;
    function Equals(AnEle: TCnExpressionElement): Boolean;
    
    property OperatorType: TCnOperatorType read FOperatorType write FOperatorType;
    property Factor: Integer read FFactor write FFactor;
    property BracketType: TCnBracketType read FBracketType write FBracketType;
    property ElementType: TCnExpressionElementType read FElementType write FElementType;
  end;

  TCnIntegerExpression = class
  private
    FExpressionElements: TObjectList;
    function GetLength: Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure AddFactor(Factor: Integer);
    procedure AddOperator(Op: TCnOperatorType);
    procedure AddBracket(Bracket: TCnBracketType);
  
    function ToString: string;
    function Equals(AnExpression: TCnIntegerExpression): Boolean;

    property Length: Integer read GetLength;
  end;

  TCnRandomExpressionGenerator = class
  private
    FResults: TObjectList;

    FAvoidZero: Boolean;
    FUniqueInterval: Integer;
    FMaxResult: Integer;
    FMaxFactor: Integer;
    FRangeType: TCnRangeType;
    FOperatorTypes: TCnOperatorTypes;
    FFactorCount: Integer;
    procedure SetPreSet(const Value: TCnRandomExpressionPreSet);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    
    procedure GenerateExpressions(Count: Integer);
    procedure OutputExpressions(List: TStrings);

    property FactorCount: Integer read FFactorCount write FFactorCount;
    property UniqueInterval: Integer read FUniqueInterval write FUniqueInterval;
    property AvoidZero: Boolean read FAvoidZero write FAvoidZero;
    property RangeType: TCnRangeType read FRangeType write FRangeType;
    property MaxFactor: Integer read FMaxFactor write FMaxFactor;
    property MaxResult: Integer read FMaxResult write FMaxResult;
    property OperatorTypes: TCnOperatorTypes read FOperatorTypes write FOperatorTypes;

    property PreSet: TCnRandomExpressionPreSet write SetPreSet;
  end;

implementation

const
  SCN_BRACKET_CHARS: array[Low(TCnBracketType)..High(TCnBracketType)] of Char
    = ('(', ')');

  SCN_OPERATOR_CHARS: array[Low(TCnOperatorType)..High(TCnOperatorType)] of Char
    = ('+', '-', '*', '/');

  SCN_OPERATOR_WIDECHARS: array[Low(TCnOperatorType)..High(TCnOperatorType)] of string
    = ('гл', 'гн', 'б┴', 'б┬');

{ TCnRandomExpression }

constructor TCnRandomExpressionGenerator.Create;
begin
  FResults := TObjectList.Create(True);
end;

destructor TCnRandomExpressionGenerator.Destroy;
begin
  FResults.Free;
  inherited;
end;

procedure TCnRandomExpressionGenerator.GenerateExpressions(Count: Integer);
begin

end;

procedure TCnRandomExpressionGenerator.OutputExpressions(List: TStrings);
var
  I: Integer;
begin
  if List <> nil then
  begin
    List.Clear;
    for I := 0 to FResults.Count - 1 do
      List.Add(TCnIntegerExpression(FResults[I]).ToString);
  end;
end;

procedure TCnRandomExpressionGenerator.SetPreSet(const Value: TCnRandomExpressionPreSet);
begin
  UniqueInterval := 7;
  case Value of
    rep10Add2, rep20Add2:
      begin
        FAvoidZero := True;
        FRangeType := rtResult;
        if Value = rep10Add2 then
          FMaxResult := 10
        else
          FMaxResult := 20;
      end;
    rep10Sub2, rep20Sub2:
      begin
        FAvoidZero := True;
        FRangeType := rtFactor;
        if Value = rep10Sub2 then
          FMaxFactor := 10
        else
          FMaxFactor := 20;
      end;
  end;
end;

{ TCnIntegerExpression }

procedure TCnIntegerExpression.AddBracket(Bracket: TCnBracketType);
var
  Ele: TCnExpressionElement;
begin
  Ele := TCnExpressionElement.Create;
  Ele.ElementType := etBracket;
  Ele.BracketType := Bracket;
  FExpressionElements.Add(Ele)
end;

procedure TCnIntegerExpression.AddFactor(Factor: Integer);
var
  Ele: TCnExpressionElement;
begin
  Ele := TCnExpressionElement.Create;
  Ele.ElementType := etFactor;
  Ele.Factor := Factor;
  FExpressionElements.Add(Ele);
end;

procedure TCnIntegerExpression.AddOperator(Op: TCnOperatorType);
var
  Ele: TCnExpressionElement;
begin
  Ele := TCnExpressionElement.Create;
  Ele.ElementType := etOperator;
  Ele.OperatorType := Op;
  FExpressionElements.Add(Ele);
end;

constructor TCnIntegerExpression.Create;
begin
  FExpressionElements := TObjectList.Create(True);
end;

destructor TCnIntegerExpression.Destroy;
begin
  FExpressionElements.Free;
  inherited;
end;

function TCnIntegerExpression.Equals(AnExpression: TCnIntegerExpression): Boolean;
var
  I: Integer;
begin
  Result := True;
  if (Self = nil) and (AnExpression = nil) then
    Exit;

  Result := False;
  if (Self = nil) and (AnExpression <> nil) then
    Exit;
  if (Self <> nil) and (AnExpression = nil) then
    Exit;

  if GetLength <> AnExpression.Length then
    Exit;

  for I := 0 to GetLength - 1 do
  begin
    if not TCnExpressionElement(FExpressionElements[I]).Equals(
      TCnExpressionElement(AnExpression.FExpressionElements[I])) then
      Exit;
  end;
  Result := True;
end;

function TCnIntegerExpression.GetLength: Integer;
begin
  Result := FExpressionElements.Count;
end;

function TCnIntegerExpression.ToString: string;
var
  I: Integer;
  Ele: TCnExpressionElement;
begin
  Result := '';
  for I := 0 to FExpressionElements.Count - 1 do
  begin
    Ele := TCnExpressionElement(FExpressionElements[I]);
    Result := Result + Ele.ToString;
  end;
end;

{ TCnExpressionElement }

function TCnExpressionElement.Equals(AnEle: TCnExpressionElement): Boolean;
begin
  Result := True;
  if (Self = nil) and (AnEle = nil) then
    Exit;

  Result := False;
  if (Self = nil) and (AnEle <> nil) then
    Exit;
  if (Self <> nil) and (AnEle = nil) then
    Exit;

  if FElementType <> AnEle.ElementType then
    Exit;
  case FElementType of
    etFactor:
      if FFactor <> AnEle.Factor then
        Exit;
    etOperator:
      if FOperatorType <> AnEle.OperatorType then
        Exit;
    etBracket:
      if FBracketType <> AnEle.BracketType then
        Exit;
  end;

  Result := True;
end;

function TCnExpressionElement.ToString: string;
begin
  Result := '';
  case FElementType of
    etFactor:
      Result := IntToStr(FFactor);
    etOperator:
      Result := SCN_OPERATOR_CHARS[FOperatorType];
    etBracket:
      Result := SCN_BRACKET_CHARS[FBracketType];
  end;
end;

end.
