unit UnitSettingForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TFormSetting = class(TForm)
    pgcSetting: TPageControl;
    btnClose: TButton;
    pnlToolbar: TPanel;
    btnAdd: TSpeedButton;
    btnDelete: TSpeedButton;
    grpStamp: TGroupBox;
    lbledtStampWidth: TLabeledEdit;
    lbledtStampHeight: TLabeledEdit;
    lbledtStampTop: TLabeledEdit;
    lbledtStampLeft: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    procedure InitUIFromSettings;
  public
    { Public declarations }
  end;

var
  FormSetting: TFormSetting;

implementation

{$R *.dfm}

uses
  UnitSetting, UnitFrame;

procedure TFormSetting.btnAddClick(Sender: TObject);
var
  I: Integer;
  S: string;
  Tab: TTabSheet;
  Frm: TFrameSetting;
begin
  // 输入名称新增大页
  S := InputBox('', '新页面名称', '新页面一');

  for I := 0 to pgcSetting.PageCount - 1 do
  begin
    Tab := pgcSetting.Pages[I];
    if S = Tab.Caption then
      raise Exception.Create('页面名称重复了！');
  end;

  if S <> '' then
  begin
    // 拿到新的 SettingType，新建界面
    Tab := TTabSheet.Create(pgcSetting);
    Tab.Caption := S;
    Tab.PageControl := pgcSetting;

    pgcSetting.ActivePageIndex := pgcSetting.PageCount - 1;

    Frm := TFrameSetting.Create(Tab);
    Frm.Name := 'FrameSetting' + IntToStr(pgcSetting.PageCount - 1);
    Frm.SettingType := S;
    Frm.UpdateFromOrigin;

    Frm.Parent := Tab;
    Frm.Top := 0;
    Frm.Left := 0;
  end;
end;

procedure TFormSetting.btnCloseClick(Sender: TObject);
var
  I: Integer;
  Tab: TTabSheet;
begin
  for I := 0 to pgcSetting.PageCount - 1 do
  begin
    Tab := pgcSetting.Pages[I];
    if Pos('被核查器具', Tab.Caption) = 1 then
      FWSetting.SortType(Tab.Caption);
  end;

  Close;
end;

procedure TFormSetting.btnDeleteClick(Sender: TObject);
var
  Tab: TTabSheet;
begin
  if pgcSetting.ActivePageIndex >= 0 then
  begin
    if Application.MessageBox('确定要删除页面？', '提示', MB_OKCANCEL + MB_ICONQUESTION) = IDOK then
    begin
      Tab := pgcSetting.ActivePage;

      FWSetting.DeleteType(Tab.Caption);

      Tab.PageControl := nil;
      Tab.Free;
    end;
  end;
end;

procedure TFormSetting.FormCreate(Sender: TObject);
begin
  InitUIFromSettings;
end;

procedure TFormSetting.InitUIFromSettings;
var
  SL: TStringList;
  I: Integer;
  Item: TFWSettingItem;
  Tab: TTabSheet;
  Frm: TFrameSetting;
begin
  lbledtStampTop.Text := IntToStr(FWSetting.StampTop);
  lbledtStampLeft.Text := IntToStr(FWSetting.StampLeft);
  lbledtStampWidth.Text := IntToStr(FWSetting.StampWidth);
  lbledtStampHeight.Text := IntToStr(FWSetting.StampHeight);

  SL := TStringList.Create;
  try
    for I := 0 to FWSetting.Count - 1 do
    begin
      Item := FWSetting.Items[I] as TFWSettingItem;
      if Item <> nil then
      begin
        if SL.IndexOf(Item.SettingType) >= 0 then
          Continue;

        SL.Add(Item.SettingType);

        // 取到了一个新的 SettingType，新建界面
        Tab := TTabSheet.Create(pgcSetting);
        Tab.Caption := Item.SettingType;
        Tab.PageControl := pgcSetting;

        Frm := TFrameSetting.Create(Tab);
        Frm.Name := 'FrameSetting' + IntToStr(pgcSetting.PageCount - 1);
        Frm.SettingType := Item.SettingType;
        Frm.UpdateFromOrigin;

        Frm.Parent := Tab;
        Frm.Top := 0;
        Frm.Left := 0;
      end;
    end;
  finally
    SL.Free;
  end;
end;

end.
