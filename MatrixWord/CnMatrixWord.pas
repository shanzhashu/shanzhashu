unit CnMatrixWord;

interface

uses
  SysUtils, Classes, Windows, Grids;

type
  TCnSearchDirection = (sdUp, sdUpLeft, sdLeft, sdLeftDown, sdDown, sdDownRight, sdRight, sdRightUp);

  TCnSearchDirections = set of TCnSearchDirection;

  TCnSearchResult = array of TPoint;

  TCnMatrixWord = class(TObject)
  private
    FWidth: Integer;
    FHeight: Integer;
    FChars: TStrings;
    FSearchDirections: TCnSearchDirections;
    procedure SetSearchDirections(const Value: TCnSearchDirections);
    function GetChars(X, Y: Integer): Char;
    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure ReCalc;
  public
    constructor Create;
    destructor Destroy; override;

    function Search(const Str: string; out ResultPoint: TPoint; out Direction: TCnSearchDirection): Boolean;
    procedure LoadFromStrings(Strings: TStrings);
    procedure LoadFromFile(const AFile: string);
    procedure DumpToGrid(AGrid: TStringGrid);

    property Chars[X, Y: Integer]: Char read GetChars;
    property SearchDirections: TCnSearchDirections read FSearchDirections write SetSearchDirections;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
  end;

implementation

{ TCnMatrixWord }

constructor TCnMatrixWord.Create;
begin
  FChars := TStringList.Create;
  FSearchDirections := [sdUp, sdUpLeft, sdLeft, sdLeftDown, sdDown, sdDownRight, sdRight, sdRightUp];
end;

destructor TCnMatrixWord.Destroy;
begin
  FChars.Free;
end;

procedure TCnMatrixWord.DumpToGrid(AGrid: TStringGrid);
var
  Col, Row, L: Integer;
  S: string;
begin
  AGrid.ColCount := FWidth;
  AGrid.RowCount := FHeight;
  for Row := 0 to AGrid.RowCount - 1 do
    for Col := 0 to AGrid.ColCount - 1 do
      AGrid.Cells[Col, Row] := '';

  for Row := 0 to AGrid.RowCount - 1 do
  begin
    S := FChars[Row];
    L := Length(S) - 1;
    for Col := 0 to AGrid.ColCount - 1 do
      if Col <= L then
        AGrid.Cells[Col, Row] := S[Col + 1];
  end;
end;

function TCnMatrixWord.GetChars(X, Y: Integer): Char;
var
  S: string;
begin
  // 第 Y 行的第 X 个字符，X Y 均从 1 开始
  if (Y < 1) or (Y > FChars.Count) then
    raise Exception.Create('Y is out of bounds ' + IntToStr(Y));
  S := FChars[Y - 1];
  if (X < 1) or (X > Length(S)) then
    raise Exception.Create('X is out of bounds ' + IntToStr(X));

  Result := S[X];
end;

function TCnMatrixWord.GetHeight: Integer;
begin
  Result := FHeight;
end;

function TCnMatrixWord.GetWidth: Integer;
begin
  Result := FWidth;
end;

procedure TCnMatrixWord.LoadFromFile(const AFile: string);
begin
  if FileExists(AFile) then
  begin
    FChars.LoadFromFile(AFile);
    ReCalc;
  end;
end;

procedure TCnMatrixWord.LoadFromStrings(Strings: TStrings);
begin
  if Strings <> nil then
  begin
    FChars.Assign(Strings);
    ReCalc;
  end;
end;

procedure TCnMatrixWord.ReCalc;
var
  I: Integer;
begin
  FHeight := FChars.Count;
  FWidth := 0;
  for I := 0 to FChars.Count - 1 do
    if Length(FChars[I]) > FWidth then
      FWidth := Length(FChars[I]);
end;

function TCnMatrixWord.Search(const Str: string; out ResultPoint: TPoint;
  out Direction: TCnSearchDirection): Boolean;
var
  L: Integer;
  C: Char;
  F: Boolean;

  function GetNextChar(OrigX, OrigY, Offset: Integer; Dir: TCnSearchDirection): Char;
  begin
    case Dir of // 第 Y 行的第 X 个字符偏 I
      sdUp:        Result := GetChars(OrigX, OrigY - Offset);
      sdUpLeft:    Result := GetChars(OrigX - Offset, OrigY - Offset);
      sdLeft:      Result := GetChars(OrigX - Offset, OrigY);
      sdLeftDown:  Result := GetChars(OrigX - Offset, OrigY + Offset);
      sdDown:      Result := GetChars(OrigX, OrigY + Offset);
      sdDownRight: Result := GetChars(OrigX + Offset, OrigY + Offset);
      sdRight:     Result := GetChars(OrigX + Offset, OrigY);
      sdRightUp:   Result := GetChars(OrigX + Offset, OrigY - Offset);
    else
      Result := #0;
    end;
  end;

  function SearchInDirection(Dir: TCnSearchDirection): Boolean;
  var
    I, X, Y: Integer;
  begin
    Result := False;
    for X := 1 to FWidth do
    begin
      for Y := 1 to FHeight do
      begin
        try
          C := GetChars(X, Y);
          if C = Str[1] then
          begin
            F := True;
            for I := 2 to L do
            begin
              try
                C := GetNextChar(X, Y, I - 1, Dir);
                if C <> Str[I] then
                begin
                  F := False;
                  Break;
                end;
              except
                F := False;
                Break;
              end;
            end;

            if F then
            begin
              Result := True;
              ResultPoint.x := X;
              ResultPoint.y := Y;
              Direction := Dir;
            end;
          end;
        except
          Continue;
        end;
      end;
    end;
  end;

begin
  Result := False;
  L := Length(Str);
  if L < 1 then
    Exit;

  if (sdUp in FSearchDirections) and SearchInDirection(sdUp) then
      Result := True;
  if (sdUpLeft in FSearchDirections) and SearchInDirection(sdUpLeft) then
      Result := True;
  if (sdLeft in FSearchDirections) and SearchInDirection(sdLeft) then
      Result := True;
  if (sdLeftDown in FSearchDirections) and SearchInDirection(sdLeftDown) then
      Result := True;
  if (sdDown in FSearchDirections) and SearchInDirection(sdDown) then
      Result := True;
  if (sdDownRight in FSearchDirections) and SearchInDirection(sdDownRight) then
      Result := True;
  if (sdRight in FSearchDirections) and SearchInDirection(sdRight) then
      Result := True;
  if (sdRightUp in FSearchDirections) and SearchInDirection(sdRightUp) then
      Result := True;
end;

procedure TCnMatrixWord.SetSearchDirections(
  const Value: TCnSearchDirections);
begin
  FSearchDirections := Value;
end;

end.
