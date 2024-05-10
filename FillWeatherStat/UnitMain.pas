unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.FlexCel.Core, FlexCel.XlsAdapter, FlexCel.Pdf,
  FlexCel.Render, FlexCel.Preview, Vcl.ComCtrls, Vcl.Imaging.pngimage, _UMiscClasses.TImageProperties,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.Buttons, Vcl.Mask;

const
  XLS_COUNT = 8;

type
  TFormMain = class(TForm)
    pgcMain: TPageControl;
    ts1: TTabSheet;
    ScrollBox1: TScrollBox;
    fcpSheet1: TFlexCelPreviewer;
    edt1JiLuBianHao: TEdit;
    lbl1BeiHeCha: TLabel;
    edt1QiWen: TEdit;
    edt1ShiDu: TEdit;
    edt1FengSu: TEdit;
    edt1KaiShiShiJian: TMaskEdit;
    edt1JieShuShiJian: TMaskEdit;
    cbb1HeGe: TComboBox;
    edt1JiaoZhunShiJian: TEdit;
    cbb1BeiHeCha: TComboBox;
    cbb1WaiGuanHeGe: TComboBox;
    cbb1FuHeYaoQiu: TComboBox;
    cbb1JiaoZhun: TComboBox;
    cbb1HeYan: TComboBox;
    cbb1HeChaYiJu: TComboBox;
    edt1BeiHeCha1: TEdit;
    edt1BeiHeCha2: TEdit;
    edt1BeiHeCha3: TEdit;
    edt1XiuZhengZhi1: TEdit;
    edt1XiuZhengZhi2: TEdit;
    edt1XiuZhengZhi3: TEdit;
    edt1BiaoZhunZhi1: TEdit;
    edt1BiaoZhunZhi2: TEdit;
    edt1BiaoZhunZhi3: TEdit;
    edt1BiaoZhunZhi4: TEdit;
    edt1BiaoZhunZhi5: TEdit;
    edt1BiaoZhunZhi6: TEdit;
    edt1BiaoZhunZhi7: TEdit;
    edt1BiaoZhunZhi8: TEdit;
    edt1BiaoZhunZhi9: TEdit;
    ts2: TTabSheet;
    ScrollBox2: TScrollBox;
    fcpSheet2: TFlexCelPreviewer;
    edt2JiLuBianHao: TEdit;
    edt2QiWen: TEdit;
    edt2ShiDu: TEdit;
    edt2FengSu: TEdit;
    edt2KaiShiShiJian: TMaskEdit;
    edt2JieShuShiJian: TMaskEdit;
    cbb2BeiHeCha: TComboBox;
    cbb2WaiGuanHeGe: TComboBox;
    cbb2HeGe: TComboBox;
    cbb2HeChaYiJu: TComboBox;
    cbb2FuHeYaoQiu: TComboBox;
    cbb2JiaoZhun: TComboBox;
    cbb2HeYan: TComboBox;
    edt2JiaoZhunShiJian: TEdit;
    lbl2BeiHeCha: TLabel;
    edt2BiaoZhunZhi1: TEdit;
    edt2BiaoZhunZhi2: TEdit;
    edt2BiaoZhunZhi3: TEdit;
    edt2BiaoZhunZhi4: TEdit;
    edt2BiaoZhunZhi5: TEdit;
    edt2BiaoZhunZhi6: TEdit;
    edt2XiuZhengZhi1: TEdit;
    edt2XiuZhengZhi2: TEdit;
    edt2BeiHeCha1: TEdit;
    edt2BeiHeCha2: TEdit;
    ts3: TTabSheet;
    ScrollBox3: TScrollBox;
    fcpSheet3: TFlexCelPreviewer;
    cbb3FuHeYaoQiu: TComboBox;
    cbb3HeChaYiJu: TComboBox;
    cbb3HeGe: TComboBox;
    cbb3WaiGuanHeGe: TComboBox;
    cbb3BeiHeCha: TComboBox;
    edt3KaiShiShiJian: TMaskEdit;
    edt3QiWen: TEdit;
    edt3ShiDu: TEdit;
    edt3FengSu: TEdit;
    edt3JieShuShiJian: TMaskEdit;
    edt3JiLuBianHao: TEdit;
    lbl3BeiHeCha: TLabel;
    cbb3JiaoZhun: TComboBox;
    edt3JiaoZhunShiJian: TEdit;
    cbb3HeYan: TComboBox;
    edt3BeiHeCha1: TEdit;
    edt3BeiHeCha2: TEdit;
    edt3BeiHeCha3: TEdit;
    ts4: TTabSheet;
    ScrollBox4: TScrollBox;
    fcpSheet4: TFlexCelPreviewer;
    edt4JiLuBianHao: TEdit;
    edt4QiWen: TEdit;
    edt4ShiDu: TEdit;
    edt4FengSu: TEdit;
    edt4KaiShiShiJian: TMaskEdit;
    edt4JieShuShiJian: TMaskEdit;
    cbb4BeiHeCha: TComboBox;
    lbl4BeiHeCha: TLabel;
    cbb4WaiGuanHeGe: TComboBox;
    cbb4HeGe: TComboBox;
    cbb4HeChaYiJu: TComboBox;
    cbb4FuHeYaoQiu: TComboBox;
    edt4JiaoZhunShiJian: TEdit;
    cbb4JiaoZhun: TComboBox;
    cbb4HeYan: TComboBox;
    cbb4JieGuoHeGe1: TComboBox;
    cbb4JieGuoHeGe2: TComboBox;
    cbb4JieGuoHeGe3: TComboBox;
    cbb4JieGuoHeGe4: TComboBox;
    cbb4JieGuoHeGe5: TComboBox;
    edt4BiaoZhunZhi1: TEdit;
    edt4BiaoZhunZhi2: TEdit;
    edt4BiaoZhunZhi3: TEdit;
    edt4BiaoZhunZhi4: TEdit;
    edt4BiaoZhunZhi5: TEdit;
    edt4BeiHeCha1: TEdit;
    edt4BeiHeCha2: TEdit;
    edt4BeiHeCha3: TEdit;
    edt4BeiHeCha4: TEdit;
    edt4BeiHeCha5: TEdit;
    ts5: TTabSheet;
    ScrollBox5: TScrollBox;
    fcpSheet5: TFlexCelPreviewer;
    edt5JiLuBianHao: TEdit;
    edt5QiWen: TEdit;
    edt5ShiDu: TEdit;
    edt5FengSu: TEdit;
    edt5JieShuShiJian: TMaskEdit;
    edt5KaiShiShiJian: TMaskEdit;
    cbb5BeiHeCha: TComboBox;
    lbl5BeiHeCha: TLabel;
    cbb5WaiGuanHeGe: TComboBox;
    cbb5HeGe: TComboBox;
    cbb5HeChaYiJu: TComboBox;
    cbb5FuHeYaoQiu: TComboBox;
    edt5JiaoZhunShiJian: TEdit;
    cbb5JiaoZhun: TComboBox;
    cbb5HeYan: TComboBox;
    edt5BeiHeCha1: TEdit;
    edt5BeiHeCha2: TEdit;
    edt5BeiHeCha3: TEdit;
    edt5XiuZhengZhi1: TEdit;
    edt5XiuZhengZhi2: TEdit;
    edt5XiuZhengZhi3: TEdit;
    edt5BiaoZhunZhi1: TEdit;
    edt5BiaoZhunZhi2: TEdit;
    edt5BiaoZhunZhi3: TEdit;
    edt5BiaoZhunZhi6: TEdit;
    edt5BiaoZhunZhi5: TEdit;
    edt5BiaoZhunZhi4: TEdit;
    edt5BiaoZhunZhi7: TEdit;
    edt5BiaoZhunZhi8: TEdit;
    edt5BiaoZhunZhi9: TEdit;
    ts6: TTabSheet;
    ScrollBox6: TScrollBox;
    fcpSheet6: TFlexCelPreviewer;
    edt6JiLuBianHao: TEdit;
    edt6FengSu: TEdit;
    edt6ShiDu: TEdit;
    edt6QiWen: TEdit;
    edt6KaiShiShiJian: TMaskEdit;
    edt6JieShuShiJian: TMaskEdit;
    lbl6BeiHeCha: TLabel;
    cbb6BeiHeCha: TComboBox;
    cbb6WaiGuanHeGe: TComboBox;
    cbb6HeGe: TComboBox;
    cbb6HeChaYiJu: TComboBox;
    cbb6FuHeYaoQiu: TComboBox;
    cbb6HeYan: TComboBox;
    cbb6JiaoZhun: TComboBox;
    edt6JiaoZhunShiJian: TEdit;
    edt6ChuanGanQi1: TEdit;
    edt6ChuanGanQi2: TEdit;
    edt6ChuanGanQi3: TEdit;
    edt6ChuanGanQi4: TEdit;
    edt6ChuanGanQi5: TEdit;
    edt6ChuanGanQi6: TEdit;
    ts7: TTabSheet;
    ScrollBox7: TScrollBox;
    fcpSheet7: TFlexCelPreviewer;
    edt7JiLuBianHao: TEdit;
    edt7QiWen: TEdit;
    edt7ShiDu: TEdit;
    edt7FengSu: TEdit;
    edt7JieShuShiJian: TMaskEdit;
    edt7KaiShiShiJian: TMaskEdit;
    cbb7BeiHeCha: TComboBox;
    lbl7BeiHeCha: TLabel;
    cbb7WaiGuanHeGe: TComboBox;
    cbb7HeChaYiJu: TComboBox;
    cbb7FuHeYaoQiu: TComboBox;
    edt7JiaoZhunShiJian: TEdit;
    cbb7JiaoZhun: TComboBox;
    cbb7HeYan: TComboBox;
    edt7BiaoZhunZhi1: TEdit;
    edt7BiaoZhunZhi2: TEdit;
    edt7BiaoZhunZhi3: TEdit;
    edt7HeChaJieGuo: TEdit;
    edt7ZuiDaYunXuZhi: TEdit;

    ts8: TTabSheet;
    ScrollBox8: TScrollBox;
    fcpSheet8: TFlexCelPreviewer;
    edt8JiLuBianHao: TEdit;
    edt8QiWen: TEdit;
    edt8ShiDu: TEdit;
    edt8YaLi: TEdit;
    edt8KaiShiShiJian: TMaskEdit;
    edt8JieShuShiJian: TMaskEdit;
    cbb8BeiHeCha: TComboBox;
    lbl8BeiHeCha: TLabel;
    cbb8WaiGuanHeGe: TComboBox;
    cbb8FuHeYaoQiu: TComboBox;
    cbb8HeChaYiJu: TComboBox;
    cbb8JiaoZhun: TComboBox;
    cbb8HeYan: TComboBox;
    edt8JiaoZhunShiJian: TEdit;
    edt8NengRuDu1: TEdit;
    edt8NengRuDu2: TEdit;

    pnlMain: TPanel;
    btnPDF: TSpeedButton;
    dlgSavePDF: TSaveDialog;
    btnToggleVisible: TSpeedButton;
    btnSettings: TSpeedButton;
    btnStamp: TSpeedButton;
    dlgOpenForStamp: TOpenDialog;
    dlgSaveStamp: TSaveDialog;
    chkImage: TCheckBox;
    lbl8BiaoZhunQi: TLabel;
    cbb8BiaoZhunQi: TComboBox;
    edt8BiaoChenZhi1: TEdit;
    edt8BiaoChenZhi2: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
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
    procedure UpdateSheet8(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
  private
    FIniting: Boolean;
    FSettingFile: string;
    FValueFile: string;
    FStampFile: string;
    FStampIndexes: array[1..XLS_COUNT] of Integer;
    FStampAddeds: array[1..XLS_COUNT] of Boolean;
    FXlses: array[1..XLS_COUNT] of TExcelFile;
    FImgExports: array[1..XLS_COUNT] of TFlexCelImgExport;
    FBiaoZhunQiNames, FBiaoZhunQiValues: TStringList;
    FNengJianDuBiaoZhunQiNames, FNengJianDuBiaoZhunQiValues: TStringList;
    FBeiHeChaQiJuNames1, FBeiHeChaQiJuValues1: TStringList;
    FBeiHeChaQiJuNames2, FBeiHeChaQiJuValues2: TStringList;
    FBeiHeChaQiJuNames3, FBeiHeChaQiJuValues3: TStringList;
    FBeiHeChaQiJuNames4, FBeiHeChaQiJuValues4: TStringList;
    FBeiHeChaQiJuNames5, FBeiHeChaQiJuValues5: TStringList;
    FBeiHeChaQiJuNames6, FBeiHeChaQiJuValues6: TStringList;
    FBeiHeChaQiJuNames7, FBeiHeChaQiJuValues7: TStringList;
    FBeiHeChaQiJuNames8, FBeiHeChaQiJuValues8: TStringList;
    FHeChaYiJu, FJiaoZhun, FHeYan: TStringList;
    function ExtractBianHao(const CellValue: string): string;
    function CalcCurrentBianhao(const QuZhanHao: string): string;
    function MyStrToDate(const Str: string): TDate;
    procedure ToggleSheet(Index: Integer);
    function ToggleSheetControlsVisible(Prev: TFlexCelPreviewer): Boolean;
  protected
    procedure SetNumberValue(Xls: TExcelFile; Row, Col: Integer; const Value: string);
    procedure InsertStamp(Index: Integer);
    procedure DeleteStamp(Index: Integer);
    function PreviewerByIndex(Index: Integer): TFlexCelPreviewer;
    function CurrentPreviewer: TFlexCelPreviewer;
    function CurrentBeiHeCha: TComboBox;

    procedure LoadValues;
    procedure SaveValues;
  public
    procedure Init0;
    procedure Init1;
    procedure Init2;
    procedure Init3;
    procedure Init4;
    procedure Init5;
    procedure Init6;
    procedure Init7;
    procedure Init8;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  UnitSettingForm, UnitSetting, CnJSON;

const
  S_Gai_Zhang_Cheng_Gong = '盖章成功！';
  S_Ti_Shi = '提示';
  S_Biao_Zhun_Qi = '标准器';
  S_Neng_Jian_Du_Biao_Zhun_Qi = '能见度标准器';
  S_Bei_He_Cha_Qi_Ju1 = '被核查器具气温';
  S_Bei_He_Cha_Qi_Ju2 = '被核查器具湿度';
  S_Bei_He_Cha_Qi_Ju3 = '被核查器具风向';
  S_Bei_He_Cha_Qi_Ju4 = '被核查器具风速';
  S_Bei_He_Cha_Qi_Ju5 = '被核查器具气压';
  S_Bei_He_Cha_Qi_Ju6 = '被核查器具雨量';
  S_Bei_He_Cha_Qi_Ju7 = '被核查器具起动风';
  S_Bei_He_Cha_Qi_Ju8 = '被核查器具能见度';
  S_Xiao_Zhun_Ren = '校准人';
  S_He_Yan_Ren = '核验人';
  S_He_Cha_Yi_Ju = '核查依据';
  S_Yyyy_Nian_Mm_Yue_Dd_Ri = 'yyyy年MM月dd日';
  S_No_Fcpsheet_For = 'NO FcpSheet for ';
  S_No_Combo_For = 'NO ComboBox for ';
  S_Ji_Lu_Bian_Hao_S = '记录编号：%s';
  S_Qi_Wen_S_Shi_Dong_S_Rh_Feng_Su = '气温：%s℃     湿度：%s％RH    风速：%sm/s';
  S_Qi_Wen_S_Ya_Li_S_Shi_Du = '气温：%s℃  压力：%shpa   湿度：%s％RH';
  S_S_He_Ge_S_Bu_He_Ge = '%s合格                  %s 不合格';
  S_S_Shi_S_Fou = '%s 是        %s 否';
  S_Xiao_Zhun = '校准：';
  S_He_Yan = '核验：';

const
  S_F_SET = 'Setting.json';
  S_F_VALUE = 'Value.json';
  S_F_STAMP = 'stamp.png';
  S_ARR_HEGE: array[0..1] of string = ('合格', '不合格');
  S_BIANHAO_FMT: array[1..XLS_COUNT] of string = (
    'G-%s-H(T)%s0101',
    'G-%s-H(TH)%s0101',
    'G-%s-H(VX)%s0101',
    'G-%s-H(VS)%s0101',
    'G-%s-H(P)%s0101',
    'G-%s-H(R)%s0101',
    'G-%s-H(VS)%s0201',
    'G-%s-H(V)%s0101'
  );
  OFFSET_ARRAY: array[1..XLS_COUNT] of Integer = (-33, -100, -150, -110, 0, -70, -150, -160);

var
  XLS_FILES: array[1..XLS_COUNT] of string;

procedure TFormMain.btnPDFClick(Sender: TObject);
var
  Pdf: TFlexCelPdfExport;
  Idx: Integer;
  Combo: TComboBox;
  S: string;
begin
  S := '表格.pdf';
  Combo := CurrentBeiHeCha;
  if Combo.ItemIndex >= 0 then
    S := Combo.Items[Combo.ItemIndex] + '.pdf';

  dlgSavePDF.FileName := S;
  if dlgSavePDF.Execute then
  begin
    Idx := pgcMain.ActivePageIndex + 1;
    if chkImage.Checked then
      InsertStamp(Idx)
    else
      DeleteStamp(Idx);

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
            Application.MessageBox(S_Gai_Zhang_Cheng_Gong, S_Ti_Shi, MB_OK + MB_ICONINFORMATION);
          end;
        end;
      end;
    finally
      Bmp.Free;
    end;
  end;
end;

function TFormMain.ToggleSheetControlsVisible(Prev: TFlexCelPreviewer): Boolean;
var
  V: Boolean;
  I: Integer;
begin
  Result := False;
  V := False;
  for I := 0 to Prev.ControlCount - 1 do
  begin
    if (Prev.Controls[I] is TEdit) or (Prev.Controls[I] is TComboBox) or
      (Prev.Controls[I] is TRadioGroup) or (Prev.Controls[I] is TLabel) or
      (Prev.Controls[I] is TMaskEdit) then
    begin
      V := Prev.Controls[I].Visible;
      Break;
    end;
  end;

  for I := 0 to Prev.ControlCount - 1 do
  begin
    if (Prev.Controls[I] is TEdit) or (Prev.Controls[I] is TComboBox) or
      (Prev.Controls[I] is TRadioGroup) or (Prev.Controls[I] is TLabel) or
      (Prev.Controls[I] is TMaskEdit) then
    begin
      Prev.Controls[I].Visible := not V;
      Result := Prev.Controls[I].Visible;
    end;
  end;
end;

procedure TFormMain.ToggleSheet(Index: Integer);
var
  Sht: TFlexCelPreviewer;
begin
  Sht := FindComponent('fcpSheet' +IntToStr(Index)) as TFlexCelPreviewer;

  if ToggleSheetControlsVisible(Sht) then
  begin
    if FStampAddeds[Index] then
    begin
      FXlses[Index].DeleteImage(FStampIndexes[Index]);
      Dec(FStampIndexes[Index]);
      FStampAddeds[Index] := False;
    end;
    Sht.InvalidatePreview;
  end
  else
  begin
    if chkImage.Checked then
      InsertStamp(Index);
  end;
end;

procedure TFormMain.btnToggleVisibleClick(Sender: TObject);
begin
  ToggleSheet(pgcMain.ActivePageIndex + 1);
end;

function TFormMain.CalcCurrentBianhao(const QuZhanHao: string): string;
var
  Idx: Integer;
  Dt: TDateTime;
  S: string;
  Edt: TEdit;
begin
  Idx := pgcMain.ActivePageIndex + 1;
  S := 'edt' + IntToStr(Idx) + 'JiaoZhunShiJian';
  Edt := FindComponent(S) as TEdit;
  Dt := MyStrToDate(Edt.Text);

  S := FormatDateTime('yyMMdd', Dt);
  Result := Format(S_BIANHAO_FMT[Idx], [QuZhanHao, S]);
end;

function TFormMain.CurrentBeiHeCha: TComboBox;
var
  Idx: Integer;
begin
  Idx := pgcMain.ActivePageIndex + 1;
  Result := FindComponent('cbb' + IntToStr(Idx) + 'BeiHeCha') as TComboBox;
  if Result = nil then
    raise Exception.Create(S_No_Combo_For + IntToStr(Idx));
end;

function TFormMain.CurrentPreviewer: TFlexCelPreviewer;
begin
  Result := PreviewerByIndex(pgcMain.ActivePageIndex + 1);
end;

procedure TFormMain.DeleteStamp(Index: Integer);
begin
  if FStampAddeds[Index] then
  begin
    FXlses[Index].DeleteImage(FStampIndexes[Index]);
    Dec(FStampIndexes[Index]);
    FStampAddeds[Index] := False;

    PreviewerByIndex(Index).InvalidatePreview;;
  end;
end;

function TFormMain.ExtractBianHao(const CellValue: string): string;
var
  I, J: Integer;
  SL: TStringList;
begin
  Result := '0000';

  SL := TStringList.Create;
  try
    SL.Text := CellValue;
    for I := 0 to SL.Count - 1 do
    begin
      if (Length(SL[I]) > 4) and (Pos('区站号', SL[I])  > 0) then
      begin
        // Result := Copy(SL[I], Length(SL[I]) - 3, MaxInt);
        // 改成从右往左找所有数字
        for J := Length(SL[I]) downto 1 do
        begin
          if not (SL[I][J] in ['0'..'9']) then
          begin
            Result := Copy(SL[I], J + 1, MaxInt);
            Exit;
          end;
        end;
        Exit;
      end;
    end;
  finally
    SL.Free;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  Application.Title := '气象系统';

  FValueFile := ExtractFilePath(Application.ExeName) + S_F_VALUE;

  // 初始化选项文件
  FSettingFile := ExtractFilePath(Application.ExeName) + S_F_SET;
  if FileExists(FSettingFile) then
    FWSetting.LoadFromJSON(FSettingFile);

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
  FBiaoZhunQiNames := TStringList.Create;
  FBiaoZhunQiValues := TStringList.Create;

  FNengJianDuBiaoZhunQiNames := TStringList.Create;
  FNengJianDuBiaoZhunQiValues := TStringList.Create;

  FBeiHeChaQiJuNames1 := TStringList.Create;
  FBeiHeChaQiJuValues1 := TStringList.Create;

  FBeiHeChaQiJuNames2 := TStringList.Create;
  FBeiHeChaQiJuValues2 := TStringList.Create;

  FBeiHeChaQiJuNames3 := TStringList.Create;
  FBeiHeChaQiJuValues3 := TStringList.Create;

  FBeiHeChaQiJuNames4 := TStringList.Create;
  FBeiHeChaQiJuValues4 := TStringList.Create;

  FBeiHeChaQiJuNames5 := TStringList.Create;
  FBeiHeChaQiJuValues5 := TStringList.Create;

  FBeiHeChaQiJuNames6 := TStringList.Create;
  FBeiHeChaQiJuValues6 := TStringList.Create;

  FBeiHeChaQiJuNames7 := TStringList.Create;
  FBeiHeChaQiJuValues7 := TStringList.Create;

  FBeiHeChaQiJuNames8 := TStringList.Create;
  FBeiHeChaQiJuValues8 := TStringList.Create;

  FJiaoZhun := TStringList.Create;
  FHeYan := TStringList.Create;
  FHeChaYiJu := TStringList.Create;

  FIniting := True;
  try
    Init0;

    Init1;
    Init2;
    Init3;
    Init4;
    Init5;
    Init6;
    Init7;
    Init8;

    LoadValues;

    UpdateSheet1(nil);
    UpdateSheet2(nil);
    UpdateSheet3(nil);
    UpdateSheet4(nil);
    UpdateSheet5(nil);
    UpdateSheet6(nil);
    UpdateSheet7(nil);
    UpdateSheet8(nil);
  finally
    FIniting := False;
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  SaveValues;

  FBiaoZhunQiNames.Free;
  FBiaoZhunQiValues.Free;

  FNengJianDuBiaoZhunQiNames.Free;
  FNengJianDuBiaoZhunQiValues.Free;

  FBeiHeChaQiJuNames8.Free;
  FBeiHeChaQiJuValues8.Free;

  FBeiHeChaQiJuNames7.Free;
  FBeiHeChaQiJuValues7.Free;

  FBeiHeChaQiJuNames6.Free;
  FBeiHeChaQiJuValues6.Free;

  FBeiHeChaQiJuNames5.Free;
  FBeiHeChaQiJuValues5.Free;

  FBeiHeChaQiJuNames4.Free;
  FBeiHeChaQiJuValues4.Free;

  FBeiHeChaQiJuNames3.Free;
  FBeiHeChaQiJuValues3.Free;

  FBeiHeChaQiJuNames2.Free;
  FBeiHeChaQiJuValues2.Free;

  FBeiHeChaQiJuNames1.Free;
  FBeiHeChaQiJuValues1.Free;

  FJiaoZhun.Free;
  FHeYan.Free;
  FHeChaYiJu.Free;
end;

procedure TFormMain.Init0;
begin
  FWSetting.GetType(S_Biao_Zhun_Qi, FBiaoZhunQiNames, FBiaoZhunQiValues);
  FWSetting.GetType(S_Neng_Jian_Du_Biao_Zhun_Qi, FNengJianDuBiaoZhunQiNames, FNengJianDuBiaoZhunQiValues);
  FWSetting.GetType(S_Bei_He_Cha_Qi_Ju1, FBeiHeChaQiJuNames1, FBeiHeChaQiJuValues1);
  FWSetting.GetType(S_Bei_He_Cha_Qi_Ju2, FBeiHeChaQiJuNames2, FBeiHeChaQiJuValues2);
  FWSetting.GetType(S_Bei_He_Cha_Qi_Ju3, FBeiHeChaQiJuNames3, FBeiHeChaQiJuValues3);
  FWSetting.GetType(S_Bei_He_Cha_Qi_Ju4, FBeiHeChaQiJuNames4, FBeiHeChaQiJuValues4);
  FWSetting.GetType(S_Bei_He_Cha_Qi_Ju5, FBeiHeChaQiJuNames5, FBeiHeChaQiJuValues5);
  FWSetting.GetType(S_Bei_He_Cha_Qi_Ju6, FBeiHeChaQiJuNames6, FBeiHeChaQiJuValues6);
  FWSetting.GetType(S_Bei_He_Cha_Qi_Ju7, FBeiHeChaQiJuNames7, FBeiHeChaQiJuValues7);
  FWSetting.GetType(S_Bei_He_Cha_Qi_Ju8, FBeiHeChaQiJuNames8, FBeiHeChaQiJuValues8);

  FWSetting.GetType(S_Xiao_Zhun_Ren, FJiaoZhun, nil);
  FWSetting.GetType(S_He_Yan_Ren, FHeYan, nil);
  FWSetting.GetType(S_He_Cha_Yi_Ju, FHeChaYiJu, nil);
end;

procedure TFormMain.Init1;
begin
  edt1JiaoZhunShiJian.Text := FormatDateTime(S_Yyyy_Nian_Mm_Yue_Dd_Ri, Now());

  cbb1BeiHeCha.Items.Assign(FBeiHeChaQiJuNames1);

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
  edt2JiaoZhunShiJian.Text := FormatDateTime(S_Yyyy_Nian_Mm_Yue_Dd_Ri, Now());

  cbb2BeiHeCha.Items.Assign(FBeiHeChaQiJuNames2);

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
  edt3JiaoZhunShiJian.Text := FormatDateTime(S_Yyyy_Nian_Mm_Yue_Dd_Ri, Now());

  cbb3BeiHeCha.Items.Assign(FBeiHeChaQiJuNames3);

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
  edt4JiaoZhunShiJian.Text := FormatDateTime(S_Yyyy_Nian_Mm_Yue_Dd_Ri, Now());

  cbb4BeiHeCha.Items.Assign(FBeiHeChaQiJuNames4);

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
  edt5JiaoZhunShiJian.Text := FormatDateTime(S_Yyyy_Nian_Mm_Yue_Dd_Ri, Now());

  cbb5BeiHeCha.Items.Assign(FBeiHeChaQiJuNames5);

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
  edt6JiaoZhunShiJian.Text := FormatDateTime(S_Yyyy_Nian_Mm_Yue_Dd_Ri, Now());

  cbb6BeiHeCha.Items.Assign(FBeiHeChaQiJuNames6);

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
  edt7JiaoZhunShiJian.Text := FormatDateTime(S_Yyyy_Nian_Mm_Yue_Dd_Ri, Now());

  cbb7BeiHeCha.Items.Assign(FBeiHeChaQiJuNames7);

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

procedure TFormMain.Init8;
begin
  edt8JiaoZhunShiJian.Text := FormatDateTime(S_Yyyy_Nian_Mm_Yue_Dd_Ri, Now());

  cbb8BiaoZhunQi.Items.Assign(FNengJianDuBiaoZhunQiNames);
  cbb8BeiHeCha.Items.Assign(FBeiHeChaQiJuNames8);

  cbb8JiaoZhun.Items.Assign(FJiaoZhun);
  if cbb8JiaoZhun.Items.Count > 0 then
    cbb8JiaoZhun.ItemIndex := 0;

  cbb8HeYan.Items.Assign(FHeYan);
  if cbb8HeYan.Items.Count > 0 then
    cbb8HeYan.ItemIndex := 0;

  cbb8HeChaYiJu.Items.Assign(FHeChaYiJu);
  if cbb8HeChaYiJu.Items.Count > 0 then
    cbb8HeChaYiJu.ItemIndex := 0;
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
      16, OFFSET_ARRAY[Index], 4, 40, 256, 236, FXlses[Index]);
      // 行、行偏移像素、列、列偏移像素、高、宽、XLS实例
    FXlses[Index].AddImage(FStampFile, MP);
    Inc(FStampIndexes[Index]);

    PreviewerByIndex(Index).InvalidatePreview;
    FStampAddeds[Index] := True;
  end;
end;

procedure TFormMain.LoadValues;
var
  C: TComponent;
  N: string;
  I: Integer;
  Obj: TCnJSONObject;
begin
  if not FileExists(FValueFile) then
    Exit;

  Obj := TCnJSONReader.FileToJSONObject(FValueFile);
  try
    for I := 0 to Self.ComponentCount - 1 do
    begin
      C := Self.Components[I];
      N := C.Name;
      if Pos('JiaoZhunShiJian', N) > 0 then  // 不加载校准时间
        Continue;

      if C is TEdit then
      begin
        (C as TEdit).Text := Obj.ValueByName[N].AsString;
      end
      else if C is TMaskEdit then
      begin
        (C as TMaskEdit).Text := Obj.ValueByName[N].AsString;
      end
      else if C is TComboBox then
      begin
        (C as TComboBox).ItemIndex := Obj.ValueByName[N].AsInteger;
      end;
    end;
  finally
    Obj.Free;
  end;
end;

function TFormMain.MyStrToDate(const Str: string): TDate;
var
  Idx, Y, M, D: Integer;
  S, T: string;
begin
  Result := Now;
  S := Str;

  Idx := Pos('年', S);
  if Idx > 0 then
  begin
    T := Copy(S, 1, Idx - 1);
    Y := StrToInt(T);

    Delete(S, 1, Idx);

    Idx := Pos('月', S);
    if Idx > 0 then
    begin
      T := Copy(S, 1, Idx - 1);
      M := StrToInt(T);

      Delete(S, 1, Idx);

      Idx := Pos('日', S);
      if Idx > 0 then
      begin
        T := Copy(S, 1, Idx - 1);
        D := StrToInt(T);

        Result := EncodeDate(Y, M, D);
      end;
    end;
  end;
end;

procedure TFormMain.pgcMainChange(Sender: TObject);
begin
  Init0;
  case pgcMain.ActivePageIndex of
    0: UpdateSheet1(ts1);
    1: UpdateSheet2(ts2);
    2: UpdateSheet3(ts3);
    3: UpdateSheet4(ts4);
    4: UpdateSheet5(ts5);
    5: UpdateSheet6(ts6);
    6: UpdateSheet7(ts7);
  end;
end;

function TFormMain.PreviewerByIndex(Index: Integer): TFlexCelPreviewer;
begin
  Result := FindComponent('fcpSheet' + IntToStr(Index)) as TFlexCelPreviewer;
  if Result = nil then
    raise Exception.Create(S_No_Fcpsheet_For + IntToStr(Index));
end;

procedure TFormMain.SaveValues;
var
  C: TComponent;
  N: string;
  I: Integer;
  Obj: TCnJSONObject;
begin
  Obj := TCnJSONObject.Create;
  try
    for I := 0 to Self.ComponentCount - 1 do
    begin
      C := Self.Components[I];
      N := C.Name;
      if Pos('JiaoZhunShiJian', N) > 0 then  // 不保存校准时间
        Continue;

      if C is TEdit then
      begin
        Obj.AddPair(N, (C as TEdit).Text);
      end
      else if C is TMaskEdit then
      begin
        Obj.AddPair(N, (C as TMaskEdit).Text);
      end
      else if C is TComboBox then
      begin
        Obj.AddPair(N, (C as TComboBox).ItemIndex);
      end;
    end;
    TCnJSONWriter.JSONObjectToFile(Obj, FValueFile);
  finally
    Obj.Free;
  end;
end;

procedure TFormMain.SetNumberValue(Xls: TExcelFile; Row, Col: Integer;
  const Value: string);
var
  E, VI: Integer;
  VE: Extended;
begin
  Val(Value, VI, E);
  if E = 0 then
  begin
    // 是整数
    Xls.SetCellValue(Row, Col, VI);
    Exit;
  end;

  try
    // 按浮点数处理
    VE := StrToFloat(Value);
    Xls.SetCellValue(Row, Col, VE);
  except
    ; // 出错则啥都不做
  end;
end;

procedure TFormMain.UpdateSheet1(Sender: TObject);
var
  S: string;
begin
  if Sender <> edt1JiLuBianHao then
  begin
    if (cbb1BeiHeCha.ItemIndex >= 0) and
     (cbb1BeiHeCha.ItemIndex < FBeiHeChaQiJuValues1.Count) then
    begin
      S := FBeiHeChaQiJuValues1[cbb1BeiHeCha.ItemIndex];
      edt1JiLuBianHao.Text := CalcCurrentBianhao(ExtractBianHao(S));
    end;
  end;

  S := Format(S_Ji_Lu_Bian_Hao_S, [edt1JiLuBianHao.Text]);
  FXlses[1].SetCellValue(3, 1, S);

  S := Format(S_Qi_Wen_S_Shi_Dong_S_Rh_Feng_Su,
    [edt1QiWen.Text, edt1ShiDu.Text, edt1FengSu.Text]);
  FXlses[1].SetCellValue(4, 2, S);

  if cbb1WaiGuanHeGe.ItemIndex = 0 then
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$2611, #$25A1])
  else
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$25A1, #$2611]);
  FXlses[1].SetCellValue(8, 2, S);

  FXlses[1].SetCellValue(5, 2, edt1KaiShiShiJian.Text);
  FXlses[1].SetCellValue(5, 5, edt1JieShuShiJian.Text);

//  if (cbb1BiaoZhunQi.ItemIndex >= 0) and (cbb1BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
  FXlses[1].SetCellValue(7, 2, FBiaoZhunQiValues[0]);

  if (cbb1BeiHeCha.ItemIndex >= 0) and (cbb1BeiHeCha.ItemIndex < FBeiHeChaQiJuValues1.Count) then
    FXlses[1].SetCellValue(7, 4, FBeiHeChaQiJuValues1[cbb1BeiHeCha.ItemIndex]);

  SetNumberValue(FXlses[1], 10, 2, edt1BiaoZhunZhi1.Text);
  SetNumberValue(FXlses[1], 11, 2, edt1BiaoZhunZhi2.Text);
  SetNumberValue(FXlses[1], 12, 2, edt1BiaoZhunZhi3.Text);
  SetNumberValue(FXlses[1], 13, 2, edt1BiaoZhunZhi4.Text);
  SetNumberValue(FXlses[1], 14, 2, edt1BiaoZhunZhi5.Text);
  SetNumberValue(FXlses[1], 15, 2, edt1BiaoZhunZhi6.Text);
  SetNumberValue(FXlses[1], 16, 2, edt1BiaoZhunZhi7.Text);
  SetNumberValue(FXlses[1], 17, 2, edt1BiaoZhunZhi8.Text);
  SetNumberValue(FXlses[1], 18, 2, edt1BiaoZhunZhi9.Text);

  SetNumberValue(FXlses[1], 10, 3, edt1XiuZhengZhi1.Text);
  SetNumberValue(FXlses[1], 13, 3, edt1XiuZhengZhi2.Text);
  SetNumberValue(FXlses[1], 16, 3, edt1XiuZhengZhi3.Text);

  SetNumberValue(FXlses[1], 10, 5, edt1BeiHeCha1.Text);
  SetNumberValue(FXlses[1], 13, 5, edt1BeiHeCha2.Text);
  SetNumberValue(FXlses[1], 16, 5, edt1BeiHeCha3.Text);

  if not FIniting then
    FXlses[1].RecalcAndVerify;

  FXlses[1].SetCellValue(19, 3, S_ARR_HEGE[cbb1HeGe.ItemIndex]);
  if cbb1FuHeYaoQiu.ItemIndex = 0 then
    S := Format(S_S_Shi_S_Fou, [#$2611, #$25A1])
  else
    S := Format(S_S_Shi_S_Fou, [#$25A1, #$2611]);

  FXlses[1].SetCellValue(20, 3, cbb1HeChaYiJu.Items[cbb1HeChaYiJu.ItemIndex]);
  FXlses[1].SetCellValue(21, 3, S);

  FXlses[1].SetCellValue(22, 1, S_Xiao_Zhun + cbb1JiaoZhun.Items[cbb1JiaoZhun.ItemIndex]);
  FXlses[1].SetCellValue(22, 3, S_He_Yan + cbb1HeYan.Items[cbb1HeYan.ItemIndex]);
  FXlses[1].SetCellValue(22, 5, edt1JiaoZhunShiJian.Text);

  FcpSheet1.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet2(Sender: TObject);
var
  S: string;
begin
  if Sender <> edt2JiLuBianHao then
  begin
    if (cbb2BeiHeCha.ItemIndex >= 0) and
     (cbb2BeiHeCha.ItemIndex < FBeiHeChaQiJuValues2.Count) then
    begin
      S := FBeiHeChaQiJuValues2[cbb2BeiHeCha.ItemIndex];
      edt2JiLuBianHao.Text := CalcCurrentBianhao(ExtractBianHao(S));
    end;
  end;

  S := Format(S_Ji_Lu_Bian_Hao_S, [edt2JiLuBianHao.Text]);
  FXlses[2].SetCellValue(2, 1, S);

  S := Format(S_Qi_Wen_S_Shi_Dong_S_Rh_Feng_Su,
    [edt2QiWen.Text, edt2ShiDu.Text, edt2FengSu.Text]);
  FXlses[2].SetCellValue(3, 2, S);

  if cbb2WaiGuanHeGe.ItemIndex = 0 then
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$2611, #$25A1])
  else
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$25A1, #$2611]);
  FXlses[2].SetCellValue(7, 2, S);

  FXlses[2].SetCellValue(4, 2, edt2KaiShiShiJian.Text);
  FXlses[2].SetCellValue(4, 5, edt2JieShuShiJian.Text);

//  if (cbb2BiaoZhunQi.ItemIndex >= 0) and (cbb2BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
  FXlses[2].SetCellValue(6, 2, FBiaoZhunQiValues[1]);

  if (cbb2BeiHeCha.ItemIndex >= 0) and (cbb2BeiHeCha.ItemIndex < FBeiHeChaQiJuValues2.Count) then
    FXlses[2].SetCellValue(6, 4, FBeiHeChaQiJuValues2[cbb2BeiHeCha.ItemIndex]);

  SetNumberValue(FXlses[2], 9, 2, edt2BiaoZhunZhi1.Text);
  SetNumberValue(FXlses[2], 10, 2, edt2BiaoZhunZhi2.Text);
  SetNumberValue(FXlses[2], 11, 2, edt2BiaoZhunZhi3.Text);
  SetNumberValue(FXlses[2], 12, 2, edt2BiaoZhunZhi4.Text);
  SetNumberValue(FXlses[2], 13, 2, edt2BiaoZhunZhi5.Text);
  SetNumberValue(FXlses[2], 14, 2, edt2BiaoZhunZhi6.Text);

  SetNumberValue(FXlses[2], 9, 3, edt2XiuZhengZhi1.Text);
  SetNumberValue(FXlses[2], 12, 3, edt2XiuZhengZhi2.Text);

  SetNumberValue(FXlses[2], 9, 5, edt2BeiHeCha1.Text);
  SetNumberValue(FXlses[2], 12, 5, edt2BeiHeCha2.Text);

  if not FIniting then
    FXlses[2].RecalcAndVerify;

  FXlses[2].SetCellValue(15, 2, S_ARR_HEGE[cbb2HeGe.ItemIndex]);
  if cbb2FuHeYaoQiu.ItemIndex = 0 then
    S := Format(S_S_Shi_S_Fou, [#$2611, #$25A1])
  else
    S := Format(S_S_Shi_S_Fou, [#$25A1, #$2611]);

  FXlses[2].SetCellValue(16, 2, cbb2HeChaYiJu.Items[cbb2HeChaYiJu.ItemIndex]);
  FXlses[2].SetCellValue(17, 2, S);

  FXlses[2].SetCellValue(18, 1, S_Xiao_Zhun + cbb2JiaoZhun.Items[cbb2JiaoZhun.ItemIndex]);
  FXlses[2].SetCellValue(18, 3, S_He_Yan + cbb2HeYan.Items[cbb2HeYan.ItemIndex]);
  FXlses[2].SetCellValue(18, 5, edt2JiaoZhunShiJian.Text);

  FcpSheet2.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet3(Sender: TObject);
var
  S: string;
begin
  if Sender <> edt3JiLuBianHao then
  begin
    if (cbb3BeiHeCha.ItemIndex >= 0) and
     (cbb3BeiHeCha.ItemIndex < FBeiHeChaQiJuValues3.Count) then
    begin
      S := FBeiHeChaQiJuValues3[cbb3BeiHeCha.ItemIndex];
      edt3JiLuBianHao.Text := CalcCurrentBianhao(ExtractBianHao(S));
    end;
  end;

  S := Format(S_Ji_Lu_Bian_Hao_S, [edt3JiLuBianHao.Text]);
  FXlses[3].SetCellValue(3, 3, S);

  S := Format(S_Qi_Wen_S_Shi_Dong_S_Rh_Feng_Su,
    [edt3QiWen.Text, edt3ShiDu.Text, edt3FengSu.Text]);
  FXlses[3].SetCellValue(4, 2, S);

  if cbb3WaiGuanHeGe.ItemIndex = 0 then
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$2611, #$25A1])
  else
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$25A1, #$2611]);
  FXlses[3].SetCellValue(8, 2, S);

  FXlses[3].SetCellValue(5, 2, edt3KaiShiShiJian.Text);
  FXlses[3].SetCellValue(5, 5, edt3JieShuShiJian.Text);

//  if (cbb3BiaoZhunQi.ItemIndex >= 0) and (cbb3BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
  FXlses[3].SetCellValue(7, 2, FBiaoZhunQiValues[2]);

  if (cbb3BeiHeCha.ItemIndex >= 0) and (cbb3BeiHeCha.ItemIndex < FBeiHeChaQiJuValues3.Count) then
    FXlses[3].SetCellValue(7, 4, FBeiHeChaQiJuValues3[cbb3BeiHeCha.ItemIndex]);

  SetNumberValue(FXlses[3], 10, 2, edt3BeiHeCha1.Text);
  SetNumberValue(FXlses[3], 11, 2, edt3BeiHeCha2.Text);
  SetNumberValue(FXlses[3], 12, 2, edt3BeiHeCha3.Text);

  if not FIniting then
    FXlses[3].RecalcAndVerify;

  FXlses[3].SetCellValue(13, 3, S_ARR_HEGE[cbb3HeGe.ItemIndex]);
  if cbb3FuHeYaoQiu.ItemIndex = 0 then
    S := Format(S_S_Shi_S_Fou, [#$2611, #$25A1])
  else
    S := Format(S_S_Shi_S_Fou, [#$25A1, #$2611]);

  FXlses[3].SetCellValue(14, 3, cbb3HeChaYiJu.Items[cbb3HeChaYiJu.ItemIndex]);
  FXlses[3].SetCellValue(15, 3, S);

  FXlses[3].SetCellValue(16, 1, S_Xiao_Zhun + cbb3JiaoZhun.Items[cbb3JiaoZhun.ItemIndex]);
  FXlses[3].SetCellValue(16, 3, S_He_Yan + cbb3HeYan.Items[cbb3HeYan.ItemIndex]);
  FXlses[3].SetCellValue(16, 5, edt3JiaoZhunShiJian.Text);

  FcpSheet3.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet4(Sender: TObject);
var
  S: string;
begin
  if Sender <> edt4JiLuBianHao then
  begin
    if (cbb4BeiHeCha.ItemIndex >= 0) and
     (cbb4BeiHeCha.ItemIndex < FBeiHeChaQiJuValues4.Count) then
    begin
      S := FBeiHeChaQiJuValues4[cbb4BeiHeCha.ItemIndex];
      edt4JiLuBianHao.Text := CalcCurrentBianhao(ExtractBianHao(S));
    end;
  end;

  S := Format(S_Ji_Lu_Bian_Hao_S, [edt4JiLuBianHao.Text]);
  FXlses[4].SetCellValue(3, 3, S);

  S := Format(S_Qi_Wen_S_Shi_Dong_S_Rh_Feng_Su,
    [edt4QiWen.Text, edt4ShiDu.Text, edt4FengSu.Text]);
  FXlses[4].SetCellValue(4, 2, S);

  if cbb4WaiGuanHeGe.ItemIndex = 0 then
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$2611, #$25A1])
  else
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$25A1, #$2611]);
  FXlses[4].SetCellValue(8, 2, S);

  FXlses[4].SetCellValue(5, 2, edt4KaiShiShiJian.Text);
  FXlses[4].SetCellValue(5, 5, edt4JieShuShiJian.Text);

//  if (cbb4BiaoZhunQi.ItemIndex >= 0) and (cbb4BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
  FXlses[4].SetCellValue(7, 2, FBiaoZhunQiValues[3]);

  if (cbb4BeiHeCha.ItemIndex >= 0) and (cbb4BeiHeCha.ItemIndex < FBeiHeChaQiJuValues4.Count) then
    FXlses[4].SetCellValue(7, 4, FBeiHeChaQiJuValues4[cbb4BeiHeCha.ItemIndex]);

  SetNumberValue(FXlses[4], 10, 2, edt4BiaoZhunZhi1.Text);
  SetNumberValue(FXlses[4], 11, 2, edt4BiaoZhunZhi2.Text);
  SetNumberValue(FXlses[4], 12, 2, edt4BiaoZhunZhi3.Text);
  SetNumberValue(FXlses[4], 13, 2, edt4BiaoZhunZhi4.Text);
  SetNumberValue(FXlses[4], 14, 2, edt4BiaoZhunZhi5.Text);

  SetNumberValue(FXlses[4], 10, 3, edt4BeiHeCha1.Text);
  SetNumberValue(FXlses[4], 11, 3, edt4BeiHeCha2.Text);
  SetNumberValue(FXlses[4], 12, 3, edt4BeiHeCha3.Text);
  SetNumberValue(FXlses[4], 13, 3, edt4BeiHeCha4.Text);
  SetNumberValue(FXlses[4], 14, 3, edt4BeiHeCha5.Text);

  FXlses[4].SetCellValue(10, 5, S_ARR_HEGE[cbb4JieGuoHeGe1.ItemIndex]);
  FXlses[4].SetCellValue(11, 5, S_ARR_HEGE[cbb4JieGuoHeGe2.ItemIndex]);
  FXlses[4].SetCellValue(12, 5, S_ARR_HEGE[cbb4JieGuoHeGe3.ItemIndex]);
  FXlses[4].SetCellValue(13, 5, S_ARR_HEGE[cbb4JieGuoHeGe4.ItemIndex]);
  FXlses[4].SetCellValue(14, 5, S_ARR_HEGE[cbb4JieGuoHeGe5.ItemIndex]);

  if not FIniting then
    FXlses[4].RecalcAndVerify;

  FXlses[4].SetCellValue(15, 3, S_ARR_HEGE[cbb4HeGe.ItemIndex]);
  if cbb4FuHeYaoQiu.ItemIndex = 0 then
    S := Format(S_S_Shi_S_Fou, [#$2611, #$25A1])
  else
    S := Format(S_S_Shi_S_Fou, [#$25A1, #$2611]);

  FXlses[4].SetCellValue(16, 3, cbb4HeChaYiJu.Items[cbb4HeChaYiJu.ItemIndex]);
  FXlses[4].SetCellValue(17, 3, S);

  FXlses[4].SetCellValue(18, 1, S_Xiao_Zhun + cbb4JiaoZhun.Items[cbb4JiaoZhun.ItemIndex]);
  FXlses[4].SetCellValue(18, 3, S_He_Yan + cbb4HeYan.Items[cbb4HeYan.ItemIndex]);
  FXlses[4].SetCellValue(18, 5, edt4JiaoZhunShiJian.Text);

  FcpSheet4.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet5(Sender: TObject);
var
  S: string;
begin
  if Sender <> edt5JiLuBianHao then
  begin
    if (cbb5BeiHeCha.ItemIndex >= 0) and
     (cbb5BeiHeCha.ItemIndex < FBeiHeChaQiJuValues5.Count) then
    begin
      S := FBeiHeChaQiJuValues5[cbb5BeiHeCha.ItemIndex];
      edt5JiLuBianHao.Text := CalcCurrentBianhao(ExtractBianHao(S));
    end;
  end;

  S := Format(S_Ji_Lu_Bian_Hao_S, [edt5JiLuBianHao.Text]);
  FXlses[5].SetCellValue(3, 4, S);

  S := Format(S_Qi_Wen_S_Shi_Dong_S_Rh_Feng_Su,
    [edt5QiWen.Text, edt5ShiDu.Text, edt5FengSu.Text]);
  FXlses[5].SetCellValue(4, 2, S);

  if cbb5WaiGuanHeGe.ItemIndex = 0 then
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$2611, #$25A1])
  else
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$25A1, #$2611]);
  FXlses[5].SetCellValue(8, 2, S);

  FXlses[5].SetCellValue(5, 2, edt5KaiShiShiJian.Text);
  FXlses[5].SetCellValue(5, 5, edt5JieShuShiJian.Text);

//  if (cbb5BiaoZhunQi.ItemIndex >= 0) and (cbb5BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
  FXlses[5].SetCellValue(7, 2, FBiaoZhunQiValues[4]);

  if (cbb5BeiHeCha.ItemIndex >= 0) and (cbb5BeiHeCha.ItemIndex < FBeiHeChaQiJuValues5.Count) then
    FXlses[5].SetCellValue(7, 4, FBeiHeChaQiJuValues5[cbb5BeiHeCha.ItemIndex]);

  SetNumberValue(FXlses[5], 10, 2, edt5BiaoZhunZhi1.Text);
  SetNumberValue(FXlses[5], 11, 2, edt5BiaoZhunZhi2.Text);
  SetNumberValue(FXlses[5], 12, 2, edt5BiaoZhunZhi3.Text);
  SetNumberValue(FXlses[5], 13, 2, edt5BiaoZhunZhi4.Text);
  SetNumberValue(FXlses[5], 14, 2, edt5BiaoZhunZhi5.Text);
  SetNumberValue(FXlses[5], 15, 2, edt5BiaoZhunZhi6.Text);
  SetNumberValue(FXlses[5], 16, 2, edt5BiaoZhunZhi7.Text);
  SetNumberValue(FXlses[5], 17, 2, edt5BiaoZhunZhi8.Text);
  SetNumberValue(FXlses[5], 18, 2, edt5BiaoZhunZhi9.Text);

  SetNumberValue(FXlses[5], 10, 3, edt5XiuZhengZhi1.Text);
  SetNumberValue(FXlses[5], 13, 3, edt5XiuZhengZhi2.Text);
  SetNumberValue(FXlses[5], 16, 3, edt5XiuZhengZhi3.Text);

  SetNumberValue(FXlses[5], 10, 5, edt5BeiHeCha1.Text);
  SetNumberValue(FXlses[5], 13, 5, edt5BeiHeCha2.Text);
  SetNumberValue(FXlses[5], 16, 5, edt5BeiHeCha3.Text);

  if not FIniting then
    FXlses[5].RecalcAndVerify;

  FXlses[5].SetCellValue(19, 3, S_ARR_HEGE[cbb5HeGe.ItemIndex]);
  if cbb5FuHeYaoQiu.ItemIndex = 0 then
    S := Format(S_S_Shi_S_Fou, [#$2611, #$25A1])
  else
    S := Format(S_S_Shi_S_Fou, [#$25A1, #$2611]);

  FXlses[5].SetCellValue(20, 3, cbb5HeChaYiJu.Items[cbb5HeChaYiJu.ItemIndex]);
  FXlses[5].SetCellValue(21, 3, S);

  FXlses[5].SetCellValue(22, 1, S_Xiao_Zhun + cbb5JiaoZhun.Items[cbb5JiaoZhun.ItemIndex]);
  FXlses[5].SetCellValue(22, 3, S_He_Yan + cbb5HeYan.Items[cbb5HeYan.ItemIndex]);
  FXlses[5].SetCellValue(22, 5, edt5JiaoZhunShiJian.Text);

  FcpSheet5.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet6(Sender: TObject);
var
  S: string;
begin
  if Sender <> edt6JiLuBianHao then
  begin
    if (cbb6BeiHeCha.ItemIndex >= 0) and
     (cbb6BeiHeCha.ItemIndex < FBeiHeChaQiJuValues6.Count) then
    begin
      S := FBeiHeChaQiJuValues6[cbb6BeiHeCha.ItemIndex];
      edt6JiLuBianHao.Text := CalcCurrentBianhao(ExtractBianHao(S));
    end;
  end;

  S := Format(S_Ji_Lu_Bian_Hao_S, [edt6JiLuBianHao.Text]);
  FXlses[6].SetCellValue(3, 4, S);

  S := Format(S_Qi_Wen_S_Shi_Dong_S_Rh_Feng_Su,
    [edt6QiWen.Text, edt6ShiDu.Text, edt6FengSu.Text]);
  FXlses[6].SetCellValue(4, 2, S);

  if cbb6WaiGuanHeGe.ItemIndex = 0 then
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$2611, #$25A1])
  else
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$25A1, #$2611]);
  FXlses[6].SetCellValue(8, 2, S);

  FXlses[6].SetCellValue(5, 2, edt6KaiShiShiJian.Text);
  FXlses[6].SetCellValue(5, 5, edt6JieShuShiJian.Text);

//  if (cbb6BiaoZhunQi.ItemIndex >= 0) and (cbb6BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
  FXlses[6].SetCellValue(7, 2, FBiaoZhunQiValues[5]);

  if (cbb6BeiHeCha.ItemIndex >= 0) and (cbb6BeiHeCha.ItemIndex < FBeiHeChaQiJuValues6.Count) then
    FXlses[6].SetCellValue(7, 4, FBeiHeChaQiJuValues6[cbb6BeiHeCha.ItemIndex]);

  // 填格子并计算，注意得数值
  SetNumberValue(FXlses[6], 10, 4, edt6ChuanGanQi1.Text);
  SetNumberValue(FXlses[6], 11, 4, edt6ChuanGanQi2.Text);
  SetNumberValue(FXlses[6], 12, 4, edt6ChuanGanQi3.Text);
  SetNumberValue(FXlses[6], 13, 4, edt6ChuanGanQi4.Text);
  SetNumberValue(FXlses[6], 14, 4, edt6ChuanGanQi5.Text);
  SetNumberValue(FXlses[6], 15, 4, edt6ChuanGanQi6.Text);

  if not FIniting then
    FXlses[6].RecalcAndVerify;

  FXlses[6].SetCellValue(16, 3, S_ARR_HEGE[cbb6HeGe.ItemIndex]);
  if cbb6FuHeYaoQiu.ItemIndex = 0 then
    S := Format(S_S_Shi_S_Fou, [#$2611, #$25A1])
  else
    S := Format(S_S_Shi_S_Fou, [#$25A1, #$2611]);

  FXlses[6].SetCellValue(17, 3, cbb6HeChaYiJu.Items[cbb6HeChaYiJu.ItemIndex]);
  FXlses[6].SetCellValue(18, 3, S);

  FXlses[6].SetCellValue(19, 2, cbb6JiaoZhun.Items[cbb6JiaoZhun.ItemIndex]);
  FXlses[6].SetCellValue(19, 3, S_He_Yan + cbb6HeYan.Items[cbb6HeYan.ItemIndex]);
  FXlses[6].SetCellValue(19, 5, edt6JiaoZhunShiJian.Text);

  FcpSheet6.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet7(Sender: TObject);
var
  S: string;
begin
  if Sender <> edt7JiLuBianHao then
  begin
    if (cbb7BeiHeCha.ItemIndex >= 0) and
     (cbb7BeiHeCha.ItemIndex < FBeiHeChaQiJuValues7.Count) then
    begin
      S := FBeiHeChaQiJuValues7[cbb7BeiHeCha.ItemIndex];
      edt7JiLuBianHao.Text := CalcCurrentBianhao(ExtractBianHao(S));
    end;
  end;

  S := Format(S_Ji_Lu_Bian_Hao_S, [edt7JiLuBianHao.Text]);
  FXlses[7].SetCellValue(3, 4, S);

  S := Format(S_Qi_Wen_S_Shi_Dong_S_Rh_Feng_Su,
    [edt7QiWen.Text, edt7ShiDu.Text, edt7FengSu.Text]);
  FXlses[7].SetCellValue(4, 2, S);

  if not FIniting then
    FXlses[7].RecalcAndVerify;

  if cbb7WaiGuanHeGe.ItemIndex = 0 then
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$2611, #$25A1])
  else
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$25A1, #$2611]);
  FXlses[7].SetCellValue(8, 2, S);

  FXlses[7].SetCellValue(5, 2, edt7KaiShiShiJian.Text);
  FXlses[7].SetCellValue(5, 5, edt7JieShuShiJian.Text);

//  if (cbb7BiaoZhunQi.ItemIndex >= 0) and (cbb7BiaoZhunQi.ItemIndex < FBiaoZhunQiValues.Count) then
  FXlses[7].SetCellValue(7, 2, FBiaoZhunQiValues[6]);

  if (cbb7BeiHeCha.ItemIndex >= 0) and (cbb7BeiHeCha.ItemIndex < FBeiHeChaQiJuValues7.Count) then
    FXlses[7].SetCellValue(7, 4, FBeiHeChaQiJuValues7[cbb7BeiHeCha.ItemIndex]);

  FXlses[7].SetCellValue(10, 2, edt7BiaoZhunZhi1.Text);
  FXlses[7].SetCellValue(11, 2, edt7BiaoZhunZhi2.Text);
  FXlses[7].SetCellValue(12, 2, edt7BiaoZhunZhi3.Text);
  FXlses[7].SetCellValue(10, 4, edt7HeChaJieGuo.Text);
  FXlses[7].SetCellValue(13, 3, edt7ZuiDaYunXuZhi.Text);

  if cbb7FuHeYaoQiu.ItemIndex = 0 then
    S := Format(S_S_Shi_S_Fou, [#$2611, #$25A1])
  else
    S := Format(S_S_Shi_S_Fou, [#$25A1, #$2611]);

  FXlses[7].SetCellValue(14, 3, cbb7HeChaYiJu.Items[cbb7HeChaYiJu.ItemIndex]);
  FXlses[7].SetCellValue(15, 3, S);

  FXlses[7].SetCellValue(16, 2, cbb7JiaoZhun.Items[cbb7JiaoZhun.ItemIndex]);
  FXlses[7].SetCellValue(16, 3, S_He_Yan + cbb7HeYan.Items[cbb7HeYan.ItemIndex]);
  FXlses[7].SetCellValue(16, 5, edt7JiaoZhunShiJian.Text);

  FcpSheet7.InvalidatePreview;
end;

procedure TFormMain.UpdateSheet8(Sender: TObject);
var
  S: string;
begin
  if Sender <> edt8JiLuBianHao then
  begin
    if (cbb8BeiHeCha.ItemIndex >= 0) and
     (cbb8BeiHeCha.ItemIndex < FBeiHeChaQiJuValues8.Count) then
    begin
      S := FBeiHeChaQiJuValues8[cbb8BeiHeCha.ItemIndex];
      edt8JiLuBianHao.Text := CalcCurrentBianhao(ExtractBianHao(S));
    end;
  end;

  S := Format(S_Ji_Lu_Bian_Hao_S, [edt8JiLuBianHao.Text]);
  FXlses[8].SetCellValue(3, 4, S);

  S := Format(S_Qi_Wen_S_Ya_Li_S_Shi_Du,
    [edt8QiWen.Text, edt8YaLi.Text, edt8ShiDu.Text]);
  FXlses[8].SetCellValue(4, 2, S);

  // 非固定，改动态
  // FXlses[8].SetCellValue(7, 2, FBiaoZhunQiValues[7]);
  if (cbb8BiaoZhunQi.ItemIndex >= 0) and (cbb8BiaoZhunQi.ItemIndex < FNengJianDuBiaoZhunQiValues.Count) then
    FXlses[8].SetCellValue(7, 2, FNengJianDuBiaoZhunQiValues[cbb8BiaoZhunQi.ItemIndex]);


  if (cbb8BeiHeCha.ItemIndex >= 0) and (cbb8BeiHeCha.ItemIndex < FBeiHeChaQiJuValues8.Count) then
    FXlses[8].SetCellValue(7, 4, FBeiHeChaQiJuValues8[cbb8BeiHeCha.ItemIndex]);

  if cbb8WaiGuanHeGe.ItemIndex = 0 then
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$2611, #$25A1])
  else
    S := Format(S_S_He_Ge_S_Bu_He_Ge, [#$25A1, #$2611]);
  FXlses[8].SetCellValue(8, 2, S);

  SetNumberValue(FXlses[8], 10, 2, edt8NengRuDu1.Text);
  SetNumberValue(FXlses[8], 11, 2, edt8NengRuDu2.Text);
  SetNumberValue(FXlses[8], 10, 4, edt8BiaoChenZhi1.Text);
  SetNumberValue(FXlses[8], 11, 4, edt8BiaoChenZhi2.Text);

  if not FIniting then
    FXlses[8].RecalcAndVerify;

  if cbb8FuHeYaoQiu.ItemIndex = 0 then
    S := Format(S_S_Shi_S_Fou, [#$2611, #$25A1])
  else
    S := Format(S_S_Shi_S_Fou, [#$25A1, #$2611]);

  FXlses[8].SetCellValue(14, 3, cbb8HeChaYiJu.Items[cbb8HeChaYiJu.ItemIndex]);
  FXlses[8].SetCellValue(15, 3, S);

  FXlses[8].SetCellValue(16, 2, cbb8JiaoZhun.Items[cbb8JiaoZhun.ItemIndex]);
  FXlses[8].SetCellValue(16, 3, S_He_Yan + cbb8HeYan.Items[cbb8HeYan.ItemIndex]);
  FXlses[8].SetCellValue(16, 5, edt8JiaoZhunShiJian.Text);

  FcpSheet8.InvalidatePreview;
end;

end.
