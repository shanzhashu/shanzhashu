// (c) March 2001,  "Alex Konshin"<alexk@mtgroup.ru>

{$IFDEF WS2_DLL_DYNAMIC_LOAD}	
type
	PPointer = ^Pointer;

var
	hWS2Dll : THandle = 0; // WS2.DLL handle
	WS2_WSAStartup : LPFN_WSASTARTUP;
	
constructor	EWS2StubError.Build( const ATitle : String; AWin32Error : DWORD );
begin
	FTitle := ATitle;
	FWin32Error := AWin32Error;
	if AWin32Error=0 then inherited Create( ATitle )
	else
		begin
			FWin32ErrorMessage := SysUtils.SysErrorMessage(AWin32Error);
			inherited Create( ATitle+': '+FWin32ErrorMessage );
		end;
end;

procedure	WS2StubInit; forward;

procedure	WS2Unload;
var h : THandle;
begin
	h := InterlockedExchange(Integer(hWS2Dll),0);
	if h<>0 then
	begin
		Windows.FreeLibrary(h);
		WS2StubInit;
	end;
end;

{$ENDIF}	// $IFDEF WS2_DLL_DYNAMIC_LOAD


{$IFDEF WS2_DLL_TRACE}

{$IFNDEF WS2_DLL_DYNAMIC_LOAD}	
type
	PPointer = ^Pointer;
{$ENDIF}
	
{$include ws2trace.inc}	
	
{$IFDEF WS2_DLL_DYNAMIC_LOAD}	

procedure	WS2StubInit;
begin
	FillChar( WS2_Entry, SizeOf(Pointer)*WS2_EntryCount, #0 );
end;

{$ENDIF}


function WSAStartup( const wVersionRequired: word; var WSData: TWSAData ): Integer;
begin
	if WS2TraceSwitch and(trc_WSAStartup in WS2TraceMask) then
		Trace('%.8x: WS2_32.WSAStartup wVersionRequired=%.4x',[GetCurrentThreadId,wVersionRequired]);
{$IFDEF WS2_DLL_DYNAMIC_LOAD}
	if hWS2Dll=0 then
	begin
		hWS2Dll := LoadLibrary( WINSOCK2_DLL );
		if hWS2Dll=0 then
			raise EWS2StubError.Build( 'Error on loading Winsock2 library ('+WINSOCK2_DLL+')', Windows.GetLastError );
		WS2_WSAStartup := LPFN_WSASTARTUP( Windows.GetProcAddress( hWS2Dll, 'WSAStartup' ) );
	end;
{$ENDIF}
	Result := WS2_WSAStartup( wVersionRequired, WSData );
end;

{$ELSE}	// not WS2_DLL_TRACE


{$IFDEF WS2_DLL_DYNAMIC_LOAD}	// and not WS2_DLL_TRACE

type
	WS2StubEntry = record
		StubProc : Pointer;
		ProcVar : PPointer;
		Name : PChar;
	end;
	
function WS2Call( AStubEntryIndex : DWORD ) : Pointer; forward;

{$include ws2stubtable.inc}	

function WS2Call( AStubEntryIndex : DWORD ) : Pointer;
begin
	with WS2StubTable[AStubEntryIndex] do
	begin
		if hWS2Dll=0 then
			raise EWS2StubError.Build( 'Error on call Winsock2 library function '''+Name+'''', WSANOTINITIALISED );
		Result := Windows.GetProcAddress( hWS2Dll, Name );
		ProcVar^ := Result;
	end;
end;

procedure	WS2StubInit;
var i : Integer;
begin
	for i := 0 to WS2StubEntryCount-1 do
		with WS2StubTable[i] do ProcVar^ := StubProc;
end;


function WSAStartup( const wVersionRequired: word; var WSData: TWSAData ): Integer;
begin
	if hWS2Dll=0 then
	begin
		hWS2Dll := LoadLibrary( WINSOCK2_DLL );
		if hWS2Dll=0 then
			raise EWS2StubError.Build( 'Error on loading Winsock2 library ('+WINSOCK2_DLL+')', Windows.GetLastError );
		WS2_WSAStartup := LPFN_WSASTARTUP( Windows.GetProcAddress( hWS2Dll, 'WSAStartup' ) );
	end;
	Result := WS2_WSAStartup( wVersionRequired, WSData );
end;

{$ELSE}	// not WS2_DLL_DYNAMIC_LOAD and not WS2_DLL_TRACE

{$include ws2static.inc}

{$ENDIF} // $IFDEF WS2_DLL_DYNAMIC_LOAD

{$ENDIF} // $IFDEF WS2_DLL_TRACE

