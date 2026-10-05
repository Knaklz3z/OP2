PROGRAM SortMonth(INPUT, OUTPUT);
USES
  DateIO;
VAR
  M1, M2: Month;
BEGIN { SortMonth }
  ReadMonth(INPUT, M1);
  READLN;
  ReadMonth(INPUT, M2);
  IF (M1 = NoMonth) OR (M2 = NoMonth)
  THEN
    WRITELN('¬ходные данные записаны неверно')
  ELSE
    IF M1 = M2
    THEN
      BEGIN
        WRITE('ќба мес€ца ');
        WriteMonth(OUTPUT, M1);
        WRITELN
      END
    ELSE
      BEGIN
        WriteMonth(OUTPUT, M1);
        IF M1 < M2
        THEN
          WRITE(' предшествует ')
        ELSE
          WRITE(' следует за ');
        WriteMonth(OUTPUT, M2)
      END;
  WRITELN      
END. { SortMonth }
