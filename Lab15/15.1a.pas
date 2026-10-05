PROGRAM CountingSymbolsInText(INPUT, OUTPUT);
USES
  Count3;
VAR
  Ch, X100, X10, X1: CHAR;
BEGIN { CountingSymbolsInText }
  WHILE NOT EOF
  DO
    BEGIN
      WHILE NOT EOLN
      DO
        BEGIN
          READ(Ch);
          Bump { Увеличиваем счетчик на единицу }
        END;
      READLN
    END;
  WRITELN;
  Value(X100, X10, X1); { Получаем значение счетчика }
  IF (X100 = '9') AND (X10 = '9') AND (X1 = '9')
  THEN
    WRITELN('Количество символов превышает 999')
  ELSE
    WRITELN('Количество символов ', X100, X10, X1)
END. { CountingSymbolsInText }

