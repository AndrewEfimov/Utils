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

unit uParsing;

interface

uses
  System.Classes, StrUtils;

type
  TParse = class
  private
    /// <summary>„истим строку от тегов</summary>
    class procedure ClearString(var Str: string);
  public
    /// <summary>Ќаходим первое совпадение и вырезаем строку между TagBegin и TagEnd</summary>
    class function FirstMatch(const Str, TagBegin, TagEnd: string): string;
    /// <summary>Ќаходим все совпадени€ начина€ с Position и вырезаем строки между TagBegin и TagEnd</summary>
    class function AllMatches(const Str, TagBegin, TagEnd: string; Position: Integer): TStringList;
  end;

implementation

{ TParse }

class function TParse.AllMatches(const Str, TagBegin, TagEnd: string; Position: Integer): TStringList;
var
  PosStart, PosFinish, LengthString: Integer;
  GetString: string;
begin
  Result := TStringList.Create;

  PosStart := PosEx(TagBegin, Str, Position);

  while PosStart <> 0 do
  begin
    PosFinish := PosEx(TagEnd, Str, PosStart);
    LengthString := PosFinish - PosStart;

    GetString := Copy(Str, PosStart + Length(TagBegin), LengthString - Length(TagBegin));
    ClearString(GetString);

    Result.Add(GetString);

    PosStart := PosEx(TagBegin, Str, PosFinish);
  end;
end;

class procedure TParse.ClearString(var Str: string);
const
  ListTags: array [0 .. 3] of string = ('<nobr>', '</nobr>', '<b>', '</b>');
var
  I: Integer;
begin
  for I := 0 to Length(ListTags) - 1 do
    Str := ReplaceStr(Str, ListTags[I], '');
end;

class function TParse.FirstMatch(const Str, TagBegin, TagEnd: string): string;
var
  PosStart, PosFinish: Integer;
begin
  PosStart := Pos(TagBegin, Str);

  if PosStart <> 0 then
  begin
    PosFinish := PosEx(TagEnd, Str, PosStart) - PosStart;

    Result := Copy(Str, PosStart + Length(TagBegin), PosFinish - Length(TagBegin));
  end;
end;

end.
