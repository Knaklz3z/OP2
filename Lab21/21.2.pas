PROGRAM Encryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
  и печатает новые символы в OUTPUT}
CONST
  Len = 20;
  Let = [' ' .. 'Z'];
  CypherFile = 'CYPHER.TXT';
TYPE
  Letter = ' ' .. 'Z';
  Str = ARRAY [1 .. Len] OF Letter;
  Chiper = ARRAY [Letter] OF CHAR;
  Length = 1 .. Len;
VAR
  Msg: Str;
  Code: Chiper;
  MsgLength: Length;
  F: TEXT;

PROCEDURE Initialize(VAR Code: Chiper; VAR F: TEXT);
{ Присвоить Code шифр замены }
VAR
  Ch1, Ch2: CHAR;
BEGIN { Initialize }
  WHILE NOT EOF(F)
  DO
    BEGIN
      READ(F, Ch1);
      READ(F, Ch2);
      Code[Ch1] := Ch2;
      READLN(F)
    END
END; { Initialize }

PROCEDURE Encode(VAR S: Str; VAR MsgLength: Length);
{ Выводит символы из Code, соответствующие символам из S }
VAR
  Index: 1 .. MsgLength;
BEGIN { Encode }
  FOR Index := 1 TO MsgLength
  DO
    IF S[Index] IN Let
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END; { Encode }

BEGIN { Encryption }
  { Инициализировать Code }
  ASSIGN(F, CypherFile);
  RESET(F);
  Initialize(Code, F);
  WHILE NOT EOF
  DO
    BEGIN
      { Читать строку в Msg и распечатать ее }
      MsgLength := 1;
      WHILE NOT EOLN AND (MsgLength <= Len)
      DO
        BEGIN
          READ(Msg[MsgLength]);
          WRITE(Msg[MsgLength]);
          MsgLength := MsgLength + 1
        END;
      READLN;
      WRITELN;
      { Распечатать кодированное сообщение }
      Encode(Msg, MsgLength)
    END
END. { Encryption }

