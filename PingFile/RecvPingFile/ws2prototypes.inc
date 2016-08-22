function WSAStartup( const wVersionRequired: word; var WSData: TWSAData ): Integer; stdcall;

{$IFDEF INCL_WINSOCK_API_PROTOTYPES}
function WSACleanup: Integer; stdcall;
function accept( const s: TSocket; addr: PSockAddr; addrlen: PInteger ): TSocket; stdcall;
function bind( const s: TSocket; const name: PSockAddr; const namelen: Integer ): Integer; stdcall;
function closesocket( const s: TSocket ): Integer; stdcall;
function connect( const s: TSocket; const name: PSockAddr; const namelen: Integer): Integer; stdcall;
function ioctlsocket( const s: TSocket; const cmd: DWORD; var arg: u_long ): Integer; stdcall;
function getpeername( const s: TSocket; const name: PSockAddr; var namelen: Integer ): Integer; stdcall;
function getsockname( const s: TSocket; const name: PSockAddr; var namelen: Integer ): Integer; stdcall;
function getsockopt( const s: TSocket; const level, optname: Integer; optval: PChar; var optlen: Integer ): Integer; stdcall;
function htonl(hostlong: u_long): u_long; stdcall;
function htons(hostshort: u_short): u_short; stdcall;
function inet_addr(cp: PChar): u_long; stdcall;
function inet_ntoa(inaddr: TInAddr): PChar; stdcall;
function listen( const s: TSocket; backlog: Integer ): Integer; stdcall;
function ntohl(netlong: u_long): u_long; stdcall;
function ntohs(netshort: u_short): u_short; stdcall;
function recv( const s: TSocket; var Buf; len, flags: Integer ): Integer; stdcall;
function recvfrom( const s: TSocket; var Buf; len, flags: Integer; from: PSockAddr; fromlen: PInteger ): Integer; stdcall;
function select(nfds: Integer; readfds, writefds, exceptfds: PFDSet; timeout: PTimeVal ): Integer; stdcall;
function send( const s: TSocket; var Buf; len, flags: Integer ): Integer; stdcall;
function sendto( const s: TSocket; var Buf; const len, flags: Integer; const addrto: PSockAddr; const tolen: Integer ): Integer; stdcall;
function setsockopt( const s: TSocket; const level, optname: Integer; optval: PChar; const optlen: Integer ): Integer; stdcall;
function shutdown( const s: TSocket; const how: Integer ): Integer; stdcall;
function socket( const af, struct, protocol: Integer ): TSocket; stdcall;
function gethostbyaddr( addr: Pointer; const len, addrtype: Integer ): PHostEnt; stdcall;
function gethostbyname( name: PChar ): PHostEnt; stdcall;
function gethostname( name: PChar; len: Integer ): Integer; stdcall;
function getservbyport( const port: Integer; const proto: PChar ): PServEnt; stdcall;
function getservbyname( const name, proto: PChar ): PServEnt; stdcall;
function getprotobynumber( const proto: Integer ): PProtoEnt; stdcall;
function getprotobyname( const name: PChar ): PProtoEnt; stdcall;
procedure WSASetLastError( const iError: Integer ); stdcall;
function WSAGetLastError: Integer; stdcall;
function WSAIsBlocking: BOOL; stdcall;
function WSAUnhookBlockingHook: Integer; stdcall;
function WSASetBlockingHook( lpBlockFunc: TFarProc ): TFarProc; stdcall;
function WSACancelBlockingCall: Integer; stdcall;
function WSAAsyncGetServByName( HWindow: HWND; wMsg: u_int; name, proto, buf: PChar; buflen: Integer ): THandle; stdcall;
function WSAAsyncGetServByPort( HWindow: HWND; wMsg, port: u_int; proto, buf: PChar; buflen: Integer ): THandle; stdcall;
function WSAAsyncGetProtoByName( HWindow: HWND; wMsg: u_int; name, buf: PChar; buflen: Integer ): THandle; stdcall;
function WSAAsyncGetProtoByNumber( HWindow: HWND; wMsg: u_int; number: Integer; buf: PChar; buflen: Integer ): THandle; stdcall;
function WSAAsyncGetHostByName( HWindow: HWND; wMsg: u_int; name, buf: PChar; buflen: Integer ): THandle; stdcall;
function WSAAsyncGetHostByAddr( HWindow: HWND; wMsg: u_int; addr: PChar; len, struct: Integer; buf: PChar; buflen: Integer ): THandle; stdcall;
function WSACancelAsyncRequest( hAsyncTaskHandle: THandle ): Integer; stdcall;
function WSAAsyncSelect( const s: TSocket; HWindow: HWND; wMsg: u_int; lEvent: Longint ): Integer; stdcall;
function __WSAFDIsSet( const s: TSocket; var FDSet: TFDSet ): Bool; stdcall;

// WinSock 2 API new function prototypes
function WSAAccept( const s : TSocket; addr : PSockAddr; addrlen : PInteger; lpfnCondition : LPCONDITIONPROC; const dwCallbackData : DWORD ): TSocket; stdcall;
function WSACloseEvent( const hEvent : WSAEVENT ) : WordBool; stdcall;
function WSAConnect( const s : TSocket; const name : PSockAddr; const namelen : Integer; lpCallerData,lpCalleeData : LPWSABUF; lpSQOS,lpGQOS : LPQOS ) : Integer; stdcall;
function WSACreateEvent : WSAEVENT; stdcall;

function WSADuplicateSocketA( const s : TSocket; const dwProcessId : DWORD; lpProtocolInfo : LPWSAProtocol_InfoA ) : Integer; stdcall;
function WSADuplicateSocketW( const s : TSocket; const dwProcessId : DWORD; lpProtocolInfo : LPWSAProtocol_InfoW ) : Integer; stdcall;
function WSADuplicateSocket( const s : TSocket; const dwProcessId : DWORD; lpProtocolInfo : LPWSAProtocol_Info ) : Integer; stdcall;

function WSAEnumNetworkEvents( const s : TSocket; const hEventObject : WSAEVENT; lpNetworkEvents : LPWSANETWORKEVENTS ) :Integer; stdcall;
function WSAEnumProtocolsA( lpiProtocols : PInteger; lpProtocolBuffer : LPWSAProtocol_InfoA; var lpdwBufferLength : DWORD ) : Integer; stdcall;
function WSAEnumProtocolsW( lpiProtocols : PInteger; lpProtocolBuffer : LPWSAProtocol_InfoW; var lpdwBufferLength : DWORD ) : Integer; stdcall;
function WSAEnumProtocols( lpiProtocols : PInteger; lpProtocolBuffer : LPWSAProtocol_Info; var lpdwBufferLength : DWORD ) : Integer; stdcall;

function WSAEventSelect( const s : TSocket; const hEventObject : WSAEVENT; lNetworkEvents : LongInt ): Integer; stdcall;

function WSAGetOverlappedResult( const s : TSocket; lpOverlapped : LPWSAOVERLAPPED; lpcbTransfer : LPDWORD; fWait : BOOL; var lpdwFlags : DWORD ) : WordBool; stdcall;

function WSAGetQosByName( const s : TSocket; lpQOSName : LPWSABUF; lpQOS : LPQOS ): WordBool; stdcall;

function WSAHtonl( const s : TSocket; hostlong : u_long; var lpnetlong : DWORD ): Integer; stdcall;
function WSAHtons( const s : TSocket; hostshort : u_short; var lpnetshort : WORD ): Integer; stdcall;

function WSAIoctl( const s : TSocket; dwIoControlCode : DWORD; lpvInBuffer : Pointer; cbInBuffer : DWORD; lpvOutBuffer : Pointer; cbOutBuffer : DWORD;
  lpcbBytesReturned : LPDWORD; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ) : Integer; stdcall;

function WSAJoinLeaf( const s : TSocket; name : PSockAddr; namelen : Integer; lpCallerData,lpCalleeData : LPWSABUF;
  lpSQOS,lpGQOS : LPQOS; dwFlags : DWORD ) : TSocket; stdcall;

function WSANtohl( const s : TSocket; netlong : u_long; var lphostlong : DWORD ): Integer; stdcall;
function WSANtohs( const s : TSocket; netshort : u_short; var lphostshort : WORD ): Integer; stdcall;

function WSARecv( const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesRecvd : DWORD; var lpFlags : DWORD;
  lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall;
function WSARecvDisconnect( const s : TSocket; lpInboundDisconnectData : LPWSABUF ): Integer; stdcall;
function WSARecvFrom( const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesRecvd : DWORD; var lpFlags : DWORD;
  lpFrom : PSockAddr; lpFromlen : PInteger; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall;

function WSAResetEvent( hEvent : WSAEVENT ): WordBool; stdcall;

function WSASend( const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesSent : DWORD; dwFlags : DWORD;
  lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall;
function WSASendDisconnect( const s : TSocket; lpOutboundDisconnectData : LPWSABUF ): Integer; stdcall;
function WSASendTo( const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesSent : DWORD; dwFlags : DWORD;
  lpTo : PSockAddr; iTolen : Integer; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall;

function WSASetEvent( hEvent : WSAEVENT ): WordBool; stdcall;

function WSASocketA( af, iType, protocol : Integer; lpProtocolInfo : LPWSAProtocol_InfoA; g : GROUP; dwFlags : DWORD ): TSocket; stdcall;
function WSASocketW( af, iType, protocol : Integer; lpProtocolInfo : LPWSAProtocol_InfoW; g : GROUP; dwFlags : DWORD ): TSocket; stdcall;
function WSASocket( af, iType, protocol : Integer; lpProtocolInfo : LPWSAProtocol_Info; g : GROUP; dwFlags : DWORD ): TSocket; stdcall;

function WSAWaitForMultipleEvents( cEvents : DWORD; lphEvents : PWSAEVENT; fWaitAll : LongBool;
  dwTimeout : DWORD; fAlertable : LongBool ): DWORD; stdcall;

function WSAAddressToStringA( lpsaAddress : PSockAddr; const dwAddressLength : DWORD; const lpProtocolInfo : LPWSAProtocol_InfoA;
  const lpszAddressString : PChar; var lpdwAddressStringLength : DWORD ): Integer; stdcall;
function WSAAddressToStringW( lpsaAddress : PSockAddr; const dwAddressLength : DWORD; const lpProtocolInfo : LPWSAProtocol_InfoW;
  const lpszAddressString : PWideChar; var lpdwAddressStringLength : DWORD ): Integer; stdcall;
function WSAAddressToString( lpsaAddress : PSockAddr; const dwAddressLength : DWORD; const lpProtocolInfo : LPWSAProtocol_Info;
  const lpszAddressString : PMBChar; var lpdwAddressStringLength : DWORD ): Integer; stdcall;

function WSAStringToAddressA( const AddressString : PChar; const AddressFamily: Integer; const lpProtocolInfo : LPWSAProtocol_InfoA;
  var lpAddress : TSockAddr; var lpAddressLength : Integer ): Integer; stdcall;
function WSAStringToAddressW( const AddressString : PWideChar; const AddressFamily: Integer; const lpProtocolInfo : LPWSAProtocol_InfoW;
  var lpAddress : TSockAddr; var lpAddressLength : Integer ): Integer; stdcall;
function WSAStringToAddress( const AddressString : PMBChar; const AddressFamily: Integer; const lpProtocolInfo : LPWSAProtocol_Info;
  var lpAddress : TSockAddr; var lpAddressLength : Integer ): Integer; stdcall;

// Registration and Name Resolution API functions 
function WSALookupServiceBeginA( var qsRestrictions : TWSAQuerySetA; const dwControlFlags : DWORD; var hLookup : THANDLE ): Integer; stdcall;
function WSALookupServiceBeginW( var qsRestrictions : TWSAQuerySetW; const dwControlFlags : DWORD; var hLookup : THANDLE ): Integer; stdcall;
function WSALookupServiceBegin( var qsRestrictions : TWSAQuerySet; const dwControlFlags : DWORD; var hLookup : THANDLE ): Integer; stdcall;

function WSALookupServiceNextA( const hLookup : THandle; const dwControlFlags : DWORD; var dwBufferLength : DWORD; lpqsResults : PWSAQuerySetA ): Integer; stdcall;
function WSALookupServiceNextW( const hLookup : THandle; const dwControlFlags : DWORD; var dwBufferLength : DWORD; lpqsResults : PWSAQuerySetW ): Integer; stdcall;
function WSALookupServiceNext( const hLookup : THandle; const dwControlFlags : DWORD; var dwBufferLength : DWORD; lpqsResults : PWSAQuerySet ): Integer; stdcall;

function WSALookupServiceEnd( const hLookup : THandle ): Integer; stdcall;

function WSAInstallServiceClassA( const lpServiceClassInfo : LPWSAServiceClassInfoA ) : Integer; stdcall;
function WSAInstallServiceClassW( const lpServiceClassInfo : LPWSAServiceClassInfoW ) : Integer; stdcall;
function WSAInstallServiceClass( const lpServiceClassInfo : LPWSAServiceClassInfo ) : Integer; stdcall;

function WSARemoveServiceClass( const lpServiceClassId : PGUID ) : Integer; stdcall;

function WSAGetServiceClassInfoA( const lpProviderId : PGUID; const lpServiceClassId : PGUID; var lpdwBufSize : DWORD;
  lpServiceClassInfo : LPWSAServiceClassInfoA ): Integer; stdcall;
function WSAGetServiceClassInfoW( const lpProviderId : PGUID; const lpServiceClassId : PGUID; var lpdwBufSize : DWORD;
  lpServiceClassInfo : LPWSAServiceClassInfoW ): Integer; stdcall;
function WSAGetServiceClassInfo( const lpProviderId : PGUID; const lpServiceClassId : PGUID; var lpdwBufSize : DWORD;
  lpServiceClassInfo : LPWSAServiceClassInfo ): Integer; stdcall;

function WSAEnumNameSpaceProvidersA( var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANameSpace_InfoA ): Integer; stdcall;
function WSAEnumNameSpaceProvidersW( var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANameSpace_InfoW ): Integer; stdcall;
function WSAEnumNameSpaceProviders( var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANameSpace_Info ): Integer; stdcall;

function WSAGetServiceClassNameByClassIdA( const lpServiceClassId: PGUID; lpszServiceClassName: PChar; var lpdwBufferLength: DWORD ): Integer; stdcall;
function WSAGetServiceClassNameByClassIdW( const lpServiceClassId: PGUID; lpszServiceClassName: PWideChar; var lpdwBufferLength: DWORD ): Integer; stdcall;
function WSAGetServiceClassNameByClassId( const lpServiceClassId: PGUID; lpszServiceClassName: PMBChar; var lpdwBufferLength: DWORD ): Integer; stdcall;

function WSASetServiceA( const lpqsRegInfo: LPWSAQuerySetA; const essoperation: TWSAeSetServiceOp; const dwControlFlags: DWORD ): Integer; stdcall;
function WSASetServiceW( const lpqsRegInfo: LPWSAQuerySetW; const essoperation: TWSAeSetServiceOp; const dwControlFlags: DWORD ): Integer; stdcall;
function WSASetService( const lpqsRegInfo: LPWSAQuerySet; const essoperation: TWSAeSetServiceOp; const dwControlFlags: DWORD ): Integer; stdcall;

function WSAProviderConfigChange( var lpNotificationHandle : THandle; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ) : Integer; stdcall;
{$ENDIF}


{$IFDEF INCL_WINSOCK_API_TYPEDEFS}
type
	LPFN_WSASTARTUP = function ( const wVersionRequired: word; var WSData: TWSAData ): Integer; stdcall;
	LPFN_WSACLEANUP = function : Integer; stdcall;
	LPFN_ACCEPT = function ( const s: TSocket; addr: PSockAddr; addrlen: PInteger ): TSocket; stdcall;
	LPFN_BIND = function ( const s: TSocket; const name: PSockAddr; const namelen: Integer ): Integer; stdcall;
	LPFN_CLOSESOCKET = function ( const s: TSocket ): Integer; stdcall;
	LPFN_CONNECT = function ( const s: TSocket; const name: PSockAddr; const namelen: Integer): Integer; stdcall;
	LPFN_IOCTLSOCKET = function ( const s: TSocket; const cmd: DWORD; var arg: u_long ): Integer; stdcall;
	LPFN_GETPEERNAME = function ( const s: TSocket; const name: PSockAddr; var namelen: Integer ): Integer; stdcall;
	LPFN_GETSOCKNAME = function ( const s: TSocket; const name: PSockAddr; var namelen: Integer ): Integer; stdcall;
	LPFN_GETSOCKOPT = function ( const s: TSocket; const level, optname: Integer; optval: PChar; var optlen: Integer ): Integer; stdcall;
	LPFN_HTONL = function (hostlong: u_long): u_long; stdcall;
	LPFN_HTONS = function (hostshort: u_short): u_short; stdcall;
	LPFN_INET_ADDR = function (cp: PChar): u_long; stdcall;
	LPFN_INET_NTOA = function (inaddr: TInAddr): PChar; stdcall;
	LPFN_LISTEN = function ( const s: TSocket; backlog: Integer ): Integer; stdcall;
	LPFN_NTOHL = function (netlong: u_long): u_long; stdcall;
	LPFN_NTOHS = function (netshort: u_short): u_short; stdcall;
	LPFN_RECV = function ( const s: TSocket; var Buf; len, flags: Integer ): Integer; stdcall;
	LPFN_RECVFROM = function ( const s: TSocket; var Buf; len, flags: Integer; from: PSockAddr; fromlen: PInteger ): Integer; stdcall;
	LPFN_SELECT = function (nfds: Integer; readfds, writefds, exceptfds: PFDSet; timeout: PTimeVal ): Integer; stdcall;
	LPFN_SEND = function ( const s: TSocket; var Buf; len, flags: Integer ): Integer; stdcall;
	LPFN_SENDTO = function ( const s: TSocket; var Buf; const len, flags: Integer; const addrto: PSockAddr; const tolen: Integer ): Integer; stdcall;
	LPFN_SETSOCKOPT = function ( const s: TSocket; const level, optname: Integer; optval: PChar; const optlen: Integer ): Integer; stdcall;
	LPFN_SHUTDOWN = function ( const s: TSocket; const how: Integer ): Integer; stdcall;
	LPFN_SOCKET = function ( const af, struct, protocol: Integer ): TSocket; stdcall;
	LPFN_GETHOSTBYADDR = function ( addr: Pointer; const len, addrtype: Integer ): PHostEnt; stdcall;
	LPFN_GETHOSTBYNAME = function ( name: PChar ): PHostEnt; stdcall;
	LPFN_GETHOSTNAME = function ( name: PChar; len: Integer ): Integer; stdcall;
	LPFN_GETSERVBYPORT = function ( const port: Integer; const proto: PChar ): PServEnt; stdcall;
	LPFN_GETSERVBYNAME = function ( const name, proto: PChar ): PServEnt; stdcall;
	LPFN_GETPROTOBYNUMBER = function ( const proto: Integer ): PProtoEnt; stdcall;
	LPFN_GETPROTOBYNAME = function ( const name: PChar ): PProtoEnt; stdcall;
	LPFN_WSASETLASTERROR = procedure ( const iError: Integer ); stdcall;
	LPFN_WSAGETLASTERROR = function : Integer; stdcall;
	LPFN_WSAISBLOCKING = function : BOOL; stdcall;
	LPFN_WSAUNHOOKBLOCKINGHOOK = function : Integer; stdcall;
	LPFN_WSASETBLOCKINGHOOK = function ( lpBlockFunc: TFarProc ): TFarProc; stdcall;
	LPFN_WSACANCELBLOCKINGCALL = function : Integer; stdcall;
	LPFN_WSAASYNCGETSERVBYNAME = function ( HWindow: HWND; wMsg: u_int; name, proto, buf: PChar; buflen: Integer ): THandle; stdcall;
	LPFN_WSAASYNCGETSERVBYPORT = function ( HWindow: HWND; wMsg, port: u_int; proto, buf: PChar; buflen: Integer ): THandle; stdcall;
	LPFN_WSAASYNCGETPROTOBYNAME = function ( HWindow: HWND; wMsg: u_int; name, buf: PChar; buflen: Integer ): THandle; stdcall;
	LPFN_WSAASYNCGETPROTOBYNUMBER = function ( HWindow: HWND; wMsg: u_int; number: Integer; buf: PChar; buflen: Integer ): THandle; stdcall;
	LPFN_WSAASYNCGETHOSTBYNAME = function ( HWindow: HWND; wMsg: u_int; name, buf: PChar; buflen: Integer ): THandle; stdcall;
	LPFN_WSAASYNCGETHOSTBYADDR = function ( HWindow: HWND; wMsg: u_int; addr: PChar; len, struct: Integer; buf: PChar; buflen: Integer ): THandle; stdcall;
	LPFN_WSACANCELASYNCREQUEST = function ( hAsyncTaskHandle: THandle ): Integer; stdcall;
	LPFN_WSAASYNCSELECT = function ( const s: TSocket; HWindow: HWND; wMsg: u_int; lEvent: Longint ): Integer; stdcall;
	LPFN___WSAFDISSET = function ( const s: TSocket; var FDSet: TFDSet ): Bool; stdcall;

// WinSock 2 API new function prototypes
	LPFN_WSAACCEPT = function ( const s : TSocket; addr : PSockAddr; addrlen : PInteger; lpfnCondition : LPCONDITIONPROC; const dwCallbackData : DWORD ): TSocket; stdcall;
	LPFN_WSACLOSEEVENT = function ( const hEvent : WSAEVENT ) : WordBool; stdcall;
	LPFN_WSACONNECT = function ( const s : TSocket; const name : PSockAddr; const namelen : Integer; lpCallerData,lpCalleeData : LPWSABUF; lpSQOS,lpGQOS : LPQOS ) : Integer; stdcall;
	LPFN_WSACREATEEVENT  = function : WSAEVENT; stdcall;

	LPFN_WSADUPLICATESOCKETA = function ( const s : TSocket; const dwProcessId : DWORD; lpProtocolInfo : LPWSAProtocol_InfoA ) : Integer; stdcall;
	LPFN_WSADUPLICATESOCKETW = function ( const s : TSocket; const dwProcessId : DWORD; lpProtocolInfo : LPWSAProtocol_InfoW ) : Integer; stdcall;
	LPFN_WSADUPLICATESOCKET = function ( const s : TSocket; const dwProcessId : DWORD; lpProtocolInfo : LPWSAProtocol_Info ) : Integer; stdcall;

	LPFN_WSAENUMNETWORKEVENTS = function ( const s : TSocket; const hEventObject : WSAEVENT; lpNetworkEvents : LPWSANETWORKEVENTS ) :Integer; stdcall;
	LPFN_WSAENUMPROTOCOLSA = function ( lpiProtocols : PInteger; lpProtocolBuffer : LPWSAProtocol_InfoA; var lpdwBufferLength : DWORD ) : Integer; stdcall;
	LPFN_WSAENUMPROTOCOLSW = function ( lpiProtocols : PInteger; lpProtocolBuffer : LPWSAProtocol_InfoW; var lpdwBufferLength : DWORD ) : Integer; stdcall;
	LPFN_WSAENUMPROTOCOLS = function ( lpiProtocols : PInteger; lpProtocolBuffer : LPWSAProtocol_Info; var lpdwBufferLength : DWORD ) : Integer; stdcall;

	LPFN_WSAEVENTSELECT = function ( const s : TSocket; const hEventObject : WSAEVENT; lNetworkEvents : LongInt ): Integer; stdcall;

	LPFN_WSAGETOVERLAPPEDRESULT = function ( const s : TSocket; lpOverlapped : LPWSAOVERLAPPED; lpcbTransfer : LPDWORD; fWait : BOOL; var lpdwFlags : DWORD ) : WordBool; stdcall;

	LPFN_WSAGETQOSBYNAME = function ( const s : TSocket; lpQOSName : LPWSABUF; lpQOS : LPQOS ): WordBool; stdcall;

	LPFN_WSAHTONL = function ( const s : TSocket; hostlong : u_long; var lpnetlong : DWORD ): Integer; stdcall;
	LPFN_WSAHTONS = function ( const s : TSocket; hostshort : u_short; var lpnetshort : WORD ): Integer; stdcall;

	LPFN_WSAIOCTL = function ( const s : TSocket; dwIoControlCode : DWORD; lpvInBuffer : Pointer; cbInBuffer : DWORD; lpvOutBuffer : Pointer; cbOutBuffer : DWORD;
	  lpcbBytesReturned : LPDWORD; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ) : Integer; stdcall;

	LPFN_WSAJOINLEAF = function ( const s : TSocket; name : PSockAddr; namelen : Integer; lpCallerData,lpCalleeData : LPWSABUF;
	  lpSQOS,lpGQOS : LPQOS; dwFlags : DWORD ) : TSocket; stdcall;

	LPFN_WSANTOHL = function ( const s : TSocket; netlong : u_long; var lphostlong : DWORD ): Integer; stdcall;
	LPFN_WSANTOHS = function ( const s : TSocket; netshort : u_short; var lphostshort : WORD ): Integer; stdcall;

	LPFN_WSARECV = function ( const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesRecvd : DWORD; var lpFlags : DWORD;
	  lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall;
	LPFN_WSARECVDISCONNECT = function ( const s : TSocket; lpInboundDisconnectData : LPWSABUF ): Integer; stdcall;
	LPFN_WSARECVFROM = function ( const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesRecvd : DWORD; var lpFlags : DWORD;
	  lpFrom : PSockAddr; lpFromlen : PInteger; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall;

	LPFN_WSARESETEVENT = function ( hEvent : WSAEVENT ): WordBool; stdcall;

	LPFN_WSASEND = function ( const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesSent : DWORD; dwFlags : DWORD;
	  lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall;
	LPFN_WSASENDDISCONNECT = function ( const s : TSocket; lpOutboundDisconnectData : LPWSABUF ): Integer; stdcall;
	LPFN_WSASENDTO = function ( const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesSent : DWORD; dwFlags : DWORD;
	  lpTo : PSockAddr; iTolen : Integer; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall;

	LPFN_WSASETEVENT = function ( hEvent : WSAEVENT ): WordBool; stdcall;

	LPFN_WSASOCKETA = function ( af, iType, protocol : Integer; lpProtocolInfo : LPWSAProtocol_InfoA; g : GROUP; dwFlags : DWORD ): TSocket; stdcall;
	LPFN_WSASOCKETW = function ( af, iType, protocol : Integer; lpProtocolInfo : LPWSAProtocol_InfoW; g : GROUP; dwFlags : DWORD ): TSocket; stdcall;
	LPFN_WSASOCKET = function ( af, iType, protocol : Integer; lpProtocolInfo : LPWSAProtocol_Info; g : GROUP; dwFlags : DWORD ): TSocket; stdcall;

	LPFN_WSAWAITFORMULTIPLEEVENTS = function ( cEvents : DWORD; lphEvents : PWSAEVENT; fWaitAll : LongBool;
	  dwTimeout : DWORD; fAlertable : LongBool ): DWORD; stdcall;

	LPFN_WSAADDRESSTOSTRINGA = function ( lpsaAddress : PSockAddr; const dwAddressLength : DWORD; const lpProtocolInfo : LPWSAProtocol_InfoA;
	  const lpszAddressString : PChar; var lpdwAddressStringLength : DWORD ): Integer; stdcall;
	LPFN_WSAADDRESSTOSTRINGW = function ( lpsaAddress : PSockAddr; const dwAddressLength : DWORD; const lpProtocolInfo : LPWSAProtocol_InfoW;
	  const lpszAddressString : PWideChar; var lpdwAddressStringLength : DWORD ): Integer; stdcall;
	LPFN_WSAADDRESSTOSTRING = function ( lpsaAddress : PSockAddr; const dwAddressLength : DWORD; const lpProtocolInfo : LPWSAProtocol_Info;
	  const lpszAddressString : PMBChar; var lpdwAddressStringLength : DWORD ): Integer; stdcall;

	LPFN_WSASTRINGTOADDRESSA = function ( const AddressString : PChar; const AddressFamily: Integer; const lpProtocolInfo : LPWSAProtocol_InfoA;
	  var lpAddress : TSockAddr; var lpAddressLength : Integer ): Integer; stdcall;
	LPFN_WSASTRINGTOADDRESSW = function ( const AddressString : PWideChar; const AddressFamily: Integer; const lpProtocolInfo : LPWSAProtocol_InfoW;
	  var lpAddress : TSockAddr; var lpAddressLength : Integer ): Integer; stdcall;
	LPFN_WSASTRINGTOADDRESS = function ( const AddressString : PMBChar; const AddressFamily: Integer; const lpProtocolInfo : LPWSAProtocol_Info;
	  var lpAddress : TSockAddr; var lpAddressLength : Integer ): Integer; stdcall;

// Registration and Name Resolution API functions 
	LPFN_WSALOOKUPSERVICEBEGINA = function ( var qsRestrictions : TWSAQuerySetA; const dwControlFlags : DWORD; var hLookup : THANDLE ): Integer; stdcall;
	LPFN_WSALOOKUPSERVICEBEGINW = function ( var qsRestrictions : TWSAQuerySetW; const dwControlFlags : DWORD; var hLookup : THANDLE ): Integer; stdcall;
	LPFN_WSALOOKUPSERVICEBEGIN = function ( var qsRestrictions : TWSAQuerySet; const dwControlFlags : DWORD; var hLookup : THANDLE ): Integer; stdcall;

	LPFN_WSALOOKUPSERVICENEXTA = function ( const hLookup : THandle; const dwControlFlags : DWORD; var dwBufferLength : DWORD; lpqsResults : PWSAQuerySetA ): Integer; stdcall;
	LPFN_WSALOOKUPSERVICENEXTW = function ( const hLookup : THandle; const dwControlFlags : DWORD; var dwBufferLength : DWORD; lpqsResults : PWSAQuerySetW ): Integer; stdcall;
	LPFN_WSALOOKUPSERVICENEXT = function ( const hLookup : THandle; const dwControlFlags : DWORD; var dwBufferLength : DWORD; lpqsResults : PWSAQuerySet ): Integer; stdcall;

	LPFN_WSALOOKUPSERVICEEND = function ( const hLookup : THandle ): Integer; stdcall;

	LPFN_WSAINSTALLSERVICECLASSA = function ( const lpServiceClassInfo : LPWSAServiceClassInfoA ) : Integer; stdcall;
	LPFN_WSAINSTALLSERVICECLASSW = function ( const lpServiceClassInfo : LPWSAServiceClassInfoW ) : Integer; stdcall;
	LPFN_WSAINSTALLSERVICECLASS = function ( const lpServiceClassInfo : LPWSAServiceClassInfo ) : Integer; stdcall;

	LPFN_WSAREMOVESERVICECLASS = function ( const lpServiceClassId : PGUID ) : Integer; stdcall;

	LPFN_WSAGETSERVICECLASSINFOA = function ( const lpProviderId : PGUID; const lpServiceClassId : PGUID; var lpdwBufSize : DWORD;
	  lpServiceClassInfo : LPWSAServiceClassInfoA ): Integer; stdcall;
	LPFN_WSAGETSERVICECLASSINFOW = function ( const lpProviderId : PGUID; const lpServiceClassId : PGUID; var lpdwBufSize : DWORD;
	  lpServiceClassInfo : LPWSAServiceClassInfoW ): Integer; stdcall;
	LPFN_WSAGETSERVICECLASSINFO = function ( const lpProviderId : PGUID; const lpServiceClassId : PGUID; var lpdwBufSize : DWORD;
	  lpServiceClassInfo : LPWSAServiceClassInfo ): Integer; stdcall;

	LPFN_WSAENUMNAMESPACEPROVIDERSA = function ( var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANameSpace_InfoA ): Integer; stdcall;
	LPFN_WSAENUMNAMESPACEPROVIDERSW = function ( var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANameSpace_InfoW ): Integer; stdcall;
	LPFN_WSAENUMNAMESPACEPROVIDERS = function ( var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANameSpace_Info ): Integer; stdcall;

	LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDA = function ( const lpServiceClassId: PGUID; lpszServiceClassName: PChar; var lpdwBufferLength: DWORD ): Integer; stdcall;
	LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDW = function ( const lpServiceClassId: PGUID; lpszServiceClassName: PWideChar; var lpdwBufferLength: DWORD ): Integer; stdcall;
	LPFN_WSAGETSERVICECLASSNAMEBYCLASSID = function ( const lpServiceClassId: PGUID; lpszServiceClassName: PMBChar; var lpdwBufferLength: DWORD ): Integer; stdcall;

	LPFN_WSASETSERVICEA = function ( const lpqsRegInfo: LPWSAQuerySetA; const essoperation: TWSAeSetServiceOp; const dwControlFlags: DWORD ): Integer; stdcall;
	LPFN_WSASETSERVICEW = function ( const lpqsRegInfo: LPWSAQuerySetW; const essoperation: TWSAeSetServiceOp; const dwControlFlags: DWORD ): Integer; stdcall;
	LPFN_WSASETSERVICE = function ( const lpqsRegInfo: LPWSAQuerySet; const essoperation: TWSAeSetServiceOp; const dwControlFlags: DWORD ): Integer; stdcall;

	LPFN_WSAPROVIDERCONFIGCHANGE = function ( var lpNotificationHandle : THandle; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ) : Integer; stdcall;


{$IFDEF WS2_DLL_FUNC_VARS}
var
	WSACleanup : LPFN_WSACLEANUP;
	accept : LPFN_ACCEPT;
	bind : LPFN_BIND;
	closesocket : LPFN_CLOSESOCKET;
	connect : LPFN_CONNECT;
	ioctlsocket : LPFN_IOCTLSOCKET;
	getpeername : LPFN_GETPEERNAME;
	getsockname : LPFN_GETSOCKNAME;
	getsockopt : LPFN_GETSOCKOPT;
	htonl : LPFN_HTONL;
	htons : LPFN_HTONS;
	inet_addr : LPFN_INET_ADDR;
	inet_ntoa : LPFN_INET_NTOA;
	listen : LPFN_LISTEN;
	ntohl : LPFN_NTOHL;
	ntohs : LPFN_NTOHS;
	recv : LPFN_RECV;
	recvfrom : LPFN_RECVFROM;
	select : LPFN_SELECT;
	send : LPFN_SEND;
	sendto : LPFN_SENDTO;
	setsockopt : LPFN_SETSOCKOPT;
	shutdown : LPFN_SHUTDOWN;
	socket : LPFN_SOCKET;
	gethostbyaddr : LPFN_GETHOSTBYADDR;
	gethostbyname : LPFN_GETHOSTBYNAME;
	gethostname : LPFN_GETHOSTNAME;
	getservbyport : LPFN_GETSERVBYPORT;
	getservbyname : LPFN_GETSERVBYNAME;
	getprotobynumber : LPFN_GETPROTOBYNUMBER;
	getprotobyname : LPFN_GETPROTOBYNAME;
	WSASetLastError : LPFN_WSASETLASTERROR;
	WSAGetLastError : LPFN_WSAGETLASTERROR;
	WSAIsBlocking : LPFN_WSAISBLOCKING;
	WSAUnhookBlockingHook : LPFN_WSAUNHOOKBLOCKINGHOOK;
	WSASetBlockingHook : LPFN_WSASETBLOCKINGHOOK;
	WSACancelBlockingCall : LPFN_WSACANCELBLOCKINGCALL;
	WSAAsyncGetServByName : LPFN_WSAASYNCGETSERVBYNAME;
	WSAAsyncGetServByPort : LPFN_WSAASYNCGETSERVBYPORT;
	WSAAsyncGetProtoByName : LPFN_WSAASYNCGETPROTOBYNAME;
	WSAAsyncGetProtoByNumber : LPFN_WSAASYNCGETPROTOBYNUMBER;
	WSAAsyncGetHostByName : LPFN_WSAASYNCGETHOSTBYNAME;
	WSAAsyncGetHostByAddr : LPFN_WSAASYNCGETHOSTBYADDR;
	WSACancelAsyncRequest : LPFN_WSACANCELASYNCREQUEST;
	WSAAsyncSelect : LPFN_WSAASYNCSELECT;
	__WSAFDIsSet : LPFN___WSAFDISSET;
	WSAAccept : LPFN_WSAACCEPT;
	WSACloseEvent : LPFN_WSACLOSEEVENT;
	WSAConnect : LPFN_WSACONNECT;
	WSACreateEvent  : LPFN_WSACREATEEVENT ;
	WSADuplicateSocketA : LPFN_WSADUPLICATESOCKETA;
	WSADuplicateSocketW : LPFN_WSADUPLICATESOCKETW;
	WSADuplicateSocket : LPFN_WSADUPLICATESOCKET;
	WSAEnumNetworkEvents : LPFN_WSAENUMNETWORKEVENTS;
	WSAEnumProtocolsA : LPFN_WSAENUMPROTOCOLSA;
	WSAEnumProtocolsW : LPFN_WSAENUMPROTOCOLSW;
	WSAEnumProtocols : LPFN_WSAENUMPROTOCOLS;
	WSAEventSelect : LPFN_WSAEVENTSELECT;
	WSAGetOverlappedResult : LPFN_WSAGETOVERLAPPEDRESULT;
	WSAGetQosByName : LPFN_WSAGETQOSBYNAME;
	WSAHtonl : LPFN_WSAHTONL;
	WSAHtons : LPFN_WSAHTONS;
	WSAIoctl : LPFN_WSAIOCTL;
	WSAJoinLeaf : LPFN_WSAJOINLEAF;
	WSANtohl : LPFN_WSANTOHL;
	WSANtohs : LPFN_WSANTOHS;
	WSARecv : LPFN_WSARECV;
	WSARecvDisconnect : LPFN_WSARECVDISCONNECT;
	WSARecvFrom : LPFN_WSARECVFROM;
	WSAResetEvent : LPFN_WSARESETEVENT;
	WSASend : LPFN_WSASEND;
	WSASendDisconnect : LPFN_WSASENDDISCONNECT;
	WSASendTo : LPFN_WSASENDTO;
	WSASetEvent : LPFN_WSASETEVENT;
	WSASocketA : LPFN_WSASOCKETA;
	WSASocketW : LPFN_WSASOCKETW;
	WSASocket : LPFN_WSASOCKET;
	WSAWaitForMultipleEvents : LPFN_WSAWAITFORMULTIPLEEVENTS;
	WSAAddressToStringA : LPFN_WSAADDRESSTOSTRINGA;
	WSAAddressToStringW : LPFN_WSAADDRESSTOSTRINGW;
	WSAAddressToString : LPFN_WSAADDRESSTOSTRING;
	WSAStringToAddressA : LPFN_WSASTRINGTOADDRESSA;
	WSAStringToAddressW : LPFN_WSASTRINGTOADDRESSW;
	WSAStringToAddress : LPFN_WSASTRINGTOADDRESS;
	WSALookupServiceBeginA : LPFN_WSALOOKUPSERVICEBEGINA;
	WSALookupServiceBeginW : LPFN_WSALOOKUPSERVICEBEGINW;
	WSALookupServiceBegin : LPFN_WSALOOKUPSERVICEBEGIN;
	WSALookupServiceNextA : LPFN_WSALOOKUPSERVICENEXTA;
	WSALookupServiceNextW : LPFN_WSALOOKUPSERVICENEXTW;
	WSALookupServiceNext : LPFN_WSALOOKUPSERVICENEXT;
	WSALookupServiceEnd : LPFN_WSALOOKUPSERVICEEND;
	WSAInstallServiceClassA : LPFN_WSAINSTALLSERVICECLASSA;
	WSAInstallServiceClassW : LPFN_WSAINSTALLSERVICECLASSW;
	WSAInstallServiceClass : LPFN_WSAINSTALLSERVICECLASS;
	WSARemoveServiceClass : LPFN_WSAREMOVESERVICECLASS;
	WSAGetServiceClassInfoA : LPFN_WSAGETSERVICECLASSINFOA;
	WSAGetServiceClassInfoW : LPFN_WSAGETSERVICECLASSINFOW;
	WSAGetServiceClassInfo : LPFN_WSAGETSERVICECLASSINFO;
	WSAEnumNameSpaceProvidersA : LPFN_WSAENUMNAMESPACEPROVIDERSA;
	WSAEnumNameSpaceProvidersW : LPFN_WSAENUMNAMESPACEPROVIDERSW;
	WSAEnumNameSpaceProviders : LPFN_WSAENUMNAMESPACEPROVIDERS;
	WSAGetServiceClassNameByClassIdA : LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDA;
	WSAGetServiceClassNameByClassIdW : LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDW;
	WSAGetServiceClassNameByClassId : LPFN_WSAGETSERVICECLASSNAMEBYCLASSID;
	WSASetServiceA : LPFN_WSASETSERVICEA;
	WSASetServiceW : LPFN_WSASETSERVICEW;
	WSASetService : LPFN_WSASETSERVICE;
	WSAProviderConfigChange : LPFN_WSAPROVIDERCONFIGCHANGE;
{$ENDIF} // $IFDEF WS2_DLL_FUNC_VARS

{$ENDIF} // $IFDEF INCL_WINSOCK_API_TYPEDEFS

{$IFDEF WS2_DLL_TRACE}

type
	TWS2TraceMaskBit = (
	trc_WSAStartup,trc_WSACleanup,trc_accept,trc_bind,trc_closesocket,
	trc_connect,trc_ioctlsocket,trc_getpeername,trc_getsockname,
	trc_getsockopt,trc_htonl,trc_htons,trc_inet_addr,trc_inet_ntoa,
	trc_listen,trc_ntohl,trc_ntohs,trc_recv,trc_recvfrom,trc_select,trc_send,
	trc_sendto,trc_setsockopt,trc_shutdown,trc_socket,trc_gethostbyaddr,
	trc_gethostbyname,trc_gethostname,trc_getservbyport,trc_getservbyname,
	trc_getprotobynumber,trc_getprotobyname,trc_WSASetLastError,
	trc_WSAGetLastError,trc_WSAIsBlocking,trc_WSAUnhookBlockingHook,
	trc_WSASetBlockingHook,trc_WSACancelBlockingCall,
	trc_WSAAsyncGetServByName,trc_WSAAsyncGetServByPort,
	trc_WSAAsyncGetProtoByName,trc_WSAAsyncGetProtoByNumber,
	trc_WSAAsyncGetHostByName,trc_WSAAsyncGetHostByAddr,
	trc_WSACancelAsyncRequest,trc_WSAAsyncSelect,trc___WSAFDIsSet,
	trc_WSAAccept,trc_WSACloseEvent,trc_WSAConnect,trc_WSACreateEvent ,
	trc_WSADuplicateSocket,trc_WSAEnumNetworkEvents,trc_WSAEnumProtocols,
	trc_WSAEventSelect,trc_WSAGetOverlappedResult,trc_WSAGetQosByName,
	trc_WSAHtonl,trc_WSAHtons,trc_WSAIoctl,trc_WSAJoinLeaf,trc_WSANtohl,
	trc_WSANtohs,trc_WSARecv,trc_WSARecvDisconnect,trc_WSARecvFrom,
	trc_WSAResetEvent,trc_WSASend,trc_WSASendDisconnect,trc_WSASendTo,
	trc_WSASetEvent,trc_WSASocket,trc_WSAWaitForMultipleEvents,
	trc_WSAAddressToString,trc_WSAStringToAddress,trc_WSALookupServiceBegin,
	trc_WSALookupServiceNext,trc_WSALookupServiceEnd,
	trc_WSAInstallServiceClass,trc_WSARemoveServiceClass,
	trc_WSAGetServiceClassInfo,trc_WSAEnumNameSpaceProviders,
	trc_WSAGetServiceClassNameByClassId,trc_WSASetService,
	trc_WSAProviderConfigChange
	);
	TWS2TraceMask = set of TWS2TraceMaskBit;
const
	WS2TraceAll = [Low(TWS2TraceMaskBit)..High(TWS2TraceMaskBit)];
var
	WS2TraceSwitch : Boolean = True; // Calls tracing on/off switch.
	WS2TraceRecvPackets : Boolean = False; // Received packet contents dumping.
	WS2TraceSendPackets : Boolean = False; // Sent packet contents dumping.
	WS2TraceMask : TWS2TraceMask = WS2TraceAll; // Trace filter mask.

{$ENDIF} // $IFDEF WS2_DLL_TRACE
