unit UnitDualMapper;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, CnThreadingTCPServer,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.Memo.Types;

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
    FRunning: Boolean;
  protected
    procedure LeftAccept(Sender: TObject; ClientSocket: TCnClientSocket);
    procedure RightAccept(Sender: TObject; ClientSocket: TCnClientSocket);
    procedure LeftError(Sender: TObject; SocketError: Integer);
    procedure RightError(Sender: TObject; SocketError: Integer);
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
    FLeft.Active := False;
    FRight.Active := False;
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

  FLeft.OnError := LeftError;
  FRight.OnError := RightError;
end;

procedure TFormDualMap.LeftAccept(Sender: TObject;
  ClientSocket: TCnClientSocket);
var
  Buf: array[0..BUF_SIZE - 1] of Byte;
  Ret: Integer;
begin
  LogLeft('有左鱼上钩了。' + ClientSocket.RemoteIP + ': ' + IntToStr(ClientSocket.RemotePort));
  if FRight.ClientCount < 1 then
    LogLeft('等右鱼……');

  // 等待 FRight 有连接
  while FLeft.Active do
  begin
    Sleep(0);
    if FRight.ClientCount = 1 then
      Break;
  end;

  if not FLeft.Active then
  begin
    LogLeft('用户取消左边了');
    Exit;
  end;

  LogLeft('桥接完成，开始转发');
  while FLeft.Active do
  begin
    Ret := ClientSocket.Recv(Buf, SizeOf(Buf));
    if Ret <= 0 then
    begin
      LogLeft('左边接收数据出错，停工');
      ClientSocket.Shutdown;
      FRight.Close;
      Exit;
    end
    else
      LogLeft('左边接收到数据：' + IntToStr(Ret));

    Ret := FRight.Clients[0].Send(Buf, Ret);
    if Ret <= 0 then
    begin
      LogLeft('数据发送到右边出错，停工');
      ClientSocket.Shutdown;
      FRight.Close;
      Exit;
    end
    else
      LogLeft('数据发送到右边：' + IntToStr(Ret));
  end;
end;

procedure TFormDualMap.LeftError(Sender: TObject; SocketError: Integer);
begin
  LogLeft('*** Socket Error ***' + IntToStr(SocketError));
end;

procedure TFormDualMap.LogLeft(const Msg: string);
begin
  TThread.Synchronize(nil, procedure
    begin
      mmoLeft.Lines.Add(FormatDateTime('hh:MM:ss', Time) + ' ' + Msg);
    end);
end;

procedure TFormDualMap.LogRight(const Msg: string);
begin
  TThread.Synchronize(nil, procedure
    begin
      mmoRight.Lines.Add(FormatDateTime('hh:MM:ss', Time) + ' ' + Msg);
    end);
end;

procedure TFormDualMap.RightAccept(Sender: TObject;
  ClientSocket: TCnClientSocket);
var
  Buf: array[0..BUF_SIZE - 1] of Byte;
  Ret: Integer;
begin
  // 等待 FLeft 有连接
  LogRight('有右鱼上钩了。' + ClientSocket.RemoteIP + ': ' + IntToStr(ClientSocket.RemotePort));
  if FLeft.ClientCount < 1 then
    LogRight('等左鱼……');

  while FRight.Active do
  begin
    Sleep(0);
    if FLeft.ClientCount = 1 then
      Break;
  end;

  if not FRight.Active then
  begin
    LogLeft('用户取消右边了');
    Exit;
  end;

  LogRight('桥接完成，开始转发');
  while FRight.Active do
  begin
    Ret := ClientSocket.Recv(Buf, SizeOf(Buf));
    if Ret <= 0 then
    begin
      LogRight('右边接收数据出错，停工');
      ClientSocket.Shutdown;
      FLeft.Close;
      Exit;
    end
    else
      LogRight('右边接收到数据：' + IntToStr(Ret));

    Ret := FLeft.Clients[0].Send(Buf, Ret);
    if Ret <= 0 then
    begin
      LogRight('数据发送到左边出错，停工');
      ClientSocket.Shutdown;
      FLeft.Close;
      Exit;
    end
    else
      LogRight('数据发送到左边：' + IntToStr(Ret));
  end;
end;

procedure TFormDualMap.RightError(Sender: TObject; SocketError: Integer);
begin
  LogRight('*** Socket Error ***' + IntToStr(SocketError));
end;

end.
