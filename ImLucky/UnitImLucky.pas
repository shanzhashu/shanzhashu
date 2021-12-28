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
    dlgOpen1: TOpenDialog;
    btnMax: TSpeedButton;
    btnMin: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnChouClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnMaxClick(Sender: TObject);
    procedure btnMinClick(Sender: TObject);
  private
    FCount: Integer;
    FLogFileName: string;
    FUsers: TStringList;
    FRolling: Boolean;
    FUserIndex: Integer;
    procedure LuckyLog(const S: string);
    procedure LoadUMs(const AFile: string);
    procedure SetRolling(const Value: Boolean);
    procedure MixUserList; // 随机排列 FUsers 内的内容
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

const
  DISPLAY_COUNT = 3;
  USER_FILE = 'USER.txt';
  BACK_FILE = 'BACK.jpg';
  LOG_FILE_FMT = '%s_log.txt';

  ADVAPI32 = 'advapi32.dll';

  CRYPT_VERIFYCONTEXT = $F0000000;
  CRYPT_NEWKEYSET = $8;
  CRYPT_DELETEKEYSET = $10;

  PROV_RSA_FULL = 1;
  NTE_BAD_KEYSET = $80090016;

var
  CRLF: array[0..1] of Char = (#13, #10);
  DISPLAY_ITEMS: array[0..DISPLAY_COUNT - 1] of string;

function CryptAcquireContext(phProv: PULONG; pszContainer: PAnsiChar;
  pszProvider: PAnsiChar; dwProvType: LongWord; dwFlags: LongWord): BOOL;
  stdcall; external ADVAPI32 name 'CryptAcquireContextA';

function CryptReleaseContext(hProv: ULONG; dwFlags: LongWord): BOOL;
  stdcall; external ADVAPI32 name 'CryptReleaseContext';

function CryptGenRandom(hProv: ULONG; dwLen: LongWord; pbBuffer: PAnsiChar): BOOL;
  stdcall; external ADVAPI32 name 'CryptGenRandom';

procedure TFormLucky.FormCreate(Sender: TObject);
var
  J: TJPEGImage;
begin
  Application.Title := '大抽奖';

  FLogFileName := Format(LOG_FILE_FMT, [FormatDateTime('yyyy-mm-dd-hh-MM-ss', Now)]);
  FLogFileName := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + FLogFileName;

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

  if FileExists(USER_FILE) then
    LoadUMs(USER_FILE)
  else
  begin
    // TEST
    TestFillUMs;
    // TEST

    MixUserList;
    LuckyLog('List Shuffled');
  end;
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

  if Rolling then
    btnChou.Caption := '开始蓄力……'
  else
    btnChou.Caption := '停！！！';

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
      pnlScroll.Invalidate;
      LuckyLog('停止滚屏，抽！');
      Application.ProcessMessages;

      // 抽 udCount.Position 个奖并显示并从列表里删除
      Names := TStringList.Create;
      try
        PickLuckyNames(udCount.Position, Names);
        S := JoinNames(Names);
        Inc(FCount);
        S := Format('第%d轮抽中%d人: ', [FCount, udCount.Position]) + S;
        LuckyLog(S);
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

procedure TFormLucky.MixUserList;
var
  I, J: Integer;
  HProv: THandle;
  Res: LongWord;

  function RandClosedInterval(RMin, RMax: Integer): Integer;
  var
    D: Cardinal;
  begin
    if RMin > RMax then
      raise ERangeError.Create('Max Min Error');
    if RMin = RMax then
    begin
      Result := RMin;
      Exit;
    end;

    // 使用 Windows API 实现区块随机填充
    if HProv <> 0 then
    begin
      if not CryptGenRandom(HProv, SizeOf(D), @D) then
        raise Exception.CreateFmt('Error CryptGenRandom $%8.8x', [GetLastError]);
    end;

    Result := RMin + (D mod (RMax - RMin + 1));
  end;

begin
  HProv := 0;
  if not CryptAcquireContext(@HProv, nil, nil, PROV_RSA_FULL, 0) then
  begin
    Res := GetLastError;
    if Res = NTE_BAD_KEYSET then // KeyContainer 不存在，用新建的方式
    begin
      if not CryptAcquireContext(@HProv, nil, nil, PROV_RSA_FULL, CRYPT_NEWKEYSET) then
        raise Exception.CreateFmt('Error CryptAcquireContext NewKeySet $%8.8x', [GetLastError]);
    end
    else
        raise Exception.CreateFmt('Error CryptAcquireContext $%8.8x', [Res]);
  end;

  if HProv = 0 then
    raise Exception.CreateFmt('Error CryptAcquireContext $%8.8x', [GetLastError]);

  try
    for I := 0 to FUsers.Count - 1 do
    begin
      J := RandClosedInterval(I, FUsers.Count - 1);
      FUsers.Exchange(I, J);
    end;
  finally
    CryptReleaseContext(HProv, 0);
  end;
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

  AddToUMList('刘备LIUBEI');
  AddToUMList('关羽GUANYU');
  AddToUMList('张飞ZHANGFEI');
  AddToUMList('赵云ZHAOYUN');
  AddToUMList('诸葛亮ZHUGELIANG');
  AddToUMList('曹操CAOCAO');
  AddToUMList('孙权SUNQUAN');
  AddToUMList('典韦DIANWEI');
  AddToUMList('太史慈TAISHICI');
  AddToUMList('孙策SUNCE');
  AddToUMList('许褚XUZHU');
  AddToUMList('郭嘉GUOJIA');
  AddToUMList('庞统PANGTONG');
  AddToUMList('周瑜ZHOUYU');
  AddToUMList('鲁肃LUSU');
  AddToUMList('蒋干JIANGGAN');
  AddToUMList('于禁YUJIN');
  AddToUMList('毛玠MAOJIE');
  AddToUMList('小乔XIAOQIAO');
  AddToUMList('大乔DAQIAO');
  AddToUMList('甘宁GANNING');
  AddToUMList('黄盖HUANGGAI');
  AddToUMList('蔡瑁CAIMAO');
  AddToUMList('张允ZHANGYUN');
  AddToUMList('姜维JIANGWEI');
  AddToUMList('钟会ZHONGHUI');
  AddToUMList('法正FAZHENG');
  AddToUMList('刘禅LIUCHANG');
  AddToUMList('孟获MENGHUO');
  AddToUMList('庞德PANGDE');
  AddToUMList('董卓DONGZHUO');
  AddToUMList('吕布LVBU');
  AddToUMList('吕伯奢LVBOSHE');
  AddToUMList('陈宫CHENGONG');
  AddToUMList('司马懿SIMAYI');
  AddToUMList('司马昭SIMAZHAO');
  AddToUMList('司马师SIMASHI');
  AddToUMList('刘彻LIUCHE');
  AddToUMList('伏皇后FUHUANGHOU');
end;

procedure TFormLucky.PickLuckyNames(C: Integer; OutNames: TStrings);
var
  I: Integer;
begin
  if (C <= 0) or (C > FUsers.Count) then
    raise Exception.Create('没法抽或者不够抽');

  MixUserList; // 再次混一下

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

procedure TFormLucky.LoadUMs(const AFile: string);
var
  I: Integer;
  SL: TStringList;
begin
  if FileExists(AFile) then
  begin
    SL := TStringList.Create;

    try
      SL.LoadFromFile(AFile);
      if SL.Count = 0 then
        Exit;

      if Pos('姓名', Trim(SL[0])) = 1 then
        SL.Delete(0);

      FUsers.Clear;
      for I := 0 to SL.Count - 1 do
        FUsers.Add(StringReplace(Trim(SL[I]), ',', '', [rfReplaceAll]));

      ShowMessage('导入人员：' + IntToStr(FUsers.Count));
      LuckyLog('导入人员：' + IntToStr(FUsers.Count));

      MixUserList;
      LuckyLog('List Shuffled');
    finally
      SL.Free;
    end;
  end;
end;

procedure TFormLucky.btnImportClick(Sender: TObject);
begin
  if dlgOpen1.Execute then
    LoadUMs(dlgOpen1.FileName);
end;

procedure TFormLucky.btnMaxClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TFormLucky.btnMinClick(Sender: TObject);
begin
  WindowState := wsMinimized;
end;

end.
