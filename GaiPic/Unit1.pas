unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, ExtCtrls;

type
  TFormMain = class(TForm)
    lbl1: TLabel;
    edtSource: TEdit;
    btnBrowseSrc: TButton;
    btnDo: TButton;
    chkRecure: TCheckBox;
    chkDeleteBack: TCheckBox;
    chkAutoRotate: TCheckBox;
    GroupBox1: TGroupBox;
    cbbModel: TComboBox;
    lbl2: TLabel;
    chkResize: TCheckBox;
    Bevel1: TBevel;
    chkErrorAbort: TCheckBox;
    cbbResizeGeo: TComboBox;
    chkChangeCamara: TCheckBox;
    procedure btnBrowseSrcClick(Sender: TObject);
    procedure btnDoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkChangeCamaraClick(Sender: TObject);
    procedure chkResizeClick(Sender: TObject);
    procedure GroupBox1DblClick(Sender: TObject);
  private
    { Private declarations }
    FFinding: Boolean;
    FFoundCount: Integer;
    FModifyCount: Integer;
    FRotateCount: Integer;

    FIntWidth: Integer;
    FIntHeight: Integer;
    procedure OnFindFile(const FileName: string; const Info: TSearchRec; var Abort: Boolean);
    procedure EnsureFileNotReadOnly(const FileName: string);
    procedure ObtainJPEGSize(const FileName: string; var IntWidth: Integer; var IntHeight: Integer);
    procedure ExtractIntegers(const S: string; var Int1: Integer; var Int2: Integer);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

//非全幅：3456x2304 2592x1728 5184x3456
// 全幅： 5616x3744 4080x2720 2784x1856
const
  S_SelectSourceDirectoryCaption = '请选择照片所在的目录...';

  S_ErrorDirNotExist = '目录不存在：';
  S_ErrorResizeParam = '尺寸参数错误：';
  S_ErrorProcessFile = '文件处理失败：';
  S_ErrorRun = '命令执行失败：';
  S_ErrorObtainSize = '获取图像尺寸失败：';
  S_ErrorDelete = '文件删除失败：';
  S_ErrorRename = '文件改名失败：';
  S_ErrorCopy = '文件复制失败：';
  S_UserCancel = '用户中止。';

  S_ModifySuccess = ' 个文件已成功处理。';
  S_RotateSuccess = ' 个文件已成功旋转。';
  S_Processing = '正在处理照片文件…… ';

type
  TFindCallBack = procedure(const FileName: string; const Info: TSearchRec;
    var Abort: Boolean) of object;
{* 查找指定目录下文件的回调函数}

  TDirCallBack = procedure(const SubDir: string) of object;
{* 查找指定目录时进入子目录回调函数}

var
  FindAbort: Boolean;
  OldCaption: string;

// 运行一个文件并等待其结束
function WinExecAndWait32(FileName: string; Visibility: Integer;
  ProcessMsg: Boolean): Integer;
var
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);

  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName,                           { pointer to command line string }
    nil,                                { pointer to process security attributes }
    nil,                                { pointer to thread security attributes }
    False,                              { handle inheritance flag }
    CREATE_NEW_CONSOLE or               { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil,                                { pointer to new environment block }
    nil,                                { pointer to current directory name }
    StartupInfo,                        { pointer to STARTUPINFO }
    ProcessInfo) then
    Result := -1                        { pointer to PROCESS_INF }
  else
  begin
    if ProcessMsg then
    begin
      repeat
        Application.ProcessMessages;
        GetExitCodeProcess(ProcessInfo.hProcess, Cardinal(Result));
      until (Result <> STILL_ACTIVE) or Application.Terminated;
    end
    else
    begin
      WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
      GetExitCodeProcess(ProcessInfo.hProcess, Cardinal(Result));
    end;
  end;
end;

// 用管道方式在 Dir 目录执行 CmdLine，Output 返回输出信息，
// dwExitCode 返回退出码。如果成功返回 True
function InternalWinExecWithPipe(const CmdLine, Dir: string; slOutput: TStrings;
  var dwExitCode: Cardinal): Boolean;
var
  HOutRead, HOutWrite: THandle;
  StartInfo: TStartupInfo;
  ProceInfo: TProcessInformation;
  sa: TSecurityAttributes;
  InStream: THandleStream;
  strTemp: string;
  PDir: PChar;

  procedure ReadLinesFromPipe(IsEnd: Boolean);
  var
    s: string;
    ls: TStringList;
    i: Integer;
  begin
    if InStream.Position < InStream.Size then
    begin
      SetLength(s, InStream.Size - InStream.Position);
      InStream.Read(PChar(s)^, InStream.Size - InStream.Position);
      strTemp := strTemp + s;
      ls := TStringList.Create;
      try
        ls.Text := strTemp;
        for i := 0 to ls.Count - 2 do
          slOutput.Add(ls[i]);
        strTemp := ls[ls.Count - 1];
      finally
        ls.Free;
      end;
    end;

    if IsEnd and (strTemp <> '') then
    begin
      slOutput.Add(strTemp);
      strTemp := '';
    end;
  end;
begin
  dwExitCode := 0;
  Result := False;
  try
    FillChar(sa, sizeof(sa), 0);
    sa.nLength := sizeof(sa);
    sa.bInheritHandle := True;
    sa.lpSecurityDescriptor := nil;
    InStream := nil;
    strTemp := '';
    HOutRead := INVALID_HANDLE_VALUE;
    HOutWrite := INVALID_HANDLE_VALUE;
    try
      Win32Check(CreatePipe(HOutRead, HOutWrite, @sa, 0));

      FillChar(StartInfo, SizeOf(StartInfo), 0);
      StartInfo.cb := SizeOf(StartInfo);
      StartInfo.wShowWindow := SW_HIDE;
      StartInfo.dwFlags := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
      StartInfo.hStdError := HOutWrite;
      StartInfo.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
      StartInfo.hStdOutput := HOutWrite;

      InStream := THandleStream.Create(HOutRead);

      if Dir <> '' then
        PDir := PChar(Dir)
      else
        PDir := nil;
      Win32Check(CreateProcess(nil, //lpApplicationName: PChar
        PChar(CmdLine), //lpCommandLine: PChar
        nil, //lpProcessAttributes: PSecurityAttributes
        nil, //lpThreadAttributes: PSecurityAttributes
        True, //bInheritHandles: BOOL
        NORMAL_PRIORITY_CLASS, //CREATE_NEW_CONSOLE,
        nil,
        PDir,
        StartInfo,
        ProceInfo));

      while WaitForSingleObject(ProceInfo.hProcess, 100) = WAIT_TIMEOUT do
      begin
        ReadLinesFromPipe(False);
        Application.ProcessMessages;
        //if Application.Terminated then break;
      end;
      ReadLinesFromPipe(True);

      GetExitCodeProcess(ProceInfo.hProcess, dwExitCode);

      CloseHandle(ProceInfo.hProcess);
      CloseHandle(ProceInfo.hThread);

      Result := True;
    finally
      if InStream <> nil then InStream.Free;
      if HOutRead <> INVALID_HANDLE_VALUE then CloseHandle(HOutRead);
      if HOutWrite <> INVALID_HANDLE_VALUE then CloseHandle(HOutWrite);
    end;
  except
    ;
  end;
end;

function WinExecWithPipe(const CmdLine, Dir: string; var Output: string;
  var dwExitCode: Cardinal): Boolean;
var
  slOutput: TStringList;
begin
  slOutput := TStringList.Create;
  try
    Result := InternalWinExecWithPipe(CmdLine, Dir, slOutput, dwExitCode);
    Output := slOutput.Text;
  finally
    slOutput.Free;
  end;
end;

function ConvertFileDate(Fd: _FileTime): TDateTime;
var
  tCT: _SystemTime;
  T: _FileTime;
begin
  FileTimeToLocalFileTime(Fd, T);
  FileTimeToSystemTime(T, tCT);
  Result := SystemTimeToDateTime(tCT);
end;

// 查找指定目录下文件
function FindFile(const Path: string; const FileName: string = '*.*';
  Proc: TFindCallBack = nil; DirProc: TDirCallBack = nil; bSub: Boolean = True;
  bMsg: Boolean = True): Boolean;

  procedure DoFindFile(const Path, SubPath: string; const FileName: string;
    Proc: TFindCallBack; DirProc: TDirCallBack; bSub: Boolean;
    bMsg: Boolean);
  var
    APath: string;
    Info: TSearchRec;
    Succ: Integer;
  begin
    FindAbort := False;
    APath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Path) + SubPath);
    Succ := FindFirst(APath + FileName, faAnyFile - faVolumeID, Info);
    try
      while Succ = 0 do
      begin
        if (Info.Name <> '.') and (Info.Name <> '..') then
        begin
          if (Info.Attr and faDirectory) <> faDirectory then
          begin
            if Assigned(Proc) then
              Proc(APath + Info.FindData.cFileName, Info, FindAbort);
          end
        end;
        if bMsg then
          Application.ProcessMessages;
        if FindAbort then
          Exit;
        Succ := FindNext(Info);
      end;
    finally
      FindClose(Info);
    end;

    if bSub then
    begin
      Succ := FindFirst(APath + '*.*', faAnyFile - faVolumeID, Info);
      try
        while Succ = 0 do
        begin
          if (Info.Name <> '.') and (Info.Name <> '..') and
            (Info.Attr and faDirectory = faDirectory) then
          begin
            if Assigned(DirProc) then
              DirProc(IncludeTrailingPathDelimiter(SubPath) + Info.Name);
            DoFindFile(Path, IncludeTrailingPathDelimiter(SubPath) + Info.Name, FileName, Proc,
              DirProc, bSub, bMsg);
            if FindAbort then
              Exit;
          end;
          Succ := FindNext(Info);
        end;
      finally
        FindClose(Info);
      end;
    end;
  end;

begin
  DoFindFile(Path, '', FileName, Proc, DirProc, bSub, bMsg);
  Result := not FindAbort;
end;

procedure TFormMain.btnBrowseSrcClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := edtSource.Text;
  if SelectDirectory(S_SelectSourceDirectoryCaption, '.', Dir) then
    edtSource.Text := Dir;
end;

procedure TFormMain.btnDoClick(Sender: TObject);
var
  Res, SizeEnabled: Boolean;
begin
  if FFinding then
  begin
    FFinding := False;
    Exit;
  end;

  edtSource.Text := Trim(edtSource.Text);
  if not DirectoryExists(edtSource.Text) then
  begin
    ShowMessage(S_ErrorDirNotExist + edtSource.Text);
    Exit;
  end;

  if chkResize.Checked then
  begin
    ExtractIntegers(cbbResizeGeo.Text, FIntWidth, FIntHeight);
    if (FIntWidth = 0) or (FIntHeight = 0) then
    begin
      ShowMessage(S_ErrorResizeParam + cbbResizeGeo.Text);
      Exit;
    end;
  end;

  Screen.Cursor := crHourGlass;
  chkErrorAbort.Enabled := False;
  SizeEnabled := cbbResizeGeo.Enabled;
  cbbResizeGeo.Enabled := False;
  try
    FModifyCount := 0;
    FFoundCount := 0;
    FRotateCount := 0;
    FFinding := True;
    Res := FindFile(edtSource.Text, '*.JPG', OnFindFile, nil, chkRecure.Checked, False);
  finally
    Screen.Cursor := crDefault;
    Caption := OldCaption;
    chkErrorAbort.Enabled := True;
    cbbResizeGeo.Enabled := SizeEnabled;
  end;

  FFinding := False;
  if Res then
    ShowMessage(IntToStr(FModifyCount) + S_ModifySuccess + ' ' + IntToStr(FRotateCount) + S_RotateSuccess);
end;

procedure TFormMain.OnFindFile(const FileName: string;
  const Info: TSearchRec; var Abort: Boolean);
var
  Res, W, H: Integer;
  S, Cmd1, Cmd2, Cmd3, SizeFormat: string;
  ExitCode: Cardinal;
  DestFile: string;
begin
  Inc(FFoundCount);

  if not FFinding then
  begin
    ShowMessage(S_UserCancel);
    Abort := True;
    Exit;
  end;

  if (Info.Attr and faReadOnly) <> 0 then
  begin
    // ReadOnly. Change the permission
    FileSetAttr(FileName, Info.Attr and (not faReadOnly));
  end;

  // 5184x3456, 3456x2304, 2592x1728,
  DestFile := FileName;
  if chkResize.Checked then
  begin
    ObtainJPEGSize(FileName, W, H);
    if (W = 0) or (H = 0) then
    begin
      ShowMessage(S_ErrorObtainSize + FileName);
      Abort := chkErrorAbort.Checked;;
      Exit;
    end;

    if H > W then
      SizeFormat := IntToStr(FIntHeight) + 'x' + IntToStr(FIntWidth)
    else
      SizeFormat := IntToStr(FIntWidth) + 'x' + IntToStr(FIntHeight);
     
    Cmd1 := 'gm convert -resize ' + SizeFormat + ' -compress Lossless "' + FileName + '" "' + DestFile + '"';
    Res := WinExecAndWait32(Cmd1, SW_HIDE, True);
    if Res <> 0 then
    begin
      ShowMessage(S_ErrorRun + Cmd1);
      Abort := chkErrorAbort.Checked;;
      Exit;
    end;
    Sleep(0);
  end;

  if chkAutoRotate.Checked then
  begin
    if WinExecWithPipe('exiftool -Orientation "' + FileName + '"', 'C:\', S, ExitCode) then
    begin
      if ExitCode = 0 then
      begin
        Cmd1 := ''; Cmd2 := '';
        if Pos('Rotate 270 CW', S) > 0 then
        begin
          Cmd1 := 'gm convert -rotate -90 -compress Lossless "' + FileName + '" "' + DestFile + '"';
        end
        else if Pos('Rotate 90 CW', S) > 0 then
        begin
          Cmd1 := 'gm convert -rotate 90 -compress Lossless "' + FileName + '" "' + DestFile + '"';
        end;

        if Cmd1 <> '' then
        begin
          Res := WinExecAndWait32(Cmd1, SW_HIDE, True);
          if Res <> 0 then
          begin
            ShowMessage(S_ErrorRun + Cmd1);
            Abort := chkErrorAbort.Checked;;
            Exit;
          end;
          Sleep(0);

          Cmd2 := 'exiftool -overwrite_original -Orientation=1 -n "' + FileName + '"';
          Res := WinExecAndWait32(Cmd2, SW_HIDE, True);
          if Res <> 0 then
          begin
            ShowMessage(S_ErrorRun + Cmd2);
            Abort := chkErrorAbort.Checked;;
            Exit;
          end;

          Inc(FRotateCount);
        end;
      end
      else
      begin
        ShowMessage(S_ErrorRun + 'get orientation');
        Abort := True;
        Exit;
      end;
    end;
  end;

  if chkChangeCamara.Checked then
  begin
    if not chkDeleteBack.Checked then
      Cmd3 := 'exiftool -model="' + cbbModel.Text + '" "' + FileName + '"'
    else
      Cmd3 := 'exiftool -overwrite_original -model="' + cbbModel.Text + '" "' + FileName + '"';

    Res := WinExecAndWait32(Cmd3, SW_HIDE, True);
    if Res <> 0 then
    begin
      ShowMessage(S_ErrorProcessFile + FileName + ' -> ' + FileName);
      Abort := chkErrorAbort.Checked;;
      Exit;
    end;

    if chkDeleteBack.Checked then
      DeleteFile(FileName + '_original');
  end;

  Inc(FModifyCount);
  Caption := S_Processing + IntToStr(FModifyCount) + ' : ' + FileName;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Application.Title := Caption;
  OldCaption := Caption;
  cbbModel.ItemIndex := 0;
end;

procedure TFormMain.chkChangeCamaraClick(Sender: TObject);
begin
  cbbModel.Enabled := chkChangeCamara.Checked;
end;

procedure TFormMain.EnsureFileNotReadOnly(const FileName: string);
var
  Attr: Integer;
begin
  Attr := FileGetAttr(FileName);

end;

procedure TFormMain.chkResizeClick(Sender: TObject);
begin
  cbbResizeGeo.Enabled := chkResize.Checked;
end;

procedure TFormMain.ExtractIntegers(const S: string; var Int1,
  Int2: Integer);
var
  P: Integer;
  S1, S2: string;
begin
  Int1 := 0; Int2 := 0;
  if S <> '' then
  begin
    P := Pos('x', S);
    if P > 0 then
    begin
      S1 := Copy(S, 1, P - 1);
      S2 := Copy(S, P + 1, MaxInt);

      Int1 := StrToIntDef(S1, 0);
      Int2 := StrToIntDef(S2, 0);
    end;
  end;
end;

procedure TFormMain.GroupBox1DblClick(Sender: TObject);
begin
  chkChangeCamara.Visible := not chkChangeCamara.Visible;
  lbl2.Visible := not lbl2.Visible;
  cbbModel.Visible := not cbbModel.Visible; 
end;

procedure TFormMain.ObtainJPEGSize(const FileName: string; var IntWidth,
  IntHeight: Integer);
const
  JPEG = ' JPEG ';
var
  Cmd, S: string;
  P, W, H: Integer;
  ExitCode: DWORD;
begin
  Cmd := 'gm identify "' + FileName + '"';
  if WinExecWithPipe(Cmd, 'C:\', S, ExitCode) then
  begin
    if ExitCode = 0 then
    begin
      P := Pos(JPEG, S);
      if P > 0 then
      begin
        S := Copy(S, P + Length(JPEG), MaxInt);
        P := Pos('+', S);
        if P > 0 then
        begin
          S := Copy(S, 1, P - 1);
          ExtractIntegers(S, IntWidth, IntHeight);
        end;
      end;
    end;
  end;
end;

end.
