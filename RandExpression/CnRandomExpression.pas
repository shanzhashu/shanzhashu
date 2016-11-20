unit CnRandomExpression;

interface

uses
  Classes, SysUtils, Windows;

type
  TCnOperatorType = (otAdd, otSub, otMul, otDiv);

  TCnOperatorTypes = set of TCnOperatorType;

  TCnRangeType = (rtFactor, rtResult);

  TCnRandomExpression = class
  private
    FAvoidZero: Boolean;
    FUniqueInterval: Integer;
    FMaxResult: Integer;
    FMaxFactor: Integer;
    FRangeType: TCnRangeType;
    FOperatorTypes: TCnOperatorTypes;
    FFactorCount: Integer;
  public
    property FactorCount: Integer read FFactorCount write FFactorCount;
    property UniqueInterval: Integer read FUniqueInterval write FUniqueInterval;
    property AvoidZero: Boolean read FAvoidZero write FAvoidZero;
    property RangeType: TCnRangeType read FRangeType write FRangeType;
    property MaxFactor: Integer read FMaxFactor write FMaxFactor;
    property MaxResult: Integer read FMaxResult write FMaxResult;
    property OperatorTypes: TCnOperatorTypes read FOperatorTypes write FOperatorTypes;
  end;

implementation

end.
