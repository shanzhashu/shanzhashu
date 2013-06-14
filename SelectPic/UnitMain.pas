unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, ExtCtrls, StdCtrls, ShellCtrls, Contnrs, jpeg,
  GDIPAPI, GDIPOBJ, GDIPUTIL, Buttons, LXImage, ActnList, ToolWin, ShellAPI,
  Menus;

const
  WM_UPDATE_SELECTION = WM_USER + 200;
  WM_UPDATE_IMAGE = WM_USER + 201;
  INFO_QUERY_CAPTION = '提示';
  INFO_ERROR_CAPTION = '错误';
  INI_FILE = '.\feipaibuke.ini';
  ERROR_FILE = '.\error.bmp';

type
  TDisplayMode = (dmMatch, dmActual, dmCustom);

  TFormMain = class(TForm)
    pnlLeft: TPanel;
    statBar: TStatusBar;
    spl1: TSplitter;
    pnlMain: TPanel;
    pnlImage: TPanel;
    spl2: TSplitter;
    pnlContain: TPanel;
    tvMain: TShellTreeView;
    spl3: TSplitter;
    pnlLeftBottom: TPanel;
    pnlToolbar: TPanel;
    lvImages: TListView;
    ilImages: TImageList;
    lstSelection: TListBox;
    pnlContentBtm: TPanel;
    actlstMain: TActionList;
    actSelectAll: TAction;
    actSelectNone: TAction;
    actShowMatch: TAction;
    actShowActual: TAction;
    actCopySelection: TAction;
    actRemoveSelection: TAction;
    bvl1: TBevel;
    ilActions: TImageList;
    actPrevImage: TAction;
    actNextImage: TAction;
    tlbSelection: TToolBar;
    btnSelectAll: TToolButton;
    btnSelectNone: TToolButton;
    btnRemoveSelection: TToolButton;
    btnCopySelection: TToolButton;
    btn1: TToolButton;
    tlbImage: TToolBar;
    btnPrevImage: TToolButton;
    btnNextImage: TToolButton;
    btnShowActual: TToolButton;
    btnShowMatch: TToolButton;
    btn2: TToolButton;
    actSlide: TAction;
    btn3: TToolButton;
    btnSlide: TToolButton;
    actSetting: TAction;
    btnSetting: TToolButton;
    btn5: TToolButton;
    pnlDisplay: TPanel;
    actDeleteFile: TAction;
    btnDeleteFile: TToolButton;
    btn4: TToolButton;
    actContextMenu: TAction;
    actShowInfo: TAction;
    pmImage: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;

    procedure tvMainChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvImagesData(Sender: TObject; Item: TListItem);
    procedure lvImagesCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvImagesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvImagesDblClick(Sender: TObject);
    procedure lvImagesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actShowMatchExecute(Sender: TObject);
    procedure actShowActualExecute(Sender: TObject);
    procedure lvImagesKeyPress(Sender: TObject; var Key: Char);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actSelectNoneExecute(Sender: TObject);
    procedure actCopySelectionExecute(Sender: TObject);
    procedure tvMainChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actRemoveSelectionExecute(Sender: TObject);
    procedure lstSelectionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pnlContentBtmResize(Sender: TObject);
    procedure actPrevImageExecute(Sender: TObject);
    procedure actNextImageExecute(Sender: TObject);
    procedure actSlideExecute(Sender: TObject);
    procedure pnlToolbarResize(Sender: TObject);
    procedure lstSelectionDblClick(Sender: TObject);
    procedure actlstMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actSettingExecute(Sender: TObject);
    procedure pnlDisplayResize(Sender: TObject);
    procedure actDeleteFileExecute(Sender: TObject);
    procedure actContextMenuExecute(Sender: TObject);
    procedure actShowInfoExecute(Sender: TObject);
  private
    { Private declarations }
    FCheckedBitmap: TBitmap;
    FUncheckedBitMap: TBitmap;
    FCheckedIcon: TIcon;
    FUncheckedIcon: TIcon;
    FFiles: TObjectList;
    FCurrentFileName: string;
    FCurrentIndex: Integer;
    FCurrentGPImage: TGPImage;
    FCurImgWidth, FCurImgHeight: Integer;
    FDisplayMode: TDisplayMode;
    FImgContent: TLXImage;
    FZoomFactor: Extended;
    FSrcRect: TRect;  // 以源内容为参考系的绘制源区域
    FDestRect: TRect; // 以FImgContent区域为参考系的绘制目标区域
    FImageMouseDownPos: TPoint;
    FImageMouseDown: Boolean;
    FCurSelectionChanged: Boolean;
    FExifTool: string;
    procedure OnFindFile(const FileName: string; const Info: TSearchRec; var Abort: Boolean);
    procedure UpdateSelectionText(var Msg: TMessage); message WM_UPDATE_SELECTION;
    procedure UpdateImage(var Msg: TMessage); message WM_UPDATE_IMAGE;
    procedure UpdateSelectionSummary;
    procedure UpdateShowingImageInfo;
    procedure ShowMatchedImage(const FileName: string; ForceReload: Boolean = True);
    procedure ShowActualImage(const FileName: string; ForceReload: Boolean = True);
    procedure ClearImage();
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageDblClick(Sender: TObject);
    function QueryDlg(const Msg: string; const Cap: string = INFO_QUERY_CAPTION ): Boolean;
    procedure InfoDlg(const Msg: string; const Cap: string = INFO_QUERY_CAPTION);
    procedure ErrDlg(const Msg: string; const Cap: string = INFO_ERROR_CAPTION);
    function YesNoDlg(const Msg: string; const Cap: string = INFO_QUERY_CAPTION): Boolean;
  public
    { Public declarations }
  end;

  TFileItem = class(TObject)
  private
    FCaption: string;
    FFileName: string;
    FChecked: Boolean;
    FBitmap: TBitmap;
    FThumbValid: Boolean;
    FImageIndex: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    property FileName: string read FFileName write FFileName;
    property Caption: string read FCaption write FCaption;
    property Checked: Boolean read FChecked write FChecked;
    property Bitmap: TBitmap read FBitmap;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property ThumbValid: Boolean read FThumbValid write FThumbValid;
  end;

var
  FormMain: TFormMain;

implementation

uses UnitSlide, UnitOptions, UnitDisplay, UnitSetting, CnShellUtils,
  UnitInfo;

{$R *.dfm}

const
  THUMB_MAX = 120;
  ICON_SIZE = 16;

  ListViewIconW: Word = 120; {Width of thumbnail in ICON view mode}
  ListViewIconH: Word = 120; {Height of thumbnail size}
  CheckWidth: Word = 16; {Width of check mark box}
  CheckHeight: Word = 16; {Height of checkmark}
  CheckBiasTop: Word = 20; {This aligns the checkbox to be in centered}
  CheckBiasLeft: Word = 20; {In the row of the list item display}

  SCnMsgDlgOK = '确定';
  SCnMsgDlgCancel = '取消';

type
  TFindCallBack = procedure(const FileName: string; const Info: TSearchRec;
    var Abort: Boolean) of object;
{* 查找指定目录下文件的回调函数}

  TDirCallBack = procedure(const SubDir: string) of object;
{* 查找指定目录时进入子目录回调函数}

var
  FindAbort: Boolean;

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

function DeleteFileWithUndo(FileName : string ): Boolean;
var
  Fos : TSHFileOpStruct;
begin
  FillChar( Fos, SizeOf( Fos ), 0 );
  with Fos do
  begin
    wFunc  := FO_DELETE;
    pFrom  := PChar( FileName );
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
  end;
  Result := ( 0 = ShFileOperation( Fos ) );
end;

procedure ExploreDir(APath: string; ShowDir: Boolean);
var
  strExecute: AnsiString;
begin
  if not ShowDir then
    strExecute := AnsiString(Format('EXPLORER.EXE "%s"', [APath]))
  else
    strExecute := AnsiString(Format('EXPLORER.EXE /e, "%s"', [APath]));
  WinExec(PAnsiChar(strExecute), SW_SHOWNORMAL);
end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

// 输入对话框
function CnInputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  ComboBox: TComboBox;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
{$IFDEF CREATE_PARAMS_BUG}
  OldLong: Longint;
  AHandle: THandle;
  NeedChange: Boolean;
{$ENDIF}
begin
  Result := False;
  ComboBox := nil;

{$IFDEF CREATE_PARAMS_BUG}
  NeedChange := False;
  OldLong := 0;
  AHandle := Application.ActiveFormHandle;
{$ENDIF}

  Form := TForm.Create(Application);
  with Form do
    try
      Scaled := False;
      Font.Handle := GetStockObject(DEFAULT_GUI_FONT);
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      ClientHeight := MulDiv(63, DialogUnits.Y, 8);
      Position := poScreenCenter;

      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        AutoSize := True;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Caption := APrompt;
      end;

      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := MulDiv(19, DialogUnits.Y, 8);
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;

      ButtonTop := MulDiv(41, DialogUnits.Y, 8);
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);

      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SCnMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;

      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SCnMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;

{$IFDEF CREATE_PARAMS_BUG}
      if AHandle <> 0 then
      begin
        OldLong := GetWindowLong(AHandle, GWL_EXSTYLE);
        NeedChange := OldLong and WS_EX_TOOLWINDOW = WS_EX_TOOLWINDOW;
        if NeedChange then
          SetWindowLong(AHandle, GWL_EXSTYLE, OldLong and not WS_EX_TOOLWINDOW);
      end;
{$ENDIF}

      if ShowModal = mrOk then
      begin
        if Assigned(ComboBox) then
        begin
          Value := ComboBox.Text;
        end
        else
          Value := Edit.Text;
        Result := True;
      end;
    finally
{$IFDEF CREATE_PARAMS_BUG}
      if NeedChange and (OldLong <> 0) then
        SetWindowLong(AHandle, GWL_EXSTYLE, OldLong);
{$ENDIF}
      Form.Free;
    end;
end;

// 输入对话框
function CnInputBox(const ACaption, APrompt, ADefault: string; var Res: string): Boolean;
begin
  Res := ADefault;
  Result := CnInputQuery(ACaption, APrompt, Res);
end;

procedure LoadThumb(const FileName: string; Bmp: TBitmap);
var
  E: Extended;
  H, W: Integer;
  G: TGPGraphics;
  Img, Thumb, Err: TGPImage;
begin
  if not Bmp.HandleAllocated then
    Exit;

  G := nil;
  Img := nil;
  Thumb := nil;

  try
    try
      G := TGPGraphics.Create(Bmp.Canvas.Handle);
      Img := TGPImage.Create(FileName);

      W := Img.GetWidth;
      H := Img.GetHeight;
      if W > H then
      begin
        W := THUMB_MAX;
        E := Img.GetWidth / W;
        E := Img.GetHeight / E;
        H := Round(E);
      end
      else
      begin
        H := THUMB_MAX;
        E := Img.GetHeight /H;
        E := Img.GetWidth /E;
        W := Round(E);
      end;

      Thumb := Img.GetThumbnailImage(W, H, nil, nil);
      G.Clear(MakeColor($FF, $FF, $FF));
      G.DrawImage(Thumb, (Bmp.Width - W) div 2, (Bmp.Height - H) div 2, Thumb.GetWidth, Thumb.GetHeight);
    except
      G.Clear(MakeColor($FF, $FF, $FF));
      Err := nil;
      try
        try
          Err := TGPImage.Create(ERROR_FILE);
          G.DrawImage(Err, (Bmp.Width - Err.GetWidth) div 2, (Bmp.Height - Err.GetHeight) div 2);
        except
          ;
        end;
      finally
      Err.Free;
      end;
    end;
  finally
    Img.Free;
    Thumb.Free;
    G.Free;
  end;
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

procedure TFormMain.tvMainChange(Sender: TObject; Node: TTreeNode);
var
  Res: Boolean;
begin
  // Get All Files List
  if FFiles = nil then
    Exit;

  FFiles.Clear;
  ilImages.Clear;
  lstSelection.Clear;
  FCurrentFileName := '';
  ClearImage;

  Screen.Cursor := crHourGlass;
  try
    Res := FindFile(tvMain.Path, '*.JPG', OnFindFile, nil, False, False);
  finally
    Screen.Cursor := crDefault;
  end;

  if Res then
  begin
    lvImages.Items.Count := FFiles.Count;
    lvImages.Invalidate;
  end;
  FCurSelectionChanged := False;
end;

procedure TFormMain.OnFindFile(const FileName: string;
  const Info: TSearchRec; var Abort: Boolean);
var
  F: TFileItem;
begin
  F := TFileItem.Create;
  F.FileName := FileName;
  F.Caption := ChangeFileExt(ExtractFileName(FileName), '');
  FFiles.Add(F);

  ilImages.Add(F.Bitmap, nil);
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  P: string;
begin
  FFiles := TObjectList.Create(True);

  FCheckedIcon := TIcon.Create;
  FCheckedIcon.Height := ICON_SIZE;
  FCheckedIcon.Width := ICON_SIZE;
  FCheckedIcon.LoadFromFile('checked.ico');
  //FCheckedIcon.Handle := LoadIcon(HInstance, 'CHECKED');


  FUnCheckedIcon := TIcon.Create;
  FUnCheckedIcon.LoadFromFile('unchecked.ico');
  FUncheckedIcon.Height := ICON_SIZE;
  FUncheckedIcon.Width := ICON_SIZE;
  //FUncheckedIcon.Handle := LoadIcon(HInstance, 'UNCHECKED');

  FImgContent := TLXImage.Create(Self);
  FImgContent.Parent := pnlDisplay;
  FImgContent.AutoSize := True;
  FImgContent.Align := alClient;
  FImgContent.OnMouseDown := ImageMouseDown;
  FImgContent.OnMouseMove := ImageMouseMove;
  FImgContent.OnMouseUp := ImageMouseUp;
  FImgContent.OnDblClick := ImageDblClick;
  FImgContent.PopupMenu := pmImage;

  IniOptions.LoadFromFile(INI_FILE);

  if DirectoryExists(IniOptions.ConfigRootDir) then
  begin
    tvMain.Path := IniOptions.ConfigRootDir;
    tvMain.Selected.Expand(False);
    // TODO: Expand?
  end;
  Application.Title := Caption;
  Left := 0; Top := 0;
  Width := Screen.DesktopWidth;
  Height := Screen.DesktopHeight - 30;
  lvImages.DoubleBuffered := True;

  P := ExtractFilePath(Application.ExeName);
  P := IncludeTrailingPathDelimiter(P) + '\exiftool.exe';
  if FileExists(P) then
  begin
    FExifTool := P;
  end
  else
  begin
    P :=  ExtractFilePath(Application.ExeName);
    P := IncludeTrailingPathDelimiter(P) + '..\GaiPic\exiftool.exe';
    if FileExists(P) then
    begin
      FExifTool := P;
    end;
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FUncheckedIcon.Free;
  FCheckedIcon.Free;

  FUncheckedBitMap.Free;
  FCheckedBitmap.Free;
  FFiles.Free;
end;

procedure TFormMain.lvImagesData(Sender: TObject; Item: TListItem);
var
  F: TFileItem;
  Idx: Integer;
begin
  if Item <> nil then
  begin
    Idx := Item.Index;
    if (Idx >= 0) and (Idx < FFiles.Count) then
    begin
      F := TFileItem(FFiles.Items[Idx]);
      if F <> nil then
      begin
        Item.Caption := F.Caption;
        Item.Checked := F.Checked;
        if not F.ThumbValid then
        begin
          LoadThumb(F.FileName, F.Bitmap);
          F.ThumbValid := True;
          F.ImageIndex := ilImages.Add(F.Bitmap, nil);
        end;
        Item.ImageIndex := F.ImageIndex;
      end;
    end;
  end;
end;

{ TFileItem }

constructor TFileItem.Create;
begin
  FImageIndex := -1;
  FBitmap := TBitmap.Create;
  FBitmap.Width := THUMB_MAX;
  FBitmap.Height := THUMB_MAX;
end;

destructor TFileItem.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TFormMain.lvImagesCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  P: TPoint;
  OldColor: TColor;
begin
  OldColor := Sender.Canvas.Pen.Color;
  P := Item.GetPosition;

  if Item.Checked then
    Sender.Canvas.Draw(P.X - 12, P.Y + 2, FCheckedIcon)
  else
    Sender.Canvas.Draw(P.X - 12, P.Y + 2, FUncheckedIcon);

  Sender.Canvas.Brush.Color := (Sender as TListView).Color;
  Sender.Canvas.Pen.Color := OldColor;
end;

procedure TFormMain.UpdateSelectionText(var Msg: TMessage);
var
  I: Integer;
  F: TFileItem;
begin
  lstSelection.Clear;
  lstSelection.Items.BeginUpdate;
  try
    for I := 0 to FFiles.Count - 1 do
    begin
      F := TFileItem(FFiles.Items[I]);
      if (F <> nil) and F.Checked then
        lstSelection.Items.Add(F.Caption);
    end;
  finally
    lstSelection.Items.EndUpdate;
  end;
  FCurSelectionChanged := True;
  UpdateSelectionSummary;
end;

procedure TFormMain.lvImagesChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  Idx: Integer;
  F: TFileItem;
begin
  if Change = ctState then
  begin
    if (Item <> nil) and Item.Selected then
    begin
      Idx := Item.Index;
      if (Idx >= 0) and (Idx < FFiles.Count) then
      begin
        F := TFileItem(FFiles.Items[Idx]);
        if FCurrentFileName <> F.FileName then
        begin
          ShowMatchedImage(F.FileName);
          FCurrentIndex := Idx;
          UpdateShowingImageInfo;
        end;
      end;
    end;
  end;
end;

procedure TFormMain.lvImagesDblClick(Sender: TObject);
var
  P: TPoint;
  Item: TListItem;
  Idx: Integer;
  F: TFileItem;
begin
  P := Mouse.CursorPos;
  P := (Sender as TListView).ScreenToClient(P);
  Item := (Sender as TListView).GetItemAt(P.X, P.Y);
  if Item = nil then
    Exit;

  Idx := Item.Index;
  if (Idx < 0) or (Idx >= FFiles.Count) then
    Exit;

  F := TFileItem(FFiles.Items[Idx]);
  F.Checked := not F.Checked;

  (Sender as TListView).Invalidate;
  PostMessage(Handle, WM_UPDATE_SELECTION, 0, 0);
end;

procedure TFormMain.ShowMatchedImage(const FileName: string; ForceReload: Boolean);
var
  W, H: Integer;
  EW, EH: Extended;
  G: TGPGraphics;
begin
  if FileName = '' then
    Exit;
  if not FileExists(FileName) then
    Exit;

  try
    // Show this image as Matched.
    // 只有文件名相同并且ForceReload是False时才不重新来
    // 如果文件名不同或ForceReload是True，就释放掉重来
    if ForceReload or (FCurrentFileName <> FileName) then
    begin
      if FCurrentGPImage <> nil then
        FreeAndNil(FCurrentGPImage);
      FCurrentGPImage := TGPImage.Create(FileName);
    end;

    if FCurrentGPImage = nil then
      FCurrentGPImage := TGPImage.Create(FileName);

    W := FCurrentGPImage.GetWidth;
    H := FCurrentGPImage.GetHeight;

    // Matched 状态，源区是整张图
    FSrcRect.Left := 0;
    FSrcRect.Top := 0;
    FSrcRect.Right := W;
    FSrcRect.Bottom := H;

    if (FCurImgWidth > 0) and (FCurImgHeight > 0) then
    begin
      G := TGPGraphics.Create(FImgContent.Canvas.Handle);
      G.Clear(MakeColor($FF, $FF, $FF));
      if (W <= FCurImgWidth) and (H <= FCurImgHeight) then
      begin
        // 直接原始大小居中显示
        FZoomFactor := 1.0;
        FDestRect.Left := (FCurImgWidth - W) div 2;
        FDestRect.Top := (FCurImgHeight - H) div 2;
        FDestRect.Right := FDestRect.Left + W;
        FDestRect.Bottom := FDestRect.Top + H;

        G.DrawImage(FCurrentGPImage, FDestRect.Left,
          FDestRect.Top, W, H);
      end
      else
      begin
        // 缩放至合适大小
        EW := FCurImgWidth / W; // 横向缩比例
        EH := FCurImgHeight / H; // 纵向缩比例

        if EW >= EH then // 横的缩得多，按横的来
        begin
          FZoomFactor := EH;
          W := Round(W * FZoomFactor);
          H := Round(H * FZoomFactor);
        end
        else
        begin
          FZoomFactor := EW;
          W := Round(W * FZoomFactor);
          H := Round(H * FZoomFactor);
        end;

        // 再用缩放的显示
        FDestRect.Left := (FCurImgWidth - W) div 2;
        FDestRect.Top := (FCurImgHeight - H) div 2;
        FDestRect.Right := FDestRect.Left + W;
        FDestRect.Bottom := FDestRect.Top + H;
        G.DrawImage(FCurrentGPImage, FDestRect.Left,
           FDestRect.Top, W, H);

        // TODO: 画个黑框？
//        R.Left := (FCurImgWidth - W) div 2;
//        R.Top := (FCurImgHeight - H) div 2;
//        R.Right := R.Left + W;
//        R.Bottom := R.Top + H;
//        imgContent.Canvas.Pen.Color := clBlack;
//        imgContent.Canvas.FrameRect(R);
      end;
      G.Free;
    end;
    FImgContent.Invalidate;
    FDisplayMode := dmMatch;
  except
    ;
  end;
  FCurrentFileName := FileName;
end;

procedure TFormMain.UpdateImage(var Msg: TMessage);
begin
  if FDisplayMode = dmMatch then
    ShowMatchedImage(FCurrentFileName, False)
  else if FDisplayMode = dmActual then
    ShowActualImage(FCurrentFileName, False);
end;

procedure TFormMain.ShowActualImage(const FileName: string; ForceReload: Boolean);
var
  W, H: Integer;
  G: TGPGraphics;
begin
  if FileName = '' then
    Exit;
  if not FileExists(FileName) then
    Exit;

  try
    // Show this image as Actual.

    // 只有文件名相同并且ForceReload是False时才不重新来
    // 如果文件名不同或ForceReload是True，就释放掉重来
    if ForceReload or (FCurrentFileName <> FileName) then
    begin
      if FCurrentGPImage <> nil then
        FreeAndNil(FCurrentGPImage);
      FCurrentGPImage := TGPImage.Create(FileName);
    end;

    if FCurrentGPImage = nil then
      FCurrentGPImage := TGPImage.Create(FileName);

    W := FCurrentGPImage.GetWidth;
    H := FCurrentGPImage.GetHeight;

    if (FCurImgWidth > 0) and (FCurImgHeight > 0) then
    begin
      G := TGPGraphics.Create(FImgContent.Canvas.Handle);
      G.Clear(MakeColor($FF, $FF, $FF));
      FDestRect.Left := (FCurImgWidth - W) div 2;
      FDestRect.Top := (FCurImgHeight - H) div 2;
      FDestRect.Right := FDestRect.Left + W;
      FDestRect.Bottom := FDestRect.Top + H;

      if FDestRect.Left > 0 then
        FSrcRect.Left := 0
      else
        FSrcRect.Left := - FDestRect.Left;

      if FDestRect.Top > 0 then
        FSrcRect.Top := 0
      else
        FSrcRect.Top := - FDestRect.Top;

      FSrcRect.Right := FSrcRect.Left + W;
      FSrcRect.Bottom := FSrcRect.Top + H; // To prevent exceed Image Size?
      G.DrawImage(FCurrentGPImage, FDestRect.Left,
        FDestRect.Top, W, H);
      G.Free;
    end;
    FImgContent.Invalidate;
    FDisplayMode := dmActual;
    FZoomFactor := 1.0;
  except
    ;
  end;
  FCurrentFileName := FileName;
end;

procedure TFormMain.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    FImageMouseDown := True;
    FImageMouseDownPos.X := X;
    FImageMouseDownPos.Y := Y;
  end;
end;

procedure TFormMain.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  DeltaX, DeltaY: Integer;
  G: TGPGraphics;
  R: TRect;
begin
  if FImageMouseDown and (FCurrentGPImage <> nil) then
  begin
    DeltaX := X - FImageMouseDownPos.X;
    DeltaY := Y - FImageMouseDownPos.Y;

    G := TGPGraphics.Create(FImgContent.Canvas.Handle);
    G.Clear(MakeColor($FF, $FF, $FF));
    R := FDestRect;
    OffsetRect(R, DeltaX, DeltaY);
    G.DrawImage(FCurrentGPImage, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
    FImgContent.Invalidate;

    FDisplayMode := dmCustom;
  end;
end;

procedure TFormMain.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  DeltaX, DeltaY: Integer;
begin
  if Button = mbLeft then
  begin
    FImageMouseDown := False;
    DeltaX := X - FImageMouseDownPos.X;
    DeltaY := Y - FImageMouseDownPos.Y;
    OffsetRect(FDestRect, DeltaX, DeltaY);
  end;
//  else if Button = mbRight then
//  begin
//    if FCurrentFileName <> '' then
//    begin
//      P.X := X;
//      P.Y := Y;
//      DisplayContextMenu(Handle, FCurrentFileName, FImgContent.ClientToScreen(P));
//    end;
//  end;
end;

procedure TFormMain.ImageDblClick(Sender: TObject);
begin
  if FDisplayMode <> dmMatch then
    ShowMatchedImage(FCurrentFileName, False)
  else
    ShowActualImage(FCurrentFileName, False);
end;

procedure TFormMain.lvImagesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  Item: TListItem;
  Idx: Integer;
  F: TFileItem;
  R: TRect;
begin
  if Button = mbLeft then
  begin
    P := Mouse.CursorPos;
    P := (Sender as TListView).ScreenToClient(P);
    Item := (Sender as TListView).GetItemAt(P.X, P.Y);
    if Item = nil then
      Item := (Sender as TListView).GetItemAt(P.X + 20, P.Y);
    if Item = nil then
      Exit;

    Idx := Item.Index;
    if (Idx < 0) or (Idx >= FFiles.Count) then
      Exit;

    F := TFileItem(FFiles.Items[Idx]);
    R := Item.DisplayRect(drBounds);
    if (X - R.Left < 20) and (Y - R.Top < 20) then
    begin
      F.Checked := not F.Checked;
      (Sender as TListView).Invalidate;
      PostMessage(Handle, WM_UPDATE_SELECTION, 0, 0);
    end;
  end;
end;

procedure TFormMain.actShowMatchExecute(Sender: TObject);
begin
  // 适合窗口尺寸。双边都小于窗口尺寸则以实际大小显示并居中
  // 有一大于窗口尺寸则缩放并居中。
  ShowMatchedImage(FCurrentFileName, False);
end;

procedure TFormMain.actShowActualExecute(Sender: TObject);
begin
  // 实际大小。双边都小于窗口尺寸则以实际大小显示并居中
  // 有一大于窗口尺寸则实际显示并居中。
  ShowActualImage(FCurrentFileName, False);
end;

procedure TFormMain.lvImagesKeyPress(Sender: TObject; var Key: Char);
var
  Item: TListItem;
  Idx: Integer;
  F: TFileItem;
begin
  if Key = ' ' then
  begin
    if (Sender as TListView).Selected <> nil then
    begin
      Item := (Sender as TListView).Selected;
      Idx := Item.Index;
      if (Idx < 0) or (Idx >= FFiles.Count) then
        Exit;

      F := TFileItem(FFiles.Items[Idx]);
      F.Checked := not F.Checked;
      (Sender as TListView).Invalidate;
      PostMessage(Handle, WM_UPDATE_SELECTION, 0, 0);
    end;
  end;
end;

procedure TFormMain.UpdateSelectionSummary;
begin
  if lstSelection.Items.Count = 0 then
    statBar.Panels[0].Text := ''
  else
    statBar.Panels[0].Text := Format('已选择 %d 张照片。', [lstSelection.Items.Count]);
end;

procedure TFormMain.UpdateShowingImageInfo;
begin
  if FCurrentFileName <> '' then
    statBar.Panels[1].Text := Format('当前照片：%s', [FCurrentFileName])
  else
    statBar.Panels[1].Text := '';
end;

function TFormMain.QueryDlg(const Msg, Cap: string): Boolean;
begin
  Result := False;
  if Application.MessageBox(PChar(Msg), PChar(Cap), MB_OKCANCEL +
    MB_ICONQUESTION) = IDOK then
  begin
    Result := True;
  end;
end;

procedure TFormMain.actSelectAllExecute(Sender: TObject);
var
  I: Integer;
  F: TFileItem;
begin
  if QueryDlg('要全部选择当前文件夹下的所有照片？') then
  begin
    for I := 0 to FFiles.Count - 1 do
    begin
      F := TFileItem(FFiles[I]);
      F.Checked := True;

      lvImages.Invalidate;
      PostMessage(Handle, WM_UPDATE_SELECTION, 0, 0);
    end;
  end;
end;

procedure TFormMain.actSelectNoneExecute(Sender: TObject);
var
  I: Integer;
  F: TFileItem;
begin
  if QueryDlg('要忘掉所有选择？') then
  begin
    for I := 0 to FFiles.Count - 1 do
    begin
      F := TFileItem(FFiles[I]);
      F.Checked := False;

      lvImages.Invalidate;
      PostMessage(Handle, WM_UPDATE_SELECTION, 0, 0);
    end;
  end;
end;

procedure TFormMain.actCopySelectionExecute(Sender: TObject);
var
  DirName, FullDir, Dst: string;
  I, C: Integer;
  F: TFileItem;
begin
  if lstSelection.Count = 0 then
  begin
    ErrDlg('没有选择的照片。');
    Exit;
  end;

  if CnInputBox(INFO_QUERY_CAPTION, '将建立子目录于当前目录：' + tvMain.Path, '选片', DirName) then
  begin
    if DirName <> '' then
    begin
      Screen.Cursor := crHourGlass;
      try
        FullDir := IncludeTrailingPathDelimiter(tvMain.Path) + DirName;
        if DirectoryExists(FullDir) then
        begin
          if not QueryDlg(Format('目录 %s 已存在，是否确定要将选片结果覆盖存储至此目录下？', [DirName])) then
            Exit;
        end;
        ForceDirectories(FullDir);

        C := 0;
        for I := 0 to FFiles.Count - 1 do
        begin
          F := TFileItem(FFiles.Items[I]);
          if F.Checked then
          begin
            Dst := IncludeTrailingPathDelimiter(FullDir) + ExtractFileName(F.FileName);
            if CopyFile(PChar(F.FileName), PChar(Dst), False) then
              Inc(C);
          end;
        end;
      finally
        Screen.Cursor := crDefault;
      end;
      FCurSelectionChanged := False;
      if YesNoDlg(Format('已成功选片 %d 张。是否要打开子目录 %s 来查看选片结果？', [C, DirName])) then
         ExploreDir(FullDir, False);
    end;
  end;
end;

procedure TFormMain.InfoDlg(const Msg, Cap: string);
begin
  Application.MessageBox(PChar(Msg), PChar(Cap), MB_OK + MB_ICONINFORMATION);
end;

procedure TFormMain.ErrDlg(const Msg, Cap: string);
begin
  Application.MessageBox(PChar(Msg), PChar(Cap), MB_OK + MB_ICONERROR);
end;

procedure TFormMain.tvMainChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if FCurSelectionChanged and (lstSelection.Count > 0) then
    AllowChange := QueryDlg('当前目录下的选片结果未保存，是否放弃？');
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FCurSelectionChanged and (lstSelection.Count > 0) then
    CanClose := QueryDlg('当前目录下的选片结果未保存，是否放弃？')
  else
    CanClose := True;
end;

procedure TFormMain.actRemoveSelectionExecute(Sender: TObject);
var
  I, J: Integer;
  S: string;
  F: TFileItem;
begin
  for I := 0 to lstSelection.Items.Count - 1 do
  begin
    if lstSelection.Selected[I] then
    begin
      S := Trim(lstSelection.Items[I]);

      for J := 0 to FFiles.Count - 1 do
      begin
        F := TFileItem(FFiles.Items[J]);
        if F.Checked and (F.Caption = S) then
        begin
          F.Checked := False;
          lvImages.Invalidate;
          PostMessage(Handle, WM_UPDATE_SELECTION, 0, 0);
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TFormMain.lstSelectionKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    actRemoveSelection.Execute;
  end;
end;

procedure TFormMain.pnlContentBtmResize(Sender: TObject);
begin
  tlbImage.Left := (pnlContentBtm.Width - tlbImage.Width) div 2;
end;

procedure TFormMain.actPrevImageExecute(Sender: TObject);
var
  Idx: Integer;
begin
  if lvImages.Selected <> nil then
    Idx := lvImages.Selected.Index
  else
    Idx := FCurrentIndex;

  if Idx > 0 then
  begin
    Dec(Idx);
    lvImages.Selected := lvImages.Items[Idx];
    lvImages.Selected.MakeVisible(False);
  end;
end;

procedure TFormMain.actNextImageExecute(Sender: TObject);
var
  Idx: Integer;
begin
  if lvImages.Selected <> nil then
    Idx := lvImages.Selected.Index
  else
    Idx := FCurrentIndex;

  if Idx < lvImages.Items.Count - 1 then
  begin
    Inc(Idx);
    lvImages.Selected := lvImages.Items[Idx];
    lvImages.Selected.MakeVisible(False);
  end;
end;

procedure TFormMain.actSlideExecute(Sender: TObject);
var
  Idx: Integer;
begin
  if (FFiles = nil) or (FFiles.Count = 0) then
    Exit;

  Idx := 0;
  if lvImages.Selected <> nil then
    Idx := lvImages.Selected.Index;

  with TFormSlide.Create(nil) do
  begin
    Files := FFiles;
    CurIdx := Idx;
    ShowModal;
    Idx := CurIdx;
    Free;

    if (Idx >= 0) and (Idx < lvImages.Items.Count) then
    begin
      lvImages.Selected := lvImages.Items[Idx];
      lvImages.Selected.MakeVisible(False);
    end;
  end;
end;

procedure TFormMain.pnlToolbarResize(Sender: TObject);
begin
  tlbSelection.Left := (pnlToolbar.Width - tlbSelection.Width) div 2;
end;

function TFormMain.YesNoDlg(const Msg, Cap: string): Boolean;
begin
  Result := False;
  if Application.MessageBox(PChar(Msg), PChar(Cap), MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
  begin
    Result := True;
  end;
end;

procedure TFormMain.lstSelectionDblClick(Sender: TObject);
var
  J: Integer;
  F: TFileItem;
  S: string;
begin
  if lstSelection.ItemIndex >= 0 then
  begin
    S := Trim(lstSelection.Items[lstSelection.ItemIndex]);
    for J := 0 to FFiles.Count - 1 do
    begin
      F := TFileItem(FFiles.Items[J]);
      if F.Checked and (F.Caption = S) then
      begin
        with TFormDisplay.Create(nil) do
        begin
          FileName := F.FileName;
          ShowModal;
          Free;
        end;
      end;
    end;
  end;
end;

procedure TFormMain.actlstMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  if Action = actSelectAll then
  begin
    (Action as TAction).Enabled := FFiles.Count > 0;
    Handled := True;
  end
  else if Action = actSelectNone then
  begin
    (Action as TAction).Enabled := lstSelection.Items.Count > 0;
    Handled := True;
  end
  else if Action = actRemoveSelection then
  begin
    (Action as TAction).Enabled := lstSelection.ItemIndex >= 0;
    Handled := True;
  end
  else if Action = actCopySelection then
  begin
    (Action as TAction).Enabled := FCurSelectionChanged and (lstSelection.Items.Count > 0);
    Handled := True;
  end
  else if Action = actPrevImage then
  begin
    (Action as TAction).Enabled := FCurrentIndex > 0;
    Handled := True;
  end
  else if Action = actNextImage then
  begin
    (Action as TAction).Enabled := FCurrentIndex < FFiles.Count - 1;
    Handled := True;
  end
  else if Action = actShowMatch then
  begin
    (Action as TAction).Enabled := (FDisplayMode <> dmMatch) and (FCurrentFileName <> '');
    Handled := True;
  end
  else if Action = actShowActual then
  begin
    (Action as TAction).Enabled := (FDisplayMode <> dmActual) and (FCurrentFileName <> '');
    Handled := True;
  end
  else if Action = actSlide then
  begin
    (Action as TAction).Enabled := FFiles.Count > 0;
    Handled := True;
  end
  else if Action = actDeleteFile then
  begin
    (Action as TAction).Enabled := FCurrentFileName <> '';
    Handled := True;
  end
  else if Action = actShowInfo then
  begin
    (Action as TAction).Enabled := FCurrentFileName <> '';
    Handled := True;
  end
  else if Action = actContextMenu then
  begin
    (Action as TAction).Enabled := FCurrentFileName <> '';
    Handled := True;
  end
end;

procedure TFormMain.actSettingExecute(Sender: TObject);
begin
  // Do settings
  with TFormSetting.Create(nil) do
  begin
    edtRoot.Text := IniOptions.ConfigRootDir;
    seInterval.Value := IniOptions.ConfigSlideDelay;
    if ShowModal = mrOK then
    begin
      IniOptions.ConfigSlideDelay := seInterval.Value;
      IniOptions.ConfigRootDir := edtRoot.Text;
      IniOptions.SaveToFile(INI_FILE);
    end;
    Free;
  end;
end;

procedure TFormMain.pnlDisplayResize(Sender: TObject);
begin
  FCurImgWidth := pnlDisplay.Width;
  FCurImgHeight := pnlDisplay.Height;
  PostMessage(Handle, WM_UPDATE_IMAGE, 0, 0);
end;

procedure TFormMain.ClearImage;
var
  G: TGPGraphics;
begin
  G := TGPGraphics.Create(FImgContent.Canvas.Handle);
  G.Clear(MakeColor($FF, $FF, $FF));
  G.Free;
  FImgContent.Invalidate;
end;

procedure TFormMain.actDeleteFileExecute(Sender: TObject);
var
  I: Integer;
  F: TFileItem;
  Deleted, Res: Boolean;
begin
  if FCurrentFileName <> '' then
  begin
    if QueryDlg('确实要删除文件：' + FCurrentFileName + '？删除后不可恢复。') then
    begin
      if FCurrentGPImage <> nil then
        FreeAndNil(FCurrentGPImage);

      Res := DeleteFile(FCurrentFileName);
      if not Res then
      begin
        ErrDlg('文件删除失败！错误码：' + IntToStr(GetLastError));
        Exit;
      end;

      Deleted := False;
      for I := 0 to FFiles.Count - 1 do
      begin
        F := TFileItem(FFiles.Items[I]);
        if F.FileName = FCurrentFileName then
        begin
          FFiles.Remove(F);
          Deleted := True;
          Break;
        end;
      end;

      if Deleted then
      begin
        PostMessage(Handle, WM_UPDATE_SELECTION, 0, 0);
        lvImages.Items.Count := FFiles.Count;
        lvImages.Invalidate;

        if FFiles.Count = 0 then
        begin
          ClearImage;
          FCurrentFileName := '';
          UpdateShowingImageInfo;
          Exit;
        end;

        if FCurrentIndex >= FFiles.Count then
          FCurrentIndex := FFiles.Count - 1;

        FCurrentFileName := TFileItem(FFiles.Items[FCurrentIndex]).FileName;
        ShowMatchedImage(FCurrentFileName);
      end;
    end;
  end;
end;

procedure TFormMain.actContextMenuExecute(Sender: TObject);
begin
  if FCurrentFileName <> '' then
  begin
    DisplayContextMenu(Handle, FCurrentFileName, Mouse.CursorPos);
  end;
end;

procedure TFormMain.actShowInfoExecute(Sender: TObject);
var
  S: string;
  ExitCode: DWORD;
begin
  Screen.Cursor := crHourGlass;
  if WinExecWithPipe(FExifTool + ' ' + FCurrentFileName, '', S, ExitCode) then
  begin
    with TFormInfo.Create(nil) do
    begin
      Caption := FCurrentFileName;
      lstInfo.Items.Clear;
      lstInfo.Items.Text := S;
      TranslateStrings;
      Screen.Cursor := crDefault;
      ShowModal;
      Free;
    end;
  end;
  Screen.Cursor := crDefault;
end;

end.
