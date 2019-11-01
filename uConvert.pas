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

unit uConvert;

interface

uses
  System.SysUtils;

type
  TConvertString = class
  private const
    Koi8R = 'þàáöäåôãõèéêëìíîïÿðñòóæâüûçøýù÷úÞÀÁÖÄÅÔÃÕÈÉÊËÌÍÎÏßÐÑÒÓÆÂÜÛÇØÝÙ×Ú';
    Win1251 = 'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ';
  public
    class function Win1251ToKoi8R(const Str: string): string;
    class function Koi8RToWin1251(const Str: string): string;
  end;

implementation

{ TConvertString }
{
  TStringHelper work only 0-based strings. IndexOf + Chars
  Low and High autodetect 1 or 0 - based string for Platform
}
class function TConvertString.Koi8RToWin1251(const Str: string): string;
var
  I: integer;
begin
  Result := Str;
  for I := Low(Result) to High(Result) do
    if Koi8R.IndexOf(Result[I]) > -1 then
      Result[I] := Win1251.Chars[Koi8R.IndexOf(Result[I])];
end;

class function TConvertString.Win1251ToKoi8R(const Str: string): string;
var
  I: integer;
begin
  Result := Str;
  for I := Low(Result) to High(Result) do
    if Win1251.IndexOf(Result[I]) > -1 then
      Result[I] := Koi8R.Chars[Win1251.IndexOf(Result[I])];
end;

end.
