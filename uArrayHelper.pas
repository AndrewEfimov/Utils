{ *********************************************************************
  *
  * Autor: Efimov A.A.
  * E-mail: infocean@gmail.com
  * GitHub: https://github.com/AndrewEfimov
  * Requirements: -
  * Platform: Android, Windows
  * IDE: Delphi 10.1 Berlin +
  *
  ******************************************************************** }

unit uArrayHelper;

interface

uses
  System.Math, System.SysUtils;

type
  TArrayHelper = class
  public
    /// <summary>—оздаЄм массив (длина - ALength) и заполн€ем по пор€дку начина€ с AStart, перемешиваем массив</summary>
    class function CreateMixIntArray(const AStart, ALength: Integer): TArray<Integer>;
    /// <summary>—оздаЄм массив (длина - ALength) и заполн€ем рандомными неповтор€ющимис€ числами в промежутке от AFrom до ATo</summary>
    class function CreateRandIntArray(const AFrom, ATo, ALength: Integer): TArray<Integer>;
    /// <summary>ѕеремешиваем значени€ массива любого типа</summary>
    class procedure MixArray<T>(var AArray: TArray<T>);
  end;

implementation

{ TArrayHelper }

class function TArrayHelper.CreateMixIntArray(const AStart, ALength: Integer): TArray<Integer>;
var
  I: Integer;
begin
  SetLength(Result, ALength);

  // Initialize array
  for I := Low(Result) to High(Result) do
    Result[I] := AStart + I;

  // Mix array
  MixArray<Integer>(Result);
end;

class function TArrayHelper.CreateRandIntArray(const AFrom, ATo, ALength: Integer): TArray<Integer>;
var
  I, J: Integer;
begin
  if (ATo - AFrom + 1) < ALength then
    raise Exception.Create('ƒиапазон меньше длины массива');

  SetLength(Result, ALength);

  for I := Low(Result) to High(Result) do
  begin
    Result[I] := RandomRange(AFrom, ATo + 1);

    // Check for duplicates
    J := 0;
    while J < I do
      if Result[J] = Result[I] then
      begin
        Result[I] := RandomRange(AFrom, ATo + 1);
        J := 0;
      end
      else
        Inc(J);
  end;
end;

class procedure TArrayHelper.MixArray<T>(var AArray: TArray<T>);
var
  I, RandomIndex: Integer;
  TempValue: T;
begin
  for I := Low(AArray) to High(AArray) do
  begin
    RandomIndex := RandomRange(Low(AArray), High(AArray) + 1);

    TempValue := AArray[I];
    AArray[I] := AArray[RandomIndex];
    AArray[RandomIndex] := TempValue;
  end;
end;

end.
