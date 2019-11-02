{ *********************************************************************
  *
  * Autor: Efimov A.A.
  * E-mail: infocean@gmail.com
  * GitHub: https://github.com/AndrewEfimov
  * Platform (Tested): Android, Windows 10 x64
  * IDE (Tested): Delphi 10.3.1
  * Change: 03.11.2019
  *
  ******************************************************************** }

unit uArrayHelper;

interface

uses
  System.Math, System.SysUtils;

type
  TArrayHelper = class
  private
    class constructor Create;
  public
    /// <summary>Returns a shuffled array filled in order, starting with AStart</summary>
    class function CreateShuffledIntArray(const AStart, ALength: Integer): TArray<Integer>;
    /// <summary>
    /// Returns an array filled with random non-repeating numbers ranging from AFrom (inclusive) to ATo (inclusive).
    /// Negative ranges are supported.
    ///</summary>
    class function CreateRandIntArray(const AFrom, ATo, ALength: Integer): TArray<Integer>;
    /// <summary>Shuffle array values</summary>
    class procedure ShuffleArray<T>(var AArray: TArray<T>);
  end;

implementation

{ TArrayHelper }

class constructor TArrayHelper.Create;
begin
  Randomize;
end;

class function TArrayHelper.CreateShuffledIntArray(const AStart, ALength: Integer): TArray<Integer>;
var
  I: Integer;
begin
  if ALength <= 0 then
    raise Exception.Create(Format('Length (%d) is less than or equal to 0.', [ALength]));

  SetLength(Result, ALength);
  for I := Low(Result) to High(Result) do
    Result[I] := AStart + I;

  ShuffleArray<Integer>(Result);
end;

class function TArrayHelper.CreateRandIntArray(const AFrom, ATo, ALength: Integer): TArray<Integer>;
var
  I, J: Integer;
  RangeCalc: Integer;
  AFromInclusive, AToInclusive: Integer;
begin
  if ALength <= 0 then
    raise Exception.Create(Format('Length (%d) is less than or equal to 0.', [ALength]));

  RangeCalc := abs(ATo - AFrom) + 1;

  if RangeCalc < ALength then
    raise Exception.Create(Format('Range(%d .. %d) smaller array length (%d).', [AFrom, ATo, ALength]));

  AToInclusive := ATo;
  AFromInclusive := AFrom;

  if ATo > AFrom then
    AToInclusive := ATo + 1
  else
    AFromInclusive := AFrom + 1;

  SetLength(Result, ALength);

  for I := Low(Result) to High(Result) do
  begin
    Result[I] := RandomRange(AFromInclusive, AToInclusive);

    // Check for duplicates
    J := 0;
    while J < I do
      if Result[J] = Result[I] then
      begin
        Result[I] := RandomRange(AFromInclusive, AToInclusive);
        J := 0;
      end
      else
        Inc(J);
  end;
end;

class procedure TArrayHelper.ShuffleArray<T>(var AArray: TArray<T>);
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
