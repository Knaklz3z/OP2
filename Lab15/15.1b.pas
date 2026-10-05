PROGRAM CountingReversInText(INPUT, OUTPUT);
USES
  Count3;

PROCEDURE SafeRead(VAR Ch: CHAR);
BEGIN
  IF NOT EOLN
  THEN
    READ(Ch)
END;

PROCEDURE FindRevers(VAR N1, N2, N3: CHAR);
BEGIN
  IF ((N2 > N1) AND (N2 > N3)) OR ((N2 < N1) AND (N2 < N3))
  THEN
    Bump
END;

VAR
  Ch1, Ch2, Ch3: CHAR;
  X100, X10, X1: CHAR;
BEGIN { CountingReversInText }
  SafeRead(Ch1);
  SafeRead(Ch2);
  SafeRead(Ch3);
  WHILE NOT EOLN
  DO
    BEGIN { Если найден реверс, то увеличиваем счетчик на 1 }
      FindRevers(Ch1, Ch2, Ch3);
      { Сдвиг окна }
      Ch1 := Ch2;
      Ch2 := Ch3;
      READ(Ch3)      
    END;
  FindRevers(Ch1, Ch2, Ch3);  
  WRITELN;  
  Value(X100, X10, X1);
  IF (X100 = '9') AND (X10 = '9') AND (X1 = '9')
  THEN
    WRITELN('Количество реверсов превышает 999')
  ELSE
    WRITELN('Количество реверсов ', X100, X10, X1)  
END. { CountingReversInText }
