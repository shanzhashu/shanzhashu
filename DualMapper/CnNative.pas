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

unit CnNative;
{* |<PRE>
================================================================================
* ������ƣ�CnPack �����
* ��Ԫ���ƣ�32 λ�� 64 λ��һЩͳһ�����Լ�һ�ѻ���ʵ��
* ��Ԫ���ߣ���Х (liuxiao@cnpack.org)
* ��    ע��Delphi XE 2 ֧�� 32 �� 64 ���������ų��� NativeInt �� NativeUInt ��
*           ��ǰ�� 32 λ���� 64 ����̬�仯��Ӱ�쵽���� Pointer��Reference�ȶ�����
*           ���ǵ������ԣ��̶����ȵ� 32 λ Cardinal/Integer �Ⱥ� Pointer ��Щ��
*           ������ͨ���ˣ���ʹ 32 λ��Ҳ����������ֹ����˱���Ԫ�����˼������ͣ�
*           ��ͬʱ�ڵͰ汾�͸߰汾�� Delphi ��ʹ�á�
*           �������� UInt64 �İ�װ��ע�� D567 �²�ֱ��֧�� UInt64 �����㣬��Ҫ��
*           ��������ʵ�֣�Ŀǰʵ���� div �� mod
*           �����ַ���� Integer(APtr) �� 64 λ�������� MacOS �����׳��ֽضϣ���Ҫ�� NativeInt
* ����ƽ̨��PWin2000 + Delphi 5.0
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6/7 XE 2
* �� �� �����õ�Ԫ�е��ַ��������ϱ��ػ�����ʽ
* �޸ļ�¼��2022.11.11 V2.3
*               ���ϼ����޷��������ֽ�˳���������
*           2022.07.23 V2.2
*               ���Ӽ����ڴ�λ���㺯���������ת���ַ���������������Ϊ CnNative
*           2022.06.08 V2.1
*               �����ĸ�ʱ��̶��Ľ��������Լ��ڴ浹�ź���
*           2022.03.14 V2.0
*               ���Ӽ���ʮ������ת������
*           2022.02.17 V1.9
*               ���� FPC �ı���֧��
*           2022.02.09 V1.8
*               ���������ڵĴ�С���жϺ���
*           2021.09.05 V1.7
*               ���� Int64/UInt64 ������������������㺯��
*           2020.10.28 V1.6
*               ���� UInt64 �����ص��ж������㺯��
*           2020.09.06 V1.5
*               ������ UInt64 ����ƽ�����ĺ���
*           2020.07.01 V1.5
*               �����ж� 32 λ�� 64 λ���޷���������Ƿ�����ĺ���
*           2020.06.20 V1.4
*               ���� 32 λ�� 64 λ��ȡ�������͵� 1 λλ�õĺ���
*           2020.01.01 V1.3
*               ���� 32 λ�޷������͵� mul ���㣬�ڲ�֧�� UInt64 ��ϵͳ���� Int64 �����Ա������
*           2018.06.05 V1.2
*               ���� 64 λ���͵� div/mod ���㣬�ڲ�֧�� UInt64 ��ϵͳ���� Int64 ���� 
*           2016.09.27 V1.1
*               ���� 64 λ���͵�һЩ����
*           2011.07.06 V1.0
*               ������Ԫ��ʵ�ֹ���
================================================================================
|</PRE>}

interface

{$I CnPack.inc}

uses
  Classes, SysUtils, SysConst, Math {$IFDEF COMPILER5}, Windows {$ENDIF};
                                    // D5 ����Ҫ���� Windows �е� PByte
type
{$IFDEF COMPILER5}
  PCardinal = ^Cardinal;
  {* D5 �� System ��Ԫ��δ���壬������}
  PByte = Windows.PByte;
  {* D5 �� PByte ������ Windows �У������汾������ System �У�
    ����ͳһһ�¹����ʹ�� PByte ʱ���� uses Windows���������ڿ�ƽ̨}
{$ENDIF}

{$IFDEF SUPPORT_32_AND_64}
  TCnNativeInt     = NativeInt;
  TCnNativeUInt    = NativeUInt;
  TCnNativePointer = NativeInt;
  TCnNativeIntPtr  = PNativeInt;
  TCnNativeUIntPtr = PNativeUInt;
{$ELSE}
  TCnNativeInt     = Integer;
  TCnNativeUInt    = Cardinal;
  TCnNativePointer = Integer;
  TCnNativeIntPtr  = PInteger;
  TCnNativeUIntPtr = PCardinal;
{$ENDIF}

{$IFDEF CPU64BITS}
  TCnUInt64        = NativeUInt;
  TCnInt64         = NativeInt;
{$ELSE}
  {$IFDEF SUPPORT_UINT64}
  TCnUInt64        = UInt64;
  {$ELSE}
  TCnUInt64 = packed record  // ֻ���������Ľṹ����
    case Boolean of
      True:  (Value: Int64);
      False: (Lo32, Hi32: Cardinal);
  end;
  {$ENDIF}
  TCnInt64         = Int64;
{$ENDIF}

// TUInt64 ���� cnvcl ���в�֧�� UInt64 �������� div mod ��
{$IFDEF SUPPORT_UINT64}
  TUInt64          = UInt64;
  {$IFNDEF SUPPORT_PUINT64}
  PUInt64          = ^UInt64;
  {$ENDIF}
{$ELSE}
  TUInt64          = Int64;
  PUInt64          = ^TUInt64;
{$ENDIF}

{$IFNDEF SUPPORT_INT64ARRAY}
  // ���ϵͳû�ж��� Int64Array
  Int64Array  = array[0..$0FFFFFFE] of Int64;
  PInt64Array = ^Int64Array;
{$ENDIF}

  TUInt64Array = array of TUInt64; // �����̬���������ƺ����׺;�̬���������г�ͻ

  ExtendedArray = array[0..65537] of Extended;
  PExtendedArray = ^ExtendedArray;

  PCnWord16Array = ^TCnWord16Array;
  TCnWord16Array = array [0..0] of Word;

{$IFDEF POSIX64}
  TCnLongWord32 = Cardinal; // Linux64/MacOS64 (or POSIX64?) LongWord is 64 Bits
{$ELSE}
  TCnLongWord32 = LongWord;
{$ENDIF}
  PCnLongWord32 = ^TCnLongWord32;

  TCnLongWord32Array = array [0..MaxInt div SizeOf(Integer) - 1] of TCnLongWord32;

  PCnLongWord32Array = ^TCnLongWord32Array;

{$IFNDEF TBYTES_DEFINED}
  TBytes = array of Byte;
  {* �޷����ֽ����飬δ����ʱ������}
{$ENDIF}

  TShortInts = array of ShortInt;
  {* �з����ֽ�����}

  PCnByte = ^Byte;
  PCnWord = ^Word;

  TCnBitOperation = (boAnd, boOr, boXor, boNot);
  {* λ��������}

type
  TCnMemSortCompareProc = function (P1, P2: Pointer; ElementByteSize: Integer): Integer;
  {* �ڴ�̶���ߴ����������ȽϺ���ԭ��}

const
  CN_MAX_SQRT_INT64: Cardinal               = 3037000499;
  CN_MAX_UINT16: Word                       = $FFFF;
  CN_MAX_UINT32: Cardinal                   = $FFFFFFFF;
  CN_MAX_TUINT64: TUInt64                   = $FFFFFFFFFFFFFFFF;
  CN_MAX_SIGNED_INT64_IN_TUINT64: TUInt64   = $7FFFFFFFFFFFFFFF;

{*
  ���� D567 �Ȳ�֧�� UInt64 �ı���������Ȼ������ Int64 ���� UInt64 ���мӼ����洢
  ���˳��������޷�ֱ����ɣ������װ���������� System ���е� _lludiv �� _llumod
  ������ʵ���� Int64 ��ʾ�� UInt64 ���ݵ� div �� mod ���ܡ�
}
function UInt64Mod(A, B: TUInt64): TUInt64;
{* ���� UInt64 ����}

function UInt64Div(A, B: TUInt64): TUInt64;
{* ���� UInt64 ����}

function UInt64Mul(A, B: Cardinal): TUInt64;
{* �޷��� 32 λ�������������ˣ��ڲ�֧�� UInt64 ��ƽ̨�ϣ������ UInt64 ����ʽ���� Int64 �
  ������ֱ��ʹ�� Int64 �������п������}

procedure UInt64AddUInt64(A, B: TUInt64; var ResLo, ResHi: TUInt64);
{* �����޷��� 64 λ������ӣ�������������������� ResLo �� ResHi ��
  ע���ڲ�ʵ�ְ��㷨������Ϊ���ӣ�ʵ������������ResHi ��Ȼ�� 1��ֱ���ж������������ 1 ����}

procedure UInt64MulUInt64(A, B: TUInt64; var ResLo, ResHi: TUInt64);
{* �����޷��� 64 λ������ˣ������ ResLo �� ResHi �У�64 λ���û��ʵ�֣�����Լһ������}

function UInt64ToHex(N: TUInt64): string;
{* �� UInt64 ת��Ϊʮ�������ַ���}

function UInt64ToStr(N: TUInt64): string;
{* �� UInt64 ת��Ϊ�ַ���}

function StrToUInt64(const S: string): TUInt64;
{* ���ַ���ת��Ϊ UInt64}

function UInt64Compare(A, B: TUInt64): Integer;
{* �Ƚ����� UInt64 ֵ���ֱ���� > = < ���� 1��0��-1}

function UInt64Sqrt(N: TUInt64): TUInt64;
{* �� UInt64 ��ƽ��������������}

function UInt32IsNegative(N: Cardinal): Boolean;
{* �� Cardinal ������ Integer ʱ�Ƿ�С�� 0}

function UInt64IsNegative(N: TUInt64): Boolean;
{* �� UInt64 ������ Int64 ʱ�Ƿ�С�� 0}

procedure UInt64SetBit(var B: TUInt64; Index: Integer);
{* �� UInt64 ��ĳһλ�� 1��λ Index �� 0 ��ʼ}

procedure UInt64ClearBit(var B: TUInt64; Index: Integer);
{* �� UInt64 ��ĳһλ�� 0��λ Index �� 0 ��ʼ}

function GetUInt64BitSet(B: TUInt64; Index: Integer): Boolean;
{* ���� UInt64 ��ĳһλ�Ƿ��� 1��λ Index �� 0 ��ʼ}

function GetUInt64HighBits(B: TUInt64): Integer;
{* ���� UInt64 ���� 1 ����߶�����λ�ǵڼ�λ�����λ�� 0�����û�� 1������ -1}

function GetUInt32HighBits(B: Cardinal): Integer;
{* ���� Cardinal ���� 1 ����߶�����λ�ǵڼ�λ�����λ�� 0�����û�� 1������ -1}

function GetUInt64LowBits(B: TUInt64): Integer;
{* ���� Int64 ���� 1 ����Ͷ�����λ�ǵڼ�λ�����λ�� 0��������ͬ��ĩβ���� 0�����û�� 1������ -1}

function GetUInt32LowBits(B: Cardinal): Integer;
{* ���� Cardinal ���� 1 ����Ͷ�����λ�ǵڼ�λ�����λ�� 0��������ͬ��ĩβ���� 0�����û�� 1������ -1}

function Int64Mod(M, N: Int64): Int64;
{* ��װ�� Int64 Mod��M ������ֵʱȡ����ģ��ģ������ N ��Ҫ������������������}

function IsUInt32PowerOf2(N: Cardinal): Boolean;
{* �ж�һ 32 λ�޷��������Ƿ� 2 ����������}

function IsUInt64PowerOf2(N: TUInt64): Boolean;
{* �ж�һ 64 λ�޷��������Ƿ� 2 ����������}

function GetUInt32PowerOf2GreaterEqual(N: Cardinal): Cardinal;
{* �õ�һ��ָ�� 32 λ�޷������������ȵ� 2 ���������ݣ�������򷵻� 0}

function GetUInt64PowerOf2GreaterEqual(N: TUInt64): TUInt64;
{* �õ�һ��ָ�� 64 λ�޷������������ȵ� 2 ���������ݣ�������򷵻� 0}

function IsInt32AddOverflow(A, B: Integer): Boolean;
{* �ж����� 32 λ�з���������Ƿ���� 32 λ�з�������}

function IsUInt32AddOverflow(A, B: Cardinal): Boolean;
{* �ж����� 32 λ�޷���������Ƿ���� 32 λ�޷�������}

function IsInt64AddOverflow(A, B: Int64): Boolean;
{* �ж����� 64 λ�з���������Ƿ���� 64 λ�з�������}

function IsUInt64AddOverflow(A, B: TUInt64): Boolean;
{* �ж����� 64 λ�޷���������Ƿ���� 64 λ�޷�������}

procedure UInt64Add(var R: TUInt64; A, B: TUInt64; out Carry: Integer);
{* ���� 64 λ�޷�������ӣ�A + B => R������������������� 1 ���λ������������}

procedure UInt64Sub(var R: TUInt64; A, B: TUInt64; out Carry: Integer);
{* ���� 64 λ�޷����������A - B => R������������н�λ������ 1 ���λ������������}

function IsInt32MulOverflow(A, B: Integer): Boolean;
{* �ж����� 32 λ�з���������Ƿ���� 32 λ�з�������}

function IsUInt32MulOverflow(A, B: Cardinal): Boolean;
{* �ж����� 32 λ�޷���������Ƿ���� 32 λ�޷�������}

function IsUInt32MulOverflowInt64(A, B: Cardinal; out R: TUInt64): Boolean;
{* �ж����� 32 λ�޷���������Ƿ���� 64 λ�з���������δ���Ҳ������ False ʱ��R ��ֱ�ӷ��ؽ��
  �����Ҳ������ True�������Ҫ���µ��� UInt64Mul ����ʵʩ���}

function IsInt64MulOverflow(A, B: Int64): Boolean;
{* �ж����� 64 λ�з���������Ƿ���� 64 λ�з�������}

function PointerToInteger(P: Pointer): Integer;
{* ָ������ת�������ͣ�֧�� 32/64 λ��ע�� 64 λ�¿��ܻᶪ���� 32 λ������}

function IntegerToPointer(I: Integer): Pointer;
{* ����ת����ָ�����ͣ�֧�� 32/64 λ}

function Int64NonNegativeAddMod(A, B, N: Int64): Int64;
{* �� Int64 ��Χ���������ĺ����࣬��������������Ҫ�� N ���� 0}

function UInt64NonNegativeAddMod(A, B, N: TUInt64): TUInt64;
{* �� UInt64 ��Χ���������ĺ����࣬��������������Ҫ�� N ���� 0}

function Int64NonNegativeMulMod(A, B, N: Int64): Int64;
{* Int64 ��Χ�ڵ�������࣬����ֱ�Ӽ��㣬���������Ҫ�� N ���� 0}

function UInt64NonNegativeMulMod(A, B, N: TUInt64): TUInt64;
{* UInt64 ��Χ�ڵ�������࣬����ֱ�Ӽ��㣬���������}

function Int64NonNegativeMod(N: Int64; P: Int64): Int64;
{* ��װ�� Int64 �Ǹ����ຯ����Ҳ��������Ϊ��ʱ���Ӹ������������������豣֤ P ���� 0}

function Int64NonNegativPower(N: Int64; Exp: Integer): Int64;
{* Int64 �ķǸ�����ָ���ݣ���������������}

function Int64NonNegativeRoot(N: Int64; Exp: Integer): Int64;
{* �� Int64 �ķǸ������η������������֣���������������}

function UInt64NonNegativPower(N: TUInt64; Exp: Integer): TUInt64;
{* UInt64 �ķǸ�����ָ���ݣ���������������}

function UInt64NonNegativeRoot(N: TUInt64; Exp: Integer): TUInt64;
{* �� UInt64 �ķǸ������η������������֣���������������}

function CurrentByteOrderIsBigEndian: Boolean;
{* ���ص�ǰ�����ڻ����Ƿ��Ǵ�ˣ�Ҳ�����Ƿ������еĸ����ֽڴ洢�ڽϵ͵���ʼ��ַ�����ϴ����ҵ��Ķ�ϰ�ߣ��粿��ָ���� ARM �� MIPS}

function CurrentByteOrderIsLittleEndian: Boolean;
{* ���ص�ǰ�����ڻ����Ƿ���С�ˣ�Ҳ�����Ƿ������еĸ����ֽڴ洢�ڽϸߵ���ʼ��ַ���� x86 �벿��Ĭ�� arm}

function Int64ToBigEndian(Value: Int64): Int64;
{* ȷ�� Int64 ֵΪ��ˣ���С�˻����л����ת��}

function Int32ToBigEndian(Value: Integer): Integer;
{* ȷ�� Int32 ֵΪ��ˣ���С�˻����л����ת��}

function Int16ToBigEndian(Value: SmallInt): SmallInt;
{* ȷ�� Int16 ֵΪ��ˣ���С�˻����л����ת��}

function Int64ToLittleEndian(Value: Int64): Int64;
{* ȷ�� Int64 ֵΪС�ˣ��ڴ�˻����л����ת��}

function Int32ToLittleEndian(Value: Integer): Integer;
{* ȷ�� Int32 ֵΪС�ˣ��ڴ�˻����л����ת��}

function Int16ToLittleEndian(Value: SmallInt): SmallInt;
{* ȷ�� Int16 ֵΪС�ˣ��ڴ�˻����л����ת��}

function UInt64ToBigEndian(Value: TUInt64): TUInt64;
{* ȷ�� UInt64 ֵΪ��ˣ���С�˻����л����ת��}

function UInt32ToBigEndian(Value: Cardinal): Cardinal;
{* ȷ�� UInt32 ֵΪ��ˣ���С�˻����л����ת��}

function UInt16ToBigEndian(Value: Word): Word;
{* ȷ�� UInt16 ֵΪ��ˣ���С�˻����л����ת��}

function UInt64ToLittleEndian(Value: TUInt64): TUInt64;
{* ȷ�� UInt64 ֵΪС�ˣ��ڴ�˻����л����ת��}

function UInt32ToLittleEndian(Value: Cardinal): Cardinal;
{* ȷ�� UInt32 ֵΪС�ˣ��ڴ�˻����л����ת��}

function UInt16ToLittleEndian(Value: Word): Word;
{* ȷ�� UInt16 ֵΪС�ˣ��ڴ�˻����л����ת��}

function Int64HostToNetwork(Value: Int64): Int64;
{* �� Int64 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function Int32HostToNetwork(Value: Integer): Integer;
{* �� Int32 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function Int16HostToNetwork(Value: SmallInt): SmallInt;
{* �� Int16 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function Int64NetworkToHost(Value: Int64): Int64;
{* �� Int64 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function Int32NetworkToHost(Value: Integer): Integer;
{* �� Int32ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function Int16NetworkToHost(Value: SmallInt): SmallInt;
{* �� Int16 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function UInt64HostToNetwork(Value: TUInt64): TUInt64;
{* �� UInt64 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function UInt32HostToNetwork(Value: Cardinal): Cardinal;
{* �� UInt32 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function UInt16HostToNetwork(Value: Word): Word;
{* �� UInt16 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function UInt64NetworkToHost(Value: TUInt64): TUInt64;
{* �� UInt64 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function UInt32NetworkToHost(Value: Cardinal): Cardinal;
{* �� UInt32ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

function UInt16NetworkToHost(Value: Word): Word;
{* �� UInt16 ֵ�������ֽ�˳��ת��Ϊ�����ֽ�˳����С�˻����л����ת��}

procedure ReverseMemory(AMem: Pointer; MemByteLen: Integer);
{* ���ֽ�˳����һ���ڴ�飬�ֽ��ڲ�����}

function ReverseBitsInInt8(V: Byte): Byte;
{* ����һ�ֽ�����}

function ReverseBitsInInt16(V: Word): Word;
{* ���ö��ֽ�����}

function ReverseBitsInInt32(V: Cardinal): Cardinal;
{* �������ֽ�����}

function ReverseBitsInInt64(V: Int64): Int64;
{* ���ð��ֽ�����}

procedure ReverseMemoryWithBits(AMem: Pointer; MemByteLen: Integer);
{* ���ֽ�˳����һ���ڴ�飬����ÿ���ֽ�Ҳ������}

procedure MemoryAnd(AMem, BMem: Pointer; MemByteLen: Integer; ResMem: Pointer);
{* ���鳤����ͬ���ڴ� AMem �� BMem ��λ�룬����� ResMem �У����߿���ͬ}

procedure MemoryOr(AMem, BMem: Pointer; MemByteLen: Integer; ResMem: Pointer);
{* ���鳤����ͬ���ڴ� AMem �� BMem ��λ�򣬽���� ResMem �У����߿���ͬ}

procedure MemoryXor(AMem, BMem: Pointer; MemByteLen: Integer; ResMem: Pointer);
{* ���鳤����ͬ���ڴ� AMem �� BMem ��λ��򣬽���� ResMem �У����߿���ͬ}

procedure MemoryNot(AMem: Pointer; MemByteLen: Integer; ResMem: Pointer);
{* һ���ڴ� AMem ȡ��������� ResMem �У����߿���ͬ}

procedure MemoryShiftLeft(AMem, BMem: Pointer; MemByteLen: Integer; BitCount: Integer);
{* AMem �����ڴ����� BitCount λ�� BMem�����ڴ��ַ��λ�ƣ���λ�� 0�����߿����}

procedure MemoryShiftRight(AMem, BMem: Pointer; MemByteLen: Integer; BitCount: Integer);
{* AMem �����ڴ����� BitCount λ�� BMem�����ڴ��ַ��λ�ƣ���λ�� 0�����߿����}

function MemoryIsBitSet(AMem: Pointer; N: Integer): Boolean;
{* �����ڴ��ĳ Bit λ�Ƿ��� 1���ڴ��ַ��λ�� 0���ֽ��ڻ����ұ�Ϊ 0}

procedure MemorySetBit(AMem: Pointer; N: Integer);
{* ���ڴ��ĳ Bit λ�� 1���ڴ��ַ��λ�� 0���ֽ��ڻ����ұ�Ϊ 0}

procedure MemoryClearBit(AMem: Pointer; N: Integer);
{* ���ڴ��ĳ Bit λ�� 0���ڴ��ַ��λ�� 0���ֽ��ڻ����ұ�Ϊ 0}

function MemoryToBinStr(AMem: Pointer; MemByteLen: Integer; Sep: Boolean = False): string;
{* ��һ���ڴ����ݴӵ͵����ֽ�˳�����Ϊ�������ַ�����Sep ��ʾ�Ƿ�ո�ָ�}

procedure MemorySwap(AMem, BMem: Pointer; MemByteLen: Integer);
{* ����������ͬ���ȵ��ڴ������ݣ�����������ͬ���ڴ����ʲô������}

function MemoryCompare(AMem, BMem: Pointer; MemByteLen: Integer): Integer;
{* ���޷������ķ�ʽ�Ƚ������ڴ棬���� 1��0��-1������������ͬ���ڴ����ֱ�ӷ��� 0}

procedure MemoryQuickSort(Mem: Pointer; ElementByteSize: Integer;
  ElementCount: Integer; CompareProc: TCnMemSortCompareProc = nil);
{* ��Թ̶���С��Ԫ�ص������������}

function UInt8ToBinStr(V: Byte): string;
{* ��һ�޷����ֽ�ת��Ϊ�������ַ���}

function UInt16ToBinStr(V: Word): string;
{* ��һ�޷�����ת��Ϊ�������ַ���}

function UInt32ToBinStr(V: Cardinal): string;
{* ��һ���ֽ��޷�������ת��Ϊ�������ַ���}

function UInt32ToStr(V: Cardinal): string;
{* ��һ���ֽ��޷�������ת��Ϊ�ַ���}

function UInt64ToBinStr(V: TUInt64): string;
{* ��һ�޷��� 64 �ֽ�����ת��Ϊ�������ַ���}

function HexToInt(const Hex: string): Integer; overload;
{* ��һʮ�������ַ���ת��Ϊ���ͣ��ʺϽ϶������� 2 �ַ����ַ���}

function HexToInt(Hex: PChar; CharLen: Integer): Integer; overload;
{* ��һʮ�������ַ���ָ����ָ������ת��Ϊ���ͣ��ʺϽ϶������� 2 �ַ����ַ���}

function IsHexString(const Hex: string): Boolean;
{* �ж�һ�ַ����Ƿ�Ϸ���ʮ�������ַ����������ִ�Сд}

function DataToHex(InData: Pointer; ByteLength: Integer; UseUpperCase: Boolean = True): string;
{* �ڴ��ת��Ϊʮ�������ַ������ڴ��λ�����ݳ������ַ����󷽣��൱�������ֽ�˳��
  UseUpperCase ����������ݵĴ�Сд}

function HexToData(const Hex: string; OutData: Pointer = nil): Integer;
{* ʮ�������ַ���ת��Ϊ�ڴ�飬�ַ����󷽵����ݳ������ڴ��λ���൱�������ֽ�˳��
  ʮ�������ַ�������Ϊ���ת��ʧ��ʱ�׳��쳣������ת���ɹ����ֽ���
  ע�� OutData Ӧ��ָ���㹻����ת�����ݵ����򣬳�������Ϊ Length(Hex) div 2
  ����� nil����ֻ����������ֽڳ��ȣ���������ʽת��}

function StringToHex(const Data: string; UseUpperCase: Boolean = True): string;
{* �ַ���ת��Ϊʮ�������ַ�����UseUpperCase ����������ݵĴ�Сд}

function HexToString(const Hex: string): string;
{* ʮ�������ַ���ת��Ϊ�ַ�����ʮ�������ַ�������Ϊ���ת��ʧ��ʱ�׳��쳣}

function HexToAnsiStr(const Hex: AnsiString): AnsiString;
{* ʮ�������ַ���ת��Ϊ�ַ�����ʮ�������ַ�������Ϊ���ת��ʧ��ʱ�׳��쳣}

function BytesToHex(Data: TBytes; UseUpperCase: Boolean = True): string;
{* �ֽ�����ת��Ϊʮ�������ַ������±��λ�����ݳ������ַ����󷽣��൱�������ֽ�˳��
  UseUpperCase ����������ݵĴ�Сд}

function HexToBytes(const Hex: string): TBytes;
{* ʮ�������ַ���ת��Ϊ�ֽ����飬�ַ�����ߵ����ݳ������±��λ���൱�������ֽ�˳��
  �ַ�������Ϊ���ת��ʧ��ʱ�׳��쳣}

procedure ReverseBytes(Data: TBytes);
{* ���ֽ�˳����һ�ֽ�����}

function StreamToBytes(Stream: TStream): TBytes;
{* ������ͷ����ȫ���������ֽ����飬���ش������ֽ�����}

function BytesToStream(Data: TBytes; OutStream: TStream): Integer;
{* �ֽ�����д��������������д���ֽ���}

procedure MoveMost(const Source; var Dest; ByteLen, MostLen: Integer);
{* �� Source �ƶ� ByteLen �Ҳ����� MostLen ���ֽڵ� Dest �У�
  �� ByteLen С�� MostLen���� Dest ��� 0��Ҫ�� Dest �������� MostLen}

procedure ConstantTimeConditionalSwap8(CanSwap: Boolean; var A, B: Byte);
{* ��������ֽڱ�����ִ��ʱ��̶�������������CanSwap Ϊ True ʱ��ʵʩ A B ����}

procedure ConstantTimeConditionalSwap16(CanSwap: Boolean; var A, B: Word);
{* �������˫�ֽڱ�����ִ��ʱ��̶�������������CanSwap Ϊ True ʱ��ʵʩ A B ����}

procedure ConstantTimeConditionalSwap32(CanSwap: Boolean; var A, B: Cardinal);
{* ����������ֽڱ�����ִ��ʱ��̶�������������CanSwap Ϊ True ʱ��ʵʩ A B ����}

procedure ConstantTimeConditionalSwap64(CanSwap: Boolean; var A, B: TUInt64);
{* ����������ֽڱ�����ִ��ʱ��̶�������������CanSwap Ϊ True ʱ��ʵʩ A B ����}

{$IFDEF MSWINDOWS}

// ���ĸ�������Ϊ���� Intel ��࣬���ֻ֧�� 32 λ�� 64 λ�� Intel CPU������Ӧ����������CPUX86 �� CPUX64

procedure Int64DivInt32Mod(A: Int64; B: Integer; var DivRes, ModRes: Integer);
{* 64 λ�з��������� 32 λ�з��������̷� DivRes�������� ModRes
  �����������б�֤���� 32 λ��Χ�ڣ������������쳣}

procedure UInt64DivUInt32Mod(A: TUInt64; B: Cardinal; var DivRes, ModRes: Cardinal);
{* 64 λ�޷��������� 32 λ�޷��������̷� DivRes�������� ModRes
  �����������б�֤���� 32 λ��Χ�ڣ������������쳣}

procedure Int128DivInt64Mod(ALo, AHi: Int64; B: Int64; var DivRes, ModRes: Int64);
{* 128 λ�з��������� 64 λ�з��������̷� DivRes�������� ModRes
  �����������б�֤���� 64 λ��Χ�ڣ������������쳣}

procedure UInt128DivUInt64Mod(ALo, AHi: TUInt64; B: TUInt64; var DivRes, ModRes: TUInt64);
{* 128 λ�޷��������� 64 λ�޷��������̷� DivRes�������� ModRes
  �����������б�֤���� 64 λ��Χ�ڣ������������쳣}

{$ENDIF}

function IsUInt128BitSet(Lo, Hi: TUInt64; N: Integer): Boolean;
{* ������� Int64 ƴ�ɵ� 128 λ���֣����ص� N λ�Ƿ�Ϊ 1��N �� 0 �� 127}

procedure SetUInt128Bit(var Lo, Hi: TUInt64; N: Integer);
{* ������� Int64 ƴ�ɵ� 128 λ���֣����õ� N λΪ 1��N �� 0 �� 127}

procedure ClearUInt128Bit(var Lo, Hi: TUInt64; N: Integer);
{* ������� Int64 ƴ�ɵ� 128 λ���֣������ N λ��N �� 0 �� 127}

function UnsignedAddWithLimitRadix(A, B, C: Cardinal; var R: Cardinal;
  L, H: Cardinal): Cardinal;
{* ������������Ƶ��޷��żӷ���A + B + C������� R �У����ؽ�λֵ
  ���ȷ���� L �� H �ı������ڣ��û���ȷ�� H ���� L�����������������
  �ú����������ַ������������ӳ�䣬���� C һ���ǽ�λ}

implementation

uses
  CnFloat;

var
  FByteOrderIsBigEndian: Boolean = False;

function CurrentByteOrderIsBigEndian: Boolean;
type
  TByteOrder = packed record
    case Boolean of
      False: (C: array[0..1] of Byte);
      True: (W: Word);
  end;
var
  T: TByteOrder;
begin
  T.W := $00CC;
  Result := T.C[1] = $CC;
end;

function CurrentByteOrderIsLittleEndian: Boolean;
begin
  Result := not CurrentByteOrderIsBigEndian;
end;

function SwapInt64(Value: Int64): Int64;
var
  Lo, Hi: Cardinal;
  Rec: Int64Rec;
begin
  Lo := Int64Rec(Value).Lo;
  Hi := Int64Rec(Value).Hi;
  Lo := ((Lo and $000000FF) shl 24) or ((Lo and $0000FF00) shl 8)
    or ((Lo and $00FF0000) shr 8) or ((Lo and $FF000000) shr 24);
  Hi := ((Hi and $000000FF) shl 24) or ((Hi and $0000FF00) shl 8)
    or ((Hi and $00FF0000) shr 8) or ((Hi and $FF000000) shr 24);
  Rec.Lo := Hi;
  Rec.Hi := Lo;
  Result := Int64(Rec);
end;

function SwapUInt64(Value: TUInt64): TUInt64;
var
  Lo, Hi: Cardinal;
  Rec: Int64Rec;
begin
  Lo := Int64Rec(Value).Lo;
  Hi := Int64Rec(Value).Hi;
  Lo := ((Lo and $000000FF) shl 24) or ((Lo and $0000FF00) shl 8)
    or ((Lo and $00FF0000) shr 8) or ((Lo and $FF000000) shr 24);
  Hi := ((Hi and $000000FF) shl 24) or ((Hi and $0000FF00) shl 8)
    or ((Hi and $00FF0000) shr 8) or ((Hi and $FF000000) shr 24);
  Rec.Lo := Hi;
  Rec.Hi := Lo;
  Result := TUInt64(Rec);
end;

function Int64ToBigEndian(Value: Int64): Int64;
begin
  if FByteOrderIsBigEndian then
    Result := Value
  else
    Result := SwapInt64(Value);
end;

function Int32ToBigEndian(Value: Integer): Integer;
begin
  if FByteOrderIsBigEndian then
    Result := Value
  else
    Result := Integer((Value and $000000FF) shl 24) or Integer((Value and $0000FF00) shl 8)
      or Integer((Value and $00FF0000) shr 8) or Integer((Value and $FF000000) shr 24);
end;

function Int16ToBigEndian(Value: SmallInt): SmallInt;
begin
  if FByteOrderIsBigEndian then
    Result := Value
  else
    Result := SmallInt((Value and $00FF) shl 8) or SmallInt((Value and $FF00) shr 8);
end;

function Int64ToLittleEndian(Value: Int64): Int64;
begin
  if not FByteOrderIsBigEndian then
    Result := Value
  else
    Result := SwapInt64(Value);
end;

function Int32ToLittleEndian(Value: Integer): Integer;
begin
  if not FByteOrderIsBigEndian then
    Result := Value
  else
    Result := Integer((Value and $000000FF) shl 24) or Integer((Value and $0000FF00) shl 8)
      or Integer((Value and $00FF0000) shr 8) or Integer((Value and $FF000000) shr 24);
end;

function Int16ToLittleEndian(Value: SmallInt): SmallInt;
begin
  if not FByteOrderIsBigEndian then
    Result := Value
  else
    Result := SmallInt((Value and $00FF) shl 8) or SmallInt((Value and $FF00) shr 8);
end;

function UInt64ToBigEndian(Value: TUInt64): TUInt64;
begin
  if FByteOrderIsBigEndian then
    Result := Value
  else
    Result := SwapUInt64(Value);
end;

function UInt32ToBigEndian(Value: Cardinal): Cardinal;
begin
  if FByteOrderIsBigEndian then
    Result := Value
  else
    Result := Cardinal((Value and $000000FF) shl 24) or Cardinal((Value and $0000FF00) shl 8)
      or Cardinal((Value and $00FF0000) shr 8) or Cardinal((Value and $FF000000) shr 24);
end;

function UInt16ToBigEndian(Value: Word): Word;
begin
  if FByteOrderIsBigEndian then
    Result := Value
  else
    Result := Word((Value and $00FF) shl 8) or Word((Value and $FF00) shr 8);
end;

function UInt64ToLittleEndian(Value: TUInt64): TUInt64;
begin
  if not FByteOrderIsBigEndian then
    Result := Value
  else
    Result := SwapUInt64(Value);
end;

function UInt32ToLittleEndian(Value: Cardinal): Cardinal;
begin
  if not FByteOrderIsBigEndian then
    Result := Value
  else
    Result := Cardinal((Value and $000000FF) shl 24) or Cardinal((Value and $0000FF00) shl 8)
      or Cardinal((Value and $00FF0000) shr 8) or Cardinal((Value and $FF000000) shr 24);
end;

function UInt16ToLittleEndian(Value: Word): Word;
begin
  if not FByteOrderIsBigEndian then
    Result := Value
  else
    Result := Word((Value and $00FF) shl 8) or Word((Value and $FF00) shr 8);
end;

function Int64HostToNetwork(Value: Int64): Int64;
begin
  if not FByteOrderIsBigEndian then
    Result := SwapInt64(Value)
  else
    Result := Value;
end;

function Int32HostToNetwork(Value: Integer): Integer;
begin
  if not FByteOrderIsBigEndian then
    Result := Integer((Value and $000000FF) shl 24) or Integer((Value and $0000FF00) shl 8)
      or Integer((Value and $00FF0000) shr 8) or Integer((Value and $FF000000) shr 24)
  else
    Result := Value;
end;

function Int16HostToNetwork(Value: SmallInt): SmallInt;
begin
  if not FByteOrderIsBigEndian then
    Result := SmallInt((Value and $00FF) shl 8) or SmallInt((Value and $FF00) shr 8)
  else
    Result := Value;
end;

function Int64NetworkToHost(Value: Int64): Int64;
begin
  if not FByteOrderIsBigEndian then
    REsult := SwapInt64(Value)
  else
    Result := Value;
end;

function Int32NetworkToHost(Value: Integer): Integer;
begin
  if not FByteOrderIsBigEndian then
    Result := Integer((Value and $000000FF) shl 24) or Integer((Value and $0000FF00) shl 8)
      or Integer((Value and $00FF0000) shr 8) or Integer((Value and $FF000000) shr 24)
  else
    Result := Value;
end;

function Int16NetworkToHost(Value: SmallInt): SmallInt;
begin
  if not FByteOrderIsBigEndian then
    Result := SmallInt((Value and $00FF) shl 8) or SmallInt((Value and $FF00) shr 8)
  else
    Result := Value;
end;

function UInt64HostToNetwork(Value: TUInt64): TUInt64;
begin
  if CurrentByteOrderIsBigEndian then
    Result := Value
  else
    Result := SwapUInt64(Value);
end;

function UInt32HostToNetwork(Value: Cardinal): Cardinal;
begin
  if not FByteOrderIsBigEndian then
    Result := Cardinal((Value and $000000FF) shl 24) or Cardinal((Value and $0000FF00) shl 8)
      or Cardinal((Value and $00FF0000) shr 8) or Cardinal((Value and $FF000000) shr 24)
  else
    Result := Value;
end;

function UInt16HostToNetwork(Value: Word): Word;
begin
  if not FByteOrderIsBigEndian then
    Result := ((Value and $00FF) shl 8) or ((Value and $FF00) shr 8)
  else
    Result := Value;
end;

function UInt64NetworkToHost(Value: TUInt64): TUInt64;
begin
  if CurrentByteOrderIsBigEndian then
    Result := Value
  else
    Result := SwapUInt64(Value);
end;

function UInt32NetworkToHost(Value: Cardinal): Cardinal;
begin
  if not FByteOrderIsBigEndian then
    Result := Cardinal((Value and $000000FF) shl 24) or Cardinal((Value and $0000FF00) shl 8)
      or Cardinal((Value and $00FF0000) shr 8) or Cardinal((Value and $FF000000) shr 24)
  else
    Result := Value;
end;

function UInt16NetworkToHost(Value: Word): Word;
begin
  if not FByteOrderIsBigEndian then
    Result := ((Value and $00FF) shl 8) or ((Value and $FF00) shr 8)
  else
    Result := Value;
end;

function ReverseBitsInInt8(V: Byte): Byte;
begin
  // 0 �� 1 ������2 �� 3 ������4 �� 5 ������6 �� 7 ����
  V := ((V and $AA) shr 1) or ((V and $55) shl 1);
  // 01 �� 23 ������45 �� 67 ����
  V := ((V and $CC) shr 2) or ((V and $33) shl 2);
  // 0123 �� 4567 ����
  V := (V shr 4) or (V shl 4);
  Result := V;
end;

function ReverseBitsInInt16(V: Word): Word;
begin
  Result := (ReverseBitsInInt8(V and $00FF) shl 8)
    or ReverseBitsInInt8((V and $FF00) shr 8);
end;

function ReverseBitsInInt32(V: Cardinal): Cardinal;
begin
  Result := (ReverseBitsInInt16(V and $0000FFFF) shl 16)
    or ReverseBitsInInt16((V and $FFFF0000) shr 16);
end;

function ReverseBitsInInt64(V: Int64): Int64;
begin
  Result := (Int64(ReverseBitsInInt32(V and $00000000FFFFFFFF)) shl 32)
    or ReverseBitsInInt32((V and $FFFFFFFF00000000) shr 32);
end;

procedure ReverseMemory(AMem: Pointer; MemByteLen: Integer);
var
  I, L: Integer;
  P: PByteArray;
  T: Byte;
begin
  if (AMem = nil) or (MemByteLen < 2) then
    Exit;

  L := MemByteLen div 2;
  P := PByteArray(AMem);
  for I := 0 to L - 1 do
  begin
    // ������ I �͵� MemLen - I - 1
    T := P^[I];
    P^[I] := P^[MemByteLen - I - 1];
    P^[MemByteLen - I - 1] := T;
  end;
end;

procedure ReverseMemoryWithBits(AMem: Pointer; MemByteLen: Integer);
var
  I: Integer;
  P: PByteArray;
begin
  if (AMem = nil) or (MemByteLen <= 0) then
    Exit;

  ReverseMemory(AMem, MemByteLen);
  P := PByteArray(AMem);

  for I := 0 to MemByteLen - 1 do
    P^[I] := ReverseBitsInInt8(P^[I]);
end;

// N �ֽڳ��ȵ��ڴ���λ����
procedure MemoryBitOperation(AMem, BMem, RMem: Pointer; N: Integer; Op: TCnBitOperation);
var
  A, B, R: PCnLongWord32Array;
  BA, BB, BR: PByteArray;
begin
  if N <= 0 then
    Exit;

  if (AMem = nil) or ((BMem = nil) and (Op <> boNot)) or (RMem = nil) then
    Exit;

  A := PCnLongWord32Array(AMem);
  B := PCnLongWord32Array(BMem);
  R := PCnLongWord32Array(RMem);

  while (N and (not 3)) <> 0 do
  begin
    case Op of
      boAnd:
        R^[0] := A^[0] and B^[0];
      boOr:
        R^[0] := A^[0] or B^[0];
      boXor:
        R^[0] := A^[0] xor B^[0];
      boNot: // ��ʱ���� B
        R^[0] := not A^[0];
    end;

    A := PCnLongWord32Array(TCnNativeInt(A) + SizeOf(Cardinal));
    B := PCnLongWord32Array(TCnNativeInt(B) + SizeOf(Cardinal));
    R := PCnLongWord32Array(TCnNativeInt(R) + SizeOf(Cardinal));

    Dec(N, SizeOf(Cardinal));
  end;

  if N > 0 then
  begin
    BA := PByteArray(A);
    BB := PByteArray(B);
    BR := PByteArray(R);

    while N <> 0 do
    begin
      case Op of
        boAnd:
          BR^[0] := BA^[0] and BB^[0];
        boOr:
          BR^[0] := BA^[0] or BB^[0];
        boXor:
          BR^[0] := BA^[0] xor BB^[0];
        boNot:
          BR^[0] := not BA^[0];
      end;

      BA := PByteArray(TCnNativeInt(BA) + SizeOf(Byte));
      BB := PByteArray(TCnNativeInt(BB) + SizeOf(Byte));
      BR := PByteArray(TCnNativeInt(BR) + SizeOf(Byte));
      Dec(N);
    end;
  end;
end;

procedure MemoryAnd(AMem, BMem: Pointer; MemByteLen: Integer; ResMem: Pointer);
begin
  MemoryBitOperation(AMem, BMem, ResMem, MemByteLen, boAnd);
end;

procedure MemoryOr(AMem, BMem: Pointer; MemByteLen: Integer; ResMem: Pointer);
begin
  MemoryBitOperation(AMem, BMem, ResMem, MemByteLen, boOr);
end;

procedure MemoryXor(AMem, BMem: Pointer; MemByteLen: Integer; ResMem: Pointer);
begin
  MemoryBitOperation(AMem, BMem, ResMem, MemByteLen, boXor);
end;

procedure MemoryNot(AMem: Pointer; MemByteLen: Integer; ResMem: Pointer);
begin
  MemoryBitOperation(AMem, nil, ResMem, MemByteLen, boNot);
end;

procedure MemoryShiftLeft(AMem, BMem: Pointer; MemByteLen: Integer; BitCount: Integer);
var
  I, L, N, LB, RB: Integer;
  PF, PT: PByteArray;
begin
  if (AMem = nil) or (MemByteLen <= 0) or (BitCount = 0) then
    Exit;

  if BitCount < 0 then
  begin
    MemoryShiftRight(AMem, BMem, MemByteLen, -BitCount);
    Exit;
  end;

  if BMem = nil then
    BMem := AMem;

  if (MemByteLen * 8) <= BitCount then // ��̫�಻����ȫ 0
  begin
    FillChar(BMem^, MemByteLen, 0);
    Exit;
  end;

  N := BitCount div 8;  // ��λ���������ֽ���
  RB := BitCount mod 8; // ȥ�����ֽں�ʣ�µ�λ��
  LB := 8 - RB;         // ����ʣ�µ�λ����һ�ֽ�����ʣ�µ�λ��

  PF := PByteArray(AMem);
  PT := PByteArray(BMem);

  if RB = 0 then // ���飬�ð죬Ҫ��λ���ֽ����� MemLen - NW
  begin
    Move(PF^[N], PT^[0], MemByteLen - N);
    FillChar(PT^[MemByteLen - N], N, 0);
  end
  else
  begin
    // ����� PF^[N] �� PT^[0]������ MemLen - N ���ֽڣ��������ֽڼ��н���
    L := MemByteLen - N;
    PF := PByteArray(TCnNativeInt(PF) + N);

    for I := 1 to L do // �ӵ�λ�����ƶ����ȴ���͵�
    begin
      PT^[0] := Byte(PF^[0] shl RB);
      if I < L then    // ���һ���ֽ� PF^[1] �ᳬ��
        PT^[0] := (PF^[1] shr LB) or PT^[0];

      PF := PByteArray(TCnNativeInt(PF) + 1);
      PT := PByteArray(TCnNativeInt(PT) + 1);
    end;

    // ʣ�µ�Ҫ�� 0
    if N > 0 then
      FillChar(PT^[0], N, 0);
  end;
end;

procedure MemoryShiftRight(AMem, BMem: Pointer; MemByteLen: Integer; BitCount: Integer);
var
  I, L, N, LB, RB: Integer;
  PF, PT: PByteArray;
begin
  if (AMem = nil) or (MemByteLen <= 0) or (BitCount = 0) then
    Exit;

  if BitCount < 0 then
  begin
    MemoryShiftLeft(AMem, BMem, MemByteLen, -BitCount);
    Exit;
  end;

  if BMem = nil then
    BMem := AMem;

  if (MemByteLen * 8) <= BitCount then // ��̫�಻����ȫ 0
  begin
    FillChar(BMem^, MemByteLen, 0);
    Exit;
  end;

  N := BitCount div 8;  // ��λ���������ֽ���
  RB := BitCount mod 8; // ȥ�����ֽں�ʣ�µ�λ��
  LB := 8 - RB;         // ����ʣ�µ�λ����һ�ֽ�����ʣ�µ�λ��

  if RB = 0 then // ���飬�ð죬Ҫ��λ���ֽ����� MemLen - N
  begin
    PF := PByteArray(AMem);
    PT := PByteArray(BMem);

    Move(PF^[0], PT^[N], MemByteLen - N);
    FillChar(PT^[0], N, 0);
  end
  else
  begin
    // ����� PF^[0] �� PT^[N]������ MemLen - N ���ֽڣ����ôӸߴ���ʼ���������ֽڼ��н���
    L := MemByteLen - N;

    PF := PByteArray(TCnNativeInt(AMem) + L - 1);
    PT := PByteArray(TCnNativeInt(BMem) + MemByteLen - 1);

    for I := L downto 1 do // �Ӹ�λ����λ�ƶ����ȴ�������
    begin
      PT^[0] := Byte(PF^[0] shr RB);
      if I > 1 then        // ���һ���ֽ� PF^[-1] �ᳬ��
      begin
        PF := PByteArray(TCnNativeInt(PF) - 1);
        PT^[0] := (PF^[0] shl LB) or PT^[0];
      end
      else
        PF := PByteArray(TCnNativeInt(PF) - 1);

      PT := PByteArray(TCnNativeInt(PT) - 1);
    end;

    // ʣ�µ���ǰ���Ҫ�� 0
    if N > 0 then
      FillChar(BMem^, N, 0);
  end;
end;

function MemoryIsBitSet(AMem: Pointer; N: Integer): Boolean;
var
  P: PByte;
  A, B: Integer;
  V: Byte;
begin
  if (AMem = nil) or (N < 0) then
    raise Exception.Create(SRangeError);

  A := N div 8;
  B := N mod 8;
  P := PByte(TCnNativeInt(AMem) + A);

  V := Byte(1 shl B);
  Result := (P^ and V) <> 0;
end;

procedure MemorySetBit(AMem: Pointer; N: Integer);
var
  P: PByte;
  A, B: Integer;
  V: Byte;
begin
  if (AMem = nil) or (N < 0) then
    raise Exception.Create(SRangeError);

  A := N div 8;
  B := N mod 8;
  P := PByte(TCnNativeInt(AMem) + A);

  V := Byte(1 shl B);
  P^ := P^ or V;
end;

procedure MemoryClearBit(AMem: Pointer; N: Integer);
var
  P: PByte;
  A, B: Integer;
  V: Byte;
begin
  if (AMem = nil) or (N < 0) then
    raise Exception.Create(SRangeError);

  A := N div 8;
  B := N mod 8;
  P := PByte(TCnNativeInt(AMem) + A);

  V := not Byte(1 shl B);
  P^ := P^ and V;
end;

function MemoryToBinStr(AMem: Pointer; MemByteLen: Integer; Sep: Boolean): string;
var
  J, L: Integer;
  P: PByteArray;
  B: PChar;

  procedure FillAByteToBuf(V: Byte; Buf: PChar);
  const
    M = $80;
  var
    I: Integer;
  begin
    for I := 0 to 7 do
    begin
      if (V and M) <> 0 then
        Buf[I] := '1'
      else
        Buf[I] := '0';
      V := V shl 1;
    end;
  end;

begin
  Result := '';
  if (AMem = nil) or (MemByteLen <= 0) then
    Exit;

  L := MemByteLen * 8;
  if Sep then
    L := L + MemByteLen - 1; // �м��ÿո�ָ�

  SetLength(Result, L);
  B := PChar(@Result[1]);
  P := PByteArray(AMem);

  for J := 0 to MemByteLen - 1 do
  begin
    FillAByteToBuf(P^[J], B);
    if Sep then
    begin
      B[8] := ' ';
      Inc(B, 9);
    end
    else
      Inc(B, 8);
  end;
end;

procedure MemorySwap(AMem, BMem: Pointer; MemByteLen: Integer);
var
  A, B: PCnLongWord32Array;
  BA, BB: PByteArray;
  TC: Cardinal;
  TB: Byte;
begin
  if (AMem = nil) or (BMem = nil) or (MemByteLen <= 0) then
    Exit;

  A := PCnLongWord32Array(AMem);
  B := PCnLongWord32Array(BMem);

  if A = B then
    Exit;

  while (MemByteLen and (not 3)) <> 0 do
  begin
    TC := A^[0];
    A^[0] := B^[0];
    B^[0] := TC;

    A := PCnLongWord32Array(TCnNativeInt(A) + SizeOf(Cardinal));
    B := PCnLongWord32Array(TCnNativeInt(B) + SizeOf(Cardinal));

    Dec(MemByteLen, SizeOf(Cardinal));
  end;

  if MemByteLen > 0 then
  begin
    BA := PByteArray(A);
    BB := PByteArray(B);

    while MemByteLen <> 0 do
    begin
      TB := BA^[0];
      BA^[0] := BB^[0];
      BB^[0] :=TB;

      BA := PByteArray(TCnNativeInt(BA) + SizeOf(Byte));
      BB := PByteArray(TCnNativeInt(BB) + SizeOf(Byte));

      Dec(MemByteLen);
    end;
  end;
end;

function MemoryCompare(AMem, BMem: Pointer; MemByteLen: Integer): Integer;
var
  A, B: PCnLongWord32Array;
  BA, BB: PByteArray;
begin
  Result := 0;
  if ((AMem = nil) and (BMem = nil)) or (AMem = BMem) then // ͬһ��
    Exit;

  if MemByteLen <= 0 then
    Exit;

  if AMem = nil then
  begin
    Result := -1;
    Exit;
  end;
  if BMem = nil then
  begin
    Result := 1;
    Exit;
  end;

  A := PCnLongWord32Array(AMem);
  B := PCnLongWord32Array(BMem);

  while (MemByteLen and (not 3)) <> 0 do
  begin
    if A^[0] > B^[0] then
    begin
      Result := 1;
      Exit;
    end
    else if A^[0] < B^[0] then
    begin
      Result := -1;
      Exit;
    end;

    A := PCnLongWord32Array(TCnNativeInt(A) + SizeOf(Cardinal));
    B := PCnLongWord32Array(TCnNativeInt(B) + SizeOf(Cardinal));

    Dec(MemByteLen, SizeOf(Cardinal));
  end;

  if MemByteLen > 0 then
  begin
    BA := PByteArray(A);
    BB := PByteArray(B);

    while MemByteLen <> 0 do
    begin
      if BA^[0] > BB^[0] then
      begin
        Result := 1;
        Exit;
      end
      else if BA^[0] < BB^[0] then
      begin
        Result := -1;
        Exit;
      end;

      BA := PByteArray(TCnNativeInt(BA) + SizeOf(Byte));
      BB := PByteArray(TCnNativeInt(BB) + SizeOf(Byte));

      Dec(MemByteLen);
    end;
  end;
end;

function UInt8ToBinStr(V: Byte): string;
const
  M = $80;
var
  I: Integer;
begin
  SetLength(Result, 8 * SizeOf(V));
  for I := 1 to 8 * SizeOf(V) do
  begin
    if (V and M) <> 0 then
      Result[I] := '1'
    else
      Result[I] := '0';
    V := V shl 1;
  end;
end;

function UInt16ToBinStr(V: Word): string;
const
  M = $8000;
var
  I: Integer;
begin
  SetLength(Result, 8 * SizeOf(V));
  for I := 1 to 8 * SizeOf(V) do
  begin
    if (V and M) <> 0 then
      Result[I] := '1'
    else
      Result[I] := '0';
    V := V shl 1;
  end;
end;

function UInt32ToBinStr(V: Cardinal): string;
const
  M = $80000000;
var
  I: Integer;
begin
  SetLength(Result, 8 * SizeOf(V));
  for I := 1 to 8 * SizeOf(V) do
  begin
    if (V and M) <> 0 then
      Result[I] := '1'
    else
      Result[I] := '0';
    V := V shl 1;
  end;
end;

function UInt32ToStr(V: Cardinal): string;
begin
  Result := Format('%u', [V]);
end;

function UInt64ToBinStr(V: TUInt64): string;
const
  M = $8000000000000000;
var
  I: Integer;
begin
  SetLength(Result, 8 * SizeOf(V));

  for I := 1 to 8 * SizeOf(V) do
  begin
    if (V and M) <> 0 then
      Result[I] := '1'
    else
      Result[I] := '0';
    V := V shl 1;
  end;
end;

const
  HiDigits: array[0..15] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
                                  '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
const
  LoDigits: array[0..15] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
                                  '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');

function HexToInt(Hex: PChar; CharLen: Integer): Integer;
var
  I, Res: Integer;
  C: Char;
begin
  Res := 0;
  for I := 0 to CharLen - 1 do
  begin
    C := Hex[I];
    if (C >= '0') and (C <= '9') then
      Res := Res * 16 + Ord(C) - Ord('0')
    else if (C >= 'A') and (C <= 'F') then
      Res := Res * 16 + Ord(C) - Ord('A') + 10
    else if (C >= 'a') and (C <= 'f') then
      Res := Res * 16 + Ord(C) - Ord('a') + 10
    else
      raise Exception.CreateFmt('Error: not a Hex PChar: %c', [C]);
  end;
  Result := Res;
end;

function HexToInt(const Hex: string): Integer;
begin
  Result := HexToInt(PChar(Hex), Length(Hex));
end;

{$WARNINGS OFF}

function IsHexString(const Hex: string): Boolean;
var
  I, L: Integer;
begin
  Result := False;
  L := Length(Hex);
  if (L <= 0) or ((L and 1) <> 0) then // �ջ��ż���ȶ�����
    Exit;

  for I := 1 to L do
  begin
    // ע��˴� Unicode ����Ȼ�� Warning���������ǽ� Hex[I] ��� WideChar ֱ�ӽض��� AnsiChar
    // ���ٽ����жϣ������ᵼ�¡��޻ޡ����� $66$66$66$66 ���ַ����������У�������
    // ֱ��ͨ�� WideChar ��ֵ���� ax �������˫�ֽڵģ��Ӽ����жϣ������������
    if not (Hex[I] in ['0'..'9', 'A'..'F', 'a'..'f']) then
      Exit;
  end;
  Result := True;
end;

{$WARNINGS ON}

function DataToHex(InData: Pointer; ByteLength: Integer; UseUpperCase: Boolean = True): string;
var
  I: Integer;
  B: Byte;
begin
  Result := '';
  if ByteLength <= 0 then
    Exit;

  SetLength(Result, ByteLength * 2);
  if UseUpperCase then
  begin
    for I := 0 to ByteLength - 1 do
    begin
      B := PByte(TCnNativeInt(InData) + I * SizeOf(Byte))^;
      Result[I * 2 + 1] := HiDigits[(B shr 4) and $0F];
      Result[I * 2 + 2] := HiDigits[B and $0F];
    end;
  end
  else
  begin
    for I := 0 to ByteLength - 1 do
    begin
      B := PByte(TCnNativeInt(InData) + I * SizeOf(Byte))^;
      Result[I * 2 + 1] := LoDigits[(B shr 4) and $0F];
      Result[I * 2 + 2] := LoDigits[B and $0F];
    end;
  end;
end;

function HexToData(const Hex: string; OutData: Pointer): Integer;
var
  I, L: Integer;
  H: PChar;
begin
  L := Length(Hex);
  if (L mod 2) <> 0 then
    raise Exception.CreateFmt('Error Length %d: not a Hex String', [L]);

  if OutData = nil then
  begin
    Result := L div 2;
    Exit;
  end;

  Result := 0;
  H := PChar(Hex);
  for I := 1 to L div 2 do
  begin
    PByte(TCnNativeInt(OutData) + I - 1)^ := Byte(HexToInt(@H[(I - 1) * 2], 2));
    Inc(Result);
  end;
end;

function StringToHex(const Data: string; UseUpperCase: Boolean): string;
var
  I, L: Integer;
  B: Byte;
  Buffer: PChar;
begin
  Result := '';
  L := Length(Data);
  if L = 0 then
    Exit;

  SetLength(Result, L * 2);
  Buffer := @Data[1];

  if UseUpperCase then
  begin
    for I := 0 to L - 1 do
    begin
      B := PByte(TCnNativeInt(Buffer) + I * SizeOf(Char))^;
      Result[I * 2 + 1] := HiDigits[(B shr 4) and $0F];
      Result[I * 2 + 2] := HiDigits[B and $0F];
    end;
  end
  else
  begin
    for I := 0 to L - 1 do
    begin
      B := PByte(TCnNativeInt(Buffer) + I * SizeOf(Char))^;
      Result[I * 2 + 1] := LoDigits[(B shr 4) and $0F];
      Result[I * 2 + 2] := LoDigits[B and $0F];
    end;
  end;
end;

function HexToString(const Hex: string): string;
var
  I, L: Integer;
  H: PChar;
begin
  L := Length(Hex);
  if (L mod 2) <> 0 then
    raise Exception.CreateFmt('Error Length %d: not a Hex String', [L]);

  SetLength(Result, L div 2);
  H := PChar(Hex);
  for I := 1 to L div 2 do
    Result[I] := Chr(HexToInt(@H[(I - 1) * 2], 2));
end;

function HexToAnsiStr(const Hex: AnsiString): AnsiString;
var
  I, L: Integer;
  S: string;
begin
  L := Length(Hex);
  if (L mod 2) <> 0 then
    raise Exception.CreateFmt('Error Length %d: not a Hex AnsiString', [L]);

  SetLength(Result, L div 2);
  for I := 1 to L div 2 do
  begin
    S := string(Copy(Hex, I * 2 - 1, 2));
    Result[I] := AnsiChar(Chr(HexToInt(S)));
  end;
end;

function BytesToHex(Data: TBytes; UseUpperCase: Boolean): string;
var
  I, L: Integer;
  B: Byte;
  Buffer: PAnsiChar;
begin
  Result := '';
  L := Length(Data);
  if L = 0 then
    Exit;

  SetLength(Result, L * 2);
  Buffer := @Data[0];

  if UseUpperCase then
  begin
    for I := 0 to L - 1 do
    begin
      B := PByte(TCnNativeInt(Buffer) + I)^;
      Result[I * 2 + 1] := HiDigits[(B shr 4) and $0F];
      Result[I * 2 + 2] := HiDigits[B and $0F];
    end;
  end
  else
  begin
    for I := 0 to L - 1 do
    begin
      B := PByte(TCnNativeInt(Buffer) + I)^;
      Result[I * 2 + 1] := LoDigits[(B shr 4) and $0F];
      Result[I * 2 + 2] := LoDigits[B and $0F];
    end;
  end;
end;

function HexToBytes(const Hex: string): TBytes;
var
  I, L: Integer;
  H: PChar;
begin
  L := Length(Hex);
  if (L mod 2) <> 0 then
    raise Exception.CreateFmt('Error Length %d: not a Hex String', [L]);

  SetLength(Result, L div 2);
  H := PChar(Hex);

  for I := 1 to L div 2 do
    Result[I - 1] := Byte(HexToInt(@H[(I - 1) * 2], 2));
end;

procedure ReverseBytes(Data: TBytes);
var
  I, L, M: Integer;
  T: Byte;
begin
  if (Data = nil) or (Length(Data) <= 1) then
    Exit;
  L := Length(Data);
  M := L div 2;
  for I := 0 to M - 1 do
  begin
    // ���� I �� L - I - 1
    T := Data[I];
    Data[I] := Data[L - I - 1];
    Data[L - I - 1] := T;
  end;
end;

function StreamToBytes(Stream: TStream): TBytes;
begin
  Result := nil;
  if (Stream <> nil) and (Stream.Size > 0) then
  begin
    SetLength(Result, Stream.Size);
    Stream.Position := 0;
    Stream.Read(Result[0], Stream.Size);
  end;
end;

function BytesToStream(Data: TBytes; OutStream: TStream): Integer;
begin
  Result := 0;
  if (Data <> nil) and (Length(Data) > 0) and (OutStream <> nil) then
  begin
    OutStream.Size := 0;
    Result := OutStream.Write(Data[0], Length(Data));
  end;
end;

procedure MoveMost(const Source; var Dest; ByteLen, MostLen: Integer);
begin
  if MostLen <= 0 then
    Exit;

  if ByteLen > MostLen then
    ByteLen := MostLen
  else if ByteLen < MostLen then
    FillChar(Dest, MostLen, 0);

  Move(Source, Dest, ByteLen);
end;

procedure ConstantTimeConditionalSwap8(CanSwap: Boolean; var A, B: Byte);
var
  T, V: Byte;
begin
  if CanSwap then
    T := $FF
  else
    T := 0;

  V := (A xor B) and T;
  A := A xor V;
  B := B xor V;
end;

procedure ConstantTimeConditionalSwap16(CanSwap: Boolean; var A, B: Word);
var
  T, V: Word;
begin
  if CanSwap then
    T := $FFFF
  else
    T := 0;

  V := (A xor B) and T;
  A := A xor V;
  B := B xor V;
end;

procedure ConstantTimeConditionalSwap32(CanSwap: Boolean; var A, B: Cardinal);
var
  T, V: Cardinal;
begin
  if CanSwap then
    T := $FFFFFFFF
  else
    T := 0;

  V := (A xor B) and T;
  A := A xor V;
  B := B xor V;
end;

procedure ConstantTimeConditionalSwap64(CanSwap: Boolean; var A, B: TUInt64);
var
  T, V: TUInt64;
begin
  if CanSwap then
  begin
{$IFDEF SUPPORT_UINT64}
    T := $FFFFFFFFFFFFFFFF;
{$ELSE}
    T := not 0;
{$ENDIF}
  end
  else
    T := 0;

  V := (A xor B) and T;
  A := A xor V;
  B := B xor V;
end;

{$IFDEF MSWINDOWS}

{$IFDEF CPUX64}

// 64 λ����� IDIV �� IDIV ָ��ʵ�֣����� A �� RCX �B �� EDX/RDX �DivRes ��ַ�� R8 �ModRes ��ַ�� R9 ��
procedure Int64DivInt32Mod(A: Int64; B: Integer; var DivRes, ModRes: Integer); assembler;
asm
        PUSH    RCX                           // RCX �� A
        MOV     RCX, RDX                      // ���� B ���� RCX
        POP     RAX                           // ������ A ���� RAX
        XOR     RDX, RDX                      // �������� 64 λ����
        IDIV    RCX
        MOV     [R8], EAX                     // �̷��� R8 ��ָ�� DivRes
        MOV     [R9], EDX                     // �������� R9 ��ָ�� ModRes
end;

procedure UInt64DivUInt32Mod(A: TUInt64; B: Cardinal; var DivRes, ModRes: Cardinal); assembler;
asm
        PUSH    RCX                           // RCX �� A
        MOV     RCX, RDX                      // ���� B ���� RCX
        POP     RAX                           // ������ A ���� RAX
        XOR     RDX, RDX                      // �������� 64 λ����
        DIV     RCX
        MOV     [R8], EAX                     // �̷��� R8 ��ָ�� DivRes
        MOV     [R9], EDX                     // �������� R9 ��ָ�� ModRes
end;

// 64 λ����� IDIV �� IDIV ָ��ʵ�֣�ALo �� RCX��AHi �� RDX��B �� R8��DivRes �ĵ�ַ�� R9��
procedure Int128DivInt64Mod(ALo, AHi: Int64; B: Int64; var DivRes, ModRes: Int64); assembler;
asm
        MOV     RAX, RCX                      // ALo ���� RAX��AHi �Ѿ��� RDX ��
        MOV     RCX, R8                       // B ���� RCX
        IDIV    RCX
        MOV     [R9], RAX                     // �̷��� R9 ��ָ�� DivRes
        MOV     RAX, [RBP + $30]              // ModRes ��ַ���� RAX
        MOV     [RAX], RDX                    // �������� RAX ��ָ�� ModRes
end;

procedure UInt128DivUInt64Mod(ALo, AHi: UInt64; B: UInt64; var DivRes, ModRes: UInt64); assembler;
asm
        MOV     RAX, RCX                      // ALo ���� RAX��AHi �Ѿ��� RDX ��
        MOV     RCX, R8                       // B ���� RCX
        DIV     RCX
        MOV     [R9], RAX                     // �̷��� R9 ��ָ�� DivRes
        MOV     RAX, [RBP + $30]              // ModRes ��ַ���� RAX
        MOV     [RAX], RDX                    // �������� RAX ��ָ�� ModRes
end;

{$ELSE}

// 32 λ����� IDIV �� IDIV ָ��ʵ�֣����� A �ڶ�ջ�ϣ�B �� EAX��DivRes ��ַ�� EDX��ModRes ��ַ�� ECX
procedure Int64DivInt32Mod(A: Int64; B: Integer; var DivRes, ModRes: Integer); assembler;
asm
        PUSH    ECX                           // ECX �� ModRes ��ַ���ȱ���
        MOV     ECX, B                        // B �� EAX �У����Ƶ� ECX ��
        PUSH    EDX                           // DivRes �ĵ�ַ�� EDX �У�Ҳ����
        MOV     EAX, [EBP + $8]               // A Lo
        MOV     EDX, [EBP + $C]               // A Hi
        IDIV    ECX
        POP     ECX                           // ���� ECX���õ� DivRes ��ַ
        MOV     [ECX], EAX
        POP     ECX                           // ���� ECX���õ� ModRes ��ַ
        MOV     [ECX], EDX
end;

procedure UInt64DivUInt32Mod(A: TUInt64; B: Cardinal; var DivRes, ModRes: Cardinal); assembler;
asm
        PUSH    ECX                           // ECX �� ModRes ��ַ���ȱ���
        MOV     ECX, B                        // B �� EAX �У����Ƶ� ECX ��
        PUSH    EDX                           // DivRes �ĵ�ַ�� EDX �У�Ҳ����
        MOV     EAX, [EBP + $8]               // A Lo
        MOV     EDX, [EBP + $C]               // A Hi
        DIV     ECX
        POP     ECX                           // ���� ECX���õ� DivRes ��ַ
        MOV     [ECX], EAX
        POP     ECX                           // ���� ECX���õ� ModRes ��ַ
        MOV     [ECX], EDX
end;

// 32 λ�µ�ʵ��
procedure Int128DivInt64Mod(ALo, AHi: Int64; B: Int64; var DivRes, ModRes: Int64);
var
  C: Integer;
begin
  if B = 0 then
    raise EDivByZero.Create(SDivByZero);

  if (AHi = 0) or (AHi = $FFFFFFFFFFFFFFFF) then // �� 64 λΪ 0 ����ֵ��ֵ
  begin
    DivRes := ALo div B;
    ModRes := ALo mod B;
  end
  else
  begin
    if B < 0 then // �����Ǹ���
    begin
      Int128DivInt64Mod(ALo, AHi, -B, DivRes, ModRes);
      DivRes := -DivRes;
      Exit;
    end;

    if AHi < 0 then // �������Ǹ���
    begin
      // AHi, ALo �󷴼� 1���Եõ���ֵ
      AHi := not AHi;
      ALo := not ALo;
{$IFDEF SUPPORT_UINT64}
      UInt64Add(UInt64(ALo), UInt64(ALo), 1, C);
{$ELSE}
      UInt64Add(ALo, ALo, 1, C);
{$ENDIF}
      if C > 0 then
        AHi := AHi + C;

      // ������ת����
      Int128DivInt64Mod(ALo, AHi, B, DivRes, ModRes);

      // ����ٵ���
      if ModRes = 0 then
        DivRes := -DivRes
      else
      begin
        DivRes := -DivRes - 1;
        ModRes := B - ModRes;
      end;
      Exit;
    end;

    // ȫ���󣬰��޷�������
{$IFDEF SUPPORT_UINT64}
    UInt128DivUInt64Mod(TUInt64(ALo), TUInt64(AHi), TUInt64(B), TUInt64(DivRes), TUInt64(ModRes));
{$ELSE}
    UInt128DivUInt64Mod(ALo, AHi, B, DivRes, ModRes);
{$ENDIF}
  end;
end;

procedure UInt128DivUInt64Mod(ALo, AHi: TUInt64; B: TUInt64; var DivRes, ModRes: TUInt64);
var
  I, Cnt: Integer;
  Q, R: TUInt64;
begin
  if B = 0 then
    raise EDivByZero.Create(SDivByZero);

  if AHi = 0 then
  begin
    DivRes := UInt64Div(ALo, B);
    ModRes := UInt64Mod(ALo, B);
  end
  else
  begin
    // �и�λ�е�λզ�죿���ж��Ƿ���������� AHi >= B�����ʾ��Ҫ�� 64 λ�����
    if UInt64Compare(AHi, B) >= 0 then
      raise Exception.Create(SIntOverflow);

    Q := 0;
    R := 0;
    Cnt := GetUInt64LowBits(AHi) + 64;
    for I := Cnt downto 0 do
    begin
      R := R shl 1;
      if IsUInt128BitSet(ALo, AHi, I) then  // �������ĵ� I λ�Ƿ��� 0
        R := R or 1
      else
        R := R and TUInt64(not 1);

      if UInt64Compare(R, B) >= 0 then
      begin
        R := R - B;
        Q := Q or (TUInt64(1) shl I);
      end;
    end;
    DivRes := Q;
    ModRes := R;
  end;
end;

{$ENDIF}

{$ENDIF}

{$IFDEF SUPPORT_UINT64}

// ֻҪ֧�� 64 λ�޷������������� 32/64 λ Intel ���� ARM������ Delphi ���� FPC������ʲô����ϵͳ�������

function UInt64Mod(A, B: TUInt64): TUInt64;
begin
  Result := A mod B;
end;

function UInt64Div(A, B: TUInt64): TUInt64;
begin
  Result := A div B;
end;

{$ELSE}
{
  ��֧�� UInt64 �ĵͰ汾 Delphi ���� Int64 �� A mod/div B

  ���õ���ջ˳���� A �ĸ�λ��A �ĵ�λ��B �ĸ�λ��B �ĵ�λ������ push ��ϲ����뺯����
  ESP �Ƿ��ص�ַ��ESP+4 �� B �ĵ�λ��ESP + 8 �� B �ĸ�λ��ESP + C �� A �ĵ�λ��ESP + 10 �� A �ĸ�λ
  ����� push esp �� ESP ���� 4��Ȼ�� mov ebp esp��֮���� EBP ��Ѱַ��ȫҪ��� 4

  �� System.@_llumod Ҫ���ڸս���ʱ��EAX <- A �ĵ�λ��EDX <- A �ĸ�λ����System Դ��ע���� EAX/EDX д���ˣ�
  [ESP + 8]��Ҳ���� EBP + C��<- B �ĸ�λ��[ESP + 4] ��Ҳ���� EBP + 8��<- B �ĵ�λ

  ���� CALL ǰ�����ľ���ƴ��롣UInt64 Div ��Ҳ����
}
function UInt64Mod(A, B: TUInt64): TUInt64;
asm
        // PUSH ESP �� ESP ���� 4��Ҫ����
        MOV     EAX, [EBP + $10]              // A Lo
        MOV     EDX, [EBP + $14]              // A Hi
        PUSH    DWORD PTR[EBP + $C]           // B Hi
        PUSH    DWORD PTR[EBP + $8]           // B Lo
        CALL    System.@_llumod;
end;

function UInt64Div(A, B: TUInt64): TUInt64;
asm
        // PUSH ESP �� ESP ���� 4��Ҫ����
        MOV     EAX, [EBP + $10]              // A Lo
        MOV     EDX, [EBP + $14]              // A Hi
        PUSH    DWORD PTR[EBP + $C]           // B Hi
        PUSH    DWORD PTR[EBP + $8]           // B Lo
        CALL    System.@_lludiv;
end;

{$ENDIF}

{$IFDEF SUPPORT_UINT64}

// ֻҪ֧�� 64 λ�޷������������� 32/64 λ Intel ���� ARM������ Delphi ���� FPC������ʲô����ϵͳ�������

function UInt64Mul(A, B: Cardinal): TUInt64;
begin
  Result := TUInt64(A) * B;
end;

{$ELSE} // ֻ�еͰ汾 Delphi ������Win32 x86

{
  �޷��� 32 λ������ˣ�������ֱ��ʹ�� Int64 �������ģ�� 64 λ�޷�������

  ���üĴ���Լ���� A -> EAX��B -> EDX����ʹ�ö�ջ
  �� System.@_llmul Ҫ���ڸս���ʱ��EAX <- A �ĵ�λ��EDX <- A �ĸ�λ 0��
  [ESP + 8]��Ҳ���� EBP + C��<- B �ĸ�λ 0��[ESP + 4] ��Ҳ���� EBP + 8��<- B �ĵ�λ
}
function UInt64Mul(A, B: Cardinal): TUInt64;
asm
        PUSH    0               // PUSH B ��λ 0
        PUSH    EDX             // PUSH B ��λ
                                // EAX A ��λ���Ѿ�����
        XOR     EDX, EDX        // EDX A ��λ 0
        CALL    System.@_llmul; // ���� EAX �� 32 λ��EDX �� 32 λ
end;

{$ENDIF}

// �����޷��� 64 λ������ӣ�������������������� ResLo �� ResHi ��
procedure UInt64AddUInt64(A, B: TUInt64; var ResLo, ResHi: TUInt64);
var
  X, Y, Z, T, R0L, R0H, R1L, R1H: Cardinal;
  R0, R1, R01, R12: TUInt64;
begin
  // ����˼�룺2^32 ��ϵ�� M����� (xM+y) + (zM+t) = (x+z) M + (y+t)
  // y+t �� R0 ռ 0��1��x+z �� R1 ռ 1��2���� R0, R1 �ٲ���ӳ� R01, R12
  if IsUInt64AddOverflow(A, B) then
  begin
    X := Int64Rec(A).Hi;
    Y := Int64Rec(A).Lo;
    Z := Int64Rec(B).Hi;
    T := Int64Rec(B).Lo;

    R0 := TUInt64(Y) + TUInt64(T);
    R1 := TUInt64(X) + TUInt64(Z);

    R0L := Int64Rec(R0).Lo;
    R0H := Int64Rec(R0).Hi;
    R1L := Int64Rec(R1).Lo;
    R1H := Int64Rec(R1).Hi;

    R01 := TUInt64(R0H) + TUInt64(R1L);
    R12 := TUInt64(R1H) + TUInt64(Int64Rec(R01).Hi);

    Int64Rec(ResLo).Lo := R0L;
    Int64Rec(ResLo).Hi := Int64Rec(R01).Lo;
    Int64Rec(ResHi).Lo := Int64Rec(R12).Lo;
    Int64Rec(ResHi).Hi := Int64Rec(R12).Hi;
  end
  else
  begin
    ResLo := A + B;
    ResHi := 0;
  end;
end;

{$IFDEF WIN64}  // ע�� Linux 64 �²�֧�� ASM��ֻ�� WIN64

// 64 λ�������޷��� 64 λ������ˣ������ ResLo �� ResHi �У�ֱ���û��ʵ�֣����������һ������
procedure UInt64MulUInt64(A, B: UInt64; var ResLo, ResHi: UInt64); assembler;
asm
  PUSH RAX
  MOV RAX, RCX
  MUL RDX         // �����޷��ţ��������з��ŵ� IMUL
  MOV [R8], RAX
  MOV [R9], RDX
  POP RAX
end;

{$ELSE}

// �����޷��� 64 λ������ˣ������ ResLo �� ResHi ��
procedure UInt64MulUInt64(A, B: TUInt64; var ResLo, ResHi: TUInt64);
var
  X, Y, Z, T: Cardinal;
  YT, XT, ZY, ZX: TUInt64;
  P, R1Lo, R1Hi, R2Lo, R2Hi: TUInt64;
begin
  // ����˼�룺2^32 ��ϵ�� M����� (xM+y)*(zM+t) = xzM^2 + (xt+yz)M + yt
  // ����ϵ������ UInt64��xz ռ 2��3��4��xt+yz ռ 1��2��3��yt ռ 0��1��Ȼ���ۼ�
  X := Int64Rec(A).Hi;
  Y := Int64Rec(A).Lo;
  Z := Int64Rec(B).Hi;
  T := Int64Rec(B).Lo;

  YT := UInt64Mul(Y, T);
  XT := UInt64Mul(X, T);
  ZY := UInt64Mul(Y, Z);
  ZX := UInt64Mul(X, Z);

  Int64Rec(ResLo).Lo := Int64Rec(YT).Lo;

  P := Int64Rec(YT).Hi;
  UInt64AddUInt64(P, XT, R1Lo, R1Hi);
  UInt64AddUInt64(ZY, R1Lo, R2Lo, R2Hi);

  Int64Rec(ResLo).Hi := Int64Rec(R2Lo).Lo;

  P := TUInt64(Int64Rec(R2Lo).Hi) + TUInt64(Int64Rec(ZX).Lo);

  Int64Rec(ResHi).Lo := Int64Rec(P).Lo;
  Int64Rec(ResHi).Hi := Int64Rec(R1Hi).Lo + Int64Rec(R2Hi).Lo + Int64Rec(ZX).Hi + Int64Rec(P).Hi;
end;

{$ENDIF}

{$HINTS OFF}

function _ValUInt64(const S: string; var Code: Integer): TUInt64;
const
  FirstIndex = 1;
var
  I: Integer;
  Dig: Integer;
  Sign: Boolean;
  Empty: Boolean;
begin
  I := FirstIndex;
  Dig := 0;    // To avoid warning
  Result := 0;

  if S = '' then
  begin
    Code := 1;
    Exit;
  end;
  while S[I] = Char(' ') do
    Inc(I);
  Sign := False;
  if S[I] =  Char('-') then
  begin
    Sign := True;
    Inc(I);
  end
  else if S[I] =  Char('+') then
    Inc(I);
  Empty := True;

  if (S[I] =  Char('$')) or (UpCase(S[I]) =  Char('X'))
    or ((S[I] =  Char('0')) and (I < Length(S)) and (UpCase(S[I+1]) =  Char('X'))) then
  begin
    if S[I] =  Char('0') then
      Inc(I);
    Inc(I);
    while True do
    begin
      case   Char(S[I]) of
       Char('0').. Char('9'): Dig := Ord(S[I]) -  Ord('0');
       Char('A').. Char('F'): Dig := Ord(S[I]) - (Ord('A') - 10);
       Char('a').. Char('f'): Dig := Ord(S[I]) - (Ord('a') - 10);
      else
        Break;
      end;
      if Result > (CN_MAX_TUINT64 shr 4) then
        Break;
      if Sign and (Dig <> 0) then
        Break;
      Result := Result shl 4 + TUInt64(Dig);
      Inc(I);
      Empty := False;
    end;
  end
  else
  begin
    while True do
    begin
      case Char(S[I]) of
        Char('0').. Char('9'): Dig := Ord(S[I]) - Ord('0');
      else
        Break;
      end;

      if Result > UInt64Div(CN_MAX_TUINT64, 10) then
        Break;
      if Sign and (Dig <> 0) then
        Break;
      Result := Result * 10 + TUInt64(Dig);
      Inc(I);
      Empty := False;
    end;
  end;

  if (S[I] <> Char(#0)) or Empty then
    Code := I + 1 - FirstIndex
  else
    Code := 0;
end;

{$HINTS ON}

function UInt64ToHex(N: TUInt64): string;
const
  Digits: array[0..15] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
                                  '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');

  function HC(B: Byte): string;
  begin
    Result := string(Digits[(B shr 4) and $0F] + Digits[B and $0F]);
  end;

begin
  Result :=
      HC(Byte((N and $FF00000000000000) shr 56))
    + HC(Byte((N and $00FF000000000000) shr 48))
    + HC(Byte((N and $0000FF0000000000) shr 40))
    + HC(Byte((N and $000000FF00000000) shr 32))
    + HC(Byte((N and $00000000FF000000) shr 24))
    + HC(Byte((N and $0000000000FF0000) shr 16))
    + HC(Byte((N and $000000000000FF00) shr 8))
    + HC(Byte((N and $00000000000000FF)));
end;

function UInt64ToStr(N: TUInt64): string;
begin
  Result := Format('%u', [N]);
end;

function StrToUInt64(const S: string): TUInt64;
{$IFNDEF DELPHIXE6_UP}
var
  E: Integer;
{$ENDIF}
begin
{$IFDEF DELPHIXE6_UP}
  Result := SysUtils.StrToUInt64(S);  // StrToUInt64 only exists under XE6 or above
{$ELSE}
  Result := _ValUInt64(S,  E);
  if E <> 0 then raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
{$ENDIF}
end;

function UInt64Compare(A, B: TUInt64): Integer;
{$IFNDEF SUPPORT_UINT64}
var
  HiA, HiB, LoA, LoB: LongWord;
{$ENDIF}
begin
{$IFDEF SUPPORT_UINT64}
  if A > B then
    Result := 1
  else if A < B then
    Result := -1
  else
    Result := 0;
{$ELSE}
  HiA := (A and $FFFFFFFF00000000) shr 32;
  HiB := (B and $FFFFFFFF00000000) shr 32;
  if HiA > HiB then
    Result := 1
  else if HiA < HiB then
    Result := -1
  else
  begin
    LoA := LongWord(A and $00000000FFFFFFFF);
    LoB := LongWord(B and $00000000FFFFFFFF);
    if LoA > LoB then
      Result := 1
    else if LoA < LoB then
      Result := -1
    else
      Result := 0;
  end;
{$ENDIF}
end;

function UInt64Sqrt(N: TUInt64): TUInt64;
var
  Rem, Root: TUInt64;
  I: Integer;
begin
  Result := 0;
  if N = 0 then
    Exit;

  if UInt64Compare(N, 4) < 0 then
  begin
    Result := 1;
    Exit;
  end;

  Rem := 0;
  Root := 0;

  for I := 0 to 31 do
  begin
    Root := Root shl 1;
    Inc(Root);

    Rem := Rem shl 2;
    Rem := Rem or (N shr 62);
    N := N shl 2;

    if UInt64Compare(Root, Rem) <= 0 then
    begin
      Rem := Rem - Root;
      Inc(Root);
    end
    else
      Dec(Root);
  end;
  Result := Root shr 1;
end;

function UInt32IsNegative(N: Cardinal): Boolean;
begin
  Result := (N and (1 shl 31)) <> 0;
end;

function UInt64IsNegative(N: TUInt64): Boolean;
begin
{$IFDEF SUPPORT_UINT64}
  Result := (N and (UInt64(1) shl 63)) <> 0;
{$ELSE}
  Result := N < 0;
{$ENDIF}
end;

// �� UInt64 ��ĳһλ�� 1��λ Index �� 0 ��ʼ
procedure UInt64SetBit(var B: TUInt64; Index: Integer);
begin
  B := B or (TUInt64(1) shl Index);
end;

// �� UInt64 ��ĳһλ�� 0��λ Index �� 0 ��ʼ
procedure UInt64ClearBit(var B: TUInt64; Index: Integer);
begin
  B := B and not (TUInt64(1) shl Index);
end;

// ���� UInt64 �ĵڼ�λ�Ƿ��� 1��0 ��ʼ
function GetUInt64BitSet(B: TUInt64; Index: Integer): Boolean;
begin
  B := B and (TUInt64(1) shl Index);
  Result := B <> 0;
end;

// ���� Int64 ���� 1 ����߶�����λ�ǵڼ�λ�����λ�� 0�����û�� 1������ -1
function GetUInt64HighBits(B: TUInt64): Integer;
begin
  if B = 0 then
  begin
    Result := -1;
    Exit;
  end;

  Result := 1;
  if B shr 32 = 0 then
  begin
   Inc(Result, 32);
   B := B shl 32;
  end;
  if B shr 48 = 0 then
  begin
   Inc(Result, 16);
   B := B shl 16;
  end;
  if B shr 56 = 0 then
  begin
    Inc(Result, 8);
    B := B shl 8;
  end;
  if B shr 60 = 0 then
  begin
    Inc(Result, 4);
    B := B shl 4;
  end;
  if B shr 62 = 0 then
  begin
    Inc(Result, 2);
    B := B shl 2;
  end;
  Result := Result - Integer(B shr 63); // �õ�ǰ�� 0 ������
  Result := 63 - Result;
end;

// ���� Cardinal ���� 1 ����߶�����λ�ǵڼ�λ�����λ�� 0�����û�� 1������ -1
function GetUInt32HighBits(B: Cardinal): Integer;
begin
  if B = 0 then
  begin
    Result := -1;
    Exit;
  end;

  Result := 1;
  if B shr 16 = 0 then
  begin
   Inc(Result, 16);
   B := B shl 16;
  end;
  if B shr 24 = 0 then
  begin
    Inc(Result, 8);
    B := B shl 8;
  end;
  if B shr 28 = 0 then
  begin
    Inc(Result, 4);
    B := B shl 4;
  end;
  if B shr 30 = 0 then
  begin
    Inc(Result, 2);
    B := B shl 2;
  end;
  Result := Result - Integer(B shr 31); // �õ�ǰ�� 0 ������
  Result := 31 - Result;
end;

// ���� Int64 ���� 1 ����Ͷ�����λ�ǵڼ�λ�����λ�� 0�����û�� 1������ -1
function GetUInt64LowBits(B: TUInt64): Integer;
var
  Y: TUInt64;
  N: Integer;
begin
  Result := -1;
  if B = 0 then
    Exit;

  N := 63;
  Y := B shl 32;
  if Y <> 0 then
  begin
    Dec(N, 32);
    B := Y;
  end;
  Y := B shl 16;
  if Y <> 0 then
  begin
    Dec(N, 16);
    B := Y;
  end;
  Y := B shl 8;
  if Y <> 0 then
  begin
    Dec(N, 8);
    B := Y;
  end;
  Y := B shl 4;
  if Y <> 0 then
  begin
    Dec(N, 4);
    B := Y;
  end;
  Y := B shl 2;
  if Y <> 0 then
  begin
    Dec(N, 2);
    B := Y;
  end;
  B := B shl 1;
  Result := N - Integer(B shr 63);
end;

// ���� Cardinal ���� 1 ����Ͷ�����λ�ǵڼ�λ�����λ�� 0�����û�� 1������ -1
function GetUInt32LowBits(B: Cardinal): Integer;
var
  Y, N: Integer;
begin
  Result := -1;
  if B = 0 then
    Exit;

  N := 31;
  Y := B shl 16;
  if Y <> 0 then
  begin
    Dec(N, 16);
    B := Y;
  end;
  Y := B shl 8;
  if Y <> 0 then
  begin
    Dec(N, 8);
    B := Y;
  end;
  Y := B shl 4;
  if Y <> 0 then
  begin
    Dec(N, 4);
    B := Y;
  end;
  Y := B shl 2;
  if Y <> 0 then
  begin
    Dec(N, 2);
    B := Y;
  end;
  B := B shl 1;
  Result := N - Integer(B shr 31);
end;

// ��װ�� Int64 Mod��������ֵʱȡ����ģ��ģ��
function Int64Mod(M, N: Int64): Int64;
begin
  if M > 0 then
    Result := M mod N
  else
    Result := N - ((-M) mod N);
end;

// �ж�һ 32 λ�޷��������Ƿ� 2 ����������
function IsUInt32PowerOf2(N: Cardinal): Boolean;
begin
  Result := (N and (N - 1)) = 0;
end;

// �ж�һ 64 λ�޷��������Ƿ� 2 ����������
function IsUInt64PowerOf2(N: TUInt64): Boolean;
begin
  Result := (N and (N - 1)) = 0;
end;

// �õ�һ��ָ�� 32 λ�޷������������ȵ� 2 ���������ݣ�������򷵻� 0
function GetUInt32PowerOf2GreaterEqual(N: Cardinal): Cardinal;
begin
  Result := N - 1;
  Result := Result or (Result shr 1);
  Result := Result or (Result shr 2);
  Result := Result or (Result shr 4);
  Result := Result or (Result shr 8);
  Result := Result or (Result shr 16);
  Inc(Result);
end;

// �õ�һ��ָ�� 64 λ�޷������������ 2 ���������ݣ�������򷵻� 0
function GetUInt64PowerOf2GreaterEqual(N: TUInt64): TUInt64;
begin
  Result := N - 1;
  Result := Result or (Result shr 1);
  Result := Result or (Result shr 2);
  Result := Result or (Result shr 4);
  Result := Result or (Result shr 8);
  Result := Result or (Result shr 16);
  Result := Result or (Result shr 32);
  Inc(Result);
end;

// �ж����� 32 λ�з���������Ƿ���� 32 λ�з�������
function IsInt32AddOverflow(A, B: Integer): Boolean;
var
  C: Integer;
begin
  C := A + B;
  Result := ((A > 0) and (B > 0) and (C < 0)) or   // ͬ�����ҽ��������˵�����������
    ((A < 0) and (B < 0) and (C > 0));
end;

// �ж����� 32 λ�޷���������Ƿ���� 32 λ�޷�������
function IsUInt32AddOverflow(A, B: Cardinal): Boolean;
begin
  Result := (A + B) < A; // �޷�����ӣ����ֻҪС����һ������˵�������
end;

// �ж����� 64 λ�з���������Ƿ���� 64 λ�з�������
function IsInt64AddOverflow(A, B: Int64): Boolean;
var
  C: Int64;
begin
  C := A + B;
  Result := ((A > 0) and (B > 0) and (C < 0)) or   // ͬ�����ҽ��������˵�����������
    ((A < 0) and (B < 0) and (C > 0));
end;

// �ж����� 64 λ�޷���������Ƿ���� 64 λ�޷�������
function IsUInt64AddOverflow(A, B: TUInt64): Boolean;
begin
  Result := UInt64Compare(A + B, A) < 0; // �޷�����ӣ����ֻҪС����һ������˵�������
end;

// ���� 64 λ�޷�������ӣ�A + B => R������������������� 1 ���λ������������
procedure UInt64Add(var R: TUInt64; A, B: TUInt64; out Carry: Integer);
begin
  R := A + B;
  if UInt64Compare(R, A) < 0 then // �޷�����ӣ����ֻҪС����һ������˵�������
    Carry := 1
  else
    Carry := 0;
end;

// ���� 64 λ�޷����������A - B => R������������н�λ������ 1 ���λ������������
procedure UInt64Sub(var R: TUInt64; A, B: TUInt64; out Carry: Integer);
begin
  R := A - B;
  if UInt64Compare(R, A) > 0 then // �޷�����������ֻҪ���ڱ�������˵����λ��
    Carry := 1
  else
    Carry := 0;
end;

// �ж����� 32 λ�з���������Ƿ���� 32 λ�з�������
function IsInt32MulOverflow(A, B: Integer): Boolean;
var
  T: Integer;
begin
  T := A * B;
  Result := (B <> 0) and ((T div B) <> A);
end;

// �ж����� 32 λ�޷���������Ƿ���� 32 λ�޷�������
function IsUInt32MulOverflow(A, B: Cardinal): Boolean;
var
  T: TUInt64;
begin
  T := TUInt64(A) * TUInt64(B);
  Result := (T = Cardinal(T));
end;

// �ж����� 32 λ�޷���������Ƿ���� 64 λ�з���������δ���Ҳ������ False ʱ��R ��ֱ�ӷ��ؽ��
function IsUInt32MulOverflowInt64(A, B: Cardinal; out R: TUInt64): Boolean;
var
  T: Int64;
begin
  T := Int64(A) * Int64(B);
  Result := T < 0; // ������� Int64 ��ֵ��˵�����
  if not Result then
    R := TUInt64(T);
end;

// �ж����� 64 λ�з���������Ƿ���� 64 λ�з�������
function IsInt64MulOverflow(A, B: Int64): Boolean;
var
  T: Int64;
begin
  T := A * B;
  Result := (B <> 0) and ((T div B) <> A);
end;

// ָ������ת�������ͣ�֧�� 32/64 λ
function PointerToInteger(P: Pointer): Integer;
begin
{$IFDEF CPU64BITS}
  // ����ôд������ Pointer �ĵ� 32 λ�� Integer
  Result := Integer(P);
{$ELSE}
  Result := Integer(P);
{$ENDIF}
end;

// ����ת����ָ�����ͣ�֧�� 32/64 λ
function IntegerToPointer(I: Integer): Pointer;
begin
{$IFDEF CPU64BITS}
  // ����ôд������ Pointer �ĵ� 32 λ�� Integer
  Result := Pointer(I);
{$ELSE}
  Result := Pointer(I);
{$ENDIF}
end;

// �� Int64 ��Χ���������ĺ����࣬��������������Ҫ�� N ���� 0
function Int64NonNegativeAddMod(A, B, N: Int64): Int64;
begin
  if IsInt64AddOverflow(A, B) then // ������������ Int64
  begin
    if A > 0 then
    begin
      // A �� B ������ 0������ UInt64 ���ȡģ����δ��� UInt64 ���ޣ���ע�� N δ��� Int64 ���ȡģ���С�� Int64 ���ޣ������ɸ�ֵ
      Result := UInt64NonNegativeAddMod(A, B, N);
    end
    else
    begin
      // A �� B ��С�� 0��ȡ������� UInt64 ���ȡģ������ĺ�δ��� UInt64 ���ޣ���ģ�ٱ�������һ��
{$IFDEF SUPPORT_UINT64}
      Result := UInt64(N) - UInt64NonNegativeAddMod(-A, -B, N);
{$ELSE}
      Result := N - UInt64NonNegativeAddMod(-A, -B, N);
{$ENDIF}
    end;
  end
  else // �������ֱ�Ӽ���������
    Result := Int64NonNegativeMod(A + B, N);
end;

// �� UInt64 ��Χ���������ĺ����࣬��������������Ҫ�� N ���� 0
function UInt64NonNegativeAddMod(A, B, N: TUInt64): TUInt64;
var
  C, D: TUInt64;
begin
  if IsUInt64AddOverflow(A, B) then // ������������
  begin
    C := UInt64Mod(A, N);  // �͸�����ģ
    D := UInt64Mod(B, N);
    if IsUInt64AddOverflow(C, D) then
    begin
      // ������������˵��ģ�������������󣬸�����ģû�á�
      // ������һ���������ڵ��� 2^63��N ������ 2^63 + 1
      // �� = ������ + 2^64
      // �� mod N = ������ mod N + (2^64 - 1) mod N) + 1
      // ���� N ������ 2^63 + 1������������� 2^64 - 2������ǰ������Ӳ������������ֱ����Ӻ��һ����ģ
      Result := UInt64Mod(UInt64Mod(A + B, N) + UInt64Mod(CN_MAX_TUINT64, N) + 1, N);
    end
    else
      Result := UInt64Mod(C + D, N);
  end
  else
  begin
    Result := UInt64Mod(A + B, N);
  end;
end;

function Int64NonNegativeMulMod(A, B, N: Int64): Int64;
var
  Neg: Boolean;
begin
  if N <= 0 then
    raise EDivByZero.Create(SDivByZero);

  // ��ΧС��ֱ����
  if not IsInt64MulOverflow(A, B) then
  begin
    Result := A * B mod N;
    if Result < 0 then
      Result := Result + N;
    Exit;
  end;

  // �������ŵ���
  Result := 0;
  if (A = 0) or (B = 0) then
    Exit;

  Neg := False;
  if (A < 0) and (B > 0) then
  begin
    A := -A;
    Neg := True;
  end
  else if (A > 0) and (B < 0) then
  begin
    B := -B;
    Neg := True;
  end
  else if (A < 0) and (B < 0) then
  begin
    A := -A;
    B := -B;
  end;

  // ��λѭ����
  while B <> 0 do
  begin
    if (B and 1) <> 0 then
      Result := ((Result mod N) + (A mod N)) mod N;

    A := A shl 1;
    if A >= N then
      A := A mod N;

    B := B shr 1;
  end;

  if Neg then
    Result := N - Result;
end;

function UInt64NonNegativeMulMod(A, B, N: TUInt64): TUInt64;
begin
  Result := 0;
  if (UInt64Compare(A, CN_MAX_UINT32) <= 0) and (UInt64Compare(B, CN_MAX_UINT32) <= 0) then
  begin
    Result := UInt64Mod(A * B, N); // �㹻С�Ļ�ֱ�ӳ˺���ģ
  end
  else
  begin
    while B <> 0 do
    begin
      if (B and 1) <> 0 then
        Result := UInt64NonNegativeAddMod(Result, A, N);

      A := UInt64NonNegativeAddMod(A, A, N);
      // �����ô�ͳ�㷨��� A := A shl 1������ N ���� mod N����Ϊ�����

      B := B shr 1;
    end;
  end;
end;

// ��װ�ķǸ����ຯ����Ҳ��������Ϊ��ʱ���Ӹ������������������豣֤ P ���� 0
function Int64NonNegativeMod(N: Int64; P: Int64): Int64;
begin
  if P <= 0 then
    raise EDivByZero.Create(SDivByZero);

  Result := N mod P;
  if Result < 0 then
    Inc(Result, P);
end;

// Int64 �ķǸ�����ָ����
function Int64NonNegativPower(N: Int64; Exp: Integer): Int64;
var
  T: Int64;
begin
  if Exp < 0 then
    raise ERangeError.Create(SRangeError)
  else if Exp = 0 then
  begin
    if N <> 0 then
      Result := 1
    else
      raise EDivByZero.Create(SDivByZero);
  end
  else if Exp = 1 then
    Result := N
  else
  begin
    Result := 1;
    T := N;

    while Exp > 0 do
    begin
      if (Exp and 1) <> 0 then
        Result := Result * T;

      Exp := Exp shr 1;
      T := T * T;
    end;
  end;
end;

function Int64NonNegativeRoot(N: Int64; Exp: Integer): Int64;
var
  I: Integer;
  X: Int64;
  X0, X1: Extended;
begin
  if (Exp < 0) or (N < 0) then
    raise ERangeError.Create(SRangeError)
  else if Exp = 0 then
    raise EDivByZero.Create(SDivByZero)
  else if (N = 0) or (N = 1) then
    Result := N
  else if Exp = 2 then
    Result := UInt64Sqrt(N)
  else
  begin
    // ţ�ٵ��������
    I := GetUInt64HighBits(N) + 1; // �õ���Լ Log2 N ��ֵ
    I := (I div Exp) + 1;
    X := 1 shl I;                  // �õ�һ���ϴ�� X0 ֵ��Ϊ��ʼֵ

    X0 := X;
    X1 := X0 - (Power(X0, Exp) - N) / (Exp * Power(X0, Exp - 1));

    while True do
    begin
      if (Trunc(X0) = Trunc(X1)) and (Abs(X0 - X1) < 0.001) then
      begin
        Result := Trunc(X1); // Trunc ֻ֧�� Int64�������˻����
        Exit;
      end;

      X0 := X1;
      X1 := X0 - (Power(X0, Exp) - N) / (Exp * Power(X0, Exp - 1));
    end;
  end;
end;

function UInt64NonNegativPower(N: TUInt64; Exp: Integer): TUInt64;
var
  T, RL, RH: TUInt64;
begin
  if Exp < 0 then
    raise ERangeError.Create(SRangeError)
  else if Exp = 0 then
  begin
    if N <> 0 then
      Result := 1
    else
      raise EDivByZero.Create(SDivByZero);
  end
  else if Exp = 1 then
    Result := N
  else
  begin
    Result := 1;
    T := N;

    while Exp > 0 do
    begin
      if (Exp and 1) <> 0 then
      begin
        UInt64MulUInt64(Result, T, RL, RH);
        Result := RL;
      end;

      Exp := Exp shr 1;
      UInt64MulUInt64(T, T, RL, RH);
      T := RL;
    end;
  end;
end;

function UInt64NonNegativeRoot(N: TUInt64; Exp: Integer): TUInt64;
var
  I: Integer;
  X: TUInt64;
  XN, X0, X1: Extended;
begin
  if Exp < 0 then
    raise ERangeError.Create(SRangeError)
  else if Exp = 0 then
    raise EDivByZero.Create(SDivByZero)
  else if (N = 0) or (N = 1) then
    Result := N
  else if Exp = 2 then
    Result := UInt64Sqrt(N)
  else
  begin
    // ţ�ٵ��������
    I := GetUInt64HighBits(N) + 1; // �õ���Լ Log2 N ��ֵ
    I := (I div Exp) + 1;
    X := 1 shl I;                  // �õ�һ���ϴ�� X0 ֵ��Ϊ��ʼֵ

    X0 := UInt64ToExtended(X);
    XN := UInt64ToExtended(N);
    X1 := X0 - (Power(X0, Exp) - XN) / (Exp * Power(X0, Exp - 1));

    while True do
    begin
      if (ExtendedToUInt64(X0) = ExtendedToUInt64(X1)) and (Abs(X0 - X1) < 0.001) then
      begin
        Result := ExtendedToUInt64(X1);
        Exit;
      end;

      X0 := X1;
      X1 := X0 - (Power(X0, Exp) - XN) / (Exp * Power(X0, Exp - 1));
    end;
  end;
end;

function IsUInt128BitSet(Lo, Hi: TUInt64; N: Integer): Boolean;
begin
  if N < 64 then
    Result := (Lo and (TUInt64(1) shl N)) <> 0
  else
  begin
    Dec(N, 64);
    Result := (Hi and (TUInt64(1) shl N)) <> 0;
  end;
end;

procedure SetUInt128Bit(var Lo, Hi: TUInt64; N: Integer);
begin
  if N < 64 then
    Lo := Lo or (TUInt64(1) shl N)
  else
  begin
    Dec(N, 64);
    Hi := Hi or (TUInt64(1) shl N);
  end;
end;

procedure ClearUInt128Bit(var Lo, Hi: TUInt64; N: Integer);
begin
  if N < 64 then
    Lo := Lo and not (TUInt64(1) shl N)
  else
  begin
    Dec(N, 64);
    Hi := Hi and not (TUInt64(1) shl N);
  end;
end;

function UnsignedAddWithLimitRadix(A, B, C: Cardinal; var R: Cardinal;
  L, H: Cardinal): Cardinal;
begin
  R := A + B + C;
  if R > H then         // �н�λ
  begin
    A := H - L + 1;     // �õ�����
    B := R - L;         // �õ����� L ��ֵ

    Result := B div A;  // �������Ƶĵڼ����ͽ���
    R := L + (B mod A); // ȥ�����ƺ����������������
  end
  else
    Result := 0;
end;

procedure InternalQuickSort(Mem: Pointer; L, R: Integer; ElementByteSize: Integer;
  CompareProc: TCnMemSortCompareProc);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while CompareProc(Pointer(TCnNativeInt(Mem) + I * ElementByteSize),
        Pointer(TCnNativeInt(Mem) + P * ElementByteSize), ElementByteSize) < 0 do
        Inc(I);
      while CompareProc(Pointer(TCnNativeInt(Mem) + J * ElementByteSize),
        Pointer(TCnNativeInt(Mem) + P * ElementByteSize), ElementByteSize) > 0 do
        Dec(J);

      if I <= J then
      begin
        MemorySwap(Pointer(TCnNativeInt(Mem) + I * ElementByteSize),
          Pointer(TCnNativeInt(Mem) + J * ElementByteSize), ElementByteSize);

        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;

    if L < J then
      InternalQuickSort(Mem, L, J, ElementByteSize, CompareProc);
    L := I;
  until I >= R;
end;

function DefaultCompareProc(P1, P2: Pointer; ElementByteSize: Integer): Integer;
begin
  Result := MemoryCompare(P1, P2, ElementByteSize);
end;

procedure MemoryQuickSort(Mem: Pointer; ElementByteSize: Integer;
  ElementCount: Integer; CompareProc: TCnMemSortCompareProc);
begin
  if (Mem <> nil) and (ElementCount > 0) and (ElementCount > 0) then
  begin
    if Assigned(CompareProc) then
      InternalQuickSort(Mem, 0, ElementCount - 1, ElementByteSize, CompareProc)
    else
      InternalQuickSort(Mem, 0, ElementCount - 1, ElementByteSize, DefaultCompareProc);
  end;
end;

initialization
  FByteOrderIsBigEndian := CurrentByteOrderIsBigEndian;

end.
