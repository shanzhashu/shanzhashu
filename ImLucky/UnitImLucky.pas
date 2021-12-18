unit UnitImLucky;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, jpeg;

const
  WM_ROLL_DISPLAY = WM_USER + 100;

type
  TFormLucky = class(TForm)
    edtCount: TEdit;
    udCount: TUpDown;
    btnImport: TButton;
    lblCount: TLabel;
    lblRen: TLabel;
    btnChou: TButton;
    pnlScroll: TPanel;
    mmoResult: TMemo;
    btnClose: TSpeedButton;
    img1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnChouClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FLogFileName: string;
    FUsers: TStringList;
    FRolling: Boolean;
    FUserIndex: Integer;
    procedure LuckyLog(const S: string);
    procedure SetRolling(const Value: Boolean);
    procedure MixUMList; // 随机排列 FUMs 内的内容
    function RandClosedInterval(RMin, RMax: Integer): Integer;
    procedure OnRollDisplay(var Msg: TMessage); message WM_ROLL_DISPLAY;
    procedure PickLuckyNames(C: Integer; OutNames: TStrings);
    function JoinNames(Names: TStrings): string;

    procedure TestFillUMs;
  public
    property Rolling: Boolean read FRolling write SetRolling;
  end;

var
  FormLucky: TFormLucky;

implementation

{$R *.dfm}

uses
  CnRandom;

const
  DISPLAY_COUNT = 3;
  USER_FILE = 'USER.txt';
  BACK_FILE = 'BACK.jpg';
  LOG_FILE_FMT = '%s_log.txt';

var
  CRLF: array[0..1] of Char = (#13, #10);
  DISPLAY_ITEMS: array[0..DISPLAY_COUNT - 1] of string;

procedure TFormLucky.FormCreate(Sender: TObject);
var
  J: TJPEGImage;
begin
  FLogFileName := Format(LOG_FILE_FMT, [FormatDateTime('yyyy-mm-dd-hh-MM-ss', Now)]);
  LuckyLog('I''m Lucky Start.');

  if FileExists(BACK_FILE) then
  begin
    J := TJPEGImage.Create;
    try
      J.LoadFromFile(BACK_FILE);
      img1.Picture.Assign(J);
      LuckyLog('Load background ' + BACK_FILE);
    finally
      J.Free;
    end;
  end;

  FUsers := TStringList.Create;
  pnlScroll.DoubleBuffered := True;
  Randomize;

  // TEST
  TestFillUMs;
  // TEST

  MixUMList;
  LuckyLog('List Shuffled');

end;

procedure TFormLucky.LuckyLog(const S: string);
var
  FS: TFileStream;
  Str: string;
begin
  if FileExists(FLogFileName) then
    FS := TFileStream.Create(FLogFileName, fmOpenWrite)
  else
    FS := TFileStream.Create(FLogFileName, fmCreate);

  try
    FS.Seek(0, soEnd);

    Str := Format('%s %s', [FormatDateTime('mm-dd_hh:MM:ss', Now), S]);
    FS.Write(Str[1], Length(Str) * SizeOf(Char));
    FS.Write(CRLF[0], SizeOf(CRLF) * SizeOf(Char));
  finally
    FS.Free;
  end;
end;

procedure TFormLucky.FormDestroy(Sender: TObject);
begin
  FUsers.Free;
  LuckyLog('I''m Lucky Over.');
end;

procedure TFormLucky.btnChouClick(Sender: TObject);
begin
  if udCount.Position <= 0 then
    raise Exception.Create('抽奖人数不对')
  else if udCount.Position > FUsers.Count then
    raise Exception.Create('人不够抽');

  Rolling := not Rolling;
end;

procedure TFormLucky.SetRolling(const Value: Boolean);
var
  Names: TStrings;
  S: string;
begin
  if Value <> FRolling then
  begin
    FRolling := Value;
    if FRolling then
    begin
      FUserIndex := 0;
      PostMessage(Handle, WM_ROLL_DISPLAY, 0, 0);
      LuckyLog('开始滚屏……');
    end
    else
    begin
      pnlScroll.Caption := '';
      LuckyLog('停止滚屏，抽！');

      // 抽 udCount.Position 个奖并显示并从列表里删除
      Names := TStringList.Create;
      try
        PickLuckyNames(udCount.Position, Names);
        S := JoinNames(Names);
        LuckyLog(Format('抽中%d人: ', [udCount.Position]) + S);
        mmoResult.Lines.Add(S);
      finally
        Names.Free;
      end;
    end;
  end;
end;

procedure TFormLucky.OnRollDisplay(var Msg: TMessage);

  procedure FillDisplayStrings;
  var
    I: Integer;
  begin
    for I := Low(DISPLAY_ITEMS) to High(DISPLAY_ITEMS) do
    begin
      DISPLAY_ITEMS[I] := FUsers[FUserIndex];
      Inc(FUserIndex);
      if FUserIndex = FUsers.Count then
        FUserIndex := 0;
    end;
  end;

  function JoinDisplayItems: string;
  var
    I: Integer;
  begin
    Result := '';
    for I := Low(DISPLAY_ITEMS) to High(DISPLAY_ITEMS) do
      Result := Result + DISPLAY_ITEMS[I] + '     ';
  end;

begin
  if not FRolling then
    Exit;

  FillDisplayStrings;
  pnlScroll.Caption := JoinDisplayItems;
  Application.ProcessMessages;

  if FRolling then
  begin
    // Sleep(200);
    PostMessage(Handle, WM_ROLL_DISPLAY, 0, 0);
  end;
end;

procedure TFormLucky.MixUMList;
var
  I, J: Integer;
begin
  for I := 0 to FUsers.Count - 1 do
  begin
    J := RandClosedInterval(I, FUsers.Count - 1);
    FUsers.Exchange(I, J);
  end;
end;

function TFormLucky.RandClosedInterval(RMin, RMax: Integer): Integer;
var
  I: Cardinal;
begin
  if RMin > RMax then
    raise ERangeError.Create('Max Min Error');
  if RMin = RMax then
  begin
    Result := RMin;
    Exit;
  end;

  CnRandomFillBytes(@I, SizeOf(I));
  Result := RMin + (I mod (RMax - RMin + 1));
end;

procedure TFormLucky.TestFillUMs;
var
  I: Integer;

  procedure AddToUMList(const S: string);
  begin
    Inc(I);
    FUsers.Add(S + Format('%3.3d', [I]));
  end;
begin
  FUsers.Clear;
  I := 0;

  AddToUMList('LIUBEI');
  AddToUMList('GUANYU');
  AddToUMList('ZHANGFEI');
  AddToUMList('ZHAOYUN');
  AddToUMList('ZHUGELIANG');
  AddToUMList('CAOCAO');
  AddToUMList('SUNQUAN');
  AddToUMList('DIANWEI');
  AddToUMList('TAISHICI');
  AddToUMList('SUNCE');
  AddToUMList('XUZHU');
  AddToUMList('GUOJIA');
  AddToUMList('PANTONG');
  AddToUMList('ZHOUYU');
  AddToUMList('LUSU');
  AddToUMList('JIANGGAN');
  AddToUMList('YUJING');
  AddToUMList('MAOJIE');
  AddToUMList('XIAOQIAO');
  AddToUMList('DAQIAO');
  AddToUMList('GANNING');
  AddToUMList('HUANGGAI');
  AddToUMList('CAIMAO');
  AddToUMList('ZHANGYUN');
  AddToUMList('JIANGWEI');
  AddToUMList('ZHONGHUI');
  AddToUMList('FAZHENG');
  AddToUMList('LIUCHANG');
  AddToUMList('MENGHUO');
  AddToUMList('PANDE');
  AddToUMList('DONGZHUO');
  AddToUMList('LVBU');
  AddToUMList('LVBOSHE');
  AddToUMList('CHENGONG');
  AddToUMList('SIMAYI');
  AddToUMList('SIMAZHAO');
  AddToUMList('SIMASHI');
  AddToUMList('LIUCHE');
  AddToUMList('FUHUANGHOU');
end;

procedure TFormLucky.PickLuckyNames(C: Integer; OutNames: TStrings);
var
  I: Integer;
begin
  if (C <= 0) or (C > FUsers.Count) then
    raise Exception.Create('没法抽或者不够抽');

  MixUMList; // 再次混一下

  OutNames.Clear;
  for I := 0 to C - 1 do
  begin
    OutNames.Add(FUsers[0]);   // 抽出前 C 个
    FUsers.Delete(0);          // 删掉旧的
  end;
end;

function TFormLucky.JoinNames(Names: TStrings): string;
var
  I: Integer;
begin
  Result := '';
  if Names.Count > 0 then
    for I := 0 to Names.Count - 1 do
      Result := Result + '  ' + Names[I];
end;

procedure TFormLucky.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
