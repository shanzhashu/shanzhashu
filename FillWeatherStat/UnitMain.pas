unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.FlexCel.Core, FlexCel.XlsAdapter, FlexCel.Pdf,
  FlexCel.Render, FlexCel.Preview, Vcl.ComCtrls, Vcl.Imaging.pngimage, _UMiscClasses.TImageProperties,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.Buttons;

const
  XLS_COUNT = 7;

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
    cbb1JiaoZhun: TComboBox;
    cbb1HeYan: TComboBox;
    cbb1HeChaYiJu: TComboBox;
    ts2: TTabSheet;
    ScrollBox2: TScrollBox;
    fcpSheet2: TFlexCelPreviewer;
    ts3: TTabSheet;
    ScrollBox3: TScrollBox;
    fcpSheet3: TFlexCelPreviewer;
    ts4: TTabSheet;
    ScrollBox4: TScrollBox;
    fcpSheet4: TFlexCelPreviewer;
    ts5: TTabSheet;
    ScrollBox5: TScrollBox;
    fcpSheet5: TFlexCelPreviewer;
    ts6: TTabSheet;
    ScrollBox6: TScrollBox;
    fcpSheet6: TFlexCelPreviewer;
    ts7: TTabSheet;
    ScrollBox7: TScrollBox;
    fcpSheet7: TFlexCelPreviewer;
    edt1JiLuBianHao: TEdit;
    btnStamp: TSpeedButton;
    dlgOpen1: TOpenDialog;
    dlgSaveStamp: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure edtChange1(Sender: TObject);
    procedure btnToggleVisibleClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnStampClick(Sender: TObject);
  private
    FSettingFile: string;
    FStampFile: string;
    FStampIndexes: array[1..XLS_COUNT] of Integer;
    FStampAddeds: array[1..XLS_COUNT] of Boolean;
    FXlses: array[1..XLS_COUNT] of TExcelFile;
    FImgExports: array[1..XLS_COUNT] of TFlexCelImgExport;
    F1BiaoZhunQiNames, F1BiaoZhunQiValues: TStringList;
    F1BeiHeChaQiJuNames, F1BeiHeChaQiJuValues: TStringList;
    F1HeChaYiJu, F1JiaoZhun, F1HeYan: TStringList;
  protected
    procedure InsertStamp(Index: Integer);
    function PreviewerByIndex(Index: Integer): TFlexCelPreviewer;
    function CurrentPreviewer: TFlexCelPreviewer;
  public
    procedure UpdateSheet1; // 气温
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
  UnitSettingForm, UnitSetting, CnJSON;

const
  S_F_SET = 'Setting.json';
  S_F_STAMP = 'stamp.png';
  S_ARR_HEGE: array[0..1] of string = ('合格', '不合格');

var
  XLS_FILES: array[1..XLS_COUNT] of string;

procedure TFormMain.btnPDFClick(Sender: TObject);
var
  Pdf: TFlexCelPdfExport;
  Idx: Integer;
begin
  if dlgSave1.Execute then
  begin
    Idx := pgcMain.ActivePageIndex + 1;
    InsertStamp(Idx);

    Pdf := TFlexCelPdfExport.Create(FXlses[Idx], True);
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
    FWSetting.SaveToJSON(FSettingFile);
    Free;
  end;
end;

function LoadAndDrawImageFromFile(Bmp: TBitmap; const FileName: string): Boolean;
var
  FileStream: TFileStream;
  JpgImage: TJPEGImage;
  PngImage: TPNGImage;
  ImageWidth, ImageHeight: Integer;
begin
  Result := False;
  if not FileExists(FileName) then
    Exit;

  // 创建文件流
  FileStream := TFileStream.Create(FileName, fmOpenRead);

  try
    // 尝试加载JPEG图像
    JpgImage := TJPEGImage.Create;
    try
      JpgImage.LoadFromStream(FileStream);
      ImageWidth := JpgImage.Width;
      ImageHeight := JpgImage.Height;
      Bmp.Width := ImageWidth;
      Bmp.Height := ImageHeight;
      Bmp.Canvas.Draw(0, 0, JpgImage);
      Result := True;
    finally
      JpgImage.Free;
    end;
  finally
    FileStream.Free;
  end;

  if not Result then
  begin
    // 如果不是JPEG，尝试加载PNG图像
    PngImage := TPNGImage.Create;
    try
      PngImage.LoadFromStream(FileStream);
      ImageWidth := PngImage.Width;
      ImageHeight := PngImage.Height;
      Bmp.Width := ImageWidth;
      Bmp.Height := ImageHeight;
      Bmp.Canvas.Draw(0, 0, PngImage);
      Result := True;
    finally
      PngImage.Free;
    end;
  end;
end;

function LoadAndDrawStamp(Bmp: TBitmap; const FileName: string; Left, Top: Integer): Boolean;
var
  FileStream: TFileStream;
  PngImage: TPNGImage;
begin
  Result := False;
  if not FileExists(FileName) then
    Exit;

  // 创建文件流
  FileStream := TFileStream.Create(FileName, fmOpenRead);

  try
    // 尝试加载PNG图像
    PngImage := TPNGImage.Create;
    try
      PngImage.LoadFromStream(FileStream);
      Bmp.Canvas.Draw(Left, Top, PngImage);
      Result := True;
    finally
      PngImage.Free;
    end;
  finally
    FileStream.Free;
  end;
end;

procedure SaveBitmapToJPG(const Bitmap: TBitmap; const FileName: string);
var
  JPEGImage: TJPEGImage;
begin
  JPEGImage := TJPEGImage.Create;
  try
    JPEGImage.Assign(Bitmap);
    JPEGImage.SaveToFile(FileName);
  finally
    JPEGImage.Free;
  end;
end;

procedure TFormMain.btnStampClick(Sender: TObject);
var
  Bmp: TBitmap;
begin
  if dlgOpen1.Execute then
  begin
    Bmp := TBitmap.Create;

    try
      if LoadAndDrawImageFromFile(Bmp, dlgOpen1.FileName) then
      begin
        if LoadAndDrawStamp(Bmp, FStampFile, FWSetting.StampLeft,
          FWSetting.StampTop) then
        begin
          if dlgSaveStamp.Execute then
            SaveBitmapToJPG(Bmp, dlgSaveStamp.FileName);
        end;
      end;
    finally
      Bmp.Free;
    end;
  end;
end;

procedure TFormMain.btnToggleVisibleClick(Sender: TObject);

  function ToggleSheetControlsVisible(Prev: TFlexCelPreviewer): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to Prev.ControlCount - 1 do
    begin
      if (Prev.Controls[I] is TEdit) or (Prev.Controls[I] is TComboBox) or
        (Prev.Controls[I] is TRadioGroup) or (Prev.Controls[I] is TLabel) then
      begin
        Prev.Controls[I].Visible := not Prev.Controls[I].Visible;
        Result := Prev.Controls[I].Visible;
      end;
    end;
  end;

  procedure ToggleSheet(Index: Integer);
  var
    Sht: TFlexCelPreviewer;
  begin
    Sht := FindComponent('fcpSheet' +IntToStr(Index)) as TFlexCelPreviewer;

    if ToggleSheetControlsVisible(Sht) then
    begin
      FXlses[Index].DeleteImage(FStampIndexes[Index]);
      Dec(FStampIndexes[Index]);
      FStampAddeds[Index] := False;

      Sht.InvalidatePreview;
    end
    else
    begin
      InsertStamp(Index);
    end;
  end;

begin
  ToggleSheet(pgcMain.ActivePageIndex + 1);
end;

function TFormMain.CurrentPreviewer: TFlexCelPreviewer;
begin
  Result := PreviewerByIndex(pgcMain.ActivePageIndex + 1);
end;

procedure TFormMain.edtChange1(Sender: TObject);
begin
  UpdateSheet1;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  // 初始化选项文件
  FSettingFile := ExtractFilePath(Application.ExeName) + S_F_SET;
  if FileExists(FSettingFile) then
  begin
    FWSetting.LoadFromJSON(FSettingFile);
//    FWSetting.LoadFromXML(ExtractFilePath(Application.ExeName) + 'Setting.xml');
//    TCnJSONWriter.SaveToFile(FWSetting, FSettingFile);
    // TCnJSONReader.LoadFromFile(FWSetting, FSettingFile);
  end;

  // 初始化公章文件
  FStampFile := ExtractFilePath(Application.ExeName) + S_F_STAMP;

  // 初始化 Excel 文件名并打开 Excel 文件并加载显示
  for I := Low(XLS_FILES) to High(XLS_FILES) do
  begin
    XLS_FILES[I] := ExtractFilePath(Application.ExeName) + IntToStr(I) + '.xlsx';

    FXlses[I] := TXlsFile.Create(True);
    FXlses[I].Open(XLS_FILES[I]);
    FXlses[I].ActiveSheet := 1;

    FImgExports[I] := TFlexCelImgExport.Create(FXlses[I], False);
    FImgExports[I].AllVisibleSheets := False;

    PreviewerByIndex(I).Document := FImgExports[I];
    // 显示打印底图
    PreviewerByIndex(I).InvalidatePreview;
  end;

  pgcMain.ActivePageIndex := 0;

  // 初始化填写元素，后面分页来，第一页：
  edt1JiaoZhunShiJian.Text := FormatDateTime('yyyy年MM月dd日', Now());

  F1BiaoZhunQiNames := TStringList.Create;
  F1BiaoZhunQiValues := TStringList.Create;
  FWSetting.GetType('标准器', F1BiaoZhunQiNames, F1BiaoZhunQiValues);
  cbb1BiaoZhunQi.Items.Assign(F1BiaoZhunQiNames);

  F1BeiHeChaQiJuNames := TStringList.Create;
  F1BeiHeChaQiJuValues := TStringList.Create;
  FWSetting.GetType('被核查器具', F1BeiHeChaQiJuNames, F1BeiHeChaQiJuValues);
  cbb1BeiHeCha.Items.Assign(F1BeiHeChaQiJuNames);

  F1JiaoZhun := TStringList.Create;
  F1HeYan := TStringList.Create;
  F1HeChaYiJu := TStringList.Create;
  FWSetting.GetType('校准人', F1JiaoZhun, nil);
  FWSetting.GetType('核验人', F1HeYan, nil);
  FWSetting.GetType('核查依据', F1HeChaYiJu, nil);

  cbb1JiaoZhun.Items.Assign(F1JiaoZhun);
  if cbb1JiaoZhun.Items.Count > 0 then
    cbb1JiaoZhun.ItemIndex := 0;

  cbb1HeYan.Items.Assign(F1HeYan);
  if cbb1HeYan.Items.Count > 0 then
    cbb1HeYan.ItemIndex := 0;

  cbb1HeChaYiJu.Items.Assign(F1HeChaYiJu);
  if cbb1HeChaYiJu.Items.Count > 0 then
    cbb1HeChaYiJu.ItemIndex := 0;

  // 第二页
end;

procedure TFormMain.InsertStamp(Index: Integer);
var
  MP: IImageProperties;
begin
  if not FStampAddeds[Index] then
  begin
    // 插入图像
    MP := TImageProperties.Create;
    MP.Anchor := TClientAnchor.Create(TFlxAnchorType.MoveAndDontResize,
      16, 0, 4, 50, 256, 236, FXlses[Index]);

    FXlses[Index].AddImage(FStampFile, MP);
    Inc(FStampIndexes[Index]);

    PreviewerByIndex(Index).InvalidatePreview;
    FStampAddeds[Index] := True;
  end;
end;

function TFormMain.PreviewerByIndex(Index: Integer): TFlexCelPreviewer;
begin
  Result := FindComponent('fcpSheet' + IntToStr(Index)) as TFlexCelPreviewer;
  if Result = nil then
    raise Exception.Create('NO FcpSheet for ' + IntToStr(Index));
end;

procedure TFormMain.UpdateSheet1;
var
  S: string;
begin
  S := Format('记录编号：%s', [edt1JiLuBianHao.Text]);
  FXlses[1].SetCellValue(3, 1, S);

  S := Format('气温：%s℃     湿度：%s％RH    风速：%sm/s',
    [edt1QiWen.Text, edt1ShiDu.Text, edt1FengSu.Text]);
  FXlses[1].SetCellValue(4, 2, S);

  if cbb1WaiGuanHeGe.ItemIndex = 0 then
    S := Format('%s合格                  %s 不合格', [#$2611, #$25A1])
  else
    S := Format('%s合格                  %s 不合格', [#$25A1, #$2611]);
  FXlses[1].SetCellValue(8, 2, S);

  FXlses[1].SetCellValue(5, 2, edt1KaiShiShiJian.Text);
  FXlses[1].SetCellValue(5, 5, edt1JieShuShiJian.Text);

  if (cbb1BiaoZhunQi.ItemIndex >= 0) and (cbb1BiaoZhunQi.ItemIndex < F1BiaoZhunQiValues.Count) then
    FXlses[1].SetCellValue(7, 2, F1BiaoZhunQiValues[cbb1BiaoZhunQi.ItemIndex]);

  if (cbb1BeiHeCha.ItemIndex >= 0) and (cbb1BeiHeCha.ItemIndex < F1BeiHeChaQiJuValues.Count) then
    FXlses[1].SetCellValue(7, 4, F1BeiHeChaQiJuValues[cbb1BeiHeCha.ItemIndex]);

  FXlses[1].SetCellValue(19, 3, S_ARR_HEGE[cbb1HeGe.ItemIndex]);
  if cbb1FuHeYaoQiu.ItemIndex = 0 then
    S := Format('%s 是        %s 否', [#$2611, #$25A1])
  else
    S := Format('%s 是        %s 否', [#$25A1, #$2611]);

  FXlses[1].SetCellValue(20, 3, cbb1HeChaYiJu.Items[cbb1HeChaYiJu.ItemIndex]);
  FXlses[1].SetCellValue(21, 3, S);

  FXlses[1].SetCellValue(22, 1, '校准：' + cbb1JiaoZhun.Items[cbb1JiaoZhun.ItemIndex]);
  FXlses[1].SetCellValue(22, 3, '核验：' + cbb1HeYan.Items[cbb1HeYan.ItemIndex]);
  FXlses[1].SetCellValue(22, 5, edt1JiaoZhunShiJian.Text);

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
