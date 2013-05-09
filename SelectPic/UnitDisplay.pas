unit UnitDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GDIPAPI, GDIPOBJ, GDIPUTIL, LXImage;

const
  WM_START_SHOW = WM_USER + 251;

type
  TFormDisplay = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FFileName: string;
    FImage: TLXImage;
    FGPImage: TGPImage;
    FImgWidth, FImgHeight: Integer;
    procedure ShowMatchedImage(const FileName: string);
    procedure StartShow(var Msg: TMessage); message WM_START_SHOW;
    { Private declarations }
  public
    { Public declarations }
    property FileName: string read FFileName write FFileName;
  end;

var
  FormDisplay: TFormDisplay;

implementation

{$R *.dfm}

procedure TFormDisplay.FormCreate(Sender: TObject);
begin
  FImage := TLXImage.Create(Self);
  FImage.Parent := Self;
  FImage.Align := alClient;
  Width := Screen.Width * 2 div 3;
  Height := Screen.Height * 2 div 3;
end;

procedure TFormDisplay.ShowMatchedImage(const FileName: string);
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
      G := TGPGraphics.Create(FImage.Canvas.Handle);
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
    FImage.Invalidate;
  except
    ;
  end;
end;

procedure TFormDisplay.FormDestroy(Sender: TObject);
begin
  if FGPImage <> nil then
    FGPImage.Free;
end;

procedure TFormDisplay.FormShow(Sender: TObject);
begin
  PostMessage(Handle, WM_START_SHOW, 0, 0);
end;

procedure TFormDisplay.StartShow(var Msg: TMessage);
begin
  FImgWidth := FImage.Width;
  FImgHeight := FImage.Height;
  ShowMatchedImage(FileName);
end;

end.
