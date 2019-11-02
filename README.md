# Utils

Helper classes (for Android and Windows) - Вспомогательные классы (для Android и Windows)

uIPv4Helper:
* **class function DecToIpv4(const AValue: Cardinal): string;** - 3232235777 -> 192.168.1.1 
* **class function Ipv4ToDec(const AValue: string): Cardinal;** - 192.168.1.1 -> 3232235777
* **class function GetPossibleSubnetMasks(): TArray<string>;** - Получаем список всех возможных масок подсети
* **class function InverseSubnetMask(const AValue: string): string;** - 255.255.252.0 -> 0.0.3.255
* **class function IPv4ToBinStr(const AValue: string; AddSeparator: Boolean = True): string;** - 192.168.1.2 -> 11000000.10101000.00000001.00000010
* **class function GetNetworkAddress(const IPValue, SubnetMaskValue: string): string;** - Получение Адреса сети исходя из Ip-адреса и маски подсети
* **class function GetBroadcastAddress(const IPValue, SubnetMaskValue: string): string;** - Получение Широковещательного адреса исходя из Ip-адреса и маски подсети
* **class function GetIPAddressOfFirstHost(const IPValue, SubnetMaskValue: string): string;** - Получение Адреса для первого хоста исходя из Ip-адреса и маски подсети
* **class function GetIPAddressOfLastHost(const IPValue, SubnetMaskValue: string): string;** - Получение Адреса для последнего хоста исходя из Ip-адреса и маски подсети
* **class function GetNumberAvailableIPAddresses(const SubnetMaskValue: string): Int64;** - Получение Количества адресов в подсети исходя из маски подсети

uBinHelper:
* **class function BitCount(const AValue: Int64; AIsByte: Boolean): Integer;** - Количество установленных бит
* **class function BinToDec(const AValue: string): Int64;** - 0001 0100 0000 0101 = 5125
* **class function DecToBinStr(const AValue: Int64; ABits: Integer): string; overload;** - 5125 = 0001 0100 0000 0101
* **class function DecToBinStr(const AValue: Byte): string; overload;** - 0..255 = 0000 0000 .. 1111 1111

uArrayHelper:
* **class function CreateShuffledIntArray(const AStart, ALength: Integer): TArray<Integer>;** - Создаём массив (длина - ALength) и заполняем по порядку начиная с AStart, перемешиваем массив
* **class function CreateRandIntArray(const AFrom, ATo, ALength: Integer): TArray<Integer>;** - Создаём массив (длина - ALength) и заполняем рандомными неповторяющимися числами в промежутке от AFrom до ATo
* **class procedure ShuffleArray<T>(var AArray: TArray<T>);** - Перемешиваем значения массива любого типа




uConvert:
* **class function Win1251ToKoi8R(const Str: string): string;**
* **class function Koi8RToWin1251(const Str: string): string;**

uParsing:
* **class function FirstMatch(const Str, TagBegin, TagEnd: string): string;** - Находим первое совпадение и вырезаем строку между TagBegin и TagEnd
* **class function AllMatches(const Str, TagBegin, TagEnd: string; Position: Integer): TStringList;** - Находим все совпадения начиная с Position и вырезаем строки между TagBegin и TagEnd



Delphi 10.1 Berlin +