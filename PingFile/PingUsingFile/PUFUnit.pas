unit PUFUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSock, ComCtrls;

const
  ICMPDLL = 'icmp.dll';
  WS2_32DLL = 'WS2_32.DLL';
  MAXIPNOTE = 255;
  IPJOIN = '.';
  IPADDRFORMAT = '%0:D.%1:D.%2:D.%3:D';
  SIO_GET_INTERFACE_LIST = $4004747F;
  IFF_UP = $00000001;
  IFF_BROADCAST = $00000002;
  IFF_LOOPBACK = $00000004;
  IFF_POINTTOPOINT = $00000008;
  IFF_MULTICAST = $00000010;
  IPNOTE1 = $FF000000;
  IPNOTE2 = $00FF0000;
  IPNOTE3 = $0000FF00;
  IPNOTE4 = $000000FF;

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
    edtDelay: TEdit;
    udDelay: TUpDown;
    lblDelay: TLabel;
    chkSepProcess: TCheckBox;
    lblProgress: TLabel;
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

  TIP_NetType = (iptNone, iptANet, iptBNet, iptCNet, iptDNet, iptENet,
    iptBroadCast, iptKeepAddr);

  TIPNotes = array[1..4] of Byte;

  TIP_Info = packed record
    IPAddress: Cardinal;                 // IP地址,此处用整形存储
    SubnetMask: Cardinal;                // 子网掩码,此处用整形存储
    BroadCast: Cardinal;                 // 广播地址,此处用整形存储
    HostName: array[0..255] of AnsiChar; // 主机名
    NetType: TIP_NetType;                // IP地址的网络类型
    Notes: TIPNotes;                     // IP地址的各子节点
    UpState: Boolean;                    // 启用状态
    Loopback: Boolean;                   // 是否环回地址
    SupportBroadcast: Boolean;           // 是否支持广播
  end;

  TIPGroup = array of TIP_Info; //IP地址组

  sockaddr_gen = packed record
    AddressIn: sockaddr_in;
    filler: packed array[0..7] of AnsiChar;
  end;

  TINTERFACE_INFO = packed record
    iiFlags: u_long; // Interface flags
    iiAddress: sockaddr_gen; // Interface address
    iiBroadcastAddress: sockaddr_gen; // Broadcast address
    iiNetmask: sockaddr_gen; // Network mask
  end;

  TIcmpCreateFile = function(): THandle; stdcall;

  TIcmpCloseHandle = function(IcmpHandle: THandle): Boolean; stdcall;

  TIcmpSendEcho = function(IcmpHandle: THandle; DestAddress: DWORD; RequestData:
    Pointer; RequestSize: Word; RequestOptions: PIPOptionInformation;
    ReplyBuffer: Pointer; ReplySize: DWord; TimeOut: DWord): DWord; stdcall;

  TWSAIoctl = function(s: TSocket; cmd: DWORD; lpInBuffer: PByte; dwInBufferLen:
    DWORD; lpOutBuffer: PByte; dwOutBufferLen: DWORD; lpdwOutBytesReturned:
    LPDWORD; lpOverLapped: POINTER; lpOverLappedRoutine: POINTER): Integer; stdcall;

var
  FormPuf: TFormPuf;

implementation

{$R *.dfm}

var
  IcmpCreateFile: TIcmpCreateFile = nil;
  IcmpCloseHandle: TIcmpCloseHandle = nil;
  IcmpSendEcho: TIcmpSendEcho = nil;
  WSAIoctl: TWSAIoctl = nil;
  IcmpDllHandle: THandle = 0;
  WS2_32DllHandle: THandle = 0;
  HICMP: THandle = 0;

  SEP_PROCESS: Boolean = False;  // 本进程为主程序
  SLAVE_PROCESS: Boolean = False; // 本进程为发包的自动化程序

  // -s Sequence Start Number
  // -l local ip address
  // -i dest ip address
  // -f file name
  // -o file offset bytes
  // -b block size bytes
  // -c count
  // -d delay milisec

  CMD_SEQ_START: Integer;
  CMD_LOCAL_IP: string;
  CMD_DEST_IP: string;
  CMD_FILE: string;
  CMD_OFFSET: Integer = 0 ;
  CMD_BLOCK_SIZE: Integer = 1024;
  CMD_COUNT: Integer = 1;
  CMD_DELAY_MILLISEC: Integer = 150;

function WinExecAndWait32(FileName: string; Visibility: Integer;
  ProcessMsg: Boolean): Integer;
var
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);

  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName,                           { pointer to command line string }
    nil,                                { pointer to process security attributes }
    nil,                                { pointer to thread security attributes }
    False,                              { handle inheritance flag }
    CREATE_NEW_CONSOLE or               { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil,                                { pointer to new environment block }
    nil,                                { pointer to current directory name }
    StartupInfo,                        { pointer to STARTUPINFO }
    ProcessInfo) then
    Result := -1                        { pointer to PROCESS_INF }
  else
  begin
    if ProcessMsg then
    begin
      repeat
        Application.ProcessMessages;
        GetExitCodeProcess(ProcessInfo.hProcess, Cardinal(Result));
      until (Result <> STILL_ACTIVE) or Application.Terminated;
    end
    else
    begin
      WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
      GetExitCodeProcess(ProcessInfo.hProcess, Cardinal(Result));
    end;
  end;
end;

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

procedure InitWSAIoctl;
begin
  WS2_32DllHandle := LoadLibrary(WS2_32DLL);
  if WS2_32DllHandle <> 0 then
  begin
    @WSAIoctl := GetProcAddress(WS2_32DllHandle, 'WSAIoctl');
  end;
end;

procedure FreeWSAIoctl;
begin
  if WS2_32DllHandle <> 0 then
    FreeLibrary(WS2_32DllHandle);
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

function GetIPNotes(const aIP: string; var aResult: TIPNotes): Boolean;
var
  iPos, iNote: Integer;
  sIP: string;

  function CheckIpNote(aNote: string): Byte;
  begin
    iNote := StrToInt(aNote);
    if (iNote < 0) or (iNote > MAXIPNOTE) then
      raise Exception.Create(aNote + ' Error Range.');
    Result := iNote;
  end;

begin
  iPos := Pos(IPJOIN, aIP);
  aResult[1] := CheckIpNote(Copy(aIP, 1, iPos - 1));
  sIP := Copy(aIP, iPos + 1, 20);
  iPos := Pos(IPJOIN, sIP);
  aResult[2] := CheckIpNote(Copy(sIP, 1, iPos - 1));
  sIP := Copy(sIP, iPos + 1, 20);
  iPos := Pos(IPJOIN, sIP);
  aResult[3] := CheckIpNote(Copy(sIP, 1, iPos - 1));
  aResult[4] := CheckIpNote(Copy(sIP, iPos + 1, 20));
  Result := aResult[1] > 0;
end;

function IPTypeCheck(const aIP: string): TIP_NetType;
var
  FNotes: TIPNotes;
begin
  Result := iptNone;
  if GetIPNotes(aIP, FNotes) then
  begin
    case FNotes[1] of
      1..126:
        Result := iptANet;
      127:
        Result := iptKeepAddr;
      128..191:
        Result := iptBNet;
      192..223:
        Result := iptCNet;
      224..239:
        Result := iptDNet;
      240..255:
        Result := iptENet;
    else
      Result := iptNone;
    end;
  end;
end;

function IPToInt(const aIP: string): Cardinal;
var
  FNotes: TIPNotes;
begin
  Result := 0;
  if IPTypeCheck(aIP) = iptNone then
  begin
    //raise Exception.Create(SCnErrorAddress);
    Exit;
  end;
  if GetIPNotes(aIP, FNotes) then
  begin
    Result := Result or FNotes[1] shl 24 or FNotes[2] shl 16 or FNotes[3] shl 8
      or FNotes[4];
  end;
end;

function IntToIP(const aIP: Cardinal): string;
var
  FNotes: TIPNotes;
begin
  FNotes[1] := aIP and IPNOTE1 shr 24;
  FNotes[2] := aIP and IPNOTE2 shr 16;
  FNotes[3] := aIP and IPNOTE3 shr 8;
  FNotes[4] := aIP and IPNOTE4;
  Result := Format(IPADDRFORMAT, [FNotes[1], FNotes[2], FNotes[3], FNotes[4]]);
end;

function EnumLocalIP(var aLocalIP: TIPGroup): Integer;
var
  skLocal: TSocket;
  iIP: Integer;
  PtrA: pointer;
  BytesReturned, SetFlags: u_long;
  pAddrInet: Sockaddr_IN;
  Buffer: array[0..20] of TINTERFACE_INFO;
  FWSAData: TWSAData;
begin
  Result := 0;

  WSAStartup($101, FWSAData);
  try
    skLocal := Socket(AF_INET, SOCK_STREAM, 0); // Open a socket
    if (skLocal = INVALID_SOCKET) then
      Exit;

    try // Call WSAIoCtl
      PtrA := @bytesReturned;
      if (WSAIoCtl(skLocal, SIO_GET_INTERFACE_LIST, nil, 0, @Buffer, 1024, PtrA,
        nil, nil) <> SOCKET_ERROR) then
      begin // If ok, find out how
        Result := BytesReturned div SizeOf(TINTERFACE_INFO);
        SetLength(aLocalIP, Result);
        for iIP := 0 to Result - 1 do // For every interface
        begin
          pAddrInet := Buffer[iIP].iiAddress.AddressIn;
          aLocalIP[iIP].IPAddress := IPToInt({$IFDEF UNICODE}string{$ENDIF}(inet_ntoa
            (pAddrInet.sin_addr)));
          pAddrInet := Buffer[iIP].iiNetMask.AddressIn;
          aLocalIP[iIP].SubnetMask := IPToInt({$IFDEF UNICODE}string{$ENDIF}(inet_ntoa
            (pAddrInet.sin_addr)));
          pAddrInet := Buffer[iIP].iiBroadCastAddress.AddressIn;
          aLocalIP[iIP].BroadCast := IPToInt({$IFDEF UNICODE}string{$ENDIF}(inet_ntoa
            (pAddrInet.sin_addr)));
          SetFlags := Buffer[iIP].iiFlags;
          aLocalIP[iIP].UpState := (SetFlags and IFF_UP) = IFF_UP;
          aLocalIP[iIP].Loopback := (SetFlags and IFF_LOOPBACK) = IFF_LOOPBACK;
          aLocalIP[iIP].SupportBroadcast := (SetFlags and IFF_BROADCAST) = IFF_BROADCAST;
        end;
      end;
    except
      ;
    end;
    CloseSocket(skLocal);
  finally
    WSACleanUp;
  end;
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
        Result := GetLastError; // 没有响应
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
var
  aLocalIP: TIPGroup;
  I: Integer;
  HasError: Boolean;
  Stream: TFileStream;
  Buf: PAnsiChar;
  PSeq: PCardinal;
  PSize: PCardinal;
  ASize: Integer;
  aIP: TIpInfo;
  Reply: string;
  Ret: Integer;

  procedure ShowError(Msg: string);
  begin
    HasError := True;
    ShowMessage(Msg);
    Application.Terminate;
  end;

begin
  InitIcmpFunctions;
  InitWSAIoctl;
  HICMP := IcmpCreateFile; // 取得DLL句柄
  if HICMP = INVALID_HANDLE_VALUE then
    raise Exception.Create('ICMP Error');

  if ParamCount > 0 then
    SLAVE_PROCESS := True;

  EnumLocalIP(aLocalIP);
  if Length(aLocalIP) > 0 then
    edtIP.Text := IntToIP(aLocalIP[0].IPAddress);

  if SLAVE_PROCESS then
  begin
    // -s Sequence Start Number
    // -l local ip address
    // -i dest ip address
    // -f file name
    // -o file offset bytes
    // -b block size bytes
    // -c count
    // -d delay milisec
    HasError := False;
    I := 1;
    while I <= ParamCount do
    begin
      if ParamStr(I) = '-s' then
      begin
        Inc(I);
        if I > ParamCount then
          ShowError('No Params for -s');
        CMD_SEQ_START := StrToIntDef(ParamStr(I), CMD_SEQ_START);
        Inc(I);
      end
      else if ParamStr(I) = '-l' then
      begin
        Inc(I);
        if I > ParamCount then
          ShowError('No Params for -l');
        CMD_LOCAL_IP := ParamStr(I);
        Inc(I);
      end
      else if ParamStr(I) = '-i' then
      begin
        Inc(I);
        if I > ParamCount then
          ShowError('No Params for -i');
        CMD_DEST_IP := ParamStr(I);
        Inc(I);
      end
      else if ParamStr(I) = '-f' then
      begin
        Inc(I);
        if I > ParamCount then
          ShowError('No Params for -f');
        CMD_FILE := ParamStr(I);
        Inc(I);
      end
      else if ParamStr(I) = '-o' then
      begin
        Inc(I);
        if I > ParamCount then
          ShowError('No Params for -o');
        CMD_OFFSET := StrToIntDef(ParamStr(I), CMD_OFFSET);
        Inc(I);
      end
      else if ParamStr(I) = '-b' then
      begin
        Inc(I);
        if I > ParamCount then
          ShowError('No Params for -b');
        CMD_BLOCK_SIZE := StrToIntDef(ParamStr(I), CMD_BLOCK_SIZE);
        Inc(I);
      end
      else if ParamStr(I) = '-c' then
      begin
        Inc(I);
        if I > ParamCount then
          ShowError('No Params for -c');
        CMD_COUNT := StrToIntDef(ParamStr(I), CMD_COUNT);
        Inc(I);
      end
      else if ParamStr(I) = '-d' then
      begin
        Inc(I);
        if I > ParamCount then
          ShowError('No Params for -d');
        CMD_DELAY_MILLISEC := StrToIntDef(ParamStr(I), CMD_DELAY_MILLISEC);
        Inc(I);
      end;
    end;

    // TODO: Send Packets using the Params
    if not FileExists(CMD_FILE) then
      ShowError('No File.');
    if CMD_COUNT <= 0 then
      ShowError('No Count.');
    if not SetIP(CMD_DEST_IP, aIP) then
      ShowError('Invalid IP.');

    Buf := GetMemory(CMD_BLOCK_SIZE);
    Stream := TFileStream.Create(CMD_FILE, fmOpenRead or fmShareDenyWrite);
    Stream.Seek(CMD_OFFSET, soFromBeginning);
    PSeq := PCardinal(@Buf[0]);
    PSize := PCardinal(@Buf[4]);

    try
      for I := 1 to CMD_COUNT do
      begin
        PSeq^ := CMD_SEQ_START;
        ASize := Stream.Read(Buf[8], CMD_BLOCK_SIZE - 8);
        if ASize = 0 then // 文件没内容了
          Break;

        PSize^ := ASize;
        Ret := PingIP_Host(aIP, Buf[0], CMD_BLOCK_SIZE, Reply);
        if Ret <> 0 then
        begin
          ShowMessage('Error Sending #' + IntToStr(CMD_SEQ_START) + ' : ' +IntToStr(Ret));
          Exit;
        end;

        Inc(CMD_SEQ_START);
        Sleep(CMD_DELAY_MILLISEC);
      end;
    finally
      FreeMemory(Buf);
      Stream.Free;
    end;
    Application.Terminate;
  end;
end;

procedure TFormPuf.FormDestroy(Sender: TObject);
begin
  if HICMP <> INVALID_HANDLE_VALUE then
    IcmpCloseHandle(HICMP);
  FreeWSAIoctl;
  FreeIcmpFunctions;
end;

procedure TFormPuf.btnSendClick(Sender: TObject);
const
  BATCH_COUNT = 10;
var
  Reply: string;
  Buf: PAnsiChar;
  BufSize, Ret: Integer;
  aIP: TIpInfo;
  Stream: TFileStream;
  PSeq, PSize: PCardinal;
  Seq, ASize, FileSize: Integer;
  FileName: AnsiString;
  Interval: Integer;
  Cmd: string;
  RetryFlag: Boolean;
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
  Interval := udDelay.Position;
  BufSize := StrToIntDef(edtSize.Text, 0);
  if BufSize < 256 then
    BufSize := 1024;

  Buf := GetMemory(BufSize);
  Stream := TFileStream.Create(edtFile.Text, fmOpenRead or fmShareDenyWrite);
  PSeq := PCardinal(@Buf[0]);
  PSize := PCardinal(@Buf[4]);
  Seq := 0;
  FileName := AnsiString(ExtractFileName(edtFile.Text));
  FileSize := Stream.Size;

  lblProgress.Caption := '';

  try
    // 第一个包，序号，尺寸，文件名
    PSeq^ := 0;
    PSize^ := FileSize;
    CopyMemory(@Buf[8], @FileName[1], Length(FileName) + 1); // 包括末尾的 #0

    Ret := PingIP_Host(aIP, Buf[0], BufSize, Reply);
    if Ret <> 0 then
    begin
      ShowMessage('Error Sending #' + IntToStr(Seq) + ' : ' +IntToStr(Ret));
      Exit;
    end;
    Sleep(Interval);

    if chkSepProcess.Checked then
    begin
      while FileSize > 0 do
      begin
        // Inc(Seq);         // 序列号起始
        // Stream.Position;  // 文件偏移
        // aIP.IP;           // 目标 IP
        // Interval;         // 发包间隔时间
        // BufSize;          // 缓冲区大小
        // 10;               // 默认发 10 个
        Cmd := Format('%s -s %d -f "%s" -i %s -d %d -o %d -b %d -c %d',
          [ParamStr(0), Seq, edtFile.Text, aIP.IP, Interval, Stream.Position,
          BufSize, BATCH_COUNT]);
        // ShowMessage(Cmd);
        WinExecAndWait32(Cmd, SW_HIDE, False);
        Stream.Seek(BATCH_COUNT * BufSize, soFromCurrent);
        Dec(FileSize, BATCH_COUNT * BufSize);
        Inc(Seq, BATCH_COUNT);
      end;
    end
    else
    begin
      RetryFlag := False;
      while FileSize > 0 do
      begin
        // 后面的包，序号，本包的文件内容尺寸，数据
        if not RetryFlag then
          Inc(Seq);
        RetryFlag := False;

        PSeq^ := Seq;
        ASize := Stream.Read(Buf[8], BufSize - 8);
        PSize^ := ASize;

        Ret := PingIP_Host(aIP, Buf[0], BufSize, Reply);
        if Ret <> 0 then
        begin
          if Ret = 11010 then
          begin
            // QOS fail, wait some time to retry.
            lblProgress.Caption := IntToStr(Seq) + ' QOS Fail. Wait 4 Secs to Retry.';
            Application.ProcessMessages;
            Sleep(4000);
            RetryFlag := True;
            Continue;
          end
          else
          begin
            ShowMessage('Error Sending #' + IntToStr(Seq) + ' : ' +IntToStr(Ret));
            Exit;
          end;
        end;

        Sleep(Interval);
        Dec(FileSize, ASize);

        lblProgress.Caption := IntToStr(Seq) + ' Sent.';
        Application.ProcessMessages;
      end;
      ShowMessage('File Sent. Count ' + IntToStr(Seq));
    end;
  finally
    FreeMemory(Buf);
    Stream.Free;
  end;
end;

end.


