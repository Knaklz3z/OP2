UNIT Queue;

INTERFACE

PROCEDURE EmptyQ; { Очищает Q }
PROCEDURE AddQ(VAR Elt: CHAR); { Добавляет элемент Elt в Q }
PROCEDURE DelQ; { Удаляет первый элемент из Q }
PROCEDURE HeadQ(VAR Elt: CHAR); { Elt := голова из строки в Q, т.е. первый элемент }

IMPLEMENTATION

VAR
  Q, TEMP: TEXT;

PROCEDURE CopyOpen(VAR F1, F2: TEXT);
{ Копирует строку из F1 в F2 без RESET или REWRITE;
таким образом F1 должен быть готов для чтения, а F2 для записи,
но прошлые строки у этих файлов могут быть не пусты }
VAR
  Ch: CHAR;
BEGIN { CopyOpen }
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      WRITE(F2, Ch)
    END
END; { CopyOpen }

PROCEDURE EmptyQ;
{Q := <, /, R>}
BEGIN { EmptyQ }
  REWRITE(Q);
  WRITELN(Q);
  RESET(Q)
END; { EmptyQ }

PROCEDURE AddQ(VAR Elt: CHAR);
{Q = <, x/, R>, где x строка И Elt = a --> Q = <, xa/, R> }
VAR
  Temp: TEXT;
BEGIN { AddQ }
  REWRITE(Temp);
  CopyOpen(Q, Temp);
  WRITELN(Temp, Elt);
  { Копируем Temp в Elt }
  RESET(Temp);
  REWRITE(Q);
  CopyOpen(Temp, Q);
  WRITELN(Q);
  RESET(Q)
END; { AddQ }

PROCEDURE DelQ;
{ (Q = <, /, R> -->)|(Q = <, ax/, R>, где a символ и x строка --> Q := <, x/, R>) }
VAR
  Ch: CHAR;
BEGIN { DelQ }
  { Удаляем первый элемент из Q };
  READ(Q, Ch);
  IF NOT EOF(Q)
  THEN { Не пустой }
    BEGIN
      REWRITE(Temp);
      CopyOpen(Q, Temp);
      WRITELN(Temp);
      { Копируем Temp в Q }
      RESET(Temp);
      REWRITE(Q);
      CopyOpen(Temp, Q);
      WRITELN(Q);
    END;
  RESET(Q)
END; { DelQ }

PROCEDURE HeadQ(VAR Elt: CHAR);
{ (Q = <, /, R> --> Elt := '#')|(Q = <, ax/, R>, где a символ и x строка --> Elt := 'a') }
BEGIN  { HeadQ }
  IF NOT EOLN(Q)
  THEN
    READ(Q, Elt)
  ELSE
    Elt := '#';
  RESET(Q)
END; { HeadQ }

BEGIN { UNIT Queue }
END. { UNIT Queue }
