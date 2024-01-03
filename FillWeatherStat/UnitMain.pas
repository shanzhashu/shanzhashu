unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.FlexCel.Core, FlexCel.XlsAdapter, FlexCel.Pdf,
  FlexCel.Render, FlexCel.Preview, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.Buttons;

type
  TFormMain = class(TForm)
    pgcMain: TPageControl;
    ts1: TTabSheet;
    pnlMain: TPanel;
    btnPDF: TSpeedButton;
    dlgSave1: TSaveDialog;
    btnToggleVisible: TSpeedButton;
    ScrollBox1: TScrollBox;
    fcpSheet1: TFlexCelPreviewer;
    lbl1BiaoZhunQi: TLabel;
    img1bk: TImage;
    lbl1BeiHeCha: TLabel;
    cbb1BiaoZhunQi: TComboBox;
    edt1QiWen: TEdit;
    edt1ShiDu: TEdit;
    edt1FengSu: TEdit;
    edt1KaiShiShiJian: TEdit;
    edt1JieShuShiJian: TEdit;
    cbb1HeGe: TComboBox;
    edt1JiaoZhunShiJian: TEdit;
    cbb1BeiHeCha: TComboBox;
    cbb1WaiGuanHeGe: TComboBox;
    cbb1FuHeYaoQiu: TComboBox;
    btnSettings: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure edtChange1(Sender: TObject);
    procedure btnToggleVisibleClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
  private
    FFileName: string;
    FSettingFile: string;
    FXls: TExcelFile;
    FImgExport: TFlexCelImgExport;
  public
    procedure UpdateSheet1; // 温度
    procedure UpdateSheet2; // 湿度
    procedure UpdateSheet3; // 风向
    procedure UpdateSheet4; // 风速
    procedure UpdateSheet5; // 气压
    procedure UpdateSheet6; // 雨量
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  UnitSettingForm, UnitSetting;

const
  S_F_XLS = 'DY.xlsx';
  S_F_SET = 'Setting.xml';
  S_ARR_HEGE: array[0..1] of string = ('合格', '不合格');

procedure TFormMain.btnPDFClick(Sender: TObject);
var
  Pdf: TFlexCelPdfExport;
begin
  if dlgSave1.Execute then
  begin
    Pdf := TFlexCelPdfExport.Create(FXls, True);
    Screen.Cursor := crHourGlass;
    try
      Pdf.Export(dlgSave1.FileName);
    finally
      Pdf.Free;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFormMain.btnSettingsClick(Sender: TObject);
begin
  with TFormSetting.Create(nil) do
  begin
    ShowModal;
    FWSetting.SaveToXML(FSettingFile);
    Free;
  end;
end;

procedure TFormMain.btnToggleVisibleClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to fcpSheet1.ControlCount - 1 do
  begin
    if (fcpSheet1.Controls[I] is TEdit) or (fcpSheet1.Controls[I] is TComboBox) or
      (fcpSheet1.Controls[I] is TRadioGroup) then
    begin
      fcpSheet1.Controls[I].Visible := not fcpSheet1.Controls[I].Visible;
    end;
  end;
end;

procedure TFormMain.edtChange1(Sender: TObject);
begin
  UpdateSheet1;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FSettingFile := ExtractFilePath(Application.ExeName) + S_F_SET;
  if FileExists(FSettingFile) then
    FWSetting.LoadFromXML(FSettingFile);

  FFileName := ExtractFilePath(Application.ExeName) + S_F_XLS;
  if not FileExists(FFileName) then
    FFileName := ExtractFilePath(Application.ExeName) + '..\..\' + S_F_XLS;

  FXls := TXlsFile.Create(True);

  FXls.Open(FFileName);
  // ShowMessage(IntToStr(FXls.ActiveSheet) + FXls.ActiveSheetByName);
  FXls.ActiveSheet := 1;
  Caption := FXls.ActiveSheetByName;

  FImgExport := TFlexCelImgExport.Create(FXls, False);
  FImgExport.AllVisibleSheets := False;
  FcpSheet1.Document := FImgExport;

  FcpSheet1.InvalidatePreview;

  edt1JiaoZhunShiJian.Text := FormatDateTime('yyyy年MM月dd日', Now());
end;

procedure TFormMain.UpdateSheet1;
var
  S: string;
begin
  S := Format('气温：%s℃     湿度：%s％RH    风速：%sm/s',
    [edt1QiWen.Text, edt1ShiDu.Text, edt1FengSu.Text]);
  FXls.SetCellValue(4, 2, S);

  if cbb1WaiGuanHeGe.ItemIndex = 0 then
    S := Format('%s合格                  %s 不合格', [#$2611, #$25A1])
  else
    S := Format('%s合格                  %s 不合格', [#$25A1, #$2611]);
  FXls.SetCellValue(8, 2, S);

  FXls.SetCellValue(5, 2, edt1KaiShiShiJian.Text);
  FXls.SetCellValue(5, 5, edt1JieShuShiJian.Text);

  FXls.SetCellValue(19, 3, S_ARR_HEGE[cbb1HeGe.ItemIndex]);
  if cbb1FuHeYaoQiu.ItemIndex = 0 then
    S := Format('%s 是        %s 否', [#$2611, #$25A1])
  else
    S := Format('%s 是        %s 否', [#$25A1, #$2611]);
  FXls.SetCellValue(21, 3, S);

  FXls.SetCellValue(22, 5, edt1JiaoZhunShiJian.Text);
  //FXls.Save(FFileName);
  FcpSheet1.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet2;
begin

end;

procedure TFormMain.UpdateSheet3;
begin

end;

procedure TFormMain.UpdateSheet4;
begin

end;

procedure TFormMain.UpdateSheet5;
begin

end;

procedure TFormMain.UpdateSheet6;
begin

end;

end.
