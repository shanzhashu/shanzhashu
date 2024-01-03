{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     �й����Լ��Ŀ���Դ�������������                         }
{                   (C)Copyright 2001-2024 CnPack ������                       }
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

unit CnJSON;
{* |<PRE>
================================================================================
* ������ƣ�������������
* ��Ԫ���ƣ�JSON ��������װ��Ԫ�������� DXE6 ������ JSON ������ĳ���
* ��Ԫ���ߣ�CnPack ������ Liu Xiao
* ��    ע���ʺ� UTF8 ��ע�͸�ʽ������ RFC 7159 ������
*           ע��δ���ϸ�ȫ����ԣ����ʺ���� System.JSON
*           ������ System.JSON �ĵͰ汾�г䵱 JSON ��������װ��
*
*           һ�� JSON ��һ�� JSONObject������һ������ Key Value �ԣ�
*           Key ���ַ�����Value ���������ֵͨ��JSONObject �� JSONArray��
*           JSONArray ��һ�� JSONValue
*
*           ������
*              ���ú��� CnJSONParse������ UTF8 ��ʽ�� JSONString������ JSONObject ����
*
*           ��װ��
*              ���� TCnJSONObject ������� AddPair ����
*              ��Ҫ����ʱ���� TCnJSONArray ������� AddValue ����
*              �� TCnJSONObject ���� ToJSON ���������� UTF8 ��ʽ�� JSON �ַ���
*
* ����ƽ̨��PWin7 + Delphi 7
* ���ݲ��ԣ�PWin7 + Delphi 2009 ~
* �� �� �����õ�Ԫ�е��ַ��������ϱ��ػ�����ʽ
* �޸ļ�¼��2023.09.15 V1.0
*                ������Ԫ
================================================================================
|</PRE>}

interface

{$I CnPack.inc}

uses
  Classes, SysUtils, Variants, Contnrs, TypInfo, CnStrings;

type
  ECnJSONException = class(Exception);
  {* JSON ��������쳣}

  TCnJSONTokenType = (jttObjectBegin, jttObjectEnd, jttArrayBegin, jttArrayEnd,
    jttNameValueSep, jttElementSep, jttNumber, jttString, jttNull, jttTrue,
    jttFalse, jttBlank, jttTerminated, jttUnknown);
  {* JSON �еķ������ͣ���Ӧ������š��Ҵ����š��������š��������š��ֺš����š�
    ���֡�˫�����ַ�����null��true��false���ո�س���#0��δ֪��}

  TCnJSONParser = class
  {* UTF8 ��ʽ����ע�͵� JSON �ַ���������}
  private
    FRun: Integer;
    FTokenPos: Integer;
    FOrigin: PAnsiChar;
    FStringLen: Integer; // ��ǰ�ַ������ַ�����
    FProcTable: array[#0..#255] of procedure of object;
    FTokenID: TCnJSONTokenType;

    procedure KeywordProc;               // null true false ���ʶ��
    procedure ObjectBeginProc;           // {
    procedure ObjectEndProc;             // }
    procedure ArrayBeginProc;            // []
    procedure ArrayEndProc;              // ]
    procedure NameValueSepProc;          // :
    procedure ArrayElementSepProc;       // ,
    procedure StringProc;                // ˫����
    procedure NumberProc;                // ����
    procedure BlankProc;                 // �ո� Tab �س���
    procedure TerminateProc;             // #0
    procedure UnknownProc;               // δ֪
    function GetToken: AnsiString;
    procedure SetOrigin(const Value: PAnsiChar);
    procedure SetRunPos(const Value: Integer);
    function GetTokenLength: Integer;
  protected
    function TokenEqualStr(Org: PAnsiChar; const Str: AnsiString): Boolean;
    procedure MakeMethodTable;
    procedure StepRun; {$IFDEF SUPPORT_INLINE} inline; {$ENDIF}
    procedure StepBOM;
  public
    constructor Create; virtual;
    {* ���캯��}
    destructor Destroy; override;
    {* ��������}

    procedure Next;
    {* ������һ�� Token ��ȷ�� TokenID}
    procedure NextNoJunk;
    {* ������һ���� Null �Լ��ǿո� Token ��ȷ�� TokenID}

    property Origin: PAnsiChar read FOrigin write SetOrigin;
    {* �������� UTF8 ��ʽ�� JSON �ַ�������}
    property RunPos: Integer read FRun write SetRunPos;
    {* ��ǰ����λ������� FOrigin ������ƫ��������λΪ�ֽ�����0 ��ʼ}
    property TokenID: TCnJSONTokenType read FTokenID;
    {* ��ǰ Token ����}
    property Token: AnsiString read GetToken;
    {* ��ǰ Token �� UTF8 �ַ������ݲ���������}
    property TokenLength: Integer read GetTokenLength;
    {* ��ǰ Token ���ֽڳ���}
  end;

  TCnJSONString = class;

  TCnJSONPair = class;

  TCnJSONBase = class(TPersistent)
  {* JSON �еĸ�Ԫ�صĻ���}
  private
    FParent: TCnJSONBase;
  protected
    function AddChild(AChild: TCnJSONBase): TCnJSONBase; virtual;
    {* ������ JSON ʱ��Ԫ��ƴװ�ã�һ�㲻��Ҫ���û�����}
  public

    function ToJSON(UseFormat: Boolean = True; Indent: Integer = 0): AnsiString; virtual; abstract;
    property Parent: TCnJSONBase read FParent write FParent;
  end;

  TCnJSONValue = class(TCnJSONBase)
  {* ���� JSON �е�ֵ����}
  private
    FContent: AnsiString;
    // ����ʱ�洢 JSON �н������� UTF8 ԭʼ���ݣ���װʱ�� UTF8 �� JSON �ַ�������
    procedure SetContent(const Value: AnsiString);
  protected
    FUpdated: Boolean;
  public
    constructor Create; virtual;
    {* ���캯��}
    destructor Destroy; override;
    {* ��������}

    procedure Assign(Source: TPersistent); override;
    {* ��ֵ����}

    // ���·�����װ��
    function ToJSON(UseFormat: Boolean = True; Indent: Integer = 0): AnsiString; override;

    // ���·�������ʱ�ж�������
    function IsObject: Boolean; virtual;
    function IsArray: Boolean; virtual;
    function IsString: Boolean; virtual;
    function IsNumber: Boolean; virtual;
    function IsNull: Boolean; virtual;
    function IsTrue: Boolean; virtual;
    function IsFalse: Boolean; virtual;

    // ���·�������ʱȡֵ��
    function AsString: string; virtual;
    function AsInteger: Integer; virtual;
    function AsInt64: Int64; virtual;
    function AsFloat: Extended; virtual;
    function AsBoolean: Boolean; virtual;

    property Content: AnsiString read FContent write SetContent;
    {* ��ֵͨ����ʱ����ԭʼ UTF8 ��ʽ���ַ�������}
  end;

{
  object = begin-object [ member *( value-separator member ) ]
           end-object

  member = string name-separator value
}
  TCnJSONObject = class(TCnJSONValue)
  {* ���� JSON �еĶ���ֵ���࣬Ҳ�� JSON ������}
  private
    FPairs: TObjectList;
    function GetCount: Integer;
    function GetName(Index: Integer): TCnJSONString;
    function GetValue(Index: Integer): TCnJSONValue;
    function GetValueByName(const Name: string): TCnJSONValue;
  protected
    function AddChild(AChild: TCnJSONBase): TCnJSONBase; override;
    {* ���ڲ�����ʱ��� Pair}
  public
    constructor Create; override;
    {* ���캯��}
    destructor Destroy; override;
    {* ��������}

    procedure Assign(Source: TPersistent); override;
    {* ��ֵ����}

    procedure Clear;
    {* �����������}

    // ���·�����װ��
    function AddPair(const Name: string; Value: TCnJSONValue): TCnJSONPair; overload;
    function AddPair(const Name: string; const Value: string): TCnJSONPair; overload;
    function AddPair(const Name: string; Value: Integer): TCnJSONPair; overload;
    function AddPair(const Name: string; Value: Int64): TCnJSONPair; overload;
    function AddPair(const Name: string; Value: Extended): TCnJSONPair; overload;
    function AddPair(const Name: string; Value: Boolean): TCnJSONPair; overload;
    function AddPair(const Name: string): TCnJSONPair; overload;

    function ToJSON(UseFormat: Boolean = True; Indent: Integer = 0): AnsiString; override;
    {* ���� UTF8 ��ʽ�� JSON �ַ���}

    // ���·���������
    function IsObject: Boolean; override;

    class function FromJSON(const JsonStr: AnsiString): TCnJSONObject;
    {* ���� UTF8 ��ʽ�� JSON �ַ����������¶���}

    procedure GetNames(OutNames: TStrings);
    {* �� Name Value �Ե� Name ���� OutNames �б�}
    property Count: Integer read GetCount;
    {* �ж��ٸ� Name Value ��}

    property Names[Index: Integer]: TCnJSONString read GetName;
    {* ���ƶ�������}
    property Values[Index: Integer]: TCnJSONValue read GetValue;
    {* ֵ����������ע��ֵ������ TCnJSONValue �Ĳ�ͬ����ʵ��}
    property ValueByName[const Name: string]: TCnJSONValue read GetValueByName; default;
    {* �������ƻ�ȡֵ��ʵ��}
  end;

  TCnJSONValueClass = class of TCnJSONValue;

{
  string = quotation-mark *char quotation-mark
}
  TCnJSONString = class(TCnJSONValue)
  {* ���� JSON �е��ַ���ֵ����}
  private
    FValue: string;
    // �� Content ͬ���� string ��ʽ����
    procedure SetValue(const Value: string);

    function JsonFormatToString(const Str: AnsiString): string;
    {* �� JSON �е����ݽ���ת��󷵻أ�����ȥ���š�����ת���}
    function StringToJsonFormat(const Str: string): AnsiString;
    {* ���ַ�������˫������ת��󷵻�Ϊ JSON ��ʽ���ڲ����� UTF8 ת��}
  public
    function IsString: Boolean; override;
    function AsString: string; override;
    {* ���� Content ֵ���� Value ������}

    property Value: string read FValue write SetValue;
    {* ��װʱ�����д��ֵ���ڲ�ͬ������ Content}
  end;

  TCnJSONNumber = class(TCnJSONValue)
  {* ���� JSON �е�����ֵ����}
  private

  public
    function IsNumber: Boolean; override;
  end;

  TCnJSONNull = class(TCnJSONValue)
  {* ���� JSON �еĿ�ֵ��}
  private

  public
    constructor Create; override;
    function IsNull: Boolean; override;
  end;

  TCnJSONTrue = class(TCnJSONValue)
  {* ���� JSON �е���ֵ����}
  private

  public
    constructor Create; override;
    function IsTrue: Boolean; override;
  end;

  TCnJSONFalse = class(TCnJSONValue)
  {* ���� JSON �еļ�ֵ����}
  private

  public
    constructor Create; override;
    function IsFalse: Boolean; override;
  end;

{
  array = begin-array [ value *( value-separator value ) ] end-array
}
  TCnJSONArray = class(TCnJSONValue)
  {* ���� JSON �е�������}
  private
    FValues: TObjectList;
    function GetCount: Integer;
    function GetValues(Index: Integer): TCnJSONValue;
  protected
    function AddChild(AChild: TCnJSONBase): TCnJSONBase; override;
    {* �ڲ���� Value ��Ϊ����Ԫ��}
  public
    constructor Create; override;
    {* ���캯��}
    destructor Destroy; override;
    {* ��������}

    procedure Assign(Source: TPersistent); override;
    {* ��ֵ����}

    procedure Clear;
    {* �����������}

    // �ⲿ��װ��
    function AddValue(Value: TCnJSONValue): TCnJSONArray; overload;
    function AddValue(const Value: string): TCnJSONArray; overload;
    function AddValue(Value: Integer): TCnJSONArray; overload;
    function AddValue(Value: Extended): TCnJSONArray; overload;
    function AddValue(Value: Boolean): TCnJSONArray; overload;
    function AddValue: TCnJSONArray; overload;

    function ToJSON(UseFormat: Boolean = True; Indent: Integer = 0): AnsiString; override;
    {* ���� UTF8 ��ʽ�� JSON �ַ���}

    property Count: Integer read GetCount;
    {* �������Ԫ������}
    property Values[Index: Integer]: TCnJSONValue read GetValues;
    {* �������Ԫ��}
  end;

  TCnJSONPair = class(TCnJSONBase)
  {* ���� JSON �� Object �ڵ� Name �� Value �������}
  private
    FName: TCnJSONString;
    FValue: TCnJSONValue;
  protected
    function AddChild(AChild: TCnJSONBase): TCnJSONBase; override;
    {* ���� AChild ��Ϊ�� Value}
  public
    constructor Create; virtual;
    {* ���캯��}
    destructor Destroy; override;
    {* ��������}

    procedure Assign(Source: TPersistent); override;
    {* ��ֵ����}

    function ToJSON(UseFormat: Boolean = True; Indent: Integer = 0): AnsiString; override;
    {* ���� UTF8 ��ʽ�� JSON �ַ���}

    property Name: TCnJSONString read FName;
    {* �������Զ����������У��������ͷ�}
    property Value: TCnJSONValue read FValue write FValue;
    {* ֵ�����Զ��������ⲿ���������ã��������ͷ�}
  end;

  TCnJSONReader = class
  private
    procedure Read(Instance: TPersistent; Obj: TCnJSONObject);
    procedure ReadCollection(Instance: TPersistent; Obj: TCnJSONObject);
  public
    class procedure LoadFromFile(Instance: TPersistent; const FileName: string);
    class procedure LoadFromJSON(Instance: TPersistent; const JSON: AnsiString);
  end;

  TCnJSONWriter = class
  private
    procedure WriteNameValue(Obj: TCnJSONObject; const Name, Value: string);
    procedure WriteProperty(Instance: TPersistent; PropInfo: PPropInfo; Obj: TCnJSONObject);
    procedure Write(Instance: TPersistent; Obj: TCnJSONObject);
  public
    class procedure SaveToFile(Instance: TPersistent; const FileName: string;
      Utf8Bom: Boolean = True);
    class function SaveToJSON(Instance: TPersistent): AnsiString;
  end;

function CnJSONParse(const JsonStr: AnsiString): TCnJSONObject;
{* ���� UTF8 ��ʽ�� JSON �ַ���Ϊ JSON ����}

implementation

{$IFNDEF UNICODE}
uses
  CnWideStrings;
{$ENDIF}

const
  CN_BLANK_CHARSET: set of AnsiChar = [#9, #10, #13, #32]; // RFC �淶��ֻ�����⼸����Ϊ�հ׷�
  CN_INDENT_DELTA = 4; // ���ʱ�������ո�
  CRLF = #13#10;

resourcestring
  SCnErrorJSONTokenFmt = 'JSON Token %s Expected at Offset %d';
  SCnErrorJSONValueFmt = 'JSON Value Error %s at Offset %d';
  SCnErrorJSONPair = 'JSON Pair Value Conflict';
  SCnErrorJSONTypeMismatch = 'JSON Value Type Mismatch';
  SCnErrorJSONStringParse = 'JSON String Parse Error';

function JSONDateTimeToStr(Value: TDateTime): string;
begin
  if Trunc(Value) = 0 then
    Result := FormatDateTime('''hh:mm:ss.zzz''', Value)
  else if Frac(Value) = 0 then
    Result := FormatDateTime('''yyyy-mm-dd''', Value)
  else
    Result := FormatDateTime('''yyyy-mm-dd hh:mm:ss.zzz''', Value);
end;

// ע�⣬ÿ�� JSONParseXXXX ����ִ�����P �� TokenID ��ָ�����Ԫ�غ���ڵķǿ�Ԫ��

function JSONParseValue(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONValue; forward;

function JSONParseObject(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONObject; forward;

procedure JSONCheckToken(P: TCnJSONParser; ExpectedToken: TCnJSONTokenType);
begin
  if P.TokenID <> ExpectedToken then
    raise ECnJSONException.CreateFmt(SCnErrorJSONTokenFmt,
      [GetEnumName(TypeInfo(TCnJSONTokenType), Ord(ExpectedToken)), P.RunPos]);
end;

// �����������ַ���ʱ���ã�Current ���ⲿ�ĸ�����
function JSONParseString(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONString;
begin
  Result := TCnJSONString.Create;
  Result.Content := P.Token;
  Current.AddChild(Result);
  P.NextNoJunk;
end;

// ��������������ʱ���ã�Current ���ⲿ�ĸ�����
function JSONParseNumber(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONNumber;
begin
  Result := TCnJSONNumber.Create;
  Result.Content := P.Token;
  Current.AddChild(Result);
  P.NextNoJunk;
end;

// ���������� null ʱ���ã�Current ���ⲿ�ĸ�����
function JSONParseNull(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONNull;
begin
  Result := TCnJSONNull.Create;
  Result.Content := P.Token;
  Current.AddChild(Result);
  P.NextNoJunk;
end;

// ���������� true ʱ���ã�Current ���ⲿ�ĸ�����
function JSONParseTrue(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONTrue;
begin
  Result := TCnJSONTrue.Create;
  Result.Content := P.Token;
  Current.AddChild(Result);
  P.NextNoJunk;
end;

// ���������� false ʱ���ã�Current ���ⲿ�ĸ�����
function JSONParseFalse(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONFalse;
begin
  Result := TCnJSONFalse.Create;
  Result.Content := P.Token;
  Current.AddChild(Result);
  P.NextNoJunk;
end;

// �������������鿪ʼ���� [ ʱ���ã�Current ���ⲿ�ĸ�����
function JSONParseArray(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONArray;
begin
  Result := TCnJSONArray.Create;
  P.NextNoJunk;

  Current.AddChild(Result);
  while P.TokenID <> jttTerminated do
  begin
    JSONParseValue(P, Result);
    if P.TokenID = jttElementSep then
    begin
      P.NextNoJunk;
      Continue;
    end
    else
      Break;
  end;

  JSONCheckToken(P, jttArrayEnd);
  P.NextNoJunk;
end;

function JSONParseValue(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONValue;
begin
  case P.TokenID of
    jttObjectBegin:
      Result := JSONParseObject(P, Current);
    jttString:
      Result := JSONParseString(P, Current);
    jttNumber:
      Result := JSONParseNumber(P, Current);
    jttArrayBegin:
      Result := JSONParseArray(P, Current);
    jttNull:
      Result := JSONParseNull(P, Current);
    jttTrue:
      Result := JSONParseTrue(P, Current);
    jttFalse:
      Result := JSONParseFalse(P, Current);
  else
    raise ECnJSONException.CreateFmt(SCnErrorJSONValueFmt,
      [GetEnumName(TypeInfo(TCnJSONTokenType), Ord(P.TokenID)), P.RunPos]);
  end;
end;

// ���������� { ʱ���ã�Ҫ�� Current ���ⲿ������ JSONObject ����
function JSONParseObject(P: TCnJSONParser; Current: TCnJSONBase): TCnJSONObject;
var
  Pair: TCnJSONPair;
begin
  Result := TCnJSONObject.Create;
  P.NextNoJunk;
  if Current <> nil then
    Current.AddChild(Result);

  while P.TokenID <> jttTerminated do
  begin
    // ����һ�� String
    JSONCheckToken(P, jttString);

    Pair := TCnJSONPair.Create;
    Pair.Name.Content := P.Token;            // ���á�Pair ���е� Name ������
    Result.AddChild(Pair);

    // ����һ��ð��
    P.NextNoJunk;
    JSONCheckToken(P, jttNameValueSep);

    P.NextNoJunk;
    JSONParseValue(P, Pair);
    // ����һ�� Value

    if P.TokenID = jttElementSep then        // �ж��ŷָ���˵������һ�� Key Value ��
    begin
      P.NextNoJunk;
      Continue;
    end
    else
      Break;
  end;

  JSONCheckToken(P, jttObjectEnd);
  P.NextNoJunk;
end;

function CnJSONParse(const JsonStr: AnsiString): TCnJSONObject;
var
  P: TCnJSONParser;
begin
  Result := nil;
  P := TCnJSONParser.Create;
  try
    P.SetOrigin(PAnsiChar(JsonStr));

    while P.TokenID <> jttTerminated do
    begin
      if P.TokenID = jttObjectBegin then
      begin
        Result := JSONParseObject(P, nil);
        Exit;
      end;

      P.NextNoJunk;
    end;
  finally
    P.Free;
  end;
end;

{ TCnJSONParser }

procedure TCnJSONParser.ArrayBeginProc;
begin
  StepRun;
  FTokenID := jttArrayBegin;
end;

procedure TCnJSONParser.ArrayElementSepProc;
begin
  StepRun;
  FTokenID := jttElementSep;
end;

procedure TCnJSONParser.ArrayEndProc;
begin
  StepRun;
  FTokenID := jttArrayEnd;
end;

procedure TCnJSONParser.BlankProc;
begin
  repeat
    StepRun;
  until not (FOrigin[FRun] in CN_BLANK_CHARSET);
  FTokenID := jttBlank;
end;

constructor TCnJSONParser.Create;
begin
  inherited Create;
  MakeMethodTable;
end;

destructor TCnJSONParser.Destroy;
begin

  inherited;
end;

function TCnJSONParser.GetToken: AnsiString;
var
  Len: Cardinal;
  OutStr: AnsiString;
begin
  Len := FRun - FTokenPos;                         // ����ƫ����֮���λΪ�ַ���
  SetString(OutStr, (FOrigin + FTokenPos), Len);   // ��ָ���ڴ��ַ�볤�ȹ����ַ���
  Result := OutStr;
end;

function TCnJSONParser.GetTokenLength: Integer;
begin
  Result := FRun - FTokenPos;
end;

procedure TCnJSONParser.KeywordProc;
begin
  FStringLen := 0;
  repeat
    StepRun;
    Inc(FStringLen);
  until not (FOrigin[FRun] in ['a'..'z']); // �ҵ�Сд��ĸ��ϵı�ʶ��β��

  FTokenID := jttUnknown; // ����ô��
  if (FStringLen = 5) and TokenEqualStr(FOrigin + FRun - FStringLen, 'false') then
    FTokenID := jttFalse
  else if FStringLen = 4 then
  begin
    if TokenEqualStr(FOrigin + FRun - FStringLen, 'true') then
      FTokenID := jttTrue
    else if TokenEqualStr(FOrigin + FRun - FStringLen, 'null') then
      FTokenID := jttNull;
  end;
end;

procedure TCnJSONParser.MakeMethodTable;
var
  I: AnsiChar;
begin
  for I := #0 to #255 do
  begin
    case I of
      #0:
        FProcTable[I] := TerminateProc;
      #9, #10, #13, #32:
        FProcTable[I] := BlankProc;
      '"':
        FProcTable[I] := StringProc;
      '0'..'9', '+', '-':
        FProcTable[I] := NumberProc;
      '{':
        FProcTable[I] := ObjectBeginProc;
      '}':
        FProcTable[I] := ObjectEndProc;
      '[':
        FProcTable[I] := ArrayBeginProc;
      ']':
        FProcTable[I] := ArrayEndProc;
      ':':
        FProcTable[I] := NameValueSepProc;
      ',':
        FProcTable[I] := ArrayElementSepProc;
      'f', 'n', 't':
        FProcTable[I] := KeywordProc;
    else
      FProcTable[I] := UnknownProc;
    end;
  end;
end;

procedure TCnJSONParser.NameValueSepProc;
begin
  StepRun;
  FTokenID := jttNameValueSep;
end;

procedure TCnJSONParser.Next;
begin
  FTokenPos := FRun;
  FProcTable[FOrigin[FRun]];
end;

procedure TCnJSONParser.NextNoJunk;
begin
  repeat
    Next;
  until not (FTokenID in [jttBlank]);
end;

procedure TCnJSONParser.NumberProc;
begin
  repeat
    StepRun;
  until not (FOrigin[FRun] in ['0'..'9', '.', 'e', 'E']); // ���Ų����ٳ����ˣ��ܳ��� e ���ֿ�ѧ������
  FTokenID := jttNumber;
end;

procedure TCnJSONParser.ObjectBeginProc;
begin
  StepRun;
  FTokenID := jttObjectBegin;
end;

procedure TCnJSONParser.ObjectEndProc;
begin
  StepRun;
  FTokenID := jttObjectEnd;
end;

procedure TCnJSONParser.SetOrigin(const Value: PAnsiChar);
begin
  FOrigin := Value;
  FRun := 0;
  StepBOM;
  Next;
end;

procedure TCnJSONParser.SetRunPos(const Value: Integer);
begin
  FRun := Value;
  Next;
end;

procedure TCnJSONParser.StepBOM;
begin
  if (FOrigin[FRun] <> #239) or (FOrigin[FRun + 1] = #0) then
    Exit;
  if (FOrigin[FRun + 1] <> #187) or (FOrigin[FRun + 2] = #0) then
    Exit;
  if FOrigin[FRun + 2] <> #191 then
    Exit;

  Inc(FRun, 3);
end;

procedure TCnJSONParser.StepRun;
begin
  Inc(FRun);
end;

procedure TCnJSONParser.StringProc;
begin
  StepRun;
  FTokenID := jttString;
  // Ҫ���� UTF8 �ַ�����ҲҪ����ת���ַ��� \ ��� " \ / b f n r t u ֱ�������� " Ϊֹ
  while FOrigin[FRun] <> '"' do
  begin
    StepRun;
    if FOrigin[FRun] = '\' then
    begin
      StepRun;
      if FOrigin[FRun] = '"' then   // \" ���⴦���Ա����жϽ������󣬵�Ҫע�� UTF8 �ĺ����ַ����ܳ�������
        StepRun;
    end;
  end;
  StepRun;
end;

procedure TCnJSONParser.TerminateProc;
begin
  FTokenID := jttTerminated;
end;

function TCnJSONParser.TokenEqualStr(Org: PAnsiChar; const Str: AnsiString): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Length(Str) - 1 do
  begin
    if Org[I] <> Str[I + 1] then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

procedure TCnJSONParser.UnknownProc;
begin
  StepRun;
  FTokenID := jttUnknown;
end;

{ TCnJSONObject }

function TCnJSONObject.AddChild(AChild: TCnJSONBase): TCnJSONBase;
begin
  if AChild is TCnJSONPair then
  begin
    FPairs.Add(AChild);
    AChild.Parent := Self;
    Result := AChild;
  end
  else
    Result := nil;
end;

function TCnJSONObject.AddPair(const Name: string; Value: Integer): TCnJSONPair;
var
  V: TCnJSONNumber;
begin
  V := TCnJSONNumber.Create;
  V.Content := IntToStr(Value);
  Result := AddPair(Name, V);
end;

function TCnJSONObject.AddPair(const Name, Value: string): TCnJSONPair;
var
  V: TCnJSONString;
begin
  V := TCnJSONString.Create;
  V.Value := Value;
  Result := AddPair(Name, V);
end;

function TCnJSONObject.AddPair(const Name: string; Value: TCnJSONValue): TCnJSONPair;
begin
  Result := TCnJSONPair.Create;
  AddChild(Result);
  Result.Name.Content := Name;
  Result.Value := Value;
end;

function TCnJSONObject.AddPair(const Name: string): TCnJSONPair;
begin
  Result := AddPair(Name, TCnJSONNull.Create);
end;

function TCnJSONObject.AddPair(const Name: string; Value: Boolean): TCnJSONPair;
begin
  if Value then
    Result := AddPair(Name, TCnJSONTrue.Create)
  else
    Result := AddPair(Name, TCnJSONFalse.Create);
end;

function TCnJSONObject.AddPair(const Name: string; Value: Extended): TCnJSONPair;
var
  V: TCnJSONNumber;
begin
  V := TCnJSONNumber.Create;
  V.Content := FloatToStr(Value);
  Result := AddPair(Name, V);
end;

function TCnJSONObject.AddPair(const Name: string; Value: Int64): TCnJSONPair;
var
  V: TCnJSONNumber;
begin
  V := TCnJSONNumber.Create;
  V.Content := IntToStr(Value);
  Result := AddPair(Name, V);
end;

procedure TCnJSONObject.Assign(Source: TPersistent);
var
  I: Integer;
  JObj: TCnJSONObject;
  Pair: TCnJSONPair;
begin
  if Source is TCnJSONObject then
  begin
    JObj := Source as TCnJSONObject;
    FPairs.Clear;

    for I := 0 to JObj.Count - 1 do
    begin
      Pair := TCnJSONPair.Create;
      Pair.Assign(TCnJSONPair(JObj.FPairs[I]));
      FPairs.Add(Pair);
    end;
  end
  else
    inherited;
end;

procedure TCnJSONObject.Clear;
begin
  FPairs.Clear;
end;

constructor TCnJSONObject.Create;
begin
  inherited;
  FPairs := TObjectList.Create(True);
end;

destructor TCnJSONObject.Destroy;
begin
  FPairs.Free;
  inherited;
end;

class function TCnJSONObject.FromJSON(const JsonStr: AnsiString): TCnJSONObject;
begin
  Result := CnJSONParse(JsonStr);
end;

function TCnJSONObject.GetCount: Integer;
begin
  Result := FPairs.Count;
end;

function TCnJSONObject.GetName(Index: Integer): TCnJSONString;
begin
  Result := (FPairs[Index] as TCnJSONPair).Name;
end;

procedure TCnJSONObject.GetNames(OutNames: TStrings);
var
  I: Integer;
begin
  if OutNames <> nil then
  begin
    OutNames.Clear;
    for I := 0 to Count - 1 do
      OutNames.Add((FPairs[I] as TCnJSONPair).Name.AsString);
  end;
end;

function TCnJSONObject.GetValue(Index: Integer): TCnJSONValue;
begin
  Result := (FPairs[Index] as TCnJSONPair).Value;
end;

function TCnJSONObject.GetValueByName(const Name: string): TCnJSONValue;
var
  I: Integer;
begin
  for I := 0 to FPairs.Count - 1 do
  begin
    if TCnJSONPair(FPairs[I]).Name.AsString = Name then
    begin
      Result := TCnJSONPair(FPairs[I]).Value;
      Exit;
    end;
  end;
  Result := nil;
end;

function TCnJSONObject.IsObject: Boolean;
begin
  Result := True;
end;

function TCnJSONObject.ToJSON(UseFormat: Boolean; Indent: Integer): AnsiString;
var
  I: Integer;
  Bld: TCnStringBuilder;
begin
  if Indent < 0 then
    Indent := 0;

  Bld := TCnStringBuilder.Create(True);
  try
    if UseFormat then
      Bld.Append('{' + CRLF)
    else
      Bld.AppendAnsiChar('{');

    for I := 0 to Count - 1 do
    begin
      if UseFormat then
        Bld.Append(StringOfChar(' ', Indent + CN_INDENT_DELTA));

{$IFDEF UNICODE}
      Bld.AppendAnsi(Names[I].ToJSON(UseFormat, Indent + CN_INDENT_DELTA));
      // Ҫ��ʽ�� Ansi����Ϊ���ݿ����� UTF8�����ܶ������ string ת��
{$ELSE}
      Bld.Append(Names[I].ToJSON(UseFormat, Indent + CN_INDENT_DELTA));
{$ENDIF}

      Bld.AppendAnsiChar(':');
      if UseFormat then
        Bld.AppendAnsiChar(' ');

{$IFDEF UNICODE}
      Bld.AppendAnsi(Values[I].ToJSON(UseFormat, Indent + CN_INDENT_DELTA));
      // Ҫ��ʽ�� Ansi����Ϊ���ݿ����� UTF8�����ܶ������ string ת��
{$ELSE}
      Bld.Append(Values[I].ToJSON(UseFormat, Indent + CN_INDENT_DELTA));
{$ENDIF}

      if I <> Count - 1 then
      begin
        Bld.AppendAnsiChar(',');
        if UseFormat then
          Bld.Append(CRLF);
      end;
    end;

    if UseFormat then
      Bld.Append(CRLF + StringOfChar(' ', Indent) + '}')
    else
      Bld.AppendAnsiChar('}');

    Result := Bld.ToAnsiString;
  finally
    Bld.Free;
  end;
end;

{ TCnJSONValue }

function TCnJSONValue.AsBoolean: Boolean;
begin
  if IsTrue then
    Result := True
  else if IsFalse then
    Result := False
  else
    raise ECnJSONException.Create(SCnErrorJSONTypeMismatch);
end;

function TCnJSONValue.AsFloat: Extended;
begin
  if not IsNumber then
    raise ECnJSONException.Create(SCnErrorJSONTypeMismatch);

  Result := StrToFloat(FContent);
end;

function TCnJSONValue.AsInt64: Int64;
begin
  if not IsNumber then
    raise ECnJSONException.Create(SCnErrorJSONTypeMismatch);

  Result := StrToInt64(FContent);
end;

function TCnJSONValue.AsInteger: Integer;
begin
  if not IsNumber then
    raise ECnJSONException.Create(SCnErrorJSONTypeMismatch);

  Result := StrToInt(FContent);
end;

procedure TCnJSONValue.Assign(Source: TPersistent);
begin
  if Source is TCnJSONValue then
  begin
    Content := (Source as TCnJSONValue).Content;
  end
  else
    inherited;
end;

function TCnJSONValue.AsString: string;
begin
  Result := FContent; // ���෵��ԭʼ����
end;

constructor TCnJSONValue.Create;
begin

end;

destructor TCnJSONValue.Destroy;
begin

  inherited;
end;

function TCnJSONValue.IsArray: Boolean;
begin
  Result := False;
end;

function TCnJSONValue.IsFalse: Boolean;
begin
  Result := False;
end;

function TCnJSONValue.IsNull: Boolean;
begin
  Result := False;
end;

function TCnJSONValue.IsNumber: Boolean;
begin
  Result := False;
end;

function TCnJSONValue.IsObject: Boolean;
begin
  Result := False;
end;

function TCnJSONValue.IsString: Boolean;
begin
  Result := False;
end;

function TCnJSONValue.IsTrue: Boolean;
begin
  Result := False;
end;

procedure TCnJSONValue.SetContent(const Value: AnsiString);
begin
  FContent := Value;
  FUpdated := True;
end;

function TCnJSONValue.ToJSON(UseFormat: Boolean; Indent: Integer): AnsiString;
begin
  // FContent �� UTF8 ��ʽ
  Result := FContent;
end;

{ TCnJSONArray }

function TCnJSONArray.AddChild(AChild: TCnJSONBase): TCnJSONBase;
begin
  if AChild is TCnJSONValue then
  begin
    FValues.Add(AChild);
    AChild.Parent := Self;
    Result := AChild;
  end
  else
    Result := nil;
end;

function TCnJSONArray.AddValue(const Value: string): TCnJSONArray;
var
  V: TCnJSONString;
begin
  V := TCnJSONString.Create;
  V.Value := Value;
  Result := AddValue(V);
end;

function TCnJSONArray.AddValue(Value: TCnJSONValue): TCnJSONArray;
begin
  if Value <> nil then
    FValues.Add(Value);
  Result := Self;
end;

function TCnJSONArray.AddValue(Value: Integer): TCnJSONArray;
var
  V: TCnJSONNumber;
begin
  V := TCnJSONNumber.Create;
  V.Content := IntToStr(Value);
  Result := AddValue(V);
end;

function TCnJSONArray.AddValue(Value: Boolean): TCnJSONArray;
begin
  if Value then
    Result := AddValue(TCnJSONTrue.Create)
  else
    Result := AddValue(TCnJSONFalse.Create)
end;

function TCnJSONArray.AddValue(Value: Extended): TCnJSONArray;
var
  V: TCnJSONNumber;
begin
  V := TCnJSONNumber.Create;
  V.Content := FloatToStr(Value);
  Result := AddValue(V);
end;

function TCnJSONArray.AddValue: TCnJSONArray;
begin
  Result := AddValue(TCnJSONNull.Create);
end;

procedure TCnJSONArray.Assign(Source: TPersistent);
var
  I: Integer;
  Clz: TCnJSONValueClass;
  V: TCnJSONValue;
  Arr: TCnJSONArray;
begin
  if Source is TCnJSONArray then
  begin
    Arr := Source as TCnJSONArray;

    FValues.Clear;
    for I := 0 to Arr.Count - 1 do
    begin
      Clz := TCnJSONValueClass(Arr.Values[I].ClassType);
      V := TCnJSONValue(Clz.NewInstance);
      V.Create;
      V.Assign(Arr.Values[I]);

      AddValue(V);
    end;
  end
  else
    inherited;
end;

procedure TCnJSONArray.Clear;
begin
  FValues.Clear;
end;

constructor TCnJSONArray.Create;
begin
  inherited;
  FValues := TObjectList.Create(True);
end;

destructor TCnJSONArray.Destroy;
begin
  FValues.Free;
  inherited;
end;

function TCnJSONArray.GetCount: Integer;
begin
  Result := FValues.Count;
end;

function TCnJSONArray.GetValues(Index: Integer): TCnJSONValue;
begin
  Result := TCnJSONValue(FValues[Index]);
end;

function TCnJSONArray.ToJSON(UseFormat: Boolean; Indent: Integer): AnsiString;
var
  Bld: TCnStringBuilder;
  I: Integer;
begin
  Bld := TCnStringBuilder.Create(True);
  try
    Bld.AppendAnsiChar('[');
    if UseFormat then
      Bld.Append(CRLF + StringOfChar(' ', Indent + CN_INDENT_DELTA));

    for I := 0 to Count - 1 do
    begin
{$IFDEF UNICODE}
      Bld.AppendAnsi(Values[I].ToJSON(UseFormat, Indent + CN_INDENT_DELTA));
{$ELSE}
      Bld.Append(Values[I].ToJSON(UseFormat, Indent + CN_INDENT_DELTA));
{$ENDIF}
      if I <> Count - 1 then
      begin
        Bld.AppendAnsiChar(',');
        if UseFormat then
          Bld.AppendAnsiChar(' ');
      end;
    end;

    if UseFormat then
    begin
      Bld.Append(CRLF);
      Bld.Append(StringOfChar(' ', Indent) + ']');
    end
    else
      Bld.AppendAnsiChar(']');

    Result := Bld.ToAnsiString;
  finally
    Bld.Free;
  end;
end;

{ TCnJSONPair }

function TCnJSONPair.AddChild(AChild: TCnJSONBase): TCnJSONBase;
begin
  if FValue <> nil then
    raise ECnJSONException.Create(SCnErrorJSONPair);

  if AChild is TCnJSONValue then
  begin
    FValue := AChild as TCnJSONValue;
    AChild.Parent := Self;
    Result := AChild;
  end
  else
    Result := nil;
end;

procedure TCnJSONPair.Assign(Source: TPersistent);
var
  Clz: TCnJSONValueClass;
  Pair: TCnJSONPair;
begin
  if Source is TCnJSONPair then
  begin
    Pair := Source as TCnJSONPair;
    FName.Assign(Pair.Name);

    if Pair.Value <> nil then
    begin
      Clz := TCnJSONValueClass(Pair.Value.ClassType);
      FValue := TCnJSONValue(Clz.NewInstance);
      FValue.Create;
      FValue.Assign(Pair.Value);
    end;
  end
  else
    inherited;
end;

constructor TCnJSONPair.Create;
begin
  inherited;
  FName := TCnJSONString.Create;
  // FValue ���Ͳ�һ�����ȴ���
end;

destructor TCnJSONPair.Destroy;
begin
  FValue.Free;
  FName.Free;
  inherited;
end;

function TCnJSONPair.ToJSON(UseFormat: Boolean; Indent: Integer): AnsiString;
begin
  // ��������Ӧ���õ����
  Result := '';
end;

{ TCnJSONBase }

function TCnJSONBase.AddChild(AChild: TCnJSONBase): TCnJSONBase;
begin
  Result := AChild;
  AChild.Parent := Self;
end;

{ TCnJSONString }

function TCnJSONString.AsString: string;
begin
  if FUpdated then
  begin
    FValue := JsonFormatToString(Content);
    FUpdated := False;
  end;
  Result := FValue;
end;

function TCnJSONString.IsString: Boolean;
begin
  Result := True;
end;

function TCnJSONString.JsonFormatToString(const Str: AnsiString): string;
var
  Bld: TCnStringBuilder;
  P: PWideChar;
  U: Integer;
{$IFDEF UNICODE}
  WS: string;
{$ELSE}
  WS: WideString;
{$ENDIF}
  B0, B1, B2, B3: Byte;

  procedure CheckHex(B: Byte);
  begin
    if not (AnsiChar(B) in ['0'..'9', 'A'..'F', 'a'..'f']) then
      raise ECnJSONException.Create(SCnErrorJSONStringParse);
  end;

  function HexToDec(const Value: Byte): Integer;
  begin
    if Value > Ord('9') then
    begin
      if Value > Ord('F') then
        Result := Value - Ord('a') + 10
      else
        Result := Value - Ord('A') + 10;
    end
    else
      Result := Value - Ord('0');
  end;

begin
  Result := '';
  if Length(Str) = 0 then
    Exit;

  // Unicode ������ʹ��ϵͳ��ת��������ʹ�� CnWideStrings ���ת��
{$IFDEF UNICODE}
  WS := UTF8ToUnicodeString(Str);
{$ELSE}
  WS := CnUtf8DecodeToWideString(Str);
{$ENDIF}

  if Length(WS) = 0 then
    raise ECnJSONException.Create(SCnErrorJSONStringParse); // UTF8 ����ʧ��

  P := @WS[1];
  if P^ <> '"' then
    raise ECnJSONException.Create(SCnErrorJSONStringParse);

  Bld := TCnStringBuilder.Create(False);  // ����˫�ֽ��ַ������� Wide ģʽ
  try
    Inc(P);
    while (P^ <> '"') and (P^ <> #0) do
    begin
      if P^ = '\' then
      begin
        Inc(P);
        case P^ of
          '\': Bld.AppendWideChar('\');
          '"': Bld.AppendWideChar('"');
          'b': Bld.AppendWideChar(#$08);
          't': Bld.AppendWideChar(#$09);
          'n': Bld.AppendWideChar(#$0A);
          'f': Bld.AppendWideChar(#$0C);
          'r': Bld.AppendWideChar(#$0D);
          'u':
            begin
              Inc(P);
              B3 := Ord(P^);
              CheckHex(B3);

              Inc(P);
              B2 := Ord(P^);
              CheckHex(B2);

              Inc(P);
              B1 := Ord(P^);
              CheckHex(B1);

              Inc(P);
              B0 := Ord(P^);
              CheckHex(B0);

              U := (HexToDec(B3) shl 12) or (HexToDec(B2) shl 8) or (HexToDec(B1) shl 4) or HexToDec(B0);
              Bld.AppendWideChar(WideChar(U));
            end;
        else
          raise ECnJSONException.Create(SCnErrorJSONStringParse);
        end;
      end
      else
        Bld.AppendWideChar(P^);
      Inc(P);
    end;

{$IFDEF UNICODE}
    Result := Bld.ToString;
    // Unicode �汾��ʹ�� Wide �汾��ֱ����� string
{$ELSE}
    Result := AnsiString(Bld.ToWideString);
    // �� Unicode ��ǿ��ʹ�� Wide �汾ʱֻ֧����� WideString���ⲿת���� AnsiString
{$ENDIF}
  finally
    Bld.Free;
  end;
end;

procedure TCnJSONString.SetValue(const Value: string);
begin
  FValue := Value;
  Content := StringToJsonFormat(Value);
  FUpdated := False; // �� Value ����Ķ� Content �ĸ��£�Content ��������ȥ���� FValue
end;

function TCnJSONString.StringToJsonFormat(const Str: string): AnsiString;
var
  Bld: TCnStringBuilder;
  P: PChar;
begin
  // �������Լ�ת������� UTF8 ת��
  Bld := TCnStringBuilder.Create;
  try
    Bld.AppendChar('"');
    if Length(Str) > 0 then
    begin
      P := @Str[1];
      while P^ <> #0 do
      begin
        case P^ of
          '\':
            begin
              Bld.AppendChar('\');
              Bld.AppendChar('\');
            end;
          '"':
            begin
              Bld.AppendChar('\');
              Bld.AppendChar('"');
            end;
          #$08:
            begin
              Bld.AppendChar('\');
              Bld.AppendChar('b');
            end;
          #$09:
            begin
              Bld.AppendChar('\');
              Bld.AppendChar('t');
            end;
          #$0A:
            begin
              Bld.AppendChar('\');
              Bld.AppendChar('n');
            end;
          #$0C:
            begin
              Bld.AppendChar('\');
              Bld.AppendChar('f');
            end;
          #$0D:
            begin
              Bld.AppendChar('\');
              Bld.AppendChar('r');
            end;
        else
          Bld.AppendChar(P^);
        end;
        Inc(P);
      end;
    end;

    Bld.AppendChar('"');

{$IFDEF UNICODE}
    Result := UTF8Encode(Bld.ToString);
    // Unicode ������ StringBuilder �ڲ�ʹ�� Wide ģʽ������ UnicodeString��ֱ�ӱ���� UTF8
{$ELSE}
    // �� Unicode ������ StringBuilder �ڲ�ʹ�� Ansi ģʽ������ AnsiString���ڲ�������˫�ֽ��ַ���
    // ת�� WideString ������ UTF8
    Result := CnUtf8EncodeWideString(WideString(Bld.ToString));
{$ENDIF}
  finally
    Bld.Free;
  end;
end;

{ TCnJSONNumber }

function TCnJSONNumber.IsNumber: Boolean;
begin
  Result := True;
end;

{ TCnJSONNull }

constructor TCnJSONNull.Create;
begin
  inherited;
  FContent := 'null';
end;

function TCnJSONNull.IsNull: Boolean;
begin
  Result := True;
end;

{ TCnJSONTrue }

constructor TCnJSONTrue.Create;
begin
  inherited;
  FContent := 'true';
end;

function TCnJSONTrue.IsTrue: Boolean;
begin
  Result := True;
end;

{ TCnJSONFalse }

constructor TCnJSONFalse.Create;
begin
  inherited;
  FContent := 'false';
end;

function TCnJSONFalse.IsFalse: Boolean;
begin
  Result := True;
end;

{ TCnJSONReader }

class procedure TCnJSONReader.LoadFromFile(Instance: TPersistent;
  const FileName: string);
begin

end;

class procedure TCnJSONReader.LoadFromJSON(Instance: TPersistent;
  const JSON: AnsiString);
var
  Obj: TCnJSONObject;
  Reader: TCnJSONReader;
begin
  Obj := nil;
  Reader := nil;

  try
    Obj := CnJSONParse(JSON);
    Reader := TCnJSONReader.Create;

    if Instance is TCollection then
      Reader.ReadCollection(Instance, Obj)
    else
      Reader.Read(Instance, Obj)
  finally
    Reader.Free;
    Obj.Free;
  end;
end;

procedure TCnJSONReader.Read(Instance: TPersistent; Obj: TCnJSONObject);
begin

end;

procedure TCnJSONReader.ReadCollection(Instance: TPersistent; Obj: TCnJSONObject);
begin

end;

{ TCnJSONWriter }

class procedure TCnJSONWriter.SaveToFile(Instance: TPersistent;
  const FileName: string; Utf8Bom: Boolean);
var
  JSON: AnsiString;
  F: TFileStream;
begin
  JSON := SaveToJSON(Instance);
  if JSON = '' then
    Exit;

  // UTF8 ��ʽ�� AnsiString��д BOM ͷ�����ݵ��ļ�
  F := TFileStream.Create(FileName, fmCreate);
  try
    if Utf8Bom then
      F.Write(SCN_BOM_UTF8[0], SizeOf(SCN_BOM_UTF8));
    F.Write(JSON[1], Length(JSON));
  finally
    F.Free;
  end;
end;

class function TCnJSONWriter.SaveToJSON(Instance: TPersistent): AnsiString;
var
  Obj: TCnJSONObject;
  Writer: TCnJSONWriter;
begin
  Obj := nil;
  Writer := nil;

  try
    Obj := TCnJSONObject.Create;
    Writer := TCnJSONWriter.Create;

    Writer.Write(Instance, Obj);
    Result := Obj.ToJSON;
  finally
    Writer.Free;
    Obj.Free;
  end;
end;

procedure TCnJSONWriter.Write(Instance: TPersistent; Obj: TCnJSONObject);
var
  PropCount: Integer;
  PropList: PPropList;
  I: Integer;
  PropInfo: PPropInfo;
  Arr: TCnJSONArray;
  Sub: TCnJSONObject;
begin
  PropCount := GetTypeData(Instance.ClassInfo)^.PropCount;
  if PropCount = 0 then
    Exit;

  GetMem(PropList, PropCount * SizeOf(Pointer));
  try
    GetPropInfos(Instance.ClassInfo, PropList);
    for I := 0 to PropCount - 1 do
    begin
      PropInfo := PropList^[I];
      if PropInfo = nil then
        Break;

      if IsStoredProp(Instance, PropInfo) then
        WriteProperty(Instance, PropInfo, Obj)
    end;
  finally
    FreeMem(PropList, PropCount * SizeOf(Pointer));
  end;

  if Instance is TCollection then
  begin
    Arr := TCnJSONArray.Create;
    Obj.AddPair('Items', Arr);

    for I := 0 to (Instance as TCollection).Count - 1 do
    begin
      Sub := TCnJSONObject.Create;
      Arr.AddChild(Sub);
      Write((Instance as TCollection).Items[I], Sub);
    end;
  end;
end;

procedure TCnJSONWriter.WriteNameValue(Obj: TCnJSONObject; const Name,
  Value: string);
begin
  Obj.AddPair(Name, Value);
end;

procedure TCnJSONWriter.WriteProperty(Instance: TPersistent;
  PropInfo: PPropInfo; Obj: TCnJSONObject);
var
  PropType: PTypeInfo;

  procedure WriteStrProp;
  var
    Value: string;
  begin
    Value := GetStrProp(Instance, PropInfo);
    WriteNameValue(Obj, string(PropInfo^.Name), Value);
  end;

  procedure WriteOrdProp;
  var
    Value: Longint;
  begin
    Value := GetOrdProp(Instance, PropInfo);
    if Value <> PPropInfo(PropInfo)^.Default then
    begin
      case PropType^.Kind of
        tkInteger:
          WriteNameValue(Obj, string(PropInfo^.Name), IntToStr(Value));
        tkChar:
          WriteNameValue(Obj, string(PropInfo^.Name), Chr(Value));
        tkSet:
          WriteNameValue(Obj, string(PropInfo^.Name), GetSetProp(Instance, PPropInfo(PropInfo), True));
        tkEnumeration:
          begin
            if PropType = TypeInfo(Boolean) then
              WriteNameValue(Obj, string(PropInfo^.Name), BoolToStr(Boolean(Value), True))
            else
              WriteNameValue(Obj, string(PropInfo^.Name), GetEnumName(PropType, Value));
          end;
      end;
    end;
  end;

  procedure WriteFloatProp;
  var
    Value: Extended;
  begin
    Value := GetFloatProp(Instance, PropInfo);
    WriteNameValue(Obj, string(PropInfo^.Name), FloatToStr(Value));
  end;

  procedure WriteInt64Prop;
  var
    Value: Int64;
  begin
    Value := GetInt64Prop(Instance, PropInfo);
    WriteNameValue(Obj, string(PropInfo^.Name), IntToStr(Value));
  end;

  procedure WriteObjectProp;
  var
    Value: TObject;
    SubObj: TCnJSONObject;
  begin
    Value := TObject(GetOrdProp(Instance, PropInfo));
    if Value <> nil then
    begin
      if Value is TPersistent then
      begin
        SubObj := TCnJSONObject.Create;
        Obj.AddPair(string(PropInfo^.Name), SubObj);
        Write(TPersistent(Value), SubObj);
      end;
    end;
  end;

begin
  if (PPropInfo(PropInfo)^.SetProc <> nil) and
    (PPropInfo(PropInfo)^.GetProc <> nil) then
  begin
    PropType := PPropInfo(PropInfo)^.PropType^;
    case PropType^.Kind of
      tkInteger, tkChar, tkEnumeration, tkSet:
        WriteOrdProp;
      tkString, tkLString, tkWString {$IFDEF UNICODE}, tkUString {$ENDIF}:
        WriteStrProp;
      tkFloat:
        // ʱ��������ʱ�����⴦���ڲ����ø�������
        WriteFloatProp;
      tkInt64: WriteInt64Prop;
      tkClass: WriteObjectProp;
    end;
  end;
end;

end.
