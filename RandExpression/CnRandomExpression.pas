unit CnRandomExpression;

interface

uses
  Classes, SysUtils, Windows, Contnrs, Math;

type
  TCnRandomExpressionPreSet = (rep10, rep20, rep10Add2, rep20Add2, rep10Sub2, rep20Sub2,
    rep10AddSub2, rep20AddSub2);

  TCnRandomComparePreSet = (rcp10Add2vs1, rcp20Add2vs1, rcp10Sub2vs1, rcp20Sub2vs1,
    rcp10AddSub2vs1, rcp20AddSub2vs1);

  TCnExpressionElementType = (etFactor, etOperator, etBracket);

  TCnOperatorType = (otAdd, otSub, otMul, otDiv);

  TCnCompareResult = (crGreaterThan, crEqual, crLessThan);

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
    function ToString(WideFormat: Boolean = False): string;
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

    procedure Clear;
    function ToString(WideFormat: Boolean = False): string;
    function Equals(AnExpression: TCnIntegerExpression): Boolean;

    property Length: Integer read GetLength;
  end;

  TCnRandomExpressionGenerator = class
  private
    FResults: TObjectList;

    FAvoidZeroFactor: Boolean;
    FUniqueInterval: Integer;
    FMaxResult: Integer;
    FMaxFactor: Integer;
    FRangeType: TCnRangeType;
    FOperatorTypes: TCnOperatorTypes;
    FFactorCount: Integer;
    FAvoidEqualSub: Boolean;
    FHisExprs: TStrings;
    FAppendEqual: Boolean;
    procedure SetPreSet(const Value: TCnRandomExpressionPreSet);

    function RandIntIncludeLowHigh(ALow, AHigh: Integer): Integer;
    function RandOneOperator: TCnOperatorType;
    function CheckResult(Expr: TCnIntegerExpression): Boolean;
    procedure UpdateHistory(Expr: TCnIntegerExpression);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    
    procedure GenerateExpressions(Count: Integer);
    procedure OutputExpressions(List: TStrings; WideFormat: Boolean = False);

    property FactorCount: Integer read FFactorCount write FFactorCount;
    property UniqueInterval: Integer read FUniqueInterval write FUniqueInterval;
    property AvoidZeroFactor: Boolean read FAvoidZeroFactor write FAvoidZeroFactor;
    property AvoidEqualSub: Boolean read FAvoidEqualSub write FAvoidEqualSub;
    property RangeType: TCnRangeType read FRangeType write FRangeType;
    property MaxFactor: Integer read FMaxFactor write FMaxFactor;
    property MaxResult: Integer read FMaxResult write FMaxResult;
    property OperatorTypes: TCnOperatorTypes read FOperatorTypes write FOperatorTypes;
    property AppendEqual: Boolean read FAppendEqual write FAppendEqual;

    property PreSet: TCnRandomExpressionPreSet write SetPreSet;
  end;

  TCnCompareExpression = class
  private
    FLeft: TCnIntegerExpression;
    FRight: TCnIntegerExpression;
    FCompareOperator: TCnCompareResult;
  public
    property Left: TCnIntegerExpression read FLeft write FLeft;
    property Right: TCnIntegerExpression read FRight write FRight;
    property CompareOperator: TCnCompareResult read FCompareOperator write FCompareOperator;
  end;

  TCnCompareGenerator = class
  private
    FLeft: TCnRandomExpressionGenerator;
    FRight: TCnRandomExpressionGenerator;
    procedure SetPreSet(const Value: TCnRandomComparePreSet);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure GenerateExpressions(Count: Integer);
    procedure OutputExpressions(List: TStrings; WideFormat: Boolean = False);

    property PreSet: TCnRandomComparePreSet write SetPreSet;
  end;

implementation

const
  SCN_BRACKET_CHARS: array[Low(TCnBracketType)..High(TCnBracketType)] of Char
    = ('(', ')');

  SCN_BRACKET_WIDECHARS: array[Low(TCnBracketType)..High(TCnBracketType)] of string
    = ('（', '）');

  SCN_OPERATOR_CHARS: array[Low(TCnOperatorType)..High(TCnOperatorType)] of Char
    = ('+', '-', '*', '/');

  SCN_OPERATOR_WIDECHARS: array[Low(TCnOperatorType)..High(TCnOperatorType)] of string
    = ('＋', '－', '×', '÷');

  SCN_NUMBER_WIDECHARS: array[0..9] of string =
    ('０', '１', '２', '３', '４', '５','６', '７', '８', '９');

procedure SwapInt(var I1, I2: Integer);
var
  I: Integer;
begin
  I := I1;
  I1 := I2;
  I2 := I;
end;

function EvalSimpleExpression(const Value: string): Double;
var
  Code, Temp: string;
  Loop, APos: Integer;
  Opers, Consts: TStrings; // 操作符 // 操作数
  AFlag: Boolean; // 标志上一个有用的字符是否是操作符
begin
  Result:= 0;
  AFlag:= True;
  Opers:= TStringList.Create;
  Consts:= TStringList.Create;

  try
    Code:= UpperCase(Trim(Value)); // 取公式

    while Trim(Code) <> '' do
      case Code[1] of
        '+', '-', '*', '/', '^': // 如果是操作符
          begin
            if not AFlag then
            begin
              Opers.Add(Code[1]);
              Delete(Code, 1, 1);
              Temp:= '';
              AFlag:= True; // 添加了操作符以后，置标志为True
            end
            else
            begin
              Temp:= Code[1];
              Delete(Code, 1, 1);
              AFlag:= False; // 否则置标志为False
            end;
          end;

        '0'..'9', '.': // 如果是操作数
          begin
            while Trim(Code) <> '' do
              if Code[1] in ['0'..'9', '.'] then
              begin
                Temp:= Temp + Code[1];
                Delete(Code, 1, 1);
              end
              else
                Break;
                
            Consts.Add(Temp);
            AFlag:= False; // 添加了操作数以后置标志为False
          end;

        '(':       // 如果带括号
          begin
            Delete(Code, 1, 1);  // 删除第一个左括号
            APos:= 1;            // 括号配对数，正数为找到的左括号比右括号多
            Temp:= '';
            while Trim(Code) <> '' do
              if (Pos(')', Code) > -1) and (APos > 0) then
              begin
                if Code[1] = '(' then // 如果找到的是左括号则记数加一
                  Inc(APos)
                else if Code[1] = ')' then // 如果找到右括号则记数减一
                  Dec(APos);

                Temp:= Temp + Code[1];
                Delete(Code, 1, 1);
              end
              else
                Break;

            Temp:= Copy(Temp, 1, Length(Temp) - 1); // 删除最后一个右括号
            Consts.Add(FloatToStr(EvalSimpleExpression(Temp))); // 递归调用函数本身优先计算括号内的值
            Temp:= '';
            AFlag:= False; // 添加括号以后置标志为False
          end;

        else // 忽略其它字符
          Delete(Code, 1, 1);
      end;

    if Opers.Count = 0 then // 如果没有操作符
    begin
      if Consts.Count > 0 then // 如果有操作数
        Result:= StrToFloat(Consts.Strings[0]);
      Exit;
    end
    else if Consts.Count = 0 then // 如果没有操作数
      Exit;

    Loop:= 0;
    while Opers.Count > 0 do
    begin
      if Opers.Strings[Loop] = '^' then // 如果操作符是乘方
      begin
        Consts.Strings[Loop]:= FloatToStr(Power(StrToFloat(Consts.Strings[Loop]), StrToFloat(Consts.Strings[Loop + 1])));
        Consts.Delete(Loop + 1);
        Opers.Delete(Loop);
        Loop:= 0;
      end
      else if Opers.IndexOf('^') > -1 then // 如果不是次方但是还有计算次方操作符
      begin
        Inc(Loop);
        Continue;
      end
      else if Opers.Strings[Loop][1] in ['*', '/'] then // 如果是乘/除法
        case Opers.Strings[Loop][1] of
          '*':
            begin
              Consts.Strings[Loop]:= FloatToStr(StrToFloat(Consts.Strings[Loop]) * StrToFloat(Consts.Strings[Loop + 1]));
              Consts.Delete(Loop + 1);
              Opers.Delete(Loop);
              Loop:= 0;
            end;

          '/':
            begin
              Consts.Strings[Loop]:= FloatToStr(StrToFloat(Consts.Strings[Loop]) / StrToFloat(Consts.Strings[Loop + 1]));
              Consts.Delete(Loop + 1);
              Opers.Delete(Loop);
              Loop:= 0;
            end;
        end
      else if (Opers.IndexOf('*') > -1) or (Opers.IndexOf('/') > -1) then
      begin
        Inc(Loop);
        Continue;
      end
      else if Opers.Strings[Loop][1] in ['+', '-'] then
        case Opers.Strings[Loop][1] of
          '+':
            begin
              Consts.Strings[Loop]:= FloatToStr(StrToFloat(Consts.Strings[Loop])
                + StrToFloat(Consts.Strings[Loop + 1]));
              Consts.Delete(Loop + 1);
              Opers.Delete(Loop);
              Loop:= 0;
            end;

          '-':
            begin
              Consts.Strings[Loop]:= FloatToStr(StrToFloat(Consts.Strings[Loop])
                - StrToFloat(Consts.Strings[Loop + 1]));
              Consts.Delete(Loop + 1);
              Opers.Delete(Loop);
              Loop:= 0;
            end;
        end
      else
        Inc(Loop);
    end;

    Result:= StrToFloat(Consts.Strings[0]);
  finally
    FreeAndNil(Consts);
    FreeAndNil(Opers);
  end;
end;

{ TCnRandomExpression }

function TCnRandomExpressionGenerator.CheckResult(
  Expr: TCnIntegerExpression): Boolean;
var
  Res: Double;
  S: string;
begin
  Result := False;
  if Expr <> nil then
  begin
    S := Expr.ToString;
    if FRangeType = rtResult then
    begin
      Res := EvalSimpleExpression(S);
      if Res > FMaxResult then
        Exit;
    end;

    if FHisExprs.IndexOf(S) >= 0 then
      Exit;

    Result := True;
  end;
end;

constructor TCnRandomExpressionGenerator.Create;
begin
  FResults := TObjectList.Create(True);
  FHisExprs := TStringList.Create;
end;

destructor TCnRandomExpressionGenerator.Destroy;
begin
  FHisExprs.Free;
  FResults.Free;
  inherited;
end;

procedure TCnRandomExpressionGenerator.GenerateExpressions(Count: Integer);
var
  Cnt, MinFact, MaxFact: Integer;
  Op: TCnOperatorType;
  I, F1, F2: Integer;
  AnExpr: TCnIntegerExpression;

  procedure CleanExpression;
  begin
    if AnExpr <> nil then
      AnExpr.Clear;
    FreeAndNil(AnExpr);
  end;

begin
  // Randomize;

  Cnt := 0;
  FResults.Clear;
  FHisExprs.Clear;
  if FFactorCount < 1 then
    raise Exception.Create('No Enough Factors.');

  if (FFactorCount > 1) and (FOperatorTypes = []) then
    raise Exception.Create('No Operators.');

  if FAvoidZeroFactor then
    MinFact := 1
  else
    MinFact := 0;

  MaxFact := FMaxFactor;

  while True do
  begin
    AnExpr := TCnIntegerExpression.Create;
    if FFactorCount = 1 then
    begin
      AnExpr.AddFactor(RandIntIncludeLowHigh(MinFact, MaxFact));
    end
    else if FFactorCount = 2 then
    begin
      Op := RandOneOperator;
      F1 := RandIntIncludeLowHigh(MinFact, MaxFact);
      F2 := RandIntIncludeLowHigh(MinFact, MaxFact);
      if (Op = otSub) and (F1 < F2) then
        SwapInt(F1, F2);

      AnExpr.AddFactor(F1);
      AnExpr.AddOperator(Op);
      AnExpr.AddFactor(F2);
    end
    else
    begin
      for I := 1 to FFactorCount - 1 do
      begin
        AnExpr.AddFactor(RandIntIncludeLowHigh(MinFact, MaxFact));
        AnExpr.AddOperator(RandOneOperator);
      end;
      AnExpr.AddFactor(RandIntIncludeLowHigh(MinFact, MaxFact));
    end;

    // 检查生成的单个结果是否合格
    if not CheckResult(AnExpr) then
    begin
      CleanExpression;
      Continue;
    end;

    // 生成成功后
    FResults.Add(AnExpr);
    UpdateHistory(AnExpr);
    Inc(Cnt);
    if Cnt = Count then
      Exit;
  end;
end;

procedure TCnRandomExpressionGenerator.OutputExpressions(List: TStrings;
  WideFormat: Boolean);
var
  I: Integer;
  S: string;
begin
  if List <> nil then
  begin
    List.Clear;
    for I := 0 to FResults.Count - 1 do
    begin
      S := TCnIntegerExpression(FResults[I]).ToString(WideFormat);
      if FAppendEqual then
      begin
        if WideFormat then
          S := S + '＝'
        else
          S := S + '=';
      end;
      List.Add(S);
    end;
  end;
end;

function TCnRandomExpressionGenerator.RandIntIncludeLowHigh(ALow,
  AHigh: Integer): Integer;
begin
  if ALow > AHigh then
    SwapInt(ALow, AHigh);

  Result := ALow + Trunc(Random(AHigh + 1));
  if Result > AHigh then
    Result := AHigh;
end;

function TCnRandomExpressionGenerator.RandOneOperator: TCnOperatorType;
var
  Rnd: Integer;
begin
  if FOperatorTypes = [] then
    raise Exception.Create('No Operators.');

  repeat
    Rnd := RandIntIncludeLowHigh(Ord(Low(TCnOperatorType)), Ord(High(TCnOperatorType)));
    if TCnOperatorType(Rnd) in FOperatorTypes then
      Break;
  until False;

  Result := TCnOperatorType(Rnd);
end;

procedure TCnRandomExpressionGenerator.SetPreSet(const Value: TCnRandomExpressionPreSet);
begin
  UniqueInterval := 7;
  if Value in [rep10, rep20] then
  begin
    FFactorCount := 1;
    if Value = rep10 then
      FMaxFactor := 10
    else
      FMaxFactor := 20;
    Exit;
  end;

  FFactorCount := 2;
  case Value of
    rep10Add2, rep20Add2:
      begin
        FOperatorTypes := [otAdd];
        FAvoidZeroFactor := True;
        FRangeType := rtResult;
        if Value = rep10Add2 then
          FMaxResult := 10
        else
          FMaxResult := 20;
        FMaxFactor := FMaxResult;
      end;
    rep10Sub2, rep20Sub2:
      begin
        FOperatorTypes := [otSub];
        FAvoidZeroFactor := True;
        FRangeType := rtFactor;
        if Value = rep10Sub2 then
          FMaxFactor := 10
        else
          FMaxFactor := 20;
        FMaxResult := FMaxFactor;
      end;
    rep10AddSub2, rep20AddSub2:
      begin
        FOperatorTypes := [otAdd, otSub];
        FAvoidZeroFactor := True;
        FRangeType := rtResult;
        if Value = rep10AddSub2 then
          FMaxResult := 10
        else
          FMaxResult := 20;
        FMaxFactor := FMaxResult;
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

procedure TCnIntegerExpression.Clear;
begin
  FExpressionElements.Clear;
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

function TCnIntegerExpression.ToString(WideFormat: Boolean): string;
var
  I: Integer;
  Ele: TCnExpressionElement;
begin
  Result := '';
  for I := 0 to FExpressionElements.Count - 1 do
  begin
    Ele := TCnExpressionElement(FExpressionElements[I]);
    Result := Result + Ele.ToString(WideFormat);
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

function TCnExpressionElement.ToString(WideFormat: Boolean): string;
var
  I: Integer;
begin
  Result := '';
  if WideFormat then
  begin
    case FElementType of
      etFactor:
        begin
          Result := IntToStr(FFactor);
          for I := 0 to 9 do
            Result := StringReplace(Result, IntToStr(I), SCN_NUMBER_WIDECHARS[I], [rfReplaceAll]);
        end;
      etOperator:
        Result := SCN_OPERATOR_WIDECHARS[FOperatorType];
      etBracket:
        Result := SCN_BRACKET_WIDECHARS[FBracketType];
    end;
  end
  else
  begin
    case FElementType of
      etFactor:
        Result := IntToStr(FFactor);
      etOperator:
        Result := SCN_OPERATOR_CHARS[FOperatorType];
      etBracket:
        Result := SCN_BRACKET_CHARS[FBracketType];
    end;
  end;
end;

procedure TCnRandomExpressionGenerator.UpdateHistory(
  Expr: TCnIntegerExpression);
var
  I: Integer;
begin
  if (Expr = nil) or (FUniqueInterval <= 0) then
    Exit;

  if FHisExprs.Count >= FUniqueInterval then
    for I := 0 to FHisExprs.Count - FUniqueInterval do
      FHisExprs.Delete(FHisExprs.Count - 1);

  FHisExprs.Add(Expr.ToString);
end;

{ TCnCompareGenerator }

constructor TCnCompareGenerator.Create;
begin
  FLeft := TCnRandomExpressionGenerator.Create;
  FRight := TCnRandomExpressionGenerator.Create;
end;

destructor TCnCompareGenerator.Destroy;
begin
  FLeft.Free;
  FRight.Free;
  inherited;
end;

procedure TCnCompareGenerator.GenerateExpressions(Count: Integer);
begin
  FLeft.GenerateExpressions(Count);
  FRight.GenerateExpressions(Count);
end;

procedure TCnCompareGenerator.OutputExpressions(List: TStrings;
  WideFormat: Boolean);
var
  L1, L2: TStrings;
  I: Integer;
begin
  if List = nil then
    Exit;

  L1 := nil;
  L2 := nil;
  try
    L1 := TStringList.Create;
    L2 := TStringList.Create;
    FLeft.OutputExpressions(L1, WideFormat);
    FRight.OutputExpressions(L2, WideFormat);
    if L1.Count <> L2.Count then
      raise Exception.Create('Generate Error.');

    List.Clear;
    for I := 0 to L1.Count - 1 do
      List.Add(L1[I] + '  ' + L2[I]);
  finally
    L1.Free;
    L2.Free;
  end;
end;

procedure TCnCompareGenerator.SetPreSet(const Value: TCnRandomComparePreSet);
begin
  case Value of
    rcp10Add2vs1:
      begin
        FLeft.SetPreSet(rep10Add2);
        FRight.SetPreSet(rep10);
      end;
    rcp20Add2vs1:
      begin
        FLeft.SetPreSet(rep20Add2);
        FRight.SetPreSet(rep20);
      end;
    rcp10Sub2vs1:
      begin
        FLeft.SetPreSet(rep10Sub2);
        FRight.SetPreSet(rep10);
      end;
    rcp20Sub2vs1:
      begin
        FLeft.SetPreSet(rep20Sub2);
        FRight.SetPreSet(rep20);
      end;
    rcp10AddSub2vs1:
      begin
        FLeft.SetPreSet(rep10AddSub2);
        FRight.SetPreSet(rep10);
      end;
    rcp20AddSub2vs1:
      begin
        FLeft.SetPreSet(rep20AddSub2);
        FRight.SetPreSet(rep20);
      end;
  end;
end;

end.
