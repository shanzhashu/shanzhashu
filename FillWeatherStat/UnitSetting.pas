unit UnitSetting;

interface

uses
  System.SysUtils, System.Classes, System.Contnrs, CnJSON;

type
  TFWSettingItem = class(TCollectionItem)
  private
    FSettingValue: string;
    FSettingType: string;
    FSettingName: string;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  published
    property SettingType: string read FSettingType write FSettingType;
    property SettingName: string read FSettingName write FSettingName;
    property SettingValue: string read FSettingValue write FSettingValue;
  end;

  TFWSettingCollectin = class(TCollection)
  private
    FSettingVersion: Integer;
    FStampLeft: Integer;
    FStampTop: Integer;
    FStampWidth: Integer;
    FStampHeight: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure Exchange(Index1, Index2: Integer);

    function Find(const AType, AName: string): Integer;
    procedure DeleteType(const AType: string);
    procedure GetType(const AType: string; Names, Values: TStrings); overload;
    procedure GetType(const AType: string; OutRefs: TObjectList); overload;

    procedure SaveToJSON(const JSONFile: string);
    procedure LoadFromJSON(const JSONFile: string);

    procedure SortType(const AType: string);
    // 属于同一个类型的条目排序
  published
    property SettingVersion: Integer read FSettingVersion write FSettingVersion;

    property StampLeft: Integer read FStampLeft write FStampLeft;
    property StampTop: Integer read FStampTop write FStampTop;
    property StampWidth: Integer read FStampWidth write FStampWidth;
    property StampHeight: Integer read FStampHeight write FStampHeight;
  end;

var
  FWSetting: TFWSettingCollectin = nil;

implementation

{ TFWSettingCollectin }

constructor TFWSettingCollectin.Create;
begin
  inherited Create(TFWSettingItem);
  FSettingVersion := 1;
  FStampTop := 350;
  FStampLeft := 80;
  FStampWidth := 200;
  FStampHeight := 200;
end;

procedure TFWSettingCollectin.DeleteType(const AType: string);
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
  begin
    if (Items[I] as TFWSettingItem).SettingType = AType then
      Delete(I);
  end;
end;

destructor TFWSettingCollectin.Destroy;
begin

  inherited;
end;

procedure TFWSettingCollectin.Exchange(Index1, Index2: Integer);
var
  T: TFWSettingItem;
begin
 if (Index1 <> Index2) and (Index1 >= 0) and (Index1 < Count) and
   (Index2 >= 0) and (Index2 < Count) then
 begin
   T := TFWSettingItem.Create(nil);
   try
     T.Assign(GetItem(Index1));
     SetItem(Index1, GetItem(Index2));
     SetItem(Index2, T);
   finally
     T.Free;
   end;
 end;
end;

function TFWSettingCollectin.Find(const AType, AName: string): Integer;
var
  I: Integer;
  Item: TFWSettingItem;
begin
  for I := 0 to Count - 1 do
  begin
    Item := Items[I] as TFWSettingItem;
    if (Item <> nil) and (Item.SettingType = AType) and (Item.SettingName = AName) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

procedure TFWSettingCollectin.GetType(const AType: string;
  OutRefs: TObjectList);
var
  I: Integer;
  Item: TFWSettingItem;
begin
  OutRefs.Clear;

  for I := 0 to Count - 1 do
  begin
    Item := Items[I] as TFWSettingItem;
    if (AType = '') or (Item.SettingType = AType) then
      OutRefs.Add(Item);
  end;
end;

procedure TFWSettingCollectin.GetType(const AType: string;
  Names, Values: TStrings);
var
  I: Integer;
  Item: TFWSettingItem;
begin
  Names.Clear;
  if Values <> nil then
    Values.Clear;

  for I := 0 to Count - 1 do
  begin
    Item := Items[I] as TFWSettingItem;
    if (AType = '') or (Item.SettingType = AType) then
    begin
      Names.Add(Item.SettingName);
      if Values <> nil then
        Values.Add(Item.SettingValue);
    end;
  end;
end;

procedure TFWSettingCollectin.LoadFromJSON(const JSONFile: string);
begin
  TCnJSONReader.LoadFromFile(Self, JSONFile);
end;

procedure TFWSettingCollectin.SaveToJSON(const JSONFile: string);
begin
  TCnJSONWriter.SaveToFile(Self, JSONFile);
end;

function ItemSortCmp(Item1, Item2: Pointer): Integer;
var
  S1, S2: TFWSettingItem;
begin
  S1 := TFWSettingItem(Item1);
  S2 := TFWSettingItem(Item2);

  Result := CompareStr(S1.SettingName, S2.SettingName);
end;

procedure TFWSettingCollectin.SortType(const AType: string);
var
  Olds, Refs, News: TObjectList;
  OldIdx, NewIdx: array of Integer;
  I: Integer;
  T: TFWSettingItem;
begin
  Olds := TObjectList.Create(False);
  Refs := TObjectList.Create(False);
  News := TObjectList.Create(True); // 临时管理排序后的复制内容
  try
    GetType(AType, Olds);
    GetType(AType, Refs);
    Refs.Sort(ItemSortCmp);

    // 将排序后的 Refs 的内容复制一份
    for I := 0 to Refs.Count - 1 do
    begin
      T := TFWSettingItem.Create(nil);
      T.Assign(TFWSettingItem(Refs[I]));
      News.Add(T);
    end;

    SetLength(OldIdx, Olds.Count);
    SetLength(NewIdx, Refs.Count);

    for I := 0 to Olds.Count - 1 do
      OldIdx[I] := TFWSettingItem(Olds[I]).Index;
    for I := 0 to Refs.Count - 1 do
      NewIdx[I] := TFWSettingItem(Refs[I]).Index;

    // OldIdx 是一排原始索引，NewIdx 是排序后的新索引
    for I := 0 to News.Count - 1 do
      Items[OldIdx[I]] := TFWSettingItem(News[I]);
  finally
    News.Free;
    Refs.Free;
    Olds.Free;
  end;
end;

{ TFWSettingItem }

procedure TFWSettingItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TFWSettingItem then
  begin
    (Dest as TFWSettingItem).SettingType := FSettingType;
    (Dest as TFWSettingItem).SettingName := FSettingName;
    (Dest as TFWSettingItem).SettingValue := FSettingValue;
  end
  else
    inherited;
end;

initialization
  FWSetting := TFWSettingCollectin.Create;

finalization
  FWSetting.Free;

end.
