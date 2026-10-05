PROGRAM TestRemove(INPUT, OUTPUT);
{ Читает строку из входа, пропускает ее через RemoveExtraBlanks }
USES 
  Queue;
VAR
  Ch: CHAR;
  
PROCEDURE RemoveExtraBlanks;
{ Удаляет лишние пробелы между словами на одной строке }
VAR
  Ch, Blank, LineEnd, FirstWord: CHAR;
BEGIN { RemoveExtraBlanks }
  Blank := ' ';
  LineEnd := '$';
  FirstWord := '1';
  AddQ(LineEnd); { Помечаем конец текста в очереди }
  HeadQ(Ch);
  { Удаляем пробелы }
  WHILE Ch <> LineEnd
  DO
    BEGIN
      { Читаем слово }
      WHILE (Ch <> Blank) AND (Ch <> LineEnd)
      DO
        BEGIN
          AddQ(Ch);
          DelQ;
          HeadQ(Ch);
          FirstWord := '0'
        END;
      { Удаляем пробелы }
      WHILE Ch = Blank
      DO
        BEGIN
          DelQ;
          HeadQ(Ch)
        END;
      { Вставляем пробел между словами }
      IF (Ch <> LineEnd) AND (FirstWord = '0')
      THEN
        AddQ(Blank)
    END;
  DelQ { Удаяем LineEnd из очереди }  
END; { RemoveExtraBlanks }

BEGIN { TestRemove }
  EmptyQ;
  WRITE('Вход: ');
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      WRITE(Ch);
      AddQ(Ch)
    END;
  WRITELN;
  RemoveExtraBlanks;
  WRITE('Выход: ');
  HeadQ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      DelQ;
      HeadQ(Ch)
    END;
  WRITELN
END. { TestRemove }

