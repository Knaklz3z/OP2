PROGRAM RunReverse(INPUT, OUTPUT);

PROCEDURE Reverse(VAR InFile: TEXT);
VAR
  Ch: CHAR;
BEGIN {Reverse}
  IF NOT EOLN(InFile)
  THEN
    BEGIN
      READ(InFile, Ch);
      Reverse(InFile);
      WRITE(Ch)
    END
END; {Reverse}

BEGIN {RunReverse}
  Reverse(INPUT);
  WRITELN
END. {RunReverse}
