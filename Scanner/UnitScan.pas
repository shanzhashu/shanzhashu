unit UnitScan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  WinSock, StdCtrls;

const
  WM_USER_UPDATE_MSG = WM_USER + 1;

type
  TScanThread = class(TThread)
  private
    FFromPort: Integer;
    FToPort: Integer;
    FHost: string;
    procedure SendResultToForm(const S: string);
  protected
    procedure Execute; override;
  public
    property Host: string read FHost write FHost;
    property FromPort: Integer read FFromPort write FFromPort;
    property ToPort: Integer read FToPort write FToPort;
  end;

  TFormScan = class(TForm)
    mmoResult: TMemo;
    lblHost: TLabel;
    edtHost: TEdit;
    lblPort: TLabel;
    edtFromPort: TEdit;
    lblTo: TLabel;
    edtPortTo: TEdit;
    btnScan: TButton;
    procedure btnScanClick(Sender: TObject);
  private
    FScanning: Boolean;
    FThread: TScanThread;
    FResultStr: string;
    procedure ThreadTerminated(Sender: TObject);
    procedure OnUpdateResultMessage(var Msg: TMessage); message WM_USER_UPDATE_MSG;
  public
    property ResultStr: string read FResultStr write FResultStr;
  end;

var
  FormScan: TFormScan;

implementation

{$R *.DFM}

procedure TFormScan.btnScanClick(Sender: TObject);
begin
  if not FScanning then
  begin
    mmoResult.Clear;

    if FThread <> nil then
      FreeAndNil(FThread);
    FThread := TScanThread.Create(True);
    FThread.FreeOnTerminate := False;
    FThread.OnTerminate := ThreadTerminated;

    FThread.Host := edtHost.Text;
    FThread.FromPort := StrToInt(edtFromPort.Text);
    FThread.ToPort := StrToInt(edtPortTo.Text);
    FThread.Resume;

    FScanning := True;
    btnScan.Caption := 'Stop';
  end
  else
  begin
    if FThread <> nil then
    begin
      FThread.Terminate;
      FThread.WaitFor;
      FreeAndNil(FThread);
    end;
    FScanning := False;
    btnScan.Caption := 'Scan';
  end;
end;

{ TScanThread }

procedure TScanThread.Execute;
var
  WsaData: TWSAData;
  Ret: Integer;
  ClientSocket: Integer;
  ClientHostEnt: PHostEnt;
  ClientAddr: TSockAddrIn;
  psaddr: ^LongInt;
  SAddr: LongInt;
  Port: Integer;
begin
  Ret := WSAStartup(MakeWord(2, 2), WsaData);
  if (0 <> Ret) then
  begin
    SendResultToForm('WSAStartup Error!');
    WSACleanup;
    Exit;
  end;

  for Port := FFromPort to FToPort do
  begin
    if Terminated then
    begin
      SendResultToForm('Cancel by User!');
      WSACleanup;
      Exit;
    end;
    ClientAddr.sin_family := PF_INET;
    ClientAddr.sin_port := htons(Port);
    ClientHostEnt := gethostbyname(PChar(FHost));
    if nil = ClientHostEnt then
    begin
      SAddr := inet_addr(PChar(FHost));
      if -1 <> SAddr then
        ClientAddr.sin_addr.S_addr := SAddr;
    end
    else
    begin
      psaddr := Pointer(ClientHostEnt.h_addr_list^);
      ClientAddr.sin_addr.S_addr := psaddr^;
    end;

    ClientSocket := socket(PF_INET, SOCK_STREAM, 0);
    if INVALID_SOCKET = ClientSocket then
    begin
      SendResultToForm('Create Socket Fail!');
      WSACleanup;
      Exit;
    end;

    Ret := connect(ClientSocket, ClientAddr, SizeOf(ClientAddr));
    if SOCKET_ERROR = Ret then
    begin
      Ret := WSAGetLastError;
      SendResultToForm(FHost + ': ' + IntToStr(Port) + ' Connect Fail! ' + IntToStr(Ret));
    end
    else
    begin
      SendResultToForm(FHost + ': ' + IntToStr(Port) + ' Connect OK.');
    end;
    closesocket(ClientSocket);
  end;
  WSACleanup;
end;

procedure TFormScan.OnUpdateResultMessage(var Msg: TMessage);
begin
  if FResultStr <> '' then
  begin
    mmoResult.Lines.Add(FResultStr);
    FResultStr := '';
  end;
end;

procedure TFormScan.ThreadTerminated(Sender: TObject);
begin
  FreeAndNil(FThread);
  FScanning := False;
end;

procedure TScanThread.SendResultToForm(const S: string);
begin
  FormScan.ResultStr := S;
  SendMessage(FormScan.Handle, WM_USER_UPDATE_MSG, 0, 0);
end;

end.

