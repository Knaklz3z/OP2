UNIT LogicUtils;

INTERFACE

FUNCTION IsAllowedChar(Ch: CHAR): BOOLEAN;
FUNCTION IsGreater(Str1, Str2: STRING): BOOLEAN;

IMPLEMENTATION

CONST
  AllowedChars = ['a' .. 'z', 'A' .. 'Z', 'а' .. 'я', 'А' .. 'Я', 'ё', 'Ё', '-'];
  Alphabet = '-abcdefghijklmnopqrstuvwxyzабвгдеёжзийклмнопрстуфхцчшщъыьэюя';

FUNCTION IsAllowedChar(Ch: CHAR): BOOLEAN;
{ Проверяет букву или допустимый дефис }
BEGIN { IsAllowedCHAR }
  IsAllowedChar := Ch IN AllowedChars
END; { IsAllowedCHAR }

FUNCTION GetDiffIndex(Str1, Str2: STRING): INTEGER;
{ Находит позицию первого отличающегося символа }
VAR
  Index, MinLen: INTEGER;
BEGIN { GetDiffIndex }
  IF LENGTH(Str1) < LENGTH(Str2) 
  THEN 
    MinLen := LENGTH(Str1) 
  ELSE 
    MinLen := LENGTH(Str2);
  Index := 1;
  WHILE (Index <= MinLen) AND (Str1[Index] = Str2[Index]) 
  DO
    Index := Index + 1;
  IF Index > MinLen 
  THEN 
    GetDiffIndex := 0 
  ELSE 
    GetDiffIndex := Index
END; { GetDiffIndex }

FUNCTION CompareChars(Ch1, Ch2: CHAR): BOOLEAN;
{ Сравнивает порядок двух символов }
BEGIN { CompareChars }
  CompareChars := POS(Ch1, Alphabet) > POS(Ch2, Alphabet)
END; { CompareChars }

FUNCTION IsGreater(Str1, Str2: STRING): BOOLEAN;
{ Сравнивает две строки и если 1-я больше 2-й, то TRUE }
VAR 
  DifIndex: INTEGER;
BEGIN { IsGreater }
  DifIndex := GetDiffIndex(Str1, Str2);
  IF DifIndex <> 0 
  THEN
    IsGreater := CompareChars(Str1[DifIndex], Str2[DifIndex])
  ELSE
    IsGreater := LENGTH(Str1) > LENGTH(Str2)
END; { IsGreater }

BEGIN { LogicUtils }
END. { LogicUtils }
