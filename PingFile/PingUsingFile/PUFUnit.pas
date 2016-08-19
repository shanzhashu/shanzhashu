unit PUFUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSock;

const
  ICMPDLL = 'icmp.dll';

type
  TFormPuf = class(TForm)
    lblFile: TLabel;
    edtFile: TEdit;
    btnBrowse: TButton;
    lblInfo: TLabel;
    lblPackSize: TLabel;
    edtSize: TEdit;
    btnSend: TButton;
    dlgOpen: TOpenDialog;
    lblIP: TLabel;
    edtIP: TEdit;
    procedure btnBrowseClick(Sender: TObject);
    procedure edtFileChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  PIPOptionInformation = ^TIPOptionInformation;

  TIPOptionInformation = packed record
    TTL: Byte; // Time To Live (used for traceroute)
    TOS: Byte; // Type Of Service (usually 0)
    Flags: Byte; // IP header flags (usually 0)
    OptionsSize: Byte; // Size of options data (usually 0, max 40)
    OptionsData: PAnsiChar; // Options data buffer
  end;

  PIcmpEchoReply = ^TIcmpEchoReply;

  TIcmpEchoReply = packed record
    Address: DWORD; // replying address
    Status: DWORD; // IP status value (see below)
    RTT: DWORD; // Round Trip Time in milliseconds
    DataSize: Word; // reply data size
    Reserved: Word;
    Data: Pointer; // pointer to reply data buffer
    Options: TIPOptionInformation; // reply options
  end;

  TIpInfo = record
    Address: Int64;
    IP: string;
    Host: string;
  end;

  TIcmpCreateFile = function(): THandle; stdcall;

  TIcmpCloseHandle = function(IcmpHandle: THandle): Boolean; stdcall;

  TIcmpSendEcho = function(IcmpHandle: THandle; DestAddress: DWORD; RequestData:
    Pointer; RequestSize: Word; RequestOptions: PIPOptionInformation;
    ReplyBuffer: Pointer; ReplySize: DWord; TimeOut: DWord): DWord; stdcall;

var
  FormPuf: TFormPuf;

implementation

{$R *.dfm}

var
  IcmpCreateFile: TIcmpCreateFile = nil;
  IcmpCloseHandle: TIcmpCloseHandle = nil;
  IcmpSendEcho: TIcmpSendEcho = nil;
  IcmpDllHandle: THandle = 0;
  HICMP: THandle = 0;

function MyGetFileSize(const FileName: string): Integer;
var
  H: Integer;
begin
  Result := -1;
  if FileExists(FileName) then
  begin
    H := FileOpen(FileName, fmOpenRead);
    Result := GetFileSize(H, nil);
    FileClose(H);
  end;
end;

procedure InitIcmpFunctions;
begin
  IcmpDllHandle := LoadLibrary(ICMPDLL);
  if IcmpDllHandle <> 0 then
  begin
    @IcmpCreateFile := GetProcAddress(IcmpDllHandle, 'IcmpCreateFile');
    @IcmpCloseHandle := GetProcAddress(IcmpDllHandle, 'IcmpCloseHandle');
    @IcmpSendEcho := GetProcAddress(IcmpDllHandle, 'IcmpSendEcho');
  end;
end;

procedure FreeIcmpFunctions;
begin
  if IcmpDllHandle <> 0 then
    FreeLibrary(IcmpDllHandle);
end;

function SetIP(aIPAddr: string; var aIP: TIpInfo): Boolean;
var
  pIPAddr: PAnsiChar;
begin
  Result := False;
  aIP.Address := INADDR_NONE;
  aIP.IP := aIPAddr;
  aIP.Host := '';
  if aIP.IP = '' then
    Exit;

  GetMem(pIPAddr, Length(aIP.IP) + 1);
  try
    ZeroMemory(pIPAddr, Length(aIP.IP) + 1);
    StrPCopy(pIPAddr, {$IFDEF UNICODE}AnsiString{$ENDIF}(aIP.IP));
    aIP.Address := inet_addr(PAnsiChar(pIPAddr)); // IP转换成无点整型
  finally
    FreeMem(pIPAddr); // 释放申请的动态内存
  end;
  Result := aIP.Address <> INADDR_NONE;
end;

function PingIP_Host(const aIP: TIpInfo; const Data; Count: Cardinal; var aReply:
  string): Integer;
var
  IPOpt: TIPOptionInformation; // 发送数据结构
  pReqData, pRevData: PAnsiChar;
  pCIER: PIcmpEchoReply;
  FWSAData: TWSAData;
begin
  Result := -1;
  pReqData := nil;

  if Count <= 0 then
    Exit;

  if aIP.Address = INADDR_NONE then
    Exit;

  GetMem(pCIER, SizeOf(TICMPEchoReply) + Count);
  GetMem(pRevData, Count);
  try
    FillChar(pCIER^, SizeOf(TICMPEchoReply) + Count, 0); // 初始化接收数据结构
    pCIER^.Data := pRevData;
    GetMem(pReqData, Count);
    Move(Data, pReqData^, Count); // 准备发送的数据
    FillChar(IPOpt, Sizeof(IPOpt), 0); // 初始化发送数据结构
    IPOpt.TTL := 128;

    try //Ping开始
      if WSAStartup(MAKEWORD(2, 0), FWSAData) <> 0 then
        raise Exception.Create('Init Failed.');
      if IcmpSendEcho(HICMP, //dll handle
        aIP.Address, //target
        pReqData, //data
        Count, //data length
        @IPOpt, //addree of ping option
        pCIER, SizeOf(TICMPEchoReply) + Count, //pack size
        1000 //timeout value
      ) <> 0 then
      begin
        Result := 0; // Ping正常返回
//        if Assigned(FOnReceived) then
//          FOnReceived(Self, aIP.IP, aIP.Host, IPOpt.TTL, IPOpt.TOS);
      end
      else
      begin
        Result := -2; // 没有响应
//        if Assigned(FOnError) then
//          FOnError(Self, aIP.IP, aIP.Host, IPOpt.TTL, IPOpt.TOS, SNoResponse);
      end;
    except
      on E: Exception do
      begin
        Result := -3; // 发生错误
//        if Assigned(FOnError) then
//          FOnError(Self, aIP.IP, aIP.Host, IPOpt.TTL, IPOpt.TOS, E.Message);
      end;
    end;
  finally
    WSACleanUP;
    aReply := '';
    if pRevData <> nil then
    begin
      FreeMem(pRevData); // 释放内存
      pCIER.Data := nil;
    end;
    if pReqData <> nil then
      FreeMem(pReqData); //释放内存
    FreeMem(pCIER); //释放内存
  end;
end;

procedure TFormPuf.btnBrowseClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edtFile.Text := dlgOpen.FileName;
end;

procedure TFormPuf.edtFileChange(Sender: TObject);
var
  H: Integer;
begin
  H := MyGetFileSize(edtFile.Text);
  if H >= 0 then
    lblInfo.Caption := IntToStr(H)
  else
    lblInfo.Caption := '';
end;

procedure TFormPuf.FormCreate(Sender: TObject);
begin
  InitIcmpFunctions;
  HICMP := IcmpCreateFile; // 取得DLL句柄
  if HICMP = INVALID_HANDLE_VALUE then
    raise Exception.Create('ICMP Error');
end;

procedure TFormPuf.FormDestroy(Sender: TObject);
begin
  if HICMP <> INVALID_HANDLE_VALUE then
    IcmpCloseHandle(HICMP);
  FreeIcmpFunctions;
end;

procedure TFormPuf.btnSendClick(Sender: TObject);
var
  Reply: string;
  Buf: PAnsiChar;
  BufSize: Integer;
  aIP: TIpInfo;
  Stream: TFileStream;
  PSeq, PSize: PCardinal;
  Seq, ASize, FileSize: Integer;
  FileName: AnsiString;
begin
  if not FileExists(edtFile.Text) then
  begin
    ShowMessage('No File.');
    Exit;
  end;
  if not SetIP(edtIP.Text, aIP) then
  begin
    ShowMessage('Invalid IP.');
    Exit;
  end;

  BufSize := StrToIntDef(edtSize.Text, 0);
  if BufSize < 256 then
    BufSize := 1024;

  Buf := GetMemory(BufSize);
  Stream := TFileStream.Create(edtFile.Text, fmOpenRead);
  PSeq := PCardinal(@Buf[0]);
  PSize := PCardinal(@Buf[4]);
  Seq := 0;
  FileName := AnsiString(ExtractFileName(edtFile.Text));
  FileSize := Stream.Size;

  try
    // 第一个包，序号，尺寸，文件名
    PSeq^ := 0;
    PSize^ := FileSize;
    CopyMemory(@Buf[8], @FileName[1], Length(FileName) + 1); // 包括末尾的 #0

    if PingIP_Host(aIP, Buf[0], BufSize, Reply) <> 0 then
    begin
      ShowMessage('Error Sending #' + IntToStr(Seq));
      Exit;
    end;
    Sleep(0);

    while FileSize > 0 do
    begin
      // 后面的包，序号，本包的文件内容尺寸，数据
      Inc(Seq);
      PSeq^ := Seq;
      ASize := Stream.Read(Buf[4], BufSize - 8);
      PSize^ := ASize;

      if PingIP_Host(aIP, Buf[0], BufSize, Reply) <> 0 then
      begin
        ShowMessage('Error Sending #' + IntToStr(Seq));
        Exit;
      end;

      Sleep(0);
      Dec(FileSize, ASize);
    end;
    ShowMessage('File Sent. Count ' + IntToStr(Seq));
  finally
    FreeMemory(Buf);
    Stream.Free;
  end;
end;

end.


