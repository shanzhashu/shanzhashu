unit UnitSplit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.ScrollBox, FMX.Memo,
  FMX.TabControl;

type
  TFormSplit = class(TForm)
    tbc1: TTabControl;
    tbtmSplit: TTabItem;
    lblSplit: TLabel;
    edtFile: TEdit;
    btnBrowse: TButton;
    edtBlockSize: TEdit;
    cbbUnit: TComboBox;
    lblBy: TLabel;
    lblTo: TLabel;
    lblSize: TLabel;
    lblPick: TLabel;
    edtStart: TEdit;
    lblPickEnd: TLabel;
    edtEnd: TEdit;
    btnSave: TButton;
    dlgOpen: TOpenDialog;
    tbtmMerge: TTabItem;
    tbtmCompare: TTabItem;
    lblFile1: TLabel;
    edtCompareFile1: TEdit;
    btnBrowse1: TButton;
    lblOffset1: TLabel;
    edtOffset1: TEdit;
    edtOffset2: TEdit;
    lblOffset2: TLabel;
    btnBrowse2: TButton;
    edtCompareFile2: TEdit;
    lblCompareFile2: TLabel;
    lblCompareSize: TLabel;
    edtCompareSize: TEdit;
    cbbCompareUnit: TComboBox;
    btnCompare: TButton;
    mmoResult: TMemo;
    lblMergeDir: TLabel;
    edtMergeDir: TEdit;
    btnMergeBrowse: TButton;
    lblMergeFrom: TLabel;
    edtMergeFrom: TEdit;
    lblMergeTo: TLabel;
    edtMergeTo: TEdit;
    btnMerge: TButton;
    dlgSave: TSaveDialog;
    procedure btnBrowseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbUnitChange(Sender: TObject);
    procedure edtBlockSizeChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnBrowse1Click(Sender: TObject);
    procedure btnBrowse2Click(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnMergeClick(Sender: TObject);
    procedure btnMergeBrowseClick(Sender: TObject);
  private
    FBlockSize: Int64; // 块大小，字节
    FBlockCount: Integer; // 块数，1 开始
    FOutputDir: string;   // 外写目录，
    procedure UpdateBlockSize;
    procedure UpdateFileSize;
    procedure LogMsg(const M: string);
    procedure SaveOneBlock(F: TFileStream; BlockIndex: Integer);
  public
    { Public declarations }
  end;

var
  FormSplit: TFormSplit;

implementation

{$R *.fmx}

var
  Buf: array[1..1024*1024] of Byte;

procedure TFormSplit.btnBrowse1Click(Sender: TObject);
begin
  if dlgOpen.Execute then
    edtCompareFile1.Text := dlgOpen.FileName;
end;

procedure TFormSplit.btnBrowse2Click(Sender: TObject);
begin
  if dlgOpen.Execute then
    edtCompareFile2.Text := dlgOpen.FileName;
end;

procedure TFormSplit.btnBrowseClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    edtFile.Text := dlgOpen.FileName;
    UpdateFileSize;
    edtStart.Text := '1';
    edtEnd.Text := IntToStr(FBlockCount);
  end;
end;

procedure TFormSplit.btnCompareClick(Sender: TObject);
var
  F1, F2: TFileStream;
  Off1, Off2: Int64;
  Cnt, CompareSize, C1, C2: Integer;
  B1, B2: Byte;
  Equ: Boolean;
begin
  Off1 := StrToIntDef(edtOffset1.Text, 0);
  Off2 := StrToIntDef(edtOffset2.Text, 0);
  CompareSize := StrToIntDef(edtCompareSize.Text, 0);
  case cbbCompareUnit.ItemIndex of
    0:
      begin
        CompareSize := CompareSize * 1024;
      end;
    1:
      begin
        CompareSize := CompareSize * 1024 * 1024;
      end;
    2:
      begin
        CompareSize := CompareSize * 1024 * 1024 * 1024
      end;
  end;

  F1 := TFileStream.Create(edtCompareFile1.Text, fmOpenRead);
  F2 := TFileStream.Create(edtCompareFile2.Text, fmOpenRead);
  try
    F1.Position := Off1;
    F2.Position := Off2;

    Cnt := 0;
    Equ := True;
    while Equ and (Cnt < CompareSize) do
    begin
      C1 := F1.Read(B1, 1);
      C2 := F2.Read(B2, 1);

      if (C1 <> 1) or (C2 <> 1) then
        Break;
      Equ := B1 = B2;
      Inc(Cnt);
    end;

    if Equ then
      LogMsg('Equal ! ' + IntToStr(Cnt) + ' Bytes compared.')
    else
      LogMsg('NOT Equal ! at ' + IntToStr(Cnt));
  finally
    F2.Free;
    F1.Free;
  end;
end;

procedure TFormSplit.btnMergeBrowseClick(Sender: TObject);
var
  S: string;
begin
  if SelectDirectory('', '/', S) then
    edtMergeDir.Text := S;
end;

procedure TFormSplit.btnMergeClick(Sender: TObject);
var
  I, A, B, BufSize, C, Sum: Integer;
  S: string;
  D, F: TFileStream;
begin
  A := StrToIntDef(edtMergeFrom.Text, 1);
  B := StrToIntDef(edtMergeTo.Text, 10);
  if A > B then
    raise Exception.Create('Error Range.');

  for I := A to B do
  begin
    S := IncludeTrailingPathDelimiter(edtMergeDir.Text) + Format('%4.4d', [I]);
    if not FileExists(S) then
    begin
      LogMsg('File ' + S + ' NOT Exists.');
      Exit;
    end;
  end;

  if dlgSave.Execute then
    S := dlgSave.FileName;
  if FileExists(S) then
    DeleteFile(S);

  Sum := 0;
  BufSize := 1024 * 1024;
  D := TFileStream.Create(S, fmOpenWrite or fmCreate);
  for I := A to B do
  begin
    F := TFileStream.Create(IncludeTrailingPathDelimiter(edtMergeDir.Text)
      + Format('%4.4d', [I]), fmOpenRead);
    repeat
      C := F.Read(Buf, BufSize);
      D.Write(Buf, C);
      Inc(Sum, C);
    until C = 0;
    F.Free;
  end;
  D.Free;
  LogMsg('Merged ' + IntToStr(Sum) + ' Bytes.');
end;

procedure TFormSplit.btnSaveClick(Sender: TObject);
var
  I, A, B: Integer;
  F: TFileStream;
begin
  if not SelectDirectory('', '/', FOutputDir) then
    Exit;

  LogMsg(FOutputDir);
  UpdateFileSize;
  UpdateBlockSize;

  A := StrToInt(edtStart.Text);
  B := StrToInt(edtEnd.Text);
  if A > B then
    raise Exception.Create('Index Error');
  if B > FBlockCount then
    raise Exception.Create('Index Out of Range');

  F := TFileStream.Create(edtFile.Text, fmOpenRead);
  try
    for I := A to B do
    begin
      SaveOneBlock(F, I);
    end;
  finally
    F.Free;
  end;
end;

procedure TFormSplit.cbbUnitChange(Sender: TObject);
begin
  UpdateBlockSize;
end;

procedure TFormSplit.edtBlockSizeChange(Sender: TObject);
begin
  UpdateBlockSize;
end;

procedure TFormSplit.FormCreate(Sender: TObject);
begin
  tbc1.ActiveTab := tbtmSplit;
  UpdateBlockSize;
end;

procedure TFormSplit.LogMsg(const M: string);
begin
  mmoResult.Lines.Add(M);
end;

procedure TFormSplit.SaveOneBlock(F: TFileStream; BlockIndex: Integer);
var
  O: string;
  B: TFileStream;
  Sum, C, BufSize, ToReadSize: Integer;
begin
  // 将 F 文件流中的第 BlockIndex 块写入文件
  O := IncludeTrailingPathDelimiter(FOutputDir) + Format('%4.4d', [BlockIndex]);
  if FileExists(O) then
    DeleteFile(O);

  B := TFileStream.Create(O, fmOpenWrite or fmCreate);
  Sum := 0;
  C := 0;
  try
    F.Position := FBlockSize * (BlockIndex - 1);   // 从该位置读起，要读总共 FBlockSize 个或到文件尾
    LogMsg('Read from Offset: ' + IntToStr(F.Position));

    // 缓冲区大小 1 M，每次读最多 1 M，也就是 1 M 与 FBlockSize 中的较小者
    BufSize := 1024 * 1024;
    if BufSize > FBlockSize then  // 一次就读完，可能是文件尾，实际内容没有 FBlockSize 那么多
    begin
      BufSize := FBlockSize;
      C := F.Read(Buf, BufSize);
      // if C <> R then
      //   raise Exception.Create('Read Error');
      B.Write(Buf, C);
      Inc(Sum, C);
      B.Free;
    end
    else
    begin
      ToReadSize := FBlockSize;
      if F.Size - F.Position < ToReadSize then
        ToReadSize := F.Size - F.Position;

      while ToReadSize > 0 do
      begin
        C := F.Read(Buf, BufSize);   // BufSize 第一次进来是缓冲区大小，
        Dec(ToReadSize, C);
        B.Write(Buf, C);
        Inc(Sum, C);
      end;
    end;
  finally
    B.Free;
  end;
  LogMsg('Write ' + IntToStr(C) + ' Bytes to ' + O);
end;

procedure TFormSplit.UpdateBlockSize;
begin
  FBlockSize := StrToInt(edtBlockSize.Text);
  case cbbUnit.ItemIndex of
    0:
      begin
        FBlockSize := FBlockSize * 1024;
      end;
    1:
      begin
        FBlockSize := FBlockSize * 1024 * 1024;
      end;
    2:
      begin
        FBlockSize := FBlockSize * 1024 * 1024 * 1024
      end;
  end;
end;

procedure TFormSplit.UpdateFileSize;
var
  F: TFileStream;
  T: Int64;
begin
  F := TFileStream.Create(edtFile.Text, fmOpenRead);
  T := F.Size;
  lblSize.Text := IntToStr(T);
  FBlockCount := (T div FBlockSize) + 1;
  lblTo.Text := 'To 1 ~ ' + IntToStr(FBlockCount) + ' Blocks.';
  F.Free;
end;

end.
