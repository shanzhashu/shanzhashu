unit CnRandom;

interface

uses
  SysUtils {$IFDEF MSWINDOWS}, Windows {$ENDIF},  Classes;

type
  ECnRandomAPIError = class(Exception);

function CnRandomFillBytes(Buf: PAnsiChar; Len: Integer): Boolean;
{* 使用 Windows API 或 /dev/random 设备实现区块随机填充}

implementation

{$IFDEF MSWINDOWS}

const
  ADVAPI32 = 'advapi32.dll';

  CRYPT_VERIFYCONTEXT = $F0000000;
  CRYPT_NEWKEYSET = $8;
  CRYPT_DELETEKEYSET = $10;

  PROV_RSA_FULL = 1;
  NTE_BAD_KEYSET = $80090016;

function CryptAcquireContext(phProv: PULONG; pszContainer: PAnsiChar;
  pszProvider: PAnsiChar; dwProvType: LongWord; dwFlags: LongWord): BOOL;
  stdcall; external ADVAPI32 name 'CryptAcquireContextA';

function CryptReleaseContext(hProv: ULONG; dwFlags: LongWord): BOOL;
  stdcall; external ADVAPI32 name 'CryptReleaseContext';

function CryptGenRandom(hProv: ULONG; dwLen: LongWord; pbBuffer: PAnsiChar): BOOL;
  stdcall; external ADVAPI32 name 'CryptGenRandom';

{$ENDIF}

function CnRandomFillBytes(Buf: PAnsiChar; Len: Integer): Boolean;
var
{$IFDEF MSWINDOWS}
  HProv: THandle;
  Res: LongWord;
{$ELSE}
  F: TFileStream;
{$ENDIF}
begin
  Result := False;
{$IFDEF MSWINDOWS}
  // 使用 Windows API 实现区块随机填充
  HProv := 0;
  if not CryptAcquireContext(@HProv, nil, nil, PROV_RSA_FULL, 0) then
  begin
    Res := GetLastError;
    if Res = NTE_BAD_KEYSET then // KeyContainer 不存在，用新建的方式
    begin
      if not CryptAcquireContext(@HProv, nil, nil, PROV_RSA_FULL, CRYPT_NEWKEYSET) then
        raise ECnRandomAPIError.CreateFmt('Error CryptAcquireContext NewKeySet $%8.8x', [GetLastError]);
    end
    else
        raise ECnRandomAPIError.CreateFmt('Error CryptAcquireContext $%8.8x', [Res]);
  end;

  if HProv <> 0 then
  begin
    try
      Result := CryptGenRandom(HProv, Len, Buf);
      if not Result then
        raise ECnRandomAPIError.CreateFmt('Error CryptGenRandom $%8.8x', [GetLastError]);
    finally
      CryptReleaseContext(HProv, 0);
    end;
  end;
{$ELSE}
  // MacOS 下的随机填充实现，采用读取 /dev/random 内容的方式
  F := nil;
  try
    F := TFileStream.Create('/dev/random', fmOpenRead);
    Result := F.Read(Buf^, Len) = Len;
  finally
    F.Free;
  end;
{$ENDIF}
end;

end.
