unit UnitCharCount;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFormCharCount = class(TForm)
    mmoInput: TMemo;
    mmoResult: TMemo;
    btnCount: TButton;
    lblInput: TLabel;
    lblResult: TLabel;
    pb1: TPaintBox;
    procedure btnCountClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pb1Paint(Sender: TObject);
  private
    { Private declarations }
    FOldMemoWndProc: TWndMethod;
    procedure NewMemoWndProc(var Msg: TMessage);
    procedure InvalidateLineNumbers;
  public
    { Public declarations }
  end;

var
  FormCharCount: TFormCharCount;

implementation

{$R *.DFM}

function IsIgnoredChar(C: Char): Boolean;
begin
  // 忽略空格、换行、回车
  if C in [#32, #10, #13, #9] then
  begin
    Result := True;
    Exit;
  end;

  // 半角标点符号
  if C in ['!', '"', '#', '$', '%', '&', '''', '(', ')', '*', '+', ',', '-',
            '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', '\', ']', '^',
            '_', '`', '{', '|', '}', '~'] then
  begin
    Result := True;
    Exit;
  end;

  // 全角标点符号及全角空格
  case C of
    #$3000, // 全角空格
    #$FF01, // ！
    #$FF02, // ＂
    #$FF03, // ＃
    #$FF04, // ＄
    #$FF05, // ％
    #$FF06, // ＆
    #$FF07, // ＇
    #$FF08, // （
    #$FF09, // ）
    #$FF0A, // ＊
    #$FF0B, // ＋
    #$FF0C, // ，
    #$FF0D, // －
    #$FF0E, // ．
    #$FF0F, // ／
    #$FF1A, // ：
    #$FF1B, // ；
    #$FF1C, // ＜
    #$FF1D, // ＝
    #$FF1E, // ＞
    #$FF1F, // ？
    #$FF20, // ＠
    #$FF3B, // ［
    #$FF3C, // ＼
    #$FF3D, // ］
    #$FF3E, // ＾
    #$FF3F, // ＿
    #$FF40, // ｀
    #$FF5B, // ｛
    #$FF5C, // ｜
    #$FF5D, // ｝
    #$FF5E, // ～
    #$3001, // 、
    #$3002, // 。
    #$FF64, // ､
    #$FE50, // ﹐
    #$FE51, // ﹑
    #$FE52, // ﹒
    #$FE54, // ﹔
    #$FE55, // ﹕
    #$FE56, // ﹖
    #$FE57, // ﹗
    #$FE58, // ﹘
    #$FE59, // ﹙
    #$FE5A, // ﹚
    #$FE5B, // ﹛
    #$FE5C, // ﹜
    #$FE5D, // ﹝
    #$FE5E, // ﹞
    #$2018, // '
    #$2019, // '
    #$201C, // "
    #$201D, // "
    #$2014, // —
    #$2013, // –
    #$2026, // …
    #$300A, // 《
    #$300B, // 》
    #$3008, // 〈
    #$3009, // 〉
    #$300C, // 「
    #$300D, // 」
    #$300E, // 『
    #$300F, // 』
    #$3010, // 【
    #$3011, // 】
    #$3014, // 〔
    #$3015, // 〕
    #$3016, // 〖
    #$3017, // 〗
    #$FE41, // ﹁
    #$FE42, // ﹂
    #$FE43, // ﹃
    #$FE44, // ﹄
    #$FE49, // ﹉
    #$FE4A, // ﹊
    #$FE4B, // ﹋
    #$FE4C, // ﹌
    #$FE4D, // ﹍
    #$FE4E, // ﹎
    #$FE4F: // ﹏
      Result := True;
  else
    Result := False;
  end;
end;

type
  TCharInfo = record
    CharCode: Word;
    Count: Integer;
    Lines: string;
  end;

  TCharInfoArray = array of TCharInfo;

procedure SortCharInfo(var Arr: TCharInfoArray);
var
  I, J: Integer;
  Temp: TCharInfo;
begin
  // 简单插入排序，按数量降序
  for I := 1 to Length(Arr) - 1 do
  begin
    Temp := Arr[I];
    J := I - 1;
    while (J >= 0) and (Arr[J].Count < Temp.Count) do
    begin
      Arr[J + 1] := Arr[J];
      Dec(J);
    end;
    Arr[J + 1] := Temp;
  end;
end;

procedure TFormCharCount.btnCountClick(Sender: TObject);
var
  S: string;
  I, CurLine: Integer;
  CharMap: array[0..65535] of Integer;
  CharLines: array[0..65535] of string;
  LineSet: string;
  C, PrevChar: Char;
  LineBuf: string;
  TotalChars: Integer;
  CharArr: TCharInfoArray;
  ArrLen: Integer;
begin
  S := mmoInput.Text;
  if S = '' then
  begin
    mmoResult.Clear;
    mmoResult.Lines.Add('输入内容为空，无字符可统计。');
    Exit;
  end;

  // 删除空行：逐行处理，只保留非空行
  mmoInput.Lines.BeginUpdate;
  try
    I := 0;
    while I < mmoInput.Lines.Count do
    begin
      if Trim(mmoInput.Lines[I]) = '' then
        mmoInput.Lines.Delete(I)
      else
        Inc(I);
    end;
  finally
    mmoInput.Lines.EndUpdate;
  end;

  // 删除空行后重新获取文本
  S := mmoInput.Text;
  if S = '' then
  begin
    mmoResult.Clear;
    mmoResult.Lines.Add('输入内容为空，无字符可统计。');
    Exit;
  end;

  // 初始化计数数组和行号记录
  FillChar(CharMap, SizeOf(CharMap), 0);
  for I := Low(CharLines) to High(CharLines) do
    CharLines[I] := '';
  TotalChars := 0;

  // 遍历每个字符并计数，同时记录所在行号
  // 同一行内连续相同字符只计一次
  CurLine := 1;
  PrevChar := #0;
  for I := 1 to Length(S) do
  begin
    C := S[I];
    if C = #10 then
    begin
      Inc(CurLine);
      PrevChar := #0; // 换行后重置前一个有效字符
    end
    else if C <> #13 then
    begin
      if not IsIgnoredChar(C) then
      begin
        // 有效字符总数不受连续去重规则影响
        Inc(TotalChars);
        // 同一行内连续相同字符不算重复
        if C <> PrevChar then
        begin
          Inc(CharMap[Ord(C)]);
          // 记录行号（避免重复行号）
          LineSet := CharLines[Ord(C)];
          if LineSet <> '' then
          begin
            // 检查是否已包含该行号
            if Pos(';' + IntToStr(CurLine) + ';', ';' + LineSet + ';') = 0 then
              LineSet := LineSet + ', ' + IntToStr(CurLine);
          end
          else
            LineSet := IntToStr(CurLine);
          CharLines[Ord(C)] := LineSet;
        end;
        PrevChar := C;
      end;
    end;
  end;

  // 收集有效字符到动态数组
  ArrLen := 0;
  for I := Low(CharMap) to High(CharMap) do
  begin
    if CharMap[I] > 0 then
      Inc(ArrLen);
  end;
  SetLength(CharArr, ArrLen);
  ArrLen := 0;
  for I := Low(CharMap) to High(CharMap) do
  begin
    if CharMap[I] > 0 then
    begin
      CharArr[ArrLen].CharCode := I;
      CharArr[ArrLen].Count := CharMap[I];
      CharArr[ArrLen].Lines := CharLines[I];
      Inc(ArrLen);
    end;
  end;

  // 按数量降序排序
  SortCharInfo(CharArr);

  // 输出结果
  mmoResult.Clear;
  mmoResult.Lines.Add(Format('有效字总数: %d', [TotalChars]));
  mmoResult.Lines.Add('────────────────────────────');
  mmoResult.Lines.Add(Format('%-4s %-4s %s', ['字', '数量', '所在行']));
  mmoResult.Lines.Add('────────────────────────────');

  for I := 0 to Length(CharArr) - 1 do
  begin
    C := Char(CharArr[I].CharCode);
    // 对控制字符和不可见字符做特殊显示
    case C of
      #0..#31:
        LineBuf := Format('#$%02X    %-6d', [CharArr[I].CharCode, CharArr[I].Count]);
    else
      LineBuf := Format('%-6s %-6d', [C, CharArr[I].Count]);
    end;
    // 数量大于 1 时打印所在行
    if CharArr[I].Count > 1 then
      LineBuf := LineBuf + CharArr[I].Lines;
    mmoResult.Lines.Add(LineBuf);
  end;
end;

procedure TFormCharCount.FormCreate(Sender: TObject);
begin
  // 子类化 Memo 的窗口过程，以捕获滚动和重绘消息
  FOldMemoWndProc := mmoInput.WindowProc;
  mmoInput.WindowProc := NewMemoWndProc;
end;

procedure TFormCharCount.NewMemoWndProc(var Msg: TMessage);
begin
  FOldMemoWndProc(Msg);
  // 滚动、内容变化、重绘时刷新行号
  case Msg.Msg of
    WM_VSCROLL, WM_HSCROLL,
    WM_MOUSEWHEEL, WM_KEYDOWN,
    WM_SETTEXT, EM_REPLACESEL,
    WM_CUT, WM_PASTE, WM_UNDO,
    WM_CHAR, WM_CLEAR,
    EM_SETSEL, WM_LBUTTONUP, WM_RBUTTONUP:
      InvalidateLineNumbers;
  end;
end;

procedure TFormCharCount.InvalidateLineNumbers;
begin
  pb1.Invalidate;
end;

procedure TFormCharCount.pb1Paint(Sender: TObject);
var
  LineHeight: Integer;
  FirstLine, LastLine, I: Integer;
  YPos: Integer;
  R: TRect;
  LineNumStr: string;
  TopDelta: Integer;
begin
  if mmoInput.Lines.Count = 0 then
    Exit;

  // 获取 Memo 的编辑区域（考虑边框和边距）
  SendMessage(mmoInput.Handle, EM_GETRECT, 0, LPARAM(@R));

  // 计算行高：用编辑区高度除以可见行数
  // 先获取首行可见行号
  FirstLine := SendMessage(mmoInput.Handle, EM_GETFIRSTVISIBLELINE, 0, 0);

  // 用字体高度估算行高
  LineHeight := Abs(mmoInput.Font.Height);
  if LineHeight < 1 then
    LineHeight := 14;

  // 计算 Memo 编辑区顶部与 PaintBox 顶部的对齐偏移
  // Memo 有边框，PaintBox 需要对齐到 Memo 的文字区域
  TopDelta := R.Top - mmoInput.ClientRect.Top;

  // 清空背景
  pb1.Canvas.Brush.Color := clBtnFace;
  pb1.Canvas.FillRect(pb1.ClientRect);

  // 设置字体
  pb1.Canvas.Font.Assign(mmoInput.Font);
  pb1.Canvas.Font.Color := clBlack;
  pb1.Canvas.Brush.Style := bsClear;

  // 计算可见的最后一行
  LastLine := FirstLine + (R.Bottom - R.Top) div LineHeight;
  if LastLine >= mmoInput.Lines.Count then
    LastLine := mmoInput.Lines.Count - 1;

  // 绘制行号
  for I := FirstLine to LastLine do
  begin
    YPos := TopDelta + (I - FirstLine) * LineHeight;
    LineNumStr := IntToStr(I + 1);
    pb1.Canvas.TextOut(pb1.Width - pb1.Canvas.TextWidth(LineNumStr) - 2,
      YPos, LineNumStr);
  end;
end;

end.

