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
    ScrollBox1: TScrollBox;
    fcpSheet1: TFlexCelPreviewer;
    edt1JiLuBianHao: TEdit;
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
    cbb3FuHeYaoQiu: TComboBox;
    cbb3HeChaYiJu: TComboBox;
    cbb3HeGe: TComboBox;
    cbb3WaiGuanHeGe: TComboBox;
    cbb3BeiHeCha: TComboBox;
    cbb3BiaoZhunQi: TComboBox;
    edt3KaiShiShiJian: TEdit;
    edt3QiWen: TEdit;
    edt3ShiDu: TEdit;
    edt3FengSu: TEdit;
    edt3JieShuShiJian: TEdit;
    edt3JiLuBianHao: TEdit;
    lbl3BeiHeCha: TLabel;
    lbl3BiaoZhunQi: TLabel;
    cbb3JiaoZhun: TComboBox;
    edt3JiaoZhunShiJian: TEdit;
    cbb3HeYan: TComboBox;
    ts4: TTabSheet;
    ScrollBox4: TScrollBox;
    fcpSheet4: TFlexCelPreviewer;
    edt4JiLuBianHao: TEdit;
    edt4QiWen: TEdit;
    edt4ShiDu: TEdit;
    edt4FengSu: TEdit;
    edt4KaiShiShiJian: TEdit;
    edt4JieShuShiJian: TEdit;
    cbb4BeiHeCha: TComboBox;
    lbl4BeiHeCha: TLabel;
    cbb4BiaoZhunQi: TComboBox;
    lbl4BiaoZhunQi: TLabel;
    cbb4WaiGuanHeGe: TComboBox;
    cbb4HeGe: TComboBox;
    cbb4HeChaYiJu: TComboBox;
    cbb4FuHeYaoQiu: TComboBox;
    edt4JiaoZhunShiJian: TEdit;
    cbb4JiaoZhun: TComboBox;
    cbb4HeYan: TComboBox;
    ts5: TTabSheet;
    ScrollBox5: TScrollBox;
    fcpSheet5: TFlexCelPreviewer;
    edt5JiLuBianHao: TEdit;
    edt5QiWen: TEdit;
    edt5ShiDu: TEdit;
    edt5FengSu: TEdit;
    edt5JieShuShiJian: TEdit;
    edt5KaiShiShiJian: TEdit;
    cbb5BiaoZhunQi: TComboBox;
    lbl5BiaoZhunQi: TLabel;
    cbb5BeiHeCha: TComboBox;
    lbl5BeiHeCha: TLabel;
    cbb5WaiGuanHeGe: TComboBox;
    cbb5HeGe: TComboBox;
    cbb5HeChaYiJu: TComboBox;
    cbb5FuHeYaoQiu: TComboBox;
    edt5JiaoZhunShiJian: TEdit;
    cbb5JiaoZhun: TComboBox;
    cbb5HeYan: TComboBox;
    ts6: TTabSheet;
    ScrollBox6: TScrollBox;
    fcpSheet6: TFlexCelPreviewer;
    edt6JiLuBianHao: TEdit;
    edt6FengSu: TEdit;
    edt6ShiDu: TEdit;
    edt6QiWen: TEdit;
    edt6KaiShiShiJian: TEdit;
    edt6JieShuShiJian: TEdit;
    cbb6BiaoZhunQi: TComboBox;
    lbl6BiaoZhunQi: TLabel;
    lbl6BeiHeCha: TLabel;
    cbb6BeiHeCha: TComboBox;
    cbb6WaiGuanHeGe: TComboBox;
    cbb6HeGe: TComboBox;
    cbb6HeChaYiJu: TComboBox;
    cbb6FuHeYaoQiu: TComboBox;
    cbb6HeYan: TComboBox;
    cbb6JiaoZhun: TComboBox;
    edt6JiaoZhunShiJian: TEdit;
    ts7: TTabSheet;
    ScrollBox7: TScrollBox;
    fcpSheet7: TFlexCelPreviewer;
    edt7JiLuBianHao: TEdit;
    edt7QiWen: TEdit;
    edt7ShiDu: TEdit;
    edt7FengSu: TEdit;
    edt7JieShuShiJian: TEdit;
    edt7KaiShiShiJian: TEdit;
    cbb7BiaoZhunQi: TComboBox;
    cbb7BeiHeCha: TComboBox;
    lbl7BeiHeCha: TLabel;
    lbl7BiaoZhunQi: TLabel;
    cbb7WaiGuanHeGe: TComboBox;
    cbb7HeChaYiJu: TComboBox;
    cbb7FuHeYaoQiu: TComboBox;
    edt7JiaoZhunShiJian: TEdit;
    cbb7JiaoZhun: TComboBox;
    cbb7HeYan: TComboBox;

    pnlMain: TPanel;
    btnPDF: TSpeedButton;
    dlgSavePDF: TSaveDialog;
    btnToggleVisible: TSpeedButton;
    btnSettings: TSpeedButton;
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
    procedure FormDestroy(Sender: TObject);
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
  OFFSET_ARRAY: array[1..XLS_COUNT] of Integer = (0, -100, -130, -80, 0, -70, -150);

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

    FWSetting.StampTop := StrToInt(lbledtStampTop.Text);
    FWSetting.StampLeft := StrToInt(lbledtStampLeft.Text);
    FWSetting.StampWidth := StrToInt(lbledtStampWidth.Text);
    FWSetting.StampHeight := StrToInt(lbledtStampHeight.Text);

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

function LoadAndDrawStamp(Bmp: TBitmap; const FileName: string; Left, Top, Width, Height: Integer): Boolean;
var
  FileStream: TFileStream;
  PngImage: TPNGImage;
  R: TRect;
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
      R := Rect(Left, Top, Left + Width, Top + Height);
      Bmp.Canvas.StretchDraw(R, PngImage);
      // Bmp.Canvas.Draw(Left, Top, PngImage);
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
          FWSetting.StampTop, FWSetting.StampWidth, FWSetting.StampHeight) then
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

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FBiaoZhunQiNames.Free;
  FBiaoZhunQiValues.Free;

  FBeiHeChaQiJuNames.Free;
  FBeiHeChaQiJuValues.Free;

  FJiaoZhun.Free;
  FHeYan.Free;
  FHeChaYiJu.Free;
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
  edt3JiaoZhunShiJian.Text := FormatDateTime('yyyy年MM月dd日', Now());

  cbb3BiaoZhunQi.Items.Assign(FBiaoZhunQiNames);

  cbb3BeiHeCha.Items.Assign(FBeiHeChaQiJuNames);

  cbb3JiaoZhun.Items.Assign(FJiaoZhun);
  if cbb3JiaoZhun.Items.Count > 0 then
    cbb3JiaoZhun.ItemIndex := 0;

  cbb3HeYan.Items.Assign(FHeYan);
  if cbb3HeYan.Items.Count > 0 then
    cbb3HeYan.ItemIndex := 0;

  cbb3HeChaYiJu.Items.Assign(FHeChaYiJu);
  if cbb3HeChaYiJu.Items.Count > 0 then
    cbb3HeChaYiJu.ItemIndex := 0;
end;

procedure TFormMain.Init4;
begin
  edt4JiaoZhunShiJian.Text := FormatDateTime('yyyy年MM月dd日', Now());

  cbb4BiaoZhunQi.Items.Assign(FBiaoZhunQiNames);

  cbb4BeiHeCha.Items.Assign(FBeiHeChaQiJuNames);

  cbb4JiaoZhun.Items.Assign(FJiaoZhun);
  if cbb4JiaoZhun.Items.Count > 0 then
    cbb4JiaoZhun.ItemIndex := 0;

  cbb4HeYan.Items.Assign(FHeYan);
  if cbb4HeYan.Items.Count > 0 then
    cbb4HeYan.ItemIndex := 0;

  cbb4HeChaYiJu.Items.Assign(FHeChaYiJu);
  if cbb4HeChaYiJu.Items.Count > 0 then
    cbb4HeChaYiJu.ItemIndex := 0;
end;

procedure TFormMain.Init5;
begin
  edt5JiaoZhunShiJian.Text := FormatDateTime('yyyy年MM月dd日', Now());

  cbb5BiaoZhunQi.Items.Assign(FBiaoZhunQiNames);

  cbb5BeiHeCha.Items.Assign(FBeiHeChaQiJuNames);

  cbb5JiaoZhun.Items.Assign(FJiaoZhun);
  if cbb5JiaoZhun.Items.Count > 0 then
    cbb5JiaoZhun.ItemIndex := 0;

  cbb5HeYan.Items.Assign(FHeYan);
  if cbb5HeYan.Items.Count > 0 then
    cbb5HeYan.ItemIndex := 0;

  cbb5HeChaYiJu.Items.Assign(FHeChaYiJu);
  if cbb5HeChaYiJu.Items.Count > 0 then
    cbb5HeChaYiJu.ItemIndex := 0;
end;

procedure TFormMain.Init6;
begin
  edt6JiaoZhunShiJian.Text := FormatDateTime('yyyy年MM月dd日', Now());

  cbb6BiaoZhunQi.Items.Assign(FBiaoZhunQiNames);

  cbb6BeiHeCha.Items.Assign(FBeiHeChaQiJuNames);

  cbb6JiaoZhun.Items.Assign(FJiaoZhun);
  if cbb6JiaoZhun.Items.Count > 0 then
    cbb6JiaoZhun.ItemIndex := 0;

  cbb6HeYan.Items.Assign(FHeYan);
  if cbb6HeYan.Items.Count > 0 then
    cbb6HeYan.ItemIndex := 0;

  cbb6HeChaYiJu.Items.Assign(FHeChaYiJu);
  if cbb6HeChaYiJu.Items.Count > 0 then
    cbb6HeChaYiJu.ItemIndex := 0;
end;

procedure TFormMain.Init7;
begin
  edt7JiaoZhunShiJian.Text := FormatDateTime('yyyy年MM月dd日', Now());

  cbb7BiaoZhunQi.Items.Assign(FBiaoZhunQiNames);

  cbb7BeiHeCha.Items.Assign(FBeiHeChaQiJuNames);

  cbb7JiaoZhun.Items.Assign(FJiaoZhun);
  if cbb7JiaoZhun.Items.Count > 0 then
    cbb7JiaoZhun.ItemIndex := 0;

  cbb7HeYan.Items.Assign(FHeYan);
  if cbb7HeYan.Items.Count > 0 then
    cbb7HeYan.ItemIndex := 0;

  cbb7HeChaYiJu.Items.Assign(FHeChaYiJu);
  if cbb7HeChaYiJu.Items.Count > 0 then
    cbb7HeChaYiJu.ItemIndex := 0;
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
      16, OFFSET_ARRAY[Index], 4, 50, 256, 236, FXlses[Index]);
      // 行、行偏移像素、列、列偏移像素、高、宽、XLS实例
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
    [edt2QiWen.Text, edt2ShiDu.Text, edt2FengSu.Text]);
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
var
  S: string;
begin
  S := Format('记录编号：%s', [edt3JiLuBianHao.Text]);
  FXlses[3].SetCellValue(3, 3, S);

  S := Format('气温：%s℃     湿度：%s％RH    风速：%sm/s',
    [edt3QiWen.Text, edt3ShiDu.Text, edt3FengSu.Text]);
  FXlses[3].SetCellValue(4, 2, S);

  if cbb3WaiGuanHeGe.ItemIndex = 0 then
    S := Format('%s合格                  %s 不合格', [#$2611, #$25A1])
  else
    S := Format('%s合格                  %s 不合格', [#$25A1, #$2611]);
  FXlses[3].SetCellValue(8, 2, S);

  FXlses[3].SetCellValue(5, 2, edt3KaiShiShiJian.Text);
  FXlses[3].SetCellValue(5, 5, edt3JieShuShiJian.Text);

  if (cbb3BiaoZhunQi.ItemIndex >= 0) and (cbb3BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
    FXlses[3].SetCellValue(7, 2, FBiaoZhunQiValues[cbb3BiaoZhunQi.ItemIndex]);

  if (cbb3BeiHeCha.ItemIndex >= 0) and (cbb3BeiHeCha.ItemIndex < FBeiHeChaQiJuValues.Count) then
    FXlses[3].SetCellValue(7, 4, FBeiHeChaQiJuValues[cbb3BeiHeCha.ItemIndex]);

  FXlses[3].SetCellValue(13, 3, S_ARR_HEGE[cbb3HeGe.ItemIndex]);
  if cbb3FuHeYaoQiu.ItemIndex = 0 then
    S := Format('%s 是        %s 否', [#$2611, #$25A1])
  else
    S := Format('%s 是        %s 否', [#$25A1, #$2611]);

  FXlses[3].SetCellValue(14, 3, cbb3HeChaYiJu.Items[cbb3HeChaYiJu.ItemIndex]);
  FXlses[3].SetCellValue(15, 3, S);

  FXlses[3].SetCellValue(16, 1, '校准：' + cbb3JiaoZhun.Items[cbb3JiaoZhun.ItemIndex]);
  FXlses[3].SetCellValue(16, 3, '核验：' + cbb3HeYan.Items[cbb3HeYan.ItemIndex]);
  FXlses[3].SetCellValue(16, 5, edt3JiaoZhunShiJian.Text);

  FcpSheet3.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet4(Sender: TObject);
var
  S: string;
begin
  S := Format('记录编号：%s', [edt4JiLuBianHao.Text]);
  FXlses[4].SetCellValue(3, 3, S);

  S := Format('气温：%s℃     湿度：%s％RH    风速：%sm/s',
    [edt4QiWen.Text, edt4ShiDu.Text, edt4FengSu.Text]);
  FXlses[4].SetCellValue(4, 2, S);

  if cbb4WaiGuanHeGe.ItemIndex = 0 then
    S := Format('%s合格                  %s 不合格', [#$2611, #$25A1])
  else
    S := Format('%s合格                  %s 不合格', [#$25A1, #$2611]);
  FXlses[4].SetCellValue(8, 2, S);

  FXlses[4].SetCellValue(5, 2, edt4KaiShiShiJian.Text);
  FXlses[4].SetCellValue(5, 5, edt4JieShuShiJian.Text);

  if (cbb4BiaoZhunQi.ItemIndex >= 0) and (cbb4BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
    FXlses[4].SetCellValue(7, 2, FBiaoZhunQiValues[cbb4BiaoZhunQi.ItemIndex]);

  if (cbb4BeiHeCha.ItemIndex >= 0) and (cbb4BeiHeCha.ItemIndex < FBeiHeChaQiJuValues.Count) then
    FXlses[4].SetCellValue(7, 4, FBeiHeChaQiJuValues[cbb4BeiHeCha.ItemIndex]);

  FXlses[4].SetCellValue(15, 3, S_ARR_HEGE[cbb4HeGe.ItemIndex]);
  if cbb4FuHeYaoQiu.ItemIndex = 0 then
    S := Format('%s 是        %s 否', [#$2611, #$25A1])
  else
    S := Format('%s 是        %s 否', [#$25A1, #$2611]);

  FXlses[4].SetCellValue(16, 3, cbb4HeChaYiJu.Items[cbb4HeChaYiJu.ItemIndex]);
  FXlses[4].SetCellValue(17, 3, S);

  FXlses[4].SetCellValue(18, 1, '校准：' + cbb4JiaoZhun.Items[cbb4JiaoZhun.ItemIndex]);
  FXlses[4].SetCellValue(18, 3, '核验：' + cbb4HeYan.Items[cbb4HeYan.ItemIndex]);
  FXlses[4].SetCellValue(18, 5, edt4JiaoZhunShiJian.Text);

  FcpSheet4.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet5(Sender: TObject);
var
  S: string;
begin
  S := Format('记录编号：%s', [edt5JiLuBianHao.Text]);
  FXlses[5].SetCellValue(3, 4, S);

  S := Format('气温：%s℃     湿度：%s％RH    风速：%sm/s',
    [edt5QiWen.Text, edt5ShiDu.Text, edt5FengSu.Text]);
  FXlses[5].SetCellValue(4, 2, S);

  if cbb5WaiGuanHeGe.ItemIndex = 0 then
    S := Format('%s合格                  %s 不合格', [#$2611, #$25A1])
  else
    S := Format('%s合格                  %s 不合格', [#$25A1, #$2611]);
  FXlses[5].SetCellValue(8, 2, S);

  FXlses[5].SetCellValue(5, 2, edt5KaiShiShiJian.Text);
  FXlses[5].SetCellValue(5, 5, edt5JieShuShiJian.Text);

  if (cbb5BiaoZhunQi.ItemIndex >= 0) and (cbb5BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
    FXlses[5].SetCellValue(7, 2, FBiaoZhunQiValues[cbb5BiaoZhunQi.ItemIndex]);

  if (cbb5BeiHeCha.ItemIndex >= 0) and (cbb5BeiHeCha.ItemIndex < FBeiHeChaQiJuValues.Count) then
    FXlses[5].SetCellValue(7, 4, FBeiHeChaQiJuValues[cbb5BeiHeCha.ItemIndex]);

  FXlses[5].SetCellValue(19, 3, S_ARR_HEGE[cbb5HeGe.ItemIndex]);
  if cbb5FuHeYaoQiu.ItemIndex = 0 then
    S := Format('%s 是        %s 否', [#$2611, #$25A1])
  else
    S := Format('%s 是        %s 否', [#$25A1, #$2611]);

  FXlses[5].SetCellValue(20, 3, cbb5HeChaYiJu.Items[cbb5HeChaYiJu.ItemIndex]);
  FXlses[5].SetCellValue(21, 3, S);

  FXlses[5].SetCellValue(22, 1, '校准：' + cbb5JiaoZhun.Items[cbb5JiaoZhun.ItemIndex]);
  FXlses[5].SetCellValue(22, 3, '核验：' + cbb5HeYan.Items[cbb5HeYan.ItemIndex]);
  FXlses[5].SetCellValue(22, 5, edt5JiaoZhunShiJian.Text);

  FcpSheet5.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet6(Sender: TObject);
var
  S: string;
begin
  S := Format('记录编号：%s', [edt6JiLuBianHao.Text]);
  FXlses[6].SetCellValue(3, 4, S);

  S := Format('气温：%s℃     湿度：%s％RH    风速：%sm/s',
    [edt6QiWen.Text, edt6ShiDu.Text, edt6FengSu.Text]);
  FXlses[6].SetCellValue(4, 2, S);

  if cbb6WaiGuanHeGe.ItemIndex = 0 then
    S := Format('%s合格                  %s 不合格', [#$2611, #$25A1])
  else
    S := Format('%s合格                  %s 不合格', [#$25A1, #$2611]);
  FXlses[6].SetCellValue(8, 2, S);

  FXlses[6].SetCellValue(5, 2, edt6KaiShiShiJian.Text);
  FXlses[6].SetCellValue(5, 5, edt6JieShuShiJian.Text);

  if (cbb6BiaoZhunQi.ItemIndex >= 0) and (cbb6BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
    FXlses[6].SetCellValue(7, 2, FBiaoZhunQiValues[cbb6BiaoZhunQi.ItemIndex]);

  if (cbb6BeiHeCha.ItemIndex >= 0) and (cbb6BeiHeCha.ItemIndex < FBeiHeChaQiJuValues.Count) then
    FXlses[6].SetCellValue(7, 4, FBeiHeChaQiJuValues[cbb6BeiHeCha.ItemIndex]);

  FXlses[6].SetCellValue(16, 3, S_ARR_HEGE[cbb6HeGe.ItemIndex]);
  if cbb6FuHeYaoQiu.ItemIndex = 0 then
    S := Format('%s 是        %s 否', [#$2611, #$25A1])
  else
    S := Format('%s 是        %s 否', [#$25A1, #$2611]);

  FXlses[6].SetCellValue(17, 3, cbb6HeChaYiJu.Items[cbb6HeChaYiJu.ItemIndex]);
  FXlses[6].SetCellValue(18, 3, S);

  FXlses[6].SetCellValue(19, 2, cbb6JiaoZhun.Items[cbb6JiaoZhun.ItemIndex]);
  FXlses[6].SetCellValue(19, 3, '核验：' + cbb6HeYan.Items[cbb6HeYan.ItemIndex]);
  FXlses[6].SetCellValue(19, 5, edt6JiaoZhunShiJian.Text);

  FcpSheet6.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet7(Sender: TObject);
var
  S: string;
begin
  S := Format('记录编号：%s', [edt7JiLuBianHao.Text]);
  FXlses[7].SetCellValue(3, 4, S);

  S := Format('气温：%s℃     湿度：%s％RH    风速：%sm/s',
    [edt7QiWen.Text, edt7ShiDu.Text, edt7FengSu.Text]);
  FXlses[7].SetCellValue(4, 2, S);

  if cbb7WaiGuanHeGe.ItemIndex = 0 then
    S := Format('%s合格                  %s 不合格', [#$2611, #$25A1])
  else
    S := Format('%s合格                  %s 不合格', [#$25A1, #$2611]);
  FXlses[7].SetCellValue(8, 2, S);

  FXlses[7].SetCellValue(5, 2, edt7KaiShiShiJian.Text);
  FXlses[7].SetCellValue(5, 5, edt7JieShuShiJian.Text);

  if (cbb7BiaoZhunQi.ItemIndex >= 0) and (cbb7BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
    FXlses[7].SetCellValue(7, 2, FBiaoZhunQiValues[cbb7BiaoZhunQi.ItemIndex]);

  if (cbb7BeiHeCha.ItemIndex >= 0) and (cbb7BeiHeCha.ItemIndex < FBeiHeChaQiJuValues.Count) then
    FXlses[7].SetCellValue(7, 4, FBeiHeChaQiJuValues[cbb7BeiHeCha.ItemIndex]);

  // FXlses[7].SetCellValue(16, 3, S_ARR_HEGE[cbb7HeGe.ItemIndex]);
  if cbb7FuHeYaoQiu.ItemIndex = 0 then
    S := Format('%s 是        %s 否', [#$2611, #$25A1])
  else
    S := Format('%s 是        %s 否', [#$25A1, #$2611]);

  FXlses[7].SetCellValue(14, 3, cbb7HeChaYiJu.Items[cbb7HeChaYiJu.ItemIndex]);
  FXlses[7].SetCellValue(15, 3, S);

  FXlses[7].SetCellValue(16, 2, cbb7JiaoZhun.Items[cbb7JiaoZhun.ItemIndex]);
  FXlses[7].SetCellValue(16, 3, '核验：' + cbb7HeYan.Items[cbb7HeYan.ItemIndex]);
  FXlses[7].SetCellValue(16, 5, edt7JiaoZhunShiJian.Text);

  FcpSheet7.InvalidatePreview;
end;

end.
