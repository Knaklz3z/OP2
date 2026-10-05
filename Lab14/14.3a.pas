PROGRAM RunRecursiveSort(INPUT, OUTPUT);
VAR
  F1Half, F2Half: TEXT;

PROCEDURE CopyF(VAR InFile, OutFile: TEXT);
{Копирует из InFile в OutFile}
VAR
  Ch: CHAR;
BEGIN {CopyF}
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END
END; {CopyF}

PROCEDURE Split(VAR F1, F2, F3: TEXT);
{Разбивает F1 на F2, F3}
VAR 
  Ch, Switch: CHAR;
BEGIN {Split}
  RESET(F1);
  REWRITE(F2);
  REWRITE(F3);
  {Копировать F1 попеременно в F2 и F3}
  Switch := '2';
  WHILE NOT (EOLN(F1))
  DO
    BEGIN
      READ(F1, Ch);
      IF Switch = '2'
      THEN
        BEGIN
          WRITE(F2, Ch);
          Switch := '3'
        END
      ELSE
        BEGIN
          WRITE(F3, Ch);
          Switch := '2'
        END
    END;
  WRITELN(F2);
  WRITELN(F3)
END; {Split}

BEGIN {RunRecursiveSort}
  Split(INPUT, F1Half, F2Half);
  RESET(F1Half);
  RESET(F2Half);
  CopyF(F1Half, OUTPUT);
  WRITELN;
  CopyF(F2Half, OUTPUT);
  WRITELN
END. {RunRecursiveSort}
