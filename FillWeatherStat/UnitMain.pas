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
    dlgSavePDF: TSaveDialog;
    btnToggleVisible: TSpeedButton;
    btnSettings: TSpeedButton;
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
    cbb1JiaoZhun: TComboBox;
    cbb1HeYan: TComboBox;
    cbb1HeChaYiJu: TComboBox;
    ts2: TTabSheet;
    ScrollBox2: TScrollBox;
    fcpSheet2: TFlexCelPreviewer;
    edt2JiLuBianHao: TEdit;
    edt2QiWen: TEdit;
    edt2ShiDu: TEdit;
    edt2FengSu: TEdit;
    edt2KaiShiShiJian: TEdit;
    edt2JieShuShiJian: TEdit;
    cbb2BiaoZhunQi: TComboBox;
    cbb2BeiHeCha: TComboBox;
    cbb2WaiGuanHeGe: TComboBox;
    cbb2HeGe: TComboBox;
    cbb2HeChaYiJu: TComboBox;
    cbb2FuHeYaoQiu: TComboBox;
    cbb2JiaoZhun: TComboBox;
    cbb2HeYan: TComboBox;
    edt2JiaoZhunShiJian: TEdit;
    lbl2BeiHeCha: TLabel;
    lbl2BiaoZhunQi: TLabel;
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
    dlgOpenForStamp: TOpenDialog;
    dlgSaveStamp: TSaveDialog;

    procedure FormCreate(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure edtChange1(Sender: TObject);
    procedure btnToggleVisibleClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnStampClick(Sender: TObject);

    procedure UpdateSheet1(Sender: TObject);
    procedure UpdateSheet2(Sender: TObject);
    procedure UpdateSheet3(Sender: TObject);
    procedure UpdateSheet4(Sender: TObject);
    procedure UpdateSheet5(Sender: TObject);
    procedure UpdateSheet6(Sender: TObject);
    procedure UpdateSheet7(Sender: TObject);
  private
    FSettingFile: string;
    FStampFile: string;
    FStampIndexes: array[1..XLS_COUNT] of Integer;
    FStampAddeds: array[1..XLS_COUNT] of Boolean;
    FXlses: array[1..XLS_COUNT] of TExcelFile;
    FImgExports: array[1..XLS_COUNT] of TFlexCelImgExport;
    FBiaoZhunQiNames, FBiaoZhunQiValues: TStringList;
    FBeiHeChaQiJuNames, FBeiHeChaQiJuValues: TStringList;
    FHeChaYiJu, FJiaoZhun, FHeYan: TStringList;
  protected
    procedure InsertStamp(Index: Integer);
    function PreviewerByIndex(Index: Integer): TFlexCelPreviewer;
    function CurrentPreviewer: TFlexCelPreviewer;
  public
    procedure Init0;
    procedure Init1;
    procedure Init2;
    procedure Init3;
    procedure Init4;
    procedure Init5;
    procedure Init6;
    procedure Init7;
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
  if dlgSavePDF.Execute then
  begin
    Idx := pgcMain.ActivePageIndex + 1;
    InsertStamp(Idx);

    Pdf := TFlexCelPdfExport.Create(FXlses[Idx], True);
    Screen.Cursor := crHourGlass;
    try
      Pdf.Export(dlgSavePDF.FileName);
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

  if LowerCase(ExtractFileExt(FileName)) = '.jpg' then
  begin
    // 创建文件流
    FileStream := TFileStream.Create(FileName, fmOpenRead);

    try
      // 加载JPEG图像
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
  end
  else if LowerCase(ExtractFileExt(FileName)) = '.png' then
  begin
    // 创建文件流
    FileStream := TFileStream.Create(FileName, fmOpenRead);

    try
      // 加载PNG图像
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
    finally
      FileStream.Free;
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
  if dlgOpenForStamp.Execute then
  begin
    Bmp := TBitmap.Create;

    try
      if LoadAndDrawImageFromFile(Bmp, dlgOpenForStamp.FileName) then
      begin
        if LoadAndDrawStamp(Bmp, FStampFile, FWSetting.StampLeft,
          FWSetting.StampTop) then
        begin
          if dlgSaveStamp.Execute then
          begin
            SaveBitmapToJPG(Bmp, dlgSaveStamp.FileName);
            Application.MessageBox('盖章成功！', '提示', MB_OK + MB_ICONINFORMATION);
          end;
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
  UpdateSheet1(Sender);
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

  // 初始化填写元素，分页来
  Init0;

  Init1;
  Init2;
  Init3;
  Init4;
  Init5;
  Init6;
  Init7;

  UpdateSheet1(nil);
  UpdateSheet2(nil);
  UpdateSheet3(nil);
  UpdateSheet4(nil);
  UpdateSheet5(nil);
  UpdateSheet6(nil);
  UpdateSheet7(nil);
end;

procedure TFormMain.Init0;
begin
  FBiaoZhunQiNames := TStringList.Create;
  FBiaoZhunQiValues := TStringList.Create;
  FWSetting.GetType('标准器', FBiaoZhunQiNames, FBiaoZhunQiValues);

  FBeiHeChaQiJuNames := TStringList.Create;
  FBeiHeChaQiJuValues := TStringList.Create;
  FWSetting.GetType('被核查器具', FBeiHeChaQiJuNames, FBeiHeChaQiJuValues);

  FJiaoZhun := TStringList.Create;
  FHeYan := TStringList.Create;
  FHeChaYiJu := TStringList.Create;
  FWSetting.GetType('校准人', FJiaoZhun, nil);
  FWSetting.GetType('核验人', FHeYan, nil);
  FWSetting.GetType('核查依据', FHeChaYiJu, nil);
end;

procedure TFormMain.Init1;
begin
  edt1JiaoZhunShiJian.Text := FormatDateTime('yyyy年MM月dd日', Now());

  cbb1BiaoZhunQi.Items.Assign(FBiaoZhunQiNames);

  cbb1BeiHeCha.Items.Assign(FBeiHeChaQiJuNames);

  cbb1JiaoZhun.Items.Assign(FJiaoZhun);
  if cbb1JiaoZhun.Items.Count > 0 then
    cbb1JiaoZhun.ItemIndex := 0;

  cbb1HeYan.Items.Assign(FHeYan);
  if cbb1HeYan.Items.Count > 0 then
    cbb1HeYan.ItemIndex := 0;

  cbb1HeChaYiJu.Items.Assign(FHeChaYiJu);
  if cbb1HeChaYiJu.Items.Count > 0 then
    cbb1HeChaYiJu.ItemIndex := 0;
end;

procedure TFormMain.Init2;
begin
  edt2JiaoZhunShiJian.Text := FormatDateTime('yyyy年MM月dd日', Now());

  cbb2BiaoZhunQi.Items.Assign(FBiaoZhunQiNames);

  cbb2BeiHeCha.Items.Assign(FBeiHeChaQiJuNames);

  cbb2JiaoZhun.Items.Assign(FJiaoZhun);
  if cbb2JiaoZhun.Items.Count > 0 then
    cbb2JiaoZhun.ItemIndex := 0;

  cbb2HeYan.Items.Assign(FHeYan);
  if cbb2HeYan.Items.Count > 0 then
    cbb2HeYan.ItemIndex := 0;

  cbb2HeChaYiJu.Items.Assign(FHeChaYiJu);
  if cbb2HeChaYiJu.Items.Count > 0 then
    cbb2HeChaYiJu.ItemIndex := 0;
end;

procedure TFormMain.Init3;
begin

end;

procedure TFormMain.Init4;
begin

end;

procedure TFormMain.Init5;
begin

end;

procedure TFormMain.Init6;
begin

end;

procedure TFormMain.Init7;
begin

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

procedure TFormMain.UpdateSheet1(Sender: TObject);
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

  if (cbb1BiaoZhunQi.ItemIndex >= 0) and (cbb1BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
    FXlses[1].SetCellValue(7, 2, FBiaoZhunQiValues[cbb1BiaoZhunQi.ItemIndex]);

  if (cbb1BeiHeCha.ItemIndex >= 0) and (cbb1BeiHeCha.ItemIndex < FBeiHeChaQiJuValues.Count) then
    FXlses[1].SetCellValue(7, 4, FBeiHeChaQiJuValues[cbb1BeiHeCha.ItemIndex]);

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

procedure TFormMain.UpdateSheet2(Sender: TObject);
var
  S: string;
begin
  S := Format('记录编号：%s', [edt2JiLuBianHao.Text]);
  FXlses[2].SetCellValue(2, 1, S);

  S := Format('气温：%s℃     湿度：%s％RH    风速：%sm/s',
    [edt2QiWen.Text, edt1ShiDu.Text, edt1FengSu.Text]);
  FXlses[2].SetCellValue(3, 2, S);

  if cbb2WaiGuanHeGe.ItemIndex = 0 then
    S := Format('%s合格                  %s 不合格', [#$2611, #$25A1])
  else
    S := Format('%s合格                  %s 不合格', [#$25A1, #$2611]);
  FXlses[2].SetCellValue(7, 2, S);

  FXlses[2].SetCellValue(4, 2, edt2KaiShiShiJian.Text);
  FXlses[2].SetCellValue(4, 5, edt2JieShuShiJian.Text);

  if (cbb2BiaoZhunQi.ItemIndex >= 0) and (cbb2BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
    FXlses[2].SetCellValue(6, 2, FBiaoZhunQiValues[cbb2BiaoZhunQi.ItemIndex]);

  if (cbb2BeiHeCha.ItemIndex >= 0) and (cbb2BeiHeCha.ItemIndex < FBeiHeChaQiJuValues.Count) then
    FXlses[2].SetCellValue(6, 4, FBeiHeChaQiJuValues[cbb2BeiHeCha.ItemIndex]);

  FXlses[2].SetCellValue(15, 2, S_ARR_HEGE[cbb2HeGe.ItemIndex]);
  if cbb2FuHeYaoQiu.ItemIndex = 0 then
    S := Format('%s 是        %s 否', [#$2611, #$25A1])
  else
    S := Format('%s 是        %s 否', [#$25A1, #$2611]);

  FXlses[2].SetCellValue(16, 2, cbb2HeChaYiJu.Items[cbb2HeChaYiJu.ItemIndex]);
  FXlses[2].SetCellValue(17, 2, S);

  FXlses[2].SetCellValue(18, 1, '校准：' + cbb2JiaoZhun.Items[cbb2JiaoZhun.ItemIndex]);
  FXlses[2].SetCellValue(18, 3, '核验：' + cbb2HeYan.Items[cbb2HeYan.ItemIndex]);
  FXlses[2].SetCellValue(18, 5, edt2JiaoZhunShiJian.Text);

  FcpSheet2.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet3(Sender: TObject);
begin
  //
end;

procedure TFormMain.UpdateSheet4(Sender: TObject);
begin
  //
end;

procedure TFormMain.UpdateSheet5(Sender: TObject);
begin
  //
end;

procedure TFormMain.UpdateSheet6(Sender: TObject);
begin
  //
end;

procedure TFormMain.UpdateSheet7(Sender: TObject);
begin
  //
end;

end.
