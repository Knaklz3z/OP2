PROGRAM Encryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
  и печатает новые символы в OUTPUT}
CONST
  Len = 20;
  Let = [' ', 'A' .. 'Z'];
TYPE
  Letter = ' ' .. 'Z';
  Str = ARRAY [1 .. Len] OF Letter;
  Chiper = ARRAY [Letter] OF CHAR;
  Length = 1 .. Len;
VAR
  Msg: Str;
  Code: Chiper;
  MsgLength: Length;

PROCEDURE Initialize(VAR Code: Chiper);
{ Присвоить Code шифр замены }
BEGIN { Initialize }
  Code[' '] := '@';
  Code['A'] := 'Z';
  Code['B'] := 'Y';
  Code['C'] := 'X';
  Code['D'] := '#';
  Code['E'] := 'V';
  Code['F'] := 'U';
  Code['G'] := 'T';
  Code['H'] := 'S';
  Code['I'] := 'I';
  Code['J'] := 'Q';
  Code['K'] := 'P';
  Code['L'] := '!';
  Code['M'] := 'N';
  Code['N'] := 'M';
  Code['O'] := '2';
  Code['P'] := 'K';
  Code['Q'] := '$';
  Code['R'] := 'D';
  Code['S'] := 'H';
  Code['T'] := '*';
  Code['U'] := 'F';
  Code['V'] := 'E';
  Code['W'] := 'T';
  Code['X'] := 'C';
  Code['Y'] := 'B';
  Code['Z'] := 'A';
END; { Initialize }

PROCEDURE Encode(VAR S: Str; VAR MsgLength: Length);
{ Выводит символы из Code, соответствующие символам из S }
VAR
  Index: 1 .. Len;
BEGIN { Encode }
  FOR Index := 1 TO Len
  DO
    IF S[Index] IN Let
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END; { Encode }

BEGIN {Encryption}
  { Инициализировать Code }
  Initialize(Code);
  WHILE NOT EOLN
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

