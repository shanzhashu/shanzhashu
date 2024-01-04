unit UnitFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Contnrs,
  Vcl.Buttons;

type
  TFrameSetting = class(TFrame)
    lblNames: TLabel;
    lblValues: TLabel;
    lstNames: TListBox;
    mmoValues: TMemo;
    btnAdd: TSpeedButton;
    btnDelete: TSpeedButton;
    edtSearch: TEdit;
    procedure lstNamesClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure mmoValuesChange(Sender: TObject);
    procedure lstNamesDblClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
  private
    FItemRefs: TObjectList;
    FSettingType: string;
    procedure SetSettingType(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdateFromOrigin;
    procedure ShowContents;
    procedure AddNew(const AName, AValue: string);
    procedure Delete(const AName: string);
    {* 调用完后需要 UpdateFromOrigin 重新加载到界面}

    function DeleteCurrent: Boolean;
    {* 调用完后需要 UpdateFromOrigin 重新加载到界面}

    property SettingType: string read FSettingType write SetSettingType;
  end;

implementation

{$R *.dfm}

uses
  UnitSetting;

{ TFrameSetting }

procedure TFrameSetting.AddNew(const AName, AValue: string);
var
  Item: TFWSettingItem;
begin
  if FWSetting.Find(FSettingType, AName) >=0 then
    raise Exception.Create('选项类型和名称重复了！');

  Item := FWSetting.Add as TFWSettingItem;
  Item.SettingType := FSettingType;
  Item.SettingName := AName;
  Item.SettingValue := AValue;

  FItemRefs.Add(Item);
end;

procedure TFrameSetting.btnAddClick(Sender: TObject);
var
  S: string;
begin
  // 输入名称新增空白项
  S := InputBox('', '选项名称', '新选项一');
  if S <> '' then
  begin
    AddNew(S, '');
    UpdateFromOrigin;
  end;
end;

procedure TFrameSetting.btnDeleteClick(Sender: TObject);
var
  Item: TFWSettingItem;
  B: Boolean;
begin
  B := False;
  if lstNames.ItemIndex >= 0 then
  begin
    Item := lstNames.Items.Objects[lstNames.ItemIndex] as TFWSettingItem;
    if Item <> nil then
    begin
      if Application.MessageBox(PChar(Format('确认要删除选项“%s”？', [Item.SettingName])),
       '提示', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        B := True;
      end;
    end;
  end;

  if B and DeleteCurrent then
    UpdateFromOrigin;
end;

constructor TFrameSetting.Create(AOwner: TComponent);
begin
  inherited;
  FItemRefs := TObjectList.Create(False);
end;

procedure TFrameSetting.Delete(const AName: string);
var
  Idx: Integer;
begin
  Idx := FWSetting.Find(FSettingType, AName);
  if Idx >= 0 then
    FWSetting.Delete(Idx);
end;

function TFrameSetting.DeleteCurrent: Boolean;
var
  Item: TFWSettingItem;
begin
  if lstNames.ItemIndex >= 0 then
  begin
    Item := lstNames.Items.Objects[lstNames.ItemIndex] as TFWSettingItem;
    if Item <> nil then
    begin
      Item.Release;
      Item.Free;
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

destructor TFrameSetting.Destroy;
begin
  FItemRefs.Free;
  inherited;
end;

procedure TFrameSetting.edtSearchChange(Sender: TObject);
var
  I: Integer;
begin
  if edtSearch.Text = '' then
    Exit;

  for I := 0 to lstNames.Count - 1 do
  begin
    if Pos(edtSearch.Text, lstNames.Items[I]) > 0 then
    begin
      lstNames.ItemIndex := I;
      lstNames.OnClick(lstNames);
      Break;
    end;
  end;
end;

procedure TFrameSetting.lstNamesClick(Sender: TObject);
var
  Item: TFWSettingItem;
begin
  mmoValues.Clear;
  if lstNames.ItemIndex >= 0 then
  begin
    Item := lstNames.Items.Objects[lstNames.ItemIndex] as TFWSettingItem;
    if Item <> nil then
      mmoValues.Lines.Text := Item.SettingValue;
  end;
end;

procedure TFrameSetting.lstNamesDblClick(Sender: TObject);
var
  Item: TFWSettingItem;
  S: string;
begin
  if lstNames.ItemIndex >= 0 then
  begin
    Item := lstNames.Items.Objects[lstNames.ItemIndex] as TFWSettingItem;
    if Item <> nil then
    begin
      S := InputBox('修改', '新名称：', Item.SettingName);
      if S <> '' then
      begin
        Item.SettingName := S;
        UpdateFromOrigin;
      end;
    end;
  end;
end;

procedure TFrameSetting.mmoValuesChange(Sender: TObject);
var
  Item: TFWSettingItem;
begin
  if lstNames.ItemIndex >= 0 then
  begin
    Item := lstNames.Items.Objects[lstNames.ItemIndex] as TFWSettingItem;
    if Item <> nil then
      Item.SettingValue := mmoValues.Lines.Text;
  end;
end;

procedure TFrameSetting.SetSettingType(const Value: string);
begin
  if Value <> FSettingType then
  begin
    FSettingType := Value;
    UpdateFromOrigin;
  end;
end;

procedure TFrameSetting.ShowContents;
var
  I: Integer;
  Item: TFWSettingItem;
begin
  lstNames.Clear;
  mmoValues.Clear;
  edtSearch.Clear;

  for I := 0 to FItemRefs.Count - 1 do
  begin
    Item := FItemRefs[I] as TFWSettingItem;
    lstNames.AddItem(Item.SettingName, Item);
  end;

  if lstNames.Count > 0 then
  begin
    lstNames.Selected[0] := True;
    lstNames.OnClick(lstNames);
  end;
end;

procedure TFrameSetting.UpdateFromOrigin;
var
  I: Integer;
begin
  FItemRefs.Clear;
  for I := 0 to FWSetting.Count - 1 do
    if (FWSetting.Items[I] as TFWSettingItem).SettingType = FSettingType then
      FItemRefs.Add(FWSetting.Items[I]);
  ShowContents;
end;

end.
