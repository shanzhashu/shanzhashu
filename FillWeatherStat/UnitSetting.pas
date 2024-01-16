unit UnitSetting;

interface

uses
  System.SysUtils, System.Classes, OmniXML, OmniXMLUtils, OmniXMLPersistent,
  CnJSON;

type
  TFWSettingItem = class(TCollectionItem)
  private
    FSettingValue: string;
    FSettingType: string;
    FSettingName: string;
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
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function Find(const AType, AName: string): Integer;
    procedure DeleteType(const AType: string);
    procedure GetType(const AType: string; Names, Values: TStrings);

    procedure SaveToXML(const XMLFile: string);
    procedure LoadFromXML(const XMLFile: string);

    procedure SaveToJSON(const JSONFile: string);
    procedure LoadFromJSON(const JSONFile: string);
  published
    property SettingVersion: Integer read FSettingVersion write FSettingVersion;

    property StampLeft: Integer read FStampLeft write FStampLeft;
    property StampTop: Integer read FStampTop write FStampTop;
  end;

var
  FWSetting: TFWSettingCollectin = nil;

implementation

{ TFWSettingCollectin }

constructor TFWSettingCollectin.Create;
begin
  inherited Create(TFWSettingItem);
  FSettingVersion := 1;
  FStampTop := 300;
  FStampLeft := 200;
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

procedure TFWSettingCollectin.LoadFromXML(const XMLFile: string);
begin
  TOmniXMLReader.LoadFromFile(Self, XMLFile);
end;

procedure TFWSettingCollectin.SaveToJSON(const JSONFile: string);
begin
  TCnJSONWriter.SaveToFile(Self, JSONFile);
end;

procedure TFWSettingCollectin.SaveToXML(const XMLFile: string);
begin
  TOmniXMLWriter.SaveToFile(Self, XMLFile, pfAuto, ofIndent);
end;

initialization
  FWSetting := TFWSettingCollectin.Create;

finalization
  FWSetting.Free;

end.
