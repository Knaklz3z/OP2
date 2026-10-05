UNIT GroupWordUtils;

INTERFACE

FUNCTION ExtractWord(Str: STRING): STRING;
FUNCTION ExtractCount(Str: STRING): INTEGER;
FUNCTION IntToString(Num: INTEGER): STRING;
PROCEDURE ReadLine(VAR F: TEXT; VAR Line: STRING);

IMPLEMENTATION

CONST
  Digits = '0123456789';
  Empty = '';
  SpaceSymbol = ' ';
  Base = 10;
  Overflow = -1;

FUNCTION ExtractWord(Str: STRING): STRING;
{ Извлекает слово из строки до пробела }
VAR
  SpacePos, CharIndex: INTEGER;
  ResultWord: STRING;
BEGIN { ExtractWord }
  SpacePos := POS(SpaceSymbol, Str);
  IF SpacePos = 0 
  THEN
    ExtractWord := Str
  ELSE
    BEGIN
      ResultWord := Empty;
      FOR CharIndex := 1 TO SpacePos - 1 
      DO
        ResultWord := ResultWord + Str[CharIndex];
      ExtractWord := ResultWord
    END
END; { ExtractWord }

FUNCTION ExtractCount(Str: STRING): INTEGER;
{ Извлекает число после пробела }
VAR
  SpacePos, CharIndex, DigitPos: INTEGER;
  ResultNum, CurrentDigit: INTEGER;
  IsOverflow: BOOLEAN;
BEGIN { ExtractCount }
  SpacePos := POS(SpaceSymbol, Str);
  ResultNum := 0;
  IsOverflow := FALSE;
  IF SpacePos > 0 
  THEN
    BEGIN
      CharIndex := SpacePos + 1;
      WHILE (CharIndex <= LENGTH(Str)) AND NOT IsOverflow 
      DO
        BEGIN
          DigitPos := POS(Str[CharIndex], Digits);
          IF DigitPos > 0 
          THEN
            BEGIN
              CurrentDigit := DigitPos - 1;
              IF (ResultNum > (MAXINT DIV Base)) OR ((ResultNum = (MAXINT DIV Base)) AND (CurrentDigit > (MAXINT MOD Base)))
              THEN
                IsOverflow := TRUE
              ELSE
                ResultNum := ResultNum * Base + CurrentDigit;
            END;
          CharIndex := CharIndex + 1  
        END
    END;  
  IF IsOverflow 
  THEN
    ExtractCount := Overflow
  ELSE
    ExtractCount := ResultNum
END; { ExtractCount }

FUNCTION IntToString(Num: INTEGER): STRING;
{ Конвертирует число в строку }
VAR
  ResultText: STRING;
  WorkNum: INTEGER;
BEGIN { IntToString }
  IF Num = 0 
  THEN
    IntToString := Digits[1]
  ELSE
    BEGIN
      ResultText := Empty;
      WorkNum := Num;
      WHILE WorkNum > 0 
      DO
        BEGIN
          ResultText := Digits[(WorkNum MOD Base) + 1] + ResultText;
          WorkNum := WorkNum DIV Base
        END;
      IntToString := ResultText
    END
END; { IntToString }

PROCEDURE ReadLine(VAR F: TEXT; VAR Line: STRING);
{ Читает следующую строку или возвращает пустую }
BEGIN { ReadLine }
  IF NOT EOF(F) 
  THEN
    READLN(F, Line)
  ELSE
    Line := Empty
END; { ReadLine }

BEGIN { GroupWordUtils }
END. { GroupWordUtils }
