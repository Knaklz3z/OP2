PROGRAM WriteNumber(INPUT, OUTPUT);

PROCEDURE ChToInt(VAR Ch: CHAR; VAR D: INTEGER);
{ Перевод числа из типа CHAR в тип INTEGER }
BEGIN { ChToInt }
  IF Ch = '0' THEN D := 0 ELSE
  IF Ch = '1' THEN D := 1 ELSE
  IF Ch = '2' THEN D := 2 ELSE
  IF Ch = '3' THEN D := 3 ELSE
  IF Ch = '4' THEN D := 4 ELSE
  IF Ch = '5' THEN D := 5 ELSE
  IF Ch = '6' THEN D := 6 ELSE
  IF Ch = '7' THEN D := 7 ELSE
  IF Ch = '8' THEN D := 8 ELSE
  IF Ch = '9' THEN D := 9
END; { ChToInt }

PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
{ Считывает текущий символ из файла. Если он - цифра, возвращает его
  преобразуя в значение типа INTEGER. Если считанный символ не цифра
  возвращает -1 }
VAR
  Ch: CHAR;
BEGIN { ReadDigit }
  D := -1;
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      ChToInt(Ch, D)
    END    
END; { ReadDigit }

PROCEDURE CalculatingNumber(VAR F: TEXT; VAR Digit, N: INTEGER);
VAR
  Overflow: BOOLEAN;
{ Создание числа, пока не будет получено переполнение или нечисловое значение }
BEGIN { CalculatingNumber } 
  WHILE (Digit <> -1) AND (N <> -2)
  DO
    BEGIN
      Overflow := (N > (MAXINT DIV 10)) OR ((N >= (MAXINT DIV 10)) AND (Digit > (MAXINT MOD 10)));
      IF Overflow
      THEN
        N := -2
      ELSE
        N := N * 10 + Digit;
      ReadDigit(F, Digit)
    END
END; { CalculatingNumber }

PROCEDURE ReadNumber(VAR F: TEXT; VAR N: INTEGER);
{ Преобразует строку цифр из файла до первого нецифрового символа,
  в соответсвующее целое число N }
VAR
  Digit: INTEGER;  
BEGIN { ReadNumber }
  N := -1;
  Digit := 0;
  IF NOT EOLN(F)
  THEN
    BEGIN
      ReadDigit(F, Digit);
      IF Digit <> -1
      THEN
        N := 0;
      CalculatingNumber(F, Digit, N)
    END
END; { ReadNumber }  

PROCEDURE RunReadNumber;
VAR
  Number: INTEGER; 
BEGIN { RunReadNumber }
  ReadNumber(INPUT, Number);
  WRITELN(Number)    
END; { RunReadNumber }

BEGIN { WriteNumber }
  RunReadNumber
END. { WriteNumber }
