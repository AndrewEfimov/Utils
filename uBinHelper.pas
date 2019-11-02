{ *********************************************************************
  *
  * Autor: Efimov A.A.
  * E-mail: infocean@gmail.com
  * GitHub: https://github.com/AndrewEfimov
  * Platform (Tested): Android, Windows 10 x64
  * IDE (Tested): Delphi 10.3.1
  * Change: 02.11.2019
  *
  ******************************************************************** }

unit uBinHelper;

interface

uses
  System.SysUtils, System.RegularExpressions;

type
  TBinHelper = class
  private const
    BitsInByte = 8;
    BinPattern = '^([01]{1,64})$';
  public
    /// <summary> Количество установленных бит </summary>
    class function BitCount(const AValue: Int64; AIsByte: Boolean): Integer;
    /// <summary> 0001 0100 0000 0101 = 5125 </summary>
    class function BinToDec(const AValue: string): Int64;
    /// <summary> 5125 = 0001 0100 0000 0101 </summary>
    class function DecToBinStr(const AValue: Int64; ABits: Integer): string; overload;
    /// <summary> 0..255 = 0000 0000 .. 1111 1111 </summary>
    class function DecToBinStr(const AValue: Byte): string; overload;
  end;

implementation

{ TBinHelper }

class function TBinHelper.BitCount(const AValue: Int64; AIsByte: Boolean): Integer;
var
  I, SizeBitsAValue: Integer;
begin
  Result := 0;

  if AIsByte then
    SizeBitsAValue := BitsInByte
  else
    SizeBitsAValue := SizeOf(AValue) * BitsInByte;

  for I := 0 to SizeBitsAValue - 1 do
    if AValue and (Int64(1) shl I) > 0 then
      Inc(Result);
end;

class function TBinHelper.BinToDec(const AValue: string): Int64;
var
  I: Integer;
begin
  if not TRegEx.IsMatch(AValue, BinPattern) then
    raise Exception.Create('Допускаются только "1" и "0", длина до 64 символов');

  Result := 0;
  (*
    Используются побитовые операции 'shl'(сдвиг влево) и 'or'(сложение)
    Пример: 1110 0110 -> 230
    AValue[8]    = 0
    7. 0000 0010 = 2
    6. 0000 0100 = 4
    AValue[5]    = 0
    AValue[4]    = 0
    3. 0010 0000 = 32
    2. 0100 0000 = 64
    1. 1000 0000 = 128
    Result = 2+4+32+64+128 = 230
  *)
  for I := High(AValue) downto Low(AValue) do
    if AValue[I] = '1' then
      Result := Result or (Int64(1) shl (High(AValue) - I));
end;

class function TBinHelper.DecToBinStr(const AValue: Int64; ABits: Integer): string;
var
  I: Integer;
begin
  Result := '';
  (*
    Используются побитовые операции 'shl'(сдвиг влево) и 'and'(умножение)
    Пример: 213 (8 bit) -> 11010101
    0. 1101 0101 * (0000 0001) = 1
    1. 1101 0101 * (0000 0010) = 0
    2. 1101 0101 * (0000 0100) = 1
    3. 1101 0101 * (0000 1000) = 0
    4. 1101 0101 * (0001 0000) = 1
    5. 1101 0101 * (0010 0000) = 0
    6. 1101 0101 * (0100 0000) = 1
    7. 1101 0101 * (1000 0000) = 1
  *)
  for I := 0 to ABits - 1 do
    if AValue and (Int64(1) shl I) > 0 then
      Result := '1' + Result
    else
      Result := '0' + Result;
end;

class function TBinHelper.DecToBinStr(const AValue: Byte): string;
begin
  Result := DecToBinStr(AValue, BitsInByte);
end;

end.
