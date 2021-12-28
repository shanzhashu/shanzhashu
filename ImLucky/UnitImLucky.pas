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
    procedure MixUserList; // ������� FUsers �ڵ�����
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
  Application.Title := '��齱';

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
    raise Exception.Create('�齱��������')
  else if udCount.Position > FUsers.Count then
    raise Exception.Create('�˲�����');

  if Rolling then
    btnChou.Caption := '��ʼ��������'
  else
    btnChou.Caption := 'ͣ������';

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
      LuckyLog('��ʼ��������');
    end
    else
    begin
      pnlScroll.Caption := '';
      pnlScroll.Invalidate;
      LuckyLog('ֹͣ�������飡');
      Application.ProcessMessages;

      // �� udCount.Position ��������ʾ�����б���ɾ��
      Names := TStringList.Create;
      try
        PickLuckyNames(udCount.Position, Names);
        S := JoinNames(Names);
        Inc(FCount);
        S := Format('��%d�ֳ���%d��: ', [FCount, udCount.Position]) + S;
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

    // ʹ�� Windows API ʵ������������
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
    if Res = NTE_BAD_KEYSET then // KeyContainer �����ڣ����½��ķ�ʽ
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

  AddToUMList('����LIUBEI');
  AddToUMList('����GUANYU');
  AddToUMList('�ŷ�ZHANGFEI');
  AddToUMList('����ZHAOYUN');
  AddToUMList('�����ZHUGELIANG');
  AddToUMList('�ܲ�CAOCAO');
  AddToUMList('��ȨSUNQUAN');
  AddToUMList('��ΤDIANWEI');
  AddToUMList('̫ʷ��TAISHICI');
  AddToUMList('���SUNCE');
  AddToUMList('����XUZHU');
  AddToUMList('����GUOJIA');
  AddToUMList('��ͳPANGTONG');
  AddToUMList('���ZHOUYU');
  AddToUMList('³��LUSU');
  AddToUMList('����JIANGGAN');
  AddToUMList('�ڽ�YUJIN');
  AddToUMList('ë�dMAOJIE');
  AddToUMList('С��XIAOQIAO');
  AddToUMList('����DAQIAO');
  AddToUMList('����GANNING');
  AddToUMList('�Ƹ�HUANGGAI');
  AddToUMList('���CAIMAO');
  AddToUMList('����ZHANGYUN');
  AddToUMList('��άJIANGWEI');
  AddToUMList('�ӻ�ZHONGHUI');
  AddToUMList('����FAZHENG');
  AddToUMList('����LIUCHANG');
  AddToUMList('�ϻ�MENGHUO');
  AddToUMList('�ӵ�PANGDE');
  AddToUMList('��׿DONGZHUO');
  AddToUMList('����LVBU');
  AddToUMList('������LVBOSHE');
  AddToUMList('�¹�CHENGONG');
  AddToUMList('˾��ܲSIMAYI');
  AddToUMList('˾����SIMAZHAO');
  AddToUMList('˾��ʦSIMASHI');
  AddToUMList('����LIUCHE');
  AddToUMList('���ʺ�FUHUANGHOU');
end;

procedure TFormLucky.PickLuckyNames(C: Integer; OutNames: TStrings);
var
  I: Integer;
begin
  if (C <= 0) or (C > FUsers.Count) then
    raise Exception.Create('û������߲�����');

  MixUserList; // �ٴλ�һ��

  OutNames.Clear;
  for I := 0 to C - 1 do
  begin
    OutNames.Add(FUsers[0]);   // ���ǰ C ��
    FUsers.Delete(0);          // ɾ���ɵ�
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

      if Pos('����', Trim(SL[0])) = 1 then
        SL.Delete(0);

      FUsers.Clear;
      for I := 0 to SL.Count - 1 do
        FUsers.Add(StringReplace(Trim(SL[I]), ',', '', [rfReplaceAll]));

      ShowMessage('������Ա��' + IntToStr(FUsers.Count));
      LuckyLog('������Ա��' + IntToStr(FUsers.Count));

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
