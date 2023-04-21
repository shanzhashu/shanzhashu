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
  LogLeft('�������Ϲ��ˡ�' + ClientSocket.RemoteIP + ': ' + IntToStr(ClientSocket.RemotePort));
  if FRight.ClientCount < 1 then
    LogLeft('�����㡭��');

  // �ȴ� FRight ������
  while FLeft.Active do
  begin
    Sleep(0);
    if FRight.ClientCount = 1 then
      Break;
  end;

  if not FLeft.Active then
  begin
    LogLeft('�û�ȡ�������');
    Exit;
  end;

  LogLeft('�Ž���ɣ���ʼת��');
  while FLeft.Active do
  begin
    Ret := ClientSocket.Recv(Buf, SizeOf(Buf));
    if Ret <= 0 then
    begin
      LogLeft('��߽������ݳ���ͣ��');
      ClientSocket.Shutdown;
      FRight.Close;
      Exit;
    end
    else
      LogLeft('��߽��յ����ݣ�' + IntToStr(Ret));

    Ret := FRight.Clients[0].Send(Buf, Ret);
    if Ret <= 0 then
    begin
      LogLeft('���ݷ��͵��ұ߳���ͣ��');
      ClientSocket.Shutdown;
      FRight.Close;
      Exit;
    end
    else
      LogLeft('���ݷ��͵��ұߣ�' + IntToStr(Ret));
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
  // �ȴ� FLeft ������
  LogRight('�������Ϲ��ˡ�' + ClientSocket.RemoteIP + ': ' + IntToStr(ClientSocket.RemotePort));
  if FLeft.ClientCount < 1 then
    LogRight('�����㡭��');

  while FRight.Active do
  begin
    Sleep(0);
    if FLeft.ClientCount = 1 then
      Break;
  end;

  if not FRight.Active then
  begin
    LogLeft('�û�ȡ���ұ���');
    Exit;
  end;

  LogRight('�Ž���ɣ���ʼת��');
  while FRight.Active do
  begin
    Ret := ClientSocket.Recv(Buf, SizeOf(Buf));
    if Ret <= 0 then
    begin
      LogRight('�ұ߽������ݳ���ͣ��');
      ClientSocket.Shutdown;
      FLeft.Close;
      Exit;
    end
    else
      LogRight('�ұ߽��յ����ݣ�' + IntToStr(Ret));

    Ret := FLeft.Clients[0].Send(Buf, Ret);
    if Ret <= 0 then
    begin
      LogRight('���ݷ��͵���߳���ͣ��');
      ClientSocket.Shutdown;
      FLeft.Close;
      Exit;
    end
    else
      LogRight('���ݷ��͵���ߣ�' + IntToStr(Ret));
  end;
end;

procedure TFormDualMap.RightError(Sender: TObject; SocketError: Integer);
begin
  LogRight('*** Socket Error ***' + IntToStr(SocketError));
end;

end.
