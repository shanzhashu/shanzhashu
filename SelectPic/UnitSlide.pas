unit UnitSlide;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Contnrs, LXImage, ExtCtrls, GDIPAPI, GDIPOBJ, GDIPUTIL,
  StdCtrls, UnitMain;

const
  WM_START_SLIDE = WM_USER + 250;

type
  TFormSlide = class(TForm)
    tmrSlide: TTimer;
    lblChecked: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure tmrSlideTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FImgContent: TLXImage;
    FFiles: TObjectList;
    FCurIdx: Integer;
    FGPImage: TGPImage;
    FCurrentFileName: string;
    FImgWidth, FImgHeight: Integer;
    procedure ShowMatchedImage(const FileName: string);
    procedure StartSlide(var Msg: TMessage); message WM_START_SLIDE;
    procedure ImageDblClick(Sender: TObject);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure PrevImage;
    procedure NextImage;
    procedure UpdateChecked(F: TFileItem);
  public
    { Public declarations }
    property Files: TObjectList read FFiles write FFiles;
    property CurIdx: Integer read FCurIdx write FCurIdx;
  end;

var
  FormSlide: TFormSlide;

implementation

uses UnitOptions, CnShellUtils;

{$R *.dfm}

procedure TFormSlide.FormCreate(Sender: TObject);
begin
  FImgContent := TLXImage.Create(Self);
  FImgContent.Parent := Self;
  FImgContent.AutoSize := True;
  FImgContent.Align := alClient;
//  FImgContent.OnMouseDown := ImageMouseDown;
//  FImgContent.OnMouseMove := ImageMouseMove;
  FImgContent.OnMouseUp := ImageMouseUp;
  FImgContent.OnDblClick := ImageDblClick;
  lblChecked.BringToFront;
end;

procedure TFormSlide.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Close;
  end
  else if Key in [VK_LEFT, VK_UP, VK_PRIOR]  then
  begin
    tmrSlide.Enabled := False;
    PrevImage;
    tmrSlide.Enabled := True;
  end
  else if Key in [VK_RIGHT, VK_DOWN, VK_NEXT] then
  begin
    tmrSlide.Enabled := False;
    NextImage;
    tmrSlide.Enabled := True;
  end;
end;

procedure TFormSlide.ShowMatchedImage(const FileName: string);
var
  W, H: Integer;
  EW, EH, E: Extended;
  G: TGPGraphics;
begin
  if FileName = '' then
    Exit;
  if not FileExists(FileName) then
    Exit;

  try
    // Show this image as Matched.
    if FGPImage = nil then
      FreeAndNil(FGPImage);

    FGPImage := TGPImage.Create(FileName);
    W := FGPImage.GetWidth;
    H := FGPImage.GetHeight;

    if (FImgWidth > 0) and (FImgHeight > 0) then
    begin
      G := TGPGraphics.Create(FImgContent.Canvas.Handle);
      G.Clear(MakeColor($40, $40, $40));
      if (W <= FImgWidth) and (H <= FImgHeight) then
      begin
        // 直接原始大小居中显示
        G.DrawImage(FGPImage, (FImgWidth - W) div 2,
          (FImgHeight - H) div 2, W, H);
      end
      else
      begin
        // 缩放至合适大小
        EW := FImgWidth / W; // 横向缩比例
        EH := FImgHeight / H; // 纵向缩比例

        if EW >= EH then // 横的缩得多，按横的来
        begin
          E := EH;
          W := Round(W * E);
          H := Round(H * E);
        end
        else
        begin
          E := EW;
          W := Round(W * E);
          H := Round(H * E);
        end;

        // 再用缩放的显示
        G.DrawImage(FGPImage, (FImgWidth - W) div 2,
           (FImgHeight - H) div 2, W, H);
      end;
    end;
    FImgContent.Invalidate;
    FCurrentFileName := FileName;
  except
    ;
  end;
end;

procedure TFormSlide.FormShow(Sender: TObject);
begin
  if FFiles = nil then
    Exit;
  if FFiles.Count = 0 then
    Exit;

  PostMessage(Handle, WM_START_SLIDE, 0, 0);
end;

procedure TFormSlide.tmrSlideTimer(Sender: TObject);
begin
  NextImage;
end;

procedure TFormSlide.StartSlide(var Msg: TMessage);
var
  F: TFileItem;
begin
  FImgWidth := FImgContent.Width;
  FImgHeight := FImgContent.Height;

  if (CurIdx >= 0) and (CurIdx < FFiles.Count) then
  begin
    F := TFileItem(FFiles.Items[CurIdx]);
    ShowMatchedImage(F.FileName);
    UpdateChecked(F);

    tmrSlide.Interval := IniOptions.ConfigSlideDelay * 1000;
    tmrSlide.Enabled := True;
  end;
end;

procedure TFormSlide.FormDestroy(Sender: TObject);
begin
  if FGPImage <> nil then
    FGPImage.Free;
end;

procedure TFormSlide.ImageDblClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSlide.NextImage;
var
  F: TFileItem;
begin
  Inc(FCurIdx);
  if CurIdx = FFiles.Count then
    CurIdx := 0;

  F := TFileItem(FFiles.Items[CurIdx]);
  ShowMatchedImage(F.FileName);
  UpdateChecked(F);
end;

procedure TFormSlide.PrevImage;
var
  F: TFileItem;
begin
  Dec(FCurIdx);
  if CurIdx < 0 then
    CurIdx := FFiles.Count - 1;

  F := TFileItem(FFiles.Items[CurIdx]);
  ShowMatchedImage(F.FileName);
  UpdateChecked(F);
end;

procedure TFormSlide.UpdateChecked(F: TFileItem);
begin
  if F.Checked then
    lblChecked.Caption := '已选择'
  else
    lblChecked.Caption := '';
end;

procedure TFormSlide.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  if Button = mbRight then
  begin
    if FCurrentFileName <> '' then
    begin
      P.X := X;
      P.Y := Y;
      DisplayContextMenu(Handle, FCurrentFileName, FImgContent.ClientToScreen(P));
    end;
  end;
end;

end.
