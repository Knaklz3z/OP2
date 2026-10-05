PROGRAM WriteSum(INPUT, OUTPUT);

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

PROCEDURE CalculateSum(VAR Digit, Sum: INTEGER; VAR Overflow: BOOLEAN);
{ Считай сумму чисел пока не будет переполнение или нецифровой символ }
BEGIN { CalculateSum }
  WHILE Digit <> -1
  DO
    BEGIN
      IF Sum > MAXINT - Digit
      THEN
        BEGIN
          Digit := -1;
          Overflow := TRUE
        END
      ELSE
        BEGIN
          Sum := Sum + Digit;
          ReadDigit(INPUT, Digit)
        END  
    END
END; { CalculateSum }

PROCEDURE WriteOutput(VAR Sum: INTEGER; VAR Overflow: BOOLEAN);
{ Вывод суммы если не переполнение }
BEGIN { SumOutput }
  IF Overflow
  THEN
    WRITELN('Overflow')
  ELSE
    WRITELN('Сумма = ', Sum)
END; { SumOutput }

PROCEDURE RunReadDigit;
VAR
  Sum, Digit: INTEGER;
  Overflow: BOOLEAN;    
BEGIN { RunReadDigit }
  Sum := 0;
  Digit := 0;
  CalculateSum(Digit, Sum, Overflow);
  WriteOutput(Sum, Overflow)    
END; { RunReadDigit }

BEGIN { WriteSum }
  RunReadDigit
END. { WriteSum }
