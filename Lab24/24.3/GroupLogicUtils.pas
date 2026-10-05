UNIT GroupLogicUtils;

INTERFACE

FUNCTION FindRoot(Word: STRING): STRING;
FUNCTION IsGreater(Str1, Str2: STRING): BOOLEAN;

IMPLEMENTATION

CONST
  MaxEndLen = 4;
  MinWordLength = 2;
  EndingsCount = 60;
  Alphabet = '-abcdefghijklmnopqrstuvwxyzабвгдеёжзийклмнопрстуфхцчшщъыьэюя';
TYPE
  EndingsArray = ARRAY[1 .. EndingsCount] OF STRING;
CONST
  Endings: EndingsArray = (
    'иями', 'оями',
    'иям', 'иях', 'оях', 'ями', 'оям', 'ами', 'его', 
    'ему', 'ими', 'ого', 'ому', 'ыми', 'оев', 'ией',
    'ьев',
    'ая', 'яя', 'ях', 'юю', 'ах', 'ею', 'их', 'ия', 'ию', 
    'ою', 'ую', 'ям', 'ых', 'ея', 'ам', 'ем', 'ей', 'ев', 
    'ий', 'им', 'ое', 'ой', 'ом', 'ов', 'ые', 'ый', 'ым', 
    'ми', 'ёв', 'ём', 'ья', 'ье', 'ьи', 'ью',
    'а', 'е', 'и', 'о', 'у', 'й', 'ы', 'я', 'ь'
  );
  Empty = '';

FUNCTION EndsWith(Str, Ending: STRING): BOOLEAN;
{ Проверяет, заканчивается ли строка на окончание }
VAR
  StrLen, EndLen, Index: INTEGER;
BEGIN { EndsWith }
  StrLen := LENGTH(Str);
  EndLen := LENGTH(Ending);
  EndsWith := FALSE;
  IF StrLen > EndLen 
  THEN
    BEGIN
      EndsWith := TRUE;
      FOR Index := 1 TO EndLen 
      DO
        IF Str[StrLen - EndLen + Index] <> Ending[Index] 
        THEN
          EndsWith := FALSE
    END
END; { EndsWith }

FUNCTION CutEnding(Word: STRING; EndLen: INTEGER): STRING;
{ Отрезает окончание заданной длины }
VAR
  Index: INTEGER;
  Res: STRING;
BEGIN { CutEnding }
  Res := Empty;
  FOR Index := 1 TO LENGTH(Word) - EndLen 
  DO
    Res := Res + Word[Index];
  CutEnding := Res
END; { CutEnding }

FUNCTION TryRemoveEnding(Word: STRING; TargetLen: INTEGER): STRING;
{ Пытается удалить окончание конкретной длины }
VAR
  Index: INTEGER;
  Found: BOOLEAN;
  Res: STRING;
BEGIN { TryRemoveEnding }
  Res := Word;
  Found := FALSE;
  Index := 1;
  WHILE (Index <= EndingsCount) AND NOT Found 
  DO
    BEGIN
      IF (LENGTH(Endings[Index]) = TargetLen) AND EndsWith(Word, Endings[Index])  
      THEN
        BEGIN
          Res := CutEnding(Word, TargetLen);
          Found := TRUE
        END;
      Index := Index + 1
    END;  
  TryRemoveEnding := Res
END; { TryRemoveEnding }

FUNCTION FindRoot(Word: STRING): STRING;
{ Находит корень слова - пробует от длинных окончаний к коротким }
VAR
  Res: STRING;
  EndingLen: INTEGER;
  Found: BOOLEAN;
BEGIN { FindRoot }
  Res := Word;  
  IF LENGTH(Word) >= MinWordLength 
  THEN
    BEGIN
      Found := FALSE;
      EndingLen := MaxEndLen;
      WHILE (EndingLen >= 1) AND NOT Found 
      DO
        BEGIN
          IF LENGTH(Word) > EndingLen 
          THEN
            BEGIN
              Res := TryRemoveEnding(Word, EndingLen);
              IF Res <> Word 
              THEN
                Found := TRUE
            END;
          EndingLen := EndingLen - 1
        END
    END;  
  FindRoot := Res
END; { FindRoot }

FUNCTION GetDiffIndex(Str1, Str2: STRING): INTEGER;
{ Находит позицию первого различия }
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
{ Сравнивает два символа }
BEGIN { CompareChars }
  CompareChars := POS(Ch1, Alphabet) > POS(Ch2, Alphabet)
END; { CompareChars }

FUNCTION IsGreater(Str1, Str2: STRING): BOOLEAN;
{ Сравнивает две строки }
VAR
  DiffPos: INTEGER;
BEGIN { IsGreater }
  DiffPos := GetDiffIndex(Str1, Str2);
  IF DiffPos <> 0 
  THEN
    IsGreater := CompareChars(Str1[DiffPos], Str2[DiffPos])
  ELSE
    IsGreater := LENGTH(Str1) > LENGTH(Str2)
END; { IsGreater }

BEGIN { GroupLogicUtils }
END. { GroupLogicUtils }
