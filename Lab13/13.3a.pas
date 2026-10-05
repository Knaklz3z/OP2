PROGRAM Split(INPUT,OUTPUT);
{Копирует INPUT в OUTPUT, сначала нечетные, а затем четные элементы}
VAR
  Ch, Next: CHAR;

BEGIN
  Next := 'O';
  WHILE NOT EOF
  DO
    BEGIN
      WHILE NOT EOLN
      DO
        {Прочитать Ch, записать в файл, выбранный через
         Next, переключить Next}
        BEGIN
          READ(INPUT, Ch);
          IF Next = 'O'
            THEN
              BEGIN
                WRITE(Next);
                Next := 'E'
              END
            ELSE
              BEGIN
                WRITE(Next);
                Next := 'O'
              END 
        END;             
      READLN
    END;
  WRITELN
END.

