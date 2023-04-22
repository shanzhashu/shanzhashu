unit UnitDualMapper;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, CnThreadingTCPServer,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type
  TFormDualMap = class(TForm)
    lblLeftPort: TLabel;
    lblRightPort: TLabel;
    edtLeftPort: TEdit;
    edtRightPort: TEdit;
    btnMapping: TButton;
    mmoLeft: TMemo;
    mmoRight: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnMappingClick(Sender: TObject);
  private
    FLeft, FRight: TCnThreadingTCPServer;
    FRunning, FShutting: Boolean;
  protected
    procedure LeftAccept(Sender: TObject; ClientSocket: TCnClientSocket);
    procedure RightAccept(Sender: TObject; ClientSocket: TCnClientSocket);
  public
    procedure LogLeft(const Msg: string);
    procedure LogRight(const Msg: string);
  end;

var
  FormDualMap: TFormDualMap;

implementation

{$R *.fmx}

const
  BUF_SIZE = 1024 * 64;

procedure TFormDualMap.btnMappingClick(Sender: TObject);
begin
  if FRunning then
  begin
    FShutting := True;
    try
      FLeft.Active := False;
      FRight.Active := False;
    finally
      FShutting := False;
    end;
    FRunning := False;

    btnMapping.Text := 'Start';
  end
  else
  begin
    FLeft.LocalPort := StrToInt(edtLeftPort.Text);
    FRight.LocalPort := StrToInt(edtRightPort.Text);

    FLeft.Active := True;
    FRight.Active := True;
    FRunning := True;

    btnMapping.Text := 'Stop';
    mmoLeft.Lines.Clear;
    mmoRight.Lines.Clear;
  end;

  edtLeftPort.Enabled := not FRunning;
  edtRightPort.Enabled := not FRunning;
end;

procedure TFormDualMap.FormCreate(Sender: TObject);
begin
  FLeft := TCnThreadingTCPServer.Create(Self);
  FRight := TCnThreadingTCPServer.Create(Self);
  FLeft.MaxConnections := 1;
  FRight.MaxConnections := 1;

  FLeft.OnAccept := LeftAccept;
  FRight.OnAccept := RightAccept;
end;

procedure TFormDualMap.LeftAccept(Sender: TObject;
  ClientSocket: TCnClientSocket);
var
  Buf: array[0..BUF_SIZE - 1] of Byte;
  Ret1, Ret2: Integer;
begin
  LogLeft('有左鱼上钩了。' + ClientSocket.RemoteIP + ': ' + IntToStr(ClientSocket.RemotePort));
  if FRight.ClientCount < 1 then
    LogLeft('等右鱼……');

  // 等待 FRight 有连接
  while FLeft.Active and not FLeft.Closing do
  begin
    Sleep(0);
    if FRight.ClientCount = 1 then
      Break;
  end;

  if not FLeft.Active or FLeft.Closing then
  begin
    LogLeft('用户取消左边了');
    Exit;
  end;

  while FLeft.Active and not FLeft.Closing do
  begin
    Ret1 := ClientSocket.Recv(Buf, SizeOf(Buf));
    if Ret1 <= 0 then
    begin
      LogLeft('左边接收数据出错，停工');
      ClientSocket.Shutdown;
      if not FShutting and not FRight.Closing then
        FRight.Close;
      Exit;
    end;

    Ret2 := FRight.Clients[0].Send(Buf, Ret1);
    if Ret2 <= 0 then
    begin
      LogLeft('数据发送到右边出错，停工');
      ClientSocket.Shutdown;
      if not FShutting and not FRight.Closing then
        FRight.Close;
      Exit;
    end;

    LogLeft(Format('左边收到 %d 数据发送到右边 %d', [Ret1, Ret2]));
  end;
end;

procedure TFormDualMap.LogLeft(const Msg: string);
begin
  TThread.Synchronize(nil, procedure
    begin
      mmoLeft.Lines.Add(Msg);
    end);
end;

procedure TFormDualMap.LogRight(const Msg: string);
begin
  TThread.Synchronize(nil, procedure
    begin
      mmoRight.Lines.Add(Msg);
    end);
end;

procedure TFormDualMap.RightAccept(Sender: TObject;
  ClientSocket: TCnClientSocket);
var
  Buf: array[0..BUF_SIZE - 1] of Byte;
  Ret1, Ret2: Integer;
begin
  // 等待 FLeft 有连接
  LogRight('有右鱼上钩了。' + ClientSocket.RemoteIP + ': ' + IntToStr(ClientSocket.RemotePort));
  if FLeft.ClientCount < 1 then
    LogRight('等左鱼……');

  while FRight.Active and not FRight.Closing do
  begin
    Sleep(0);
    if FLeft.ClientCount = 1 then
      Break;
  end;

  if not FRight.Active or FRight.Closing then
  begin
    LogLeft('用户取消右边了');
    Exit;
  end;

  while FRight.Active and not FRight.Closing do
  begin
    Ret1 := ClientSocket.Recv(Buf, SizeOf(Buf));
    if Ret1 <= 0 then
    begin
      LogRight('右边接收数据出错，停工');
      ClientSocket.Shutdown;
      if not FShutting and not FLeft.Closing then
        FLeft.Close;
      Exit;
    end;

    Ret2 := FLeft.Clients[0].Send(Buf, Ret1);
    if Ret2 <= 0 then
    begin
      LogRight('数据发送到左边出错，停工');
      ClientSocket.Shutdown;
      if not FShutting and not FLeft.Closing then
        FLeft.Close;
      Exit;
    end;

    LogRight(Format('右边收到 %d 数据发送到左边 %d', [Ret1, Ret2]));
  end;
end;

end.
