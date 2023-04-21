{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     �й����Լ��Ŀ���Դ�������������                         }
{                   (C)Copyright 2001-2023 CnPack ������                       }
{                   ------------------------------------                       }
{                                                                              }
{            ���������ǿ�Դ��������������������� CnPack �ķ���Э������        }
{        �ĺ����·�����һ����                                                }
{                                                                              }
{            ������һ��������Ŀ����ϣ�������ã���û���κε���������û��        }
{        �ʺ��ض�Ŀ�Ķ������ĵ���������ϸ���������� CnPack ����Э�顣        }
{                                                                              }
{            ��Ӧ���Ѿ��Ϳ�����һ���յ�һ�� CnPack ����Э��ĸ��������        }
{        ��û�У��ɷ������ǵ���վ��                                            }
{                                                                              }
{            ��վ��ַ��http://www.cnpack.org                                   }
{            �����ʼ���master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnSocket;
{* |<PRE>
================================================================================
* ������ƣ�����ͨѶ�����
* ��Ԫ���ƣ�����ͨѶ Socket �����������ƽ̨������װ��Ԫ
* ��Ԫ���ߣ�CnPack ������
* ��    ע��
* ����ƽ̨��PWin7 + Delphi 5.0
* ���ݲ��ԣ�PWin9X/2000/XP/7 + Delphi 5/6
* �� �� �����õ�Ԫ�е��ַ��������ϱ��ػ�����ʽ
* �޸ļ�¼��2022.12.06 V1.0
*                ������Ԫ
================================================================================
|</PRE>}

interface

{$I CnPack.inc}

uses
  SysUtils, Classes {$IFDEF MSWINDOWS}, Windows, WinSock {$ELSE}, System.Net.Socket,
  Posix.Base, Posix.NetIf, Posix.SysSocket, Posix.ArpaInet, Posix.NetinetIn,
  Posix.Unistd, Posix.SysSelect, Posix.SysTime {$ENDIF};

type
{$IFDEF MSWINDOWS}
  TCnFDSet = TFDSet;
  PCnFDSet = PFDSet;
{$ELSE}
  TCnFDSet = fd_set;
  PCNFDSet = Pfd_set;

  TSocket = Integer;
  TSockAddr = sockaddr_in;
{$ENDIF}

const
  SD_BOTH = 2;
{$IFNDEF MSWINDOWS}
  SOCKET_ERROR   = -1;
  INVALID_SOCKET = -1;
  SO_DONTLINGER  = $FF7F;

function getifaddrs(var Ifap: pifaddrs): Integer; cdecl; external libc name _PU + 'getifaddrs';

procedure freeifaddrs(Ifap: pifaddrs); cdecl; external libc name _PU + 'freeifaddrs';

{$ENDIF}

function CnGetHostName: string;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� gethostname �����ķ�װ�����ر�����}

function CnNewSocket(Af, Struct, Protocol: Integer): TSocket;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� socket �����ķ�װ}

function CnConnect(S: TSocket; var Name: TSockAddr; NameLen: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� connect �����ķ�װ}

function CnBind(S: TSocket; var Addr: TSockAddr; NameLen: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� bind �����ķ�װ}

function CnGetSockName(S: TSocket; var Name: TSockAddr; var NameLen: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� getsockname �����ķ�װ}

function CnListen(S: TSocket; Backlog: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� listen �����ķ�װ}

function CnAccept(S: TSocket; Addr: PSockAddr; AddrLen: PInteger): TSocket;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� accept �����ķ�װ}

function CnSend(S: TSocket; var Buf; Len, Flags: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� send �����ķ�װ}

function CnRecv(S: TSocket; var Buf; Len, Flags: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� recv �����ķ�װ}

function CnSendTo(S: TSocket; var Buf; Len, Flags: Integer;
  var AddrTo: TSockAddr; ToLen: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� sendto �����ķ�װ}

function CnRecvFrom(S: TSocket; var Buf; Len, Flags: Integer;
  var AddrFrom: TSockAddr; var FromLen: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� recvfrom �����ķ�װ}

function CnSelect(Nfds: Integer; Readfds, Writefds, Exceptfds: PCnFDSet;
  Timeout: PTimeVal): Longint;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� select �����ķ�װ}

function CnSetSockOpt(S: TSocket; Level, OptName: Integer; OptVal: PAnsiChar;
  OptLen: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� setsockopt �����ķ�װ}

function CnShutdown(S: TSocket; How: Integer): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� shutdown �����ķ�װ}

function CnCloseSocket(S: TSocket): Integer;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� closesocket �����ķ�װ}

procedure CnFDZero(var FD: TCnFDSet);
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� FD_ZERO �����ķ�װ}

procedure CnFDSet(F: Integer; var FD: TCnFDSet);
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� FD_SET �����ķ�װ}

procedure CnFDClear(F: Integer; var FD: TCnFDSet);
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� FD_CLR �����ķ�װ}

function CnFDIsSet(F: Integer; var FD: TCnFDSet): Boolean;
{* �� Windows �Լ� POSIX������ MAC��Linux �ȣ�ƽ̨�ϵ� FD_ISSET �����ķ�װ}

implementation

function CnGetHostName: string;
var
  S: array[0..256] of AnsiChar;
begin
{$IFDEF MSWINDOWS}
  WinSock.gethostname(@S[0], SizeOf(S));
{$ELSE}
  Posix.Unistd.gethostname(@S[0], SizeOf(S));
{$ENDIF}
  Result := string(S);
end;

function CnNewSocket(Af, Struct, Protocol: Integer): TSocket;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.socket(Af, Struct, Protocol);
{$ELSE}
  Result := Posix.SysSocket.socket(Af, Struct, Protocol);
{$ENDIF}
end;

function CnConnect(S: TSocket; var Name: TSockAddr; NameLen: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.connect(S, Name, NameLen);
{$ELSE}
  Result := Posix.SysSocket.connect(S, sockaddr(Name), NameLen);
{$ENDIF}
end;

function CnBind(S: TSocket; var Addr: TSockAddr; NameLen: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.bind(S, Addr, NameLen);
{$ELSE}
  Result := Posix.SysSocket.bind(S, sockaddr(Addr), NameLen);
{$ENDIF}
end;

function CnGetSockName(S: TSocket; var Name: TSockAddr; var NameLen: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.getsockname(S, Name, NameLen);
{$ELSE}
  Result := Posix.SysSocket.getsockname(S, sockaddr(Name), Cardinal(NameLen));
{$ENDIF}
end;

function CnListen(S: TSocket; Backlog: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.listen(S, Backlog);
{$ELSE}
  Result := Posix.SysSocket.listen(S, Backlog);
{$ENDIF}
end;

function CnAccept(S: TSocket; Addr: PSockAddr; AddrLen: PInteger): TSocket;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.accept(S, Addr, AddrLen);
{$ELSE}
  Result := Posix.SysSocket.accept(S, Addr^, Cardinal(AddrLen^));
{$ENDIF}
end;

function CnSend(S: TSocket; var Buf; Len, Flags: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.send(S, Buf, Len, Flags);
{$ELSE}
  Result := Posix.SysSocket.send(S, Buf, Len, Flags);
{$ENDIF}
end;

function CnRecv(S: TSocket; var Buf; Len, Flags: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.recv(S, Buf, Len, Flags);
{$ELSE}
  Result := Posix.SysSocket.recv(S, Buf, Len, Flags);
{$ENDIF}
end;

function CnSendTo(S: TSocket; var Buf; Len, Flags: Integer;
  var AddrTo: TSockAddr; ToLen: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.sendto(S, Buf, Len, Flags, AddrTo, ToLen);
{$ELSE}
  Result := Posix.SysSocket.sendto(S, Buf, Len, Flags, sockaddr(AddrTo), ToLen);
{$ENDIF}
end;

function CnRecvFrom(S: TSocket; var Buf; Len, Flags: Integer;
  var AddrFrom: TSockAddr; var FromLen: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.recvfrom(S, Buf, Len, Flags, AddrFrom, FromLen);
{$ELSE}
  Result := Posix.SysSocket.recvfrom(S, Buf, Len, Flags, sockaddr(AddrFrom), Cardinal(FromLen));
{$ENDIF}
end;

function CnSelect(Nfds: Integer; Readfds, Writefds, Exceptfds: PCnFDSet;
  Timeout: PTimeVal): Longint;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.select(Nfds, Readfds, Writefds, Exceptfds, Timeout);
{$ELSE}
  Result := Posix.SysSelect.select(Nfds, Readfds, Writefds, Exceptfds, Timeout);
{$ENDIF}
end;

function CnSetSockOpt(S: TSocket; Level, OptName: Integer; OptVal: PAnsiChar;
  OptLen: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.setsockopt(S, Level, OptName, OptVal, OptLen);
{$ELSE}
  Result := Posix.SysSocket.setsockopt(S, Level, OptName, OptVal, OptLen);
{$ENDIF}
end;

function CnShutdown(S: TSocket; How: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.shutdown(S, How);
{$ELSE}
  Result := Posix.SysSocket.shutdown(S, How);
{$ENDIF}
end;

function CnCloseSocket(S: TSocket): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := WinSock.closesocket(S);
{$ELSE}
  Result := Posix.Unistd.__close(S);
{$ENDIF}
end;

procedure CnFDZero(var FD: TCnFDSet);
begin
  FD_ZERO(FD);
end;

procedure CnFDSet(F: Integer; var FD: TCnFDSet);
begin
{$IFDEF MSWINDOWS}
  FD_SET(F, FD);
{$ELSE}
  _FD_SET(F, FD);
{$ENDIF}
end;

procedure CnFDClear(F: Integer; var FD: TCnFDSet);
begin
  FD_CLR(F, FD);
end;

function CnFDIsSet(F: Integer; var FD: TCnFDSet): Boolean;
begin
  Result := FD_ISSET(F, FD);
end;

end.
