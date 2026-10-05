UNIT WordUtils;

INTERFACE

USES
  Dictionary, LogicUtils;
  
PROCEDURE CountWords(VAR F: TEXT);   

IMPLEMENTATION

CONST
  UpCh = 'ABCDEFGHIJKLMNOPQRSTUVWXYZјЅ¬√ƒ≈®∆«»… ЋћЌќѕ–—“”‘’÷„ЎўЏџ№Ёёя';
  LowCh = 'abcdefghijklmnopqrstuvwxyzабвгдеЄжзийклмнопрстуфхцчшщъыьэю€';
  DashSymbol = '-';
  Empty = '';

FUNCTION ToLowerCase(Ch: CHAR): CHAR;
{ ѕревращает заглавную букву в строчную, если изначально не строчна€ }
VAR
  Position: INTEGER;
BEGIN { ToLowerCase }
  Position := POS(Ch, UpCh);
  IF Position > 0 
  THEN 
    ToLowerCase := LowCh[Position] 
  ELSE 
    ToLowerCase := Ch
END; { ToLowerCase }

FUNCTION Prepare(Str: STRING): STRING;
{ „истит от лишних '-' и готовит ResultStr дл€ дерева }
VAR
  Index: INTEGER;
  ResultStr: STRING;
  LastWasDash: BOOLEAN;
BEGIN { Prepare }
  ResultStr := Empty;
  LastWasDash := TRUE;
  FOR Index := 1 TO LENGTH(Str) 
  DO
    IF Str[Index] = DashSymbol 
    THEN 
      LastWasDash := TRUE
    ELSE
      BEGIN
        IF LastWasDash AND (ResultStr <> Empty) 
        THEN 
          ResultStr := ResultStr + DashSymbol;
        ResultStr := ResultStr + Str[Index];
        LastWasDash := FALSE
      END;
  Prepare := ResultStr        
END; { Prepare }

PROCEDURE CountWords(VAR F: TEXT);
{ „итает поток текста посимвольно, собирает слова и отправл€ет их в дерево }
VAR
  Ch: CHAR;
  Buf: STRING;
BEGIN { CountWords }
  Buf := Empty;
  WHILE NOT EOF(F)  
  DO
    BEGIN
      READ(F, Ch);
      IF IsAllowedChar(Ch) 
      THEN
        Buf := Buf + ToLowerCase(Ch)
      ELSE
        BEGIN
          IF LENGTH(Buf) > 0 
          THEN
            BEGIN
              Buf := Prepare(Buf);
              IF Buf <> Empty
              THEN 
                Insert(Buf)
            END; 
          Buf := Empty
        END
    END;
  IF LENGTH(Buf) > 0
  THEN
    BEGIN
      Buf := Prepare(Buf); 
      IF Buf <> Empty 
      THEN 
        Insert(Buf)
    END 
END; { CountWords }

BEGIN { WordUtils }
END. { WordUtils }
