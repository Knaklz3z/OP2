PROGRAM Stat(INPUT, OUTPUT);
{ Определяет количество найденных чисел, минимальное, максимальное и среднее арифметическое }
  
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

PROCEDURE CalculatingNumber(VAR F: TEXT; VAR Digit, Number: INTEGER);
{ Создание числа, пока не будет получено переполнение или нечисловое значение }
BEGIN { CalculatingNumber }
  WHILE (Digit <> -1) AND (Number <> -2)
  DO
    BEGIN
      IF (Number > (MAXINT DIV 10)) OR ((Number >= (MAXINT DIV 10)) AND (Digit > (MAXINT MOD 10)))
      THEN
        Number := -2
      ELSE
        Number := Number * 10 + Digit;
      ReadDigit(F, Digit)
    END
END; { CalculatingNumber }

PROCEDURE ReadNumber(VAR F: TEXT; VAR Number: INTEGER);
{ Преобразует строку цифр из файла до первого нецифрового символа,
  в соответсвующее целое число N }
VAR
  Digit: INTEGER;  
BEGIN { ReadNumber }
  Number := -1;
  Digit := 0;
  IF NOT EOLN(F)
  THEN
    BEGIN
      ReadDigit(F, Digit);
      IF Digit <> -1
      THEN
        Number := 0;
      CalculatingNumber(F, Digit, Number)
    END
END; { ReadNumber }

PROCEDURE CheckMinNumber(VAR Num, Min: INTEGER);
{ Сравниваем число с наименьшим, если меньше - становится наименьшим }
BEGIN { MinNumber }
  IF Num < Min
  THEN
    Min := Num
END; { MinNumber }

PROCEDURE CheckMaxNumber(VAR Num, Max: INTEGER);
{ Сравниваем число с наибольшим, если больше - становится наибольшим }
BEGIN { MaxNumber }
  IF Num > Max
  THEN
    Max := Num
END; { MaxNumber }

PROCEDURE SumNumber(VAR Sum, Num: INTEGER; VAR OverflowSum: BOOLEAN);
{ Нахождение суммы чисел }
BEGIN { SumNumber }
  IF Sum > MAXINT - Num
  THEN
    OverflowSum := TRUE
  ELSE
    Sum := Sum + Num
END; { SumNumber }

PROCEDURE ArithmeticMean(VAR Count, Sum, AvarageDiv, AvarageMod: INTEGER);
{ Нахождение среднего арифметического путем вычисления целой и дробной частей }
BEGIN { ArithmeticMean }
  AvarageDiv := Sum DIV Count;
  AvarageMod := ((Sum MOD Count) * 100) DIV Count
END; { ArithmeticMean }    

PROCEDURE WriteStats(VAR OverflowNum, OverflowSum: BOOLEAN; VAR Count, MinNumber, MaxNumber, Sum: INTEGER);
VAR
  AvarageDiv, AvarageMod: INTEGER;
{ Вывод результатов с проверкой флагов }
BEGIN { WriteOutput }
  AvarageDiv := 0;
  AvarageMod := 0;
  IF OverflowNum
  THEN
    WRITELN('Ошибка: переполнение при чтении числа / не число')
  ELSE
    BEGIN
      IF Count = 0
      THEN
        WRITELN('Числа не найдены')
      ELSE
        BEGIN
          WRITELN('Минимальное число: ', MinNumber);
          WRITELN('Максимальное число: ', MaxNumber);
          IF OverflowSum
          THEN
            WRITELN('Ошибка: при вычислении суммы произошло переполнение - среднее арифметическое невозможно вычислить')
          ELSE
            BEGIN
              WRITELN('Всего чисел: ', Count);
              ArithmeticMean(Count, Sum, AvarageDiv, AvarageMod);
              WRITELN('Среднее арифметическое: ', AvarageDiv, '.', AvarageMod)
            END  
        END
    END
END; { WriteOutput }

PROCEDURE GetStats(VAR OverflowSum, OverflowNum: BOOLEAN; VAR Number, Count, MinNumber, MaxNumber, Sum: INTEGER);
{ Обработка ввода, подсчет минимального, максимального чисел и суммы чисел } 
BEGIN { GetData }
  WHILE NOT EOLN AND (NOT(OverflowSum OR OverflowNum))
  DO
    BEGIN
      ReadNumber(INPUT, Number);
      IF Number >= 0
      THEN
        BEGIN
          Count := Count + 1;
          CheckMinNumber(Number, MinNumber);
          CheckMaxNumber(Number, MaxNumber);
          SumNumber(Sum, Number, OverflowSum)
        END
      ELSE
        OverflowNum := TRUE   
    END;
  WriteStats(OverflowNum, OverflowSum, Count, MinNumber, MaxNumber, Sum)  
END; { GetData }  

PROCEDURE RunStat;
VAR
  Number, MinNumber, MaxNumber, Count, Sum: INTEGER;
  OverflowSum, OverflowNum: BOOLEAN;   
BEGIN { RunStat }
  Number := 0;
  MaxNumber := 0;
  MinNumber := MAXINT;
  Count := 0;
  Sum := 0;
  OverflowSum := FALSE;
  OverflowNum := FALSE;
  GetStats(OverflowSum, OverflowNum, Number, Count, MinNumber, MaxNumber, Sum)  
END; { RunStat }

BEGIN { Stat }
  RunStat
END. { Stat }
